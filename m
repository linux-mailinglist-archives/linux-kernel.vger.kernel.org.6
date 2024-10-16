Return-Path: <linux-kernel+bounces-368189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0CD9A0C65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8445B1F24860
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42A20ADE7;
	Wed, 16 Oct 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPpwGdhW"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364571D1740;
	Wed, 16 Oct 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088298; cv=none; b=rwq0ffPV9c81pfMStSHMF0968SmkBcvRQYzeF80ETeZz+yKeKHkQGw+ubBoBr/2dddOfYYv8YJlthtA7dd+8CFhRh0Dubp2x+D2xEVmIuBJz/SCoisiKCgEUtyn8Ul34RgCQRkHIPLXgRE4XUPOX2ypWjPcK04GllO3DPmVjrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088298; c=relaxed/simple;
	bh=WX2kSn/zvOHP2sgWungvTaEfVbNTo7ic0f84S/OmDDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CdFtthzftCkzT8kyIqmdpqGZHbQfVcglSsi+QS2J4dlxVfHzlOeJeu8hZZrbd4x4MBz+PK26mFQuQlpKElQbJkcQ167Ykv7QuqAnrlTaxOrIwaq4AJBRXaM3P7Mv2PeKUS3GfB1KXjPSoOHf5qL/zX5+mFNuy7gA9BbQ8SRuiao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPpwGdhW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c8719fb63so3228005ad.1;
        Wed, 16 Oct 2024 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729088296; x=1729693096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9ahXLo+atbprdtEUFtqBUARF1aQ4qX2VZwEm9Ub9Wg=;
        b=TPpwGdhWLOGEWAF0ea/EjYWbONbRuX0RX/2UFv7aNeZHkS5fVxUDQD4qfFuobeA1Fq
         JWevxhRWEpa/e3s4uqdW+Actgf1O79tAD/2rxO0AtmpfS32yP8Gn7/+LJMrYu3klnzRu
         u+gruZzDnhQlhHFvzupNltbTT1qcSedqmjbb8GaFOQV5OGOJil8cfaaX0ATQnTkpPtCr
         V8G3epUK1ShGAlFXdUTE7oWc1MOEdgpq1tzOPBBTBfYiotwxjO0B09ltqpgIWHvhuqj2
         aL834xoLiG7fQikT0vk16BzTypKEYulaKulKll3u2pkemXJYRkFues7i9E6pFJ28lhwT
         q45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088296; x=1729693096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9ahXLo+atbprdtEUFtqBUARF1aQ4qX2VZwEm9Ub9Wg=;
        b=wBhBk/mYeVf8jkYiynwpX4noxvQXPfAy17nzjAOYRzpTk9bwRST6st7oQZLZu8oZ1H
         q1KUmtwp1BAV6HdEMv7ko4483c6bwf1FK66Rz/gj+fiNuYckYIfVtO9DxlfGofKIJbcR
         AN3OVoNbNGitG3MPoWZ8qfy6+8uHWGQ9MfoI4q82QsYnmZPIdmld1qitJ9xQMipvcAno
         YeYVkEzKgIUkcwpFO4p+1Vt9a1fF4VH4Mxt6OxOn9CYx7pjomq8H42EEBYyqBZVQv53P
         tWc6LXxEwz/S8Lh0fBwEP14PlcTfLRkHgoHFqqd4RQihZGdnLQL7uawGPmSbk5eT3C+4
         /bEg==
X-Forwarded-Encrypted: i=1; AJvYcCVpXPKBLy9bvqvrs5oJahHgUZoJZ8pGwbLlDOJ3Rl6sPaAXZoOWye7e6uisVgk7P55M4u3pqE4zBuwdmZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrG4jwReW/+RwNyQAKXtyAO1mZYNYK5e4NSKOB3rcoU/KsvtL
	tosZihxbWw9FLVWLK1RwFpuv0Yr4d29KJzCAow3WcmcswSOxkzFA
X-Google-Smtp-Source: AGHT+IFSMToqvpC53gepqRT6gDlCa9fyiQgZbm8H+iIYGIBZ0cpfFqQQD4c5wwT3JblAqbcgpRrXNg==
X-Received: by 2002:a17:902:d501:b0:20b:7ece:3226 with SMTP id d9443c01a7336-20ca167f1c0mr110434045ad.5.1729088296478;
        Wed, 16 Oct 2024 07:18:16 -0700 (PDT)
Received: from aizome.localdomain ([36.170.32.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804c033sm29057045ad.214.2024.10.16.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:18:16 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net,
	seakeel@gmail.com,
	si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaxin_wang_uestc@163.com,
	zenghui.yu@linux.dev,
	Pengyu Zhang <zpenya1314@gmail.com>
Subject: [PATCH v6 0/4] translate page_tables.rst and fix PFN calculation
Date: Wed, 16 Oct 2024 22:17:57 +0800
Message-Id: <20241016141801.25487-1-zpenya1314@gmail.com>
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

Add a entry in Chinese glossary

Pengyu Zhang (4):
  Docs/zh_CN: Translate page_tables.rst to Simplified Chinese
  Docs/mm: Fix a mistake for pfn in page_tables.rst
  Docs/zh_CN: Fix the pfn calculation error in page_tables.rst
  docs/zh_CN: Add a entry in Chinese glossary

 Documentation/mm/page_tables.rst              |   2 +-
 Documentation/translations/zh_CN/glossary.rst |   1 +
 Documentation/translations/zh_CN/mm/index.rst |   1 +
 .../translations/zh_CN/mm/page_tables.rst     | 221 ++++++++++++++++++
 4 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/mm/page_tables.rst

-- 
2.25.1


