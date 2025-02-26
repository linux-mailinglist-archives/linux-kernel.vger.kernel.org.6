Return-Path: <linux-kernel+bounces-534029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E830A461C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9C9188834D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F020B1E1;
	Wed, 26 Feb 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXkkEJmn"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7621C19F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578905; cv=none; b=WZRux0f64Ap5yGoam8cKt3aT/I+j1ab0gl+ac0cae17iBbd9DFNkPEqujpPLWxZIfC/Jx5v4x81BMwT7KFgt/Lml6U/pzJxNQPD3h/OdJU8WJu0Ol89kj0lDmyis3p/TUIYIwC2OagrhsOO8M3Tq0SfOI7gpiK5ABMznr1InQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578905; c=relaxed/simple;
	bh=Z8ID3sNVfwatoCeBh6IOOz1sI/Ryo8GaKrAF0IjVDvU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LD/u4KBnqGOPvM1P9Iw92pSfjTfUCYOJGplzv7D53zFFChpWpEGyd/XFBpGJJRtzgwqMZ4JEe8NXR0q0SRbbalGZx9vUbaM29b+t18BfA7knPhBFmcqZeolLbabnt8r0kv1YxcdZNo72T3p0F8RckiIFcNW1QG62oEsdvNaWXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXkkEJmn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abee50621ecso221953066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740578902; x=1741183702; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gGkvpqqa0lNt6OkGD+EZHoDXRP4y0p+8QmeJ79Z97r8=;
        b=oXkkEJmnBGiOJfjc7cQZzQ5LgEfhKMJd3SelLVgJMUVgneoKnNA/87UERr7bkxfJRf
         40nV7JCUWiQcD3OD80T02PlMo/iT+0pqg5cr/jvyH1B1DNrix7JdGCFfeZDNd1TffT2s
         p2N8diUxCnH6r/+rYPZTau5sab2mJ2RZq9LfhkufWW+EaZ5u3FxicGjFHuLZC6FBHms2
         JzDQqYBagRsvXqDLzUW9wbyq9Wvn6wtI15pRbWXmYjSkk4b7jzTtbJ/Mqn61ttx7vy9B
         4UgzeUyc6VWgR3Bd6lOdFTEx2IKhja0M8LkNmpEkyzhDMlG0um05XJMAvMIu47idkZUj
         gXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578902; x=1741183702;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGkvpqqa0lNt6OkGD+EZHoDXRP4y0p+8QmeJ79Z97r8=;
        b=i8T45SP43FyDjuqnN2ar/9GK9+dsQgerwaF2Mhy5/ziERA2yBqhznJtXDrTmUlROOu
         Ts1ijootiqRuzJmLLVXf8qvJSrDLmbFMfmbtMjnBOhkLSF+Xnam0piLoEVGfrrp48EK8
         esompaNdhEj/RUty9kbNuCpaN0soURDCFbgKJG1U4B29z8iXFnoZOQ19XnNqkWCoXv43
         hCbFijmW8AEyqkHiNw3S1YEiQqbR06t0RKm8MVPOC5JaJ1HCgiyUuy0a9S1pkYXHeqvt
         nnLaLxV6oWE8MdvYu6y5pEAJU8YS6tkqZWAcENC81Evu50WuE5dDiQe4BONtFc8zwd9e
         +2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqfUXx6geMIpAxled1PM/l2IVrVlQU9byZuFd5kj/CxlVVH4twFcbMDRKaHePkTrWK7Sj99GyFmdkGAj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+uGNRYJHrl0pkIHrR4+iQYdnFpXX3EtUINjzbXGLzoZr+gOB
	3TSlSB+VucCQwLZdb1llNpgO5Qy2uRhG6mM95ljd8G3BMWEluIhkamLtrqfnUAo=
X-Gm-Gg: ASbGncsuPUFM5ngK6IxeYHvGKAaTaNtACgtHoKjKvF9W/x2bgSDBwyczreCAalOX43j
	MP4QmCeGZ2PetEr/n7AXEz2L8d/amtDuwJ/v+MAVANV72gkutWqVrL5Ufdf4gNmrBumDLnQ33le
	uZbBXDkSqXmLCmF9df8SsS4mvAsJ723cy9XPgbmQ/+eiF4KR6Mv28/gl1g0NkS74OdBIoqrO1vE
	/F8yBrMUueeGenvf2j51tExg1nSq9821qRes2xE8pDBdrYqDT4xXFE4Bv76VlFweeJoCcyxCERD
	BV0fX4gfJRb9BUma5mXnoIgyinUxzeja97IZo/X/UmS6+lgTR+9diUIBwMMGYkLRVdslhCRFKYg
	VsXvv1re3mg==
X-Google-Smtp-Source: AGHT+IH4MdS69xY9exYgdEvpIfpgesUDo++yOFDim/PJZbSNDvBtWjUP3kjR6hVeKMzb+SYuk5VjHQ==
X-Received: by 2002:a17:906:2191:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-abeeedc8786mr268568966b.14.1740578902102;
        Wed, 26 Feb 2025 06:08:22 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b6024sm330157566b.181.2025.02.26.06.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:08:21 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/2] support Linux reboot modes in syscon-reboot
Date: Wed, 26 Feb 2025 14:08:19 +0000
Message-Id: <20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFQgv2cC/x2MzQqDMBAGX0X23AUNJg19ldKDP592D82WrIgiv
 rvB0zCHmYMMWWD0qg7KWMVEU5HmUdHw7dIMlrE4udr52rnAttugiTN61aXAsPBPR7APwcfYx/a
 Jhkr+z5hku9fvz3lelKi9dWoAAAA=
X-Change-ID: 20250226-syscon-reboot-reset-mode-566588b847e1
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

This series teaches syscon-reboot some of Linux' different reboot
modes.

Linux supports a couple different reboot modes, but syscon-reboot
doesn't distinguish between them and issues the same syscon register
write irrespective of the reboot mode requested by the kernel.

This is a problem when platforms want to do a cold reboot most of the
time, which could e.g. wipe RAM etc, but also want to support rebooting
while keeping RAM contents in certain cases.

DTs can now specify the existing properties prefixed with one of the
Linux reboot modes. All the changes to support this are optional and
opt-in, platforms that don't, or don't specify a register/value/mask
pair for a specific mode will behave just as before.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (2):
      dt-bindings: reset: syscon-reboot: support reset modes
      power: reset: syscon-reboot: support different reset modes

 .../bindings/power/reset/syscon-reboot.yaml        | 74 ++++++++++++++++++
 drivers/power/reset/syscon-reboot.c                | 88 +++++++++++++++++++---
 2 files changed, 151 insertions(+), 11 deletions(-)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250226-syscon-reboot-reset-mode-566588b847e1

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


