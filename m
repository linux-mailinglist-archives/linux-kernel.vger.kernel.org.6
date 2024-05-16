Return-Path: <linux-kernel+bounces-181132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D988C77D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CA11C223E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F00C1474DA;
	Thu, 16 May 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY0mcLKS"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9491474AA;
	Thu, 16 May 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866823; cv=none; b=V6wYGcaGM1mbhxGXrXwEwyNbvWSyrKzV3yCW13aWG/orkSsNW3hkPM3DKlnY/TKJydEvi/nYzwMB7i5riODWIks5k+EXov8K63QJGrvgCqMVrzp+2fhOLuoEJkbxxxguNFTtjrbpSuAL/3K5cBgfqjA+teaN0HXt93bk2es0nqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866823; c=relaxed/simple;
	bh=dTWh5B+LLDBWV9vtFY55/B1V8asERfAAion1Rkp/acY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB0SFmqcq/P28WNSsITQx+eaYYaAut55H/6ixjwUUpUhuP+oGSVFuVRnRKjsEkJgk6RPxj0Hy6w/znvWApW7s6GmxtCBqy/C5FJ/VcMaoyN9lsvQqJRKP4IlVkjVmMxTItRrqMlPWqqtGFHSCaL2yRObY/3nSHDZ3owJOAd6H7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY0mcLKS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b4aa87e01aso171828a91.3;
        Thu, 16 May 2024 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715866822; x=1716471622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL50Hp7iL/aRLAtSxMHrUM7s8ttuqkWfRiWw7eMXuF4=;
        b=hY0mcLKSxj/FDPnAcPdfxDbLrxchuo8bgioapSRw4RWqs06YVzUJOpIzobLBv0RoVN
         R3Ia/DAFcXUAGFEw/6gGl6DiQihvIEsu7FxGBAG0oy86kFj24fgvoZhiBcx32dB15oIo
         AWkvtEZ2Ehywpcl7jkeSHH997JBkS7VBU/q6LaKgphmZU9fM/JScAnXuD6ucLD4+Sp3k
         57063Mxs1TOvygD9LhEkh81jIXKFwgh/vV8rYk1Vpw5xyJlgxMe5XlE+W7jGdJDnHjG3
         ognqs97J+QZMmeqCDNt281AsbVNe1oYo9FTDB023xdlBXljW6jwQfbY10kFVo7i1cg9O
         b0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715866822; x=1716471622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AL50Hp7iL/aRLAtSxMHrUM7s8ttuqkWfRiWw7eMXuF4=;
        b=txCVUByP7+zSRwPwQKGlB1EesOPmcr0ZLr3PGR31NOcGZ5KTi4q9EiyqfAb+F7hKDL
         mvgRKO0ii38DDuJrNbranwqtBQzByfzFmusr69VgoMJolBp8WOFB5oBIXGLO9QSUBM2h
         tszXoI0aHF0kHx4n0+ieSne9g8r/fhRBiOG3CzpTFZgsvYBt1I0LC0i2wPzAf9EIa+yQ
         oLFwmEyyPF72B3uF1zkHrrNtzMb7ce5P5yXSRd5WbzUCNDc/7W+/xrINSKIyEMwF11wE
         GiKtZ1ZMjq7aGOOa7WoOYquysyLmzWOarcDulwGH8+DCIPfBpJ7OSb9DDEARmwENzP21
         vubg==
X-Forwarded-Encrypted: i=1; AJvYcCU2QxYoO+R25Wyfg/E4luSHdN40Y3Y/8jcjoCtPoyWfG5WViWkd2+2eW/jihXhnfTs9Hsh1JB5d9atBVnTTE0kcMChvtc2238tjNh2nVVpqIA1pJLSHM5R2NjfQKHHO4lpcaFXGzNlosd8=
X-Gm-Message-State: AOJu0YwXYygJxSDXAduotRqV4uTD2tTNMcYGigcDiGPGe0ly23nDWmQf
	XuO5yVuTXesWUoxMq7H5hOKVIIkB08rp87LiXHsiNnk6dr/5iz7EyZtpHNqgk5X2Uw==
X-Google-Smtp-Source: AGHT+IHro9w2hhTbEYma2Do1XWHkEiexNaff/iRzBuPLTV8K60hJ6+S1StvoamhoHiu3RghrrIFCag==
X-Received: by 2002:a17:90a:9084:b0:2b6:c650:fb53 with SMTP id 98e67ed59e1d1-2b6cd0e7c20mr14758763a91.45.1715866821543;
        Thu, 16 May 2024 06:40:21 -0700 (PDT)
Received: from thought.. ([181.170.161.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67116601fsm13712518a91.23.2024.05.16.06.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:40:20 -0700 (PDT)
From: Manuel Barrio Linares <mbarriolinares@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	Manuel Barrio Linares <mbarriolinares@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jeremie Knuesel <knuesel@gmail.com>,
	Lukasz Tyl <ltyl@hem-e.com>,
	Christos Skevis <xristos.thes@gmail.com>,
	Jussi Laako <jussi@sonarnerd.net>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix for sampling rates support for Mbox3
Date: Thu, 16 May 2024 10:40:02 -0300
Message-ID: <20240516134003.39104-1-mbarriolinares@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <87ikze486g.wl-tiwai@suse.de>
References: <87ikze486g.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed wrong use of usb_sndctrlpipe to usb_rcvctrlpipe

Signed-off-by: Manuel Barrio Linares <mbarriolinares@gmail.com>
---
 sound/usb/quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2f961f0e9378..58156fbca02c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1740,7 +1740,7 @@ static void mbox3_set_format_quirk(struct snd_usb_substream *subs,
 	u32 current_rate;
 
 	// Get current rate from card and check if changing it is needed
-	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+	snd_usb_ctl_msg(subs->dev, usb_rcvctrlpipe(subs->dev, 0),
 					0x01, 0x21 | USB_DIR_IN, 0x0100, 0x8101, &buff4, 4);
 	current_rate = le32_to_cpu(buff4);
 	dev_dbg(&subs->dev->dev,
@@ -1765,7 +1765,7 @@ static void mbox3_set_format_quirk(struct snd_usb_substream *subs,
 
 	// Check whether the change was successful
 	buff4 = 0;
-	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+	snd_usb_ctl_msg(subs->dev, usb_rcvctrlpipe(subs->dev, 0),
 					0x01, 0x21 | USB_DIR_IN, 0x0100, 0x8101, &buff4, 4);
 	if (new_rate != le32_to_cpu(buff4))
 		dev_warn(&subs->dev->dev, "MBOX3: Couldn't set the sample rate");
-- 
2.45.1


