Return-Path: <linux-kernel+bounces-413479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F169D1992
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73887B216C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00211E5712;
	Mon, 18 Nov 2024 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddARS/kz"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141F13E8AE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961362; cv=none; b=QbX+rL/HnGYDV7LNxJdotQrl35qlTwbia2Kocl/HjiB8+dh67HhVsbbsCimC3wGtMrYtqYZ0Pkcix6Svg7gTiq7jS9G0pKgL7m6yH0Klc17uvWaoCagPNBZL620Ye9LfIztszElTXxIraNfGNWbR7TT8opJqhhmR8V/+aYPLhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961362; c=relaxed/simple;
	bh=mnluNQgAlve510/CApfWtOdnDgl/FFXptVyIYDKoPr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8yl3FxDqcyHnmkzEDmDWdjj6IF0gDhFfc/aBlb2kVrxJx/kHuu/d49INLOCgekn1erD6syU11JjNGN8qWBdMQgPobGmffkxHeMuHIv8lPkjNgPRPtsNoc7vh5zxlcuEWXVFIpd6UTZmYhztoXoeV2NusoW0e4M1Xj1msJGvTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddARS/kz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e4e481692so2192298b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731961360; x=1732566160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjZL90HQpHB6LG1LvYT8ZAn2ywC/8IFgY2cBaLePPqo=;
        b=ddARS/kzWYGfNdNIMGZdWyVlNgQ+DYvxJlSwRpK+WT48iUXMis6pmRKDqMU/tmn7XM
         xI9kPg9Yl4lwSdEHQBO6DjBI+knZ+hAK0QEMVCIm+cbgtMpjNbNoj8cyDCFSomXen7Dy
         w/wALDRZdiD+lTmjmDs0pOmfjdEytdN6/RZqwLgydVqh/u21Ox3bqaRY+d3LPgkMsgux
         dzRCwOW1oXIvZ0qE50SUnPP942H0j18f1PongO7XeenbVqTS+P+wajzgx3ppzItRo+lN
         1Z2deACTV3qV0EMYXECZDBo0YUgxtEPWDN5QoJGG6wfxVow3Q8nv6nO4qLsE4xqNdk0G
         i9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731961360; x=1732566160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjZL90HQpHB6LG1LvYT8ZAn2ywC/8IFgY2cBaLePPqo=;
        b=lwPcLuxSxNDiUzFmc88GJN+GqKYhKSCr79A1f/DRDdzj45DBWMdmyaTOiTBHjSJO8D
         0MxBx3ugyv7BCpMw1du0pfiEQFdRxd3+Qls78SAmCIvjz+Lt4JxLmlIwrFXcDt0jnshD
         7UZuF/RrFSCmIzr/TWwMNhZyqSSTy1sbpkCmffoUO/7TXGEbTqzVxMqqiO7fP3HSflPY
         gEk5KzXFM/+3XVNM7v/jsaAVV9xl03FQqedbr9noTSc4G7il6tFCZAAnQc6Lcf3Z8259
         5d8lAI/r5DCZYkQrYn0Q8SFYiTMZHfoSez1MyUg+UVmWaOQqSDKSS4/nZyFEghrIygLZ
         osKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrR+agcoU33tbzo5PaYoKcP1kyEHybst/QKqRReJDr4ZBclfGkV6uJ1izJOSj430hrSFZIxu9uBx31zN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHKZs4jXYclDfTjk3XkZjhnfnXH+ZeS+dDgZm/YePFuLB3nbq
	iSepJxaY7DeyHCSUKKCT4BbHs0OAWkMPrmoi+CIp3oVqHHqSGMR7
X-Google-Smtp-Source: AGHT+IFQBbuoeAw5mvKK6TaUb6h7ms9scJfWd7IMe1+d91V4MnVNWi8INJrFcBO5OstyzXTI1NHdfA==
X-Received: by 2002:a05:6a00:b56:b0:71d:fb29:9f07 with SMTP id d2e1a72fcca58-72476bba9femr17061851b3a.15.1731961359886;
        Mon, 18 Nov 2024 12:22:39 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e5bf2sm6588587b3a.166.2024.11.18.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 12:22:39 -0800 (PST)
