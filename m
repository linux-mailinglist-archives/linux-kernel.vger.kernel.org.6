Return-Path: <linux-kernel+bounces-366137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC199F147
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5102878CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD16E1B394B;
	Tue, 15 Oct 2024 15:32:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498B1B3930
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006373; cv=none; b=OPayT+O9o9QvtPr9zbpK23lHOTpOuQBVnn+Rw4YFyUeblPDAUNgC+MjevgAs72eGcfRgDdhA41OPZLKp60zU2bWDVm9oET6oFHSiUjnNFOhUm3fIF0UisGNrNNSUNFT9OXg9I/xl8UdVwZb0cYK9jtTK19OcVqCt19XCv0PuNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006373; c=relaxed/simple;
	bh=ToZBso9cEIth5IeZrB9ajI+gqVFoi7413fAiRY85tLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6HoJBq9W5hWu5j1WLgkoLa06SZi5OnVCQsxDeTpH6+buwrHJ0Pq/WJQuDPGNIRa2aYPj65Q0Q7JUWRgcN/PqsJ+WDveJ14s+Va9uJoVxUANNQrhnBERv35vjC+lQQXPK2AKL+7E3+sl2Pni2tLmDX8bzb4my+KikzAiPp/4q6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA266FEC;
	Tue, 15 Oct 2024 08:33:20 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 819553F528;
	Tue, 15 Oct 2024 08:32:50 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:32:48 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shan.gavin@gmail.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_ffa: Fix warning caused by export_uuid()
Message-ID: <Zw6LILtuJdIT5-Eu@bogus>
References: <20241014004724.991353-1-gshan@redhat.com>
 <ZwztgGdmNMrsqO7c@bogus>
 <2ea2b741-3abd-4fe1-b622-b6a4a3c2a92b@redhat.com>
 <Zw0tqoVCU0xPS-X1@bogus>
 <024a190c-06ce-4429-824e-08075aa0ffe3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <024a190c-06ce-4429-824e-08075aa0ffe3@redhat.com>

On Tue, Oct 15, 2024 at 09:43:32AM +1000, Gavin Shan wrote:
> On 10/15/24 12:41 AM, Sudeep Holla wrote:
> > On Mon, Oct 14, 2024 at 08:25:54PM +1000, Gavin Shan wrote:
> > > On 10/14/24 8:08 PM, Sudeep Holla wrote:
> > > > On Mon, Oct 14, 2024 at 10:47:24AM +1000, Gavin Shan wrote:
> > > > > Run into build warning caused by export_uuid() where the UUID's
> > > > > length exceeds that of ffa_value_t::a2, as the following warning
> > > > > messages indicate.
> > > > > 
> > > > > In function ‘fortify_memcpy_chk’,
> > > > > inlined from ‘export_uuid’ at ./include/linux/uuid.h:88:2,
> > > > > inlined from ‘ffa_msg_send_direct_req2’ at drivers/firmware/arm_ffa/driver.c:488:2:
> > > > > ./include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ \
> > > > > declared with attribute warning: detected write beyond size of field (1st parameter); \
> > > > > maybe use struct_group()? [-Werror=attribute-warning]
> > > > > 571 |                         __write_overflow_field(p_size_field, size);
> > > > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > 
> > > > > Fix it by not passing a plain buffer to memcpy() to avoid the overflow
> > > > > and underflow warning, similar to what have been done to copy over the
> > > > > struct ffa_send_direct_data2.
> > > > > 
> > > > 
> > > > Are you observing this just on the upstream or -next as well? There is a
> > > > fix in the -next which I haven't sent to soc team yet, will do so soon.
> > > > 
> > > 
> > > I just tried the upstream when the patch was posted. I just have a try with -next
> > > and similar error exists.
> > > 
> > > [root@nvidia-grace-hopper-01 linux-next]# git remote -v
> > > origin	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (fetch)
> > > origin	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (push)
> > > [root@nvidia-grace-hopper-01 linux-next]# make W=1 drivers/firmware/arm_ffa/driver.o
> > >     :
> > > In function ‘fortify_memcpy_chk’,
> > >      inlined from ‘ffa_msg_send_direct_req2’ at drivers/firmware/arm_ffa/driver.c:504:3:
> > > ./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: \
> > > detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
> > >    580 |                         __read_overflow2_field(q_size_field, size);
> > >        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > > 
> > > 
> > > Part of the changes included this patch is still needed by -next. Could you please
> > > squeeze the changes to that one to be pulled?
> > 
> > Sure I can do that. Can you share the build command(specifically if any
> > extra warning are enabled) and the toolchain used ? I am unable to reproduce
> > it with clang 20.0.0, not sure if it my toolchain or build command/flags that
> > differs here.
> > 
> 
> Thanks, Sudeep. I think what matters is 'W=1', which is translated to '-DKBUILD_EXTRA_WARN1'.
> With KBUILD_EXTRA_WARN1 declared in linux-next, the warning is raised by __read_overflow2_field().
> 

Sorry my bad, I got confused. I was not able to reproduce the write overflow
warning even if I revert the patch in the -next. I was seeing this warning,
just got confused. Thanks for the details. I have pushed this patch partially
as discussed since other warning is already addressed.

Regards,
Sudeep

-->8
From b0798838418abe996d9b618d341d865462264cbe Mon Sep 17 00:00:00 2001
From: Gavin Shan <gshan@redhat.com>
Date: Mon, 14 Oct 2024 10:47:24 +1000
Subject: [PATCH] firmware: arm_ffa: Avoid string-fortify warning caused by
 memcpy()

Copying from a 144 byte structure arm_smccc_1_2_regs at an offset of 32
into an 112 byte struct ffa_send_direct_data2 causes a compile-time warning:

 | In file included from drivers/firmware/arm_ffa/driver.c:25:
 | In function 'fortify_memcpy_chk',
 |    inlined from 'ffa_msg_send_direct_req2' at drivers/firmware/arm_ffa/driver.c:504:3:
 | include/linux/fortify-string.h:580:4: warning: call to '__read_overflow2_field'
 | 	declared with 'warning' attribute: detected read beyond size of field
 | 	(2nd parameter); maybe use struct_group()? [-Wattribute-warning]
 |                         __read_overflow2_field(q_size_field, size);

Fix it by not passing a plain buffer to memcpy() to avoid the overflow
warning.

Fixes: aaef3bc98129 ("firmware: arm_ffa: Add support for FFA_MSG_SEND_DIRECT_{REQ,RESP}2")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20241014004724.991353-1-gshan@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 8dd81db9b071..b14cbdae94e8 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -501,7 +501,7 @@ static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
 		return ffa_to_linux_errno((int)ret.a2);

 	if (ret.a0 == FFA_MSG_SEND_DIRECT_RESP2) {
-		memcpy(data, &ret.a4, sizeof(*data));
+		memcpy(data, (void *)&ret + offsetof(ffa_value_t, a4), sizeof(*data));
 		return 0;
 	}

--
2.34.1


