Return-Path: <linux-kernel+bounces-195972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E78D5587
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D971F2472C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761A182D34;
	Thu, 30 May 2024 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liImEmSI"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC04D8CF;
	Thu, 30 May 2024 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108784; cv=none; b=f2s0STcLkZIyd7zj831VzM62OCWiPzRfKcxEVXyhpv3GQzPv/vz+Y8/HFZE+iJpa/2CfAxlS55W4Yo3KJmmqH/ZoeslRYIueY5aaBO5jRFwfQgFkCGzxFNdmQIL+JokT0Q/wvBq99GMa4Yea7j4j0JG8i9k1ZyYmIWDUX1uF7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108784; c=relaxed/simple;
	bh=mXY30NJFEF6JLW93acKB5oca48AAvAuYKl2LecAnpRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PWk/J7Qk4BWzyfx+ij3SVMu3pelVvyUjgT+8e3yt3jZd7w7BtTNWfrsJknliHZG/VLwZ9xe5ulkxRAtznu7jwV5FWlzRhK/uDBM4Hs1bXdlZFPnXXFVZ8/s/8yU7DeO2cHTFIvvC6jySVxDrP8d/KISITJgWv5twKTI5TADxnCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liImEmSI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f44b5b9de6so3108955ad.3;
        Thu, 30 May 2024 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717108782; x=1717713582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Kzk0553hUTwCCO7xot6Hyfco8XZk8QvJilIgZV2PeYU=;
        b=liImEmSIXLkDcZYuuy+pswXM/3cNvz6sSpARAI3q6Dm0oQPMtaJknQtDSiSR1W1nku
         5WjT0q8z8Fa0paMyKBDqV3FV1T5rdxDr8x1HotaPMKpn8/GgnK85oEuXvKUvQoZ7CUvB
         vhNNO3k3u3MtSQJLmBtMD13AQ4lGBaplYgiFWix7gh74hHG2F7mibSV0halisfvTAP/W
         wF1OOFzV6SQgdta4lyAa9f7qPg5SIautEyTi7+cPwxbwle9vka3XcTOUWCnXLmjMiYyX
         bk3ZT7JaMZ8ucLVJ9E97TP3E0bqvr98sVtdY/htwW/zW8Tuz6UvU7iRuR7RhcMBzfVKn
         3AGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717108782; x=1717713582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kzk0553hUTwCCO7xot6Hyfco8XZk8QvJilIgZV2PeYU=;
        b=oALFfvRF8QkQ/vRbqbDbtA0MzcKZdgiLvBxG04iztN8Ix7S9b3cm3v1l4f1JuaZ1wG
         yB/nuYu2ec37YXVdDp/KeISOixRnByEjOIQb/d3DwxK7S9xgBfK3nxCRUYM/bQSLrSh8
         Iv25rb9e69iFvZdeAlvAX52kR+sjMuh494QJSOGBifCMvabaLgRM4oMol//pkFWiHC87
         iqVIsqIZ4wSHQvt/IF6JAca5UltdU17IDHUVUiFNSGpk0HPxmQdnZabkPhMHkc2vf+Ii
         r239ZCwsNGPVhFfU5AkemHee6TQdhozVzPzhSD49iTGf7GlVSe8uacrYzCD3P5OXXSj8
         MFpw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9LxcSNDAt6J24EIHwqXtlGV6ONYbDB3HIP7LZKiV7XEwPumNVR7sfFCdglrjILLNB/CDrMh2+TRmuEzK/Ua26yD+WdtDc37iT+VC
X-Gm-Message-State: AOJu0Yyhdmnv6n+eRjUYBFbR3wzOdlzGcRj0gR0rNFDrdf/HjRe+kYep
	TzbaIrRvVeOhCVHBn14MsAb9pN5CBKRR7yyivOwNKXYCo9gbK8zj1a2E4g==
X-Google-Smtp-Source: AGHT+IGoE7HEvJHeJSvztQlvx6a4E0Q2iVrbqT66uo9OeZXKNR+dXMcHB7UVGc6kp9jUaExXJ3ZOcg==
X-Received: by 2002:a17:902:ce81:b0:1ea:b125:81a2 with SMTP id d9443c01a7336-1f63709c681mr1918115ad.53.1717108781515;
        Thu, 30 May 2024 15:39:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632338ddesm3018795ad.13.2024.05.30.15.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 15:39:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/3] hwmon: Add support for SPD5118 compliant temperature sensors
Date: Thu, 30 May 2024 15:39:36 -0700
Message-Id: <20240530223939.1027659-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
sensors. Such sensors are typically found on DDR5 memory modules.

The first patch of the series adds SPD5118 devicetree bindings. The second
patch adds support for SPD5118 temperature sensors. The third patch adds
support for suspend/resume.

Note: The driver introduced with this patch series does not currently
support accessing the SPD5118 EEPROM, or accessing SPD5118 compatible chips
in I3C mode.

v2: Drop PEC support; it only applies to I3C mode.
    Update documentation
    Add suspend/resume support 

----------------------------------------------------------------
Guenter Roeck (3):
      dt-bindings: hwmon: jedec,spd5118: Add bindings
      hwmon: Add support for SPD5118 compliant temperature sensors
      hwmon: (spd5118) Add suspend/resume support

 .../devicetree/bindings/hwmon/jedec,spd5118.yaml   |  48 ++
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/spd5118.rst                    |  56 +++
 drivers/hwmon/Kconfig                              |  12 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/spd5118.c                            | 510 +++++++++++++++++++++
 6 files changed, 628 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml
 create mode 100644 Documentation/hwmon/spd5118.rst
 create mode 100644 drivers/hwmon/spd5118.c

