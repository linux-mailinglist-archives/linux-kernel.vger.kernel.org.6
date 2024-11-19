Return-Path: <linux-kernel+bounces-414745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429E9D2CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DAB29421
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A0F1D0F79;
	Tue, 19 Nov 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IexHH1Io"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592591CF7C9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037757; cv=none; b=oRVYN5tlcKhE1r88FAltDMWD5wl4/uv+VcEXAaeyLJT79IoDW/4DjwXa4H5doKofgoyAG8RHuJ5+hoygc+B3I3EhgJgTjdRtHM6+ayKSdwkdsS8QbpbwEC6AQJfACTAZARv/BJNjEp/RYzSc0Tq2Q8xvTh6Ff3/pC9CyEwWnIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037757; c=relaxed/simple;
	bh=3PVi5uQ18yQv5FGHUW7pia28pmgtf5Wrc2UOhsBa1BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKAwWI990dEwM/Tek997OE9g6dB1ApMs/DUnJz5sIBZCEkObwPXiktL7IhhIK42GBt5TtMgRYni+JpqcY/SQ/e5X8lr5UjaO3CmvBoTA3s71qvMH1YyKg0N+8jhK1JOcB1xzfSLGQ0lqXX12tDYLZmVpD9F+lYX3fh4Djtnrj4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IexHH1Io; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea6f821decso1036095a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732037755; x=1732642555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hqsWUpFO2MMEKYBLW4PEhoQvq3wP8PQXpQdQVsc86e8=;
        b=IexHH1Iog/KJTT4xL2iTZK7BvQVoFPY2HDZZqrRaTc+105BaeESpvH51nmDyXlzutf
         LLVioDx8ElUSFjv++HCivojQ//SLZHJwkKeViDftHB6Eu9YQwVCC8I2d2h8qqMmYfWGJ
         /7CsUoDHRu1Pnq3tJt1pF1WCkcoQA/7SVFDK6qo4S8PFOgQWJNcE/op96pl6iXO6ntfw
         wc06v39g2LNWBbsGYAHwk2Kamds2wbKm3Dk7ZRLnGP4+bQ7dzZXwVNWiXVCnrm/v5miS
         ShhDBIF11vS0PEjDGn+/DpWIQJjAhk6VWZOp7bbxWUfWzSIthxP+PfzgkqgXQurJbgVV
         bTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732037755; x=1732642555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqsWUpFO2MMEKYBLW4PEhoQvq3wP8PQXpQdQVsc86e8=;
        b=Vka40nT84Onf3p7gl76DHmM8TUw0HJhorn2TgXfFHH1C+vduuJUo64RJjXfAiqz54p
         0vMdaKN/ykDP4ZVixArk95DpjJAZBuXPd0xqfEdUZYkL4njxECORTvLKzHACkyC56b0Q
         3+JR9N3GbTo4muIVBsMTlIVza6zj3P1v9D0rPMoxblugCyVTQlNzEgoWJ842kzWVCDZK
         a+h+MkyKFk+WERBFSb7l5Xxzvgn3EiqPPQu8LSRUTueAw1gpsATHA2arIp7RJZ79MJwK
         iKXFESqVCDC6tN7gor9BO54rca+IgGc+NDzNGyFAEl5eLn8CZulqWdrE2uK+jgmX/reL
         N3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAOaO17M5lYL10cEDkclJNEW36kuM1pysHtnW4iYoHllbM+XyNW1rPSU04FK4iHLdPR9I677WmZzF5tH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxlk6f5n3An6u36ZqBwY67zq19HGz2jjJ5qgZgwqGjpbE9RaOk
	qeXnxGVx6iyqc0SownyDaD8YM4loH9N58uWNXJJcMzkj1b6RJ1DR
X-Google-Smtp-Source: AGHT+IHtM56s4WB4avknhZvGKD+ANxXOLO/LXPhVaLX2GNBv0P2BBrxAVh67wYaO8y1WK4HOd/GJfQ==
X-Received: by 2002:a17:90b:1c10:b0:2e0:7b2b:f76 with SMTP id 98e67ed59e1d1-2ea1551e389mr20638217a91.19.1732037755496;
        Tue, 19 Nov 2024 09:35:55 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea3f4ea617sm6110167a91.30.2024.11.19.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:35:55 -0800 (PST)
Date: Tue, 19 Nov 2024 09:35:52 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, ardb@kernel.org,
	tzimmermann@suse.de, bhelgaas@google.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/sev: Initialize ctxt variable and zero fi
Message-ID: <ZzzMeHFyWTVT0-cI@desktop>
References: <20241118225828.123945-2-ragavendra.bn@gmail.com>
 <fc2202de-595b-f561-dc59-08f32c56ff73@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc2202de-595b-f561-dc59-08f32c56ff73@amd.com>

On Tue, Nov 19, 2024 at 08:23:14AM -0600, Tom Lendacky wrote:
> On 11/18/24 16:58, Ragavendra wrote:
> > Updating the ctxt value to {} in the svsm_perform_ghcb_protocol as
> > it was not initialized. Updating memory to zero for the ctxt->fi
> > variable in verify_exception_info when ES_EXCEPTION is returned.
> > 
> > Fixes: 34ff65901735 x86/sev: Use kernel provided SVSM Calling Areas
> > Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> > ---
> >  arch/x86/coco/sev/shared.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
> > index 71de53194089..5e0f6fbf4dd2 100644
> > --- a/arch/x86/coco/sev/shared.c
> > +++ b/arch/x86/coco/sev/shared.c
> > @@ -239,6 +239,8 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
> >  		if ((info & SVM_EVTINJ_VALID) &&
> >  		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
> >  		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
> > +			memset(&ctxt->fi, 0, sizeof(ctxt->fi));
> > +
> >  			ctxt->fi.vector = v;
> >  
> >  			if (info & SVM_EVTINJ_VALID_ERR)
> > @@ -335,7 +337,7 @@ static int svsm_perform_msr_protocol(struct svsm_call *call)
> >  
> >  static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
> >  {
> > -	struct es_em_ctxt ctxt;
> > +	struct es_em_ctxt ctxt = {};
> 
> This isn't necessary if you are doing the memset.
> 
> Thanks,
> Tom
> 
> >  	u8 pending = 0;
> >  
> >  	vc_ghcb_invalidate(ghcb);

I can go ahead and undo that, I fear that Coverity can catch it. If no harm I can leave it.


--
Thanks & regards,
Ragavendra N

