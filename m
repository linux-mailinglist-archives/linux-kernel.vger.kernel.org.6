Return-Path: <linux-kernel+bounces-169300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2AF8BC682
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E6C2819EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65664436A;
	Mon,  6 May 2024 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbQIfF+w"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930F3C489
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969227; cv=none; b=pjpfuDOkRW/PpYy6ayipweIoj5gksxL+8iY0OSn26cHtqEKzHVFbyf14myWaNrJfw78Z5sPPE9lM5uNUJif8hACe7wDTZDabKiXN0ZCRUx+UA4zNyI8VvnhJ/r2TU8wLxxrbT0OLK3VJoxOOG6RrYkanasm4b0Fg/fBH1j6OR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969227; c=relaxed/simple;
	bh=pIO752CiNLb7xAnhlTRLT2FVFS/269qYKUlU7rr7LwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/e+k8ypol6u6an7M0uRT0lnq2XzV8Llg0dpACb5/YYApjOLGUGWYWiHzZh6b1YnTfcd14DbvCezFWJJgLpLJukVZWe76kZJwc+ZWNMsi6/4yK/mvsyTDYTymQ64y9IdNAk2k5bzSdLRZy/xDlXYYoHHGFuqhRv/AFlhDShhsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbQIfF+w; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f450f43971so1001192b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 21:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714969224; x=1715574024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gvfdEwF5axDej8hZnwSL+0riRUzYkUa0D010mh4Q8aA=;
        b=cbQIfF+w+Q/oY9FHd5kXhsx+PrqTqDdwq7v4dr7lMAebHQ9xQVZG+wEbgwiPHR9+9h
         t+YS5tsu+FdIgT4glumBFargz1A78OgBhv77S5SgY6Ua1qmjxVYONzrD03GZ3MgPNymp
         jcC+V7mn/AiawwbyjilcZrHSEthTT4pJfFsBFc3E75BGutVJlE81ERQKDLijr9hGHk22
         mmfahKG+/CdQOgryg56JRLO6LC1NOxui0tEdiwTBmoGrQSfsizcKvobfsiMTb8OhVTJu
         sYvlxmOysI7QpsmzVCtbcx2M/6CqY3dtmbjJkUAv+V+p67Hzpw3hUW0FnD9TGbx4zpVI
         SmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714969224; x=1715574024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvfdEwF5axDej8hZnwSL+0riRUzYkUa0D010mh4Q8aA=;
        b=BJk3CebJ/npXAPZ9GnnZ+eTn+ll506KtAswaxKqCRVyWBzIB9yq4X5JX4X27QLen7n
         ymAVEPsCtyp0HHUzxWv5KhWyBbb8gToKf1HI7KYPZbHhMDh0gnMeJusih5+Plh7KQEyG
         DGb6ysh9JddnJ40n0QE5AWXoD/QGw/SL5Hmb6uzNowxW3SPweCfmleyvGX8UNtC8VSTb
         9jWyJAOSMu3V4HCBBkQZt0vcbT4QaJLaTdvWlCCvLVc4oxBRuZUVfboN+As/TktZrzXF
         rhv05+v0vGsfjH+THcdVE13SjSAB7mw0H57JIJ8xRfI3yh07t1DMsbkaWBPkZ+t5VZps
         U/3Q==
X-Gm-Message-State: AOJu0YzCaLe3xqPH80Tr+jsr7/Jj120GKvCwRIlf52Kl7AsV7eM9efNp
	fBeC7UZ5+1SloMXjmtveM7pvKJsB0Yw+uYTDZsaWonZDc/qXBb+D
X-Google-Smtp-Source: AGHT+IEET8JkYJX4FHvO7xpmXBED/y59u4e2T0lDhhCONIo5ShDRqSjjw4JBjUsfNC9oLM8uIUcC3g==
X-Received: by 2002:a05:6a00:3a27:b0:6ec:ceb4:49b8 with SMTP id fj39-20020a056a003a2700b006ecceb449b8mr11171834pfb.0.1714969224370;
        Sun, 05 May 2024 21:20:24 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id o14-20020a637e4e000000b005f80aced5f3sm7103116pgn.0.2024.05.05.21.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 21:20:23 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH] mailmap: add entry for Barry Song
Date: Mon,  6 May 2024 16:20:09 +1200
Message-Id: <20240506042009.10854-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patch includes a .mailmap entry to synchronize with both my past
and current emails. Among them, three business mailboxes are dead.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 .mailmap | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.mailmap b/.mailmap
index 625b496bf5f4..7dbc9aa8e8c9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -87,6 +87,11 @@ Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@linaro.org>
 Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@spreadtrum.com>
 Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@unisoc.com>
 Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang7@gmail.com>
+Barry Song <baohua@kernel.org> <21cnbao@gmail.com>
+Barry Song <baohua@kernel.org> <v-songbaohua@oppo.com>
+Barry Song <baohua@kernel.org> <song.bao.hua@hisilicon.com>
+Barry Song <baohua@kernel.org> <Baohua.Song@csr.com>
+Barry Song <baohua@kernel.org> <barry.song@analog.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@wdc.com>
 Bartosz Golaszewski <brgl@bgdev.pl> <bgolaszewski@baylibre.com>
-- 
2.34.1


