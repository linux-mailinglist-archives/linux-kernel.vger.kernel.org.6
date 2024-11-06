Return-Path: <linux-kernel+bounces-399066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEFD9BFA79
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940AF1F22B21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA3920E30F;
	Wed,  6 Nov 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFDSzYp+"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B320E00B;
	Wed,  6 Nov 2024 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937144; cv=none; b=s8db0blV05MUSpWQQjvpAR9I5pHSW7BPrJEzR098TLDt3teEroZHNbM8veQ0GuWnoWjnObnRbATxAgHq+FQbAlTJxdt2cAm9hSBfT1ICQ4FIj87Lz3piZ0/mFNzmdsvE6MFtLG2B6TO/A8t/9Xt/PEPkM+ThFJNKxKDujLsggM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937144; c=relaxed/simple;
	bh=8vf+K6JwL9Su/uwu8IdndaFHxeNiHJK4imkCcmwbNAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBAPK+FEIdEaCVhAqDQqzQIci5KZTt4kPAxACDuffgHpEsH2wL9AuyR+BgQptyXhJyTGE/7LssxCH9GTCQrfoht/+V4Ubpr8Ycuaf2AgmAwx0s7XUCZZ2lopMP1xxQJfDNZ+58tldclJD2pon2jqoQu6wLgGn6uo2i3sKakfCS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFDSzYp+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso230238b3a.3;
        Wed, 06 Nov 2024 15:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730937142; x=1731541942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk7Tp+RjS5BgkuwZhoTl8pH8m0pljr6UbcMTui39Ycg=;
        b=mFDSzYp+eGTi9g252OJKMItH6tkI07ACK0RHyvAAdTcWj4mapFE6XfXLLECf0nvJhR
         SCD3JhFrx6eE8fjS3CDZsScjwSfeIQGwzluj8V5+3Ti9p3AP6jQC7/p1ReMk0G6f+CPK
         xqvExuORmUhRT0axi7oxXJZ9f57ImrOWUMFFyfQiC6bKBKnRLTidsueB+c2pg0/DH61a
         et1VMv1sh7TlLUymm7Itt24fZTtg06UUkoInRkIXcMwXFvFkC7mLU9/adQESam5CIc8U
         L2ZyVnYmGu/bUdy+jttLdWN6U/CvPHDuGQNU8yDvyucGmkcZzK+xPD2cnaKuV+/O1umn
         pg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730937142; x=1731541942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk7Tp+RjS5BgkuwZhoTl8pH8m0pljr6UbcMTui39Ycg=;
        b=cuHVe5YP1wVVat3snb6FQNpTKsvaAN29cOGXtqdt2xqXJB7LegsHY9gh4W9m0OE5Le
         8+uTTU84XGwRsesJXU+dZJdZnfl3lj3d1+h+YUnBkqITdZrSaOLqkyOzY0L9s7Z9pKF6
         AGpv2noVfWh+A/8D/Ixgz7jLqS29MrMk6JCMGtp16c6hL/xq44StSA/JgIIfTM7+jms/
         Jn+UikLzfp+oeWs4v65ufrIkfDEPUzRe7zV97iNbmCF2KSNgRqb6qOcLQ7Ybl9ehW4tc
         C7NA0j31LfqO0Jd6fWlevfsAxWBd/JV2r1rumUrO5oZ33WTXl/sACPT+Rmi1zYgaZuTY
         t0dw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Pep0Q+D9cqMvmSB+IlOa0cOm0ud7tZCpe2L/txtD9z887eyEvTFQwooQq2LP6PVJOX/Bnnogcf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvz7zRR7tNx0J4mhqVFRjjaPMJOV80RiLqTFdKVl/WYMxzZXL
	pEA+VA6QJvvnAAauTwRS1Y4Tv8gTL518p1RTKC9ywh99b1ZeJXAkzVZ05GAzDNs=
X-Google-Smtp-Source: AGHT+IE6JiMF31f+svf6/ZmhCyKP/bwqW/n3LIDQLf0PSHY/jFJLtiob+Ff2r9PmoipDkjqOftQ0Dw==
X-Received: by 2002:a05:6a00:22c5:b0:71e:e3:608 with SMTP id d2e1a72fcca58-720c99bb6e5mr28241031b3a.26.1730937142249;
        Wed, 06 Nov 2024 15:52:22 -0800 (PST)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:c934:17a7:b0a5:6e02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a57105sm115903b3a.192.2024.11.06.15.52.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Nov 2024 15:52:21 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: corbet@lwn.net,
	broonie@kernel.org,
	dlechner@baylibre.com,
	u.kleine-koenig@pengutronix.de,
	Jonathan.Cameron@huawei.com,
	pstanner@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH 2/2] Documentation: devres: add missing remoteproc helpers
Date: Wed,  6 Nov 2024 15:52:17 -0800
Message-Id: <20241106235217.94718-2-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241106235217.94718-1-yesanishhere@gmail.com>
References: <20241106235217.94718-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remoteproc helpers were missing from the devres documentation.
This patch adds them.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/driver-api/driver-model/devres.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 8350a098f81f..7bf06e5c9274 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -448,6 +448,12 @@ REGULATOR
   devm_regulator_register_supply_alias()
   devm_regulator_unregister_notifier()
 
+REMOTEPROC
+  devm_rproc_add()
+  devm_rproc_free()
+  devm_rproc_alloc()
+  devm_rproc_remove()
+
 RESET
   devm_reset_control_get()
   devm_reset_controller_register()
-- 
2.39.3 (Apple Git-146)


