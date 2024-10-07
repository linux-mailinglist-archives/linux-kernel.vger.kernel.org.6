Return-Path: <linux-kernel+bounces-353946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D349934F4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC167284321
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8420D1DD88A;
	Mon,  7 Oct 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aq8V/GRl"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583CB1DD55E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321984; cv=none; b=BJdX1jI1QWC6vFj9FzByrDmj+T2Rn3AY8a1bZbbreGGazhvv+fv1uKiOraT6OR/46vKSW2Kta6vqesWT4gvOTRnWr6CjtrgMbgzy+wUxB70BQULRLe2wM4e22pVeKLnDNIR4JyvJ1Z4lHS7BiyFzMNaKiwEO/a27Law66uPwa3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321984; c=relaxed/simple;
	bh=pCCoHi+FSmdP+JsIamKw/AdhMR0e1YaCdPeHGA3r6A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu7iqzanU0KrMFECpOrb79GI9VaDquM4GkhK8as7tw49WprfueZa0859n3fVcx+ACb1iH1vh4oGQHgCcf2JLsQ4V3FJ7cwAiTx40h6yeviw6K0YznwFWNz8bltsx8F+bLrc2g2TQachuCZ0Ht265sz6iJOD2SDg2PkfyLZdfIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aq8V/GRl; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53991d05416so5578368e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728321980; x=1728926780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlsFqoWgQcVSzxUESq0jNu0AYxuz/E7zW/qrfaTVXzo=;
        b=aq8V/GRlLSworw4+hJ4OWnXQxvjk3cgkyh190qvxNG2p0qHOiIks9T7rzEScVyFfRu
         fmN2n868dtdJQvKChpozv2K0XoojmubId/lZgUF47uFlKcxiBLqvdOYEB9JI/m4ZkmBH
         VmCMjhTE02yLg4IuNY4H7oVe2CLi1qJD/WBOywKV6rqf8iK3ZfrBoCJwrQVPokGJGqLh
         EJPTjSvsu8aZnHoLIuS7RwMRhGLmJCo54hPF/l9fEDOjglv/6jk2LWNelNIyz1FITlPW
         3aaPbnBv0BKrBpHAmWM/YiX34GSev5bOGmFQbGqaucZNBTCUGFhbrNrL0KDb2u5ZMwPb
         52Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321980; x=1728926780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlsFqoWgQcVSzxUESq0jNu0AYxuz/E7zW/qrfaTVXzo=;
        b=qb0Ki32jaBzHIMJkiB1b1hHj7ohlijKCzP8+aQ1wcAM3RsYRSOgOrtTmpydtCbzQXR
         59gjm/R1iVDYj+qMXKOlpkNxoYSyLy7vGVW6u7Bv56/4kh3bstKLS5dsLPmLkTgLLuAG
         pYnwIt9GUFLBWtHfKiSjn8Z6EtVT3xut0VzBjbLYLpt8CSKdRvJ2vTlE+JTRjoNrpJGl
         6hNoZpd06TkUyu4xHs8aP2dOn32k0TiQ8hcL/XZFpqKyvJtcMRok6kNBfeWY7pHZGJyM
         ML/wUbLMb9rwTcN05zyuhmFvYS69OiqXVupR1So/0oVyV176VM3s5PM0J0nbo0P4ImKZ
         pYrA==
X-Forwarded-Encrypted: i=1; AJvYcCX8lGzrhiKI9AZzPZDJ8EUedbGJrgqSdy9TIPLxPHkZlSePBDytJqP1GZ7uApeDo70mPVkQk9IMGYJPUuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxamqPPsApHGjmh93DN9s/HZYlkDry2VeCKcGSCCNpsQiZWi3l8
	55WE7X3eUSqcuZUp1AX1n+bRXxYwZ7srqhH2glEzdtYix2f7Osvl9UQznCvhmdg=
X-Google-Smtp-Source: AGHT+IFqkmB5EGBLDvkk9w/73LJ1moyAI2DINnegAoUXrSgjT1r9zBJuBEvu/G0C84vFxPAg3A5H/w==
X-Received: by 2002:a05:6512:159d:b0:530:b773:b4ce with SMTP id 2adb3069b0e04-539ab87ddd9mr7298174e87.33.1728321980533;
        Mon, 07 Oct 2024 10:26:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec0f91sm907565e87.36.2024.10.07.10.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:26:19 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:26:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Karl Chan <exxxxkc@getgoogleoff.me>
Cc: linux-arm-msm@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 4/5] pinctrl: qcom: ipq5018: allow it to be bulid on
 arm32
Message-ID: <m5tfcqfr35dzeidxqtrxzk454itrlf3dt5u6mezouzievjzlx3@ymkl3qdf72ob>
References: <20241007163414.32458-1-exxxxkc@getgoogleoff.me>
 <20241007163414.32458-5-exxxxkc@getgoogleoff.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007163414.32458-5-exxxxkc@getgoogleoff.me>

On Tue, Oct 08, 2024 at 12:34:13AM GMT, Karl Chan wrote:
> There are some ipq5018 based device's firmware only can able to boot
> arm32 but the pinctrl driver dont allow it to be compiled on
> arm32.Therefore this patch needed for those devices.

The same comment:


if there is another revision of the series for whatever reason,

s/this patch needed for those devices/allow GCC for IPQ5018 to be
selected when building ARM32 kernel/


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
> ---
>  drivers/pinctrl/qcom/Kconfig.msm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry

