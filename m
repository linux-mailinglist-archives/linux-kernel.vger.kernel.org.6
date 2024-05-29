Return-Path: <linux-kernel+bounces-194678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F58D3FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E880282A39
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5281C8FBB;
	Wed, 29 May 2024 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs/PXFA3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7491B960;
	Wed, 29 May 2024 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015932; cv=none; b=UJgG2WTLhjpLz0KFd2rNYbYgpgoHsulpUOWRlKQP27CVi81am4stnIejNPudKBkLm+5j4tC5fjrncSVXjEOinf0T3giPIQd1MW0lJh/TjgUbUijygSNTlpXMt5g3vhccivvjvaJgFjlHQp4/6Xqbl9LJXhNpkgzMKrq+ymMYDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015932; c=relaxed/simple;
	bh=zdAapd0h4mwms8TrJzC82y791SE7Yr7JRdXI76LPPaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dqlfsNk+G2tvSfpsFuEqFAZHauLEv2rKXtqcg0Gi2pxsFucnXdSCbizeeW8oP+gW49wVOD1eou/I3hQGg4a1f6/5fjTW1uUD2ljAPNdYJdIftC5Ntqjx/2fftdXo3/FKRjCzuWHdFhZFiZU8zl52SjA+F54mltU6cZGoy8Hdy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs/PXFA3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f44b45d6abso1475055ad.0;
        Wed, 29 May 2024 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717015928; x=1717620728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=F6gH8nCdHmr19zHRnPBbu6WWzjKxXWVCx7ub9BRI8r8=;
        b=Cs/PXFA3kCHBrF5uYKvcSOmxrH5hvjsoudVhXu4vTBFqIcjoWq80ebgGauv/gFSa8x
         UJl6IdamcUsOYiT/71jOczwBGoQwbr2jGo5LdsW35Y39xC3xn5/vOdxP53DBQWCCKx5V
         QFJar8xWjQoZb965qx0T0pcHHOnirCLr8xJb4wiBg6KPPxgFrQujBNQrKOqkF8QgsAZ3
         BNaC8MiUP0LHl28flW6Mebz7jyvhYHKV653zJrNyCHbcKGaKDJvI/HQoh4ughhOci878
         NXKXntSLx1976Rw5OqWO7+xqaXSTmzZnZFKhbPXaVEOiwWsmmE1/27EklUuu9A/fU84M
         3qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717015928; x=1717620728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6gH8nCdHmr19zHRnPBbu6WWzjKxXWVCx7ub9BRI8r8=;
        b=qFsRTVNTJ0XlF/MZRzqzJS7CkhGWhlTMAWciOG4lfkF61T1uHSegR5NyRR2BWA1GIz
         Avt2WLqQW9fmHiMMB8PRBUJIbIkudv1xJAUvNYXOOV0l5XnedAfU0W9whFbFD0+I9nSg
         wTqNK7KC5jC0ae9/mUpSMZfPn5v2USpQMmaFzEeClZc1kVztkH0V9OgbY9OCJPbzPF0+
         CjA8HZDMdiWEe450HlCOgp8NXjRZ5GmyaNZJSbhFDfwZR43IQWePCWjOvJgwbJWmlzx/
         bYBY6AwaRYhcI5J6ZolWKCZM3+CvhHL8cf8F4VBqtYechX3Axr3iz0fzwr4UYnvPq2ko
         CHeg==
X-Forwarded-Encrypted: i=1; AJvYcCUA5p18dgTWAQStznOGUcS6NzKMFOgH7tpniqK4CKTFLqmJvWr4yypRkFeWvOzNQk7aMrWty9vBRD+bMglbMunvwqYJdZ9IyJ3Uaswip9I5HBF9l9Q4ssBmPgZvdHQTLHmLBkKmZ/0n9Q==
X-Gm-Message-State: AOJu0Yzh4b42gzn1SbW/UgCgdWRZhHCwN15teN38gDxbPI5BEYvP8JXd
	yGBKJUpLck6j5WLU29Jx+yRJBenUERxlXxDm+O5E43phsi2X9LikKkM99Q==
X-Google-Smtp-Source: AGHT+IFAFmJUKQ7duvuZ/oxhR/EPzswjWuhmgum5OIHa0fwNQZnK1//Bj1N0JIUH1EohgscjN74lSA==
X-Received: by 2002:a17:903:2301:b0:1f4:ae2a:c15c with SMTP id d9443c01a7336-1f61983aa1emr1595235ad.45.1717015928350;
        Wed, 29 May 2024 13:52:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4f1eb24d9sm17076705ad.88.2024.05.29.13.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 13:52:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/3] hwmon: Add support for SPD5118 compliant temperature sensors
Date: Wed, 29 May 2024 13:52:01 -0700
Message-Id: <20240529205204.81208-1-linux@roeck-us.net>
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
support for configuring PEC (Packet Error Checking). This patch depends
on [1] and is untested.

Note: The driver introduced with this patch series does not currently
support accessing the SPD5118 EEPROM, or accessing SPD5118 compatible chips
in I3C mode.

[1] https://patchwork.kernel.org/project/linux-hwmon/list/?series=857097

----------------------------------------------------------------
Guenter Roeck (3):
      dt-bindings: hwmon: jedec,spd5118: Add bindings
      hwmon: Add support for SPD5118 compliant temperature sensors
      hwmon: (spd5118) Add PEC support

 .../devicetree/bindings/hwmon/jedec,spd5118.yaml   |  52 +++
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/spd5118.rst                    |  60 +++
 drivers/hwmon/Kconfig                              |  12 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/spd5118.c                            | 499 +++++++++++++++++++++
 6 files changed, 625 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/jedec,spd5118.yaml
 create mode 100644 Documentation/hwmon/spd5118.rst
 create mode 100644 drivers/hwmon/spd5118.c

