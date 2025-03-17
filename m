Return-Path: <linux-kernel+bounces-565042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEDBA65FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4F73A6BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD81F8ADB;
	Mon, 17 Mar 2025 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="LV2Uoj8L"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1F1DDC15
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244920; cv=none; b=akV63Csuz/XrKJvfvZDlCf9Utvr4NPsqtgF3sBf+Unm/TyQ9DvunyLcp+vYJD8SnhceSdtQ8l4RNrZrrI7aNAD5URM1eOM/tPle31ZryldYfj2MnUawmYVF6wGojW+Z8dBqata4kw9OERSRTnjLq7akbBDINbLhpKxBM61E+SMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244920; c=relaxed/simple;
	bh=ZTfeW4lIxaywxkO8YqYFYqa7CSW6sPE5j9OCLcLq5tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLCFBsA57HiOVoeDL36rvZh41g4zKPMATQGiL2/6i5I2CVmoaNXx9S58FYTEFZ1tE+QFnIwM25bRmwWbL5kpZwyxxK09VpfW7rjGyZPt5/P9edHIqk/fDq1PTcw580VhPUxPMTuP2WRMUhxGhs1FDgSFzcAZ+YPj5oi1CQBIkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sargun.me; spf=pass smtp.mailfrom=sargun.me; dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b=LV2Uoj8L; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sargun.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sargun.me
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e636a9361a7so470107276.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1742244917; x=1742849717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uH6zXcWRgDlv69AYoY+cQU8cnjmRD3eomKeXACMA7uk=;
        b=LV2Uoj8LNrdtG4wa1vpmoGZP1wu7kC/M515JH03LrBQ22Uvg+kiUuBjqlaTQc0HF4w
         K5AWqpzLHN+VjatLf57nAc/3LKcLbYpxRPaRV5Wb4MGpIdeva4qXd5/DmKFJro9Lnipf
         0zYC2T60KT+HAbvRp0Ju902JzgA9FVXC9NSoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742244917; x=1742849717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uH6zXcWRgDlv69AYoY+cQU8cnjmRD3eomKeXACMA7uk=;
        b=vnfClvllVnekzlgFiWTs67EIVoA+NbUPvjzqC7KMC83EM+/TsnvQ+tS4cvZM6s9fTn
         5YdzqH79qmzG1qu29YwgkSBnCspEEcF13umAnOn0WCUHuCUe1Y53ExDiRKfk7QocuFl5
         ktmKk/bkH6Gd4ASw8jmo9osqXXKcqAo0RauF2TaqYZD2hGmvDZRyj1Pxou6yJoCDNVV0
         G5TicOLgn9wc7kK3+QI7IQ2LXW38XJdA6Y9sBZPM7pdWyiIGBDmF7xgRhlONBk6qn8OG
         R8pBGEygarX+0s9X4Q4PNWwMW1bVaV4F3PfVjoOKQ7BaXAxqWY1g1DB8VK6zriLyFp/o
         5O/w==
X-Gm-Message-State: AOJu0Yyi8Z1o+NxggIZnXb/EobAxFwM0arOyU1EL2fssWlsyxfhpRsOX
	iycGvcQkcv+/5/1uEWgabO2BPwNWQ2+cAM2U9kIsqeKlToTISsx7NV9rqvg3JteiFKoobeyVMWX
	AqCs=
X-Gm-Gg: ASbGncspuxo2uAH1Z/Ry79xrblck8bX+H1DD/4uLjBDo5wRw0Gpt6liv1Xl1yClpJZi
	qa3XukiWffdq4ZpC38aIlEfKjrA4WVBCPFBoL8NZ2qhMi3phwxKf3bNhbE3kiDFDqs9C5IXVZFk
	X8TX/eoGIZAkP4aKryuUne4A6tGGyVSR7Geq13wo/slpIb062zUzeihWP+K6dPY10LPPLvLFN/Z
	Fsfp+cRjHS0Iiar0tbfw2d/o6EYkI4rdNXRhx9JQtb70GXCiZrDuY39jO5YAziK2IczLaSFSR3i
	zxmTaMDzTsiCd92e5ef99C6i1Q4pKiqA+A==
X-Google-Smtp-Source: AGHT+IGG/EyO3/Feq2JSm8JdT5erJOZMKomWfyb/sedjsQC3Ckswibh7fkaSk4cSaoPLMI5okE7+yw==
X-Received: by 2002:a05:6902:1501:b0:e5d:c321:79b7 with SMTP id 3f1490d57ef6-e63f65f3041mr7172755276.8.1742244917062;
        Mon, 17 Mar 2025 13:55:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e5554f61sm2394535276.44.2025.03.17.13.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:55:16 -0700 (PDT)
From: Sargun Dhillon <sargun@sargun.me>
To: linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Sargun Dhillon <sargun@sargun.me>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] trace, RAS: Use __print_symbolic helper for entry severity for aer_events
Date: Mon, 17 Mar 2025 13:55:15 -0700
Message-ID: <20250317205516.599440-1-sargun@sargun.me>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chained ternary conditional operator in the perf event format for
ras:aer_event was causing a misrepresentation of the severity of the event
when used with "perf script". Rather than building our own hand-rolled
formatting, just use the __print_symbolic helper to format it.

The before / after are as follows (and also tested to make sure
uncorrectable events) still show up as uncorrectable.

aer-inject was used with the following AER event injection script:
AER
PCI_ID 00:05.0
COR_STATUS BAD_TLP
HEADER_LOG 0 1 2 3

dmesg (unchanged between runs):
pcieport 0000:00:05.0: aer_inject: Injecting errors 00000040/00000000 into device 0000:00:05.0
pcieport 0000:00:05.0: AER: Correctable error message received from 0000:00:05.0
pcieport 0000:00:05.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
pcieport 0000:00:05.0:   device [1b36:000c] error status/mask=00000040/0000e000
pcieport 0000:00:05.0:    [ 6] BadTLP

Before:
virtme-ng:/# perf script |cat
   irq/24-aerdrv     424 [002]   392.240255:          ras:aer_event: 0000:00:05.0 PCIe Bus Error: severity=Uncorrected, non-fatal, Bad TLP, TLP Header=Not available

After:
   irq/24-aerdrv     424 [002]    29.198383:          ras:aer_event: 0000:00:05.0 PCIe Bus Error: severity=Corrected, Bad TLP, TLP Header=Not available

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/ras/ras_event.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index e5f7ee0864e7..9312007096d7 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -327,9 +327,10 @@ TRACE_EVENT(aer_event,
 
 	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
 		__get_str(dev_name),
-		__entry->severity == AER_CORRECTABLE ? "Corrected" :
-			__entry->severity == AER_FATAL ?
-			"Fatal" : "Uncorrected, non-fatal",
+		__print_symbolic(__entry->severity,
+				 {AER_NONFATAL, "Uncorrected, non-fatal"},
+				 {AER_FATAL, "Fatal"},
+				 {AER_CORRECTABLE, "Corrected"}),
 		__entry->severity == AER_CORRECTABLE ?
 		__print_flags(__entry->status, "|", aer_correctable_errors) :
 		__print_flags(__entry->status, "|", aer_uncorrectable_errors),
-- 
2.47.1


