Return-Path: <linux-kernel+bounces-389936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358DD9B734A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB54285EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2013A884;
	Thu, 31 Oct 2024 03:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBeriMDp"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA11BD9DC;
	Thu, 31 Oct 2024 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347124; cv=none; b=Jpyf9wd0NR+pMTyYB7Yaz2Ix2/eiXqwNO6+fdH1A151jCgRpTdlgOaTRT6hw/q4bgvLdYSSrYq4JqD6q8OONU3g65go+pOFzcMMkVjElRUr3Rdmx2ZzRf9lxuHZK4IHoi/lUf9r77eJysn7ZC2E492Al8Cknjq6Eu4KKnHb3yOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347124; c=relaxed/simple;
	bh=P+ZoPofAO9CrQzRt6EgkaEQnuN2/i7IZf1CrYZsm3lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jv4FC23yh6QARE1YUNSJmoS8xc6u/M0Yag3qZAXw0RZzwHjoglAfQFu4jHrNo2jXUNf5ZgPQkgpCm83YZoLrkCKDP2qB3tAmewIYeIxyPnj7k2XaPXpSOuhUddPCYC0KwmSet44oM3HWDvh7EVgkUQgaBZr4bDkRDhTWGRtcW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBeriMDp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cb89a4e4cso4255515ad.3;
        Wed, 30 Oct 2024 20:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730347122; x=1730951922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKsH7tcmYk6G4taCb3CHfNomgw1vnUT3D+1Ikv+W9E0=;
        b=cBeriMDpdyV7aOZCEaksd78AGqBWHVXVsWzGJyhvZyR9C85BrSzldxwmxSSJ1srZ7N
         Nqc/WypVORmUei2PRAo0Dkajpb3yq5/ubrn5ri2s5iyTNa2zV1PM2AwwlY32TACK8eK1
         8rnqj/v/XUl1brUNVuSWhdCZpBfn0cWPnQSWgkZ4lIe62P+O47StAr9cABryGIGo614d
         qVqmn452pbITYxqZamdKUuAnwcSthdwg8JsuwOwJ96WD8u2iceX4KBV4ngwWzeb1FmrD
         x5dylvwjrkeFZmYpE9TZpiMW8cWJObAhEDA7q76m64UvTILdWM3RlxgDQDL96kzQuc4L
         kZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730347122; x=1730951922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKsH7tcmYk6G4taCb3CHfNomgw1vnUT3D+1Ikv+W9E0=;
        b=VL2Cl+7HrPdF0QIL37S9D7C/wxRBg3q0nj2+OEzXG4cpFxxKSQ78ZR2Rvx0hW0DWIB
         1wzLBb8P3+i7cwWS8gu5Ayl55nu8bTGYLwKEamMxW4HwXF3H+RIHt/c0dXmYUYDIW6Dc
         kb44PCFeaJxteq4dcLsXth4FkhbjOX2ZgOh23DON4J+Ya3IXyNQUJv4HjwihbjoCBN5U
         7Vb1H4N23p67MTfq6736SjiiiOty+xNF4N7OFYvylxeK77oN1bItqZOg/dwypaEwDEoz
         NSF/3iKUP2esvkUcTtQ+Rqy9uDheWhnlGW6TmpYoaGOOUPgA3cq85g8bYezK5tmJDAGf
         s64A==
X-Forwarded-Encrypted: i=1; AJvYcCUhAsrCZiN2eVIhzJWJKfHwP2gYjUsXT3tjm1q/yISUbWga29p1rs3Vl3vNe7NfWjcPBIDo+9Isxc8=@vger.kernel.org, AJvYcCXQQWXyU/eMJb7DgpkecnevIOUL0EfNWkwFSppzRm76EqYfRcNaFDf5MpVFrYFUmVp1gIGltoCvgdQjZ5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqF+1nm3JkvEEX+vi3+KkAGXs5si85GfLuiQk04aPdw+Hpq5O8
	/BrV7/34Gig/FOrKXelPw/jbXy4DcU1o45HTKQFYrl/Zt3ZV6Zuy
X-Google-Smtp-Source: AGHT+IHM7J/7cbyKydtwl/06qdn1JLPkjt8hrSlBqOmvnNdDccMARyW/y2ckAtM+E2wDuFntDycUnQ==
X-Received: by 2002:a17:903:2346:b0:20d:2804:bcde with SMTP id d9443c01a7336-210c6c293f5mr235511265ad.35.1730347121557;
        Wed, 30 Oct 2024 20:58:41 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:7d08:cd12:4b73:5f28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c4ed4sm3028065ad.230.2024.10.30.20.58.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Oct 2024 20:58:41 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH V2] ASoC: doc: update clock api details
Date: Wed, 30 Oct 2024 20:58:29 -0700
Message-Id: <20241031035829.54852-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added ASoC clock api kernel doc in this
document.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
v2: converted to use kernel doc based on comment
from Jonathan and Mark. 

 Documentation/sound/soc/clocking.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/sound/soc/clocking.rst b/Documentation/sound/soc/clocking.rst
index 32122d6877a3..25d016ea8b65 100644
--- a/Documentation/sound/soc/clocking.rst
+++ b/Documentation/sound/soc/clocking.rst
@@ -42,5 +42,17 @@ rate, number of channels and word size) to save on power.
 It is also desirable to use the codec (if possible) to drive (or master) the
 audio clocks as it usually gives more accurate sample rates than the CPU.
 
+ASoC provided clock APIs
+------------------------
 
+.. kernel-doc:: sound/soc/soc-dai.c
+   :identifiers: snd_soc_dai_set_sysclk
 
+.. kernel-doc:: sound/soc/soc-dai.c
+   :identifiers: snd_soc_dai_set_clkdiv
+
+.. kernel-doc:: sound/soc/soc-dai.c
+   :identifiers: snd_soc_dai_set_pll
+
+.. kernel-doc:: sound/soc/soc-dai.c
+   :identifiers: snd_soc_dai_set_bclk_ratio
-- 
2.39.3 (Apple Git-146)


