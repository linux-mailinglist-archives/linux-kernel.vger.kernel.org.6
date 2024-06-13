Return-Path: <linux-kernel+bounces-212869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66610906765
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF861F21728
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60314037C;
	Thu, 13 Jun 2024 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoBfTe+n"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08413FD82;
	Thu, 13 Jun 2024 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268421; cv=none; b=oFwUbIJuLqxYM7C7O70PIOOhCBlc6IXGUaDbNscsjGdEsScmE8i6vdnkNmMvvcMwt+hmeyF8URjqaq8AWWE6AGrpRIntgoxuLPdAysDsuq2zMNK46p/s4VAPuYc6iaQxWPG2TEfPyZqtP9HjCppK3VVD5D8a5J+yTeg4v9r2LVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268421; c=relaxed/simple;
	bh=1MIGK6FDq9dwWEqTUEUAAu8rtn11B0ER/xsJgA5onv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YbgOpKdqR6FaORjterfg7Ruy94z0sXzMj8htITdzqDiAWGY9il/Yat2bDYZCYeHkcxXEATNh5Dvfy2p5AdCTQTIl3VGOT7CZR63aYSNZwAEa5pqRgIoJZk6AWxGSCcWltASFrS5mM7qdqMeKFStIjTdwjw0OgKx6sCr8DOF8gh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoBfTe+n; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so114278966b.2;
        Thu, 13 Jun 2024 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718268418; x=1718873218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3yfZl5Uy3j61nQCZXcBqw5F4yIksen6ORXxHgk45Kks=;
        b=UoBfTe+nvOqjQk9STh/9BxTfVK0JHDd1ZlBbxQdoP9LH5IML7Run+FO4ApdPS/DjlB
         puCFFyk0kBPWVSBIDU3MzH8UW45SkCo7PPAHvD/IVKIUc8EyUHVAJveSzoC1HmTNfeeP
         2J6j0tKAZeA9Ac1kxQoGomYNADKd/ZypTAEIwu+k6xw7K+RZoDhRaBNG9/zazqBAehjT
         czYYhSg3XVLcRhFkqLzCQRerrYlcap1qBm2bPs7r9i2KMZLUjlTWXqyCSksqM1dcM4O2
         CYeLSfA+cm9nUi7K6s3bXepvjYmJ5rAeVORZeMJaowqyij/MFla1DDfLD5luPpzpcNIH
         Sp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268418; x=1718873218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yfZl5Uy3j61nQCZXcBqw5F4yIksen6ORXxHgk45Kks=;
        b=j5rVbcIyEtbcE8/Nyw+bHSPoynTbBTMi3AAM1kTLULe8UbHIgzD3iHenk9u/ROdCDP
         MaU7bCtdbVbiQJgCPVWk4HRAGkH90r0hDKWQeKEXUIHYZVAhbkyuMm0WGWUnH3dULmN5
         S4J5+2fAXRoM+XP13hlzWSpXZF5pATbmFr17TLL0N4BhMbkqH/nexLUUYCsDVu/4Hh95
         U7GWrRQvirHFZYlxEMYa80a+zXOBIcJbiPSb3WSjlN/JTZjq5ysJ38NcPGcrdZrkEW59
         afTv9ZkWSUPZWSi4wl89KRRBrPGhA+5RLmkM9VNV8nnDi8OAO9Sak+AZF1b0jx6xwq2n
         t3dw==
X-Forwarded-Encrypted: i=1; AJvYcCXSASeI5zkP1kE9YBt7jmlrJm+gDB5IFR6Dd6sKcFPMj+PhkPrnM1xxfTj5nqH94yk17zY1B+RFnDA6k6y4xT/luxj6EJMJPmdJ11Ls
X-Gm-Message-State: AOJu0YxYvi828Xaa5Ecj1HGTc3fPF+WTcAUKFG5N3OM7QjTClGdIstDU
	4EDL5NtBlWWIenWZPwTbZ+fdBOnvK9yzcutxtNkXcJNXM13cX0YO
X-Google-Smtp-Source: AGHT+IFFnDlUw8Gs7yxy7aQo5cv3Iq0GRUgnrryfIlPQEHgftSMK4Nb6O7IJupuZKxYnClaAwts6ow==
X-Received: by 2002:a17:907:72c5:b0:a69:13a2:4f6e with SMTP id a640c23a62f3a-a6f47d61fe0mr323396166b.74.1718268418356;
        Thu, 13 Jun 2024 01:46:58 -0700 (PDT)
Received: from andrejs-nb.. (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56dd2daasm48364266b.97.2024.06.13.01.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:46:57 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v2 0/3] ASoC: nau8822: add MCLK support
Date: Thu, 13 Jun 2024 10:46:49 +0200
Message-Id: <20240613084652.13113-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

This change adds local MCLK handling, which would cover a case when a
reference audio clock is present in a system, but is not allowed to be
changed, see [1].

[1]: https://lore.kernel.org/all/ZfBdxrzX3EnPuGOn@ediswmail9.ad.cirrus.com/

v1:
  - https://lore.kernel.org/all/20240409121719.337709-1-andrejs.cainikovs@gmail.com/

v2:
  - Fixes the issue of unbalanced clock enable and disable which resulted
    in a negative clock reference count. This triggered "already disabled"
    warning when the system was suspended.

Andrejs Cainikovs (3):
  ASoC: nau8822: move nau8822_set_dai_sysclk()
  ASoC: nau8822: set NAU8822_REFIMP_80K only once
  ASoC: nau8822: add MCLK support

 sound/soc/codecs/nau8822.c | 76 +++++++++++++++++++++++++++++---------
 sound/soc/codecs/nau8822.h |  1 +
 2 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.34.1


