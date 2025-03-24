Return-Path: <linux-kernel+bounces-574539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D794A6E68B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C3D173D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CB81F0E5C;
	Mon, 24 Mar 2025 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRQWcKgA"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE61F099D;
	Mon, 24 Mar 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855242; cv=none; b=pJv/aRa3Zgtm9WfKwKzpNzMfz+JxKMESLH5iOkT/TdOEWfPbCQaomUMuhn2Vgj8q9wQmZze2rrKGKnIN/A/TO6G3Pd6GF9McTpmxFSztDRYsFHIujIS+QYYmHiOzraz8wkw03SxEpycWukmvSDr06tECgKdKOjW0HxCEwiKAw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855242; c=relaxed/simple;
	bh=bnmIGOSo3Oj93miFUhgjK5PhG9w0bshxs0I1EZYnonY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ute/Szg0wFQXtr4Lg793D9r5aNkFtgoIUbzwaH8ztnbD7eiI6oU5AtDXEOGoF9xoyKWTMyprvbSoGHI9HdwJfEEwEagOMhJBbTwxKFTUMQx3+kU6HsIauMvHyBuX1qUDK+00kReFWRrxFF63uPNhmEpxBxLGhhgeA/wT5tV9Vx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRQWcKgA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso121661fa.2;
        Mon, 24 Mar 2025 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855238; x=1743460038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDoahxuitCMk4WP5t6poiYTnhoOTTSTYRI7m2AAo6Dg=;
        b=KRQWcKgAz6srSHVG0ACR351Hk+hxYO6zIeFdKxIRik897NpHkh1MUyIaPOYZoQ89YT
         YyxfSbpteWc+3qWd0dzH903bMQNMGbu+aqoGIXf881Xpl+aggbnscQe1ny2B+YxG+HPw
         cGjnqzngtFaOYsmQFT0A827H3ZoBh1BTLGXWeFqW8rOfBK9xu7CpAEZqkyw6ZJk+piXA
         RIIcobmq5L0cRe7Ikn29gGtbmHblTrzwuc7Ce9Q8YZ6ZnAemvR1sB3bHV1g2mFNL8xGI
         G6uS/d30i5wh5V7qFByR4UO12J78cEAuH2q+GsFizNUOGl4YNLXFYSlJ/LFns6nF7K3d
         9u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855238; x=1743460038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDoahxuitCMk4WP5t6poiYTnhoOTTSTYRI7m2AAo6Dg=;
        b=MKVaGBvgirIiMoyiTtRhOkB3Q4TX/ut67vOFzeSx5BkBh/Jql/jf0BMqB6+dy0jFQW
         21bdKmUgMEbRGAUvI+wQz93v8drsYys0F5ad/MNpWW1oLy5+ttxNHsMwtV6US1ujfUC9
         AcqhY2bMJZTV/e7N1ZMmG4ZTPrLq55yoZjK/wydbsqhpEKpEyd8MUzjR76UF/OORIRQw
         sa7qHy6ytKvr5kHZ+d6m9y0DLgEIr2kMvhs+dWnh1lqotB7x3XrMxx7htvxXzfX+TxOB
         eOTvII/6HA4GFbVTn3byBKroXKj9v+i5c5hCZs0kls2chtkUZNaIuZqTy68A4LEBWJxF
         q4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/OxtFtMhBmXUYZ1lGC/yh98aszkFmth0UmnArqfsil40W954pcKaAXFlc4KnaTi+rTx2gmqcuJNDvvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+zl1WaXSU1SqIa/Q3zTpXhg0Q1sV0mowS7emR9Xq3iiPgkB9
	tZCu/56fkF1FpaQYc3s2CeLOHrJ5TZyAlsW6PfzQWpCB7oIHHso6zdFqSGaOp6g=
