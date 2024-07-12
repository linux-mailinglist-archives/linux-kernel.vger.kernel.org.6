Return-Path: <linux-kernel+bounces-250193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4CE92F509
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8911F21942
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E319313BC39;
	Fri, 12 Jul 2024 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N3erS5ff"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5C13B78A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761597; cv=none; b=nlM0+6t57ExkBJgE6fu8N0aV4S2idsza7z4OYIF7SXVOpG+0JB12U56IxiGvg1nhCW0sUSsUOAx2kXk3p3FWhG64xPcGOmta176Lmqv/ORhA4jOeEZO5JvPx4PLqP16rup2hVPyAYOq181Kv4RtF8o5Y++EJ3lnRPe8Uk0Oo7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761597; c=relaxed/simple;
	bh=zEQaHkIHnLEwcguffr+8edDadfr0KsJyp3aPZNLWx+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3SNaIs6CL0fB9o7biDTv9Wm0v1XhCS97gYeSRpKuoIYoKezaWpp6kPHv/zpLat5HMmNBE73KnEhPptpw88V/L2Jr4+uLIapuev3cPr68jRQT0M8vl/hFAwsxS2xj+rZYxtY+erD9L6YG5vpmydVaE9LL96lriDn/uXnJ2ldYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N3erS5ff; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d9dbbaa731so910453b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761595; x=1721366395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJs3uYAgmbjgEj5efu8Z24w0fCzDc8W+Wf0sVn//syU=;
        b=N3erS5ffP4rFeNpcrVj9WfS3/FR0fcC7U3Y0J8z4ptVxhl+18RCUxS9EBzU3zyRAml
         TXmXEKgC54RfOp/SVXJbZbFX1GjX36bSM/hhRHcOhy0S0u3NHTundEy6+bF0CUuACynM
         G9RibQU5PBP/sSG1MpsSpfahhc/1qQSCJ7QJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761595; x=1721366395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJs3uYAgmbjgEj5efu8Z24w0fCzDc8W+Wf0sVn//syU=;
        b=GUXnNRJ3gkclD3qLj5ozg8ug1ukgwdgffgdXmEHTWcNjfMdJqsgNJLRwPBKR6EHWZR
         +g6UAmbC/y3rk3VSPsWtT+nvAkfspBAzy3EMfH2j9GzI26B8kmqpL7Uxp5RUKbg4Sl+u
         GYtV+8hjjfkrQvlA/6ddRD2tGhj7pRd3kfHsOgDs3CIWjmYP1rXdYtHj7yuFkBCSByiP
         IPa2iS8yv/rjNiq4WnuAaWa3vs9bNacMy5Z49kLyTj+WyEFxPGSDLgrdgtIRJbDCn0wo
         ddJlox5X1bdMjDdZOi2/x1/krZ8Vp3FgKbDP2kmZHRSOrePg/LHbEnY8RQPq2m4xs0BG
         Pm7A==
X-Gm-Message-State: AOJu0YyHyOlGwX3eDqWzxZ0B4nxA8AjbLid66sG1UIT0zQj+YTxwe5e8
	NfWfeqspq9hZywO8wqoQS04nspFw0JhqFU1tfXgdByuLPioxu1hz0H4TOxylfQ==
X-Google-Smtp-Source: AGHT+IGeKCj6wggEIhkK5rbVRPufA0jXDRCHo+n4P5SDGOIZsguPpIWfq3UtLpR21utxnl1c5msKMw==
X-Received: by 2002:a05:6808:15a2:b0:3da:a793:f10e with SMTP id 5614622812f47-3daa793fe0amr3234374b6e.18.1720761594886;
        Thu, 11 Jul 2024 22:19:54 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:54 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 23/23] Documentation/zram: add documentation for algorithm parameters
Date: Fri, 12 Jul 2024 14:18:34 +0900
Message-ID: <20240712051850.484318-24-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240712051850.484318-1-senozhatsky@chromium.org>
References: <20240712051850.484318-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document brief description of compression algorithms' parameters:
compression level and pre-trained dictionary.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 45 ++++++++++++++++-----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 091e8bb38887..e3cdbf4ba61f 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -102,15 +102,33 @@ Examples::
 	#select lzo compression algorithm
 	echo lzo > /sys/block/zram0/comp_algorithm
 
-For the time being, the `comp_algorithm` content does not necessarily
-show every compression algorithm supported by the kernel. We keep this
-list primarily to simplify device configuration and one can configure
-a new device with a compression algorithm that is not listed in
-`comp_algorithm`. The thing is that, internally, ZRAM uses Crypto API
-and, if some of the algorithms were built as modules, it's impossible
-to list all of them using, for instance, /proc/crypto or any other
-method. This, however, has an advantage of permitting the usage of
-custom crypto compression modules (implementing S/W or H/W compression).
+For the time being, the `comp_algorithm` content shows only compression
+algorithms that are supported by zram.
+
+It is also possible to pass algorithm specific configuration parameters::
+
+	#set compression level to 8
+	echo "zstd level=8" > /sys/block/zram0/comp_algorithm
+
+Note that `comp_algorithm` also supports `algo=name` format::
+
+	#set compression level to 8
+	echo "algo=zstd level=8" > /sys/block/zram0/comp_algorithm
+
+Certain compression algorithms support pre-trained dictionaries, which
+significantly change algorithms' characteristics. In order to configure
+compression algorithm to use external pre-trained dictionary, pass full
+path to the dictionary along with other parameters::
+
+	#pass path to pre-trained dictionary
+	echo "algo=zstd dict=/etc/dictioary" > /sys/block/zram0/comp_algorithm
+
+Parameters are algorithm specific: not all algorithms support pre-trained
+dictionaries, not all algorithms support 'level'. Furthermore, for certain
+algorithms 'level' controls the compression level (the higher the value the
+better the compression ratio, it even can take negatives values for some
+algorithms), for other algorithms 'level' is acceleration level (the higher
+the value the lower the compression ratio).
 
 4) Set Disksize
 ===============
@@ -442,6 +460,15 @@ configuration:::
 	#select deflate recompression algorithm, priority 2
 	echo "algo=deflate priority=2" > /sys/block/zramX/recomp_algorithm
 
+The `recomp_algorithm` also supports algorithm configuration parameters, e.g.
+compression level and pre-trained dircionary::
+
+	#pass compression level
+	echo "algo=zstd level=8" > /sys/block/zramX/recomp_algorithm
+
+	#pass path to pre-trained dictionary
+	echo "algo=zstd dict=/etc/dictioary" > /sys/block/zramX/recomp_algorithm
+
 Another device attribute that CONFIG_ZRAM_MULTI_COMP enables is recompress,
 which controls recompression.
 
-- 
2.45.2.993.g49e7a77208-goog


