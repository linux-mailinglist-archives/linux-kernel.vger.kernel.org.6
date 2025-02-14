Return-Path: <linux-kernel+bounces-514637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D36A359A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE37716B47D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37722C33A;
	Fri, 14 Feb 2025 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJst4X3S"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB4229B11
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523805; cv=none; b=A/MKZBYyydkLg8fMUykPfrgzK0MBm9rlkKOdZRCPLkxxKecHaOc6UyLmgcVhwmjuGYeSp2NSAHPrSRwfrd0VVHGDYfZYqtFTsmqG0/3bJMBIcZroAutpZpK5u6GvSGhnLK93INcnwFctVvVcdVsQylFnCQyA9JzEU8YCf6Rtw3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523805; c=relaxed/simple;
	bh=iTJc0cMLK8/kUGnVlLkEpjMd1IDc2KhUACzQgpu9b34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3sf5DsjAKBPuJwbyN3/LMs4dzdHYgicE80KnIukGtpvO43xcBgOlD9XBCikBRViGQGbijnmR5dfZSi0tWtyFp8r+2QVHW/jVyWGBybsSWJj5QjcpZB34un+3xxGWZ/9FQeB48+PiGkWCLY/Gsvo5h0GG3kLewx5w9gn8RJEgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NJst4X3S; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30737db1ab1so18648271fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739523800; x=1740128600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTJc0cMLK8/kUGnVlLkEpjMd1IDc2KhUACzQgpu9b34=;
        b=NJst4X3ShKfYilNvdBaAeZUSsNND0v2If27aHRsb398vytgj3Mv6zvMZv/ElAHtpAd
         gEi16QAbNvI3UrPJTZxa/3Nf26mrJhW7hS5aDIZxPB6dH3tJwSl3LaZGQlIFv6sX5YN/
         uTEJlU6hbBbDAfkK01+kD57zdhE3+3h3ipqeEh85BMtvW53mFuZGjhNEn8Rp77g94DQt
         N7IDS8voyAohHxca/hnh3RypNejTYYyyFGd76f82LbuPfZV0Rp1VSi845s9GCykNLV90
         5bZNXCQt3QkKGIiVSjsqT4q+NC9GwlR2CTT+Osqb+8YLtL1gnS+q3zde+7v66GAOm1wS
         NUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739523800; x=1740128600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTJc0cMLK8/kUGnVlLkEpjMd1IDc2KhUACzQgpu9b34=;
        b=f/9y4cNcrLrGj8YgzPUfU6IlxbEo9tT/gVAJeT5jm+UZ1F8V9XTCa4Olk1EoCSbq48
         Z32rdiV6eZ9sZ7VRp6X64ycLwV6wu2pb0NOE9aVwVCtK4Eh0Sh1ha2FwhL69WORllBnq
         Ofs+uSSEkMtqsQeGdIbBdO5FDjMDDEN9lgCmNJ49RORLAiVS/7pOFprehlG0IKP2sAI6
         xnFcXToi5chmK2SRvjv3Y9tap+oNWdrUNf/2o5ij01SLXzA6sP91PbIauQcpmoO5ZmmB
         6mP6cpg39Q73+/QIjESRnTD/ljRjB87/OwXiwMkN68HlJubGcgNME8YNQHtAliPMGb++
         LGRg==
X-Forwarded-Encrypted: i=1; AJvYcCXh9Qf8JI4EmV4jf8rZ1lb9cE7QIZBXj3rPSwAYZwWtC0kn8+KoCRezSGnQtY6cYLRaorq6wT9o+bdEMAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJpGfQ8g+TenFreczZJQHwXlxQlvwkWQyGbLcl9qGm90aEgwv
	XGcmEiwLuw2fEk0BZKM8lncsF6wD4bgxzlyPqiL2sdE4k/IctHWh0i2W8dJDv4xBa1qcFnwrW1E
	66dDT5d4L2s2SQ2abG8sfjh2973xi7NAILW0hjg==
X-Gm-Gg: ASbGncvw8n1FHf6GzmsZ7dvJYLEpZL56i/4PLwEw9yvhlpdMOLHwaC04tOZS3Vcbf+6
	2M5GgKT6/DyK7MxREtOEeNONULqkY6/ONVrf8srQpsQ5YQUNYrE7fJRUi5Odr5clyOk2+qEE+
X-Google-Smtp-Source: AGHT+IF3HDdrnSW3BLW3bq9cqh3LStu3LTvk4uCfYArhbMCiGtiuvWWNtxSZE4wwSFlSY9sTduBuIBS2XR5LiRCWzdc=
X-Received: by 2002:a05:651c:221d:b0:300:3a15:8f1f with SMTP id
 38308e7fff4ca-30903927410mr38426071fa.32.1739523799914; Fri, 14 Feb 2025
 01:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-bcm21664-pinctrl-v1-0-e7cfac9b2d3b@gmail.com> <20250207-bcm21664-pinctrl-v1-2-e7cfac9b2d3b@gmail.com>
In-Reply-To: <20250207-bcm21664-pinctrl-v1-2-e7cfac9b2d3b@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 10:03:08 +0100
X-Gm-Features: AWEUYZn7NND4I1Mgn5Kpd46GvIrBPpNFG6Ldn40L_YZFFLWpE1zhxOGmLe4jdWE
Message-ID: <CACRpkdbwVdEa_xgR=wRfkPN2_tpYGnbdpQkTtvgDMRSKPT-GEQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] pinctrl: bcm281xx: Fix incorrect regmap max_registers value
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Christian Daudt <bcm@fixthebug.org>, 
	Sherman Yin <syin@broadcom.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Stanislav Jakubek <stano.jakubek@gmail.com>, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 9:02=E2=80=AFPM Artur Weber <aweber.kernel@gmail.com=
> wrote:

> The max_registers value does not take into consideration the stride;
> currently, it's set to the number of the last pin, but this does not
> accurately represent the final register.
>
> Fix this by multiplying the current value by 4.
>
> Fixes: 54b1aa5a5b16 ("ARM: pinctrl: Add Broadcom Capri pinctrl driver")
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

This looks like it could be causing regressions so I pulled this patch out
and applied it for fixes.

Yours,
Linus Walleij

