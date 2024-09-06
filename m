Return-Path: <linux-kernel+bounces-319453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4863C96FCBA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071472813BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B091DFE22;
	Fri,  6 Sep 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CUgMNPLR"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A81DA63C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654505; cv=none; b=nPUXAf3B2BybqAg/jL/uJrEIzCccuewUwvf/SxhcN5J0boqDYRmTvRKOxMeNggviSU3VH3OB8Gr11511rvNWIUStVBcfnyPMt+Quqnk/4TVfwjRal8K8Oajm8FW643Wxe9yzzAGkZ2JfwDuf3BpbhOJtwCR5u6IsPJtlL4IYbis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654505; c=relaxed/simple;
	bh=E3uOxF1ZH/iR4ucEQmsFO/keFaNTqRqQ7i07DVck9j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogPWJkmRBt8AczMzbenrR3s1pvlDe3yoKr//D/v1AZZJ39G0L/SIP0cI5P80q0Nf4LAy8oT/hyw+gYFUA/Ll2c5FkGaES2H4r6///e8Tp9/YA2Rx6yBsWwdSWD4XLhJsSAabj+onO97A6ZPQsBOTO0taNkMpheNVuF2PMg/UNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CUgMNPLR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99e8c32c0so50439085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725654503; x=1726259303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnAfWEx/aiVhm89Fpzc3fk7i/4x7q8oY7L/gONXGmMI=;
        b=CUgMNPLRvex5vKPhRtEPkNwsuf+vBVuMMpH51OIEwSU3fZ4XEXKXytK5ROwGKs5/R/
         NgJ1eibl2+lbAdw3ysyPLSFhlTWpwLhP6cXIjYG4gjRD5hSYHzgwzk0Tb691w85957tH
         fQVD1NJkvJD+RH6p401AOCIFdrgbHKnBrXqm/zy8ySff3sxz6j38y6iMx25wwasIfpeG
         DXCU6sK6iqTIFO6zCjla8iG3bcw3img+k/NyY9WYyRvxi/oQMAGmDxDhabiiiIbEAeLv
         Vnbt1tYWFYFJkznlTPmauYKZjazdFAFDd6tysJ6Imzh/YU4rGkikJYDGq1Nr8Gak4xVY
         vJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654503; x=1726259303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnAfWEx/aiVhm89Fpzc3fk7i/4x7q8oY7L/gONXGmMI=;
        b=BQxpAeEWXnybR/kNVfZ8UTMTPPJG1srqkZ2/1aeH40h8wnc40Mb42dAQkLno1Y50M4
         i8ChHRuen2d6H1q1ghpFrhpSQcCwk3x6DO8gNHzgLptr673A3E0pG5Ml5txuHbNh45UT
         t8JX3+9EqXsANn9TaX1MDaQABkDFn4TsCYt2Yof3NW78kFxQKqO0dc/HdbviOc3EPwSJ
         3J8skUtOzP2meaT37h2KQvZ//Q/UEMmKOfqGEFDvwDEt5YpvsK88B5v+OgqIYFYJsa7k
         4On9hQuDkq7tQWR7HrX/wm/TW95EHi1N4KG8uXdS2GLefv8/1gY4yuF829R60h1F1LNt
         O4WA==
X-Gm-Message-State: AOJu0YytldE7TdbH19EreEtG169d1+aPGyIXDI8gC90Fdeawk/P3ArjQ
	6nQgA9SoDEXPzfBes2CAUQK2g37gb5mBChrEdcqeiop5VSZ1ieBa2egIXl6mc+E=
X-Google-Smtp-Source: AGHT+IGNKUXGcQEHZ7PXWPlir8YbvSOsbPfUe2vpAa/Zk++V48k/OP1Q/5znMUllsHdgKaBBuRjP6A==
X-Received: by 2002:a05:620a:4490:b0:7a3:6dd9:efbb with SMTP id af79cd13be357-7a997339e8bmr471752785a.33.1725654503233;
        Fri, 06 Sep 2024 13:28:23 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e653sm200519485a.5.2024.09.06.13.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:28:22 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH 3/6] libstub,tpm: provide indication of failure when getting event log
Date: Fri,  6 Sep 2024 16:27:42 -0400
Message-ID: <20240906202745.11159-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906202745.11159-1-gourry@gourry.net>
References: <20240906202745.11159-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If get_event_log fails, at least provide an indicator of this failure
to assist debugging later failures that attempt to interact with it.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/libstub/tpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index df3182f2e63a..192914e04e0f 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -185,8 +185,10 @@ void efi_retrieve_eventlog(void)
 			get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
 	}
 
-	if (status != EFI_SUCCESS || !log_location)
+	if (status != EFI_SUCCESS || !log_location) {
+		efi_err("TPM unable to provide Event Log\n");
 		return;
+	}
 
 	efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
 				   truncated, final_events_table);
-- 
2.43.0


