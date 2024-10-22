Return-Path: <linux-kernel+bounces-375625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E749A9852
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0B21C217B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27BF136664;
	Tue, 22 Oct 2024 05:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8GXJS0R"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F51126BE0;
	Tue, 22 Oct 2024 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574968; cv=none; b=LgLO24lYZHxDd0rtxM4zdiUDaGhgsWq4CmdyjyW9LER7hYfREzB+17uvWu4E14ydPeDaY3097wSxlK7JBSufDDd9rA/BffUbrLx478mXlpmgjl1O/YUE0ay4PdQ82iy0fWK0RKDzQAKXQpth4IAJq7uo5yKEKCTp39ptXKVeRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574968; c=relaxed/simple;
	bh=pfMrLe8Z7IbNyCkN5SSc8GkIyDpuWyefc53mmKrm1Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bBQkAsWEC3s+Np5TsmXG/Znlz1GV0akRZfaK61YwyHpXRION3AjwAamZWRBtedVnqUM3NA9LLYWg91qNX4p0peHl4azlCdXWeClyE4p3iQvInRAHTATprdEPdTJaNXxIV00m86IcbypAgwRFqtW7Vu5wKPGIiZFCLAKhd/xLt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8GXJS0R; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e467c3996so3343664b3a.2;
        Mon, 21 Oct 2024 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729574966; x=1730179766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CfWo8rEibeJNRR9ub5UZ9B73NL531yxGF3rC7/Vsvq4=;
        b=L8GXJS0RvRZ/u6HXInjgPtMNcrfylaDVJVf7UYeqS6Zk98KGr/2wnvY5J5tQmHvPvb
         MXe/yR/g56AQSc/xgbpRS8kmzrezrvXs4g4oRGytWCpRSNhNt7516sGHW6/11yg4G8x9
         INtxgFKyiFybD8M226JL5UPY8Ax2xqX08mq7+ZQf7cIwJbpE3JTh4+BObJyvXpySEJEH
         p+bIpsVuBElxSRwLfViVHPH47yVTbW50XAUd/8Xx8r+jEOCptd/Q1JOghZGGppqz4uB8
         yUTYE+gIuttXPkND0zEcw028gVFpySMg/1tFkjEsHUzCWY2vMpOO+P5CNEBpGpuEKjJF
         ek/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729574966; x=1730179766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfWo8rEibeJNRR9ub5UZ9B73NL531yxGF3rC7/Vsvq4=;
        b=V21r5PjX+XY7PEAr02IaX4SvGI9gV6WYeI0qD8a4K+i502LJq0i1uT3uOeNBOAlP49
         EpgClvYwLmvvZhKDucoe2F3nkfdnOp1On2sEyNzaKKC/xVKvjkx+39q5AZuePxWl8G/t
         07+wXR2Qi/1qD+Yw3C32NZitM92mUthsaK8U9bcBIFyiO259FTpUK0yEhXr0p/GpqqLC
         7n2RLBT/kLpmbeiYcnriK7HqOEZHLFe78+6ZGsn2EWqg8PkvTSWnCmlDUpgV69Hk/u6+
         9OJW4FQbb8HSbxpH0BIbOF3kkKPMMXixOY2QdkoYV96RGPPptb/IBEEexU5Kxjtfa0Ho
         Vxjw==
X-Forwarded-Encrypted: i=1; AJvYcCUTOzRxQyW1duX+T1e1fPcILzgRdJKEUNAfdKc08LT6vHkJUQIDHI72BqBQTyYWixhw3EqVa20334QfGRg+@vger.kernel.org, AJvYcCW1UxFUecNU6cuvX729r1CI8TTZaXcbotgaj3ngh349RZyO1aPCiO6DaaDiy5fk/IHw9AHLbD4bqC12@vger.kernel.org, AJvYcCWYxLDZQaB+G9U8yIS3OpVQNC1YYN3m2pSyFBSVmx/olZcJiUQnPwuklWiuQQ0eZRzgOlhkJD7fvFZS@vger.kernel.org
X-Gm-Message-State: AOJu0YzOHH+4QqTJ+UAR53984I3X95RRRtl5zZluOjMr2XsPCiDQ/jGA
	mGDgCbJ4ov6Pm6YkVMJ/kilMTmvuEypIS/HRFw26mdTkEcvfgzAA
