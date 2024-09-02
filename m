Return-Path: <linux-kernel+bounces-311169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7E2968598
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77BEB25548
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FB3200109;
	Mon,  2 Sep 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxx5XrW2"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5718593F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274674; cv=none; b=RwZb3xLFZF92WB3NO8/ItBtti5n5HPVXQ1FZzPJzdjQrDy9ZrhJFYkyEvNKDeJvz9k3iMPsTMTXNaiWHmfj3mZ9F9C47hOMSiDk8v7IAu6FR9m+1ncbVlAngCEn4GB6PMJtDf+pnjZ9YUNzKofrehGCGhXF5SwUcelR24HXTsTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274674; c=relaxed/simple;
	bh=AE/WqtEbSPbB0Mv5p05o8b8pv0X98CUBbHDhrjrLRmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ2gzzbBmkr93Esd/KA0wwi/PqdqX/Tl+RQr8vKdGxb8wURsZMWow+7PaF55RToD1dx24atqgAouXdqnlTPTkFIK+GbXM5qGh+H/U1e0EVJ7tybF4u28XI4bKiJ3TWXmVVPEKIKtYxMdrBVmDuLfWCOqZShkAVQyISxjVQFXUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxx5XrW2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso2982855a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274672; x=1725879472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbZNPChlJKjfmmUIfS51iuf6pveXQDG6PrtZ+3HXZQQ=;
        b=jxx5XrW2V8Xz391spZZI6jdMiOsvr1uA+VISCPet9iXV0WUg0JUt1Pae4mBBQLb1yX
         1SNxZCfgtfTL9aeXWdmsAQgFOry36zGNkB01m7ZYTt+wvabaHlthD9oaM4aqcnclIT3o
         t03/b8s74zbV70FLIJmNCrloUc0rhQZnkCCJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274672; x=1725879472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbZNPChlJKjfmmUIfS51iuf6pveXQDG6PrtZ+3HXZQQ=;
        b=ddp00SHIVD/1YTRC/CMvXOR/j8Gyg1QefKqRGl6zhX1dyAy4BPNtX+BVP2TSIisEip
         gtGDFmfr++YY4fOSkiiCM8sjH2DVynbf9iviP9bp6LTIDQM2NmRJJJlMs89w5WGpqzLd
         wGYmQybiC+froj8LBZ9oGkwmUczZ5wZmFx+vxU2nv7ogJuSRuz0F1mMVhE+s2U0b+/GU
         SB5K1QYc6dMc6+eGrctpb0RtPsfKXMtJFeqv1BU0jcYoxYELhzWQbldp5a1mdAy5uVZY
         ivVN+zy1i0Lyme5ZGbONTwiErC2YpaqY4zDts4lF9CWYSkCWwTXVM3TSCc2zeK+8jhLW
         eLRw==
X-Forwarded-Encrypted: i=1; AJvYcCXzdEAk+Bwzs0mIgUQsZdGJlhNPJTvqdPpIcAZ+v60u480ssIrN2Qvh+NR//SOiCnoWL3XN/kza3sJcsHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBzuKuezVbqn7zeQW4XkeAqA9p0kRRikdUlkqOaL1kEiYOk0e
	Wr+dTJmkkv50SVkXV2nTJoqSBbIe6dOFUgeuV+/FZBfrjm6iP9Wusz5gTxxSNQ==
X-Google-Smtp-Source: AGHT+IFNEGLegGQuWu7zwaVsoGnyvcQAlLtRk74EzF4/gmOT8492xTQO7/i7mwQV/rFSW9WT2dW9ow==
X-Received: by 2002:a05:6a21:9688:b0:1cc:e9bc:2567 with SMTP id adf61e73a8af0-1cecdf2955fmr10375322637.24.1725274671859;
        Mon, 02 Sep 2024 03:57:51 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:51 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 23/24] Documentation/zram: add documentation for algorithm parameters
Date: Mon,  2 Sep 2024 19:56:11 +0900
Message-ID: <20240902105656.1383858-24-senozhatsky@chromium.org>
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

Document brief description of compression algorithms' parameters:
compression level and pre-trained dictionary.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 45 +++++++++++++++++----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 96d81dc12528..bb52d2fc0587 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -105,7 +105,38 @@ Examples::
 For the time being, the `comp_algorithm` content shows only compression
 algorithms that are supported by zram.
 
-4) Set Disksize
+4) Set compression algorithm parameters: Optional
+=================================================
+
+Compression algorithms may support specific parameters which can be
+tweaked for particular dataset. ZRAM has an `algorithm_params` device
+attribute which provides a per-algorithm params configuration.
+
+For example, several compression algorithms support `level` parameter.
+In addition, certain compression algorithms support pre-trained dictionaries,
+which significantly change algorithms' characteristics. In order to configure
+compression algorithm to use external pre-trained dictionary, pass full
+path to the `dict` along with other parameters::
+
+	#pass path to pre-trained zstd dictionary
+	echo "algo=zstd dict=/etc/dictioary" > /sys/block/zram0/algorithm_params
+
+	#same, but using algorithm priority
+	echo "priority=1 dict=/etc/dictioary" > \
+		/sys/block/zram0/algorithm_params
+
+	#pass path to pre-trained zstd dictionary and compression level
+	echo "algo=zstd level=8 dict=/etc/dictioary" > \
+		/sys/block/zram0/algorithm_params
+
+Parameters are algorithm specific: not all algorithms support pre-trained
+dictionaries, not all algorithms support `level`. Furthermore, for certain
+algorithms `level` controls the compression level (the higher the value the
+better the compression ratio, it even can take negatives values for some
+algorithms), for other algorithms `level` is acceleration level (the higher
+the value the lower the compression ratio).
+
+5) Set Disksize
 ===============
 
 Set disk size by writing the value to sysfs node 'disksize'.
@@ -125,7 +156,7 @@ There is little point creating a zram of greater than twice the size of memory
 since we expect a 2:1 compression ratio. Note that zram uses about 0.1% of the
 size of the disk when not in use so a huge zram is wasteful.
 
-5) Set memory limit: Optional
+6) Set memory limit: Optional
 =============================
 
 Set memory limit by writing the value to sysfs node 'mem_limit'.
@@ -144,7 +175,7 @@ Examples::
 	# To disable memory limit
 	echo 0 > /sys/block/zram0/mem_limit
 
-6) Activate
+7) Activate
 ===========
 
 ::
@@ -155,7 +186,7 @@ Examples::
 	mkfs.ext4 /dev/zram1
 	mount /dev/zram1 /tmp
 
-7) Add/remove zram devices
+8) Add/remove zram devices
 ==========================
 
 zram provides a control interface, which enables dynamic (on-demand) device
@@ -175,7 +206,7 @@ execute::
 
 	echo X > /sys/class/zram-control/hot_remove
 
-8) Stats
+9) Stats
 ========
 
 Per-device statistics are exported as various nodes under /sys/block/zram<id>/
@@ -277,7 +308,7 @@ a single line of text and contains the following stats separated by whitespace:
 		Unit: 4K bytes
  ============== =============================================================
 
-9) Deactivate
+10) Deactivate
 =============
 
 ::
@@ -285,7 +316,7 @@ a single line of text and contains the following stats separated by whitespace:
 	swapoff /dev/zram0
 	umount /dev/zram1
 
-10) Reset
+11) Reset
 =========
 
 	Write any positive value to 'reset' sysfs node::
-- 
2.46.0.469.g59c65b2a67-goog


