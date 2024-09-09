Return-Path: <linux-kernel+bounces-321087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF097144B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8462847EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504861B3F18;
	Mon,  9 Sep 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzDiPhRp"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA01B3B34
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875236; cv=none; b=K+8nz/yQTlnmJDdkawaPjbXDD2eGx/r0/oWws6sbpsYGA2JDA7QuaXtHCsxaGK6FthphCdVZ3UEJzTs9Gu+ZvrlnbTChYLwB1N3mwMM34flW82WlcUTyvc1K07sxrOrZsN/mNZynYmx1PJ7Uz3VQZbdbXlYsxXCAEKnthjA+lPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875236; c=relaxed/simple;
	bh=n4M+GovN7tZhfg+mdxK6bHXPPX2EsrI3HZxhNQ1buqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTZVhhmtSwRtqU9TsMBVqxsnC9/dIK4iFDfvpmI6pH9bPYRxGGrRFqUBxPrqEH9uzTcQIT+utd6TqySccTqRcScQeSJs0hmfv7QQMllKZRuqznLzo0OCNCY2z9xfbFFzES2qcbeno4iRwMwsCdzunqHOpPLajj1YUIB27xJYzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CzDiPhRp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f761cfa5d8so15861061fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725875233; x=1726480033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAj1wvN+zxJHeEeDfh62ag2eR23Fcrip29/NVH4laPA=;
        b=CzDiPhRpruzs3scqGCBVKgoZQ7RzvKNsnCrzzHuEzu72TqXQP6DGQNKBOXPzF+NtNI
         BwC565ow9HN8I1O6tNnHtGHCY+bD0PGfOFaeUgxNtz5GUJlZbf9UWBh/dRDjGfyadpOf
         4MLzwJ6HeCYFFOlZyKwC02dWkx/r2j0bh00WLDwl2Q59CrYpzligsN/lAOpa3Y4AdqR8
         C0o23aBkR9gARJ4qoq9VEXNjnuVnjnGNnQNqm7Q5EDwEAFV/gnjkMXLFUtUk84Vc5Fnd
         wXyNzkSIdu7hh8tIfrjVkGITwZCzqHlNyZ4Ozd+MLucj8c16KVymodxsFau2DWuKCS4b
         1BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875233; x=1726480033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAj1wvN+zxJHeEeDfh62ag2eR23Fcrip29/NVH4laPA=;
        b=DYvJXHBSmn+51DPoETG+2gVUSobvsM+XpgQJWmlDZENUkjuZqJkmhdFZBnSSp2u+FP
         YeKZ9LI8oKv5QoCc2jk5yckLg4ggTVSvN2roPGsWSqs2jwQhfIiJJtoux58xabiYP96X
         agqTUC0QY7fpXOO9hhofyo63YTtdEaO0mXH3f+xZo3umbmrFyqQ5QnVtTCVszQkS4I8P
         tefKOZqxHiH/vhSp7QkrMhORFbHl7wwp3y+qFUxeX6egRCaeWghyPr7we14CPXXl/kRQ
         YNw8hnj7jV9jBA8bhUEo3sICZorB7Mx0l0YLG4X8CqD19zoD++V9+cuyDQfWzRBlM+NT
         CRyg==
X-Forwarded-Encrypted: i=1; AJvYcCVFXudskH36cTZidziE9kXF40XBVxRLund5TgWWcODEqv7jv0a8kuD/fsgbBD1t1rI7co32r9PodeNMi3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/jCMbSaZL5x4DRM6chMisb+coNGk+CIL9WtI1prYqKeJrkt3
	9eagBDAYRTIyjaTH5qMY9iIoEfq2qrYwwZVGbipvB3pU+55WIyK+AOEyefwlHWs=
X-Google-Smtp-Source: AGHT+IFZ64jJ5mD8lby7aJudxo1hABUCgb3NXgoVtTSzdGdQteWjQTiBrXa28ODVcj7A5bgcyzZiCg==
X-Received: by 2002:a05:651c:1991:b0:2ec:568e:336e with SMTP id 38308e7fff4ca-2f751eaee1bmr84195191fa.1.1725875232771;
        Mon, 09 Sep 2024 02:47:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75bfe817asm7501321fa.23.2024.09.09.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:47:12 -0700 (PDT)
Date: Mon, 9 Sep 2024 12:47:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, dianders@chromium.org, 
	vkoul@kernel.org, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] spi: geni-qcom: Fix incorrect free_irq() sequence
Message-ID: <kmpyep53hlqavoipgvkab3d3xkg5dt7olsflveemkdwkekiajn@s6xrdddwpnqi>
References: <20240909073141.951494-1-ruanjinjie@huawei.com>
 <20240909073141.951494-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909073141.951494-3-ruanjinjie@huawei.com>

On Mon, Sep 09, 2024 at 03:31:40PM GMT, Jinjie Ruan wrote:
> In spi_geni_remove(), the free_irq() sequence is different from that
> on the probe error path. And the IRQ will still remain and it's interrupt
> handler may use the dma channel after release dma channel and before free
> irq, which is not secure, fix it.
> 
> Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Rebased on the devm_pm_runtime_enable() patch.
> - Update the commit message.
> ---
>  drivers/spi/spi-geni-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This matches the code in spi_geni_probe().


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

