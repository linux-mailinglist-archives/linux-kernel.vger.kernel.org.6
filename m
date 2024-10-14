Return-Path: <linux-kernel+bounces-364386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A470899D3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30951C23FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D94F1ABEC1;
	Mon, 14 Oct 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhGrFvKw"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7597F1AB534;
	Mon, 14 Oct 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921372; cv=none; b=mmuhI5iJsntTexShSB/9IFwIB8cCi4NO6JoAsex3wu/Ev1JBPa+eaWJ+PUiumblZm3qxyIlx2DLRVIrLDyR0tONHxfaai5/nDFnndmQgfNHYJnmUIO5xdQeuVVY2aVwEDuMQsGCGrU00hMBlUWsE29ONpe9+tIVJBlwLDJALcsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921372; c=relaxed/simple;
	bh=VDJeC5SYCs2Dgrv56MNNO7EyaXUdUGMTeP7dA0b4Xzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pAu/I0KtRU7q8aFmVl3whyMkfwfd7eWzxgyo9yygOQnoCYDfHyXiJOTO8lwqWiKrs9ejTPliTSJtHX7IDA7AbN2e78UqnWOyDR/FhL9eRcVoPbIeRUCdCwI4p8I0KVWxeU7SXYbqRgiCuCu0iwaBVVUitJps5CQTGPgOnzDGeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhGrFvKw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cb8954ec9so1116115ad.3;
        Mon, 14 Oct 2024 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728921371; x=1729526171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=irYTghu5OKCkpdCtEDCE7QbDQl9wDWZzQGu0+ilLEjY=;
        b=bhGrFvKwLXIRMQYI3Ml7NepdXL94XwEVyWUyUFb+cjIMkMGdlePKnzgUxz9aywydOQ
         sFX/9p5YfGo082KozriUEbDTAYTPRGjGyuFq6ju8gX0yD+1F2kMwzna4yX5KYHC2gAC0
         1VFgU8DzCOI4tCeZJQTq61fuAowCLZh1rac1+9bLfT/Efjq+0kYANa+Sn5PbjcmTEbXJ
         b3ZL8gGg5ktEaKw1evSFQ7XuePPKz4D+wf23S9/Nso4Y1ZS91n+oWy6Nkc9FcIXxJTK0
         Bokz4Dm1lkmrQWhGJYWbnFunyxUlqrP99YNY2RGBrtnt9P49kN/Fm3OhezuksFXy0Suk
         Dx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921371; x=1729526171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irYTghu5OKCkpdCtEDCE7QbDQl9wDWZzQGu0+ilLEjY=;
        b=YbLBOfSQf+elbiE7yEldGmb9ul1Z3Gd9XFUbDlpGUwaVWdzxfjQc/oWp4031L2ncLt
         D1ZAdGuHnXnUY/rJfE0WYQ8/AuUxNGfyNQvMZ8owW+JUI5+VZh2HMv7ofqbzpIPNAH2N
         3Uz0bGXp2Opz/9YP8bzdsv7LFHuH7xb553H8+WSUxR3I6f0V9QAeaOO7x7mlTZXJhEWA
         Yn85D0VSWv5VeEVVmH9maM2J/FF3b11hhsHSMNM8tOp5g03jB9i4eoSEdKRhMrI1gfe7
         Kw2k5OtEvXIURfv7OHazW9iEj+65RbI/9YdI8Ud1xAxAuBe2mmd6Epfy0Y7PCC2AxMjs
         g5lw==
X-Forwarded-Encrypted: i=1; AJvYcCVU1VK0oR3tYUIjrSGtShTTVEQYRXGV2HrRrpbNAjk9lf+7svzuSh6ITI6bMmg/0hPm8ogJffUZQw+o3Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0fREf0Z877qZpZ9JzRiGIKdHw4HsaW/D5ALJ2gAUiFmpiOeM
	SJzpFlt11Zp7stwKiNlKLBURxaZ2Gw5JPA26AgPfvDJ0AuRIueZsdlEdGJYBw15JTg==
X-Google-Smtp-Source: AGHT+IGLNtQa4ReaE12ZnmUZhfU5sx6UPtRCT2Ga/Zen6jAMApY6tU1DwLawLGhdb+Cj6S6P51j45g==
X-Received: by 2002:a17:902:c407:b0:207:6e9:320b with SMTP id d9443c01a7336-20ca169e926mr68504455ad.7.1728921370729;
        Mon, 14 Oct 2024 08:56:10 -0700 (PDT)
Received: from aizome.localdomain ([117.172.223.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d00363205sm11168485ad.53.2024.10.14.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:56:09 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net,
	seakeel@gmail.com,
	si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zpenya1314@gmail.com,
	yaxin_wang_uestc@163.com,
	zenghui.yu@linux.dev
Subject: [PATCH v5 0/3] Translate page_tables.rst and fix PFN calculation
Date: Mon, 14 Oct 2024 23:55:23 +0800
Message-Id: <20241014155526.17065-1-zpenya1314@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Translate page_tables.rst to Simplified Chinese.

Fix a mistake for pfn value in mm/page_tables.rst.

Synchronize the changes of origin document to fix the pfn value.

Pengyu Zhang (3):
  Docs/zh_CN: Translate page_tables.rst to Simplified Chinese
  Docs/mm: Fix a mistake for pfn in page_tables.rst
  Docs/zh_CN: Fix the pfn calculation error in page_tables.rst

 Documentation/mm/page_tables.rst              |   2 +-
 Documentation/translations/zh_CN/mm/index.rst |   1 +
 .../translations/zh_CN/mm/page_tables.rst     | 221 ++++++++++++++++++
 3 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/mm/page_tables.rst

-- 
2.25.1


