Return-Path: <linux-kernel+bounces-432987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8169E5298
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812C31882BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1C206F2D;
	Thu,  5 Dec 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Prxs7ROf"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0835206F18
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395138; cv=none; b=dHMxPZtO3J4/YIoqk/tTDAeoAdSXpchambXkup1W75UjCFfa2Cb/CC02J9fEB9FaZt5E7DLgI4IV52iYoE0Q4V18/wBhCidduV1NbV6SrD0UzvXM7Xd75APOjfT3YPvkaYa6jzsmnuIS1wTneOPHdFOsLsIk+uQJ/7DN+MVcez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395138; c=relaxed/simple;
	bh=fazeYO8J4gmrtAfZJ1PS4e4GzNzk2PD13l8YNImILBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=baE2octEgf4b1Wss+rVU0S1UvES216dwaYNfzwHol0iyUQ11kKH1niWLX2+/r+E+IiLuDqCdL/haxwxn7Ht34yBWKe2JI9K6bxEbdqT2Hozd8LRGeVMOgoUqm3IvZsIVe4bd26m0J2bqk8IC27u6ZQbgCpwyde16U1Y4FYCjlUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Prxs7ROf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725958d5ee0so745118b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395136; x=1733999936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfDjQEoTxdpd9iDlK1ps7bFltPFhkJicFLVtDzgiM9U=;
        b=Prxs7ROfiWPKBzfP6opIbB8o29k/FGsXBUZkXA7gB+CpA9TdE2LOAT4lYgpwmYgYdd
         ENoQ8TFHpsF78vw/uTDOwcI25b88ZO2X0DpNm4GQ1oDEFZ76bP4DPvlItHqxwnKZKFLX
         Gy8uWjUN3cJQ/zv+SoTMHTbXu7M5P85g4D/uhZZZ365eGdLYx0rVIMOS/r5KJ4+Es2gb
         J3l1/BhNzJx9eK24FUpFNVZXNZG+tfa7lzGRWNBYVcbliuegctKm6cP1nJyecT6O41aG
         CcHIIjJsvhxSGkfwT9LG6f/MFMD6cMRsLNNn5UxnRJ6fe3s1a2RsHU9pilm02FFmF/xg
         TVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395136; x=1733999936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfDjQEoTxdpd9iDlK1ps7bFltPFhkJicFLVtDzgiM9U=;
        b=QOl8cEhmaE+7WbV1ONvSZz8/CpV9GwJf9BGJN/rRCQxrHsmKUFUVuqAFuPeW/fr7jd
         qHD0PO9EcuBbWpsCh6j9cnIdb3bLyYgLbRcDUx1k9JY5iBzv4pjrdbQnAwrArep5eNx1
         ztNpTGsPCLAN8D/CvfYFo9Xvu2T6Yk933QJXQO+9E9sG7uBnsVI+G1NTnYTGp7bh5DK3
         YU16aEv/EER82EJlV88Wi6TwLRi4CmcLJBbbnqEQ5M+ZKMD4XDma3CxltvAvSt160KKz
         9HX+hD9KK5Eg49pIW18DUsZAKJ+tQM1uZjkvYjcgpfO3ia8Pq3q3QQyBTUVIoP22Ep95
         yoGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ59XU6qwEHjwnvJZLq0ivuBmb+UZHEXmFfyUVt+vL8swExN/j8rOYlyyHDFCrEeAMVxohfvsKEY+33TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9PzVuK88fw/hP2coVC84KXVJ6zbDPiFrMOWDL8Rcxs6rJJ35
	hCFRyBs+6mj2mPJOBDLTt2bvpZq85m6orOy+lVKgP7z32h4peGciE8dOk7LwoZQ=
X-Gm-Gg: ASbGnctMb8Klf4XgQWszGs+XCdMugf2958PPnUJC0hsr0ITowFMhdEHNxv2wn2g9nvz
	dVsosPnkc2ig6k1w48TBU/9/qOjCHg9z2S7IvIOkyO7sHpSrDwp61M4GtmSLw7s7F5qNgxn0Amj
	4ofFWBGqJjz6XGbjB7KZhUQB6f6Zn64QeLzz8MbtM4FoGrO9SVSvuzhIV2rwlaymFt9y1SG+goD
	gIKP5eYku4KDOzQT4nioyMlACwsDqVN8pHCU+F9wMoiunHfDwXltLI/KAtj11rJePOtQOKRvZEF
	J/tnOXRT7KkWLTDLu7fLVFoYC2R/38X8
X-Google-Smtp-Source: AGHT+IHmLj1p53xhXYUvBEpMrjDW3Wg1vBwEcbP7EM0jf/sz5snayXz0eteUjpLhTi1nk0wWuAYigw==
X-Received: by 2002:a05:6a00:1703:b0:725:3bd4:9b52 with SMTP id d2e1a72fcca58-7257fa5a308mr13643770b3a.3.1733395136132;
        Thu, 05 Dec 2024 02:38:56 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:55 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 19/21] riscv: Kconfig: Adjust mmap rnd bits for 64K Page
Date: Thu,  5 Dec 2024 18:37:27 +0800
Message-Id: <20241205103729.14798-20-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 592eb5766029..9dfe95a12890 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -253,6 +253,7 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
 # max bits determined by the following formula:
 #  VA_BITS - PAGE_SHIFT - 3
 config ARCH_MMAP_RND_BITS_MAX
+	default 20 if 64BIT && RISCV_64K_PAGES # SV39 based
 	default 24 if 64BIT # SV39 based
 	default 17
 
-- 
2.20.1


