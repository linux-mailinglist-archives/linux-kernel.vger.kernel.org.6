Return-Path: <linux-kernel+bounces-311170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E6968599
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3A01C2203E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603F200126;
	Mon,  2 Sep 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nOIbsf9Z"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039E20010C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274676; cv=none; b=I7krXVelDJWmAFc/NUkdlbdu7I+FlrTpZ70kiO4k1c+uMPXb23tmFJfS9W1s1/Yj4EKHHE5w5kh5pDPA4ZCtKnLeGqQLesMd9faohTZorZUPijifiLmOr85hnYsu6l7vUArBwAk3bgPerNAXHSxy/LGxtmapjOIeLzNilElxpco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274676; c=relaxed/simple;
	bh=R3mOJ0tg7Pga0e0/mL08j7cxX2XkXKFhyGbziepUW8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsBwdaAO1LBKwg34F341BlFtvGL1CYdozt6OBUa/qxuCmEOc/02ESBpXZVWh0/wijEfzV6bHcUdpe7/tnlr8VvP5IqGSWayGzJLLO2xcvVCOu6+u+Fi1g1EVO2JhFt+c+G90dkAfjepKXynIAivfbJCIHWZm0LmpH/QIn47k1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nOIbsf9Z; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2705d31a35cso2467911fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274674; x=1725879474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANQ7nNmlnnrCWKC9y2AnQPhj4CrEHBm/AtpIgpKbHKg=;
        b=nOIbsf9ZfFhtDKrmbnKDWXONT5p+exmcWbxobhdxkVAcR4s52H3abjN68Dl85c1udf
         LYC4gR97ovdEWP4gATGPbVjGliH44rIyPODp7NUZC3NX4cCKQt4IlqUGstj5ni/O2zpN
         qhw8Wnn6LjpkVOMIR/0hoKDEkv+2zDnMnehc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274674; x=1725879474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANQ7nNmlnnrCWKC9y2AnQPhj4CrEHBm/AtpIgpKbHKg=;
        b=DjLhqXCH4T3/qreI8luNOZSuUQ+44aRzYbPuWFJ/RF5YXdPKUzWPrhJTfzpoB5qRQP
         ycbre4yC6fwopjoA1YAv4KM7MYRXNVVu0A3P4eAj5TOL2MmqzUFxLj05CB9+hjOjk2xL
         TpXEKbKMrOv9AbVKcAxpzxmqM71ET26WQcVAkbusgmkHWh7M/7jN1JUX3bKHm0fGv40O
         vg8zbfrLeH4WGMvHH6SIH/zPt9cnn7tuyKDeSpbMWZocyeWMPGkh8GnxkIF0Pjr3YiPl
         m8cMWzH/BmDGERwjUIYMM2Qc/EH2VWrPBRxPK9nJFQkDrG8/tgRRw8+vF4XrEJQ/A0Gp
         gIrg==
X-Forwarded-Encrypted: i=1; AJvYcCVoWC10Po5PA3hYEakxf6BBmmV+9OstczA6MdUw6N7Wwk2RzLG/ajwLQK2Ui6ln+1MrB88MWz5jUW05WIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLTroFwFk2ODPLy7LBAM10ZXpiS2KeM9zViUkgZeVLZHqfn4d
	DMyDdEGutTA4qDkDvPPiHPucOyNIQVABquaRGngAMZsA531ored9y3rOdtblOw==
X-Google-Smtp-Source: AGHT+IHfFvHGTiw+yEI4r1FIWoqKufWTfDqAXp7jaziqaBKtGOEA95/l3uaagE8pIbNfk15h7FbRsw==
X-Received: by 2002:a05:6870:1f0d:b0:270:463e:4b72 with SMTP id 586e51a60fabf-277ccbed82emr7661252fac.20.1725274673994;
        Mon, 02 Sep 2024 03:57:53 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:53 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 24/24] zram: support priority parameter in recompression
Date: Mon,  2 Sep 2024 19:56:12 +0900
Message-ID: <20240902105656.1383858-25-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recompress device attribute supports alg=NAME parameter
so that we can specify only one particular algorithm we
want to perform recompression with.  However, with algo
params we now can have several exactly same secondary
algorithms but each with its own params tuning (e.g.
priority 1 configured to use more aggressive level, and
priority 2 configured to use a pre-trained dictionary).
Support priority=NUM parameter so that we can correctly
determine which secondary algorithm we want to use.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  5 ++++-
 drivers/block/zram/zram_drv.c               | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index bb52d2fc0587..bbb1b1b8f10e 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -512,11 +512,14 @@ registered compression algorithms, increases our chances of finding the
 algorithm that successfully compresses a particular page. Sometimes, however,
 it is convenient (and sometimes even necessary) to limit recompression to
 only one particular algorithm so that it will not try any other algorithms.
-This can be achieved by providing a algo=NAME parameter:::
+This can be achieved by providing a `algo` or `priority` parameter:::
 
 	#use zstd algorithm only (if registered)
 	echo "type=huge algo=zstd" > /sys/block/zramX/recompress
 
+	#use zstd algorithm only (if zstd was registered under priority 1)
+	echo "type=huge priority=1" > /sys/block/zramX/recompress
+
 memory tracking
 ===============
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9b29f9e6cb50..1f1bf175a6c3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1855,6 +1855,18 @@ static ssize_t recompress_store(struct device *dev,
 			algo = val;
 			continue;
 		}
+
+		if (!strcmp(param, "priority")) {
+			ret = kstrtouint(val, 10, &prio);
+			if (ret)
+				return ret;
+
+			if (prio == ZRAM_PRIMARY_COMP)
+				prio = ZRAM_SECONDARY_COMP;
+
+			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+			continue;
+		}
 	}
 
 	if (threshold >= huge_class_size)
-- 
2.46.0.469.g59c65b2a67-goog


