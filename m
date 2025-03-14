Return-Path: <linux-kernel+bounces-561283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E50A60F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88AA1899BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072281FDA6B;
	Fri, 14 Mar 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m6hG0Loi"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE01F3B94
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950553; cv=none; b=Mw+pvIY9ixrGaQKoUlj6aUU+vOId+6RZuYNd/35a9/hRUtn8a1sBgI4Wqgt1NUNvuYaXGWyWnSGf1k2NaY4WMvnNJeWD+Ropf6g/dTXQd23GbwxNMiaj/dIYOL99/JhdFS5mYK0mQOUvyqcu0enXfmdzFFS3b+QkcjzHPRRDh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950553; c=relaxed/simple;
	bh=MAwD1GtRtdpg0DZzKIDlnqc2cR1boIHlvN2IYDSCjM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx/rmd9sC0yxhC55VdkSUV2sxaPT82eAzaYykcQmymIhqUTi0IM3531GSjgE4U0LRZSjkApDdz+ntS5+92qNGc7P5NLrAv00pA67O3SPV+GRFGwW3le5YduJG4YG8hGOVgag8j0Vm5WQV50rdESSRRjjtO+22PNteMWp3NT9JWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m6hG0Loi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5499da759e8so3346676e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741950550; x=1742555350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAwD1GtRtdpg0DZzKIDlnqc2cR1boIHlvN2IYDSCjM8=;
        b=m6hG0LoilCMzzgojzMDVf6zenpvMylGBfpavXWHCQdef7eY55MPvFJCssroITc8Ye7
         6GgIY4Br+E8GfbKyh4ciZ2dicFsLugUrgCZeyeGpxzZh+F8tGEF6u3QZqikjjllJChyU
         +PcnxoPTEfPJMUXCAIbK8okZIwqbdw8j93cgqRs5POWZPZu4C0L5SXWN/jRzYlanUuUk
         V++xXzwn9LzjDxFHd1zxrSYMSqQEh11CViOorklVWHALYIY5FoY4n6C2fb6OITfdQShZ
         jI2UKloN5gRZUJQoE2TfxKe2SPSUnIsCnTLIfHT4q8/Cx0IYPlJDG8ndLx66FPrya9yJ
         xfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741950550; x=1742555350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAwD1GtRtdpg0DZzKIDlnqc2cR1boIHlvN2IYDSCjM8=;
        b=l8d9zIy1uwu6YgZZmGvpw0C0Ek2qqBs4Uqgq9dvQQ9aPCMi5rKlSL9jOxLA+6fpwt8
         AEn84YdsIjsM2tacIR9GsP3V0W2bdKyilRzh9hxlsMtDKNL61DqvFCRpDB0zGZ5jhD+Q
         G4ZNnHhDF2PT/veZc5Di13xJznaEYfGk/KLPGUXKEJYhKJMFZ7a8kmrjSKzyW7EwpvOo
         RIu4bqjJFa84MVvrrXCgneshbxWMZzueybRWXJY9OH27Sr7MwLVbcQxzwYkQajaGayJs
         C55LuF8+wS9JrgOvO2Lc5RgfXFRJc+KbVN3MVCEeD9lRHIE6N+0J/egZXEaTk/ueSKUH
         l3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT1Zq6AofVC23KOctJ5dbqQzC7j01dgw9exuckpXgpJOiUm+W/toZgn16pdrFQTgBGPVruf/K1SHSkbyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhWLhFzFppHB9zi+biCodwVK2IOC4Hg34s10kr2ZqtL7IsWwE
	6xChqsKOKlm/UphfHZOJh/ss8p+44KaIco/XL71LeMW081N5kitEbKIpZkGKbgG/5DcigKgoq3d
	NDBihwLOx/sCaM3rYk5LoigEMDdIJlHdxLU2HMw==
X-Gm-Gg: ASbGncv0N5yg00AQqQuHdCkJg+C8/cfCuL/pGSd6JariDPLjFm82ZzG1Zupg4AeQH8G
	XeqZxMxh8iicEZBeOY75Ah/B9L9xpRXv+lX82slNlWVy8IxzGOB1YW5MQAZQiiHLMkAKM70xeGZ
	WI9Lki+YbhVw8grdCnphjlqTg=
X-Google-Smtp-Source: AGHT+IExhx3X663308XXZlwm1c0/8LT2zEZAKvTgV6X9Pe3GenUDahAFj22+6QCmZWTu+4UGyOhFdfoHzjo57MlIqmE=
X-Received: by 2002:a05:6512:238b:b0:549:88b8:ccad with SMTP id
 2adb3069b0e04-549c3f97e1amr693966e87.20.1741950549684; Fri, 14 Mar 2025
 04:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312072509.3247885-1-quic_wasimn@quicinc.com>
In-Reply-To: <20250312072509.3247885-1-quic_wasimn@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 12:08:58 +0100
X-Gm-Features: AQ5f1JqeFCXuNVd4MM_MrfjWEL2E41hAn6iGIfmUHWTfM1E_vGppRUa3h1NuRX8
Message-ID: <CACRpkdZ6r47jhGVVoLn8XzfuMKMrkg8nCcp6hMwzUnTUSTZEwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: qcom: Enable egpio function for sa8775p
To: Wasim Nazir <quic_wasimn@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 8:25=E2=80=AFAM Wasim Nazir <quic_wasimn@quicinc.co=
m> wrote:

> Add egpio function for GPIOs ranging from 126 to 148.

Patches applied!

Yours,
Linus Walleij

