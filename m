Return-Path: <linux-kernel+bounces-547617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C936A50B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D1C173D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81830253B76;
	Wed,  5 Mar 2025 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g92+gyt8"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32C253B7C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203475; cv=none; b=EoBx9mj2PZiiXtANcwi2xIEMG7TUJvigC8F1CE8vEY8Dhr4e7gwHzXkw3tOZlpIxDwh7KH5YuDLweB15sWN2jFQwXKpr/gHp/xu2y8NFUMy/4JHEKG+6fWKMrGXSuwgSzBbTtoWQLSoJxxThfVgL10an0q3zrx/bGJJ71z6WpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203475; c=relaxed/simple;
	bh=r/JCkE1A/VLSmSiv7YzZkQknfhDehP9WWEoKTpqyRXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4KT+yxkf7QKM9/+jC+hKDpN0byIR9FhbirAQsNJ1Xvpvf9aXWmFd2R4g4diW88ivetAyEsiundD5AJ7iLNiMSh65hg49JEjZCqq6I0zEYlRqEJeXu4LpjxrzvXfpgWcd3hPWAaOfgg4E4QWeLZWdQ+ZI+XaX76NBQs0M0errkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g92+gyt8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so227295a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203474; x=1741808274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVL5x+1w+5pdmFPSNp6O0gS3bmjeUt72DJ16wn3q7tw=;
        b=g92+gyt8PafJK68hqTKBTTJ5LyaNNmL4ZOUOB5icOMxcbVjR/Fwt6lyJTh8erMX1IO
         HaR5b8seqw1SNUHUiThPzOWiNjkp3ugfgO5CkXEN6bNS/abP4AiqCuQG13QeyAniqQHP
         NjRg1iCedZBzGRuhC0ROOHxkX2Nb/2JWpetB6F2iSTpV7Qb42pwDlGfQ3ZWUIciXYues
         MSu2snhsDSMdpAvs3olSotqnRN7ez0fZwn+0KuvPtY2s1ZF58kF7ZBSHM1Ibg/rXERFC
         4eR9m+GXJMC/PODAHaU834sZmsi4R6T2dOEbnc8n+mzZPIqESHElmIS9JVfQmsDc+OFG
         UfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203474; x=1741808274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVL5x+1w+5pdmFPSNp6O0gS3bmjeUt72DJ16wn3q7tw=;
        b=AKtfkFCIKhXLFF4jhJdqv3kTjkUjsxTlRbwzmG4NlSuKrU/xEm+V+TLoRN2M3Z5UMU
         aOm2xcDLtqRGe8UBh82FrcsJmT7lbQEPnMWYmPeKLBuWLUCNSUOn2OFYvsPILCZI8S6d
         EfDD/1A4w2anwunXS6iNOhCbyOhUyvqb/FFO1jASuisKwppjbS1HaInZSwYa0L0mfql+
         pv/wGjxL5IY8I4pRTKA5TRalvhSMRhIngdIcAmN4Gs0O8yR8Tdiy5pgckQ3bEptZ5Wte
         kNzi3qNhOx1Ty1Ns0+RPF8tteSJcelSboBRT3CguwxhetEzMslDDqbTvHiSCNlQXyUOg
         6tvw==
X-Forwarded-Encrypted: i=1; AJvYcCUYoppatg9/ETy5kUfV1Aysow4pEFE7jYhgWbTAorYl6x1C9MA3N3fq9KYM+ZbplQlWRuLwAeT8IQpM2aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYPc/Wit5XnAp52UQA0avR1rg1FQivf52Jc/ja7clADw0JRdo6
	CuqWGiOdCcjDleCRJTOkoSIKCP7XztZmn//MDOng993v1xaYvNlc
X-Gm-Gg: ASbGncvGkxUAMvLTI/ROan4FrUIytyQtVJXWRVrGrReIyVWLPN+LAi0gwBGLr9gEtPm
	6n2wxM5UedWFQ6VgZOVo1/cp5oLcLxmOJ0Wa3vhysX2qzvPXondk/vGt5c3C4ortpVfav/+PzN3
	7U21gF7N9eqQ+3Utd77d/mNltbEt1VMQH37QbCdxTCyGZNJo/va9d3lAVJJY759XYrhDZrgvUAW
	ymZdIQtwVTWeDEI/Co6HbWRd/C+jFO3WDOLy500aD6gSv4gkT2bquZP3WjX8sqKpvs2eRRg2keC
	0vx3YhMAgWsXG9ai9sfe/d49J2YrsggvVPIS3TABeUIJvh67YUd65N1QJLEx
X-Google-Smtp-Source: AGHT+IHNsyo24/zrvRg4XtHFBGu5hJ7yR3l2dvNxqCeNbui3/L/DlOgNcf1xKJT/5yBT8maOJNvE1Q==
X-Received: by 2002:a17:90b:1a8f:b0:2fa:6055:17e7 with SMTP id 98e67ed59e1d1-2ff497df3d2mr2866356a91.8.1741203473716;
        Wed, 05 Mar 2025 11:37:53 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7a2bbesm1898148a91.37.2025.03.05.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:37:53 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	niharchaithanya@gmail.com,
	jiapeng.chong@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH v2 3/4] staging: gpib: fix kernel-doc section for usb_gpib_line_status() function
Date: Wed,  5 Mar 2025 16:32:20 -0300
Message-ID: <20250305193614.39604-7-gascoar@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250305193614.39604-1-gascoar@gmail.com>
References: <20250305193614.39604-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function name field in the kernel-doc section for the
usb_gpib_line_status() is defined as 'line_status'. In addition, after
the kernel-doc section, there are three macro definition instead of the
function definition.

These issues trigger the warning:

warning: expecting prototype for line_status(). Prototype was for WQT()
instead.

Fix the warning by renaming the function in the kernel-doc section and
by moving the macros to the beginning of the file with the rest of
macros definition.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
v1 -> v2: remove extra blank line added by mistake in v1.

 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 090857824d07..4a8e5905daf9 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -78,6 +78,10 @@ module_param(debug, int, 0644);
 			dev_dbg(board->gpib_dev, format, ## __VA_ARGS__); } \
 	while (0)
 
+#define WQT wait_queue_entry_t
+#define WQH head
+#define WQE entry
+
 /* standard and extended command sets of the usb-gpib adapter */
 
 #define USB_GPIB_ON	 "\nIB\n"
@@ -644,17 +648,12 @@ static void usb_gpib_interface_clear(gpib_board_t *board, int assert)
 }
 
 /**
- * line_status() - Read the status of the bus lines.
+ * usb_gpib_line_status() - Read the status of the bus lines.
  *
  *  @board:    the gpib_board data area for this gpib interface
  *
  *    We can read all lines.
  */
-
-#define WQT wait_queue_entry_t
-#define WQH head
-#define WQE entry
-
 static int usb_gpib_line_status(const gpib_board_t *board)
 {
 	int buffer;
-- 
2.49.0.rc0


