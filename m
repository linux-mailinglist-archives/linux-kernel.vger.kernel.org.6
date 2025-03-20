Return-Path: <linux-kernel+bounces-569205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D660EA69FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FADE1891E51
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E4C1DF74F;
	Thu, 20 Mar 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="OyISaB4S"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA61BE251
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742453137; cv=none; b=s4nb83/AG2L2NT0FRBOfhliHH4auPWe9FjFPIR6oSHB7tLJFt5yw/cNqWkMpXAqE7Xuet5oJDlSlANg6m+vjR4aL3mZhFfVE/tg4u8cRElvS3Fae07r9y89OKB+yhA2RAa5uHJNV7lTvmDQz1vIn4snJDUUnA5nhuvxe8p+3yw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742453137; c=relaxed/simple;
	bh=MZNG+BVX7cGouQq53W6P8BuaER8CrZ9tO32wUI1canM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KQwBau47+ifI9P2eTcnRo3CwmbuGu8DWF/Oyjg7K+PX9fGMgZqlBaY183E3h7HUaBZW5Jcc+614NSewNcXKFl4j5dMKXGyiL9GloZGkwDOwNTEnsgbGlHE8U4gBMZbeEs2tfc+hY3TrHihNXq30p4oOcmWPLZvdvdWsPC/Ql614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=OyISaB4S; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2260c915749so3820885ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742453134; x=1743057934; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhU0CCYzwPH6e5BQwsshxnT9CXPSn1mC99YKcaPS0j0=;
        b=OyISaB4SB/D2qMdI4vUyL96+dYc8g34AxgSjIoraA7K+JBJcwbm+VUZPvAlAV5k77H
         LE7ukLtOINwyGpezJklSYbQVijmuo0VZTXiPjivqMcayJD6Y3/jeNzTNZ6KmHwC0kTeb
         673DfS+kPzWXiRn1J0QR8am1kej9lV3tW7mqK+0oxuxcrgrbBbFE0t6UiDRsy8eUHNOh
         /z9R1tVaX8+0bMyXTyOagV8JE+xikNFGb/kXVzzVQrKPQTVDn80DG4ONSVN1khHumDpw
         CufYNYMJiDjX+ggXxvLZdxgI/Tt7GlDuvH25siS+7fOo7glvXisrSzizAZDz5rR9HW08
         9euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742453134; x=1743057934;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhU0CCYzwPH6e5BQwsshxnT9CXPSn1mC99YKcaPS0j0=;
        b=qsBFeRkes/wfhRq/pOLJ4mdqVUf4bPScrOjfz1nSP6Pyxq8IAY7djZy6tqaCUqhv+G
         HDJITd5OM2xjXGMUP76YyFnQ4JWToDnDwd06i+AAdwG5OjIdH/mcU9fZ2Pvf2/00LiGD
         7xdjZGyDgCA39dS1ANUAy6zQhceTXpUSv2fv7wgvk8FXgyNxuo0ls0Y4AKcPLyUn2yeJ
         GlpYDHWScpZY7bqOVs4ImUli2Yg5Hgo36OJ06+CMdefwa4/YCvl8zZOBMXDcJ/NOm+zV
         F5I9AJ15l1qhE166oYPG5Gp3WMJojdOEmI8IEw8rr8ZzxGYVigiw1PRBQYNJ9SZWA1Eh
         HyzA==
X-Gm-Message-State: AOJu0Ywb8j8ey3Q2P+pjZzl4oN2+FqX4Pc6oahaEApPiUVMnRJGL5+7G
	GuDUlaEK3w2wYcr+WaQjTtESs1K4R9Ka7+PyH8XYzTYcTgkTaspdJ6IcRFsXTefOlxUW4nnANfm
	GmfE=
X-Gm-Gg: ASbGncuZjmwLCxrRcQWI7oet/zOrXZ4HHqgRNl4atESBct5BPZOnsCG8WHTYA7pT0oo
	WnrnKEwhg+53DXEU6b4VlKFlBHrJC6dGEWu7BIrekQfsU3wcoCFCEVu1gsl5x+AtXkBQ4ZOfhZb
	xQH5DZy4HyDQC1D1aCQf6SNP3l7LN32/CVnW+3KmgxnycPy0LPqnGGpmSnUF3XfVHYkiCvCZfLY
	00ok/sqoDgiKoVkokfm/mdkX6AOyAnaih+acpPwXsF/8xoJvEEclzcDjwGJDlTuSt5rqutX6Raj
	WjhW4yHoc0cA9hvWwYo9tKsHpiZ9AEG201IXFzzPw02WMPgb
X-Google-Smtp-Source: AGHT+IHxYQI012LD/A9G3mptf+LoPMP8WW8BPPA0Nzsnccx0MyoBOqnRurCBrtIx/V/sKN2UL3myHw==
X-Received: by 2002:a17:902:da8e:b0:220:d257:cdbd with SMTP id d9443c01a7336-2265eeb93admr36381395ad.48.1742453133827;
        Wed, 19 Mar 2025 23:45:33 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bd3bfesm126399905ad.214.2025.03.19.23.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 23:45:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 20 Mar 2025 15:45:20 +0900
Subject: [PATCH] mailmap: Update Akihiko Odaki's email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-mail-v1-1-347c2658bf43@daynix.com>
X-B4-Tracking: v=1; b=H4sIAH+522cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMD3dzEzBxdM0uDlMQ0U8M0o8QUJaDSgqLUtMwKsDHRsbW1AOC9kTh
 WAAAA
X-Change-ID: 20250320-mail-690daf51f2ad
To: linux-kernel@vger.kernel.org, trivial@kernel.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Recently I made a similar change for QEMU and I found I forgot to do
the same for Linux.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 72bf830e1e58..5f5582f71847 100644
--- a/.mailmap
+++ b/.mailmap
@@ -22,6 +22,7 @@ Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
 Adrian Bunk <bunk@stusta.de>
 Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
 Akhil P Oommen <quic_akhilpo@quicinc.com> <akhilpo@codeaurora.org>
+Akihiko Odaki <akihiko.odaki@daynix.com> <akihiko.odaki@gmail.com>
 Alan Cox <alan@lxorguk.ukuu.org.uk>
 Alan Cox <root@hraefn.swansea.linux.org.uk>
 Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>

---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250320-mail-690daf51f2ad

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


