Return-Path: <linux-kernel+bounces-179430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709DC8C5FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A7C1F2582C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF786BB30;
	Wed, 15 May 2024 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Zwwe5qRA"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1C679E5
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748774; cv=none; b=bz2ca75Jf5Bpv076RYUlJeqdk+F2GNjFW+cIlwPGb8QC4KI4phvdyQPhtf3RV7Fgo3FBbo16xmQ6+tT0c0+pj1L5dy0BmJc01LEW5ohSX6JLuvb9Diy0WTKHqgqsrNoMk8JGVP6uU5wkH1aan/nSu+sZMRE/yF92h5Hdv6p/j7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748774; c=relaxed/simple;
	bh=pn9UPQbZxIB+0mfraO2Vc6bruKjkA6qjq/C8H1vwwQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuSPLmDdqHhg7Ko3niCAncdW1iQYnL7VHknja6x8ztNJp6qa7VRpfXZnV+z9zeKs4e3898yh9KM2IrOxpBHX+5mnawrZcJb5F4OkKQ0UHl4Sxnm9ds1b6OhQfIHNvKEoMbHaeOEC7tkn7mpl6IaEPxW8KMStz1ALCI20QrJWmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Zwwe5qRA; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f0f5633a45so2300001a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748772; x=1716353572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzLjZ0CTnzp8KIwZswEZEQ23XT8p+OmhE8BLAKBFIrE=;
        b=Zwwe5qRAdqqz9edmS/Jotu3UoTIBSK+G+IvJ+XFgTFHl71Wd25mZM0L3sHOizBKiEs
         540B1m44nBbMHo4tluGjM50TqS7NdyOllXuzIyw3hKGzHTDL2mUAYXbn4MlLJgX0a5Dc
         t2MtCyeBmOq6D4BpSpwJw2eXCCpGzqkfGewljRTZXCYtTub+LTBDy9WJqoQByM46pmZt
         vn+n64mEJTnqvzAdx5W53N8IftLyDKl3YlqZFwBvcw3/p9YrFkFYcPTAUthIIwVzZcjG
         YrrEtZ5TYmwhpWSKM7tHoj1091gq5M7sN/zTnOSCcyqP9YccWQaOTGPGfdlPeLLirebW
         yPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748772; x=1716353572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzLjZ0CTnzp8KIwZswEZEQ23XT8p+OmhE8BLAKBFIrE=;
        b=jmxCu16E+hECg4yH71eb8p9OOHtjhuK3f5QOqPkLWjUE/4q/kQKGpWsrMrvr+jMAIm
         crO8AR07sgHrO1m9R6qW+UtQx6rFJQ9U55oND1duhEOqzevhdAag+OkqSf7cVy14aC8m
         AmMAQOairFrN6h9XhWlQ2j0x/GVScs+PhyvNIKiTJwO3QUmo6tpc04p0eQGlTr6BVc4O
         RAkTQTn6lgrkj5pgX9Jn2+wHuzYXE1AsS4RK2nkD6xxBvvfOZqNBOWsM7V/QVlMiXt1P
         FD9FviJs98kSPGwTVTTLFzxlnVjJVr6Y39I/04l12tRu3fQ1kttioZbZKFckMSbIl5iu
         VuwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC6QJx6lh7CokwCUPqZdQSDf3Mc3mAh6/xSNlvXXIwc+2FLBQSVoZdqELgtBtyg98Ogm7L44eEDz9WEf6FvcEr4nAV6rgF0TI+Cbeg
X-Gm-Message-State: AOJu0YygYwMMdWai2Uz8mcjzZCh/TPBluY/XV1mrH3pQGwy/HFl2Hsfy
	ghlr2bFt61gZXoTgEVA5MzORxjlARSa9LcrqSGwnK2TAavLy3/5SAGMyrLyS0cQ=
X-Google-Smtp-Source: AGHT+IGgGIqQpaWOD1x7rd9UdYrZ542fTUvXzZxBfrO3UqFFntK9QJhNklFUC6uXbx5H391dJ5Cz3g==
X-Received: by 2002:a05:6808:358:b0:3c9:91b7:e7f9 with SMTP id 5614622812f47-3c9970bd1e1mr14790266b6e.42.1715748771975;
        Tue, 14 May 2024 21:52:51 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:51 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 25/31] Staging: rtl8192e: Rename variable bWithCcxVerNum
Date: Tue, 14 May 2024 21:52:22 -0700
Message-Id: <20240515045228.35928-26-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bWithCcxVerNum to with_ccx_ver_num
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 91164a3b01aa..4fec36cfa2fc 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -917,7 +917,7 @@ struct rtllib_network {
 	bool	mb_ssid_valid;
 	u8	mb_ssid_mask;
 	u8	mb_ssid[ETH_ALEN];
-	bool	bWithCcxVerNum;
+	bool	with_ccx_ver_num;
 	u8	bss_ccx_ver_number;
 	/* These are network statistics */
 	struct rtllib_rx_stats stats;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index d662a12bf437..328972cfd7a7 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1839,10 +1839,10 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 	    info_element->data[2] == 0x96 &&
 	    info_element->data[3] == 0x03) {
 		if (info_element->len == 5) {
-			network->bWithCcxVerNum = true;
+			network->with_ccx_ver_num = true;
 			network->bss_ccx_ver_number = info_element->data[4];
 		} else {
-			network->bWithCcxVerNum = false;
+			network->with_ccx_ver_num = false;
 			network->bss_ccx_ver_number = 0;
 		}
 	}
@@ -2352,7 +2352,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->mb_ssid_mask = src->mb_ssid_mask;
 	dst->mb_ssid_valid = src->mb_ssid_valid;
 	memcpy(dst->mb_ssid, src->mb_ssid, 6);
-	dst->bWithCcxVerNum = src->bWithCcxVerNum;
+	dst->with_ccx_ver_num = src->with_ccx_ver_num;
 	dst->bss_ccx_ver_number = src->bss_ccx_ver_number;
 }
 
-- 
2.30.2


