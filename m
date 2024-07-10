Return-Path: <linux-kernel+bounces-247429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2E592CF63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1451C2227B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154318FDCF;
	Wed, 10 Jul 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwXIKgjh"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBB18EFF9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607787; cv=none; b=ZUudOCXluB767vhcYIvASpfR0HOfk14qHoK1KryfQMMNx8Qii+yVs7KWYclzbowYPk9aeQ9rcsDNmOx5UH1RPzreFczhooVthE/i2GHcuIowTKzsS5GntGqxDiArMS6FQ2rg/GyVgph97ilIdSxxWOUzmRbQv5v2NZVylup2tHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607787; c=relaxed/simple;
	bh=9GJRHNLrHyHetG9QLvl+hM3eRSeIWSgSwKE96DTJrig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6o9eHIGK+wid6LizyjLjHVehJxgFHSJb4XLgcq3LG7SlAakY711/tQYloCL63hZavix6E+jYZn7fYzJkY6dlptxdmuLB3i/yiUJOccSU/DQf495sXTtrnZIpF6PbSunvouQvFk9xCf1vEuOZfqSiqjhSWZYSVXaaPMyukjFA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QwXIKgjh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77b550128dso772805166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607783; x=1721212583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AjlT5eFQ6h9gEvtReCv6ZkrzRkpXg8KUXrIWg1LtUo=;
        b=QwXIKgjhD6bDJw8VKDx1Lszk9zYCPpfUWHEGgpo7W+U4JwSNMRw7bo+Xk/dIFXuAKU
         XEpVLV3F5oTq69QgBk0kQtmKoecsQY4gfEWsbEKsHkMlrC7U1TVMbIjpK7BgFCFhheQS
         qmyvlxjvB2C1uoyxw/Rp38V3aWYFdgRvqZO7a5nrd+v5MJ03DgT/GQd/w7aapp0Iu2Ik
         9hs2OudEZa66R3cS1dIxa9o7tpUOE/xbI5bZ7gIPX3y4hmIbsF3A1qeMG4FQcrlnLqwb
         g/sWUTxNlJsOXQeCOZKI50V19idl15Mayy6ail9/0tB9YJEbXWxygDy/79e1xl+FPPSj
         9NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607783; x=1721212583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AjlT5eFQ6h9gEvtReCv6ZkrzRkpXg8KUXrIWg1LtUo=;
        b=OZMPRQVPE94vmAsB1QJnoZr7Gs303+CmSVQQLqJnaN4qdRRCkaoB6zWvxf/Ke3Yq+S
         zvKAj8Oo6iGL6VVs64eBT2RVQ6lwSJ+HfsZV16gq1dx3x6VYhoNyfSzAsL7QIC/wb7Ko
         UCqZ7XFqc3m+OAEVdXvkIX8cx0kG0J6ygvkxIyjHLuXysiRSKhwgSyyNzg38JRMbONrC
         7GXpoJBF7fAVoo+x2N4OkcqnKtK3CcHPpSvkHtt0UAGNUvGAUGCsDNaMV4Fe6lOfwYlv
         WIr+ljqbywpi4/H8xEDlo5KVUMc8QNF2writnrP31bmHn7PROF0g/uiWYr1oKxEtLDLk
         EFVw==
X-Forwarded-Encrypted: i=1; AJvYcCWd5t72Lww7eHvJAoTtaB2vNSSI70lSNs2QYtTGa7gWeF89tIZeQ48CAh2ASgZ7LpqyIVXlqEXWlLzpqXa9HI+2pW1BWTAJTKLnS9KK
X-Gm-Message-State: AOJu0Yw/qUZexWgfpwWcRSGy5V3Xwm15GWMv+5Nv+Yg8s+WXvMC2hlWn
	k71ZuWNti55xP1tbWEtsgURQ4KEh63gHMoUimV/I5vrZ5ytTFAKEi6k8PI1CFqw=
X-Google-Smtp-Source: AGHT+IEBYPb6oMofA153AVchD/c6t8lwHvb5LurkHVdmpGrU7RToq5FYqM5J4DT8aQ52uq/60Vf3SA==
X-Received: by 2002:a17:907:9711:b0:a77:b0a4:7d88 with SMTP id a640c23a62f3a-a780b689270mr567665866b.10.1720607783633;
        Wed, 10 Jul 2024 03:36:23 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:23 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:08 +0100
Subject: [PATCH 01/15] usb: typec: tcpci: fix a comment typo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-1-0ec1f41f4263@linaro.org>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
In-Reply-To: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

autonously -> autonomously

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 include/linux/usb/tcpci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 0ab39b6ea205..d27fe0c22a8b 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -190,7 +190,7 @@ struct tcpci;
  *		Optional; Callback to perform chip specific operations when FRS
  *		is sourcing vbus.
  * @auto_discharge_disconnect:
- *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
+ *		Optional; Enables TCPC to autonomously discharge vbus on disconnect.
  * @vbus_vsafe0v:
  *		optional; Set when TCPC can detect whether vbus is at VSAFE0V.
  * @set_partner_usb_comm_capable:

-- 
2.45.2.803.g4e1b14247a-goog


