Return-Path: <linux-kernel+bounces-226364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E01BD913D76
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA23B21E93
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C818411F;
	Sun, 23 Jun 2024 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWWKNpMy"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767D184116
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165429; cv=none; b=Pt4YnY5MYw4dDTRfCjnhROjy5GhmkDQ9O8le172WgjdZLsm+ZbivL/r0EnFZQ0QINxWq9+z5VgpxSUbOCZaXD6Uo4jnowhbVWOUlQH8FvfMwra31eOP/td8k+vPPPhO6GIcXApYhwU7ph6cD6RHKzWSW8roGtqUzP+DANpfx6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165429; c=relaxed/simple;
	bh=MFDsON5eJ5q6Dsx0C7oF5pE6X2tzjdY7tJL46c9ssVU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmuiXAQQtHmaC4/7j5uk3e4jftT5n7nqlx4tzLx7gAibPMCZs8lIULh/wIkEkhqwbLNlAlIfQdIoYYMFDJ1g1C54xVoy+Tm2fu2EFzKQqBrF0GZG9zAXJ3SLGX2lCCDX7uRHv7urc2DOYIgkit8JMr6GAoPtqFPKpUAw0mlCwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWWKNpMy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d0ea30e87so676774a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165427; x=1719770227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z+UaUsS6E3j3bsDShHg2M/UApPqSHw5Z20YwkeFVoac=;
        b=DWWKNpMyJ0N+//lmGlv65GbFNiOu3B/Z+UusW1DkGMyMzTyl+rh2eeol2BjZ/HstUm
         E656qceR7905CkCfOaRIRkvnsBRFUog01CR1nc7ja4y5uNu8zT5FLa60HPMijeEhqVZ7
         GKutmwWz6gFgY97DQkQNZPkqeFwRHRKRl57su0Kf+kn0VaiD24Je+W+DHMwNciYoNN4i
         C2huknXlhRGxjhQH9kxTcomX3IiJtIBmfuSUdSN43Rtr71LE5nf4kUmYXpYEfImL3u4R
         V8oRL9as68dLgQdaEG5ID9loplcejNfojK62M9oO8yIE62Ae/oQqCIXxeYw1fiYRy/tO
         An+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165427; x=1719770227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+UaUsS6E3j3bsDShHg2M/UApPqSHw5Z20YwkeFVoac=;
        b=MMIjG70xOLCxEk3w9tAZXc2oiCmMXPXgiLdWNq6t7JBegZrqyLvp6HkHXWWySfPzD/
         Gecqn+9CMypwNW5+Pi6OFwsExQ65kGTfcSK1I57c8UoqggdIo0UE4sN4W9UhOVOyfo4Y
         w32aKpu+o9/OxEiEQiaz+u7gm5EgDlkFDxxaUfUtwAvuaEXClO0oeXurrSZws2fhnbjh
         iMb1Cew0jCrONO38EAOK4JBkhJITGL/eB1N4Trtpd72NZghKnT0XR4QOBGYGAJd0M6W8
         cUIkHO5/JNWrc6+fkemOXSYEDxUtsm8eMIFstv24vDV6/9GeWhwwD2c96D53MFeaIJeo
         iK6g==
X-Forwarded-Encrypted: i=1; AJvYcCUVIZwxc2mvKwmedtnD8EisWPiXRGn2S21CB6PMtimRv5kzn6YrPpUg3rI0j8CSGpXoTz8UBe8hKW7jYkgh73LknpjDbzEti51gDNNn
X-Gm-Message-State: AOJu0Yw61NgmjC9tqlCCYhAQOgtrZFWHEVyTclJASs8hFt56J4BZx7fP
	AuPU7WEx41rjFVWQBuB8udxmHF6d59MQneZIIz8p46QhDKrI9NsD
X-Google-Smtp-Source: AGHT+IHTJwIOZ3cZJ0c7JvsG128bWDCwoJiKqvdWDwjeUApoTv1m1gcC/Dfy95oCe7cal8NwVyfwlw==
X-Received: by 2002:a17:906:258a:b0:a72:51d8:bf30 with SMTP id a640c23a62f3a-a7251d8c3d0mr59135466b.0.1719165426439;
        Sun, 23 Jun 2024 10:57:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe779bc80sm202386566b.174.2024.06.23.10.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:57:06 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:57:04 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] staging: rtl8723bs: Remove unused declarations start
 with sd_hal_bus_init
Message-ID: <37d2c677e5ef57a9aeb6857d7857d4512b8e3954.1719155208.git.philipp.g.hortmann@gmail.com>
References: <cover.1719155208.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719155208.git.philipp.g.hortmann@gmail.com>

Remove unused function declarations.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/sdio_hal.h    | 4 ----
 drivers/staging/rtl8723bs/include/sdio_osintf.h | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/sdio_hal.h b/drivers/staging/rtl8723bs/include/sdio_hal.h
index 6fae19dd0cbd..024acf9b530d 100644
--- a/drivers/staging/rtl8723bs/include/sdio_hal.h
+++ b/drivers/staging/rtl8723bs/include/sdio_hal.h
@@ -7,10 +7,6 @@
 #ifndef __SDIO_HAL_H__
 #define __SDIO_HAL_H__
 
-
-extern u8 sd_hal_bus_init(struct adapter *padapter);
-extern u8 sd_hal_bus_deinit(struct adapter *padapter);
-
 u8 sd_int_isr(struct adapter *padapter);
 void sd_int_dpc(struct adapter *padapter);
 void rtw_set_hal_ops(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/sdio_osintf.h b/drivers/staging/rtl8723bs/include/sdio_osintf.h
index 146b44f95e29..198cf3889a27 100644
--- a/drivers/staging/rtl8723bs/include/sdio_osintf.h
+++ b/drivers/staging/rtl8723bs/include/sdio_osintf.h
@@ -7,10 +7,4 @@
 #ifndef __SDIO_OSINTF_H__
 #define __SDIO_OSINTF_H__
 
-
-
-u8 sd_hal_bus_init(struct adapter *padapter);
-u8 sd_hal_bus_deinit(struct adapter *padapter);
-void sd_c2h_hdl(struct adapter *padapter);
-
 #endif
-- 
2.45.2


