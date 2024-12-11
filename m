Return-Path: <linux-kernel+bounces-441137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB49ECA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F67160EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE931EC4D5;
	Wed, 11 Dec 2024 10:20:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ADF236FA9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912414; cv=none; b=gNa9Z+3w7wNNHh9e8eGvtkmputmt/N1tIaVXH36BliloEQSrbF6nWcCgxkSiGTZj0bquCIFSwTcLHKaLJnXqJcBsHTz9XC/Q8b7MusX68Uoc8IXa/BmsjGI/pNW0yaNcm8CkdUk3ikd2BmfPonQPyQ4x59Awof1ghhgUCLPgT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912414; c=relaxed/simple;
	bh=6t2l0dRFIHCqNl0Go9xbo3EmfTHVY4EWcP7WrbzRjRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsz48pZYxumDWRlIp3u18qBgzrkIa/Y0S54L/8pGpPpnVA/FipYLq5vJGfbVYWWFMSkyYf4zd64RZXSm+tNKYc/ahYeChnp8oANLRSocMSrw9VIj0FZbC8icB7tOOvUffK5D4VGkCoDyliJeo34puwSOqNU/sbGi2eiUJVKQDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07E471063;
	Wed, 11 Dec 2024 02:20:39 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA4C23F720;
	Wed, 11 Dec 2024 02:20:09 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: James Clark <james.clark@linaro.org>,
	mike.leach@linaro.org,
	coresight@lists.linaro.org,
	yeoreum.yun@arm.com
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: Drop atomics in connection refcounts
Date: Wed, 11 Dec 2024 10:20:02 +0000
Message-Id: <173391229097.561442.2664501227957186728.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128121414.2425119-1-james.clark@linaro.org>
References: <20241128121414.2425119-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Nov 2024 12:14:14 +0000, James Clark wrote:
> These belong to the device being enabled or disabled and are only ever
> used inside the device's spinlock. Remove the atomics to not imply that
> there are any other concurrent accesses.
> 
> If atomics were necessary I don't think they would have been enough
> anyway. There would be nothing to prevent an enable or disable running
> concurrently if not for the spinlock.
> 
> [...]

Applied, thanks!

[1/1] coresight: Drop atomics in connection refcounts
      https://git.kernel.org/coresight/c/5aec7c065fba0c56d6c1ea5d629395210f174be8

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

