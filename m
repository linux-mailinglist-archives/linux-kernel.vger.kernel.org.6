Return-Path: <linux-kernel+bounces-307303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5F964B85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039B72828C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310C41B5318;
	Thu, 29 Aug 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="znJzsXMR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA21B3F1F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948367; cv=none; b=FQn3GLsarz+86WLPaTiHssDeHppmm2Jww5Af0bM7r3Ns4FGhUtnHtqf/51TUE+P+yg2zIydi2SNSaXxd53sB/W1GCVB1mPbLEKQLzxdUQ+8uMl5cTBcInSq5Q+C9z2+0c0dqfzsZ68U/xOU2S6SMbupIpW87STB5rTcBED6G+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948367; c=relaxed/simple;
	bh=+uOlpQ0J2VrbeZAocdSGFU6CEoIf8QiCmdwUWB6M/Eg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=saaubWzOpwbAvxx1H5CAn+MHvvqOfins9GFIIQ5ZcZwXdE0EVhujJNLBdPRHeVlvJl5/FXBHnZ+Yvl1RwG7GeqiAgSvrn5HWT6MB6VDfN6qs1tLwZUyqh/eAESeOrOjexCq8wibEtoppq+SdSjQXb86BDKdia6vI9M1fq3QhNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=znJzsXMR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42817d3ecfeso45e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724948364; x=1725553164; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JIx/HdAS9L+v6kcy5uXIn5+SpwFH/cXtqq0x+Bbtmtg=;
        b=znJzsXMR3M8xgVD3XVZbgRJ8uO2PZVcpKt6Ez4LFCSwuEkUuOO0CDYjyspDVahe66F
         S+sMx6NnI1djwy+4js5YvRz745x/Ky1qiuCt93o7zgI4ylLHgmOtZqDww+mUlTKcfcTO
         TTaztCHWedD7w0Pz5zexu2zubkNnLCxI7oZ7FDLpDYK3fIZ23802wASa4J5ducXfZSvO
         x4/d6gSG/wBe6Uc/6EhXYn4gb/0ZuKxhHd1mJM9CR1WT/XDtAaBJQhw0CctNPPJPPSdn
         ynU3gs3uGq8MicT9WiD0z7E/QBMYRMGR+/ObwX1xfBfCbCO/Rl5GttRK/AmbV3QTgZ3k
         GBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948364; x=1725553164;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIx/HdAS9L+v6kcy5uXIn5+SpwFH/cXtqq0x+Bbtmtg=;
        b=fPkHv8PPQFyRAOqdfhkaqTYSPtcsGtYddo+wRjGbcQ+91lqPMwlFCOkdNMEko5BdXv
         +P0lkzS/59eURvUCpfd505S20Yr+7GuB/oyzZcW+B9SKQ4JAv6wrNDIs5FcvgGXALWMu
         ya98+bwJYnA1TQ5YyXU8gJem+siwAiMop2GfLIf1tUA36jR4NIQLvYi+zKPFRepp0KDu
         zE1lRmxQBgMAVabT0I8b5k2LtRncHS/pdu2Dq639ADKB9bPhMo0cZMlVgWVCoKbgIhg2
         SXlUp0/3r8hjEY321iHUQTHLTSj0tE2l/ZKSO/EAwzD34k6j64fHbmHCXNtUZvkhV4as
         IkpA==
X-Gm-Message-State: AOJu0YymIJKGUdP4l0rZ6DaauLnyNg2/6KS+1s+C5M4FXUqHeQgObaVh
	oKVI1SAi70PD5tKLWTprH7yiRE0YYh2MX8Jsa1nTpcP9GNozifnP4Ej0gsyF7zVOC61q30u8t+E
	2r5iyiagdi0UKER7fFO4tWlW8LxYNQ+2BfvkBkhdwm/1O/nuBpYY=
X-Gm-Gg: AV9I1ZTqfessbESmCaWbEAcVOvZKPpvc0y+cTyqkBuIDJWdUXpcwZv4Wuey73XMzxrm
	oUqo3bxH4Mzac5eKrRYI+pWyYzX0i8ohNhiPvbRxDJcRzBTOeC1ADKohJxnE=
X-Google-Smtp-Source: AGHT+IHDKtMRQFGOa36AubqoYkJGrBLNd6MjbrqiIZkJ8DTptIPnLPcEmiVNPdaVtXKqLOYNkeS3QZujgRcS4ueimtQ=
X-Received: by 2002:a05:600c:3ace:b0:427:f1a9:cb12 with SMTP id
 5b1f17b1804b1-42bba08b177mr7195e9.0.1724948362737; Thu, 29 Aug 2024 09:19:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joshua Pius <joshuapius@google.com>
Date: Thu, 29 Aug 2024 12:18:43 -0400
Message-ID: <CAFs7P=jk=wfo0nbHzqd1NrGX3NKpOezD4-u=nAMqzq7mq4Lidg@mail.gmail.com>
Subject: [PATCH] ALSA: Add logitech Audio profile quirk
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Specify shortnames for the following Logitech Devices: Rally bar, Rally
bar mini, MeetUp and Huddle.

BUG=b:362311751
TEST=aplay -l
TEST=Observe codecs listed
UPSTREAM-TASK=b:362958780
Signed-off-by: Joshua Pius <joshuapius@google.com>

---
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 2d6c2f1394c18..6bfbd22152819 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -375,7 +375,12 @@ static const struct usb_audio_device_name
usb_audio_names[] = {
        /* Creative/Toshiba Multimedia Center SB-0500 */
        DEVICE_NAME(0x041e, 0x3048, "Toshiba", "SB-0500"),

+       /* Logitech Audio Devices */
        DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9000"),
+       DEVICE_NAME(0x046d, 0x0898, "Logitech, Inc.", "Logi-RB-Audio"),
+       DEVICE_NAME(0x046d, 0x08d2, "Logitech, Inc.", "Logi-RBM-Audio"),
+       DEVICE_NAME(0x046d, 0x0867, "Logitech, Inc.", "Logi-MeetUp"),
+       DEVICE_NAME(0x046d, 0x087c, "Logitech, Inc.", "Logi-Huddle"),

        /* ASUS ROG Zenith II: this machine has also two devices, one for
         * the front headphone and another for the rest
---

