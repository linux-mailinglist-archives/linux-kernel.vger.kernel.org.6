Return-Path: <linux-kernel+bounces-516312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAACA36F91
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BC93B0618
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41D1E5B9C;
	Sat, 15 Feb 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoa/mzmj"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6011D89FA;
	Sat, 15 Feb 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638523; cv=none; b=hzC/Q4OXAD/RPPRZhdZM4zpbskXHKb0ys9+V5N6PqSRy9KAZR8dtNcbATrJlco58ONM3Ljxv2uY24EP9EjamdCMN6a49+cHWlHAa2/3ASF1SETcobUV9E85WSPvXuBHi1hYO6zMOFxZQoB2st2WOohX7eT+TCDlgAoG2JiYdC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638523; c=relaxed/simple;
	bh=uy5cH16JsX4JeqEfRAx/FFIcMBDLoTmq8s1tlKdmEhc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=N3fsLbd/tglMF2sVWnGUsVFpgBzzrja3AOtGCB/ueODL61zUlumnCAvc9WAh2HHCElyyRql5XQQJVjBUoEny5yxZE6VxZRaTRVEHT9AIGEYBU6NVLulgotk0DXMDZO78AcqBHlIgXFnbm1Fax3KzaG0kNyGVUScqr4Q71Tyzjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hoa/mzmj; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3d3bdb08eso1535899b6e.0;
        Sat, 15 Feb 2025 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739638521; x=1740243321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fFgotg9MMog9YPyVCTVdN/A41r7u9eJzo/q5sMJJgW8=;
        b=Hoa/mzmjsRbTVlojhp9UZXM1FE6F0iAgW6e5OfTeSAUkYkleV8QIgDZGebfCid1mH9
         xlPHUmhIrY8oTSORj+s5uREmov3LPxlpgEF61Zqo3TPg0/YQLpUA2wwuZsdcoAU6k+7u
         HYZ0lH4JuXavLNh0zgsKiGgL77h2yLd19H75UISi64oF3l5XCzRt4M/sQkaJmf39VQsv
         OWRN8zffGQ18B1BcVn1BrI9RpCN9oRnbt+obWlb+9WQW3dBQGyHdZMvmHprs3mLRQIBB
         IzA8u5PACPBBfaUrbjbxMVh2a1NVlFdMlX+HFJoVkgKKwhXl+KI0hD8pK/VNdL+zslCi
         JjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739638521; x=1740243321;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFgotg9MMog9YPyVCTVdN/A41r7u9eJzo/q5sMJJgW8=;
        b=Aac4KTZHlvi8dBDNSkECS0HpIGBzNZskgKBVR3m9Yfx34GfHP9y/F3JdFj5F8d7lgA
         ZecCQ+BvQ2ygUDRUSD1p3lS64QxJ0zTQt/BXPRQmf75pICXi9VcxfRN+PvkpM4bJ0Sgm
         qAuQRRM8bcVMznNFt4H2htX9QygpTaGyKhWFJygX/+953zzgP3iMXk9LQ4VSoi/zyDY1
         kWWbNb6G1CN9sQ9qx5I2XQRClO8AoyPo//jxwjLtJaOCZBWvLQp+DB2/j17qTrztDcVb
         jC9O1JGbLy3JhoWc2xqMozSW9GCpevyXqQv4JyNoc6rin2852boBqBMxw3+k8/Hvcp7W
         542g==
X-Forwarded-Encrypted: i=1; AJvYcCUgK/6BEuiPgEslGFEdXIvmp2edj3KeGBMWsb846HJb95dZQz/APZPHnkX8E47MvIrTk2HsTLKPt20i/6qy@vger.kernel.org, AJvYcCXLjPgYdP9zOAiGjmJnOeI4C6lSFq6ozM+HgKlD8LK4o2+V88WMQZRg5G2yCdrRlhRnS/L1b3/dNI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFjfzqoey/Q1fm+rTuVZq9Si8GEIzTm4i8t1z+U5Yw3zM+/fs
	+bfGd2alfU9dhEUDZmRV92giz2uzkjWgHJ3lbSnsh9Qjy5dqZ6K3+3hmsRfPsTtDH7ep/3VN/oU
	aVzFOW3aCv/7VHc6UuuM+fy7yOtY=
X-Gm-Gg: ASbGncuPGSLKSW+D3rPi1izAqRAXcn5BdN5EhjP+t2peObWVgzYse0PfP6k61j9sjMh
	2IJ/L0yEdtP5SgVr9FvYxk/uREtbaPl4Gk7IUZdw4Z5CT2md1PG5BJ2fJ6EDQB+KmS+M4U1k=
X-Google-Smtp-Source: AGHT+IGCeHqx4n/KP1WhydFUl06V5Mg/NgGju0fYq3OQFHyEYALKBBy4copQaMnqdqXEmQIOL1jxBiT1Y15BV84/x5Q=
X-Received: by 2002:a05:6808:4496:b0:3f3:b657:cad0 with SMTP id
 5614622812f47-3f3eb0a42d4mr2338650b6e.4.1739638521092; Sat, 15 Feb 2025
 08:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Sat, 15 Feb 2025 22:25:08 +0530
X-Gm-Features: AWEUYZlnpn4Mw298NiG2Y9osPZ8n71VgEmJmjCOVRfOFQySR_9VyTWgb3KziY7g
Message-ID: <CAO9wTFjW3i7C8wQEJ3kjdNMwQurs_bmAw8JN3rbsLVDuPFQ0mQ@mail.gmail.com>
Subject: [PATCH] Documentation/mm: Fix spelling mistake
To: akpm@linux-foundation.org, skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

The word watermark was misspelled as "watemark" in the balance.rst
file. This commit corrects the spelling error.
Signed-off-by: Suchit <suchitkarunakaran@gmail.com>
---
 Documentation/mm/balance.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/balance.rst b/Documentation/mm/balance.rst
index abaa78561..c4962c89a 100644
--- a/Documentation/mm/balance.rst
+++ b/Documentation/mm/balance.rst
@@ -81,7 +81,7 @@ Page stealing from process memory and shm is done if
stealing the page would
 alleviate memory pressure on any zone in the page's node that has fallen below
 its watermark.

-watemark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd: These
+watermark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd: These
 are per-zone fields, used to determine when a zone needs to be balanced. When
 the number of pages falls below watermark[WMARK_MIN], the hysteric field
 low_on_memory gets set. This stays set till the number of free pages becomes
-- 
2.48.1

