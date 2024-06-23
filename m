Return-Path: <linux-kernel+bounces-226368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130B913D7A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27099280D96
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE51184119;
	Sun, 23 Jun 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdoICCQt"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D21849C0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165464; cv=none; b=dno9gpM7jXNQYiAwqapn5yLjQddOhybWbtIiRhEU03KVMmt6PXexe1wzbfL0TpXsOZuRFXXYfU+lIHOVv/JXsvA/moorDRyatYGUw860Iij3dVQa4deVFKoevmV0fmrwXXKdOO/p6GLzcSGFWtXlNh+3a7OTk1a3BQDZz1fytjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165464; c=relaxed/simple;
	bh=vA0bWNYIrquhBSWHBJDOxyLqstyb/6YeHv6to/EnNWc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg7gbZDBkqlX9XE3yVhEcDd2ykzJRYfNpLrQs7HNdIXUz0++cutj/yK6gwYNKprkjTC+zex5PWbfXlj8esug0bYKp81BY7YR3bS/c9f+Fe8vA1WQqtJZj6mzZFNr4ohYf1uHmeMwMLDbsbiWostyyAvWHP7vxkjQUIWuZCuFgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdoICCQt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-366e28cde12so41038f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165461; x=1719770261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzYJslVL4+EQwJPzZpfQIy+dCA6PC/XlLcrxh7veTJU=;
        b=XdoICCQt1hFgRpO3ubbx2+YLaGw6tmfmN546Bsn+AF2KGZrLRpOFC8JRHt6ruEvpEv
         oanj/UK/YyFJEaa4Lvp7sl6T7Fu6RG60myUREl3pUtiaaQMMtlmQi4jmSmHWz1cWJhyL
         ra3EHx6K2v4MuWAQQVXb0ji8GjSrDaVYRyJRFgqHtvO+gCkPV1P0WAqrmfW2gFuyXZLi
         qDZeVqLOl2LUGVd5YoHJWhi0zUXK4+Ycm+PbX4/99g3I7PLuptZfqa62Dff2akta8v43
         ctUzpT9wwk0RNAukRnSyzNt63x3uktu6h4yJF3DZqqrk79S6H8KUnZLchwrjVV/ny+MK
         Hy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165461; x=1719770261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzYJslVL4+EQwJPzZpfQIy+dCA6PC/XlLcrxh7veTJU=;
        b=lL/MXu8tfJu0ZPmiYL0AYbbSXIECTCnkiqDTo3OaoHwylAp6/lYKpwwzR9Dibmw1k2
         QjgTX+xwtEzPrUU9mSFN/TatUHr/qaxgbs4Y7cL3F7mbNJ0z22zyyXuOfqHX3cvCUSkE
         nYb/hU8xD6kpU59ei2AEjJYYEbBofVCroEc/dw9IBTK/5fDFK4zhYftkRh/5Pa2RGHI1
         UUwDeBxk6FlX72bwbuLAg8tlQJe8ImwrNhoywcVWj2hJq1Eg29jYNNPQ8WVxxRZqMrld
         oEuaWzm72VJRHfv6CPW+66ZNO7rk7Cl78pslo25K334+F6LtLaP1OnvMcnuqptFzcJaj
         h2AA==
X-Forwarded-Encrypted: i=1; AJvYcCXh2gV4g/W3ceUH8p1RLTuSlnaw/PlxB18+YLECRl00eXA2DAm2yMf4Qr4FGXkpiRWhLEasBH01MXvNm7HSR5exz77ZXXQDT8NRtecL
X-Gm-Message-State: AOJu0YxBlN6kV+wGZiJYHVMv0WUIXVNDP6hDKmxMj8xiAh8IwlXyZe0N
	/jk10GP8PZ/BgpiGZ9RlqFFFGN0CyjVrsWulpdbEDJI1LJg8/Hql
X-Google-Smtp-Source: AGHT+IHYxGgEn2/HHiaL9a+L/jhCM4tGEr//7l/Je0sbqdub0y3j1iVnsY2bicPRoxDhQ+shZ70I4A==
X-Received: by 2002:a05:6000:1f85:b0:365:da7f:6c13 with SMTP id ffacd0b85a97d-366e2a099f0mr3087367f8f.2.1719165461023;
        Sun, 23 Jun 2024 10:57:41 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a71ddbd3479sm172316366b.189.2024.06.23.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:57:40 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:57:39 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] staging: rtl8723bs: Remove unused macros in rtw_xmit.h
Message-ID: <3d0c5e727098f7eb3ceb5d3ebe0562515dd19bcd.1719155208.git.philipp.g.hortmann@gmail.com>
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

Remove unused macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_xmit.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
index 676ead0372fa..a3b4310caddf 100644
--- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
@@ -35,7 +35,6 @@
 #define BCN_QUEUE_INX		4
 #define MGT_QUEUE_INX		5
 #define HIGH_QUEUE_INX		6
-#define TXCMD_QUEUE_INX	7
 
 #define HW_QUEUE_ENTRY	8
 
@@ -192,16 +191,7 @@ struct pkt_attrib {
 
 #define NULL_FRAMETAG		(0x0)
 #define DATA_FRAMETAG		0x01
-#define L2_FRAMETAG		0x02
 #define MGNT_FRAMETAG		0x03
-#define AMSDU_FRAMETAG	0x04
-
-#define EII_FRAMETAG		0x05
-#define IEEE8023_FRAMETAG  0x06
-
-#define MP_FRAMETAG		0x07
-
-#define TXAGG_FRAMETAG	0x08
 
 enum {
 	XMITBUF_DATA = 0,
-- 
2.45.2


