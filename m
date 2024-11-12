Return-Path: <linux-kernel+bounces-405362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525A9C505A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7221B20D61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C920ADCA;
	Tue, 12 Nov 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZYBz3KtF"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6E820A5E2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399282; cv=none; b=HwhAJ4iv5q12/moLI6xnWe7ESC+Qntdv40NNMTYapq3QpF/J4aETVVpZRPCNloRsOwY+k5y8PxEPMYMZkcaCI18b7QD+q3h1D+IGTx6iptwM3pYR03/xq9O8+4IzeUntsWOemfoTi0YDTn7TeOJtt4USfSbNurKU653wCM7dnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399282; c=relaxed/simple;
	bh=p+PLXWjKhpjZKwcc5evOVsR4vXrIBGkinCO2LXr8fB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQAInvRUwuLOSb1cnsVjTns8MHCfYl3FGfk7rSJpd5ZaFX74LlfI6GjFUUCE89JFLvLGfBPpx4KubLqBcWIYnMT7mX5KPGvu4e+kWE0gUXtGWnnjkm+csfe6SpF8+aOWRAyx9VH6LsMkNmkr63GG2V5MvWA7nkAHLHaSngiGPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZYBz3KtF; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5942079e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731399278; x=1732004078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw10TBbxuvf4HDg6HLVPzeEukqtfWyQvuwOwH1nNUuY=;
        b=ZYBz3KtF0eHFm5jLH2pRcwW/0+iDcTKP4+3MQ2WFAFgAFmv5m4YCikSb8t/iMGALQB
         7rZ2nnKoIVROKd9jDhVfsTjfgfeAJTwCWip2/fxA2//4YB2nRKTgutabh1sKdnFem6c4
         btJ6daRdpXz7kNbURFeOLE09ves3kTp7Oh9DFdFTp+5iNjalyqDrT8aaII42ltxT+Cbe
         WNdo37i6x4WuLb3QFOsawx6Pjr/webSniFsUZAM5bwtSgdUIU5alGN+vGh1zsyM3K1XI
         HPuj8T7dtC5LnpQ1Prj2UbTGaeiHz/lCu5wv29Xntf+D/I0uLJQZ08cTPQyAktMAp1v6
         rMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731399278; x=1732004078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw10TBbxuvf4HDg6HLVPzeEukqtfWyQvuwOwH1nNUuY=;
        b=PL2PfY2dhYp+azwDs3Z7Mi+5p76MPnCySr5H8XmMtKfbkgtNZ1IeljJHahm9QnX9Vp
         imKEKAr92GOg5hANVr4MpvjTHrIBAzylvzT8wu0uOpEy9ZyDSkKM2bNyfqJmI4D3JLnw
         zxg5waeWzHy1dEdvnFd+OrDU/bFIFg2HwUOn6gIwF/Tgia8tjuhKU11orTEVoIbvSFJt
         rmm76MyYl+kflAK/G/kCZER8tjC26raQTcf0MhkcSnvYyADiGTSK8/Um3ctGEkn6btJO
         5lzwwpeDAHW6PB9IHqBJ0sdcQ6yOSGrsxaVJFfXHeppShkoNHzas5NhfOxSbzlT/n325
         fznA==
X-Forwarded-Encrypted: i=1; AJvYcCUVNtcnLwTaIRo9419qrGJoyf8+YwwFzGESGZbFoPFvB4yvNekNNvY8RQx3q/t5Ksy9N+B4T8Tf5NdG2do=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3VR4hNniummC5b8FfsO3mtvNwMr4dz+0SxIn1KbcGmOiCTQ6
	KRkJPSx7fkALIaiHIpVe6AccL0OS6Txggz39g6th3+sdwPklRIqMK6ITJ3wM4zw=
X-Google-Smtp-Source: AGHT+IFTdAFBMMexGsjhtVqcKMviXCoA1Ar7R1Xm34YUqQZKZmRFIVoKBH8NkaeKsRQ21uPL0Q4RjQ==
X-Received: by 2002:a05:6512:2214:b0:53a:38:7b8c with SMTP id 2adb3069b0e04-53d862c5a94mr6955168e87.34.1731399278397;
        Tue, 12 Nov 2024 00:14:38 -0800 (PST)
Received: from u94a ([2401:e180:8d01:b15:c48:5934:ee45:3aed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5810csm88272225ad.179.2024.11.12.00.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:14:37 -0800 (PST)
Date: Tue, 12 Nov 2024 16:14:32 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, cve@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52920: bpf: support non-r10 register spill/fill to/from
 stack in precision tracking
Message-ID: <o7mtz7q3537vuw3gcqjxjdrsg4p6k7dvldu7dabonx2wrcyomn@ks5pl5soifjv>
References: <2024110518-CVE-2023-52920-17f6@gregkh>
 <emjjveewgoegvinmjmba4ys34vbmb3sp6r6qefv77i5mtettmj@hsvm5vm3qivd>
 <961720ed43b3df26042efc260d433fb6ddf5c44e.camel@gmail.com>
 <6ff5182d2cdc4601834bfaa1e3cd1db3@epfl.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff5182d2cdc4601834bfaa1e3cd1db3@epfl.ch>

On Fri, Nov 08, 2024 at 07:59:22AM GMT, Tao Lyu wrote:
...
> >> I'm trying to determine the security implication of CVE-2023-52920, or
> >> more specifically, what does commit 41f6f64e6999 ("bpf: support non-r10
> >> register spill/fill to/from stack in precision tracking") fix.
> >> Superficially this looks more like an improvement to the verifier.
> >
> > It is my understanding as well, that this commit is an optimization to
> > avoid some precision marks. I do not see any security implications.
...
> Hi Andrii, Eduard, and Shung-Hsi,
> 
> The previous discussion is here: https://lore.kernel.org/bpf/20231020155842.130257-1-tao.lyu@epfl.ch/ 
> 
> In short, without this patch, the verifier will miss checking an execution path that can have out-of-bound access,
> which eventually leads to privilege escalation, like obtaining the root privilege.

Thank you both for looking into this, and Tao's pointer to previous
discussion. I'll try to have this backported to at least stable 6.6.y.

Best,
Shung-Hsi

