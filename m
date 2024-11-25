Return-Path: <linux-kernel+bounces-421387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516729D8AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14885284196
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB941B5823;
	Mon, 25 Nov 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crigx/jD"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D641AD418;
	Mon, 25 Nov 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553519; cv=none; b=sszjI/trTfUTKFhhiqma2tjjAB10uUDLxtlTypWz0+DDMTu7u1jlwfqJEhus+If2bi42y5Kaia0D2nl07vlpcfxU/GiimgTrnqIszz3VVFUwCeAOgQzxo6IoFcGw6VwDs5+urz8wKIRJW2TjVIg74z7slG2m9re8ezJjNFLzoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553519; c=relaxed/simple;
	bh=2rDqu+/4OieE9s4NHsH9Ous00WhWEbKGEdf8CwyIUTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lxd22EHBIxLNVkmk0NPUFIm2cFrZA3OWr98+ydbs3n3WXPZ6QmwyySRReiEkMr+jrAe3ymo5bFx5DL+jkhhrx1DHj2AicJ0pJMeU3BQjdYKV+tpVDFSth71Ml7bqjU3enmYOwYq9/5qQZ6KBVP0A1hBLj/WI6lX9vb7dJ1L5/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crigx/jD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21285c1b196so44440595ad.3;
        Mon, 25 Nov 2024 08:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732553517; x=1733158317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtUn9lt5gw5xGS0lfaSG6+NKW+5RIPrQ8eMvyuD2pds=;
        b=crigx/jD9xOplcVym5uoMN4OfsuFCghe37T+cRhzeRXIiXp9ZwlzPXr0SZq7mBv/W1
         QU91KcIGKwezp/9NKyufNungLVVFT7rE/dg+ZYY3bqepxDewI1QIgFfw9I1OMfX7G7GO
         rYBZHTm0Zkyxgy8SydhK59BB14bUbkmIkWpEmWmx0Dm1NDYQ3XtbndPovzNybTNCb8Hk
         GMniKKStGymzwHZdBu8LQh8e9RLhjzKD8bndDfmXWgTYegAOiUo/zJyxXfXYzIzIZzTY
         OFEXFLM+ms3vqlCUbmpKLcvA255q2ySnV9eSkT3gKzFaswvNJ8MydFyKXdZVhGgUa4GR
         xs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732553517; x=1733158317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtUn9lt5gw5xGS0lfaSG6+NKW+5RIPrQ8eMvyuD2pds=;
        b=jubR0e9k0vZgOuReNUEoth6AH9gGdgpxLMwDyKv0Qed8DSroexrLVeNuIl2NrPx4ZB
         2/QyV7/7VFI3vR87nCNnGWkbmRe1JwKwZPtNWarnuhpBhKgwg6Oymn+f3au1vFPudrbo
         Q6PsPj5tFxtP24pbg1PKASx0xS44Wkg02ZGCtpT+yof9M66soTMZl4poX6BtGrERDN3H
         W1GSaULABleBT1ojYLlat9nj5VePcz9jKySvX5uQWEfN1NxTDlTPzF9P5e2V7GszCDZ5
         R0Iz5/N4w2lyCigLS9Jp1jDpBvZpBZCuOI2ooFhblmsdQZ0lTGk8OGUAH/pZF1MH8FXB
         ddBw==
X-Forwarded-Encrypted: i=1; AJvYcCVYz7RJfg35hjrQzvODm8MsRwufGudu6JNh3Vp3bvOaF8IDlvm3K27i6Am4r/LB0JjWe+9/TDeDR/e8sb27@vger.kernel.org, AJvYcCXChtYedRDyhTU4QP8+c721A2oq8nfMmkSCydDyz1qPUxrrGeR9ilPdWEUeEf0p3X/V1+B/AxWYFW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiiHclcOOyHCa1p4TMdeqgaTQtr7rUGbHptgcVfO3h+qJALdZS
	xb4KK24YujLg4DgYbEmf2JSDQXlVvMzu1fwqwij9EcBC6zWa4tSa
X-Gm-Gg: ASbGncspaTqDDa6QBBD9joiGXt04pjzAQy8K83trz/ORJXORSR3Y8UbcMU8JjaoUxcr
	fXQ7guDmSIgZNTcBkQU1AggUia0sy9fSpfpUAKiaur9/ZRLezZ84C3JUwMyovdhouuqxtYFHSmC
	QeNJTGdnEjn/34Q62iPog+ZUpZoFe0OI+7/1csGhwpteDbIQjUXW5VmRS5qenCZein1eCt6kS6G
	yoY0fEbz8m6H51wZmciOdXuZjhv/w0KGmOQgS5YIjIU93X3M72WthwLVKsK9AaBmA==
X-Google-Smtp-Source: AGHT+IF1b8SEIuY7pSRwqzWQ7mPcZgZAK0pcvKoIaS7ug2WaDSKDkMZOsUR2pmo2Gs/K2dxHnsFHEg==
X-Received: by 2002:a17:902:ce8c:b0:20b:707c:d688 with SMTP id d9443c01a7336-2129f67b0a9mr133164315ad.18.1732553517556;
        Mon, 25 Nov 2024 08:51:57 -0800 (PST)
Received: from localhost.localdomain ([49.206.113.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2214esm67126995ad.236.2024.11.25.08.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:51:57 -0800 (PST)
From: Saru2003 <sarvesh20123@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org
Cc: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	corbet@lwn.net,
	terrelln@fb.com,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org,
	Saru2003 <sarvesh20123@gmail.com>
Subject: [PATCH v2] Documentation: zram: fix dictionary spelling
Date: Mon, 25 Nov 2024 22:21:22 +0530
Message-Id: <20241125165122.17521-1-sarvesh20123@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125024927.GA440697@google.com>
References: <20241125024927.GA440697@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a typo in the ZRAM documentation where 'dictioary' was
misspelled. Corrected it to 'dictionary' in the example usage
of 'algorithm_params'.

Signed-off-by: Sarveshwaar SS <sarvesh20123@gmail.com>
---
 Documentation/admin-guide/blockdev/zram.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 678d70d6e1c3..dbf2b4f47ec3 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -119,14 +119,14 @@ compression algorithm to use external pre-trained dictionary, pass full
 path to the `dict` along with other parameters::
 
 	#pass path to pre-trained zstd dictionary
-	echo "algo=zstd dict=/etc/dictioary" > /sys/block/zram0/algorithm_params
+	echo "algo=zstd dict=/etc/dictionary" > /sys/block/zram0/algorithm_params
 
 	#same, but using algorithm priority
-	echo "priority=1 dict=/etc/dictioary" > \
+	echo "priority=1 dict=/etc/dictionary" > \
 		/sys/block/zram0/algorithm_params
 
 	#pass path to pre-trained zstd dictionary and compression level
-	echo "algo=zstd level=8 dict=/etc/dictioary" > \
+	echo "algo=zstd level=8 dict=/etc/dictionary" > \
 		/sys/block/zram0/algorithm_params
 
 Parameters are algorithm specific: not all algorithms support pre-trained
-- 
2.34.1