Date: Mon, 18 Nov 2024 12:22:36 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, ashish.kalra@amd.com,
	tzimmermann@suse.de, bhelgaas@google.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Message-ID: <ZzuiDPWzloIAJYya@desktop>
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com>
 <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>
 <ZzemwFBfEIgFhrD-@desktop>
 <CAMj1kXHPut9qv7dT9Xv=xhbS6AP3HRP0dikk-G690AKfLuNLGA@mail.gmail.com>
 <c7a9748e-aead-b252-dd29-48dd0d2da9be@amd.com>
 <30558bc8-c22c-1ce1-f59a-66c057fdd06f@amd.com>
 <ZzuYy9KHwlLa9HLY@desktop>
 <182fc3f3-2b9d-5c86-b058-5d1208305cbb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182fc3f3-2b9d-5c86-b058-5d1208305cbb@amd.com>

On Mon, Nov 18, 2024 at 01:50:55PM -0600, Tom Lendacky wrote:
> On 11/18/24 13:43, Ragavendra B.N. wrote:
> > On Mon, Nov 18, 2024 at 08:53:04AM -0600, Tom Lendacky wrote:
> >> On 11/18/24 08:44, Tom Lendacky wrote:
> >>> On 11/15/24 16:55, Ard Biesheuvel wrote:
> >>>> On Fri, 15 Nov 2024 at 20:53, Ragavendra B.N. <ragavendra.bn@gmail.com> wrote:
> >>>>>
> >>>>> On Fri, Nov 15, 2024 at 12:02:27PM +0100, Ard Biesheuvel wrote:
> >>>>>> On Fri, 15 Nov 2024 at 12:01, Ingo Molnar <mingo@kernel.org> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> * Ragavendra <ragavendra.bn@gmail.com> wrote:
> >>>>>>>
> >>>>>>>> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
> >>>>>>>> it was not initialized.
> >>>>>>>>
> >>>>>>>> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> >>>>>>>
> >>>>>>> This 'Fixes' tag looks bogus.
> >>>>>>>
> >>>>>>
> >>>>>> So does the patch itself - 'struct es_em_ctxt ctxt' is not a pointer.
> >>>>> Thank you very much for your response. I am relatively new to kernel development.
> >>>>>
> >>>>> I know we can use kmalloc for memory allocation. Please advice.
> >>>>>
> >>>>> struct es_em_ctxt ctxt = kmalloc(sizeof(struct es_em_ctxt), GFP_KERNEL);
> >>>>>
> >>>>> I am thinking to update like above, but like you mentioned, ctxt is not a pointer. I can update this to be a pointer if needed.
> >>>>>
> >>>>
> >>>> The code is fine as is. Let's end this thread here, shall we?
> >>>
> >>> I was assuming he got some kind of warning from some compiler options or
> >>> a static checker. Is that the case Ragavendra?
> >>>
> >>> When I look at the code, it is possible for ctxt->fi.error_code to be
> >>> left uninitialized. The simple fix is to just initialize ctxt as:
> >>>
> >>> 	struct es_em_ctxt ctxt = {};
> >>
> >> Although to cover all cases now and going forwared, the es_em_ctxt fi
> >> member should just be zeroed in verify_exception_info() when
> >> ES_EXCEPTION is going to be returned.
> >>
> >> Thanks,
> >> Tom
> >>
> >>>
> >>> Thanks,
> >>> Tom
> > 
> > Yes Tom, that is exactly the reason I worked on it the first place. The issue was reported by the Coverity tool.
> > 
> > I can send the below fix if that is fine.
> >>> 	struct es_em_ctxt ctxt = {};
> > 
> > For the es_em_ctxt fi member to be zeroed, I can go ahead and assign 0 to all the three long members like below in verify_exception_info()
> > 
> > 
> > 	if (info & SVM_EVTINJ_VALID_ERR) {
> > 		ctxt->fi.error_code = info >> 32;
> > 	} else {
> > 		ctxt->fi.error_code = 0;
> > 		ctxt->fi.vector = 0;
> > 		ctxt->fi.cr2 = 0;
> 
> But then the cr2 value isn't set/zeroed in the true path of the if
> statement. I think a simple memset() at the beginning of the if path
> that will return ES_EXCEPTION is simplest.
> 
> Thanks,
> Tom
> 
> > 
> > 	}
> > 
> > return ES_EXCEPTION;
> > 
> > Thanks,
> > Ragavendra N.

I am assuming something like below.

/* Check if exception information from hypervisor is sane. */
if ((info & SVM_EVTINJ_VALID) &&
		((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
		((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {

	memset(ctxt->fi, 0, sizeof(es_fault_info));

	ctxt->fi.vector = v;

PS - My C skills is not that great as well, as I am from Java/ C# background.


Thanks,
Ragavendra N.

