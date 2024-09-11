Return-Path: <linux-kernel+bounces-325275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF397574C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3601F25377
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFE31ACDE2;
	Wed, 11 Sep 2024 15:38:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE59219C56B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069083; cv=none; b=WsGzPHN99PVWp9h1dG1Ad+qUE9plEHkdIOZVWH79Xn+iatFItv7vhl2eMz6tsnK02NeO8t4OHAPw+P+kn0Eg+yUaygcXHrZgpYVIcAMzpT0SX44H69d7cmMHK2zR/Ij/xZRdbetwcadaah/0h0OTQK7zWJ7/qoGKhBakwLDaYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069083; c=relaxed/simple;
	bh=+w1sLuOsu9vv5wGoBJd6coDHXENLHv6Ii2udlp9bW6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/7xzLgsjoz+JWWczeG1jXRpW2wTFzSyOUjVbTI/l/kxgNOdcbKDZHtlTBfTJQhZijf2NKLyZ0hmROJOi+Xv6MJygO3kOoMZcoOvp1QtTyNy6iC8o61/Zt8dy4o3pm2aNQyropBaI1rc7VA/X06/zynQJmpYW86fd6HDELVt5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59B021007;
	Wed, 11 Sep 2024 08:38:29 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7663F73B;
	Wed, 11 Sep 2024 08:37:59 -0700 (PDT)
Date: Wed, 11 Sep 2024 16:37:56 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
	"Cristian Marussi" <cristian.marussi@arm.com>,
	"Jens Wiklander" <jens.wiklander@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: avoid string-fortify warningn in
 export_uuid()
Message-ID: <ZuG5VKBcbHN2kiut@bogus>
References: <20240909110938.247976-1-arnd@kernel.org>
 <ZuGl3v0y4SYR1np7@bogus>
 <0ae7475f-f53a-45e3-a484-667820042724@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae7475f-f53a-45e3-a484-667820042724@app.fastmail.com>

On Wed, Sep 11, 2024 at 02:44:25PM +0000, Arnd Bergmann wrote:
> On Wed, Sep 11, 2024, at 14:14, Sudeep Holla wrote:
> > On Mon, Sep 09, 2024 at 11:09:24AM +0000, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> Copying to a 16 byte structure into an 8-byte struct member
> >> causes a compile-time warning:
> >> 
> >> In file included from drivers/firmware/arm_ffa/driver.c:25:
> >> In function 'fortify_memcpy_chk',
> >>     inlined from 'export_uuid' at include/linux/uuid.h:88:2,
> >>     inlined from 'ffa_msg_send_direct_req2' at drivers/firmware/arm_ffa/driver.c:488:2:
> >> include/linux/fortify-string.h:571:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> >>   571 |                         __write_overflow_field(p_size_field, size);
> >>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >> Use a union for the conversion instead and make sure the byte order
> >> is fixed in the process.
> >> 
> >
> > Thanks for spotting and fixing the issue. I tested enabling
> > CONFIG_FORTIFY_SOURCE but couldn't hit this with gcc 13 and clang 20
> 
> Unfortunately I also don't have a reproducer at the moment,
> but I know it was from a randconfig build with gcc-14.2. I tried
> another few hundred randconfigs now with my patch reverted but it
> didn't come back. I assume it only shows up in rare combinations
> of some options,
>

Oh OK.

> Do you have any additional information on the endianess question?
> Is this arm_ffa firmware code supposed to work with big-endian
> kernels?
>

I am trying to check if that is a requirement. Also the specification
doesn't have any specific mention about it. Since it executes on the same
AP cores as Linux in different EL, I assume the entire stack must be
running same endian-ness. I will check internally. Unlike SCMI, I haven't
tested FF-A with big-endian kernel so far.

> > Also do you want this sent as fix on top of my FF-A PR now or after -rc1 ?
> 
> Earlier would be better I think. I usually have one set of
> bugfixes before rc1 even if it doesn't make it into the
> first set of branches.
>

I will try to send earlier unless this endian-ness triggers more questions.
I will update here anyways.

-- 
Regards,
Sudeep

