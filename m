Return-Path: <linux-kernel+bounces-395463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F09BBE33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F27F1F21EBE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA211CC899;
	Mon,  4 Nov 2024 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmfPBbWV"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41061CBE84
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749387; cv=none; b=QQ5yPcq3J8gqdG+SjagyK950PC3Z1RBs/fYWXcl4Tmk2EDLzo+LpnN+hoERoul2OjBlHYwhmJQesXVxG3sxW9gtvaedPaR5MdvD41J/5F3GeGScV37Xf+FMLwCZZvxCh2TyxgduZ+NX76A0ZwCR0e40kBgGZYh+EHkmciTq7gHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749387; c=relaxed/simple;
	bh=8uG7NxRiDTkmNi/k3Lc393uYuyIs9n9TqQj13yylhtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrbZQzLxK1u2byzwufaZahSKwbxw3v1Ne5UtH5+cpLIRvhj5KoMT+Vh3hXe/YHxv+xB2tDZEHjcNbxayna9TjIZ/nm/Fha4zTy4mkzuRGHGjIf9+3Hf+r2Fc8uQKTQzAT47K4hpE6HIPcrwbo5O5WGFmbyvO0sZuOizEwu26suI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VmfPBbWV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539fe02c386so4980149e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730749384; x=1731354184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1sFhrTq8uXHX1JSiq0qHtdmt7NVWrhKHjYOI9pukmc=;
        b=VmfPBbWV+Y7kJjDJauKgm8FESToE5jP/5szRxkDqZ+rNlVpx4AqL4iuUI1NjzCx58t
         czoDJsC1PfOAIEg3l/p0wrzlcb9IZ8I+1Bs0Nd6yop0YdnU/DBhh0++YGr3zBWrCaggE
         Mp5gZe9JiUryM+umH6x2oFkpsJPgXEJmNv1+odvpRJmBJu8eczvJlk0K44s+/APcEjW3
         vGPq/YT3XAKjLreyiTO9pFBagXcLRg1FWowetkTB4ianJ6eQev6Y3tHD/OWf+Np+Xzy+
         N/Ec+GBxlWQWt76Eb+Aawfp02rBaEeRnkZhmhd5vtcEmXR4t1IJUoI9S0E5VNlHfSbhB
         Urtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730749384; x=1731354184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1sFhrTq8uXHX1JSiq0qHtdmt7NVWrhKHjYOI9pukmc=;
        b=ES6etmuP9CiCBCOzv1Z7FyQAg3MgwRi4IB2lo6eKzAyo3iXs3+JGIb7hjxck4SMoTm
         ZxYDGFydiAWH1ayxkDuFtJAzBG8J9wH7vsF35XgXXQqCzBw+5xaj8i5F5Ga8as7aZOsg
         RrDlt0igKs2UxJ2SGnxcqvMvxPJH8k8kUVdHnbGxW8AVGx1qa5J20ymubtkLiF/+SQTT
         OxCu6AiS552he4eJMpf1EowXcwNA7kaKKH4qiLvdKPycQ1yRIH7FqtQQt0L43ibkFhil
         w1BxWAa0AD9ushx8lbb8GLBmlWC/A2LlawVQR32NnEX5TqA00NO4XGP78HgkjgC2FS4E
         54Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWRfAtKGsEQ0Y5nhf7GsO6gWkZVjFKOAe/7kfZ8ECrNi27fwMShLEUoIHFapLXXrcGr6BlhNk/rRonvKxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylzLS8uxVNhoXvnBW0Nc715QkT5JfwlKGIrW2Qzy8Y3Bi5tqUs
	mEmSkWGpmhhSpgw8g3/dNN5Q3rVhhnpQj0ZhenMVMc59Wv2tyzKK1TbRgm6vWEo=
X-Google-Smtp-Source: AGHT+IFZD2ro3n38RZgJEeButltGS7jnHlfd1LciHrIxyNlhnIpQcrJDRg1Oac/Uo3ZixI3UAEfGBQ==
X-Received: by 2002:a05:6512:3ba4:b0:539:fde9:4bca with SMTP id 2adb3069b0e04-53d65dc727amr4209246e87.29.1730749384058;
        Mon, 04 Nov 2024 11:43:04 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdd03casm1831187e87.242.2024.11.04.11.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:43:02 -0800 (PST)
Date: Mon, 4 Nov 2024 21:43:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: qcom: scm: rework QSEECOM allowlist
Message-ID: <4iogtv4wqrvq54c2jqryrtivamn7ymz7alxkwmlfnrywli5v63@axjojnidvn3n>
References: <20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org>
 <20241103-rework-qseecom-v1-2-1d75d4eedc1e@linaro.org>
 <02171841-acd3-4f26-987d-1376caf11481@oss.qualcomm.com>
 <Zyi67e5Os0RhXNjn@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyi67e5Os0RhXNjn@hovoldconsulting.com>

On Mon, Nov 04, 2024 at 01:15:41PM +0100, Johan Hovold wrote:
> On Mon, Nov 04, 2024 at 12:23:57PM +0100, Konrad Dybcio wrote:
> > On 3.11.2024 4:37 PM, Dmitry Baryshkov wrote:
> 
> > >  static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
> > > -	{ .compatible = "dell,xps13-9345" },
> > > -	{ .compatible = "lenovo,flex-5g" },
> > > -	{ .compatible = "lenovo,thinkpad-t14s" },
> > > -	{ .compatible = "lenovo,thinkpad-x13s", },
> > > -	{ .compatible = "lenovo,yoga-slim7x" },
> > > -	{ .compatible = "microsoft,arcata", },
> > > -	{ .compatible = "microsoft,romulus13", },
> > > -	{ .compatible = "microsoft,romulus15", },
> > > -	{ .compatible = "qcom,sc8180x-primus" },
> > > -	{ .compatible = "qcom,x1e80100-crd" },
> > > -	{ .compatible = "qcom,x1e80100-qcp" },
> > > +	{ .compatible = "qcom,sc8180x", .data = (void *)true },
> > > +	{ .compatible = "qcom,sc8280xp", .data = (void *)true },
> > > +	{ .compatible = "qcom,x1e80100", .data = (void *)true },
> > >  	{ }
> > >  };
> > 
> > + Steev I think you had some unhappy machine
> > 
> > And maybe 8180 Primus?
> 
> I have a sc8280xp crd here where variables can only be read, not stored
> (e.g. similar to the Lenovo Yoga C630). In it's current configuration
> the machine boots from UFS and this could possibly be related to how it
> has been provisioned, but this is the reason why "qcom,sc8280xp-crd" is
> not already in the above list.

Ok, so we need to add RO support first. Good point (that was pending for
c630 too, as you remember).

-- 
With best wishes
Dmitry

