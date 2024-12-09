Return-Path: <linux-kernel+bounces-437399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EF99E92C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14236161450
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1C0221D83;
	Mon,  9 Dec 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOs4K6WK"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE021D010
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745036; cv=none; b=oTq4w3dTT0bR1rFnOD1H53KBypNU9sE5n7rW3KnPbJRyRwkyexL08iAUReJ4AEs/5N42q9N1sR/0D78CQ3cyxNjiKqewlFeZwUz3G4hJ6Q8KFAqwle9FcDLTlG2XD7nJY3F7oaKPTqyGjIa9nxV5baad2hZKOOQLSNZzFcyqB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745036; c=relaxed/simple;
	bh=tRg2JG4yWbf9I5B7TpSxC1gfaa7C/jgTm+c+epd0rvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n1pgTgeR7r3TOL+CmWqMNQan1ajGflvcMn5g5ObziAzl2UFkaAQ8WA863Fd0JxmVMVV4fSIYPlkVmuHjAdDoqpE1L7CzkxPfa30QHfdmbE1+/KnhImBGQpV+0pzVBoGkyoeWFVVeG9eUrAoO5Tn+IIIbOsEdie/bpMo9ydkrd5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mOs4K6WK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso569856066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745033; x=1734349833; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ATPIw4OMF8nAB/PeB65ti7ZSBIJFQfds55Da014vBnU=;
        b=mOs4K6WKK77THOpTqSZkDQl/Lz7kzvtwMEefQqMLcsjL0jIS51b/9EvcepX6bRhNlB
         eC6StCJY+QPzu4LQ0kydcf4uWs927Cj5R0ZELooduYc5wrcB83OVgD2tXxPnJ9aQUw2i
         bYYz5aakyduHFT9CaWN9QM7YQs8V0hzjAkMGrp6EwHkYHMJ0nKHJq6h/fFKJCuFOPf8y
         uB+/hEHSnzzZd7ZRbiz2SCZOEryyI5iSLIJyB4Jq2SWCUfjXhncIgoWFBD2Bgiu3inj/
         XvMgPkDCcTZDLiheGa3TbIO2sj6bGmQBjHTIT3GOz08vfHiGIeSbIEvBC6XNwa+UpA9s
         m92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745033; x=1734349833;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATPIw4OMF8nAB/PeB65ti7ZSBIJFQfds55Da014vBnU=;
        b=TIkVsOIXW1ew+97YjzTw0TRXW/o0ZXRr2OL98TCztG+G+WOx4uNVJcAyVCpYBHMmWE
         6LIGnZH/4T2OP6w1lhIoPprcfaZ0AxfuMZl586tRw577ShT4aj8PlkeYC1hhLzBfsxil
         PCYWPMybFiScLswvD+Jb21ED46hsUAvcRTYAOZfiO2ABhyUDXTM+EICVaFEoZjbVd53+
         29uZjjHpPuNx1eNCl9IhypKaPNecBYEAWn4FAucdH9RwYZDEvts77HL6ltgjJE7vDxLB
         R0iF+Z6IUAnLKn9/VlvHrqtbN/iUW8fcMz5WHUpeEofA+u0aXbbUpV8t4R7/t2sq9BZJ
         7D/w==
X-Forwarded-Encrypted: i=1; AJvYcCUXU6UykTVP4P+LJCpxQ+u4XmzOKmButhYTCCCSXWKhTmhX57kQvfMdpKjwQbcAkK1xJ/eGy8TmsOTcFCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+Vd5wfcb9nZoDpo9niOJEcMaFztqVa6/9qNnjL4zgiMPagqp
	urDpB5Fvs9SSAEHNE27OpDH37M2JekBnIsegvF7vrXLMYFHvO/Zb8O6U10ZHuS8=
X-Gm-Gg: ASbGncveMoMwFipWeP95PWa3iPUU7Z+i7FkHdD7MCnFLYieb6kiJ/JJR9hzVrq/YKR8
	VpZRhIRP8a9EUe3D0/YZFJ71zUoBlgKOmFmSn4YSg0lNB8AvIY20GVBqO6nKF3iS0PBazxBOdw5
	wO1mWkTIcgScb1zQx8X5TQ5ZLZ3oDOco/+Qcimh1oxcetxyrtd/RWSNmiBrBOmjlwQos53azhgb
	5Dpe+KbRhm4L9US+pHQu9cCXRG5DBvHY3BvZlKdedchceFhBk8UkAgpLq3AhUWJcYF0T3HbsLeq
	BRCJRTDNmEFHJTK5g2xPTWmfkA1CHoc/LA==
X-Google-Smtp-Source: AGHT+IFO2lGH9JL+bzO4sp55jHNpx9YcfkNNqxmiJ5WgXHLLHG24iRvDXE2YESPMaen0HctcojXtcg==
X-Received: by 2002:a17:906:3cb1:b0:aa6:7df0:b17a with SMTP id a640c23a62f3a-aa67df0b300mr315812866b.34.1733745032872;
        Mon, 09 Dec 2024 03:50:32 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66d479963sm301854966b.106.2024.12.09.03.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:50:32 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 09 Dec 2024 11:49:53 +0000
Subject: [PATCH v2] usb: dwc3: gadget: fix writing NYET threshold
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241209-dwc3-nyet-fix-v2-1-02755683345b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGDZVmcC/3WMSw7CIBQAr9K8tc8ARVBX3sN0Ufm0LzFgoEGbh
 ruL3bucSWY2yC6Ry3DtNkiuUKYYGohDB2Yew+SQbGMQTEgumEL7Nj2G1S3o6YOanU9eWc0tk9C
 aV3JN77/70HimvMS07vvCf/bfqXDkKC79w2jplZT+9qQwpniMaYKh1voFKFSnUasAAAA=
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Before writing a new value to the register, the old value needs to be
masked out for the new value to be programmed as intended, because at
least in some cases the reset value of that field is 0xf (max value).

At the moment, the dwc3 core initialises the threshold to the maximum
value (0xf), with the option to override it via a DT. No upstream DTs
seem to override it, therefore this commit doesn't change behaviour for
any upstream platform. Nevertheless, the code should be fixed to have
the desired outcome.

Do so.

Fixes: 80caf7d21adc ("usb: dwc3: add lpm erratum support")
Cc: stable@vger.kernel.org # 5.10+ (needs adjustment for 5.4)
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- change mask definitions to be consistent with other masks (Thinh)
- udpate commit message to clarify that in some cases the reset value
  is != 0
- Link to v1: https://lore.kernel.org/r/20241206-dwc3-nyet-fix-v1-1-293bc74f644f@linaro.org
---
For stable-5.4, the if() test is slightly different, so a separate
patch will be sent for it for the patch to apply.
---
 drivers/usb/dwc3/core.h   | 1 +
 drivers/usb/dwc3/gadget.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ee73789326bc..f11570c8ffd0 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -464,6 +464,7 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
+#define DWC3_DCTL_NYET_THRES_MASK	(0xf << 20)
 #define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
 #define DWC3_DCTL_KEEP_CONNECT		BIT(19)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 83dc7304d701..31a654c6f15b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4195,8 +4195,10 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		WARN_ONCE(DWC3_VER_IS_PRIOR(DWC3, 240A) && dwc->has_lpm_erratum,
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
-		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A))
+		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A)) {
+			reg &= ~DWC3_DCTL_NYET_THRES_MASK;
 			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
+		}
 
 		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {

---
base-commit: c245a7a79602ccbee780c004c1e4abcda66aec32
change-id: 20241206-dwc3-nyet-fix-7085f6d71d04

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


