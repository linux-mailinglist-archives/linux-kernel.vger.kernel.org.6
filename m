Return-Path: <linux-kernel+bounces-415154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6089D3215
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5041F233FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC42E40E;
	Wed, 20 Nov 2024 02:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ozp6WNdp"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA76C125
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068747; cv=none; b=iesBrFHfScXZFeWOqnHZoXUTGCzxbZxfe0Fup6eU2iZfvyVgWT23V7KrPUBLRtOIw9FCed2RDA7xkBaFLz5mq7cLkTaqdMJB9azXR65IxXt9zT9kcOI+LumK0wIP1hyIjBDr78WIV7yNWVRpXz0c6+HSzS3pKyhUwOgZnasiigE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068747; c=relaxed/simple;
	bh=25+rPJ9fWY4m+iEBdv+TE+xd7oUG8ckOtydtKO7g9w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7xzgFhuuo4Fbl2LMhcDOeYbmlfuLK/v3mmSKlocyqZznKfmLsl/gxaEwFwxWD9+g3JYsXGIn/XucvQ+IMxQK47cLcVBEH2XIhzDeTwWz8b5ajh7QTF/P/LvDa9bvPEZf2Oun5hSsEN/yEy8GCy4MLitLzTfJWdCe6y5kpuW0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ozp6WNdp; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 754583F29F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732068737;
	bh=LRXICbRWhzx1gwE/Y73pvU27kO5MxS5NaOgmxNu3I6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Ozp6WNdp/0LSiyezhXO17J+wlb85PaGigGyu3UnQ8Pvel837Rj+acQJHy/yARHDbu
	 SmRuzwfzxxyc8beOjI2+9/tM8bLl68ZAgjtumoI5n6uSJqO89G+YNMhqEy4aDSc2sd
	 0S7TA/iK1YSaIrnQXFlSbBGGkbroWGmyf3w+nzh833jqAaQRaSgJ46+w0yq96D9l4T
	 bL+m9quROjMhowSoFw+49t79fT+SmMb+x/dXghXSUcbeUIAegs9pmI0iFmdFZINFNl
	 kHRZGGpmTzkq+1OJMcg0ri62XTZfwtB9ZtB2SEG8DRL7nZnXWGtsjFKrxalJi7SBjF
	 zNgWhewh4h3JQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ea45ba6b9aso4379672a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732068736; x=1732673536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRXICbRWhzx1gwE/Y73pvU27kO5MxS5NaOgmxNu3I6U=;
        b=T/HAFIyr7mpMCJeeJfwGUSTCB2gK/mx1FISTf7H034X4/1zympSpKG9MMgLtgzhCqM
         ekzgZAkpfYGgwJmeIsxL1ErbFCQfftPl8c3mOSONyoPDGwq3tyLc5uQ2dpUIHvMVEeJJ
         j1C1ne34sDl6bRWaa9geSjApGNcrj3HRlEt0fbGLcJGhmUlnag0IT1nscWSDGre5+dc1
         xTp7DGztP8hJExyDiF7CcDVDx96nCDETcCLzLhBg60tRGnZiCFkgtraFze2joUn9U/m2
         OfmoUPRzDJoCdmY01mpIaUQLYlQVWdTZSyx72CMzUfznTQlmfOJPEPHn0wDaPLhi9PdO
         FcWw==
X-Gm-Message-State: AOJu0YzVZAaXGTlH0Uq2O96saStyOjGNiDv8bbocG3FTj7YzmQA5DxI2
	07ngYalTptdhDW86zRKd2b6gLWF2q4K2DjoIlvQ7cmj0ZYL79iQtjy8r81iQac5wcPWWSt8avgN
	MQHoTsjo/+aOfYN7HV9fg4TDnp6hAwRwcxxPLPahxqvmY7foaORlPU9H1pSbV/jqyg0BJRBCrWY
	GmcPgfIm3WpQ==
X-Received: by 2002:a17:903:190:b0:205:8407:6321 with SMTP id d9443c01a7336-2126faf865emr4075965ad.9.1732068735921;
        Tue, 19 Nov 2024 18:12:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH4ktCTVbVWmNyF2kNFv6coM9ePcmRoT6nCq5TM40TOGd8HhfegwAOGPzYj7EjZfOTNA8PGw==
X-Received: by 2002:a17:903:190:b0:205:8407:6321 with SMTP id d9443c01a7336-2126faf865emr4075725ad.9.1732068735627;
        Tue, 19 Nov 2024 18:12:15 -0800 (PST)
Received: from zoe.. ([2001:f74:8f00:c00:6aff::1003])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2126f2c5ba0sm1371875ad.47.2024.11.19.18.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 18:12:15 -0800 (PST)
From: Masahiro Yamada <masahiro.yamada@canonical.com>
To: kernel-team@lists.ubuntu.com
Cc: linux-kernel@vger.kernel.org
Subject: [Plucky/Unstable PATCH 1/2] UBUNTU: [Packaging] Avoid Arch-Specific Certificate Creation
Date: Wed, 20 Nov 2024 11:11:01 +0900
Message-ID: <20241120021205.1590999-2-masahiro.yamada@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120021205.1590999-1-masahiro.yamada@canonical.com>
References: <20241120021205.1590999-1-masahiro.yamada@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the debian/canonical-(revoked-)certs.pem files are generated
by the clean target and included in the source package.

These files are created by concatenating *-all.pem and *-$(arch).pem
files.

When creating a source package, $(arch) expands to the architecture of
the build machine.

Although it is unclear whether arch-specific certificates have ever
been used, if they were, canonical-(revoked-)certs.pem would become
architecture-specific, resulting in an architecture-dependent source
package.

The source package should be consistent, regardless of the architecture
of the build machine.

This commit changes the build rules to concatenate all *.pem files,
ensuring the output is independent of the build machine architecture.

Signed-off-by: Masahiro Yamada <masahiro.yamada@canonical.com>
---

 debian/rules | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/debian/rules b/debian/rules
index c6facd5717c6..600e7bab2150 100755
--- a/debian/rules
+++ b/debian/rules
@@ -213,7 +213,7 @@ $(DEBIAN)/control.stub: 				\
 debian/control: $(DEBIAN)/control.stub
 	cp $(DEBIAN)/control.stub debian/control
 
-debian/canonical-certs.pem: $(wildcard debian/certs/*-all.pem) $(wildcard debian/certs/*-$(arch).pem) $(wildcard $(DEBIAN)/certs/*-all.pem) $(wildcard $(DEBIAN)/certs/*-$(arch).pem)
+debian/canonical-certs.pem: $(wildcard debian/certs/*.pem $(DEBIAN)/certs/*.pem)
 	for cert in $(sort $(notdir $^));					\
 	do									\
 		for dir in $(DEBIAN) debian;					\
@@ -225,7 +225,7 @@ debian/canonical-certs.pem: $(wildcard debian/certs/*-all.pem) $(wildcard debian
 		done;								\
 	done >"$@"
 
-debian/canonical-revoked-certs.pem: $(wildcard debian/revoked-certs/*-all.pem) $(wildcard debian/revoked-certs/*-$(arch).pem) $(wildcard $(DEBIAN)/revoked-certs/*-all.pem) $(wildcard $(DEBIAN)/revoked-certs/*-$(arch).pem)
+debian/canonical-revoked-certs.pem: $(wildcard debian/revoked-certs/*.pem $(DEBIAN)/revoked-certs/*.pem)
 	for cert in $(sort $(notdir $^));					\
 	do									\
 		for dir in $(DEBIAN) debian;					\
-- 
2.43.0


