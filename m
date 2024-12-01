Return-Path: <linux-kernel+bounces-426536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499199DF486
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 04:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CA6162C3A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 03:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2023741;
	Sun,  1 Dec 2024 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QketRCb7"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996F382;
	Sun,  1 Dec 2024 03:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733024891; cv=none; b=otGOr0Z+mRDHWTbtm3//fqdlBpNQ6wGVCMBvuYGWtRosCC6fR7UYzAzJpB8eT57FCkqRe7PAuaRdW7n72wB0P90NLT55D5UwsX+HuWALB3Wu4uHJ9edqkhnGqWNe0nWYl30naGS5FHKbqt0PXhbqMpJpyk8uNZGxysH0Yolr6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733024891; c=relaxed/simple;
	bh=6i2DoYjg0VzS2u5IbfoZOmLFNlbaUglivETR3+4a8Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c15M1aQdgBziGirbqDz+QNUlWn8dSON80w7il7qLfLa4fLjEhF8QVqn4POWpEdE+xuPCtep7V5IyidXPn2IEIstKiyEhJRaIZPMjLqcWP0PN65hqViOeMT1u4/jqK3KRTWRJ4l2riCe/9ZI9tI+fTOzOQIJbMyYYp+H48lTEScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QketRCb7; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so1988384a12.1;
        Sat, 30 Nov 2024 19:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733024889; x=1733629689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGF6HUFugfIp+0XASUHwacgWSOyYD6gUV2jCUySMzR0=;
        b=QketRCb7WJQd3oaj2vZy9QFy/n6W0z/7XhJdfM1k6LEr4waa2pvwX4qDLPjfBxxR52
         fS00udAOwUeJp+7hT+vnXzOsrESQ4659rphQajeh/Xh/IGP3yJ5wnH9RRsPNdy6zrlJS
         YHmT7Yo5QTGIdCs679MODnf0bKdEMKeDeT/tgOGrb1UsuJoW+O2sWb4pjBNtMdIytFd7
         lC08stnp9SDeXupYs6szSS43SNBPp6qY2qRAYmyXnTaXjAjE+snL1i8qHHStt3jQGx8N
         CQ91n3I3FL02iwDUGOhsE/ESfQDcvR3z7Kae5S0hLRx6z6ysSf1L6j/JUFc+GI/syBVJ
         n19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733024889; x=1733629689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGF6HUFugfIp+0XASUHwacgWSOyYD6gUV2jCUySMzR0=;
        b=egw0qH5RGBtSGpGwetalCgwjCFZbpsdKdiW1t3+EtikmrndtNwaaXHdmAv7QYYDEz6
         NTWQS2NL1XCZOHw8NiDahPd5Njaa6wyFD11KULR4tEbU1b9k8FeC0VrofGMR1zjAlaSB
         ZwC0uEhSyJXXlcniJL1Um6CtdccdQ+nixD0wrX8zsjGkFKaeFQSMKT0DrIgcIqf1KdzZ
         4Ctub9wcSj/Nn++wE/w86fqUg1rQM4A365QQjtgIcHaMVOuMAaF7h+kmH9BihKKosJoV
         SelLME0AglT9gWg8mW6hhw9LyGhpPa596Y4ecOs5/ue8DJVn2pF1ujCwKeLKOh20yq7/
         aDKg==
X-Forwarded-Encrypted: i=1; AJvYcCU1ne8TVvdgu6RBGeK4XOu3jiVN/XIga7gQt7nlQ1dw3csYXgr+J7fGFDC1dHCyV72ds0Pguv4DO24E0v7f@vger.kernel.org, AJvYcCWpjj2MQuU6tzSbeZWR3hHY0DINa5J97V8poaJuO18T1K5SgDH/LTEK8w6X9h3J+Wc3GM4j6QmV+kE=@vger.kernel.org, AJvYcCXKq/WJ6KbpgKLHzk0osy/dN77OVtdLIDmkxcZP8Q9nY0WiflSwTYKBZhzii00f50ZkP6+UEHRSFKt+Tws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBx4g2gI8w8G3ZNYKwFNXrpr2F5C1/99UlR4zaKWq3zy5T0/sD
	MP8TxBkywFF8EmywaN1zvS979+uYPR2p98VJAA/Yo8wdyiENYOyOqSeGydXO
X-Gm-Gg: ASbGncty0XEIxVNdyXCqtxFku8KlmF5p9N6nMCx45RY3O/pdu9KS8GuSYVB2Wazqgl1
	KtKX1O0IVisELq5+lo5owK9yqYPXDbfy+NFzLMWPBaMKVzn2YhjjirbYgSC+xGfrfvePY78JMEE
	141Un3xcf2FI4Q6ssfCLTu2eOom9k23mD07KZo5UgF8VQNIF6EeWCfkc5HF/THr0oDxeYbqa1Mw
	qSIv+MwGtnGEpLgvmTb2bru2/fiE+3xv5yMOhxAwUjASMgwiKPiS9TP4D1pxgrv
X-Google-Smtp-Source: AGHT+IFm6ABroHWsiBLzumLUURQUloAjNeJ/w9i0iDA5CeS2xhtgx5XOVO5BdYuoTcDB60O/8c9TDw==
X-Received: by 2002:a05:6a20:a10f:b0:1e0:cc21:19a2 with SMTP id adf61e73a8af0-1e0e0aaf55bmr24288684637.1.1733024889235;
        Sat, 30 Nov 2024 19:48:09 -0800 (PST)
Received: from localhost.localdomain ([38.47.127.59])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c321125sm5442471a12.45.2024.11.30.19.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 19:48:08 -0800 (PST)
From: Li XingYang <yanhuoguifan@gmail.com>
To: eugene.shalygin@gmail.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li XingYang <yanhuoguifan@gmail.com>
Subject: [PATCH v3 0/2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
Date: Sun,  1 Dec 2024 11:47:43 +0800
Message-ID: <20241201034803.584482-1-yanhuoguifan@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

this is my mainboard:
dmidecode | grep -A3 "Base Board"
Base Board Information
        Manufacturer: ASUSTeK COMPUTER INC.
        Product Name: TUF GAMING X670E-PLUS
        Version: Rev 1.xx

i use the version of BIOS:
TUF-GAMING-X670E-PLUS-ASUS-3042

asus-ec-sensors show when use this patch:
sensors 'asusec-*'
asusec-isa-0000
Adapter: ISA adapter
CPU_Opt:      914 RPM
CPU:          +39.0°C
CPU Package:  +48.0°C
Motherboard:  +31.0°C
VRM:          +46.0°C
Water_In:     +35.0°C
Water_Out:    +33.0°C

Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>

-- 
Changes in v3:
- Separate AMD 600's support for fanCPuOPT into a separate PATCH
- Sort TUF GAMING X670E PLUS in alphabetical order
- Link to v2: https://lore.kernel.org/linux-hwmon/20241130133837.24454-1-yanhuoguifan@gmail.com/T/#t

Changes in v2:
- Keep the sorting of TUF GAMING X670E PLUS consistent between the source file and RST files
- Link to v1: https://lore.kernel.org/linux-hwmon/20241130133837.24454-1-yanhuoguifan@gmail.com/T/#t
-- 

Li XingYang (2):
  hwmon: (asus-ec-sensors) AMD 600 motherboard add support for fan cpu
    opt
  hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS

 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
Best regards,
-- 
Li XingYang <yanhuoguifan@gmail.com>

-- 
2.47.1


