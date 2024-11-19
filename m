Return-Path: <linux-kernel+bounces-414799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455AA9D2E53
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22624B33BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990381D1732;
	Tue, 19 Nov 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVY+usYB"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC01CF7BE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039724; cv=none; b=n7cSmSZBrPRYzFWG/auDxmCOqsRtXGFNeJi6BOpPqaodwWG02MkmpvEZvDbpa2eakIezHo8dUNwYSaSG4/LhGUvhG8AeXb8nQyVtpqjjjdr7iRF+6Xa8pWFm8jAiFHLJjAD0sz1kZC2SF+4DGzIwkMJH6i+C3+4YsSUmYfQ/KzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039724; c=relaxed/simple;
	bh=ABCVQQ/oubRD0q8KjH9PhUAToxqy6BsbP0MmBtjFUbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNWJ+w8E6fHYmZ5ycNS2vMruO8DFesTFDlfRJjTtqwrlc5AB84eaZ/GOwwgRwLQ96XZRjvVBL1mQdKSkbnFjBn2tIiEyxM8h1/u1+fZ4Tz4QtrnSU8Hmq5L5YHfVfnK296yOpUJtEUBnM4ZWmMxHOXl2TAWHod0gToN1pg5nc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVY+usYB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea9739647bso996552a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732039722; x=1732644522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aq+kH256cOwYf9vQX57gUKcS5dMPP1ZyocTxDkI1PUM=;
        b=BVY+usYBYfV+D7tC4rqQtmv9C3PRjMOw7w02AustTewq4V5uBHiRz+9LMpdgh5AYPU
         CHiO149RaMUGtLagvjPX1qlWd3XC9/RaqvLybIJo+7rOvXmm6SOW+GphqS6QLa/j2Kg9
         4rM1HoWhB8xBSBN48Led/RQ6jcffEn1X74SlHmsqdPrRs2+FKt/JRF1De6/ML5So5RkL
         r/z0o153xDaVzv3FQ0MtV/jydN0HaygVJvTRC/0gqeElALUeNsyAPlDLFkA7x0l5FNdB
         a0SLoG+HG0DzAFNj+1xe2xjekdSkATMFlCOc5FvybckY4J/Nh3mcDLGjAeRCjtvqgf/l
         5B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039722; x=1732644522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq+kH256cOwYf9vQX57gUKcS5dMPP1ZyocTxDkI1PUM=;
        b=WsfCJRl1hYqHRDb5IhUJOsXOpfO8uoJ9AbAWy1DzXU1DAHE6b6qVDaoDLqf+WDi0bQ
         dSNCMl6l8Nkr/p53Uo+9W6s3d5QcHissPNmtZtqDGpdlnFJrOF9OgDSqZ6VUANqlzlt9
         Q81cnWSmcwzclHNXOAMNy6cKT8wQk2shSXficuJWp+lt3lCqjRdY06tcbi2s1lLgXUtG
         f8K3sPJ6oynJZ0yVYri+RAkKMdl066Yd9uuie8DhM08aqXaYodujRcntXT+v4f7b8SXA
         9QclHYXTirLiomBokIzewqwYeMXVpVCxALu/ygvHoR0oHlfFoO/5fFRY8m0dT79/n1UV
         VuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl/k5fkv+Ft/6UhhaowilaBe4C0NWwpxJ+fYyrXnj1z8tKUlmxeXPvf5biaVGUsArKFpvQiZ8r6u3JXjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hO6zKvD/aPcYEiwE1fVCXfedvT6zWCb1QA4mj7ozl9CLO0VU
	Ouva34JpR5sNNs6uDZtzylu+tuR01cmgygEfJjkOfldLrB+SYkz3
X-Google-Smtp-Source: AGHT+IEkLvWOcPjmfsCl1hGu1TlJjDw6x3uellzWs0wF2J/LubQIEQbPxe8nnkvtO3qT151rN2c+Og==
X-Received: by 2002:a17:90b:2d83:b0:2ea:9ccb:d1fe with SMTP id 98e67ed59e1d1-2ea9ccbd2f4mr7322925a91.0.1732039721852;
        Tue, 19 Nov 2024 10:08:41 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea2d9bef78sm6907061a91.27.2024.11.19.10.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:08:41 -0800 (PST)
Date: Tue, 19 Nov 2024 10:08:38 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, ardb@kernel.org,
	tzimmermann@suse.de, bhelgaas@google.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/sev: Initialize ctxt variable and zero fi
Message-ID: <ZzzUJpF5wNk0dEOe@desktop>
References: <20241118225828.123945-2-ragavendra.bn@gmail.com>
 <fc2202de-595b-f561-dc59-08f32c56ff73@amd.com>
 <ZzzMeHFyWTVT0-cI@desktop>
 <c5292bcf-4e9b-289d-c6f4-c587a879e07e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5292bcf-4e9b-289d-c6f4-c587a879e07e@amd.com>

On Tue, Nov 19, 2024 at 11:51:27AM -0600, Tom Lendacky wrote:
> On 11/19/24 11:35, Ragavendra B.N. wrote:
> > On Tue, Nov 19, 2024 at 08:23:14AM -0600, Tom Lendacky wrote:
> >> On 11/18/24 16:58, Ragavendra wrote:
> >>> Updating the ctxt value to {} in the svsm_perform_ghcb_protocol as
> >>> it was not initialized. Updating memory to zero for the ctxt->fi
> >>> variable in verify_exception_info when ES_EXCEPTION is returned.
> >>>
> >>> Fixes: 34ff65901735 x86/sev: Use kernel provided SVSM Calling Areas
> >>> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> >>> ---
> >>>  arch/x86/coco/sev/shared.c | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
> >>> index 71de53194089..5e0f6fbf4dd2 100644
> >>> --- a/arch/x86/coco/sev/shared.c
> >>> +++ b/arch/x86/coco/sev/shared.c
> >>> @@ -239,6 +239,8 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
> >>>  		if ((info & SVM_EVTINJ_VALID) &&
> >>>  		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
> >>>  		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
> >>> +			memset(&ctxt->fi, 0, sizeof(ctxt->fi));
> >>> +
> >>>  			ctxt->fi.vector = v;
> >>>  
> >>>  			if (info & SVM_EVTINJ_VALID_ERR)
> >>> @@ -335,7 +337,7 @@ static int svsm_perform_msr_protocol(struct svsm_call *call)
> >>>  
> >>>  static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
> >>>  {
> >>> -	struct es_em_ctxt ctxt;
> >>> +	struct es_em_ctxt ctxt = {};
> >>
> >> This isn't necessary if you are doing the memset.
> >>
> >> Thanks,
> >> Tom
> >>
> >>>  	u8 pending = 0;
> >>>  
> >>>  	vc_ghcb_invalidate(ghcb);
> > 
> > I can go ahead and undo that, I fear that Coverity can catch it. If no harm I can leave it.
> 
> Well, can you remove the line and run Coverity and see if it still
> thinks there's an issue?
> 
> If it sees an issue, then it could be that Coverity can't follow the
> flow completely in this case. Doing the memset is enough, as far as I
> can see.
> 
> Thanks,
> Tom
> 
> > 
> > 
> > --
> > Thanks & regards,
> > Ragavendra N

Sure Tom, I have updated the change and sent the new patch. Please let me know if everything looks fine,


Regards,
Ragavendra N

