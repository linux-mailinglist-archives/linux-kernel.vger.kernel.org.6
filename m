Return-Path: <linux-kernel+bounces-411213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886949CF4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA292811B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5F1D90BC;
	Fri, 15 Nov 2024 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2XNC3gEm"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6B166307
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698325; cv=none; b=hfd1l4GIBnAg0sdWgp6DYd6HuaNl+BvqCkdGzZLteVcrnM/gTD0g9CdRqNhWo0572Nu849vvec+Qj1CaaePLOWfoKAJs0pLT+7Fbmx823HlQMcGF+yJv9vOHueFYREsjy9SwS8PZ5nqdkl607TWEQCod6M7o369yne5KhJaYNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698325; c=relaxed/simple;
	bh=t3HGFRzcc7qSh3ekvRAyGEjFsPeneuzZNWnlcjmaNIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNrVhE5x1s/wFGwLwxOvchXuWJcPD49wahrcxsdIz7dQbW2GvmEMYGCxwCdliEcoDTrXyMxVVtbvEId8B1Fi9HlxxQHYgieXtvSNAwsWuBfCcEX+RM0UwT+2m8nGUvLZadYG0wmVyHYXewSIZJp83vuIqqhfsLcVvhTCFbpiK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2XNC3gEm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315ee633dcso3895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731698322; x=1732303122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gb7hmFy/0l+JpT17zGKACyUketzLohMMo6Nszps9h8Q=;
        b=2XNC3gEm4NEq7WoHYLJHSLXLP9jxKFhzohIjo4z5GgiGub6uZZ3r4zmm8hJSmTSsB8
         DVeWocx+7saXhTiX9wOmAmgmLIQVEnAYFMQX+oGGe3GTl1DmHsLNoOt8mxLSbBJMdpNH
         h/P8RdMj0T17qwHUJAk7L/7N60CwElDAIYZCD9ftfAV7L+W7DXuFB6TalYXyYH5ui336
         3EEivBpEAIYCdatrc99TizrFv/b9cYuCjg+BgKJYDpT0yBc+VyrjKOBV2QwXmEGFontP
         NHNBxkN/eR/VkAjBxBal5FapwW2AAwREoFpSyk8lfHFDxWPcvTvmfGhAp9cjC2va1HpR
         083Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731698322; x=1732303122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb7hmFy/0l+JpT17zGKACyUketzLohMMo6Nszps9h8Q=;
        b=iBIholBquRJTI9+KyR/9wHEz7Scl7Nisda4UuQH9jOZdnIorDMOHTMSAm7ysrJHulH
         kTZZqzrY8fzOYpIZtZRgcT+VpG4xgtzG1xnmnKmnSfmeNCZ5wZVrCa3pCKN0slj3MbXU
         BUKrsnhVcSwHlgZUcgx/zYXEa6O6co5y51dlXUEhIp7Lc4s3bFQYDajHxXOW1VWrzkY0
         Dve4I5SMjmiq0ShwUgsMuW/+WcdqLQhIT1TWJ0xQJv96jfiVW0108owR1HocBVZJ/8lQ
         x2zwXKdFjlYWOSAp4nicf/AVyPHmB5Zwi64s0P8Qzwb8qhdu1cLDM/ljkA8/LtvcOW3o
         vy5g==
X-Gm-Message-State: AOJu0YyN75n2HzuOz6fsQpuEgEBUxQIwtT1ZjX+V0O/T5tIoKhfr5Iv+
	GkgtWJruZxbf1oB9bpspOT0BZmxX9QA3SmWAog+8D5Jfnu8n2HXoO9NRLTCvNA==
X-Gm-Gg: ASbGncuLwj/15LdOVJA6KAJ4rG5wruju8t/PCLgzf8TkMu5BqDKgpilOUlbHkK3DYcy
	uNkSH8b6bqtIbJUf8jvJ0Dn/ZjNXetCBckY7ZRBOeYGlg61qg7anmAUHNpG8gxpM7C8SQIEqEKD
	z7DYjR6Uu5kUXTwaV/MZ+6B6Q8DGs1982uvEyuFZfNz2ibBhBmgdN8ZiPl0Mvab5RzUpBOgHHRz
	jQgqMSIw+SlxDRa/IQbEt48peo4wL7VqAIDdz68QVn1KGm6Ffpekt0PG5Rr3NFxbd2ced8M4zbW
	auRVFUUmOD6Y
