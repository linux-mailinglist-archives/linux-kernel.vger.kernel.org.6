Return-Path: <linux-kernel+bounces-285152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B59509E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183F91C22684
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2D1A0AE6;
	Tue, 13 Aug 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NexbOm3/"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D41A0709;
	Tue, 13 Aug 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565455; cv=none; b=CpNjcaT4ZywP0aeZ0hNwMMlKCmUpB9HSeoyS02xamhjwgnk47uCZIfG0HndF2M4wgCGpujenw8MW5Lw8QsQQNBjgx872a/ZiFTobccfEXDuyNvglTwgtGUp0AzLplPNQBb9/QiX87YClYC3XDoHDKH+/b90op+LpQl8rLBGDWxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565455; c=relaxed/simple;
	bh=v7ndlf8rGJH2AMQnD6DjRDLEm+mmv6/JnXt+FpXGG30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z1rI/7UWU/DOkMcml4QIc4GtoQModaBPqpD95CPiZ73m9bZGtQxyDiz4Zp9vUaAccU7F+urbZhJZ3rsMBi/+fpoJw/YT8aEe8ZZNhCIwBXxAeWrRpXOGSvnXBXUCrR8YdsqRdx7g1AwezoNE/W0hCAFGKaiT752Qc4aEcI72gfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NexbOm3/; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db2315d7ceso3345948b6e.1;
        Tue, 13 Aug 2024 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723565453; x=1724170253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1ItDKknhypftn5aMxxhUDKlZ20vPD5JiPeIzkuMvB0=;
        b=NexbOm3/nR9BNJPalId7hL7ZFIpKS1jcSYCeJfC3Vx+IIV+jJFGi7h8wQu1RtNK9v1
         c9TVD9fYRvE1xQALZiritZ4z8NS5n6uQHpoBkm/y9ArfKjasvv+6ISyyDuaQewP3Yv/P
         43o64fgDWySmVh07ORGpRKv8gd+WRTA/4IixcwsZulD9a3TUU66ELLy3Yxp+CGv7CaJC
         5IZoECrV6F/LcugFC2BAFNN9y+TWO3SJqvidESNLSEYmHOMoTL7cpRP8HwKjVBAxtEDr
         S6XAV9X/vT8hZXY9cqzWw7A2pKD8XRBtQZXd5siX+IgahoGxafJLYtmBVAnmj8TdWmOx
         BvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565453; x=1724170253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1ItDKknhypftn5aMxxhUDKlZ20vPD5JiPeIzkuMvB0=;
        b=U1YYIxMj/gGaE86XCSpj+AjPNT4S0fa6EHInFI9VSxkF8Ff/dUDFXDWwtQDkBZjTNy
         afRcFp2moWdzGcYmA8S4hMnvf8J1+qXjgSBCXo/ZlieyY/3Pe4axkcMn6IhQKkz/l3tK
         iJ/m6mWx/PPi5wa6SXkh5v1lUnxNfQSKDipI+fxLCCJBD4v6x5YFX2hY6za/UzTQtJ3Y
         1wkMuRdgDhWJeBA3XnKJclm2kne4tls3KeBjpCOHBZ8if4qYntz6WRcqr9V81TGh7Qx3
         ibmVK7iml2GCWR5Wvpq12qEHin2kblg3hfR5o2i1PTgnz5CjzA6Gi7iBqZ3trVj20Quk
         MRdw==
X-Forwarded-Encrypted: i=1; AJvYcCUl2SYpyB7rd7BAp9zREa5Z61iLAGPMKacnFj+5TB0qeyYwmB8FLksC1pFj24MAhpAG5TH3zu3rsafDaxMwHDqmJI8MLumUXoYO3zQl
X-Gm-Message-State: AOJu0YxaSCYqtbDNWMPv4H3tbFDf643dCwLjHtvxITGEYw+PG5Pqq/kU
	MYHlVJshgaw3ZykiEOw2fMR1GM8+Pkaqw+13DMgP9lKlX9SsX72BKcLyjGky
X-Google-Smtp-Source: AGHT+IE6h64K92eu87EKVNu/gVKkMsME55kMAwBdkjr/XSCYVrUyORzK94QcURJR3i67akT23qyV/Q==
X-Received: by 2002:a05:6808:16ac:b0:3db:15ed:2a21 with SMTP id 5614622812f47-3dd1ee075c7mr4761864b6e.16.1723565452797;
        Tue, 13 Aug 2024 09:10:52 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f91f2b9179sm969978e0c.5.2024.08.13.09.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:10:52 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tiwai@suse.com,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH v3] ALSA: usb-audio: Support Yamaha P-125 quirk entry
Date: Tue, 13 Aug 2024 11:10:53 -0500
Message-ID: <20240813161053.70256-1-soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds a USB quirk for the Yamaha P-125 digital piano.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
Hey! Thanks for taking the time to review my patch.

I had a little mistake in V2, I forgot to stage my new diff for
amending. Sorry

Attending your sorting by id suggestion, I've moved the P-125 to the
bottom.

Regards,
-Juan
---
 sound/usb/quirks-table.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f13a8d63a019..aaa6a515d0f8 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -273,6 +273,7 @@ YAMAHA_DEVICE(0x105a, NULL),
 YAMAHA_DEVICE(0x105b, NULL),
 YAMAHA_DEVICE(0x105c, NULL),
 YAMAHA_DEVICE(0x105d, NULL),
+YAMAHA_DEVICE(0x1718, "P-125"),
 {
 	USB_DEVICE(0x0499, 0x1503),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-- 
2.46.0


