Return-Path: <linux-kernel+bounces-383586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CE9B1D9D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51686281C73
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1B1552F6;
	Sun, 27 Oct 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJyCwH1a"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C732FE33
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030910; cv=none; b=mNL1Ntv2vO3MRg+DdMvrP0LssR0rVHI2b/K76ldP0b584cx/E/xLKTnbknu1Sn+gZIDyXWUaXzjW/3tHdR+3eRTZgBJEkfYakDHLnJVjzXZiBlAekDvW4jDdMeBc3DpVDhHizHCq2IfvDmDcaEMbzfwkqJajsXnXedZ1HGIUxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030910; c=relaxed/simple;
	bh=D/ynVHYmqi2Ckh7aFWJwqCLmolJOnpYqtWvCpDp09O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neLpAjPyGUnDBYla7kl6DUEbQ0WUKx9vqGhmlX2UFdZ5hFKd+VMy09EXwTxYmPPkqCS/zTwKdylYLJFWZECCkAjiMIufITMARolNvkhCPPdZX6bnirRIf1JzsafetbooB0Y/U5A/E8oN+EDSNGLQbvYgD2N65EDVEzAlSDd0jOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJyCwH1a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c803787abso26246675ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730030907; x=1730635707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAlFXpVPV8uFWMmnJmNJ4B3bgnH5ueF+92q0u74/c1Q=;
        b=kJyCwH1aAHr+w0ApbQwn8jP59mwtutvZjpFn086qbxQwDujHWy78wdDBtOiu63qmQc
         XupcsMt5MaUmPpozQOYsNrDXqqnDx7e5ja8ncoRHpqR0D9BvWGgCpeiEZ1/jw+/SAo3C
         1geQ7X2XrOH6AIqO1qRAMqSijgsqcguFp70AwYfjN03jxHDexPEoNmjYJ0k4ym2O8665
         3DoUSnl37xDBwB3Rt7jGrtTa6vNK6UJVd7XdnDPFYerx0BmVMkpNpZhd5TSreuj0fAiG
         UjDxkvTs0mqxHVPVMCZxEapncdmtLNncnfNPibPF6u1nUwFL14N3mhhTKFLdC0D4xJ8I
         4CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730030907; x=1730635707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAlFXpVPV8uFWMmnJmNJ4B3bgnH5ueF+92q0u74/c1Q=;
        b=VSbyntgENS87KJ/p5LC75/YJOuM+yt2xpO1C8b08Za3OM3i9i0v/HeF9kJVWGPDG3H
         t9RGWIpCQVWqK0CeYhKYypLtEhNJdvLA0yrD3EMnuKV3FSLe3doUe+lo6fckUUPq/EGE
         wrGPEEHl2ds2ITwKVVG2TW3PQCjqOWB9SeE4PHijdr4/3FGAwg5lU0D9nKk2A6Bx2e93
         6T6AVz5ABnNyKQLqFpbthIKm6zcD7cfabcuDdWVDNCjaDGquYWmXZLqC7UHcYwe+AZii
         3XUXIJdZN8Bdsq+jGTIHKkSTe0gBKNXKgbmC15tT6i0Nhob7wrJRReIGcOJiiz5mHCsd
         XxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8/b9SHn3rsJjRvArxFD+OEAQ5eI8Gf4kEyPu3+IjkasqcnMQqZIubsejjD/aIxUCN+eD7PNxPoR2xNbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeiuMnsWGbP0h7DUCjEAiPQLL1hv9t1RRkZDDCcNMCAWrZrQj1
	hDS3CB87MhUSLExgHhvRSc6Ex1p2mPDc2eq5zaOvYR1tv+b2Dq8D
X-Google-Smtp-Source: AGHT+IHKTzcPBHYCFSnQ1nhY97KwfygCayjkBvcjT39mMpBhj6B1ICPcfkvwjOJwvhjJetE2jY9bZg==
X-Received: by 2002:a17:902:d2c8:b0:20a:fd4e:fef6 with SMTP id d9443c01a7336-20fb88d5d7fmr161143025ad.8.1730030906970;
        Sun, 27 Oct 2024 05:08:26 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf43476sm34897435ad.24.2024.10.27.05.08.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Oct 2024 05:08:26 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: dj456119@gmail.com,
	cunhuang@tencent.com,
	leonylgao@tencent.com,
	j.granados@samsung.com,
	jsiddle@redhat.com,
	kent.overstreet@linux.dev,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	Lance Yang <ioworker0@gmail.com>,
	Mingzhe Yang <mingzhe.yang@ly.com>
Subject: [PATCH v2 2/2] hung_task: add docs for hung_task_detect_count
Date: Sun, 27 Oct 2024 20:07:47 +0800
Message-ID: <20241027120747.42833-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241027120747.42833-1-ioworker0@gmail.com>
References: <20241027120747.42833-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces documentation for hung_task_detect_count in
kernel.rst.

Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index f8bc1630eba0..b2b36d0c3094 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -401,6 +401,15 @@ The upper bound on the number of tasks that are checked.
 This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
 
+hung_task_detect_count
+======================
+
+Indicates the total number of tasks that have been detected as hung since
+the system boot.
+
+This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
+
+
 hung_task_timeout_secs
 ======================
 
-- 
2.45.2


