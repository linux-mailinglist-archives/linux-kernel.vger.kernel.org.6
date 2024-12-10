Return-Path: <linux-kernel+bounces-440307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858EE9EBB88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5323816847D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB1C23238F;
	Tue, 10 Dec 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtwL4ZBm"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5FA23238A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864910; cv=none; b=cPBjGwjjEdUmX/vGncWtGpHkEp2wghpsj5G6F+QhSCz3lcv082lZdm/n2wVcqevIw7Lzld+SbUDcwKmkS5uPw85nwo78pc879APZlEfTCTYZ1jhy8bMZcnTh9pKAk4MEuuE5KQgaF5nNbg6V73vbZcWiL35l57n/0I3uA3AQvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864910; c=relaxed/simple;
	bh=CDXIfy3YQvMoIcBioQwy2dUQZMASYSjIFSFtueGVukU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9n36A0+byUC1l30dAp3EB4xmP2oVFNAFTwa+zSqhUm/7cjqt9vZ1lG/Y5Sc1YTZaDG6OHj7SU5ejYam8n3kr+JP/w/b2bEvS2B1fTw4khJnRs1sNkC28RMext5ZJaJfojVZgKmEfZxGGHbT4WhFO1Fiyk/kTNCOat7PhgddeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtwL4ZBm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21680814d42so6646045ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733864908; x=1734469708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmM5ilpxdp/4WJ1oVXkjuvQCAWPFFBfzL+5a70ISH3A=;
        b=BtwL4ZBm9VpUiQfSWha3BoOUmc6cyGUwiJmwmoF3gYYkJkswHsQWTZjDq1GSik4eV+
         euwRBDOtFWH5BR4PFSqb8ZCos3tzEs4NDawavCx/AFHAXqfG6Q7xByf4i8RGsNJ+iVN9
         iq9FQvdgXJrVcnH4oSZPk7GA2jht+RxzVZS8+s5cBiRTVjxTtylLNYgjhjjpi8PHmn4i
         M1dWO3V4VaRpA67aU4ggnKCyr8URRTA2IsegUdIfNqIqYcjf5SaftBnFxDVZnO705HId
         nNGR3NGdn4effH8Lwk8Yy3VnEkohrPtESBKA7AuJlYB5Nt4iW5gzQbhjjOnti15Cc0AW
         uEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864908; x=1734469708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmM5ilpxdp/4WJ1oVXkjuvQCAWPFFBfzL+5a70ISH3A=;
        b=Akt6LeXQ/BxVfXfvHJ2fNIFMOiS5OIMR2HqNnkPFM7c3RVQZ06uWO1XgPTh/ZIqYP5
         fz4xr1C/Gd5jWwksnZhUASAhU6fwrwz4cP8mvjiwKgbcKftbScqydiwD1bzLxROrnNwh
         4IGud3xZ9AG6pr+ygc5gWDjxxgtHUsopcY6Dc7OCF+Dk2njFIOwzhGOSLJAyuN4i+o3X
         uAekVRfRz+g6HXR9Iho3JgNNcrAoiuYporL9C5NCe9XTbEOerE+H0ZwENSx9CfWi6Owk
         Rveg54caRZRO6f4x6DBT+B8YU/X9y89r4jRrHy8vdTN2BB8hN67dX64nkxaFEjEohoo9
         UY9A==
X-Forwarded-Encrypted: i=1; AJvYcCXTw9tHtZvsuKrvC64LtH1417Y4Sv+fYxHZBjRJlsITFO0zh4NztUAXOQkgdJt9EIDJNLVjCrC63knqTns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/TGoEbTntQs1hctx/PmStXl9Mf+P7TjRJ7mIWBzabZ5MSY3d
	j+NWCWKuynJo7u/MS7v4Sq1dLmak6L3KD6T3J/gM+RITrxyU8pOS5xrn2AHd
X-Gm-Gg: ASbGnctWAyfWuQPFE1RRD6umggK7iY7sYwa9gO24/kwYLFjVicCk/CTptVQ+U9ZAB1c
	KGwNu9ZLAr8JCIMxO+6ewDI2jDOTgCLtSDGTjJnbzhsGIv0htWnu5EWESJsl/kTchT3YXRmoMdK
	1SFVy4fNqLu1JDcB2o9vRodJmw8K6t28DeGYghxveJuT049zastXEz4Zpf793AZAI+XLZyhkCht
	77nBGs8y3vW0VHpQBW+/9hD5FTRJAR34205CCDr54V/ufqCAGk0qdQXeoshCgm2Ze0D4smuA3g6
	KQ==
X-Google-Smtp-Source: AGHT+IG3jeXkz7uIamB7vFNp+gUbCT+d8SNySxHxTgaFtqZZSw2v1DEnnuvbqQj7GfGUZ0uwHg4eTg==
X-Received: by 2002:a17:90b:1650:b0:2ee:a4f2:b311 with SMTP id 98e67ed59e1d1-2f127f55cacmr693734a91.8.1733864907550;
        Tue, 10 Dec 2024 13:08:27 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700979fsm13385731a91.18.2024.12.10.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:08:27 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] staging: rtl8723bs: remove HAL_DEF_DBG_RX_INFO_DUMP caller
Date: Tue, 10 Dec 2024 17:48:20 -0300
Message-ID: <20241210210741.17101-4-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210210741.17101-1-rodrigo.gobbi.7@gmail.com>
References: <20241210210741.17101-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the HAL_DEF_DBG_RX_INFO_DUMP enum caller due
to the removal of DBG_RX_SIGNAL_DISPLAY_RAW_DATA ifdef.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 317f3db19397..952ce6dd5af9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4959,7 +4959,6 @@ void _linked_info_dump(struct adapter *padapter)
 					rtw_hal_get_def_var(padapter, HW_DEF_RA_INFO_DUMP, &i);
 			}
 		}
-		rtw_hal_set_def_var(padapter, HAL_DEF_DBG_RX_INFO_DUMP, NULL);
 	}
 }
 
-- 
2.47.0


