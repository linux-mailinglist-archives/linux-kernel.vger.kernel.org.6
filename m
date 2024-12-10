Return-Path: <linux-kernel+bounces-439398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F02629EAEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91652164BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25CF210F44;
	Tue, 10 Dec 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C3yprvHr"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B72080FE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828072; cv=none; b=XrVwhpdX5nBcHrg6MrAQW1LEwJexK6mz5Yw2bDPpwlafMzeXRYTiTL5sCAmzOUH35LO+rfH4LVaUKksv50I7TScGS5G2YyOH5X7pyjUdeQtJzOe6sPeAG9IX7V/mq4n2082944R0mYdE4MXRTnpKMHyvn0e7JfhuAeDz5fULLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828072; c=relaxed/simple;
	bh=CCuhclzq1Bj2x4zFpyOxb3Seo48oZFBuzLTkJ5AkbGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4E61cJ9j+cBC6cXSzzX7n0al8GnH/cGEAJN/33OslYv6PU6eZLh8iTQsLFxRnfR6Kw6WPJHPsLG5G8J/3jXL45Lwj68uFCdWlWinlUvp68qtqMTTf+64oD9Or1z1j1WYPaiiTK7N+D1/NSCUe0PChO/+UnBQp9DBPJ1IpakwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C3yprvHr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7273967f2f0so1424928b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733828070; x=1734432870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBgnV26LOPK7kV/TRK60xkNTdvFSpncDHyQsHKHEa1Q=;
        b=C3yprvHrp7c1A1o0dvCt8MPzmW5tFB7a8fNsO96aD+4qY6P7I6sI4cgddO2zhYRLmg
         5mMzQj/DAqAYd8p7QPIbftb3K8KEO/RJRvSWAvawsDDERkqMta/cJ4PkDhlGMNNGvm0e
         Ok0zbWuzfGYeJB6Q920FiS2t/3085yUyE2gQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828070; x=1734432870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBgnV26LOPK7kV/TRK60xkNTdvFSpncDHyQsHKHEa1Q=;
        b=QiG0XPeJZVuNQ8K9xTu+3/+mwcScM9A7AeAlZigxeVNknPttyyUYQXMM4i1sfXBA4S
         oPXSdTcL6gU2+qyPPaNUBepZR+nfMaKZpi2Uh1eyiiCnV7QcjvddZe9iA5INL7cWPhiN
         2uuN2cqzAfH5cezvrorEcCJBmZJ3q+pNDc+LWh5G/Jo/smwzcyvm0CeggrMNsnOEYxH2
         srV85xBMiIkQu3fPxGUg4AatLbB/aL9WSb6LX1E1prC6CPROWEoutwEUr7QtfUtdWqMe
         XTNHf1BHdIde6QS27IDz9uOt7JGxQ3Rupnt/7dzruAg3kJ6zcglPJnw5GBruYBuSiuMd
         7eOA==
X-Forwarded-Encrypted: i=1; AJvYcCVFQo+1gw9u+vx5Pa3K+/FvjLy7p8dUraOXBUy4Wxp64UK3BjUuE6liM/jID77sTERf53mojiZYjWBkCBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyScueDa72fYyAJuPQZWGvEz+eDOkApTF8u07pWkdWqTEhW+dlG
	A1gVppcKsH47MfYU9vNrocfr6d9gAZtdCH2K3LYt4MV8ACYRDHx5fVIT1oM0pg==
X-Gm-Gg: ASbGnctwzdfrJCh8g9SRSL+vSyjKptK/cXU23ZHeTaO3UrWtgDirL+/0AR793RVkHrn
	Z9foAbuI3w/PYnZC9teLRDbPW/U7XGlqcoo2swR4T1XIjmCYQwLGpXxDcNCgov3fyBBYCQjN1Xf
	Mt60IaFjN35voj6ozCZtlp4M6BfowxOzMz8MXBPaXweGJUbfZ1L7BI+LqMK5GdUxAPgZ+3HQxFz
	NsCL37FSrOwDuf6YvK3cWrQ5Z8TevJosnY3XaaN5wy3We2Tf9bgE5Z2
X-Google-Smtp-Source: AGHT+IHN5FQB1uPxNfGbJsfWaRhVvwe4RKqTEDg2FsXlyWluGVdmlf9tuZmfWudvDjFX+ZffT2ip/g==
X-Received: by 2002:a05:6a00:b82:b0:725:ef4b:de33 with SMTP id d2e1a72fcca58-7273c7feaf9mr6117335b3a.0.1733828070002;
        Tue, 10 Dec 2024 02:54:30 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd37745f99sm5583605a12.10.2024.12.10.02.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:54:29 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/6] zram: cond_resched() in writeback loop
Date: Tue, 10 Dec 2024 19:53:55 +0900
Message-ID: <20241210105420.1888790-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241210105420.1888790-1-senozhatsky@chromium.org>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writeback loop can run for quite a while (depending on
wb device performance, compression algorithm and the
number of entries we writeback), so we need to do
cond_resched() there, similarly to what we do in
recompress loop.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5de7f30d0aa6..172546aa1fce 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -889,6 +889,8 @@ static ssize_t writeback_store(struct device *dev,
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
+
+		cond_resched();
 	}
 
 	if (blk_idx)
-- 
2.47.1.613.gc27f4b7a9f-goog


