Return-Path: <linux-kernel+bounces-360937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBC799A182
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504EF280614
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E0217323;
	Fri, 11 Oct 2024 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Qet9wB8p"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233AF213ED0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642930; cv=none; b=vE2o7F1t+OQUUKQ5z233CTpACVPNWLlfjtnNlCOxLhB7+blMeoEl0fOLzMTTPcrckPw3PzuwTHTK2b4EkBeBy9HY37U83Uxxwt7dwxKsibLEKeCEFeV/vbZ3y5c+NfrHVeGiiLb/iSvmXLx7uzisgSQkVndblgw6RqUZMMRzJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642930; c=relaxed/simple;
	bh=Zyh1kxGx+805gAQRdQwvEh+ZEcu1wUX2qKohfPj8MeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dovs3CnbpWsh0AONxdgL2+ISg0T94+1/u2gYh+zQnvOXupo5i8fe2ujZdENod2YT29wR2G3YCMZeCKXkvyzcvHMNlDmNRi/IYeRW+eBcfP5MdnOBe6AfrxIPjGwrNDr5rT/PjIBaaWTHIt6dDwl8ldlfAwW8ilkutprRNUKV1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Qet9wB8p; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aa086b077so265671266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728642927; x=1729247727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
        b=Qet9wB8pqvi9deuYuNfI1jqMiD6Of90ez+zDHBfXtsSbosRZYGRQTVTd5/14RPFqys
         nEfdZR+GldmoTxV/EQm0hY2FkCPkkAEAMI50MQJO0nnTBUegInfe+ekS73jxrtsVC8Yt
         g7l+l3bynXaUaoyX31JbKtjhtDufbUstRFCzwVvE06dWOxP+FtiLyZfmZE3AswzMR0kT
         yGKONStYdod1XHOPdbABkFhZXYi2z1b22LsNyoVCWU0KTbCTAyUc4CJ51NWbW2mVgETn
         z8PT4aT6h2q5lIy+qGUSgePMXyGmGBlBEOMoLtE6tdgR9f+p33KgiqA+BMPGHnWX/LBU
         iySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642927; x=1729247727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
        b=B6ZxmydNDXAbHeAD/PAMYMyqCgiwuyYUYpcV6GDKDk/7B3nzhPC1jiYTPGYJcnrp7Z
         TnIHUD0nWJfL4zB++9Vau13F4QEdT495atbxtp0fpKKT++RvlQrbF52QgHWv9zTPMH0A
         B8mbw6KVs9fK7RfZcoRJwX7UOn1sCz/JC9tQvs9KmcEtgb+X7OruqVhyt+zymd09p4MF
         W4McgWAETD/29VJ9Wb6xqy0MCuN/zs9u4hboM0Yqzw/pLAbDUODAVCepKxL2Onp4jXg4
         vnvqnhmXtHpV4hoqtD2lHWxH9baoHeXfRYbm3guuK30OmT0dJHL7YhPw0wNrt36XJyt1
         zHFg==
X-Forwarded-Encrypted: i=1; AJvYcCXS0PMkFtpd/mKaC9lhPBExAEQuZMO02MiGxm0wSn1Uh/nBGQtyNW5IkbhbeD1jHYjV4eoA1lgT1Kl2fUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UyfoxOyYZcdOh74WWpkpKpL66EB7fkXxmRJ6wddJd/FXlsfA
	aknJn8ds8mEj3zc45V8diPzKeRAK8QjoBpP5wgCW8pt2wff1FQ6OKo+BE7UAXng=
X-Google-Smtp-Source: AGHT+IEhwHbLJA90IWSn8bl/coknUY+AQCYOqY3PT23wFnbUy78uWpMbKYCrqY9LbjzEgIUCvqOoCg==
X-Received: by 2002:a17:907:7b87:b0:a99:4acc:3a0c with SMTP id a640c23a62f3a-a99b95ee687mr198200466b.53.1728642927511;
        Fri, 11 Oct 2024 03:35:27 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:35:27 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 32/37] arm: Implement read_mpidr on armv7
Date: Fri, 11 Oct 2024 12:23:13 +0200
Message-ID: <20241011102419.12523-33-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement read_mpidr() on armv7 to make use of it in generic
code that compiles on both armv7 and armv8.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/include/asm/system.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 2237d7d006..9eb30c2ade 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -394,6 +394,15 @@ void switch_to_hypervisor_ret(void);
 #define wfi()
 #endif
 
+static inline unsigned long read_mpidr(void)
+{
+	unsigned long val;
+
+	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
+
+	return val;
+}
+
 static inline unsigned long get_cpsr(void)
 {
 	unsigned long cpsr;
-- 
2.46.2