X-Google-Smtp-Source: AGHT+IHlSAindglmOEfkhHefJWdKX6tckM7xeJFtoM8elMYSuAHZvTh7qrg+eUu3QgKsCOo0nkDWpw==
X-Received: by 2002:a05:6a00:1acd:b0:71e:74bf:6b1a with SMTP id d2e1a72fcca58-71ea32d4226mr20125338b3a.16.1729574965692;
        Mon, 21 Oct 2024 22:29:25 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec141505bsm3845846b3a.219.2024.10.21.22.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 22:29:25 -0700 (PDT)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com,
	kcfeng0@nuvoton.com,
	DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com
Subject: [PATCH v6 0/2] hwmon: Driver for Nuvoton NCT7363Y
Date: Tue, 22 Oct 2024 13:29:03 +0800
Message-Id: <20241022052905.4062682-1-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ban Feng <kcfeng0@nuvoton.com>

NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.

Changes since version 5:
- use lower case for inline function
- remove enum chips and refine code
- use regmap_read_bulk() to avoid the locks
- add fan speed low limit (register 0x6c, 0x6d) and alarm attributes
  (register 0x34, 0x35)
- add regmap caching capabilities
- fix "checkpatch --strict" report in FANIN_SEL
  - Macro argument reuse 'x' - possible side-effects

Changes since version 4:
- add Datasheet information and refine words in yaml and rst files
- remove fan-common.yaml since it is already in hwmon-next
- refine the commit messages
- modify the type of returned value in some functions
- refine lock/unlock in nct7363_write_pwm and accessing
  HVAL/LVAL registers
- refine nct7363_init_chip
- add range check in nct7363_present_pwm_fanin
- add i2c_device_id table
- add nct7362 to of_device_id and i2c_device_id table

Changes since version 3:
- Cherry-pick the fan-common.yaml in [1]
- Fix "checkpatch --strict" report
- Replace BIT_CHECK() with BIT()
- Fix CamelCase defines or variables
- Drop enum chips
- Drop all local caching and just read values through regmap
- Drop chip auto-detection since it increases boot time

[1]: https://patchwork.kernel.org/project/linux-hwmon/patch/
     20240221104025.1306227-2-billy_tsai@aspeedtech.com/

Changes since version 2:
- Cherry-pick the fan-common.yaml in [1]
- Fix nct736x typo and add unevaluatedProperties

[1]: https://patchwork.kernel.org/project/linux-hwmon/patch/
     20231107105025.1480561-2-billy_tsai@aspeedtech.com/

Changes since version 1:
- Modify NCT736X(nct736x) to NCT7363Y(nct7363)
- Convert to devm_hwmon_device_register_with_info API
- All ID tables are next to each other and should be consistent
  between i2c_device_id and of_device_id
- Ref. fan-common.yaml and modify properties (nuvoton,pwm-mask/
  nuvoton,fanin-mask) to (pwms/tach-ch)
- Convert to devm_regmap_init_i2c API
- Remove unused function (watchdog timer)
- Fix uninitialized symbol which is reported by kernel test robot

Ban Feng (2):
  dt-bindings: hwmon: Add NCT7363Y documentation
  hwmon: Add driver for I2C chip Nuvoton NCT7363Y

 .../bindings/hwmon/nuvoton,nct7363.yaml       |  66 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/nct7363.rst               |  33 ++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/nct7363.c                       | 446 ++++++++++++++++++
 7 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
 create mode 100644 Documentation/hwmon/nct7363.rst
 create mode 100644 drivers/hwmon/nct7363.c

-- 
2.34.1


