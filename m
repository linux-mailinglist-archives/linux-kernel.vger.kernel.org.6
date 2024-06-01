Return-Path: <linux-kernel+bounces-197824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 459298D6FAA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00476281C3C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D50150994;
	Sat,  1 Jun 2024 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VenUSeDy"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1127214F9D4;
	Sat,  1 Jun 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717243610; cv=none; b=W1Zb3fJPumcnJ2ma3d7M6VOZglnC3qmFSqqIVHrCpvHBGyawx6YmCSotDtUkZLzkwcPHy+diUqxYrt7FP/F7w73csGgt8aVNzlLS1N+HxueJczjSAbf3lEEY5jTZtkCAVJ6oq4RdHJNpAclJxLQ4Lt8jHyYyXB+qihz8W/XZnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717243610; c=relaxed/simple;
	bh=t+ryz2ON73Vff2ZY7l+uEuivqA1BpuWuGKPspY1/ue8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Bgpcjh8cT6x45/saIl6M6RMXViEPIEt0uY0gZBW2LU+t+5ZXv0nGEJ6aH+2l8vQ56BLVcfMQ5/uplSjnkWbUUtenTRxcVQ3l1d1znQNvpIcnaz4rks6su/YH/MbhAMxL+2cNlFX1R3GwNUKSRYOV+pgQd2vPd2oUxdHxAUMxJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VenUSeDy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7025cb09553so162377b3a.3;
        Sat, 01 Jun 2024 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717243608; x=1717848408; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu1fLGJneetG/YubvsVksmohTmywLlkgIhdNDim3AZo=;
        b=VenUSeDyKV+SFFYtII8IPTGQp15lavk96f9FKnrmq21/xrNaDX96KrDjfy/n1lu7QT
         fyqE194i7K8dGA3z5lnRdmjrW1rsHJsxHfpo10NPnP5SWBJJz8RrVPp8sXhchdxdKOWw
         OQZ2Az35AxvgipXK94SEdKyt14K8gh3nbP8iyakNeSrsvjsjaEL3f8i9kLJV/TZQbrcp
         fFfVcfsdKGcUSsBNYN3kVPvdSRAUH2dz/v56j4tHNn5vsSc8aSl8KxMhJ9zuBtcuCcw1
         /VZLrdkL7SvYb9mbBw7Ge4taDZZfvhIn2UyTlxy2hOP4z73IiRnefci9p7jZPOQLQXiN
         sMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717243608; x=1717848408;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu1fLGJneetG/YubvsVksmohTmywLlkgIhdNDim3AZo=;
        b=kmXBbpnym2/12SxlRCqZsV6+hB5SFL/Aun47NfWXhyxHJNvNBxjZuprH4QcBFwEtcm
         RmeKThdZR0ZH8EvpnAILeGU24eVCdUneBgiBIurD8am1t3mdPO+p9lUbTXfF6MEahwZr
         t6IWYOu8tg1DiCzy+Bw+bwv1R50fRYDAu/bbrWII1k8z5lbV98d/++ic6iF79kJ9h96o
         1b9zcHuJ/Oqi7mTkGLPwpHolcVvy2LvWG/K8UbvrFpjwo6X1na+f31sNqUlsGsQvUibj
         uiw5P8y2FfneVKuq7DB+m8rBVW5cOBzfvw/Nbfq46MF44Pj/KzSvwiNeRv7i9MAeSEDc
         ifKw==
X-Forwarded-Encrypted: i=1; AJvYcCUqDi/DEKxcVRsKk5V/lOj8RFqe9XdaTkHfDlQYYIg0DpaqLTw7pCotYA/UnJ/1Uuj9BiIPcGtbLlQUV2JKn8D4/6fgi/XGEmZxCWsZ
X-Gm-Message-State: AOJu0YxfhhJNNHMydP+YfDR6PvzB7MXVp0DUfePBmcw8OtUlf44BfR4P
	50kDegA87MAkKCckmediEC02ucucQAxd0dgBDStJZI/VCoc9ePvO
X-Google-Smtp-Source: AGHT+IHtBezDsvbVMqibRsEPH2sf0BlTtcK7wXNFnZnb+FlIqmROFSO4SL00hPaO6pCWkFuV4wai3g==
X-Received: by 2002:a05:6a20:3946:b0:1ad:6c36:ee82 with SMTP id adf61e73a8af0-1b26f0ec2f5mr5469399637.13.1717243608180;
        Sat, 01 Jun 2024 05:06:48 -0700 (PDT)
Received: from localhost ([219.144.1.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702425da465sm2798253b3a.73.2024.06.01.05.06.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2024 05:06:47 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joswang <joswang@lenovo.com>
Subject: [RFC 1/1] usb: host: xhci-plat: add enable XHCI-AVOID-BEI quirk by dts
Date: Sat,  1 Jun 2024 20:06:40 +0800
Message-Id: <20240601120640.73556-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: joswang <joswang@lenovo.com>

For Synopsys DWC31 2.00a and earlier versions, every isochronous
interval the BEI(Block Event Interrupt) flag is set for all except
the last Isoch TRB in a URB, host controller consumes the event
TRBs in the event ring, once the event ring is full, it will not
generate an interrupt and will stop all data transmission and command
execution.

To avoid the problem of event ring full, the XHCI-AVOID-BEI quirk is
introduced. Currently, the XHCI-AVOID-BEI quirk has been applied to all
Intel xHCI controllers, see commit '227a4fd801c8 ("USB: xhci: apply
XHCI-AVOID-BEI quirk to all Intel xHCI controllers")'.

For Linux system, each event ring consists of one or more event ring
segments and each segment is 4 KB that contains 256 TRBs. It seems that
the TRBs on the event ring are sufficient and the event ring will not be
full. In real application, if it does happen, event ring is full, host
controller no interrupt causes the driver to timeout.

However, applying XHCI-AVOID-BEI quirk will also bring power consumption
issues. We can consider the application scenarios of the product to decide
whether to enable it. Therefore, we add the enable XHCI-AVOID-BEI quirk
through dts configuration to make it more flexible.

Signed-off-by: joswang <joswang@lenovo.com>
---
 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d071b875308..e1071827d4b3 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -253,6 +253,9 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
 			xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+		if (device_property_read_bool(tmpdev, "quirk-avoid-bei"))
+			xhci->quirks |= XHCI_AVOID_BEI;
+
 		if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
 			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
 
-- 
2.17.1


