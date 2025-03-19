Return-Path: <linux-kernel+bounces-568817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B5EA69AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25653BE7E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF32165E2;
	Wed, 19 Mar 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="ioK3aD+z"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E220F091
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419115; cv=none; b=mK717eobAcu46AHO6Rn544L0mBG2qnu8GE9h+bx5aXx6gndN9nEO/AOB/CVNSN4PAQV3BFrhI66BptF4L0+cBHT1k9PTtAbI9dUC26cB4Yf+LdGYpDxqhF8iT/DdMSUXnHkJUNiIy22WTINiYGnmdzu+ijVL6Pp4KAtCsR2/rM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419115; c=relaxed/simple;
	bh=7map+7Tpk3j/bj3oCa6b0PQPna+rcnIff0ifIXyzCoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6aqwOyeSeT3PqlXPMeFpCx4svVOTmW+tKq0Bx84gEsBQOzRqCo+pjJJUOPTkF4TWCohP2P7l5771BsB2/21NGFQ1o+2Z6G7JpFcovcyuqeXVc/E7TSIrE0FT0NbqGeBGzoDNqbR9M/nwbYgqIOMJRU2pwKjP8upxVt2MO/vme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=ioK3aD+z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225b5448519so602625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742419111; x=1743023911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy+GctLsDyQ0oVhOpFAWpkq9XxnqpLm8qDFikh+eFy0=;
        b=ioK3aD+zZpfhzNpn4BrPI1WumWzxA4F/XfDU720ZpwJTMYpNZpvD7wupiJlr/KUtwu
         7VXotUAjVjcNnVscIuKoxf3ihDMk4S60Z3MmRVXavcFtvPxRiiqEdDNUpo/1lbW7/Kkn
         nIZNIOD/oOOq2zJlrlpulu8fhIJaDhZaVKpHKybDIoZI070X9DYowPpODU/6xkfhjcmP
         Q0Sus+1sETh25Hldc2BfKEJBgxcrMAml9cwTanjx1FlCW3TLB5br+ZZBpiBvkgfDzm31
         44mJ/d7iWb6Xk0WcsIbA30R4yfL8LoKnwQIP3tis4F5LCGSPlb6CKJbAXMeBW+led/Ut
         Z0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419111; x=1743023911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy+GctLsDyQ0oVhOpFAWpkq9XxnqpLm8qDFikh+eFy0=;
        b=dSaIL+kjbrCDXpuBeLYnTKWcySXFMJqocQPa/ROAopyyBuZaLrVdqghDbtO4gmnD/r
         d78BoXsQBDI+lEiqkAfr+YS+IKDbXI0IwvXAsZfhwer8yA4Gu0KzafwwqYbWRaMc37FX
         m8aF55ApXx7pwRy+ndyyHAZLprWlgLfTB+DhA+dSlMNWiMP8ad3p5R8Ttxq9Wz8RVwGc
         wgrceqNSQIqxMSKIYylnPgyzdg5w3Dw71xqJfofYWII5HnrjWdfKcguwCMK/dqChomHa
         DcI6W2GvWA/ZT51rExmMXFy0+iTZjZv+kAyVAw/LM9qine9eeX95XztioGD5ijOLKYWe
         OmHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFuHwiDotnwJSQPTGgFEJ4+wZX6J93p2JMm7/rziEg/fWP+1jWhlg8AwG6QvKjzBhS6bxFm3qdEOvRcMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkQ5ApHUBoTAMzSKIB2lgb6L+4uo4XLFJe6s3s59kNX/cWMwL
	1u6qu/4CC6tbPrgsz2DmQjkeRKCSPvdj6Jq+woSERkZ8YsfuY5iWaea+h5uqgPkH3BH2g26isEo
	=
X-Gm-Gg: ASbGncuyoFOrcSO8aaV/X0ttzQ6wzSrXxsJGjZC+Mbd7ikq+PUWF9t962xyK0jms7JW
	Hinzflev1iIyCPmj+JpdkeZtPAuS0gZwVmWm9izlAthJxPHWrzXKt9P2QPNxSasXMJQZPN0te5W
	MLyUfRWnaOrYP67Nrw3F8Iju+E/oX6tKystOvlfPxivPF6EXP7MAzcD5cXANN1K3EL5VDDpoddU
	v+49EMRm0fGdIuLgVOTvz8a4K7HLahSpn4z/Fgukxejchj8GJN8ONPh7M39u3itmzxD3AqzSVw/
	+qDtLH2Hevl3fjnzN+JSx8V963z9BH3wpJfzyZPJmYX6reHxlibJukJxF7Qw4ROmxxWDsfUVm6r
	tOmI/5cAZLg==
