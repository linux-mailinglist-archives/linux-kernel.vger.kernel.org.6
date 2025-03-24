Return-Path: <linux-kernel+bounces-574540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E6AA6E690
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38EC3B7B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA75C1F1314;
	Mon, 24 Mar 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVghVR8J"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456B1F12E8;
	Mon, 24 Mar 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855245; cv=none; b=h8GO5XYERvgzBwzQ/aTwDOknfQGFNjf/tvYB5GB7OwS3WjiEXd3O30+IXgyiOsRZVP0MRHw6b/PjSLfHbmwCeSgUciIsKLBQPGQf1vkTgT7/5rN6nK90Rpj9n3bn4AFrnprWy+l8GXH92kv0G7FOnJa5GNXePAmtW4p5Xgyb/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855245; c=relaxed/simple;
	bh=ohffHH845V3Lt0D2FOLo8mRcnVmmn0Ok8YvCBQVBBMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnY8yQ2bg0FJi7VVIu32+WxYna2xhxsXwe29YAol35muIwZwOyLBqbooI7naeFFZogT3qXZIah9OU5R1P/5lPl4sWnbyBkNwiWiMfD2t7ip28uUJ/m2op/HPwJUMc7obwkZLMFEqzVH0TyPuAto36pOX2q82T+5Xs7maGbXJ7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVghVR8J; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so61356921fa.1;
        Mon, 24 Mar 2025 15:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855241; x=1743460041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1N9vZwz1+SrbvTc3slii/IFBENJL9mXjIxTUsSDHmU=;
        b=UVghVR8JwfXL06HBO5376TcedRt2ZdiumW/JCZ9h0nuL+1Kqjuwpm3z52UJ9EUcQgN
         swqw/Bif+qXxvUmOFf9fAbaxfbJ7VDcYJY+KVwWy7tF/ndm+tTOfjuc5W4wijJf/Yz1a
         x5Hf6T4eQnH7W8XZYixgCoQff/XSSvkn4Kgjm8IyPn+Y3qBp17yfLtJQnTrKOc4yF0id
         BFtF2uyA4AP+ErY3IP1jYFhTbgdu+JoHarDZ6d/aeiw8phSxgMnJOB5/XWR/H4Ho3cav
         lWBpDtHc2PARbMCPWhuC5lUMk8ulL3zvPxpRCXzJs2OA+NxYWXUpZ4476o9gQ+OR9ILL
         8EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855241; x=1743460041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1N9vZwz1+SrbvTc3slii/IFBENJL9mXjIxTUsSDHmU=;
        b=tKnKptbdl039ru4+4Z8TF0Lft+T+81zmwFxicbNufGhuWhzxiByKm6PS159BiaxA3Q
         ANU916ZkSglX7g8Mb0W800PiF7Y52vy/+KQt1ny+0XLMXNaDcJUU63OY+SC6xCC1BqhM
         K9X72OGqsqrwtdZZvKDlUiT6YBRNt0ccvTf5fyo+Q01D3aXft/BGhwaL480ovL34DiVU
         1D7fZohiqy8GKQtxtMtoPosKZ5BOKDadORMbYkiHCEC7sHkWJbGcMSqrHIZDBaylvl49
         4WsrUGWSl13e7tdrGySN77ZpPG+hSdT9vkp+IzUG3KDhJ9THx+xPPNCgUDfGwJpFHR94
         v5gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPqkqXPqSMzVx83OxaEZQqAFm12cfZ9qdMBhIfjhxfSkoxcTyPqXfosqfCCh0M/+i+Z9lBF1RX/g0oMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDA+V6mMPovUoiVQCpdRRGsr81UKmIwTNCGiCu69tGhaH2vXu
	0Cn4wKqimue1Mmq3GO4dtS+sfFRDz+FfbrpcWxRIwWVZ4KmINXJP4nQbt0njt5Y=
X-Gm-Gg: ASbGncuOYPmktXvHKfgGDcp6tdWn3BQRCQuanh3VuI42G/6y+X7lFkW7uiGcrqZ4mIH
	PWqRtaiLCtKoiRdPxJzBsjAcxlXWwHXuMCrizMfsp/xnjw24iV16eXo8qRqttJpqOf/KX3H/vg/
	ID1O/ozHhLaUFVi9oC/pZAkfSMlgbkOHPkg+yN6O6tp0XQKdmyaXmdb7Apu4aRDV/zwYBsKh1C0
	IEERuCgdJmtYeaBEnCLccxKtXv5gy4hmCozutUuLAx4CRyoXuhA8sfa5QTP56CqXLwRvB4pd0Kn
	SOYG4KmeQx2yUrf070lgilZZQi3aNHNz4d2sE1ASGpWj8rnWOifBeArpeLYczibxFUCghKRjpIA
	Av8UNLx2kBp2u+zKTyTxQRZ8+x08slnhN
X-Google-Smtp-Source: AGHT+IE/JquWJ/yJsgqajAK/t/AwivqsaXfdXC5fW6R+Z5xVtoJYQnCF6kmk0C/YVmiD0EliNqHvbA==
X-Received: by 2002:a2e:9f0d:0:b0:30b:fc3a:5c49 with SMTP id 38308e7fff4ca-30d7275469cmr69560211fa.9.1742855240976;
        Mon, 24 Mar 2025 15:27:20 -0700 (PDT)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe8b9sm15860611fa.58.2025.03.24.15.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:27:20 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: richard.henderson@linaro.org,
	mattst88@gmail.com,
	arnd@arndb.de,
	paulmck@kernel.org,
	glaubitz@physik.fu-berlin.de,
	macro@redhat.com,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 5/7] alpha: machine check handler for tsunami
Date: Mon, 24 Mar 2025 23:21:37 +0100
Message-ID: <20250324222643.32085-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250324222643.32085-1-linmag7@gmail.com>
References: <20250324222643.32085-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Populate the el_TSUNAMI_sysdata_mcheck struct with the
tsunami regs

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/core_tsunami.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/alpha/include/asm/core_tsunami.h b/arch/alpha/include/asm/core_tsunami.h
index 3391e95754f2..8a3a1c6a508a 100644
--- a/arch/alpha/include/asm/core_tsunami.h
+++ b/arch/alpha/include/asm/core_tsunami.h
@@ -282,7 +282,15 @@ union TPchipPERRMASK {
 /*
  * Data structure for handling TSUNAMI machine checks:
  */
+
 struct el_TSUNAMI_sysdata_mcheck {
+
+	u64 sesf;
+	u64 dir;
+	u64 misc;
+	u64 p0_perror;
+	u64 p1_perror;
+
 };
 
 
-- 
2.45.3


