Return-Path: <linux-kernel+bounces-364231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA499CE43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769B81F23CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF451AB6D4;
	Mon, 14 Oct 2024 14:41:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58831AAE37
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916911; cv=none; b=hILveIGynaR55axjvBFC8eY7RbUniOi8Cleqno3ECyrKyRZqo5aOOaHsHXGrKWPnAeSG3FcbYCnWwHnOKrun04Qjt/KZuIxuLitxuSfttEmTGeFbqC2Bm0NUnaaIo9Bxm3aUCywpJ3CMwP4f9svtFU/z7PyUbjVXDRqnZdEM1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916911; c=relaxed/simple;
	bh=hhtfj4TP8D3Fn35HAWNyNPAJgI+6Yz55diScInh50tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbB3qWulwIRz84v4s56z2QkKwlZpgS640SPecq8KmxFrjKqZnWew9AOcCN5VvCI9fvklVyyZ0BgK6bNVvMuVIphI5/t9PkYawVCSGDff3OHiT7qafGgAqBMP206HXVd7U5YMkq1i76iRr16Wjw4xkcMuHwbbnJZk7dbI6o0Rtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05FF31007;
	Mon, 14 Oct 2024 07:42:19 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFB763F51B;
	Mon, 14 Oct 2024 07:41:48 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:41:46 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shan.gavin@gmail.com
Subject: Re: [PATCH] firmware: arm_ffa: Fix warning caused by export_uuid()
Message-ID: <Zw0tqoVCU0xPS-X1@bogus>
References: <20241014004724.991353-1-gshan@redhat.com>
 <ZwztgGdmNMrsqO7c@bogus>
 <2ea2b741-3abd-4fe1-b622-b6a4a3c2a92b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ea2b741-3abd-4fe1-b622-b6a4a3c2a92b@redhat.com>

On Mon, Oct 14, 2024 at 08:25:54PM +1000, Gavin Shan wrote:
> On 10/14/24 8:08 PM, Sudeep Holla wrote:
> > On Mon, Oct 14, 2024 at 10:47:24AM +1000, Gavin Shan wrote:
> > > Run into build warning caused by export_uuid() where the UUID's
> > > length exceeds that of ffa_value_t::a2, as the following warning
> > > messages indicate.
> > > 
> > > In function ‘fortify_memcpy_chk’,
> > > inlined from ‘export_uuid’ at ./include/linux/uuid.h:88:2,
> > > inlined from ‘ffa_msg_send_direct_req2’ at drivers/firmware/arm_ffa/driver.c:488:2:
> > > ./include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ \
> > > declared with attribute warning: detected write beyond size of field (1st parameter); \
> > > maybe use struct_group()? [-Werror=attribute-warning]
> > > 571 |                         __write_overflow_field(p_size_field, size);
> > >      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Fix it by not passing a plain buffer to memcpy() to avoid the overflow
> > > and underflow warning, similar to what have been done to copy over the
> > > struct ffa_send_direct_data2.
> > > 
> > 
> > Are you observing this just on the upstream or -next as well? There is a
> > fix in the -next which I haven't sent to soc team yet, will do so soon.
> > 
> 
> I just tried the upstream when the patch was posted. I just have a try with -next
> and similar error exists.
> 
> [root@nvidia-grace-hopper-01 linux-next]# git remote -v
> origin	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (fetch)
> origin	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (push)
> [root@nvidia-grace-hopper-01 linux-next]# make W=1 drivers/firmware/arm_ffa/driver.o
>    :
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘ffa_msg_send_direct_req2’ at drivers/firmware/arm_ffa/driver.c:504:3:
> ./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: \
> detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   580 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> 
> Part of the changes included this patch is still needed by -next. Could you please
> squeeze the changes to that one to be pulled?

Sure I can do that. Can you share the build command(specifically if any
extra warning are enabled) and the toolchain used ? I am unable to reproduce
it with clang 20.0.0, not sure if it my toolchain or build command/flags that
differs here.

--
Regards,
Sudeep

