Return-Path: <linux-kernel+bounces-207963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE1901E91
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377281F24A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37FF74E0A;
	Mon, 10 Jun 2024 09:47:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F0CA62
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012865; cv=none; b=Pf1asYI0ByAR5CTwBfAO9rIHHxRwH8o/ghD5byN0xSblMVuW5KAHHfLLVToMAU4ioehCZU4B+EymHKusdr+j0ioZIxMEnldteVkMKIpYlPqOr9AA+AvpHA7TE2cTZfF4LMAaTj6EDvGJbLoOWAkTt6fGlhPjvhhY7Mjgt1tFlFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012865; c=relaxed/simple;
	bh=VQ/3JhnLna7rWk78B1WLCHGyauw1n1qafP09tVEkGcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbJK7DHEJ6j9d80ddklfshdGyZQBPsXA/nUWYAPfu9bdmp6kn8MSllplLMZyjt2UelUXFhJAGAPqMfCQAoCdYxMWlmLkQjpzwn4lk4TJz1FW03/4xwQ3+xllGhJHOCpHYh6NpTPC0z5N9txMS2Ddj6NqcLho4jB+uJfY5ZoBFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCB0212FC;
	Mon, 10 Jun 2024 02:48:06 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 180E93F73B;
	Mon, 10 Jun 2024 02:47:40 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: coresight@lists.linaro.org,
	James Clark <james.clark@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	laurent.pinchart@ideasonboard.com,
	linux-kernel@vger.kernel.org,
	Mike Leach <mike.leach@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: Fix ref leak when of_coresight_parse_endpoint() fails
Date: Mon, 10 Jun 2024 10:47:31 +0100
Message-Id: <171801275290.708723.11055477791978848818.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529133626.90080-1-james.clark@arm.com>
References: <20240529133626.90080-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 29 May 2024 14:36:26 +0100, James Clark wrote:
> of_graph_get_next_endpoint() releases the reference to the previous
> endpoint on each iteration, but when parsing fails the loop exits
> early meaning the last reference is never dropped.
> 
> Fix it by dropping the refcount in the exit condition.
> 
> 
> [...]

Applied, thanks!

[1/1] coresight: Fix ref leak when of_coresight_parse_endpoint() fails
      https://git.kernel.org/coresight/c/7fcb9cb2fe47294e16067c3cfd25332c8662a115

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

