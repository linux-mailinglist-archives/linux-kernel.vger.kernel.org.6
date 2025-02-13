Return-Path: <linux-kernel+bounces-512821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EA3A33E21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21053AB096
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B909020125B;
	Thu, 13 Feb 2025 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw4DLVoU"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB620AF98;
	Thu, 13 Feb 2025 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446231; cv=none; b=iKUJ8HnZKgBgeJIEDU1vpC6LxCSdnKhG7eNNxFbpCkjTZPT8yYPpvKKHzkbSoe5o0jSelqaRDXOKytjsu8EE4UMvx32YTuO54iNSpVn/eypqwHt1d3zJTvj4Gi1mdbu1fVZaWhAEYfxIRt/gkYAwr0b2t3fqf/D3b0GUuZ+yOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446231; c=relaxed/simple;
	bh=1tL8tgoci3RMv08/Bt3HfoiI+a9Gh4up1triArlbQ4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KspTtBjZXLnEuCr5THU/bRXbCjizb1kFIKB1cgqxPhCq4FYAM/T6+8dtGId55HN+Pe5u2/b0zdg0X9qTjw6vVUtStadrWpKla7adyF1XZH2knWtyEhYPMx7HjRY3czuLq+ZhwXKD/HpLq4asOuJtOmZ589gkMqoMj3zvqLFoEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw4DLVoU; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e41e17645dso6913206d6.2;
        Thu, 13 Feb 2025 03:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739446228; x=1740051028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SU/TBSujegWTvHaxqKdEWl78O7aiUl1zKHXvdMyNQA=;
        b=bw4DLVoUixTvsQOnCbLOtiTrNY1qvWcmZ0EDx2hZ2qD7cNIyh4+rAW2G03EX29/RrJ
         j8BCl3llPPD+CesTU2N3OgJXZ+7c77trrtziCY1d80BHMBt1rosg80iBuReweMTCJiwF
         33VEpTMZD/Y9qr+D96YZBztnTpb7aI54dDUPKH/o3/0JaSuxMyn7YR9oILd/KR02QH+m
         PwqS+4o5EF5Y1atYQS9twPxBJBF4tglmzt+ie6cOCfdoynE4qJQPlchcTf61WeeJBbrE
         e9kbbwPk37KG7mFWHnZX1EHNihg8YX77xj+WKHG1wYduGnKE+CrQdiVdShivs3FxJMUm
         QVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446228; x=1740051028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SU/TBSujegWTvHaxqKdEWl78O7aiUl1zKHXvdMyNQA=;
        b=g91fdc7EgqezbpQi81ajkbU6nVXJhyaIykxkbsrLTDQMqS8PNTEdL6c7xuui8I2RUC
         qlRlndzy5safIzkJCKMjyTPg3PRz2/ixXf+LHbZRy/y2FnbGN7VxWY8zaBngZHWepxz6
         DvL5GVXsJKVxtIPSpahyLQL1SD8ycpOss/3bayEQL/hHJxyYIgz1wurKDDcVkVGqYxt7
         LnKxMMkyq//+tBCCxjfpxn89678djobgzyIC0RZ2Vqx8b8or+ODGU/kgJ78pn388Fyl6
         ZWTfiFngBLAC6nGSrHipzbIxzuThfC3PRT7C75P81q0t8i8Loil7PLYn5B/+CXszMegU
         5C/w==
X-Forwarded-Encrypted: i=1; AJvYcCVEdsI0gh878BYfWFv87UKDoba9t75GwZ3yDsh28fJ87P2ZJ1widfmmT/GogyH1tp7Nwea4ZTKqgwz9z1zv@vger.kernel.org, AJvYcCVWZTzTrrmIQ6vKVoGiRypgcKsOJtmyLsnY+WdkfyLzwtJH5ZGDtMJBa2pPTcI8jcTkzKdlWnUQk+fH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6pGWjF/4Nra/M6wv0zafI8BIFJHumgxUbCumy3LWssjhtODlq
	oOQ96gyPb0j+42+0Pl/eTgPiz/o0290A0z4o7zZqGxbRIyStwY+K/mKphQ==
X-Gm-Gg: ASbGnctqGN/WQLw0UL56WHrF0aWCDgIoWlVbjkkIZtJJBovR2vnRdwxoyj21x9xAyYt
	yB7JcDpJRWSc3xstkYNdDmg5MypzcNfvO+w+T6m6HeNhiyamcNP8bhSlATW9KHC43XERu6aVCl0
	UWmNzyD2oDfmQ6Xz0TyevlWuVGTofxGM03TyGwbhDIZR0r56Ex2M3YRKqq474abgqpfT3rdK2TY
	NZWHvpyf3oSVN8AdoGg70eedNASRnAfqbizpSNCX7KP7Y7mF607sr4nHSAkLalJM3c=
X-Google-Smtp-Source: AGHT+IFQo684UKQQw1zozEcjISvHMyMr/bRuDRMBvz25ZEQiXj7LUIrkvbXFjlOZRa8EGwkbsJlG7w==
X-Received: by 2002:a05:6214:2aa2:b0:6e0:ad33:36c with SMTP id 6a1803df08f44-6e46ed77a8fmr112510006d6.2.1739446228388;
        Thu, 13 Feb 2025 03:30:28 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d7a3d2esm8068856d6.55.2025.02.13.03.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:30:27 -0800 (PST)
Date: Thu, 13 Feb 2025 19:30:19 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/4] reset: simple: add support generic reset-simple
 device
Message-ID: <lrbpay37sn6jfclfaozauqxp76wy6w4uft3a4arhpmluhi4kq4@6bev4gj56sdn>
References: <20250213020900.745551-1-inochiama@gmail.com>
 <20250213020900.745551-3-inochiama@gmail.com>
 <20250213-laughing-oarfish-of-opportunity-a575c5@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-laughing-oarfish-of-opportunity-a575c5@krzk-bin>

On Thu, Feb 13, 2025 at 10:36:14AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Feb 13, 2025 at 10:08:55AM +0800, Inochi Amaoto wrote:
> > Add support for generic bit reset device.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/reset/reset-simple.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> > index 276067839830..a24f8fcc6a06 100644
> > --- a/drivers/reset/reset-simple.c
> > +++ b/drivers/reset/reset-simple.c
> > @@ -148,6 +148,9 @@ static const struct of_device_id reset_simple_dt_ids[] = {
> >  		.data = &reset_simple_active_low },
> >  	{ .compatible = "brcm,bcm4908-misc-pcie-reset",
> >  		.data = &reset_simple_active_low },
> > +	{ .compatible = "reset-simple-high" },
> > +	{ .compatible = "reset-simple-low",
> > +		.data = &reset_simple_active_low },
> 
> So what is the point of the binding?
> 

I wanted to add these comptaibles as a base to avoid adding
too many compatible in driver.

Regards,
Inochi


