Return-Path: <linux-kernel+bounces-212871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6E7906767
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822C31F21094
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D981411EA;
	Thu, 13 Jun 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkGYIGsv"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7CD13D638;
	Thu, 13 Jun 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268425; cv=none; b=Yyfw7E4ppyHTvUtGzGB45xmRTsY+bZLNbO6sCpG+yywt6lJGh5/x9OsshTqDUmuJxBhpkLBqiCBJim0nFrYIewHInzAZV8FEOcFslRPFSgFobnuUEW9tNEtu1sY++vHpNerOGhD982FyJQ4QUp+VzGx/teVnySKv4NU8vJ3ju/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268425; c=relaxed/simple;
	bh=EqkSdTqJHaYEQuNi/uLAeCi9pEAL2ae1wXXb2wxmqNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lAc/wGl/pfN8OI+a+QfnlH/NEkcfaTrXJ0J4sPya7aEhRLltne7GcfAFiR95WT99RjBr8WJZlu8TicBLj/WXoDS2FI6rqMEaHLcKJND5F5SISzryTCcBUS+vAeYPjDF5wM2JGt7UPt81+8Hu4ZTvAAzdmK6E5DL7Tvo+5ap9bXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkGYIGsv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6efe62f583so71163866b.3;
        Thu, 13 Jun 2024 01:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718268422; x=1718873222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thQRC36oe2yKpAcPC3plDlm/TWRwjC8u5J3scWrGsuY=;
        b=hkGYIGsvEn94ajE67tKf8/1TKNpUX3yTt0MWou14r55jCIf7DuFVOHhZmIoB4oylhd
         eaQgicuC4axvzOt8eS4tI9mxSF1M/X2LVl0l1YDEFx813lI/DbzVhozUG5PjMVvxou7M
         LVoXoIlTwo7TU9aMi4N+JJADr8i3psS1jlmRmVdAnQc4ORwfJHDZbr4DGtjw92uUgd23
         4V0qeX64gQDyqeOQ2aqSccBUjNSe23r6brUP46y4yXa+x0AVqYEERHJAgye/wM8kUUzE
         rKIKaChiz3cF9SkSjILze9gT1Wj5PGU+I8n3DUE2UXRA9VdD8nbN+6HkDFgTH21a4NxO
         QIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268422; x=1718873222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thQRC36oe2yKpAcPC3plDlm/TWRwjC8u5J3scWrGsuY=;
        b=C5+oLgE1DySQ9PYwTKtb7+FQ4HuBq/WF0dEGzGUgjQxFp1DtizPRjkEDCTiIjaFFsq
         za9e06+gWDaCTrQXia4RV0VhADy3IpV4CyGvI3GFiewdk6yu4MkHczUEOfwc3tpsTxIY
         7uYJFN0KKq2pn8E0x74XUMoDmF7ZoJ1OKsPXw278wECmhA3NsNB9VVBK88Gted/FM3kA
         oqm1nVCAETQaQpEUjofXMqYYMDpPlRWzCtGFd0cCfqW478kGDet8Dlg0W7Of/h4R2uG2
         TXNOCFD4KS6Et78GN2jVOkcQeBksp3rajtpbF3as2vCIEeCXMIuxmGUqhMhiDgSmkawF
         o3mA==
X-Forwarded-Encrypted: i=1; AJvYcCUXoyTBEbFS6R/QnUuwihrJiVwtgpojQCsWXp1FzQBtLgWG3DXM9nboEBSV7RPE0nWPO7/LgukK7Ux37E8DKg1QxfhGjpGqDEUNrk4U
X-Gm-Message-State: AOJu0Yx7HX0SwEZQy/fm81i/uRiodtM93jjS5l32oqOGSTRt68ufT4wy
	5BSFsXRnqVmctRTr+bnWnb37ovjMZYgeqh0qpfCAnvI25m/3ovJU
X-Google-Smtp-Source: AGHT+IH+mYeCaw5E5vk77ROWpy5NO+f5UmGrTBrK24oz5K/O4bX/DcDKQcBs+PHYKe41rBz7J4b8XQ==
X-Received: by 2002:a17:906:c105:b0:a6f:48b2:aace with SMTP id a640c23a62f3a-a6f48b2aebdmr282579766b.51.1718268421698;
        Thu, 13 Jun 2024 01:47:01 -0700 (PDT)
Received: from andrejs-nb.. (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56dd2daasm48364266b.97.2024.06.13.01.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:47:00 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH v2 2/3] ASoC: nau8822: set NAU8822_REFIMP_80K only once
Date: Thu, 13 Jun 2024 10:46:51 +0200
Message-Id: <20240613084652.13113-3-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613084652.13113-1-andrejs.cainikovs@gmail.com>
References: <20240613084652.13113-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Following bias state machine logic this bit is set twice before playback.
This change makes sure this bit set is set only once.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Suggested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 sound/soc/codecs/nau8822.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index a6741bda6a9e..5f9f0953aa2f 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -942,6 +942,8 @@ static int nau8822_set_bias_level(struct snd_soc_component *component,
 {
 	switch (level) {
 	case SND_SOC_BIAS_ON:
+		break;
+
 	case SND_SOC_BIAS_PREPARE:
 		snd_soc_component_update_bits(component,
 			NAU8822_REG_POWER_MANAGEMENT_1,
-- 
2.34.1


