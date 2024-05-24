Return-Path: <linux-kernel+bounces-188260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A08CDFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC222835B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34F3B1AC;
	Fri, 24 May 2024 03:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Hv/L3+R3"
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36823769;
	Fri, 24 May 2024 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521791; cv=none; b=rX5UjMJkgRs6iAhtUR87QiW3ndgyN6IrUeglFaO26l1jJ4L/0b1HwkahrqGITPWx5g/v6IMgRKLQ8NbS4ffpjPSnZcHCSy0++Relw3GpcfDQrYb4x/49TbLocvMktLi4kh5407+l1zhNZ1d22946qJjBhbT44P5OD0B4t1rf4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521791; c=relaxed/simple;
	bh=ek6UmWLXK8nYduHntVSxP/dsgz6IetPMTwjA0Jx7W4Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tTwSGF5L2YWR2zCwC7yG4UHgQ1JP54nRHEzGNA8psSTWhq2qStzmejBv5VuiZ5CRfqHrrvG3yyCNgcM3R3JwKOm45bhIct8xVlOxvrWbdqP3wEGqPV4LQZyUhuHWY7/4RfVWWVe2OD72TenTo+Fmkktjeb8scGiLQVmyjw7TNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Hv/L3+R3; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716521781; bh=KZ8llW7PPo2JKBuxKIsoxtxbFEW9rp9tvBG99x4q/wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hv/L3+R3eDM7YBWaB67KaJaBM0oYm4RIWRxInfhomKuM5YzIiprXmr8la56jl42ql
	 38qhO0nM6zGXsLKIaKCkyHyBUgKiVKZcnk+WzMp8HY6BgPairH8YITjGxTSkbLTySo
	 K66WJBdXznEvuSAd4u1+0xVuekGIFpSiDGfJRyH8=
Received: from cyy-pc.lan ([240e:379:2259:4c00:b652:79f2:d4c3:c8a8])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 90C8A481; Fri, 24 May 2024 11:36:12 +0800
X-QQ-mid: xmsmtpt1716521778t5i4qy2rz
Message-ID: <tencent_01F8E0050FB4B11CC170C3639E43F41A1709@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCDSzsEAV2QCRH5vaNsl79saeANBHcFPSmOQXivvawGLedK6zLPr
	 C6mSD1uDd5uzWWi/YulJLDc6Pv1YEnWDxHt4Q4RMEjMcQ6DREjst3OQ50ccNhNHM6FgOCsRMidEN
	 9d5Z1MN9U3Q0oZj1mFNak0IlCin00nFFFRlFoIMVSYP7xIWFYnhT86cetkL5bZmLw1ZubkdPOkOu
	 AA0K5pmNaEuyVTmxrl8mJHkY1I30DjBXy5n7hHN/zGkq7HrdcXELbBfDfabAoXlX5mBONAh98Jg5
	 0c/q8wI1fMwYEOfcNFVs0M1nAJwCGzstvrgWFgyb2Auf6S2FjwkK/PutecdhGw+dxsmbB6Figlz4
	 tmvIGL/NDEWmVkuYayN9DjjZX7i+c2fd7GIcZsX3Q495Q3UVQDyQ5fMMVFCWONEZ80oFbop0PXEI
	 6Yngro2Hi2QXfImfUjlw1xdvhrQIDQCe8/vZQIiLxUZ6+o1pOxtshHt/jb6iVFb3E6I9q5OTJf8y
	 uZ9mR6XiwE84P8o6Mmq02Vc3K1SthZJPSzssHIBeoSWXtzjPKkwqsH80IwI8igtOn1W6Z4uBERu/
	 TQjvcIHWMLhuquWvRiisgE47b9IVjH1lKDkfJDQjsyQrY68NulOIbWvdg88WUHtgpfTQBgKH2+E8
	 BeHJp4hIbK1IiOH37zNW5i7xQhZ3EdYFFl4Lp5jNlDwIZ18DnJJgmJRsp1L81QjXPv9HFdqjb1Qt
	 dnsI5Jj72QFS3A+mJMTyt8Vt7iiEgk0oW8Bnt5fCTKK4Gku9MU0HMYqRfmYwduvzL9aI1tljLnmu
	 V6AAxUCpEVsrawdKD3yFfwwZOQXm4xik9Q1iNN6msSOTBJ0IixkJb9Qe4WoHUSgyiMrtIXuuTkRa
	 xVQcH3k4SWOYt+cKyubf3VDDP5UqMN3+mFkAIblOdAQ6ElzEpJbpNxdwotl8BDWzA9vGh3KlFFWm
	 8Ma06Pq55hrXIoB7tHKGdq7H/Ym+uz9v2GBXmsyeRBiB0wZgMbxaByOMqJGGFtoHEVkBaY3eyc6r
	 Ij43nubzE6o+1kO38R
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Elliott Hughes <enh@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Evan Green <evan@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 3/3] RISC-V: hwprobe: not treat KEY_CPUPERF_0 as bitmask
Date: Fri, 24 May 2024 11:35:59 +0800
X-OQ-MSGID: <20240524033559.298935-3-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <tencent_1E3506F09D08066B8F3BAEE136C4F887540A@qq.com>
References: <tencent_1E3506F09D08066B8F3BAEE136C4F887540A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the value in KEY_CPUPERF_0 is not bitmask, remove the wrong code
in hwprobe.h.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/include/asm/hwprobe.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 630507dff5ea..f24cad22bbe1 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -20,7 +20,6 @@ static inline bool hwprobe_key_is_bitmask(__s64 key)
 	switch (key) {
 	case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
 	case RISCV_HWPROBE_KEY_IMA_EXT_0:
-	case RISCV_HWPROBE_KEY_CPUPERF_0:
 		return true;
 	}
 
-- 
2.45.1


