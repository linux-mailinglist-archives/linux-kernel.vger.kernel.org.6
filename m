Return-Path: <linux-kernel+bounces-346887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BFA98CA4D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 115B4B227DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674431FA5;
	Wed,  2 Oct 2024 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6S4MmXo"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4148F40;
	Wed,  2 Oct 2024 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831295; cv=none; b=MvcJBtoEONbZ3y6blbAyJqL7qSpF5NzdB6bOs5rZ0ym6aFQ46aQlKB1aerl3VOp0bEqZJhNDmIwxi3WC5rmeWPdj10s+duIvTy3aYf/1YcUOkdg7VLPRY5RjDUNTdwEvxacS2HaVMW3SWmlVDSvgVe12wHOgcewUdFGZyrBbykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831295; c=relaxed/simple;
	bh=7jKVBSLvZhbWcecOQtJur1l5xbNrIljdxmhWpD5Fj20=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uTHxl2sQuipgfHo/h2gTZe+YbdRFtJOJYW8EQcnoffR+OdHkEayMzqmTct4nfUaoRaHoAXl964hX9hmyaZFQQc5tXpzaA28FzwQEJrgXm3XSy4tHj/IOGgeDlghsIeTufQNrwLWniXITxyVF1OEKHb6rvuWcinzrIDfxniPJulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6S4MmXo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37ccd81de57so210174f8f.0;
        Tue, 01 Oct 2024 18:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727831292; x=1728436092; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/zvKMmGHHcjmdHGE6wZJufqVNymx1raOpSoqWtSzBxU=;
        b=e6S4MmXo8ADn9rXGjNTPgPrYx+VZON7nDvdRkxb3YmC7kXxmXp6FsyhCILMYoKD1dV
         51ETsiyRS6BHlAv1TPqbScBUu97JppcfO50qaaV9w1ywRM4Iuc87/brg/SVfYimHkjtQ
         N9yj0QG5zasEi3dEi18Rn0XPCIxyf8s0PTSBfNUisD05lguITNtR/4R8WtGWPCQ+m3eo
         6K2ieHz5DMATCMNQ64r7x+RSiD9UrwVI8IIT9CYc+tJlG0cl39Nzi1oOJIPKo+V5lBp6
         dlgPtCKPC2jzZzfeMJZdp0YHx8L6ValuavH9RAegTnSZ3kc+GY6wPoTeOl4I9bGKKzaK
         PRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727831292; x=1728436092;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zvKMmGHHcjmdHGE6wZJufqVNymx1raOpSoqWtSzBxU=;
        b=fxF3/uVis7CBA15YIxNUSU4ZvakZWlAVhkthIomkVxOcoEF08PtKgIaya0sq5R/6D0
         7sVksqq5X4mHg4LqZRBaGKO7Imi5YwDCyhjWOTp8Nc8GjqQnaEfgT+e0u3QFM9X7l8jj
         z2O1iuegCk2xVvcp4GSYo92C67rhqPqs1Nph8TdzcnQcW2DPH/+yai0T1KcoP5S0UFFe
         UFROX361joA3+GUMcIIqqbkJemJ1iMAp3Lbzxkvh4Am6Mc1D3wmSFjrNQdO2pc151CCF
         0PGY/9UL0S7gY8Z6l/DFstfLV3OxTDX/g+fY/kmxnt79QiIWek1Qs413CQQrA6375D++
         30jw==
X-Forwarded-Encrypted: i=1; AJvYcCUtREIjnl45oHWfmr1Rbp6qwjzVFQ88hJxaJkW80YiMBYE0glxq1LcVNpI6LU5Fobm7UTyB2dCNygm6TW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjw0CX62L07+ArKz7S7Is43SIr8k72zsAkSC+Uxoc4vjIlrAW
	dH2fQONO14l8JcE3epc1IdO4OfinbAty3ZuTqR/Uu6gRbWkoQRPqk5bAHB8o
X-Google-Smtp-Source: AGHT+IESy6xLpAPyJ+ai0CSn5qfCqB2jISqMn5LHOz2n9ZgKPE0z/eDhCchoVITUBdZFFthgBmcgYw==
X-Received: by 2002:a05:6000:4106:b0:37c:f997:5b94 with SMTP id ffacd0b85a97d-37cf997631amr2847276f8f.12.1727831291856;
        Tue, 01 Oct 2024 18:08:11 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-325d-7a87-742c-96fa.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:325d:7a87:742c:96fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e89b4sm12881345f8f.53.2024.10.01.18.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:08:11 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/4] hwmon: add missing REGMAP_I2C dependencies
Date: Wed, 02 Oct 2024 03:08:07 +0200
Message-Id: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPec/GYC/x3MwQpAQBRG4VfRXbs1c02SV5GF+HGLoRmh5N1Nl
 t/inIcigiJSnT0UcGrUzSfYPKN+7vwE1iGZxIizxgjP17p5jljQHxwwrd3OYlyF0Q7iyoJSuQe
 Mev/Xpn3fD75pudVlAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727831289; l=1213;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7jKVBSLvZhbWcecOQtJur1l5xbNrIljdxmhWpD5Fj20=;
 b=VG5x8db5A04VU8Qfeh2d4e4b99Vf3TKsESVZAIFmrfR96DScXTHT7p8SGWCP/NSTkBAacXWW2
 ofJJcTJU+6TBpIs1dSQppcc4rSrkqJfDbY7J2efR5sT7nNbMXxi9Iz7
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The kernel test bot recently noticed a missing dependency on REGMAP_I2C
for tmp513, and I have noticed that there are multiple Kconfig entries
where that is missing too. First I checked mc34vr500 because I was
working on it, and I sent a single patch to fix the missing dependency.
But then I have found the same issue in some other entries, and this
series attemps to fix them all.

It might be worth mentioning that multiple sensors are part of a larger
MFD, and the dependency error is not reported by the compiler in those
cases (REGMAP must be selected indirectly in those cases). I left them
untouched.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (4):
      hwmon: (adm9240) Add missing dependency on REGMAP_I2C
      hwmon: (adt7470) Add missing dependency on REGMAP_I2C
      hwmon: (ltc2991) Add missing dependency on REGMAP_I2C
      hwmon: (max1668) Add missing dependency on REGMAP_I2C

 drivers/hwmon/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)
---
base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
change-id: 20241002-hwmon-select-regmap-2048ef1d2463

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


