Return-Path: <linux-kernel+bounces-239462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFF92605D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097511C22066
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E982E13DDD3;
	Wed,  3 Jul 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c61hXd0T"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA611384B1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009919; cv=none; b=XOWjjQR1zxiwqDXqrUelH3vVvUM4KOVDI8oT6CxBpr1wdvVAHXuH4b19OYKZvRPRnTChQrKaAf4YAIOMbpqIRwgqgTTlN2N8b/kE/RSSzsGVEQnQsSITQoDIpBfqItO66zEzlkDtjvOffJqSIGqbJNdHFTBq7qo/ZSw+/VRsaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009919; c=relaxed/simple;
	bh=0WsJacWyt8E7yx/VSCN49ZeOyHeRmLxybP/jwc6iDKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+xjBOzVyV5iVlduITkTZVav3rZPN53v7fjYiQYeyJ6JMUP1wASPopJbMpekVm2Wq6yb6niYcgCoo3Ko5fG5iDUTPkj0Ltf/c+DjmxWZntkTn7S5TSvENfXxw9nyVAwwASLhkMt/JvqwCK5y+9dyb79yJrFJK3B0fHnp6d9vCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c61hXd0T; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so24718101fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720009916; x=1720614716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WsJacWyt8E7yx/VSCN49ZeOyHeRmLxybP/jwc6iDKQ=;
        b=c61hXd0Ts1JjFiDDmbj8mInwuiV7u7G7W1vrZWMmTKZi5+T5hIogFZ6/Hp3Awc+MFf
         ISnYyD06Y5XUYfAW4IEHsUO5+ZV/iIREv+IMT792WJcxnQ0e8ZFizNI0BM7wLVWPTckG
         9mnOWAjRjfq28keQVpHzla9UdScNO+Fl38jHjJYb7GA8Excx03sON/fv88b/9depkJ3Z
         vtRTCt6C6PUzkUjzb9ZFRSlq2oeD8+TdbGFVsCBTGdp0hRhRi+WwrmSf4IE0H8Y6dFV1
         ePkltkmT7y1yeWjYziH19Mpj0dhwH00343AFuZHijCH7aaZBEPYAPlIymIF4GH4CRlVg
         V+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720009916; x=1720614716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WsJacWyt8E7yx/VSCN49ZeOyHeRmLxybP/jwc6iDKQ=;
        b=eROJTF8QAz8PR8jUQOQYuVUTCMy/UMSLTjQjGThqaO0KicrAKoOkiPmUkQo32Qini/
         y7L+nnZbGm6mBzjCED2JfAU7MH/FwFMvNOBEZA2wXimLr3d+4+rfqDQEGKuSXU9NRJmw
         Gxq2f19f7S2cXE7RAw0T9mcUWPFEqx/8HATpqUC8SlDD/bCW4YdEromKThlauY63W530
         60aI0Rwab1f71TK+VaHxWw01SX+LPTDkB3beovJj5tAHPSTQsBpoio5rNPrKLoYJmD0V
         2Oi+VQSFfrJDRbe5FzjymUhY5l/tDxtEzML0gO2Lzdl6urcKFgyRO3dkXYuLP0P2Bptv
         q9wA==
X-Forwarded-Encrypted: i=1; AJvYcCWRjEOZppcoNYZ3XScfnbi4UXA4yySLZikBxvan2J+YMX6kv0B2Xc5Uo9w3i/QfwgaWJuMY5pJ1tmYv9nNY9X/gTKW3bQ1ZOgjbY9ab
X-Gm-Message-State: AOJu0YyHHLoRJMqiFbt/hQTVWu9WR0lxDWRzESRH+uaSj7o3PmnVL9XH
	hbtRzT+AnidwCfU2QuwwqKNcF+EcKlP3Hd5LN8+5ox5yfk+VobTHNExa/iEkMoghyDn+wFAjoRC
	g9PpjlFfjEPRZCRV3A34U5l8B1h18kqFen8+HjA==
X-Google-Smtp-Source: AGHT+IGyU3wFEVZSUJ686bAHyx26jn9iQj70J+h9EnuMaXqU4LAFuMwiO8Tl9bWYBd1agpNYYRtBxAHFq2cglzpoNZ4=
X-Received: by 2002:a05:651c:1a06:b0:2ee:8720:b4b8 with SMTP id
 38308e7fff4ca-2ee8720b68amr10644331fa.39.1720009915916; Wed, 03 Jul 2024
 05:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627003654.242870-1-alexey.klimov@linaro.org>
In-Reply-To: <20240627003654.242870-1-alexey.klimov@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 14:31:44 +0200
Message-ID: <CACRpkdaxJdr-B3CmL3iUPgZHo5sTLsisrDaaBQaPpug5tTQBVw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: lpass-lpi: increase MAX_NR_GPIO to 32
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	andersson@kernel.org, krzysztof.kozlowski@linaro.org, 
	linux-gpio@vger.kernel.org, dmitry.baryshkov@linaro.org, 
	konradybcio@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:36=E2=80=AFAM Alexey Klimov <alexey.klimov@linaro=
.org> wrote:

> Account for more than only 23 GPIOs in LPASS Low Power Island pinctrl
> generic driver. The previous value 23 was chosen to satisfy existing
> SoC-specific drivers. However SM4250 LPI pinctrl uses more than 23 GPIOs
> and its probe routine fails on:

Patch applied!

Yours,
Linus Walleij

