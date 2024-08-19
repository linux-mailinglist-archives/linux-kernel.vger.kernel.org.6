Return-Path: <linux-kernel+bounces-291683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6C7956589
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2931C21A09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE0C15B11F;
	Mon, 19 Aug 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="08VAi1KM"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8C158538
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055891; cv=none; b=N+cgO3xbzZKvj2xh1ym+CMK8YQzYj+jzMtkT9AVwCN7R9VXGRriBMZrkyTZP+EmTTR2QcTVkLNq0/Ovh2EAwNyfQdTRx6SPIvejf8pQgAYscofYhcwjietjKSNnkzTsH5okzlrHHYjJRc8wEvYt8Pe1o86eo6FD7t3gtY7cDRWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055891; c=relaxed/simple;
	bh=FamuYlAjig7+R6Qx10U1TbALvNH2O6j/k6jsgrIpL4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ph6mKb0xuxs86GXsln1iI93BB2JdA0nryVH8wcFBkYeTSsy0CPxi+LoIIg7DoinkIlGWjYLfQsXEP5lzVZUhvlPq25atz+m8qPW5FGDeY/VUJ3gkazwckDRFm2LEoOV0/+8H8K5XcFEdipidZfEoN/T185Uf15sTdnywBhJpjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=08VAi1KM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42816ca797fso32652045e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724055888; x=1724660688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIBDwkrvQYglDtNL2nrORHa/NryU/QKFWL2iAI/C8cU=;
        b=08VAi1KMRzBdh1Sm5t3/O3XyGvbaQvSOw1Yrc1HFqy0ZLgmIrtKx8Ygfp7emW7RYSi
         s6pxV0nIji+n6L15ze95PDIFIkP6lteaYSN8iI1TRyPDzk8Lz9Kjpi1qUfJ1Sw9KqJ7m
         n0nFoPWPYYgcXciDOXhE2BycmpwWHAetqc6NsYO7yES3wukNIgPBx4h+428VmU4ykDKo
         9+qHBvU4nR+OA15qXSkjARYI8Um/GWdVoUVZ3aUwoIvZx7Wo1MMZrNbqaHXjnhMKGQo8
         0UKlPYdXhKOoRbPrNPrFHQfUGmuQGyas5cOqtl/gA2NYjKKDwGPnFSIUS932dsbEEQ6R
         /RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055888; x=1724660688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIBDwkrvQYglDtNL2nrORHa/NryU/QKFWL2iAI/C8cU=;
        b=feJxWyqsuv/knxS4vpjzur5dTjOxiqUAj2O+1e96bbYOG7asXW1ZHI/awolpff8WIQ
         UHDAbtJdmhQ6HG+N9j+LoauNRqRtMimk9LDbDa6rt56ZArc40wLh9M7d2JXnsTjGVQGM
         k4C0IUD/qhlBvrJyGtomWtkxKHha/KERD0qLpXbJbW21Eme8qnIViWPuqsarM/C4Xsa8
         RpAIcyvrUYx7F8pAG1cFYnC5tItISGLS0JpWrFm/I0Eqh5I/es+3z+E3yYklaV8vWltR
         YttEi9GQjYp/OBcBWkkp/oOzBs6UEt4AamHL/uzjIYM6JnTI30/MDYMw3Rbh2pCC17pW
         35pw==
X-Forwarded-Encrypted: i=1; AJvYcCXH97w3XuInF7ahuG/Wf5CwVWFfPBov7xTOglciMGd09FHurGoszR/k3WZiIlqZifN2eWCxWqNPU9NwIkqAHFtnVj15yVpXQ9FF0yDR
X-Gm-Message-State: AOJu0Yzh/GlI2QVOkCkmyks6s82+JVjN4IuArCn3tFr1Pg+lbxFsUBJi
	F49TD7AfnDMJpF7L6Hn04+0eZij9i+MYcjP4b+l3UCIzbQBS+KCJHO8CN6LMh18=
X-Google-Smtp-Source: AGHT+IFroE0AUVn42490Pv0WzAZonKNG3nvovJgY3AqmZF1oVEGmbJKI8gbrCaahPK6xzDdxQAgNmw==
X-Received: by 2002:a05:600c:1c24:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-429ed620183mr78741815e9.0.1724055888127;
        Mon, 19 Aug 2024 01:24:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7b55:8f70:3ecb:b4ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5a9sm153441175e9.43.2024.08.19.01.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:24:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 0/2] PCI/pwrctl: fixes for v6.11
Date: Mon, 19 Aug 2024 10:24:42 +0200
Message-ID: <20240819082445.10248-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are two fixes addressing issues with PCI pwrctl detected in some
corner-cases.

v1 -> v2:
- use the scoped variant of for_each_child_of_node() to fix a memory
  leak in patch 1/2

Bartosz Golaszewski (2):
  PCI: don't rely on of_platform_depopulate() for reused OF-nodes
  PCI/pwrctl: put the bus rescan on a different thread

 drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
 drivers/pci/remove.c                   | 16 +++++++++++++++-
 include/linux/pci-pwrctl.h             |  3 +++
 4 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.43.0


