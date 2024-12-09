Return-Path: <linux-kernel+bounces-437264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2400B9E9103
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05681163B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833AE189B85;
	Mon,  9 Dec 2024 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCHOHbPG"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C18194A53
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741629; cv=none; b=D8F9peabxiqhOqN6WvKCqft4W8PhO0dmQnQZbT3UUWutz15WykteX0QoSUX3aD2eZrpRef27r3Rfo7XoTGaH2BeIbLES67iXJ5ymyPmawQG6YjoIelYvKSMAWRQsA1qzLs56Ke4JTW7DQ49doN3IcGgZjvaaweUgnn+1++b56yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741629; c=relaxed/simple;
	bh=VJe3OFxjYH/n+Js2Q+bcEVuEUQwrmmLqoqv/4AKrmog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaP+wMPcFULLIHeI+RaQ2PRdJ0dROfCKYeXm630ffhGeXKNG5XYwOWNkrL99eSC9HNt8g/Ty1DadH87CVXpVAdcvytnKmWmIYIiUWf1HC1qM7ULlpQdMBgawAfJYD7E/k8y7Hu14Cqg4SobHXF0QPLSe/rw7XqjM27jFkWYAqr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zCHOHbPG; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3003e203acaso17666701fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741626; x=1734346426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuxxa4msj7g+VEGAF/7cr8B8QGdlor53ZC2L8A5c7uk=;
        b=zCHOHbPG6r7bWn4j42EHdJy6zU0JjyXHf4N0AwyVP9tAJsibwe3R+kSCPNuJKpx7JI
         v03X6DoKASeuYHVnqoBLeJIhaoC7aZpGG6Z5N/aP1LRewijie4A+g4Hz0cueRsZQaE/D
         gU8mQLbTvBc5vW+lqIpkytIsB5tPnQOr2VzJjREGKokqjMA+XongMhw07vhF274MSUPx
         mg6uTveUHOdjeRv79CsIzC5sRLoJlWVCpfXJP6K1XST0AH1YthBB7yY7cxYLSGCeDmgk
         SiTnTAk84sDNS21Rtok962vNrlpkw1dii0GEVj+w7lfdLGpKxfmm43BnYrrUDWHSP931
         qFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741626; x=1734346426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuxxa4msj7g+VEGAF/7cr8B8QGdlor53ZC2L8A5c7uk=;
        b=NI8/Ih0YVSCae87Te0c1762ZDyRSNIAZbSP0rkwz2fOfhZcd8vrr7Sw6/5+ozjse7P
         lTLGG8YbIk323tNfVxVe/fj8q9l7NpoBbEps0ShgLQcaeuGnfyTW28gLBPRX6QwrwvQH
         QSried1CboCrRr9OtxG062wYYnvF8o8vGUxYnd/kDXHlGhMMjTIu/4QwfUbSHTzz8y94
         xU5OKPNYvsH+SxCcz3hOM328InICn0xE2Yqut/DBv6N/e27lmBMA+APGzF/rUEYOe9BD
         QuZEeo7KZ6bXddeQsbSq4+3BXQOpg6Sdm+EsKTIjMf0PUY6bRahT4au422w5SIp/kGfV
         gNjw==
X-Forwarded-Encrypted: i=1; AJvYcCX3PfHBelvNpgB5BZyk23RJoA5GzsTZE6jRGGyfIeAtmKnYBaEpC40qSqMMDVl9Zy0QANxN/WLTfG17cEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvDqcXmPZ6n8HV8+4sm/EtHFjulBjwIbAnKMiP+wBxx8nlP47
	yp4FvCz1Xv64X74pZ3qHc16KaXkNE6inuBSkDB3IDCR9kcMM96MAmze8o52SWxY=
X-Gm-Gg: ASbGncvRXNj7ZJ9I31XmwU0CmQJlZVCndIYcFkRV/vNk/R8zXZ61iEcKxCgp8gICCol
	xFh27ghb7L1K3iWOsmLMQ/xBt9YO8h6y8lhMZTn4CY/QSZJSPjpuCuClV8L5z9wk8B4RTcqvauz
	vgMJ+M4fGqmC90H47HKEE/JCgviMz6gNkZ74i0RoCPV5hhjK30t5LmCKqX4Us6m0cQ6h13Ccou3
	mxx2E/cIZT0AG0GOs2VZ71z4tkMhUDiZtzfF+LxrYzIo0Lek7DnAKJOoKfEC46tOeyAd3XeYGDR
	TZTrQ4s+ECXr9Obt4B6kg4ug8kuPaQ==
X-Google-Smtp-Source: AGHT+IGt7OXGzTL0fiwZIjrAOU2/hihahldE2uGCnpjjBi748Y2s+MaTsaJJHjw3nMeqmjGyZAEh5A==
X-Received: by 2002:a2e:a595:0:b0:300:3a15:8f2a with SMTP id 38308e7fff4ca-3003a159395mr31671461fa.2.1733741626366;
        Mon, 09 Dec 2024 02:53:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-302226fe9e5sm2863291fa.0.2024.12.09.02.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:53:45 -0800 (PST)
Date: Mon, 9 Dec 2024 12:53:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naman Jain <quic_namajain@quicinc.com>
Subject: Re: [PATCH v2 1/2] nvmem: qfprom: Ensure access to qfprom is word
 aligned
Message-ID: <plemc4swba7ybrncyxt3axxpb3qjbdktfkt7kqt3dqymlusfpq@sfgwakjp7z3g>
References: <20241027-sar2130p-nvmem-v2-0-743c1271bf2d@linaro.org>
 <20241027-sar2130p-nvmem-v2-1-743c1271bf2d@linaro.org>
 <60068361-ddb7-4906-84ca-195e5eb13a0f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60068361-ddb7-4906-84ca-195e5eb13a0f@linaro.org>

On Mon, Dec 09, 2024 at 09:55:14AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 26/10/2024 23:42, Dmitry Baryshkov wrote:
> > From: Naman Jain <quic_namajain@quicinc.com>
> > 
> > Add logic for alignment of address for reading in qfprom driver to avoid
> > NOC error issues due to unaligned access. The problem manifests on the
> > SAR2130P platform, but in msm-5.x kernels the fix is applied
> 
> Is this only issue with SAR2130P?

I don't know. I know that it manifests on SAR2130P, but in the vendor
kernels the fix is applied to all the platforms.

> 
> > uncoditionally. Follow this approach and uncoditionally perform aligned
> > reads.
> 
> If there is a need of having proper register alignment this should go as
> part of the nvmem_config->stride and word_size configuration and not in
> reg_read callbacks.

Thanks, I'll explore that option. Indeed, it might be easier to handle.

-- 
With best wishes
Dmitry