X-Gm-Gg: ASbGncuwBCuRS/OQQowtS9e3GAf4odsvcs1X8CBR8MC4SCTefHYKtiS++rDPl7kZWTO
	V7txqHgJo0TsH94qoytHqKa6TYpJKL0tMzDuMCCIDXpLItHKczOYkb2UrP6a2wGSbF9KKM8/0nx
	RSw4cMCjA82c58an4CXsuq0CwPxqNUH9BMbZM1he2wOr+boO0wKVwtGXUXYMxIMW5lVN3SW6bwn
	uzapR9iXRH5u7jkG5y9c0lOvaqUTB6nRU1USxb3E+oSRGgczEeYUYS2T6jJn9GFV/aMLzVts+3D
	EyaOG6erfQQBaoqsxO8d5oRHFp3x/apApxNHCBsqYVK2+F67bdnfHKV60mQ3sAtBqSVNbfwMCTJ
	qQtWGYp6/qMBxf9UuhqRiNA==
X-Google-Smtp-Source: AGHT+IHt4wz6t77Nrazz+usL0z9NGFquepIWxagKpX4J0OkgwIScEmlNA/XNFVI4I2yasT21Cqonnw==
X-Received: by 2002:a05:651c:211f:b0:30b:a8c2:cbd3 with SMTP id 38308e7fff4ca-30d7e2ba282mr52562081fa.28.1742855237913;
        Mon, 24 Mar 2025 15:27:17 -0700 (PDT)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe8b9sm15860611fa.58.2025.03.24.15.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:27:17 -0700 (PDT)
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
Subject: [PATCH 4/7] alpha: machine check handler for tsunami
Date: Mon, 24 Mar 2025 23:21:36 +0100
Message-ID: <20250324222643.32085-5-linmag7@gmail.com>
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

Move functions tsunami_pci_clr_err_1, tsunami_pci_clr_err,
tsunami_machine_check to err_tsunami.c and enable pchip
errors by seting perrmask in tsunami_init_arch().

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/core_tsunami.c | 37 +++-----------------------------
 1 file changed, 3 insertions(+), 34 deletions(-)

diff --git a/arch/alpha/kernel/core_tsunami.c b/arch/alpha/kernel/core_tsunami.c
index fc1ab73f23de..7a6c1aab5f8b 100644
--- a/arch/alpha/kernel/core_tsunami.c
+++ b/arch/alpha/kernel/core_tsunami.c
@@ -346,6 +346,9 @@ tsunami_init_one_pchip(tsunami_pchip *pchip, int index)
 
 	pchip->wsba[3].csr = 0;
 
+	/* Enable pchip error */
+	pchip->perrmask.csr = 0x0fff;
+
 	/* Enable the Monster Window to make DAC pci64 possible. */
 	pchip->pctl.csr |= pctl_m_mwin;
 
@@ -448,37 +451,3 @@ tsunami_kill_arch(int mode)
 	if (TSUNAMI_cchip->csc.csr & 1L<<14)
 		tsunami_kill_one_pchip(TSUNAMI_pchip1, 1);
 }
-
-static inline void
-tsunami_pci_clr_err_1(tsunami_pchip *pchip)
-{
-	pchip->perror.csr;
-	pchip->perror.csr = 0x040;
-	mb();
-	pchip->perror.csr;
-}
-
-static inline void
-tsunami_pci_clr_err(void)
-{
-	tsunami_pci_clr_err_1(TSUNAMI_pchip0);
-
-	/* TSUNAMI and TYPHOON can have 2, but might only have 1 (DS10) */
-	if (TSUNAMI_cchip->csc.csr & 1L<<14)
-		tsunami_pci_clr_err_1(TSUNAMI_pchip1);
-}
-
-void
-tsunami_machine_check(unsigned long vector, unsigned long la_ptr)
-{
-	/* Clear error before any reporting.  */
-	mb();
-	mb();  /* magic */
-	draina();
-	tsunami_pci_clr_err();
-	wrmces(0x7);
-	mb();
-
-	process_mcheck_info(vector, la_ptr, "TSUNAMI",
-			    mcheck_expected(smp_processor_id()));
-}
-- 
2.45.3


