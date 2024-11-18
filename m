Return-Path: <linux-kernel+bounces-413508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245829D1A04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F50B22933
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79861E5730;
	Mon, 18 Nov 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVpuVR4u"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6571E1312
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963755; cv=none; b=Jf6rPC1bnhuQrmN9GNETynvY/k7jPmEpzWL+ZqzHnum/iPtDi3ix8FVt9gbZ/9R2CLCQoW8ZDpSjSB3P6AsPH6YSAaoDc+SwuR6pxShZZuOmilrEDcPoJmdDO4JNBwAny9GnSMErcigq1yv7Zl4q94zpKbAqPgT2z+ud5XGTPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963755; c=relaxed/simple;
	bh=c72u0ab0ci9GlKxC8UFjHNVvTLhwu4dlheCuswzDnnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD2/yuA4YfgwF/ltv1g6cmb/2OE1/oJV4c4zSQvaWMPMLN1eA5RGvX7RPhw6YuCN8GBZWiPs3ugriWmvI4ed+N8FH+hlR2qekYJNfxEZE1nCpeuFDJiIYtRLeYgxnwg+mEg6L9vYc22exMepaGQDWkrx80/PaSo5PQVXC9tOJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVpuVR4u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c714cd9c8so20859155ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731963753; x=1732568553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaK4NSPIzx6I9+BFvsVipb38aVZD7cm3V9kV+6lyahY=;
        b=JVpuVR4u1V8i/jR+64vwxBu4KAbdJdsDDtI9qo7g7A57pRWa6VuuMvSbIZORyeYCyH
         7524vQMOmv1mqwDldHMaWavljBCyjlsjhsfPNu8Qx8z9/OUUdRqNBxMjpD+AP7n4kE28
         TTt/mBkC8QhIG6ZmrZI5LddTJ1PQrDhsZzoUnXaRQ6KGiDw2FD6DbpUDRe8o5D8mgV5E
         WlAISFxKHqbkyzkr5maKBWKH8PboJ+YMZ++OtxySPYoop42WnMzqMaqyy2y5RfIYYAmX
         p28P9zjoNrG4tcB59NlAMrkpBbAMpkghmKFJ5lqVhcR6o3Vl6KplzvSjYx/5q/IUvUjS
         eR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731963753; x=1732568553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaK4NSPIzx6I9+BFvsVipb38aVZD7cm3V9kV+6lyahY=;
        b=aiACMExkK+kB4gSwT+o0Cz/N1/nHZjB6Ax/MUQoQq3A5DVUriPH8lssUwOb1azXzwz
         Vtp0w9SQrqINO5QcxFI8B156S2IO0ZdPj5FPdkEM3pDtu2McbUPO2QrkTbgJlELAfEi6
         7saNJ4rwQ0SCCSrUy2bQzlL3z2tueJ3KfRcrW+l839hZelOdjm5fDOtnlHH/F3WL7fTF
         YeGE1JgmVRMhqpPQo4Dbc0UA7i0d5sJdyCQ+4CjXXKxvGi6uZ7Q0U56Fnehc7dblmPat
         LY1h6AVMahpi0b2rIG+StGStSahWSpmFpxrazqTfZoHHym7ZchCZimpHsTk69MiRxVsA
         OYDw==
X-Forwarded-Encrypted: i=1; AJvYcCU8NUMh+EjQqtpKzbGe8TkUvv+LHYOfOYCDlLZ/E/YBeDCpN+JKueB8xWfzdg3k2TruMg9aMjGnBhp/Oi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0UXCZ43Kj7KdGVoHMF/+2NwaCgWE1O6Ro21QDb4KFHQkl8ho
	LyCoCnF3AZVMh6ZX8HV0tOKeMtaF/5+cxqqTiMB2Z2L6Mtz+sXUQ
X-Google-Smtp-Source: AGHT+IE7LMQJWC92f4htEIVWTjfQygINS/TGLaU1d0rTaMPRUlUeWIV+CG+DKP0VLcwenDn80VTMMA==
X-Received: by 2002:a17:902:cecc:b0:20f:c292:6662 with SMTP id d9443c01a7336-211d0ed22aamr180165645ad.51.1731963752932;
        Mon, 18 Nov 2024 13:02:32 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f4535csm61022115ad.178.2024.11.18.13.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 13:02:32 -0800 (PST)
Date: Mon, 18 Nov 2024 13:02:29 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, ashish.kalra@amd.com,
	tzimmermann@suse.de, bhelgaas@google.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Message-ID: <ZzurZX_wm08tyD79@desktop>
References: <Zzcp75p3KTFRfW5O@gmail.com>
 <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>
 <ZzemwFBfEIgFhrD-@desktop>
 <CAMj1kXHPut9qv7dT9Xv=xhbS6AP3HRP0dikk-G690AKfLuNLGA@mail.gmail.com>
 <c7a9748e-aead-b252-dd29-48dd0d2da9be@amd.com>
 <30558bc8-c22c-1ce1-f59a-66c057fdd06f@amd.com>
 <ZzuYy9KHwlLa9HLY@desktop>
 <182fc3f3-2b9d-5c86-b058-5d1208305cbb@amd.com>
 <ZzuiDPWzloIAJYya@desktop>
 <6539edcb-e865-e33e-5344-77fac413e49d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6539edcb-e865-e33e-5344-77fac413e49d@amd.com>

