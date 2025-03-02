Return-Path: <linux-kernel+bounces-540717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96320A4B428
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9E016B584
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8081EB5DD;
	Sun,  2 Mar 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHSKZRXJ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C91EB5D7
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740940993; cv=none; b=eLY4nst9RuGVcgvTOjqXyRzCJ/MiJ7G0Ck9LWlpC13UmCbG97SkIyFm1Mw/USbulV+eJy6QV/w4PXiP8LrovHU6XAPWptVp8779ZQXhXW3g/NWUnqk+F/hredfQ5sEF33q30wfDzQ+SLcT/sdadDcindCz+Z8ST4+QB5KtthGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740940993; c=relaxed/simple;
	bh=+H1JYRsmzoPrlN0IZH2KXuNuKiNSEAFuP+sgrI0/RtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjyGhSWJShAjwCnWWvadUfS//CxhAkqggCXoOIQGMzGjrFAurNPib/hkZeXzswqYEf84QwmgcAg2ThtkO9tSpZ3VGyYuwPw166IdeyrVyjd1YHrRu0Xn8/S0ybWgHsw/NsRgsRhKOweMStMTtor3ayrGo+IFUAMZaMQqIGI/nQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xHSKZRXJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bbc83fc35so2214471fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740940988; x=1741545788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYfSZwjrk1wuwLyH83CewpZux6QazFFyjHhdeIqoGk0=;
        b=xHSKZRXJmjxn4HtvvUvqGeQ3d5UkVE4L2yO2HyRj9rBsz9uRxhFKfXP094NjQPckcZ
         g4cJNRAjO3RmQZL9XMrNqP2VavpOcqVHM0JDkc37E089owDZM5GhbB0jZ8S/MTRI72FK
         qMxQnPZicawaODzDBql/UUr33T4B3dNiKZQMSJ3Ix5zG6Vx2UoH+tbC9jZfTd8k8emJC
         cj6dV/wcHGnXOUf9GT/94+gAWp3FecbemdSpgjlLI39L54uFLvJ68LcrRHaLkMsaAQXk
         C2Je81kM3X2WkAr68jAX7Mu5sU0guaW1p4bWVVrbmqXPN34Ge3/hxWKUaItxjE7iDBp0
         D7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740940988; x=1741545788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYfSZwjrk1wuwLyH83CewpZux6QazFFyjHhdeIqoGk0=;
        b=HTr6vo/q2cuS2wbA+5rGM/btRRR21Ro4WuU/fQrFWnkDIUZJiOemWE5r7C/RSn/CKM
         O+YKPbVnR0mpjedmUAx6miNMSnacwnOFl2mJ+13pn/vOD8U+1YoZen8AGhJ5d/ENORmH
         NYanUpX8SXyDaSjbrH9STcbr2a1sg+uMskPfkNAEryeWorkn5GCgE0oROZBOv7u8MiE4
         P9tb3SkGCHkarOMklDNRsRYQ9g6HEyjsrW5L1ln7qsFFCI3q+iANcUrGqbNaQyl5F870
         yTJjwv4exdQfPGRrdN6tsi2XWFAO4QM1J+1vUFgUhyeyH/ebDS3OSTlwekqs2QQ7xpYC
         vLZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDCRzHBsT4k8Li9BMmwnJuNb38bHYkF4Wr8Lsp5zZnv7i9YI1BMv/J0aQJ303Kn0IeOt48mcc8wQCMczE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvK8WZPCKXrtIut6sn1Nx78vBVuDhpA2NzizgFfvCw63aZJJ/h
	WQYr57Ep9IDI47zx3D83SrOpA2b6paGeETUMNvbBtNJq3hDh8hiJYgk596ORp2E=
X-Gm-Gg: ASbGncsUeV83PYJClfFWVJsoH5WcKLOEZQW1OHl2OjXdfvxRT8/ZnL1ulstYh4Z8Pc+
	JHA17SSoskfHQye/JWk9qp2vkGq7iZhRm2ATbpj1pzsk6fQjBRfe7xf9mG9SddYjwBnTMPPxWVQ
	W02nMNyzWHbqiLFMBcSsxoZrLfzV3JAMRhYxzMz1dbSzr8dHmE+Ge6SlO9zkazFBhS2hcOe5M/L
	Uss6yJZOOZyOgcbuhOqzAxdMKyeP8DL8nDpqy5FherlPndYRxCz672ZAksVjfDzejssBog0LOhJ
	2csKBkefl1zE3GM5qv7U/59c7MtuQwYKuGzumARjfS6xGYjdGKfZbQ7RKPccJOaEjNbY/weHtA8
	uxZ5DsR0+AxmfljPDI0g3p+4F
X-Google-Smtp-Source: AGHT+IEYTGmoWgInNdncfhUdNvmlzFmlOJQaw/FJcWHC4CdZnaQ0MmPAPvQbmmMMOiLgnNAPW8hDoA==
X-Received: by 2002:a2e:a4b9:0:b0:30b:919e:3021 with SMTP id 38308e7fff4ca-30b919e30aamr32112101fa.10.1740940988464;
        Sun, 02 Mar 2025 10:43:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bbf2927a3sm347551fa.1.2025.03.02.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 10:43:07 -0800 (PST)
Date: Sun, 2 Mar 2025 20:43:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andersson@kernel.org, Michael.Srba@seznam.cz, konradybcio@kernel.org, 
	jeffrey.l.hugo@gmail.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] bus: qcom-ssc-block-bus: Remove some duplicated
 iounmap() calls
Message-ID: <keric3hixhjbxscdtqbgbi66lz5oklj7dunhfbmmtscjlmjykd@6ud3faz63pvz>
References: <cover.1740932040.git.christophe.jaillet@wanadoo.fr>
 <efd06711b126e761a06eb5ef82daf9ad4e116a10.1740932040.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd06711b126e761a06eb5ef82daf9ad4e116a10.1740932040.git.christophe.jaillet@wanadoo.fr>

On Sun, Mar 02, 2025 at 05:21:34PM +0100, Christophe JAILLET wrote:
> reg_mpm_sscaon_config[01] are allocated with devm_ioremap_resource(). So,
> they will be unmapped automatically by the manage resource framework.
> 
> Remove the incorrect explicit iounmap() calls from the remove function.
> 
> Fixes: 97d485edc1d9 ("bus: add driver for initializing the SSC bus on (some) qcom SoCs")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/bus/qcom-ssc-block-bus.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

