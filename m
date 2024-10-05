Return-Path: <linux-kernel+bounces-351704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87390991508
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315F21F22F6B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE48615A;
	Sat,  5 Oct 2024 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyDurwxI"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6E25634;
	Sat,  5 Oct 2024 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728111671; cv=none; b=A6sSskv2dnf3oTMSA0FPrLv7LZQWZt1BKJltPbwOtaAzpOzRwKdfiZ3dBS5zIvfYtK22pck0bqWdCgXOK3kVti3X/dtHcR/T/Qp7QQ8PiYLMx1rr2dVQwScU3Ir7/AHnn0FDYFLc+l8zTeAnsHyYC+LIMRV3iMsiP20r6QgoyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728111671; c=relaxed/simple;
	bh=dxm3C4Om4s/OmaZ81xra3vKu4d1cwnsd0fgChYAMcCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bP6PHEJxpCcWdrHzzjOKa1cj60nhKXpqZ9EI28/fxe/UsJZ2LoDS8rOc8zfzUmV2Smd4agjW31t6gteMu4/rqxZeRHI266xRx1HIDSjNfwc7+m4xXeHSSZEisRsVt1gY/x+wEcaGeFKJsrNVqna3iFe4xsR8FI+oMMX/arCoQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyDurwxI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71df67c67fcso81352b3a.2;
        Sat, 05 Oct 2024 00:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728111669; x=1728716469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QtLSqplC9FV8nH8TMNgp/DH6Vy3umkDQiR0WE8bXh5k=;
        b=ZyDurwxIieLrjweJCMCKU4W56/Z5g5x5AbkrfYQG/0Nh0XYLLQGfL0YDqNdKA7eNnS
         CpoiVzne5XmuQaPOMjxZaNXdC6r6iy0ktREmZ/g5wmj2mzMa7c0e3UCPF6e4Tm6taJRw
         wX+tRBmkxahShtPCtj9kmlbL+iYUzB4AqcRLgWX6ygR9+FcBui8n5Ce5+o8V+GiHLDbe
         Kns5aZhsg6AmyLNE9H5UawShrpJEVU9O9pskj6dXczQPbc+yuhhvKLMH8W5KxKffxXUU
         eXIEL1bknHMfufm34Q1NiROlS9nA8rqh2wGTRxTXNJgBmo8H3g7ISWESTShHQgoFv4Df
         Va7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728111669; x=1728716469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtLSqplC9FV8nH8TMNgp/DH6Vy3umkDQiR0WE8bXh5k=;
        b=ihXmA57mQmU8IH/mDROd3HwX3zd/6AeR8zV4hGkrRl6dEIzi8TOjnmyzu7y/RBn0Pu
         5yugYe7rEvjbEkXjfihq/gzJSQBSykQOEhsDq24fERdKtVpaPeYA0FGmo9cyw95fVfwY
         +9p9AOMDR85lXM32tV+5CpG4FjCSOl49w3sXb9TqbvwYLrZWLF8lQp9q4qs3XQfHFfLR
         lE3WzLoNdhYOduYiqL0lBm8Km0FiiuWgVoxxs0VWhlemUjfU5JJKzALsFVALPYI+2A4l
         EFGasOsfuWNs1LaSV+zgItCiTsF0DMKS5DoHtdb9sshmG4F28GbdAufqOAfOrVb6Op/N
         px3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLVqe6qKpXRHbxOVZdd5CBTjcxhV4qsetAzWewudUfvBJ75kgSgtfcbWi/CGpykosH8fwq63/Ag6I=@vger.kernel.org, AJvYcCXU1O/KUdc/bhYY12jatPrdb08jkVsQnKNx/9RH5jsxHkAb4Nb7jMkhaReXcMnEaP8tNwV9DQknvMvqn2SEQYvZBx3N3g==@vger.kernel.org, AJvYcCXxPcHCGdIYK4viRm97tu9I233twHO82Xg44XRGHiQ0tYkrx8B2CwIQFVhE+/x48KQW6ymTmmiUNFFQTbyM@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6bNMhyhFstTDLj9D8Ggx5L0bg8Ypp/fKXmDPuuoNWGBTJVQ7
	7Vf5Fd+pd09CMdS4ThEuEP3v8zUTZ/aeYv9yYZIjvi/86+B77ETq
X-Google-Smtp-Source: AGHT+IHDyw2CRlAmxK5hljDVThBX/Yp4zp+oRVi3CQGx6HqrSkrV4rDaTnwVGgArVsf5dcWx7rCLmw==
X-Received: by 2002:a05:6a00:cc2:b0:70a:fb91:66d7 with SMTP id d2e1a72fcca58-71de2445487mr8375596b3a.20.1728111668933;
        Sat, 05 Oct 2024 00:01:08 -0700 (PDT)
Received: from Tua.. ([103.161.55.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4a66bsm1062870a12.92.2024.10.05.00.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 00:01:08 -0700 (PDT)
From: Anaswara T Rajan <anaswaratrajan@gmail.com>
To: W_Armin@gmx.de
Cc: corbet@lwn.net,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anaswara T Rajan <anaswaratrajan@gmail.com>
Subject: [PATCH v3] platform/x86: dell-ddv: Fix typo in documentation
Date: Sat,  5 Oct 2024 12:30:56 +0530
Message-Id: <20241005070056.16326-1-anaswaratrajan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in word 'diagnostics' in documentation.

Signed-off-by: Anaswara T Rajan <anaswaratrajan@gmail.com>
---
Changes in v2:
  - Make the commit title and description more clearer.

Changes in v3:
  - Add missing full stop to commit description.

 Documentation/wmi/devices/dell-wmi-ddv.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/wmi/devices/dell-wmi-ddv.rst
index 2fcdfcf03327..e0c20af30948 100644
--- a/Documentation/wmi/devices/dell-wmi-ddv.rst
+++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
@@ -8,7 +8,7 @@ Introduction
 ============
 
 Many Dell notebooks made after ~2020 support a WMI-based interface for
-retrieving various system data like battery temperature, ePPID, diagostic data
+retrieving various system data like battery temperature, ePPID, diagnostic data
 and fan/thermal sensor data.
 
 This interface is likely used by the `Dell Data Vault` software on Windows,
@@ -277,7 +277,7 @@ Reverse-Engineering the DDV WMI interface
 4. Try to deduce the meaning of a certain WMI method by comparing the control
    flow with other ACPI methods (_BIX or _BIF for battery related methods
    for example).
-5. Use the built-in UEFI diagostics to view sensor types/values for fan/thermal
+5. Use the built-in UEFI diagnostics to view sensor types/values for fan/thermal
    related methods (sometimes overwriting static ACPI data fields can be used
    to test different sensor type values, since on some machines this data is
    not reinitialized upon a warm reset).
-- 
2.34.1


