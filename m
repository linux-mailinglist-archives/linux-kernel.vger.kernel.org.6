Return-Path: <linux-kernel+bounces-213523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B52907668
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882151F25253
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BA114A097;
	Thu, 13 Jun 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcJGPr3y"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118B149E0C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291867; cv=none; b=aiEFm+H+7JasUDg0f4CbRU3Hn6uYcpeflXqYq1pZXgZnLVKCLk/5n4sNAoM0S5zbI85HH/Twb7hUmiuCABkdDPIOao+GbPOtjXhYA0p+kMy7njJNJSvLKd0U4ZgVtV6kOf2kqizGmk7j+DiJyAwmdmr5izx1oFxv/pag7RN+hfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291867; c=relaxed/simple;
	bh=zN1UETXXdqrh3WBTxRV+3WqwL49VqCIOmitMRKZXlLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SRTAzodE06vdTDBI0srEqfD2xwLNF8b+BPqvq0850XOc281nT+fdH86qQn/24IAg1WPwKMLnEhFQoHWbXnAa+8CxNJKsNk3IacbZAUa3NvWbsdzBAjAxi27w9LZBAJauqv1VZQuE/UkxRMEByrKhzNPmFdI5A3WXJUKCCCR8NvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcJGPr3y; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35f0aeff7a8so1029470f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718291864; x=1718896664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BG0M0s1xfKWqVwW2SMl3OjEYd7P2vlsk2ol4M6/ryk=;
        b=YcJGPr3y1+e+PQoKNuBu9GBOIAmF3fZzToXB4WqomHFdRnII/RTtKDBh2C0tcZRfUM
         pC4YTP9LvqMCzKbMGZzpTSt2yGay5I6tKcgwSVhqfLu86bpYCnF//AaO45+0840epdIb
         pwnAo6iv16JLi0Ut2siz0BzONN3o5KWv7v81ZIr8KztPjMxo1DoYzLhqVSQsaBZvBzQl
         mp8fhqn8yT0pWpN1sbqEq62+qnPtw2/DsVG1nd9WR4g2xI25Y4o80VyzUhu829H37JFU
         VhOx4oxdWGi+paV1JGYd2Wkr9vs62Ph0hZ+T6g96A8ERqwZ2jWH8bSq93wy05ZHhCBdJ
         VgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291864; x=1718896664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BG0M0s1xfKWqVwW2SMl3OjEYd7P2vlsk2ol4M6/ryk=;
        b=UVuuZQUp/JyFXwBjqqh0juUtdWcpSqrEYQPRBxEDgdx38qrUpJ1ksVUgsyeiTN0T8r
         M/+f804FMoXy6tRdGGhmeqj8UwHAJUhmpYK8wZ+B0q8XNcf14dAPdePXvIKAjoFFcuy1
         1FftWbKKFdAVuCCY2kok0h40K6+bUyuOTACn/yOcgvfhl4KMVyWSuFELWE5lOVrfPpHm
         UAyhdN8FQvef92zWLPlSe7SwSuakcI4Itok2rQJIDVk768oFUn742dh8wQtn+rIZXYLo
         r954voqjtOTCAE9xQV4VFd8738HqxerQEjc1BAdCU0manabq8ITAzrN2Q+c6VTO0oJ85
         ptWA==
X-Forwarded-Encrypted: i=1; AJvYcCVPu9aekZ7dtDkVEN4GK3A6+UTYq/bDWkmUGPldclgh4axZXzXJE8ZQtg1a2f3f3SAOcrixrqWqvhgESq8B8qX+wmsRQeg9WO5p8ShI
X-Gm-Message-State: AOJu0Yxm6FoA1TonPwvRpink+4G8UwmW8vR4x61gn64Yr59O5EhouQ0r
	hiRHJTDjChss1jAhpC+gfjVTXgQpkVjma4yDms7VJL+mvu7sRWOe
X-Google-Smtp-Source: AGHT+IHivfMxCPLBIseyR/PkOdi/noH37L986yS0duDhQKgZmcCVn63dfugPrWMeffsl/KWndzwFpA==
X-Received: by 2002:a05:6000:2aa:b0:360:6435:b40 with SMTP id ffacd0b85a97d-36064350bfcmr6572880f8f.7.1718291864170;
        Thu, 13 Jun 2024 08:17:44 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm1856978f8f.76.2024.06.13.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:17:43 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH 5/6] staging: rtl8192e: Remove unused macro dm_tx_bb_gain_idx_to_amplify
Date: Thu, 13 Jun 2024 16:16:36 +0100
Message-Id: <91961c0f7acba56576cfaf2a19d2d4121c90e721.1718291024.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718291024.git.engel.teddy@gmail.com>
References: <cover.1718291024.git.engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused macro.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 3add5aa933b8..55641f17412b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -133,8 +133,6 @@ extern	struct dig_t dm_digtable;
 extern const u32 dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN];
 extern const u8 dm_cck_tx_bb_gain[CCK_TX_BB_GAIN_TABLE_LEN][8];
 extern const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8];
-/* Maps table index to iq amplify gain (dB, 12 to -24dB) */
-#define dm_tx_bb_gain_idx_to_amplify(idx) (-idx + 12)
 
 /*------------------------Export global variable----------------------------*/
 
-- 
2.39.2