X-Google-Smtp-Source: AGHT+IEgZACoc9KZbsX8lAIO+v71R7QWG2HIokl9bbScq2qWU/e/MJKCzdIIMaSKrKVr1dlmoCoACA==
X-Received: by 2002:a17:902:f70c:b0:216:53fa:634f with SMTP id d9443c01a7336-22649cb5b29mr79844995ad.48.1742419111487;
        Wed, 19 Mar 2025 14:18:31 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f2dsm119624345ad.140.2025.03.19.14.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:18:31 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 1/2] staging: gpib: Correct CamelCase for BUS constants
Date: Wed, 19 Mar 2025 21:18:26 +0000
Message-ID: <20250319211827.9854-2-matchstick@neverthere.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319211827.9854-1-matchstick@neverthere.org>
References: <20250319211827.9854-1-matchstick@neverthere.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style and remove duplicate enums.

Reported by checkpatch

CHECK: Avoid CamelCase

Signed-off-by: Michael Rubin <matchstick@neverthere.org>
---
 .../staging/gpib/agilent_82357a/agilent_82357a.c | 16 ++++++++--------
 drivers/staging/gpib/cb7210/cb7210.c             | 16 ++++++++--------
 drivers/staging/gpib/common/iblib.c              |  4 ++--
 drivers/staging/gpib/eastwood/fluke_gpib.c       | 16 ++++++++--------
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c         | 16 ++++++++--------
 drivers/staging/gpib/gpio/gpib_bitbang.c         | 16 ++++++++--------
 drivers/staging/gpib/hp_82341/hp_82341.c         |  2 +-
 drivers/staging/gpib/ines/ines_gpib.c            | 16 ++++++++--------
 .../staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c   | 16 ++++++++--------
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c        | 16 ++++++++--------
 drivers/staging/gpib/tms9914/tms9914.c           | 16 ++++++++--------
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c      | 16 ++++++++--------
 drivers/staging/gpib/uapi/gpib_user.h            | 11 -----------
 13 files changed, 83 insertions(+), 94 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 7ebebe00dc48..7d660e558fbe 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -988,21 +988,21 @@ static int agilent_82357a_line_status(const gpib_board_t *board)
 		return retval;
 	}
 	if (bus_status.value & BSR_REN_BIT)
-		status |= BusREN;
+		status |= BUS_REN;
 	if (bus_status.value & BSR_IFC_BIT)
-		status |= BusIFC;
+		status |= BUS_IFC;
 	if (bus_status.value & BSR_SRQ_BIT)
-		status |= BusSRQ;
+		status |= BUS_SRQ;
 	if (bus_status.value & BSR_EOI_BIT)
-		status |= BusEOI;
+		status |= BUS_EOI;
 	if (bus_status.value & BSR_NRFD_BIT)
-		status |= BusNRFD;
+		status |= BUS_NRFD;
 	if (bus_status.value & BSR_NDAC_BIT)
-		status |= BusNDAC;
+		status |= BUS_NDAC;
 	if (bus_status.value & BSR_DAV_BIT)
-		status |= BusDAV;
+		status |= BUS_DAV;
 	if (bus_status.value & BSR_ATN_BIT)
-		status |= BusATN;
+		status |= BUS_ATN;
 	return status;
 }
 
diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 19dfd8b4a8e7..ba02dce62dd9 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -388,21 +388,21 @@ static int cb7210_line_status(const gpib_board_t *board)
 	bsr_bits = cb7210_paged_read_byte(cb_priv, BUS_STATUS, BUS_STATUS_PAGE);
 
 	if ((bsr_bits & BSR_REN_BIT) == 0)
-		status |= BusREN;
+		status |= BUS_REN;
 	if ((bsr_bits & BSR_IFC_BIT) == 0)
-		status |= BusIFC;
+		status |= BUS_IFC;
 	if ((bsr_bits & BSR_SRQ_BIT) == 0)
-		status |= BusSRQ;
+		status |= BUS_SRQ;
 	if ((bsr_bits & BSR_EOI_BIT) == 0)
-		status |= BusEOI;
+		status |= BUS_EOI;
 	if ((bsr_bits & BSR_NRFD_BIT) == 0)
-		status |= BusNRFD;
+		status |= BUS_NRFD;
 	if ((bsr_bits & BSR_NDAC_BIT) == 0)
-		status |= BusNDAC;
+		status |= BUS_NDAC;
 	if ((bsr_bits & BSR_DAV_BIT) == 0)