X-Google-Smtp-Source: AGHT+IG+0JQ95//Ajrq0lgO/WvKJa6AW6bqohkm2IbIyY8g9NlthrnZKtmPcJ0NxaAiAhUmfbGf1Ng==
X-Received: by 2002:a05:600c:3512:b0:426:66a0:6df6 with SMTP id 5b1f17b1804b1-432e609ec5dmr52285e9.0.1731698321726;
        Fri, 15 Nov 2024 11:18:41 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78918sm61906695e9.17.2024.11.15.11.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:18:40 -0800 (PST)
Date: Fri, 15 Nov 2024 19:18:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	joro@8bytes.org, Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] drivers/io-pgtable-arm: Fix stage concatenation with 16K
Message-ID: <ZzeejJL3Tt4OlFdr@google.com>
References: <20241115172235.1493328-1-smostafa@google.com>
 <888e6542-2aa4-43f1-b31e-79432c1ad199@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888e6542-2aa4-43f1-b31e-79432c1ad199@arm.com>

Hi Robin,

On Fri, Nov 15, 2024 at 06:29:20PM +0000, Robin Murphy wrote:
> On 2024-11-15 5:22 pm, Mostafa Saleh wrote:
> > According to the Arm spec DDI0487 K.a, in:
> > "Table D8-9 Implications of the effective minimum T0SZ value on the
> > initial stage 2 lookup level"
> > 
> > Some combinations of granule and input size with stage-2 would
> > require to use initial lookup levels that can only be achieved
> > with concatenated PGDs.
> > 
> > There was one missing case in the current implementation for 16K,
> > which is 40-bits.
> > 
> > Cc: Daniel Mentz <danielmentz@google.com>
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 14 +++++++++++---
> >   1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 0e67f1721a3d..9a57874a5cb8 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -1044,10 +1044,18 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
> >   		return NULL;
> >   	/*
> > -	 * Concatenate PGDs at level 1 if possible in order to reduce
> > -	 * the depth of the stage-2 walk.
> > +	 * Some cases where concatenation is mandatory after de-ciphering RSRKBC
> > +	 * in the Arm DDI0487 (K.a):
> > +	 * - 40 bits with 4K: use 2 table at level 1 instead of level 0
> > +	 * - 40 bits with 16K: use 16 tables at level 2 instead of level 1
> > +	 * - 42 bits with 4K: use 8 tabels at level 1 instead of level 0
> > +	 * - 48 bits with 16K: use 2 tabels at level 1 instead of level 0
> 
> This confused me, since per R_DXBSH, that last one is the only one which is
> actually mandatory in general; the others may be valid per R_PZFHQ and
> R_FBHPY. The additional R_SRKBC constraints come from the PA size, not the
> choice of T0SZ (and thus ultimately start_level) itself, so although I guess
> this probably works out true in practice based on how the SMMU drivers
> happen to behave today, it's none too obvious why.

Ah, you are right, I got a bit confused, it's not actually about the
input size, but the fact that the SMMUv3 driver uses IAS = OAS for
stage-2.
And constraint R_SRKBC is about the OAS size.

So in case we change that IAS = OAS for stage-2, we could end up using
concatenation when it's not mandatory.
I don't think that's a bad thing (I was actually thinking of changing
the code to always use concatenation if possible)
But, I can re-write the code in terms of OAS + granule instead so it's
more robust incase we change the stage-2 config in the future.

Thanks,
Mostafa
> 
> Thanks,
> Robin.
> 
> > +	 * Looking at the possible valid input size, that concludes to always
> > +	 * use level 1 with concatentation if possible or at level 2 only
> > +	 * with 16K.
> >   	 */
> > -	if (data->start_level == 0) {
> > +	if ((data->start_level == 0) ||
> > +	    ((data->start_level == 1) && (ARM_LPAE_GRANULE(data) == SZ_16K))) {
> >   		unsigned long pgd_pages;
> >   		pgd_pages = ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte);
> 

