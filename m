Return-Path: <linux-kernel+bounces-172916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F948BF8A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7982812A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9D535CF;
	Wed,  8 May 2024 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lZRLXFtT"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEF28FF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157373; cv=none; b=ZyTSGf5BPX9Xwyxv0H49c/ABSC63TuIFlRFdDObAzYF2/gUL81Z5aVgn2PVJUvSUaj77iNQ91DkbAoZojcdjnFlLt8kGPqowrZoJ598mRfjNp7D3rVic8NznOPw1nT1Mm1T5abejECTWIVCPwcqMLfHtmhrZYlE+4wNC8hENnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157373; c=relaxed/simple;
	bh=cD/uGN2qcTWGaaGtNYJBO9NukjIRx0YtregF+2V1VYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i29v7Mxuso67JObaGnq4ROSIBcHSASy3e5VesFs7LFh9PhKONmkC+z1gza+F49cqmobSarVjhX9tV0rU1svJrr5hEcM1ieBwInXvXFb71pfvsrlvEs9RGHcHF+tjNt24E31RfAGEuaQ/bJRP8wbHX/07elS7ZKOVbPTwNE8ufPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=lZRLXFtT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a599b74fd49so102014966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715157370; x=1715762170; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7aS9he7xY72nZNIRe7yyrnZe3tp43pBLnMfxlD1rnU=;
        b=lZRLXFtTpf6T/YG9g89aQUatMWTimu0/EG7HKp449+nKqYvIAIDgTZZ8MUhKrXRfzy
         Ws/pUMT6u2cODkYljc+sNoMMqsN3oMAjvf9+bOkcWOKq3fI4+WSZxVgIYEbXQnWigLIS
         y+TWDcmrRAdL1AbHwwRpOmwKxwdAUuV9f6klA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715157370; x=1715762170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7aS9he7xY72nZNIRe7yyrnZe3tp43pBLnMfxlD1rnU=;
        b=G6N3uOgTFH2hr7+QRNujpLvbt1xMnV0n2wynx3CUSpjDepW50VKbPjupLVb6L+jurR
         r5awI7nHy/X33ZeTbvGOCdDfEKJ4OqeXIrPsFzpYMEmti2MFVLxNkoufzhG9RsE2MzAy
         n1Ha6l31/vZQcwFahaG8GYuz2ZTR4a2D4YNdY8bkhpgTmg3jkvFMIDUVS4C2iBi+UO4z
         qUDNpP7yf/Qr5NYegP07RCF8ONGh0WRi4clW7N5gfEBRQCQhFI4hZVPIFPhilcIVFcMT
         acxdy1CRWS7/g6Qc1BJ3Rez5NrLpfnn6wjddA1LVwwX1ees8moPLvpRWvmcR8gz0If0z
         TNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMhL3fBABIHgvO6zzDlViieSqE0YPkDchM8oGH2lFTiQJ5+FZ1chJ02P9YQdeRdmNkQRZA7dRQOaUORWO02rSb9VyanGbMEMe5BHTR
X-Gm-Message-State: AOJu0YwbB3AkJeGj9jggBo/8jThhnoSxGaJeBG6TMasKpNPNdIBI3y8W
	o9KceKNZkR0J1vsAkaFHYd69H5ZCFK92i5E+TkvtJyK8On0LBIuypGkobwtWCKM=
X-Google-Smtp-Source: AGHT+IH9OKR3iRdAQokCHL9Wcm9g2S3grKMxIcHFTiTEbekRGm3HeABSdlBjlaSiS4k5yg1zHyrUcA==
X-Received: by 2002:a17:906:3113:b0:a59:c46b:c524 with SMTP id a640c23a62f3a-a59fb7107bcmr140268666b.0.1715157370636;
        Wed, 08 May 2024 01:36:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id gc21-20020a170906c8d500b00a59a7bac0easm5214354ejb.164.2024.05.08.01.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:36:10 -0700 (PDT)
Date: Wed, 8 May 2024 10:36:08 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Robert Mader <robert.mader@collabora.com>,
	Sebastien Bacher <sebastien.bacher@canonical.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linaro-mm-sig@lists.linaro.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Milan Zamazal <mzamazal@redhat.com>,
	Maxime Ripard <mripard@redhat.com>,
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
Message-ID: <Zjs5eM-rRoh6WYYu@phenom.ffwll.local>
Mail-Followup-To: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Robert Mader <robert.mader@collabora.com>,
	Sebastien Bacher <sebastien.bacher@canonical.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linaro-mm-sig@lists.linaro.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Milan Zamazal <mzamazal@redhat.com>,
	Maxime Ripard <mripard@redhat.com>,
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <ojduxo54lpcbfg2wfuhqhy7k3phncamtklh65z7gvttcwztmhk@zkifewcy4ovi>
 <3c0c7e7e-1530-411b-b7a4-9f13e0ff1f9e@redhat.com>
 <e7ilwp3vc32xze3iu2ejgqlgz44codsktnvyiufjhuf2zxcnnf@tnwzgzoxvbg2>
 <d2a512b2-e6b1-4675-b406-478074bbbe95@linaro.org>
 <Zjpmu_Xj6BPdkDPa@phenom.ffwll.local>
 <20240507183613.GB20390@pendragon.ideasonboard.com>
 <4f59a9d78662831123cc7e560218fa422e1c5eca.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f59a9d78662831123cc7e560218fa422e1c5eca.camel@collabora.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Tue, May 07, 2024 at 04:07:39PM -0400, Nicolas Dufresne wrote:
> Hi,
> 
> Le mardi 07 mai 2024 à 21:36 +0300, Laurent Pinchart a écrit :
> > Shorter term, we have a problem to solve, and the best option we have
> > found so far is to rely on dma-buf heaps as a backend for the frame
> > buffer allocatro helper in libcamera for the use case described above.
> > This won't work in 100% of the cases, clearly. It's a stop-gap measure
> > until we can do better.
> 
> Considering the security concerned raised on this thread with dmabuf heap
> allocation not be restricted by quotas, you'd get what you want quickly with
> memfd + udmabuf instead (which is accounted already).
> 
> It was raised that distro don't enable udmabuf, but as stated there by Hans, in
> any cases distro needs to take action to make the softISP works. This
> alternative is easy and does not interfere in anyway with your future plan or
> the libcamera API. You could even have both dmabuf heap (for Raspbian) and the
> safer memfd+udmabuf for the distro with security concerns.
> 
> And for the long term plan, we can certainly get closer by fixing that issue
> with accounting. This issue also applied to v4l2 io-ops, so it would be nice to
> find common set of helpers to fix these exporters.

Yeah if this is just for softisp, then memfd + udmabuf is also what I was
about to suggest. Not just as a stopgap, but as the real official thing.

udmabuf does kinda allow you to pin memory, but we can easily fix that by
adding the right accounting and then either let mlock rlimits or cgroups
kernel memory limits enforce good behavior.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

