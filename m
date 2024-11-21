Return-Path: <linux-kernel+bounces-417584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1A79D5635
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B901E1F23D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1531DE2DC;
	Thu, 21 Nov 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtvW6Izj"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A91DDC1F;
	Thu, 21 Nov 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732232357; cv=none; b=ZD5jasOzttCb6P+0F6Ym8XIachKzoipJJah0v9LWzaCezMwjyPTLS4z4hwDEoI4V7r20oB+jKGwDxAevcZ9KJdCy5GctYR8HouMR1YnpGYdMTb9EyCGdtVORBuIKWN5ruhkzeu2SwcaMzStsT7JnPlqWX9HkQImSfxC1MHqJoTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732232357; c=relaxed/simple;
	bh=+2Yrn/8yYSm+MI4xHHHhX+Ptj7pQFNmlJUxh10IN7pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKy55kei7v+kYc+0FdyMXFaq4DY+4Lb+rSvv3zEOt+DKcACr5UyjpcB9VVxx5buyPWDelf7yRD2rhatLPhn/1avVbIirLGo5y3USaW14lJv4kTxfO0UVh6c4Dv1kPBW6uaHvGpf8KNyyFwfzL7xI74xfIJsGF95eglV2O6x2KAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtvW6Izj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea45dac86eso1294815a91.3;
        Thu, 21 Nov 2024 15:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732232355; x=1732837155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXNz6VaAsiDKIdp12hbKlxVaiSjzEADc7nTccQXvD7M=;
        b=gtvW6IzjPH80mxHsvfpEP4PFO6RtQ4fV4MYds+q4abA7yKtbLCgGCKnAzqcA05dQfi
         2kKojkBFqmoBvaaipQEac+tx1EcvMYZBcITuim1j2cBoO0EYwFh2RZrfOhZWegkayPlD
         kYmkJh/MwMCkBrf/LbN/c3vZIjbSlZnYymU0/cPQByinvfJmFHcK7GDUK6aO9iAUOk5Q
         Yjr8Uizkqkvi/V4vlXwuGvVGWg0vFRDDnPS6JD/bqGG0ZXWWxbWcvqP342VrcFvfRM41
         C0xC3AXjgGz9+JH42519mU9T9y2AO3t1ZT0X/p2oMGDuinpbV3L8Oz/EfH6k9+VIFicv
         pexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732232355; x=1732837155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXNz6VaAsiDKIdp12hbKlxVaiSjzEADc7nTccQXvD7M=;
        b=ZTCdz9wyA+9wqqflNvPJ+hXK6HWej5ZrEMWnJ7Suhs9+CSUHa+aSE5qlYKsE3eUJlk
         NOHhycDjRdqbwxhSFSDDVbwYKzrqZVSz5P2e/7JrQEwsHkbssmOe8XNFaYE2lZd3yO9T
         g9/GY8obsDsLV9t4nl+NcoKZpxUTruSIpdG8UaWkYQERHKzbMWJ2P5S4J2NMORrqNnMe
         atJ6qWyGLq1xA3Vn3nLDtdqFbfThNs5U91nu0uI/pJoY8BAxxAwAFG2R4vBKW1kWyW7y
         U4GgAw7hHzSYksqeb5ylEfv8paoR+9VCNpAeWf5WH6zqQnNd38DGeBGJzGedSSkL8fY6
         iugw==
X-Forwarded-Encrypted: i=1; AJvYcCUmdO/nTGQIyUP8PAxpRqHhV4hWvqCzH4c7QJWhHfTGnoqtotFCx0WgWW0Sax+pGxIalfNhrnyjLck=@vger.kernel.org, AJvYcCVvyCN66G4sdpFT+orBOY7QF12l7+qF5clMpdZ5DUDfO+Mu871Jl5RjhhzTfePwW30s6+p/dxPX/0bwNN8H@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6fyL1cd3vbB3MKuOXrgVw93OEbnHlcR6eFhoitMW//GBCO36
	G8psPrhgSL2jyGXDNLX+wwADfT13v+lHe+y+DweOow/syHj/oxE=
X-Gm-Gg: ASbGncv48PO5v+h3K9Z0W7aKjyPX78ja8Bmvspp8XBGLb+l7Hm+gu8jgOmvAUh2JGY6
	87uKHLDzD3ECSH1Pnxc4VZz0k1/9gLI4FSzfxOmo5SIJRW9WlZm0XB80J6y7ulCPtX1f2Pb/3ep
	Wdnqxd9aY+/srOf+6Qk8XlOXQ3/7Pl2ymVYKcwQ+i9r3xMkP6iWyRmtu2M90nnIxa6KpSASuOc/
	i2N0buWfCofybj79POiBgPx8PPyunvyvAI20qpAzFPGoNWmiZ0puBviI5QItMLZhXc1UwgG0/U=
X-Google-Smtp-Source: AGHT+IGMR4iacChFlqlSy5PAljOdPhc8zN6VYc6/2UbVF3EjtfrEQasXm7WaRAbZkYWFy8AT0ox/ow==
X-Received: by 2002:a17:90b:4d06:b0:2ea:8e42:c48 with SMTP id 98e67ed59e1d1-2eb0e02b0fbmr819464a91.3.1732232354576;
        Thu, 21 Nov 2024 15:39:14 -0800 (PST)
Received: from localhost.localdomain ([117.250.157.213])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e1921sm280512a12.25.2024.11.21.15.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 15:39:14 -0800 (PST)
From: Vyshnav Ajith <puthen1977@gmail.com>
To: gregkh@linuxfoundation.org,
	corbet@lwn.net
Cc: linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vyshnav Ajith <puthen1977@gmail.com>
Subject: Fixing Grammatical Error
Date: Fri, 22 Nov 2024 05:08:29 +0530
Message-ID: <20241121233829.14779-1-puthen1977@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'Worst case' being singular needs 'is' instead of 'are'.

Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
---
 Documentation/usb/dwc3.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/usb/dwc3.rst b/Documentation/usb/dwc3.rst
index f94a7ba16573..12989d126a8a 100644
--- a/Documentation/usb/dwc3.rst
+++ b/Documentation/usb/dwc3.rst
@@ -20,7 +20,7 @@ Please pick something while reading :)
     to the device. If MSI provides per-endpoint interrupt this dummy
     interrupt chip can be replaced with "real" interrupts.
   - interrupts are requested / allocated on usb_ep_enable() and removed on
-    usb_ep_disable(). Worst case are 32 interrupts, the lower limit is two
+    usb_ep_disable(). The worst case is 32 interrupts, the lower limit is two
     for ep0/1.
   - dwc3_send_gadget_ep_cmd() will sleep in wait_for_completion_timeout()
     until the command completes.
-- 
2.43.0


