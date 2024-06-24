Return-Path: <linux-kernel+bounces-227801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E966F9156B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E4F283F70
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB711A0703;
	Mon, 24 Jun 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLJhs6QE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A51A01B6;
	Mon, 24 Jun 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255202; cv=none; b=OzAQG241k6DpGMocSVNNnlO9z1x4TYSN9I+raULBNNw/0oWYDnLuMF969CpgIXZZXXNGKbCOwyftdJHUw9wflsP9QJivv4SkLUbW5O7zFzFV9Xhgv9i5PaNuPie8IPA4PIcDQX7xUZQwGHr8PaIsBpWPNilSwf6Dec3CxZ5jr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255202; c=relaxed/simple;
	bh=bsgX1CZdQ7bAv/ZyedwgOWgKCDu8tkAKHzDRbVhGwKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJjHB7o5w4hu4jLWCzTjfkg0zVMYxQoOSopmTgt/0VPI2ZVjfYI6zYATvrnuqOfETBDM07Y5pw7S0u7aS82zO0HZKnYeSJEpZyBDTrQPiaoY6Iw+MWsla85uOOcBqIX/IfBYPPAscNHrit3mTdh4i5yFWY8RFoqntHHLbQMmZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLJhs6QE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAB6C32789;
	Mon, 24 Jun 2024 18:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719255201;
	bh=bsgX1CZdQ7bAv/ZyedwgOWgKCDu8tkAKHzDRbVhGwKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLJhs6QE3VGeFaJzqLwGtlNzoG8n/bzJ5DlzwyCVds6TyEQGeFK/xUEb36snxq+Fj
	 FBePkeJ6+0FtPhls9agb5iP2w3r092jqJGz7fishcs3FWelXjH8nhq4gteVM2/FHP8
	 NXxWZkjxdAXWn6XiCWIM0tXD1DDB8P6pUxv0rR752a+bptadL+OaiwmrBp4AvQwmAW
	 nKsvve87uyemGGmsOtXH08oxg0tejienkTiyMtBDOK3vYK+pmTXByKfaHVsg7cfjsA
	 laKsmlYQN5Vft4Pq52YKo2/m5QFpBFeQUwwrlWFPmGy5vo+FmB5/LYcTO+E5V3Hov5
	 BMznH9KlybWnQ==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] Docs: Move magic-number from process to staging
Date: Mon, 24 Jun 2024 11:53:08 -0700
Message-Id: <20240624185312.94537-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624185312.94537-1-sj@kernel.org>
References: <20240624185312.94537-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'Other material' section on 'process/index' is for unsorted documents.
However we also have a dedicated place for the purpose, 'staging/'.
Move 'magic-number' from the section to 'staging/' directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/process/index.rst                           | 1 -
 Documentation/staging/index.rst                           | 1 +
 Documentation/{process => staging}/magic-number.rst       | 0
 Documentation/translations/it_IT/process/magic-number.rst | 2 +-
 Documentation/translations/sp_SP/process/magic-number.rst | 2 +-
 Documentation/translations/zh_CN/process/magic-number.rst | 2 +-
 Documentation/translations/zh_TW/process/magic-number.rst | 2 +-
 7 files changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/{process => staging}/magic-number.rst (100%)

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 08b4eb1e9118..fb089bf9d6a8 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -113,7 +113,6 @@ lack of a better place.
 .. toctree::
    :maxdepth: 1
 
-   magic-number
    clang-format
 
 .. only::  subproject and html
diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index 71592f3ce89b..77bae5e5328b 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -8,6 +8,7 @@ Unsorted Documentation
 
    crc32
    lzo
+   magic-number
    remoteproc
    rpmsg
    speculation
diff --git a/Documentation/process/magic-number.rst b/Documentation/staging/magic-number.rst
similarity index 100%
rename from Documentation/process/magic-number.rst
rename to Documentation/staging/magic-number.rst
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
index ae92ab633c16..cd8f23571835 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
+:Original: :ref:`Documentation/staging/magic-number.rst <magicnumbers>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_magicnumbers:
diff --git a/Documentation/translations/sp_SP/process/magic-number.rst b/Documentation/translations/sp_SP/process/magic-number.rst
index 32a99aac2f6c..beb4b4c1de11 100644
--- a/Documentation/translations/sp_SP/process/magic-number.rst
+++ b/Documentation/translations/sp_SP/process/magic-number.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-sp.rst
 
-:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
+:Original: :ref:`Documentation/staging/magic-number.rst <magicnumbers>`
 :Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_magicnumbers:
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Documentation/translations/zh_CN/process/magic-number.rst
index 4e4aeaca796c..4ebc84cc0c54 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/process/magic-number.rst
+:Original: Documentation/staging/magic-number.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
index 199cd5d63973..5582df6d7ca7 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -4,7 +4,7 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
+:Original: :ref:`Documentation/staging/magic-number.rst <magicnumbers>`
 
 如果想評論或更新本文的內容，請直接發信到LKML。如果你使用英文交流有困難的話，也可
 以向中文版維護者求助。如果本翻譯更新不及時或者翻譯存在問題，請聯繫中文版維護者::
-- 
2.39.2


