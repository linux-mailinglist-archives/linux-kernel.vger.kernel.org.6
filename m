Return-Path: <linux-kernel+bounces-402987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D78C9C2F49
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2365282239
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C171A00F8;
	Sat,  9 Nov 2024 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udy7vIXB"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA019D098;
	Sat,  9 Nov 2024 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731180159; cv=none; b=XFDRl57Af2BAtgLM/Llhq55eOxTphgfAuYIM0PpSAYDygLeGQOByXZmOtQx61c0LAPc+TTkmTWphb7fYvTQrAAXok6Mp0+R4DzK/wDBt74AbaHhJDIWvuy/aU7uRKvoluyqGomqLNnG/d3PyJFJY8QK6V3ru4GiphMe+LYVmST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731180159; c=relaxed/simple;
	bh=PAkGTpYw0svn/8sFSQHDdcs/Z5rWGOAwjT9TSl54s80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Nl0FY6QDvfJdYCAGMAFk7DFCh3XCIGE5rn0VBSEhmuPnATaPleBOzjwIoK5BSZFELAhQ1vsvRayf+Ao7O5J2ydQthM7j6k4NxBc/ZPwfTiJYS14hWRJrD/gH5QnfJZjLKSd8BQVTITx6W69BIWmkzE10EHJkwcRoes7MwKBF8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Udy7vIXB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso2343255a12.1;
        Sat, 09 Nov 2024 11:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731180157; x=1731784957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HH+lfDLJ4OculTQvO2d4H+PRmRG5td/7+N0i6ctqQyI=;
        b=Udy7vIXBrKxHyrdaXnd3HcqBRjm6fLES9pweqlWsr5hu6IdcawcJJVby0jk+6/nJBj
         Tf0OnbJuz2VUIcXXG8NREEdahzSa//cyXaPGaz/QIqU4xk3Kji16oTo318y3Kk6/HL6P
         g8+5+rnLRC0/ejx/VobkBwtBF5OLg74yjs6lRqD1AuA/AyblJijSZXW4fVkEjFEX0tEE
         h8OlzU8ndRbS7ZzVc7dFZPPjS0jxecGnIonx1sIkeW/8s7ZHZL+3bl3mT3DUmVa+er9Z
         w2o5wkSG3CU7/YZG6RuMqlX+CWV0j2Sn83/Mm/UliUKn8Uso2gQP6+4ykoTori9LlUsj
         1PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731180157; x=1731784957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HH+lfDLJ4OculTQvO2d4H+PRmRG5td/7+N0i6ctqQyI=;
        b=FBejtHPC4Ge4WkES9UGExKA6rHstNZeA7/RaUL4cA1wCK/p//q0tm3RP2MmGK8ynF5
         httT0cBejEL077aE62lbw/2oTZJMkLpO6tcIz4nxOy1keLi05nPE3hRwvUsGI3vwEkZ1
         IZHlkGOvorCTT08C6laMLi3UVaddWz3rdNhRJi+KiwL0FqHWxn1lcGv6OTco1munS1Dj
         eKbqXKnAo90KBeibKfpPJ8qOwvEu/88diRHC4Rw+r71vjdqctZrMvXyAexoDq0r5+7fM
         qlGiH5dRXkEEg6aTOax+YZPPypyybEZtbqgmjQlV1hAlOK1QPmJqPsOT/7L2hOZTz/1M
         Z1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKb68dthj+lhcOPLQ+0odxyfGcLlQyUdZYtjo0OxisdsN5r35K/jH7VRM7/834poIAqHqXIuqSqQg=@vger.kernel.org, AJvYcCVnwToxtyNrYvdlI5yYLJdGbTiSSMJ7LQdK+J/ICARk3ul4EC2CoRavlFfe+PpSJ2kks1yjwCJ0+/yTiIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFmDu+Pj7Kwsnb5H72Pp3wyHCgluXvgcbg5k3B3nyPL1FWvMw
	EncGUH7noQqhUCyY28jvNQtFfsXFEWUeSp7CPyR5D2LCL93uqOOK
X-Google-Smtp-Source: AGHT+IFtllIT0FrtO17iJNkUxiyZVPHDkiBY/4VqQr3KHEuFxbov0zYtVSCFAVbmXC1fzWtDJs8SEg==
X-Received: by 2002:a17:90b:4c06:b0:2da:88b3:cff8 with SMTP id 98e67ed59e1d1-2e9b1edf2f4mr11511859a91.6.1731180157389;
        Sat, 09 Nov 2024 11:22:37 -0800 (PST)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:38bf:b55b:31e0:3bc0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a4f6c96sm8554688a91.2.2024.11.09.11.22.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 Nov 2024 11:22:36 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH V3] ALSA: machine: update documentation
Date: Sat,  9 Nov 2024 11:22:31 -0800
Message-Id: <20241109192231.11623-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1. Added clocking details.
2. Updated ways to register the dai's
3. Bit more detail about card registration details.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
V3:
 fixed reported warning and html machine output which
 was not formatting 'clocking controls' properly. 

V2:
 took care of comments from bagas related to underline
 and making macros as literal code block

 Documentation/sound/soc/machine.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/soc/machine.rst
index 515c9444deaf..9db132bc0070 100644
--- a/Documentation/sound/soc/machine.rst
+++ b/Documentation/sound/soc/machine.rst
@@ -71,6 +71,18 @@ struct snd_soc_dai_link is used to set up each DAI in your machine. e.g.
 	.ops = &corgi_ops,
   };
 
+In the above struct, dai’s are registered using names but you can pass
+either dai name or device tree node but not both. Also, names used here
+for cpu/codec/platform dais should be globally unique.
+
+Additionaly below example macro can be used to register cpu, codec and
+platform dai::
+
+  SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
+	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
+
 struct snd_soc_card then sets up the machine with its DAIs. e.g.
 ::
 
@@ -81,6 +93,10 @@ struct snd_soc_card then sets up the machine with its DAIs. e.g.
 	.num_links = 1,
   };
 
+Following this, ``devm_snd_soc_register_card`` can be used to register
+the sound card. During the registration, the individual components
+such as the codec, CPU, and platform are probed. If all these components
+are successfully probed, the sound card gets registered.
 
 Machine Power Map
 -----------------
@@ -95,3 +111,13 @@ Machine Controls
 ----------------
 
 Machine specific audio mixer controls can be added in the DAI init function.
+
+
+Clocking Controls
+-----------------
+
+As previously noted, clock configuration is handled within the machine driver.
+For details on the clock APIs that the machine driver can utilize for
+setup, please refer to Documentation/sound/soc/clocking.rst. However, the
+callback needs to be registered by the CPU/Codec/Platform drivers to configure
+the clocks that is needed for the corresponding device operation.
-- 
2.39.3 (Apple Git-146)


