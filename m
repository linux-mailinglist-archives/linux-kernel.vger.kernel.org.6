Return-Path: <linux-kernel+bounces-425409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DD59DC1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4D1162D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6AA188721;
	Fri, 29 Nov 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB/sQjAw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012C160799
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732873969; cv=none; b=tnqz6ljuyftI/+nvWIGodE4JXz9f6A8ZX9fWkwbx9IoJMn2obOXQyIi55JlW/9MqRHZ7CMsCNLvU0zgD1eX57LhsmUzbZxnzSykq0U71BKVVFQAIVHtTL3TdtYUv4EB/7zeMzGg0rUFfc0bKY9EagqcUfWl/TKbMIaV7YAhTj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732873969; c=relaxed/simple;
	bh=SqmOT6iWjnt0mG+nwdZYca2nN237AFxzOVzsJfDWvqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDWWnYx3+G7we5SvJwvqiHKZYpGu3lx/JhCTHOQhDo4oPeoX9FHMVRLaSMkUCSz3SdjAVeDidVIxtjMbp9tNyY8n9jBf/+MeLcYPffSW0yGxof37zXRvVZIddekfWGb7Tkxj8f//mwJM9UkEkIEtD1pE4cNIU6429wkZAUTFrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PB/sQjAw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732873966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u9pRkC1e52aumPgah0dPBX2kXf19ILENP915r5Qwrhw=;
	b=PB/sQjAwGKzNRQb9trHpHFbGh3W3OXgKkJrdO2fvS5oOYbFOLVRyhNiWY9Z8At09wzXGVx
	xbnKP6arz4xnk8ntzEWTEUNaRaGvzbTjeBT+Dox2S4c1bWdJoHVT/yQVTHsUUBlSu2OaLy
	TA5DqIomaP+mm58reCUCx3Iqb7CbxXc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-KywnGCJvNnu0lQ-BbiQkDQ-1; Fri, 29 Nov 2024 04:52:44 -0500
X-MC-Unique: KywnGCJvNnu0lQ-BbiQkDQ-1
X-Mimecast-MFC-AGG-ID: KywnGCJvNnu0lQ-BbiQkDQ
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5cfca6de3f5so1025683a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732873963; x=1733478763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9pRkC1e52aumPgah0dPBX2kXf19ILENP915r5Qwrhw=;
        b=mCgEotsoWzVfuJzQtwz15IRzdp/+WZEGBdtf6KItFRd2tpnpdH82E+OxK+dmddnasz
         l1dFKrJXAjIX3zvIz2LZNeZiE3oEgEU0s0bVrtZxBcDMDxJms4Nen9XrHlaTKSmj+vpx
         L36ge0GKVzComd2OZrq2yzd37BC5XpFlD/BGrBhXTMYsmiLBgSQCgjYgIHwDWBF6ufIU
         2igkr/ru2mWH77n6SYvqWctx0UqT+dmRRHbUmssOZPZpaCAFnxettn2JB5xYGhGy/iBx
         fUfiCv2qOYYkhEGWB2ZpXYGT95oMpVX3G2sOlWE7cKQinT5K4S6gQe7FplwnbGHaUllq
         YMvw==
X-Forwarded-Encrypted: i=1; AJvYcCXux7drnzgrVRBDDEzVvOnPsBLcKk72sB4egEuKR/CN910SQ00sReVFx1Hfnp+hmGXtbHkQXt+aXj1hz4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBfRtNUPQ71/gU6S7YCQwdgdKH1rgNUiZpicT/43SxZspOutN
	O/kZk3PcAaxD2enCVYEy0DwZZ+g7Z26p8pSz7SjqrdCkK02zMG4gaEO5ggPwkDUbbKQL547YPnI
	WtsCk5LuHiEWNOg4NkXRKv3c17ppeP6w/QcO4yjrogPMuE/J6hEqDD3A1Y0I6Wv6lGPyMHQ==
X-Gm-Gg: ASbGncvJ+8Lbf8hDe3jRKruEbSKK1tsNPxrPXPskj/gEdlzLs/BWpGdViPvdDEehs52
	RQhmlXjm5j5C1f0byIW3FG5qh1UAgw0N382ncyv0KoC4LGnIDld+KQiaMfIi2Hutt/qrgV6Jea5
	sXTWZHRySfSB6cMj6Ia99aw7FgCPbdQnUp9CWu6PG+ZC6PpNG9Uxx1TgCmrAgFCGqFvuBtQNNi8
	jQx2/gJHFK1+FDIVC2sQi+urKruRkJmS78WHO6T6HZ8z8R5sQwf/33jVp4nSfnsjPI2lGWa47Bu
	A3QJnx+qhUC/Wf5q1xW+dg==
X-Received: by 2002:a05:6402:42c4:b0:5cf:f5fc:4160 with SMTP id 4fb4d7f45d1cf-5d080c69119mr7901105a12.34.1732873963452;
        Fri, 29 Nov 2024 01:52:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1x2CcmMS3DDHYn2ZMvn/87pV8k//bJ2vQzTxS8d5iTD5KADjFjqrm1NCoFWK+kP+P/4M1Eg==
X-Received: by 2002:a05:6402:42c4:b0:5cf:f5fc:4160 with SMTP id 4fb4d7f45d1cf-5d080c69119mr7901082a12.34.1732873963145;
        Fri, 29 Nov 2024 01:52:43 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd9b7dsm1728078a12.52.2024.11.29.01.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:52:42 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Chen-Yu Tsai <wenst@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: fix typo in I2C OF COMPONENT PROBER
Date: Fri, 29 Nov 2024 10:52:38 +0100
Message-ID: <20241129095238.51748-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 157ce8f381ef ("i2c: Introduce OF component probe function") adds the
header file include/linux/i2c-of-prober.h and a corresponding file entry in
the newly added MAINTAINERS section I2C OF COMPONENT PROBER. This file
entry unfortunately has a typo.
Fortunately, ./scripts/get_maintainer.pl --self-test=patterns detects this
broken reference.

Fix the typo in this file entry in the I2C OF COMPONENT PROBER section.

Fixes: 157ce8f381ef ("i2c: Introduce OF component probe function")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1240e75ecf4b..d1b50664b5e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10765,7 +10765,7 @@ L:	linux-i2c@vger.kernel.org
 L:	devicetree@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/i2c-core-of-prober.c
-F:	include/linux-i2c-of-prober.h
+F:	include/linux/i2c-of-prober.h
 
 I2C OVER PARALLEL PORT
 M:	Jean Delvare <jdelvare@suse.com>
-- 
2.47.0