-		status |= BusDAV;
+		status |= BUS_DAV;
 	if ((bsr_bits & BSR_ATN_BIT) == 0)
-		status |= BusATN;
+		status |= BUS_ATN;
 
 	return status;
 }
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index fd2874c2fff4..1caa57b41596 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -77,7 +77,7 @@ static int check_for_command_acceptors(gpib_board_t *board)
 		return lines;
 
 	if ((lines & ValidNRFD) && (lines & ValidNDAC))	{
-		if ((lines & BusNRFD) == 0 && (lines & BusNDAC) == 0)
+		if ((lines & BUS_NRFD) == 0 && (lines & BUS_NDAC) == 0)
 			return -ENOTCONN;
 	}
 
@@ -521,7 +521,7 @@ int general_ibstatus(gpib_board_t *board, const gpib_status_queue_t *device,
 		/* get real SRQI status if we can */
 		if (iblines(board, &line_status) == 0) {
 			if ((line_status & ValidSRQ)) {
-				if ((line_status & BusSRQ))
+				if ((line_status & BUS_SRQ))
 					status |= SRQI;
 				else
 					status &= ~SRQI;
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index 731732bd8301..4e04acfdb48d 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -204,21 +204,21 @@ static int fluke_line_status(const gpib_board_t *board)
 	bsr_bits = fluke_paged_read_byte(e_priv, BUS_STATUS, BUS_STATUS_PAGE);
 
 	if ((bsr_bits & BSR_REN_BIT) == 0)
-		status |= BusREN;
+		status |= BUS_REN;
 	if ((bsr_bits & BSR_IFC_BIT) == 0)
-		status |= BusIFC;
+		status |= BUS_IFC;
 	if ((bsr_bits & BSR_SRQ_BIT) == 0)
-		status |= BusSRQ;
+		status |= BUS_SRQ;
 	if ((bsr_bits & BSR_EOI_BIT) == 0)
-		status |= BusEOI;
+		status |= BUS_EOI;
 	if ((bsr_bits & BSR_NRFD_BIT) == 0)
-		status |= BusNRFD;
+		status |= BUS_NRFD;
 	if ((bsr_bits & BSR_NDAC_BIT) == 0)
-		status |= BusNDAC;
+		status |= BUS_NDAC;
 	if ((bsr_bits & BSR_DAV_BIT) == 0)
-		status |= BusDAV;
+		status |= BUS_DAV;
 	if ((bsr_bits & BSR_ATN_BIT) == 0)
-		status |= BusATN;
+		status |= BUS_ATN;
 
 	return status;
 }
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index d62c83368518..8fbfa7e285af 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -240,21 +240,21 @@ static int fmh_gpib_line_status(const gpib_board_t *board)
 	bsr_bits = read_byte(nec_priv, BUS_STATUS_REG);
 
 	if ((bsr_bits & BSR_REN_BIT) == 0)
-		status |= BusREN;
+		status |= BUS_REN;
 	if ((bsr_bits & BSR_IFC_BIT) == 0)
-		status |= BusIFC;
+		status |= BUS_IFC;
 	if ((bsr_bits & BSR_SRQ_BIT) == 0)
-		status |= BusSRQ;
+		status |= BUS_SRQ;
 	if ((bsr_bits & BSR_EOI_BIT) == 0)
-		status |= BusEOI;
+		status |= BUS_EOI;
 	if ((bsr_bits & BSR_NRFD_BIT) == 0)
-		status |= BusNRFD;
+		status |= BUS_NRFD;
 	if ((bsr_bits & BSR_NDAC_BIT) == 0)
-		status |= BusNDAC;
+		status |= BUS_NDAC;
 	if ((bsr_bits & BSR_DAV_BIT) == 0)
-		status |= BusDAV;
+		status |= BUS_DAV;
 	if ((bsr_bits & BSR_ATN_BIT) == 0)
-		status |= BusATN;
+		status |= BUS_ATN;
 
 	return status;
 }
diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 2012db188f58..004bf0e9bc88 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -1034,21 +1034,21 @@ static int bb_line_status(const gpib_board_t *board)
 	int line_status = ValidALL;
 
 	if (gpiod_get_value(REN) == 0)
-		line_status |= BusREN;
+		line_status |= BUS_REN;
 	if (gpiod_get_value(IFC) == 0)
-		line_status |= BusIFC;
+		line_status |= BUS_IFC;
 	if (gpiod_get_value(NDAC) == 0)
-		line_status |= BusNDAC;
+		line_status |= BUS_NDAC;
 	if (gpiod_get_value(NRFD) == 0)
-		line_status |= BusNRFD;
+		line_status |= BUS_NRFD;
 	if (gpiod_get_value(DAV) == 0)
-		line_status |= BusDAV;
+		line_status |= BUS_DAV;
 	if (gpiod_get_value(EOI) == 0)
-		line_status |= BusEOI;
+		line_status |= BUS_EOI;
 	if (gpiod_get_value(_ATN) == 0)
-		line_status |= BusATN;
+		line_status |= BUS_ATN;
 	if (gpiod_get_value(SRQ) == 0)
-		line_status |= BusSRQ;
+		line_status |= BUS_SRQ;
 
 	dbg_printk(2, "status lines: %4x\n", line_status);
 
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index 91fbaf953bcd..b5d79ae519e7 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -158,7 +158,7 @@ static int restart_write_fifo(gpib_board_t *board, struct hp_82341_priv *hp_priv
 
 		//restart doesn't work if data holdoff is in effect
 		status = tms9914_line_status(board, tms_priv);
-		if ((status & BusNRFD) == 0) {
+		if ((status & BUS_NRFD) == 0) {
 			outb(RESTART_STREAM_BIT, hp_priv->iobase[0] + STREAM_STATUS_REG);
 			return 0;
 		}
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 56da6cd91188..c5c34845fc38 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -36,21 +36,21 @@ int ines_line_status(const gpib_board_t *board)
 	bcm_bits = ines_inb(ines_priv, BUS_CONTROL_MONITOR);
 
 	if (bcm_bits & BCM_REN_BIT)
-		status |= BusREN;
+		status |= BUS_REN;
 	if (bcm_bits & BCM_IFC_BIT)
-		status |= BusIFC;
+		status |= BUS_IFC;
 	if (bcm_bits & BCM_SRQ_BIT)
-		status |= BusSRQ;
+		status |= BUS_SRQ;
 	if (bcm_bits & BCM_EOI_BIT)
-		status |= BusEOI;
+		status |= BUS_EOI;
 	if (bcm_bits & BCM_NRFD_BIT)
-		status |= BusNRFD;
+		status |= BUS_NRFD;
 	if (bcm_bits & BCM_NDAC_BIT)
-		status |= BusNDAC;
+		status |= BUS_NDAC;
 	if (bcm_bits & BCM_DAV_BIT)
-		status |= BusDAV;
+		status |= BUS_DAV;
 	if (bcm_bits & BCM_ATN_BIT)
-		status |= BusATN;
+		status |= BUS_ATN;
 
 	return status;
 }
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 50faa0c17617..2775dc83305e 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -694,21 +694,21 @@ static int usb_gpib_line_status(const gpib_board_t *board)
 	}
 
 	if ((buffer & 0x01) == 0)
-		line_status |= BusREN;
+		line_status |= BUS_REN;
 	if ((buffer & 0x02) == 0)
-		line_status |= BusIFC;
+		line_status |= BUS_IFC;
 	if ((buffer & 0x04) == 0)
-		line_status |= BusNDAC;
+		line_status |= BUS_NDAC;
 	if ((buffer & 0x08) == 0)
-		line_status |= BusNRFD;
+		line_status |= BUS_NRFD;
 	if ((buffer & 0x10) == 0)
-		line_status |= BusDAV;
+		line_status |= BUS_DAV;
 	if ((buffer & 0x20) == 0)
-		line_status |= BusEOI;
+		line_status |= BUS_EOI;
 	if ((buffer & 0x40) == 0)
-		line_status |= BusATN;
+		line_status |= BUS_ATN;
 	if ((buffer & 0x80) == 0)
-		line_status |= BusSRQ;
+		line_status |= BUS_SRQ;
 
 	DIA_LOG(1, "done with %x %x\n", buffer, line_status);
 
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 61b15b19e134..7243d361f173 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -1511,21 +1511,21 @@ static int ni_usb_line_status(const gpib_board_t *board)
 	ni_usb_parse_register_read_block(in_data, &bsr_bits, 1);
 	kfree(in_data);
 	if (bsr_bits & BCSR_REN_BIT)
-		line_status |= BusREN;
+		line_status |= BUS_REN;
 	if (bsr_bits & BCSR_IFC_BIT)
-		line_status |= BusIFC;
+		line_status |= BUS_IFC;
 	if (bsr_bits & BCSR_SRQ_BIT)
-		line_status |= BusSRQ;
+		line_status |= BUS_SRQ;
 	if (bsr_bits & BCSR_EOI_BIT)
-		line_status |= BusEOI;
+		line_status |= BUS_EOI;
 	if (bsr_bits & BCSR_NRFD_BIT)
-		line_status |= BusNRFD;
+		line_status |= BUS_NRFD;
 	if (bsr_bits & BCSR_NDAC_BIT)
-		line_status |= BusNDAC;
+		line_status |= BUS_NDAC;
 	if (bsr_bits & BCSR_DAV_BIT)
-		line_status |= BusDAV;
+		line_status |= BUS_DAV;
 	if (bsr_bits & BCSR_ATN_BIT)
-		line_status |= BusATN;
+		line_status |= BUS_ATN;
 	return line_status;
 }
 
diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
index 1f2bb163cfb5..17adeccf448b 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -396,21 +396,21 @@ int tms9914_line_status(const gpib_board_t *board, struct tms9914_priv *priv)
 	bsr_bits = read_byte(priv, BSR);
 
 	if (bsr_bits & BSR_REN_BIT)
-		status |= BusREN;
+		status |= BUS_REN;
 	if (bsr_bits & BSR_IFC_BIT)
-		status |= BusIFC;
+		status |= BUS_IFC;
 	if (bsr_bits & BSR_SRQ_BIT)
-		status |= BusSRQ;
+		status |= BUS_SRQ;
 	if (bsr_bits & BSR_EOI_BIT)
-		status |= BusEOI;
+		status |= BUS_EOI;
 	if (bsr_bits & BSR_NRFD_BIT)
-		status |= BusNRFD;
+		status |= BUS_NRFD;
 	if (bsr_bits & BSR_NDAC_BIT)
-		status |= BusNDAC;
+		status |= BUS_NDAC;
 	if (bsr_bits & BSR_DAV_BIT)
-		status |= BusDAV;
+		status |= BUS_DAV;
 	if (bsr_bits & BSR_ATN_BIT)
-		status |= BusATN;
+		status |= BUS_ATN;
 
 	return status;
 }
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index d32420dee5e5..76fd9422809c 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -159,21 +159,21 @@ static int tnt4882_line_status(const gpib_board_t *board)
 	bcsr_bits = tnt_readb(tnt_priv, BSR);
 
 	if (bcsr_bits & BCSR_REN_BIT)