On Mon, Nov 18, 2024 at 02:37:58PM -0600, Tom Lendacky wrote:
> On 11/18/24 14:22, Ragavendra B.N. wrote:
> > On Mon, Nov 18, 2024 at 01:50:55PM -0600, Tom Lendacky wrote:
> >> On 11/18/24 13:43, Ragavendra B.N. wrote:
> >>> On Mon, Nov 18, 2024 at 08:53:04AM -0600, Tom Lendacky wrote:
> >>>> On 11/18/24 08:44, Tom Lendacky wrote:
> >>>>> On 11/15/24 16:55, Ard Biesheuvel wrote:
> >>>>>> On Fri, 15 Nov 2024 at 20:53, Ragavendra B.N. <ragavendra.bn@gmail.com> wrote:
> >>>>>>>
> >>>>>>> On Fri, Nov 15, 2024 at 12:02:27PM +0100, Ard Biesheuvel wrote:
> >>>>>>>> On Fri, 15 Nov 2024 at 12:01, Ingo Molnar <mingo@kernel.org> wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> * Ragavendra <ragavendra.bn@gmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>>> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
> >>>>>>>>>> it was not initialized.
> >>>>>>>>>>
> >>>>>>>>>> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> >>>>>>>>>
> >>>>>>>>> This 'Fixes' tag looks bogus.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> So does the patch itself - 'struct es_em_ctxt ctxt' is not a pointer.
> >>>>>>> Thank you very much for your response. I am relatively new to kernel development.
> >>>>>>>
> >>>>>>> I know we can use kmalloc for memory allocation. Please advice.
> >>>>>>>
> >>>>>>> struct es_em_ctxt ctxt = kmalloc(sizeof(struct es_em_ctxt), GFP_KERNEL);
> >>>>>>>
> >>>>>>> I am thinking to update like above, but like you mentioned, ctxt is not a pointer. I can update this to be a pointer if needed.
> >>>>>>>
> >>>>>>
> >>>>>> The code is fine as is. Let's end this thread here, shall we?
> >>>>>
> >>>>> I was assuming he got some kind of warning from some compiler options or
> >>>>> a static checker. Is that the case Ragavendra?
> >>>>>
> >>>>> When I look at the code, it is possible for ctxt->fi.error_code to be
> >>>>> left uninitialized. The simple fix is to just initialize ctxt as:
> >>>>>
> >>>>> 	struct es_em_ctxt ctxt = {};
> >>>>
> >>>> Although to cover all cases now and going forwared, the es_em_ctxt fi
> >>>> member should just be zeroed in verify_exception_info() when
> >>>> ES_EXCEPTION is going to be returned.
> >>>>
> >>>> Thanks,
> >>>> Tom
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Tom
> >>>
> >>> Yes Tom, that is exactly the reason I worked on it the first place. The issue was reported by the Coverity tool.
> >>>
> >>> I can send the below fix if that is fine.
> >>>>> 	struct es_em_ctxt ctxt = {};
> >>>
> >>> For the es_em_ctxt fi member to be zeroed, I can go ahead and assign 0 to all the three long members like below in verify_exception_info()
> >>>
> >>>
> >>> 	if (info & SVM_EVTINJ_VALID_ERR) {
> >>> 		ctxt->fi.error_code = info >> 32;
> >>> 	} else {
> >>> 		ctxt->fi.error_code = 0;
> >>> 		ctxt->fi.vector = 0;
> >>> 		ctxt->fi.cr2 = 0;
> >>
> >> But then the cr2 value isn't set/zeroed in the true path of the if
> >> statement. I think a simple memset() at the beginning of the if path
> >> that will return ES_EXCEPTION is simplest.
> >>
> >> Thanks,
> >> Tom
> >>
> >>>
> >>> 	}
> >>>
> >>> return ES_EXCEPTION;
> >>>
> >>> Thanks,
> >>> Ragavendra N.
> > 
> > I am assuming something like below.
> > 
> > /* Check if exception information from hypervisor is sane. */
> > if ((info & SVM_EVTINJ_VALID) &&
> > 		((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
> > 		((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
> > 
> > 	memset(ctxt->fi, 0, sizeof(es_fault_info));
> > 
> > 	ctxt->fi.vector = v;
> > 
> > PS - My C skills is not that great as well, as I am from Java/ C# background.
> 
> Yes, that is the general idea.
> 
> Please be sure that whatever you submit builds properly before
> submitting. For example, the above will fail to build (as would have
> your first patch).
> 
> Be sure to read Documentation/process/coding-style.rst and
> Documentation/process/submitting-patches.rst.
> 
> Thanks,
> Tom
> 
> > 
> > 
> > Thanks,
> > Ragavendra N.

Sure Tom, I will certainly check if I can build correctly and read the suggested documentation as well before sending my patch.


Thanks & regards,
Ragavendra

