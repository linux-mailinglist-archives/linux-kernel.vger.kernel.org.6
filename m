Return-Path: <linux-kernel+bounces-547728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF333A50CB4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196CE3AC84E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917825486B;
	Wed,  5 Mar 2025 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7pEL6Wg"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27BF1547E9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207517; cv=none; b=CPGCA3S1PbuJvgBytffQze1gapB3FO9GBn2o9kGl5EcAffMBL9N+2yukz5pjY/mgJUZu5fEizwNRCwEulihZxKx+DL/s9gBrQCLeeQ+2lEhuM6bNwJseRgh2yPHLSwqxmaoNs755ntty+PCaHUkH8P7SQE8zCXUAVD0aO3Ip67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207517; c=relaxed/simple;
	bh=nWSgmYzbJW9vIQuFfEEpG7niuQ/1DEtdvz2zxSKIHLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGZMHQgpcGYRlEURydzI7L4QU2Ak1ErTsOlMQYsCMPsBZdQv0ZaKrVPkwjTn9d3TwG7lEIHsprEsJfCOsHHWIxjp5KCwWVRxeSQ6nq+yT9HwOLW4w5RYcl72AY5cqTeAK4Lwf6uWvxETzdKiTw1suYZXuA50iJanep7x4i8F1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V7pEL6Wg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54973b49353so2869577e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741207514; x=1741812314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs41APiWQyzW6ccELRrCzvUoQL91nTx9GiNFwDYjQSc=;
        b=V7pEL6WgMTYHnuAR0h+sh3qUDgxvggKq00UEaldaTBLB8C7SHGkarLa1do/H0R1jC1
         A21XH23DG/uhCoGhF3cwJsAcvjTMXLKUWzPgDjgeJpF0y8c5oJJrDXrva4Oad/s2qc8F
         qzMBZ6eMDBQQgnhGo4IcQ4VXda5G9XWq0m7AlMDh5fpT1ILcY8wzPSP3NJpkXKgJCAMJ
         C8LJfEQS5YB3n7aLDtpJAMrKd7zSczdvmDMC10kyCrYTuTh5dmcQdOZpKd/urE7dV8Az
         clOPKKzct/DbNpnHtKwQVDPmDqeK7S+jpcZh7l3BvFXW6kYEjwCOz1x1w6Nt2quPTlwu
         1aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741207514; x=1741812314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs41APiWQyzW6ccELRrCzvUoQL91nTx9GiNFwDYjQSc=;
        b=ArUiseYDDYT0OpBxDEFz11NCneEPCVwn9gesZzm95oPYgCiShFkmFd5409+o9cVXIM
         YTiZOnmNqHC/SOxw/Q5kK48C0i1v6qcvCpX08WvKdSGNPI7xmom/KKfIpvnQvgPfLfGo
         ci2msuoPwMk2rp99MDn75roGnvujwIAgMcU9qteqJqi8b8XLA7FlH8GkFGxXdrt0be9M
         189ndO3sldVI7sT5+lzqgXpvsK25/svCoL/GQcFxKlyO2oA+dkdwKeLIPxiSlCRlfL6s
         nm1OwnGrs/2blubYdzt0OTC/MDYmrCdktWp7xjCawKHKmetHkczzBHh/tabST+Ue+tF6
         bHEg==
X-Forwarded-Encrypted: i=1; AJvYcCUhjad0dDllOUXCEV5LDtL/QHVoPeTpFYhbaYNtUOmItcsrhcE6izsuAZUGgyaVb/sMmru28ni3SpIhsEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTBrRQw5pUL1afXrcDUkJGwCTNFJIu4SN38+5LClIz3BGwZd/
	rJUoaG4B1tB76x3OR6HUuUEtQzDBWzr9yo32eQe9mh4MY9vPZXtfS3OhNGhlTJw=
X-Gm-Gg: ASbGncsiyX0hJ60ra3zsrSSerybT1P8PdeNKViVmkG7C1QO+8Q0uSpPQ8URgOWk6hxg
	56o6TtccKt0GbYWMJEiuSQldgCEWrX85OTrgwrp+Gz6NINredE3gxjr0fuH4WyC0h/Gs/5zT3ml
	DuwJVeyimdCOlg386zpaD0HIajfxlrsfJeOzQCuR9FY4TMcc9jeQTViDdFejSxYTadZSzGV90g3
	aNdK0qiTCcz9U7XsSx93+yhrHdhVy3rhX8IzH1NDSrdO3MnkHx/zcC2q1rVsbmRZ1Iw6Fv7O2qs
	Y1/6/Klr6jUxGWTlUOBZBdavkkp6oR+akMvV184NQHNyqkG/43I5JMxMiTWHQq94K1IcKQgMbbw
	B8ifdGv45LgY9293Ua7S52CQQ
X-Google-Smtp-Source: AGHT+IGEJt60WIoLMZBtifEB5R8NijD0rs7fn4MENGnhwex5vMpmDDUEO73YQjGoPnubG3s5tux5jg==
X-Received: by 2002:a05:6512:158a:b0:545:17d:f96b with SMTP id 2adb3069b0e04-5497d336139mr1696933e87.14.1741207513742;
        Wed, 05 Mar 2025 12:45:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495e1a7304sm1199597e87.216.2025.03.05.12.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:45:12 -0800 (PST)
Date: Wed, 5 Mar 2025 22:45:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: quic_vgarodia@quicinc.com, quic_abhinavk@quicinc.com, 
	mchehab@kernel.org, hverkuil@xs4all.nl, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/12] media: iris: Update CAPTURE format info based
 on OUTPUT format
Message-ID: <zw42tgyhxedcifrad5i2gam5sbjjczcaopv4iy2fy5hckkjdsj@crawjvp7bdox>
References: <20250305104335.3629945-1-quic_dikshita@quicinc.com>
 <20250305104335.3629945-7-quic_dikshita@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305104335.3629945-7-quic_dikshita@quicinc.com>

On Wed, Mar 05, 2025 at 04:13:29PM +0530, Dikshita Agarwal wrote:
> Update the width, height and buffer size of CAPTURE based on the
> resolution set to OUTPUT via VIDIOC_S_FMT. This is required to set the
> updated capture resolution to firmware when S_FMT is called only for
> OUTPUT.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vdec.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

This also looks like a fix, so Fixes, cc:stable, move to the top.

-- 
With best wishes
Dmitry

