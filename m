Return-Path: <linux-kernel+bounces-173875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8598C0717
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314CC1F236B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209313328E;
	Wed,  8 May 2024 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ffkh6TDt"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E2D530
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205866; cv=none; b=JI7KYJp2kZYZwD5WT66i6ovwMV08aGAc9kVXPM8yOBYq25Sz97L0/XuTCVNTRfHUU00p/NzMv8mVeTaTV5ZTGoFJHIgNwm3N2gpIDYb9S34nk6BIVeiLOxeFY8OhKhJVFfE22XSLvGP7VL34RWis4FCT0HyQqnvusREu1ugw358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205866; c=relaxed/simple;
	bh=qhiu1ZoqjVzMKdpVSz+tH1AGO0ixzx1LZClfO6+1N8k=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg6yPLPC94NLHiXMYw83DzcHAAdbWNOHQMIKyHsORunShqRuq8EAZRPBbhzTHlMlhaz9q3VysBWX05at+utmrP1PYg+QIGMdB2kLC1ZvBhe9bXDHan52t4g89RjNASeDI65xFoCQhWxmVrBRjqHzgHJTcC9He4STlX60JOP7gvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ffkh6TDt; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc236729a2bso294907276.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715205863; x=1715810663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhiu1ZoqjVzMKdpVSz+tH1AGO0ixzx1LZClfO6+1N8k=;
        b=Ffkh6TDtNJxRiQzhkKqFgYKMDl8LaG1wF37URp2c9pcjhUftVdYOrwUxlosojIdCnW
         kfIm7Yez4o16DZTSjyObrs94dOfdm8gRKZmCR5xgjm97lH7a6fHKjZHQ0QwiPo+buL7+
         KWMOQwUgYEGXUtsMEUg0sxoveOELRlrxrT0Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715205863; x=1715810663;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhiu1ZoqjVzMKdpVSz+tH1AGO0ixzx1LZClfO6+1N8k=;
        b=IcnLbHTAR/BtDhdHlNxv4YPNoml4RBHrNhRJlhnLj/nbjmSUFyOJXX4RKulNOkBqou
         M9oebxPjNIzQTlsFoez70FpYxsNrpVHl5rbp0eNYPckUqBRq6PhOD/RQt4JaBNcp8yuC
         GkmJip6K3UMqZZ1tMFoysk38ED2bSMAtQINcmWB0A+fTDb+X8wde3GZS36+bVDxNVaFc
         Jt1ZqABE8ps0aBRaoUeWNA+fOwsFI2zCqflUSM+j76Sdn2S0Gsg3UYTZFj+JLv/Sug+Y
         rayinpuiCvoH4rM8BVY/R944BuM+u3y+3lmfwVW9wEA4QRk1rYJD5LurRVTlPD0e+aDj
         fQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZbWrhB78RkIgxUQJ6pD4oplD8OsI4u8OjH1vOqPT+guP0S02tATK7PJKS76ywDJOJTkrLdPYm47Maoea86iPW7NxAPl0NtYHaQUSV
X-Gm-Message-State: AOJu0YxUv/C/WuWJK9HRK7AHrTaUvhRVhTAdjLNseuH3A2AVUpbpRBqO
	aVbYQGdy23PGprgudIjCxiI02c+Hjq3AJZaiJLFIgGj02yh0tuyODGO4cfOU8eptdp1BiXPpbBt
	sO2BtLp6bNS/I24/pLoTNg5+TYxbh3n9Z6E6F
X-Google-Smtp-Source: AGHT+IGNx5y2BY9D4mJMH83J8PD0rFPl4R1+a2ILIuqwXXx76mZzGSaEjAzEBuASx0Sxf34guJveW0UaaWBsvsBJ1t0=
X-Received: by 2002:a25:3041:0:b0:dd1:7128:617b with SMTP id
 3f1490d57ef6-debb9dba556mr3866366276.38.1715205863085; Wed, 08 May 2024
 15:04:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 May 2024 15:04:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506150830.23709-7-johan+linaro@kernel.org>
References: <20240506150830.23709-1-johan+linaro@kernel.org> <20240506150830.23709-7-johan+linaro@kernel.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 8 May 2024 15:04:22 -0700
Message-ID: <CAE-0n51B+czEMznAqrwzGyUpK0960q-HZDVqTUprvRwwnXuerA@mail.gmail.com>
Subject: Re: [PATCH 06/13] mfd: pm8008: rename irq chip
To: Bjorn Andersson <andersson@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Mark Brown <broonie@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Satya Priya <quic_c_skakit@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Johan Hovold (2024-05-06 08:08:23)
> Drop the redundant "irq" suffix from the irq chip name.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

