Return-Path: <linux-kernel+bounces-383016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3BA9B1637
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70DC1F22760
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911231C6F73;
	Sat, 26 Oct 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlgg9d8M"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591CE217F3D;
	Sat, 26 Oct 2024 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729929952; cv=none; b=p89f4vKEw+K479ONtSm5tj3+WTRjFBRGgx4EtUSqQ6QxjZZDJ/uVTWAS/BMpyAACEW9Z3Nl0MMFvd6VYEGWiBvNfTIXR/Vk88HRkAireEtHvDN/hH84F0t3kszqi7MZIbgbWAh9E5ZZl9L4GP+3e5KnGTQI8wPRidk1UHYY1gq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729929952; c=relaxed/simple;
	bh=Sh4OlSUSOinU9Gcmy1Jjef4XWIvja88x5RH9Cl7atfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmplLQvzlx6B0FS+a08U1m2fCyyuwUPVdskfndAOFMnqQz7CKK8l1MT7ZZQ6UvcgaKi+vmyGIgwUihCLRkS0Le0jQJsjNwLX4baDhboIGq+cciujjrb4Dc9Gl4gbeyrO7Cy5/ZQXoNMtD3hY7fZenR7ysM1sA8WIfQBkAAWFjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tlgg9d8M; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71ec997ad06so1994645b3a.3;
        Sat, 26 Oct 2024 01:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729929949; x=1730534749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2aFdd7lTNXY2oBADHotB5RImOsGkW4h5/amm8EYmlsM=;
        b=Tlgg9d8M+ZLlqyvxRdAw4+y+EjVzuGWW8L2Zz7x48L0/SnK4X4iwJHVdbC12aSJ9n7
         Hm7vuBC4rNX72xkV6JCinGPmE64ELimJv9vmrwv5AxrQDIn8VHYKaOeRTVuSwg6HZfkN
         rAn5fiBa7BpgwOd6osROosseOJCRf6IXGdB7HMheaxYbmrHTb1jcQ34URd2CeyKDXCFD
         QJtEWdeOaulT5FXp32GYrDsVMm2g5d5uPLqXsCisK+Rp2wmjLZNovw5EI6u0laU4ttIq
         50SvVsIJEbrwCdUxIcRkQGr3Mtd0W+6mrKFhGp27yZwM2IO3NRoznvO+1bP2riAWqPOY
         TxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729929949; x=1730534749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aFdd7lTNXY2oBADHotB5RImOsGkW4h5/amm8EYmlsM=;
        b=CebGY1bPt1/CnLTwew5K+9NBCheUZmuyoO3shl+UsFQIxi3z3HUOl1iqj35020rm3k
         IaFTvgZZRJe9apTPlMPz+JYkQGteHzBU5G5VolnIIDTPDE9pyG+evBg2Lqp3iEs75MyD
         9yMKJbJK1BOsGO1arCW9pfuKqDsfA3fVyKfND6qz+qcS01786ZP/vKhtfQSL6p8n0Nfi
         QXGjzoZB8q1Fb+/q6ihgyRoV6yr0GSGHcr81Ix/RWTzeWBLPamY0tu6/v5ryWq6kVYqO
         5RysH2lapwMP1y/k7dX6xCbydqf0dMqznXaHP099l9xkH6w4o9SIRGrJ7vjwZHQAimqW
         GYQw==
X-Forwarded-Encrypted: i=1; AJvYcCWsdHXnAgjKQ6/mxyoez1afACdxKCQcpnvKGOINjao2FmduvRB1L2bX1G6WgTOkGjPu0JVdM30g4qr9@vger.kernel.org
X-Gm-Message-State: AOJu0YytqW3I1mfEeyTXP2jLzXwVNQkoXaXygp7PLG+W/loPONQ8nKGn
	8xdRz6L7ZO7WvDZoezWpVF7W4amto/TAU195sh4hZHVLozzuiqKyo6CXOw==
X-Google-Smtp-Source: AGHT+IEobrp6c16eCTSQLSlp+5xfLaJ92nM09kQGa8uE5YlpoT0Cly4Sh06grJPzEFb3sZV1Pl4a2Q==
X-Received: by 2002:a05:6a00:985:b0:71e:55e2:2c58 with SMTP id d2e1a72fcca58-72062fb3d24mr3470459b3a.15.1729929949153;
        Sat, 26 Oct 2024 01:05:49 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:4618:4c6a:7feb:e53b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a46f68sm2288666a12.89.2024.10.26.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 01:05:48 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	akinobu.mita@gmail.com
Subject: [PATCH v2 0/2] hwmon: (pwm-fan) add option to leave fan on shutdown
Date: Sat, 26 Oct 2024 17:05:33 +0900
Message-Id: <20241026080535.444903-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I sent these patches a long time ago, but I didn't cc them to the DT list,
so the DT bindings changes weren't reviewed.

There have been a lot of changes to pwm-fan since then, and I've updated
the patch, so please review again.

Akinobu Mita (2):
  hwmon: (pwm-fan) add option to leave fan on shutdown
  dt-bindings: hwmon: pwm-fan: add retain-state-shutdown property

 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml | 4 ++++
 drivers/hwmon/pwm-fan.c                              | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.34.1


