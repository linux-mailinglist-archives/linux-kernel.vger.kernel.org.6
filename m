Return-Path: <linux-kernel+bounces-208712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A3A902867
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB1D2883F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE1014B953;
	Mon, 10 Jun 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUtY+BeO"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E566757E3;
	Mon, 10 Jun 2024 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043052; cv=none; b=OhLxgpQ35wUM9vi5EfgrlCuSjpkupSPPVO3+RJp8CcQ+Lvf7q3PEOeZ7112jVduaDnvrruJXi+ACNg2XX6mKnh/v2/8P62dGayZMEhxr3JZbzGEQgVPvfLCsBBYseX53cA8bWzzxt3qYabi8HO+1EL9jo6ql4eNpicHNmV4Za8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043052; c=relaxed/simple;
	bh=0eeEmyGuqeL83TJD2e5vEhbVdH476h+TQmS/Nc07uOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lyLR5QbF4Bb7gsB4EnK6jadLDkNpj0Kjch3bP4LIM6zaxUi7/M4uO+R36rlRC8F6H0JGWCqru0qXcj+08jiyh4Mb/SRty2lbjlb1K3Dwr129go3c5yDAv+Afalk38CHgH+0g8/PxTzHPx/17WqqCNwqpnkPx+aIS57NJE4h4Gz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUtY+BeO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6f38b1ab0so1139135ad.1;
        Mon, 10 Jun 2024 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718043050; x=1718647850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YeKd4x9T4zcAkJm59oT5TgzREq4OVAwAGCECxqy0L7k=;
        b=BUtY+BeO4lzwfa/i/S5DNaRGJnxF2aNjiWNYw2cWc/d8nlaaT5Fq2hB2G1P19Lihnn
         AkfqQLvM2fsEjp1YSVjj+v6E7Ponu6m7mdnGW+2oY1h4EY/46esCZpRb1G4Ajgq6AJ99
         Ghz2yQyEifpVk+aRg3JdM4MS7BtQXihHb+m/pB/ghZS5Y/ykrRDX703VlzVkEwgHK1gy
         DiAqodvx8ad9e4PgTQYRVu8YR+zzbizbdbHYVeYClAx3ifuc9f9LB5Sx21W54q1GsRp3
         hH61cxyLhAjFdDLvHmRbSOZGEY6pTz6qxhv49JskN4b08HdRA+235y552mMbrA/GHTcy
         YQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043050; x=1718647850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeKd4x9T4zcAkJm59oT5TgzREq4OVAwAGCECxqy0L7k=;
        b=BH4Mfdwbq4//SUneyNlIMSy3xHzvvFdvWzJXv5Yszj69HkWbiFbygMzCoON6pLq2pB
         3afj2twApvOYy79N4Lu9itFAONnECDbxMjvS69VIU74mhjLF8cVX3UFCjHgipjh/3/V3
         QyXe99fBGm0sjhBKzb06QYORnIWEf31fXCFtpgUEQjAkJOhtQhOiAUCZfheZntSVMEC8
         o5JdN1rubazxeZOvPdO0BUvw1NjbBhB/k4VI441A8Yn0U2gOtX4mIXQpHzphFjdpB80n
         FK0UHLWOLDhqBiGMlZK6fyGxbfoafvzxgVvRg9XY9bC7l2J+BG2CD8AQVCgJzc0rWDu2
         JuTg==
X-Forwarded-Encrypted: i=1; AJvYcCVtJFbWg24BM5SV+8BPli7WzK/K4JQcxe11ihsvsybgy5DEYmU7coAM152GbNvtyU9cyeE6YyFYpvB8JagHJAuRge+ADDzy+QI3fulJ
X-Gm-Message-State: AOJu0YwtDPmTn+xYJSWVANHvGTWtoxn3GVtWyEVTVs9PBBlhNVmhgFDE
	q0YuLZoY3BV6NnNenv01sJH+K51oMERxVif1CLZsUqC63eHujCfZIYeCsw==
X-Google-Smtp-Source: AGHT+IGQuJjDY8lBMCPcL+F3nw9NA+u4DIJa6vEMUA0EfyI2dLyreRyXab9dG7IEmSvJbduPFmULIQ==
X-Received: by 2002:a17:903:41cd:b0:1f7:2479:a52b with SMTP id d9443c01a7336-1f72479abfcmr13253745ad.65.1718043050147;
        Mon, 10 Jun 2024 11:10:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7695ddsm85604285ad.63.2024.06.10.11.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:10:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Potin Lai <potin.lai.pt@gmail.com>,
	Daniel Matyas <daniel.matyas@analog.com>,
	Andrew Davis <afd@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/4] hwmon: Update handling of chip-id enums
Date: Mon, 10 Jun 2024 11:10:42 -0700
Message-Id: <20240610181046.1991436-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the transition to use device_get_match_data() or i2c_get_match_data()
instead of i2c_match_id() and of_match_device(), the assumption was made
that the data pointer in struct i2c_device_id and struct of_device_id must
not be NULL (0). Initial patches changed enums used in those data pointers
to start with 1.

However, it turns out that this is only necessary if device_get_match_data()
is used. i2c_get_match_data() calls device_get_match_data() and uses
i2c_match_id() as fallback if device_get_match_data() returns NULL.
Therefore, it is perfectly valid to keep using 0 as starting enum value
as long as struct i2c_device_id is complete and matches the data in struct
of_device_id.

It is confusing to have some drivers start enums with 0 and others starting
them with 1, even more so if that is done inconsistently and/or if enums
starting with 1 are used to index arrays. Let enums start with index 0
where possible, and otherwise explain why the index has to start with 1.

----------------------------------------------------------------
Guenter Roeck (4):
      hwmon: (pmbus/lm25066) Let enum chips start with index 0
      hwmon: (nct6775) Let enum kinds start with index 0
      hwmon: (pmbus/mp2856) Let enum chips start with index 0
      hwmon: (pmbus/max31827) Explain why enum chips must not start with 0

 drivers/hwmon/max31827.c      | 5 +++++
 drivers/hwmon/nct6775.h       | 2 +-
 drivers/hwmon/pmbus/lm25066.c | 2 +-
 drivers/hwmon/pmbus/mp2856.c  | 8 ++++----
 4 files changed, 11 insertions(+), 6 deletions(-)