-		status |= BusREN;
+		status |= BUS_REN;
 	if (bcsr_bits & BCSR_IFC_BIT)
-		status |= BusIFC;
+		status |= BUS_IFC;
 	if (bcsr_bits & BCSR_SRQ_BIT)
-		status |= BusSRQ;
+		status |= BUS_SRQ;
 	if (bcsr_bits & BCSR_EOI_BIT)
-		status |= BusEOI;
+		status |= BUS_EOI;
 	if (bcsr_bits & BCSR_NRFD_BIT)
-		status |= BusNRFD;
+		status |= BUS_NRFD;
 	if (bcsr_bits & BCSR_NDAC_BIT)
-		status |= BusNDAC;
+		status |= BUS_NDAC;
 	if (bcsr_bits & BCSR_DAV_BIT)
-		status |= BusDAV;
+		status |= BUS_DAV;
 	if (bcsr_bits & BCSR_ATN_BIT)
-		status |= BusATN;
+		status |= BUS_ATN;
 
 	return status;
 }
diff --git a/drivers/staging/gpib/uapi/gpib_user.h b/drivers/staging/gpib/uapi/gpib_user.h
index 0896a55a758f..2d742540630a 100644
--- a/drivers/staging/gpib/uapi/gpib_user.h
+++ b/drivers/staging/gpib/uapi/gpib_user.h
@@ -115,17 +115,6 @@ enum bus_control_line {
 	ValidATN = 0x40,
 	ValidEOI = 0x80,
 	ValidALL = 0xff,
-	BusDAV = 0x0100,		/* DAV	line status bit */
-	BusNDAC = 0x0200,		/* NDAC line status bit */
-	BusNRFD = 0x0400,		/* NRFD line status bit */
-	BusIFC = 0x0800,		/* IFC	line status bit */
-	BusREN = 0x1000,		/* REN	line status bit */
-	BusSRQ = 0x2000,		/* SRQ	line status bit */
-	BusATN = 0x4000,		/* ATN	line status bit */
-	BusEOI = 0x8000		/* EOI	line status bit */
-};
-
-enum old_bus_control_line {
 	BUS_DAV = 0x0100,		/* DAV	line status bit */
 	BUS_NDAC = 0x0200,		/* NDAC line status bit */
 	BUS_NRFD = 0x0400,		/* NRFD line status bit */
-- 
2.43.0


