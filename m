Return-Path: <linux-kernel+bounces-211683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA6905551
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1B91F21919
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E2E17E463;
	Wed, 12 Jun 2024 14:38:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7639C17DE34
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203115; cv=none; b=U0pUVwAlsPDULTI0t3SEWraRhDeluR+jMOgO2aXseNhFqt95IlwedjyhhiZodn94c5BYj4eXwX5nhN4rdA0xspETv2vARiPpGrkZE56M8+zY9xUG0ONv1y78CpsKzUK1u4gMpbA+HmeDFqy3J6+RAEPkPuqlrZ9f5XSUvF6HjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203115; c=relaxed/simple;
	bh=bCrxt2my4m4yrSCXVplFBO+/qFMZHZ9RKEK/ZDlmOM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYIgdwsPZAgfWHQ7hDyK1HGctsRMFUV6/ImQdsuq3SawW/PH/+caA8mJ/jN9aUFOB0E3Xxf3hIUnwoszsW6DfqzRBUbDG50pCnJolODb16Yjlf9E6DU1Av+AxqQ7cBf10hlijgZ19zRFkJT/nE8iEHzhFp6hEGWQj6U6ujj64YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42D121063;
	Wed, 12 Jun 2024 07:38:56 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC7633F64C;
	Wed, 12 Jun 2024 07:38:28 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:38:26 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	Sudeep Holla <sudeep.holla@arm.com>, maz@kernel.org,
	oliver.upton@linux.dev, qperret@google.com, qwandor@google.com,
	suzuki.poulose@arm.com, tabba@google.com, will@kernel.org,
	yuzenghui@huawei.com, lpieralisi@kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v2 3/4] KVM: arm64: Fix the identification range for the
 FF-A smcs
Message-ID: <Zmmy4pmgLFZNhXqp@bogus>
References: <20240515172258.1680881-1-sebastianene@google.com>
 <20240515172258.1680881-4-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515172258.1680881-4-sebastianene@google.com>

On Wed, May 15, 2024 at 05:22:57PM +0000, Sebastian Ene wrote:
> The FF-A spec 1.2 reserves the following ranges for identifying FF-A
> calls:
> 0x84000060-0x840000FF: FF-A 32-bit calls
> 0xC4000060-0xC40000FF: FF-A 64-bit calls.
>
> Use the range identification according to the spec and allow calls that
> are currently out of the range(eg. FFA_MSG_SEND_DIRECT_REQ2) to be
> identified correctly.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Not sure if this needs to be fixes though. With addition of notifications
in the FF-A driver(since v6.7), host can send FF-A messages beyond 0x7F.
But since the pKVM FF-A proxy support is not yet updated to v1.1, so I
don't think it needs to be tagged as fix. Just thought I will mention it
here anyways.

--
Regards,
Sudeep

