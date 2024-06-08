Return-Path: <linux-kernel+bounces-206958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDBC90108E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06881C21756
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B5176FC6;
	Sat,  8 Jun 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEKji3l0"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291CE56C;
	Sat,  8 Jun 2024 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836743; cv=none; b=R3qEIcNSk9jgs3TP9RJt21dOJr60DLDLIYTrII+XCFVv/i6J3z5KdUZ5KcfkCAixMJy/Ddw66Bvc1zl9NQiqsDtTA837FwAnTt0o1XVkDPTJDKxek6E5d1cmHhqXdyxyEQcYxnROZewfrv4qBSgJsDhqqMD0lhbsrraJo5rzc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836743; c=relaxed/simple;
	bh=YiFi9k3yhcg5sEcCNIe8rYvKW5jD8SiTgm8EhEuTlFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0qdPUPUuZGvu+m8xi+yIFoZSU9NIHaLQYq/EJJ8zCD7qywZ5RXH4g84dwLirsczifIwAABA9NPQ4iMeVkxVQljlk+bysXW8tFOexstXOQoSTTrGQq7pEDDUvFVXdEBYsCt1wKLyte+Li94Gewfuc6RsfHb6ux4GPa5fWTB7VhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEKji3l0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c685bfd86so711889a12.2;
        Sat, 08 Jun 2024 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717836740; x=1718441540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ffnlu3ANJTNaC0wI+kwZ/AOlcd1rxYX1jJF5lY8ZS1g=;
        b=YEKji3l0P1XTbdHDEDGf00VnEI1SQAfqeJuO6jZP8bhlNgpcfvM3G69EoHNn2tpNTz
         Ba7QM7HaBBg/If7ZmwGfJ0jqSjFXndi3jvBWg0nCwzCDp/YqNsasJCQ/oLWvfOaAfN+q
         vagF2vfUtZGTBYW8k3TXVjI1wzorAOBAAqMlyKEMLOnaNMUCNpEHGEmoMLMKrihLry5Z
         +NP05k+QL6+QXOExQXHa2wH1Ex9SrDFdF6CKV31jzOKiYAdzTgv0hDTvVYzjFWXLs5fp
         vPVbEYUAbi2FCpTMx5N5j30xhNXILg+Y7entg8xeJzBUmRiVOtdF8Z/g/W2zLrMSLEyV
         H78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717836740; x=1718441540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ffnlu3ANJTNaC0wI+kwZ/AOlcd1rxYX1jJF5lY8ZS1g=;
        b=pGEnMQxJuhMmXo1sYILjHl6lt0cyfGfOtziDrDTgBwZzUrts4yhDF4D24WnLH38bJJ
         6jlW/ZwMd2tv4xtorq9FQyCBLWO957D8v0ViBeji97IrN8Hqw3mUUDcrStOnA5AlDDjc
         a0utzpay+4C+A5OBih7HnekOOpe2eNgFb8Wg+m1/hxCZvaogfytBi3wf8bHUKyuJsYcm
         ykt/pQeHWEe6h1+o4TUxKaM9tNhbgEQXL7FZY+U8/eMelKtPpOnyarywJ5bZirSXdp/E
         xtqmd6xY37k1O+XRVm9dnXApBIXTrwCAPW4RgIECZ1OgMETLPaQuoo3pqtr/XpdjyjxC
         OR6w==
X-Forwarded-Encrypted: i=1; AJvYcCWXfUAKoF6X/pe9cYmBYmvosZkwUMxHkdm3su8XfQuhsi5X6TW7hMy/kOhAPoNLPln3FHgmLzvVIn+XI0l4Ge1dyk2bcKy1ybJLqOQ6w0xUVX1uGLtTRzVb0m+e4D421evXwyJ9Jof121aCosklIFWUobYGz2Ak+kBSkcer30yBrTpzovE=
X-Gm-Message-State: AOJu0YzEzDnSk6+NLvbqZXCp/6srQuWqH2S5mghZVl+D1DtskGljfTIg
	3LqZ8ApheA98VuPHJcawMY13aWWyGT7QVAta9NmG9tBZxT5XA5gxJV16dYae
X-Google-Smtp-Source: AGHT+IE8Af8oj2uiYZ1WDGftBKl3U35R7B8HyhQOQCwEa5/pruFl7t2x07e1FAcdtSu7CtGcbaVXaA==
X-Received: by 2002:a17:906:d79a:b0:a62:2ef9:131 with SMTP id a640c23a62f3a-a6cd56111bfmr319081066b.6.1717836739767;
        Sat, 08 Jun 2024 01:52:19 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f200400a86c445e36ca9cbe.dip0.t-ipconnect.de. [2003:cf:9f20:400:a86c:445e:36ca:9cbe])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6c805fa410sm359066266b.94.2024.06.08.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 01:52:19 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] asus-ec-sensors: add ProArt X670E-CREATOR WIFI
Date: Sat,  8 Jun 2024 10:50:04 +0200
Message-ID: <20240608085146.572777-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic support for the ProArt X670E-CREATOR WIFI board.

Eugene Shalygin (1):
  hwmon: (asus-ec-sensors) add ProArt X670E-CREATOR WIFI

 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

-- 
2.45.2


