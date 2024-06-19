Return-Path: <linux-kernel+bounces-220532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF3E90E33B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98887B23397
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357815B69E;
	Wed, 19 Jun 2024 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PD6IrU+9"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103D4405
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718777836; cv=none; b=Y3UM1FaBIZd6/NBbeSYcQF5pggPG2IiSisfbcJD17ADrsmqSlVF2Jnf4NaLhYs9r2nEZiulKiz5EaA1A/k92bPwO0bvPD60Ljko3FZeyO3LElzRlSB2Oc/ZCBGggqtYMbcfFTePsaLzeEYFTo0pq0K9h2ZWTwOsF7WUMtZKj2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718777836; c=relaxed/simple;
	bh=MKxcrhf954+h/fj5FUq0M2IEtC6vw+MEMrgGG2QiMQU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qCR35t8Oz5n+MsiPpHoAXMV9agOov7K9HSxowjGodiIyi/QqBX18648OTmL8TfvG5cgAUVAzEXsdYHGJoPi5SEDXLU8+A6vRuSwR92tEMo8qli3gSec/YpndfILRGl3iVk3NQz+/ufLDppzz0PKfroM4cfAXO+78IYv0n3GAIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PD6IrU+9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f9aeb96b93so2354745ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718777834; x=1719382634; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb8rf7B7CmynNMORS4ggh0oWZNT5/aYuLwEeCtSsvN8=;
        b=PD6IrU+9ikS79E/2m8gZ5wwaARMrSIUqkj2q3bsI8XA0H5o47Ctn3WBhD4zR2b7eLY
         HDyEx/Y3AiQcPp6Xg4yOWnZ0DfIklodmWrsxxMwBpSGf7GDPJuxNLkBbFU0WrqthVmAC
         bmuS/O3H3oVHCSVsElbB1qcqAd7u2slGbWJnVFB0ajt4gcjHetmj23EsYjR1YMiuFB/2
         rW83Uz+MQRklDWxuzPCa67u5SexOutJX7JIgszcwD0ikUVSfC6QWeY7WE+Fm8iTBKBtO
         cHEHkU67owq5JkGBdIVnA0xZwhm3lUjxLQPfUZPArObi6+lypTzuMljVCkzBp3nbJpf0
         6Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718777834; x=1719382634;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb8rf7B7CmynNMORS4ggh0oWZNT5/aYuLwEeCtSsvN8=;
        b=R7sn3OP1Okw2me9z6+aMR6lG3wcdVFbnHPcsMsz40OegvTccCbdKQX57C9NaUE+wVs
         muAB9x6OmTg+COv8qM83SCnZP99So3ALB0ILc6RJcKzxonSZ9RuBF4R7F6IT4Nsy3UtD
         McXiNNRclX0k57oeQpuQACtkzFgwWJWM5S37AYLAY4PYEkRMaFJrVppjk43GXZ+BR0lo
         XDb1uq5XAcuNlJaQv1htfj1suGUbRVh/GFaJg0+XFEx/BSCPP5wQixFpHOlkVQX00CGP
         kWaK6uiIC6pH2K3W3mgxOcchGhyejnFGAm4behPavplSIvbTQ1lbj14RkK9yGBGtQJJf
         H0lA==
X-Forwarded-Encrypted: i=1; AJvYcCUWnXL/JQdWWNZpemOp/xJk6BQMKt01rRuwPXejGiJ0G5qH4/b67VxjYqrIUIYXenQQcynAiAWtjVp10wqtlO3bZo4H43ILLWR5Rmm1
X-Gm-Message-State: AOJu0YzpIE4yqJ/z8y3Gbjnlap1VCPPznv264dpb0IESYxb1NPZc2DuI
	BxJ5kGt/U3CwOIGwVzq0ViwmptS4Jjuw79bcnJr1QWgJIpNKI1IhOMykReqL+5Q=
X-Google-Smtp-Source: AGHT+IHfUnljtY+OOkau2dxrbi5Qj6VW8lQGCO3kt0DXie9WHQ+0FBNLbj6+uVP1Jcbnh77enT4saQ==
X-Received: by 2002:a17:902:b209:b0:1f6:51f5:540c with SMTP id d9443c01a7336-1f9aa3eda7bmr13953485ad.29.1718777834224;
        Tue, 18 Jun 2024 23:17:14 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9a38f9ba2sm15952735ad.70.2024.06.18.23.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:17:13 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	robh@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH] checkpatch: filter null file for dt-binding check
Date: Wed, 19 Jun 2024 14:17:09 +0800
Message-Id: <20240619061709.15236-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When removing a dt-bindings, checkpatch will catch the 'dev/null' file,
and think there is a non-dt-binding file. It causes fail because
/dev/null is not a dt-bindings

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b812210b412..ac59a48162d2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2896,7 +2896,7 @@ sub process {
 			}
 			$checklicenseline = 1;
 
-			if ($realfile !~ /^MAINTAINERS/) {
+			if (($realfile !~ /^MAINTAINERS/) && ($realfile !~ /^dev\/null$/)) {
 				my $last_binding_patch = $is_binding_patch;
 
 				$is_binding_patch = () = $realfile =~ m@^(?:Documentation/devicetree/|include/dt-bindings/)@;
-- 
2.17.1


