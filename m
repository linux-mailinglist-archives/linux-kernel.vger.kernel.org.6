Return-Path: <linux-kernel+bounces-303538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBBC960DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5811F25667
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E15D1C4EE3;
	Tue, 27 Aug 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwVr6rg1"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF91C1731;
	Tue, 27 Aug 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769146; cv=none; b=OsBNL4ga22B5RRj2P8/3qIGhjipoPHQk0EQOC9Io5Q1oUNEBFemlJWbPLNWupITpq7Xkm3txtgvj02B429TTm+lOF+G53O9x7XUKP+YXRcyO08UMOzGvZFf4RmFTVNjWtHVcxXUEUXQ/Gog3h7g6Wwu5Rm1T3uVgmHKJFdG+zfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769146; c=relaxed/simple;
	bh=QHQAsujoDKj/irae4e+S+yLEKA8zD+A/PR62mesntug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X68vLfNMqg3N18JdAJbn+kGqwwWXSfa8OGDULuf8wnQGiyN18R9W4iLSfg4FnzRwY1ru4NUxziXoERXqWhDrvQxvg9XT2LKJaE/VqQ/S7SIiBbI2J11mj8TN7RZWlf/W78Errf/O8Rb56an/8Zlpd/EDR1uawqhUkbeMHFW46uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwVr6rg1; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso67751381fa.2;
        Tue, 27 Aug 2024 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724769143; x=1725373943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk1nXOFSQsJPXJuHSlmHeWGCF+cAqyNmHrEa41Un+J0=;
        b=CwVr6rg1vkbSVVO5lNaXWwnUY+nAHEPGB/iwBjHZhUaq8OrIy2HLx36Yb11che+Bzp
         9Ts6+XXQwJqcrEmihsVC0Uq23dr5gH/y2U2gnuF4CLuEMg1GWEp510ojXBhk3tGuSxuj
         zY4owOYGbgCKhOc/dZ4EqZKcEg9OIN1VO4Xgttc8GavbPUzdfpNs0xMo/p2OJRkWq5r9
         skVHD862BYg9DxrK3aallZrY9/EYt1IC6SwTeGNCHn1LHTZ/r59jLMVhh6Muu9NmicOl
         ABWHnYXd+kqo4rOrKCQNzc3wWAy4DSM0uBeH1KtV2r3/BGCrnktoQi7FFNklErI8r3nf
         qQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769143; x=1725373943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk1nXOFSQsJPXJuHSlmHeWGCF+cAqyNmHrEa41Un+J0=;
        b=BP+BB7eSbS+KrMV/zTj15wyOhqDoMmeyO7GoJXlG8Q1CWJrroQChSxWTGtFgzO9t7x
         RUkkVGc1EWEECoWF0w8XWt0wxYRK1H3/DmR3Vz7yd5jkFJdcgWOLnnsC8U6UTxU5lov4
         7cI7aRK8XgZ3ICLtb+NkgR70zxFVh+TAfAtZw6jKaquWkhnyWQF3391PgVW9sN6KRlph
         qvp8mOSse9tRefcW4vtuIYGxdtfYKDqaXTH3k0uq3u4ZwANsd/Gy4jxMBJrdR5HLYwfO
         EVIHPAJxBfrDaWrwfl7lWsA6Gzd5veR8mh/aafWNy6Ku0rGbkWsmvTPd9rOywCmG4jA1
         6ZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh0oRLaneNeW7HSCf2EH3fqzIp7Dj5RCHdf8U6dEKiLs9IQS0VQGvBDymiT21NyBF9/VAXhXDsOH5G@vger.kernel.org, AJvYcCWPaChSEldePjn0e0cSYH/1O3NLSao4k9UwB/uKtWVEyE88eM608aXrT1tXtdu9a4htv2CnAeY6tMYO0nG8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywycr/IZIve1THNOoZXzuczxtldzHR0TMLCcpqB2o3FqO2V7XAL
	KAjTWnLOcTceFzWdTrFIfEPlnEOnq1th6YaZfdjl42phcPxlVcGllUjkYxwyRykqUjsw4KFJGZM
	merzOSKXDfm78ZuCdD1k4CroXnrs=
X-Google-Smtp-Source: AGHT+IHWJ3Gl3iN6upW/xxoBdlO0OWmiGDOdQz067boFUijDPyhwnph49wuV7rSiEbAgkS+eDSaitUYDzgrHe+UgSi8=
X-Received: by 2002:a2e:a9a2:0:b0:2f0:1a95:7106 with SMTP id
 38308e7fff4ca-2f4f579e60bmr125895581fa.39.1724769142498; Tue, 27 Aug 2024
 07:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827142458.265558-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240827142458.265558-1-alexander.stein@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Aug 2024 11:32:10 -0300
Message-ID: <CAOMZO5B32Cn6qa3Zqe437pqTZ77bpCVMMtzhH3xzj06x5G5MQA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: imx6qdl: Add reserved memory area for CMA memory
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux@ew.tq-group.com, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Tue, Aug 27, 2024 at 11:25=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Default CMA size is too small for HDMI output and VPU usage. Increase the
> default size by providing a CMA memory area.
....
> +               linux,cma {
> +                       compatible =3D "shared-dma-pool";
> +                       reusable;
> +                       size =3D <0x14000000>;

Just curious: how did you calculate that this is a suitable CMA memory
area size?

