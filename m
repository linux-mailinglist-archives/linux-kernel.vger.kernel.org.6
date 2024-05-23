Return-Path: <linux-kernel+bounces-188113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1728C8CDDA1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486DD1C2120F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206E128834;
	Thu, 23 May 2024 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TttDrzA4"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70222628D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506563; cv=none; b=HeUCeiP2UOn1VYn4w6krx1DmEIOEIfK23scwskqhvvfKxx8snqCO7sZNcmyxrKyD2MF4hvFNAVWbV5P5FbRGTtr9oUhENNgXEg4Xd7HyA/YuDzEG19RnA2ixUbdL7H4y0Rwyb/5ZPRa15NowpvuS7ZkMBRwT1M4IFk7zi+QzUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506563; c=relaxed/simple;
	bh=rgPr4Ngu722SRDj2ZtjbrxVxv2puo2dZm2D+9CkatPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hfmi2CX4v3wMtvsMozmjs7AkVIFmCPO9HL7nKWJPbkCxcb8ZI427uashG7w4KCyMdClCYbDyvr//n12JmyKVWp+nMwh7A6nW4AHM9J/vAiPbNTSUNBiblQmpVgMrmHOiGj7Z/jSsx5uoLy3kC1ylRGNvYPffnHeBEnJidVyJR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TttDrzA4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f8f34cb0beso175694b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716506561; x=1717111361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfP9vIEmS390P3O4iAtZjeM8HWFzEOcH0/2SUf3/Hok=;
        b=TttDrzA4qnK/uWrFshTTPAVszxLlkHAJ5wbe4kgITRdvWR/nkEXrJsLEcEQw7On3/t
         wDD8A+GalWqEFGeEcJVTZtMiTEZQKvxPxrbN0Tu5i1XuHGZyQ4gkUC9GYb2sQxyPcbVx
         WwtM5wwMViUyTnhfzAuyhYOLcKjj6EKviLaUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716506561; x=1717111361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfP9vIEmS390P3O4iAtZjeM8HWFzEOcH0/2SUf3/Hok=;
        b=uubOpA4b0LRyCxAZ0ATiMLeFvIDKQ60mwMUYiT8MLLwbcHHLaabEJxLs1yv+s3ZqR9
         Sk/JLCQ8w0ibTrK2hN7ciFiY5Or4HgGZFPE+0IvTNs5wplGZTeqY0EEX+cwcvHlB+UeH
         2YqcLruKIjhq5/Zi0f9Se4qW0WQNvzUhI/VB3/4Wth5G/svVP7N5O0r5G+QDkt0cmQIS
         4Fb2KgBIjXqtdNOm5xN7yaqNkfiRHMzB8Q7ijwtOnqrQDNF6EODB3OW36WsNbJz0AXJu
         npi41A1A9PL/dzdGHKShqGOuTLaDqGGmgAbhhTCNQHAatF2Grl6xk9s4OL4gcnzq8NTU
         IejA==
X-Forwarded-Encrypted: i=1; AJvYcCWnqDgWPey8eZAUGXRtpuXJDj7Y/OokMl8YgllChG7gEN9v+W851TJtJ4GF3GPXT7m7ebx348YzIAj0tF1XYe+4/qNQTU2nptyw3zrH
X-Gm-Message-State: AOJu0Yyt0M0Pg2FX65YlO3qi8QX5Vv2fPxRmibSeqWF8udSHo3nabgzT
	7/CNNk9IMr4kSbO1i/WHRmtxdVRIKRQNQO1sJLwB3wRFcZ1L4w4Rd/PzY75i6w==
X-Google-Smtp-Source: AGHT+IGv12M53lM+GUULtAWysbxmBRhEDbBtm/AXwGQlH56IEyIRCa/lNDP8GHgZxm6j/t23nijr+Q==
X-Received: by 2002:a17:902:d58c:b0:1f2:fcc0:66f with SMTP id d9443c01a7336-1f448248a0emr11751435ad.31.1716506560961;
        Thu, 23 May 2024 16:22:40 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:b835:ba86:8e6d:41c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c797938sm1279545ad.64.2024.05.23.16.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:22:40 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	linux-arm-msm@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Douglas Anderson <dianders@chromium.org>,
	Guanbing Huang <albanhuang@tencent.com>,
	James Clark <james.clark@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 0/2] serial: Fix problems when serial transfer is happening at suspend time
Date: Thu, 23 May 2024 16:22:11 -0700
Message-ID: <20240523232216.3148367-1-dianders@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a set of two patches that fix problems related to suspending
while a serial transfer is going on. The two patches are independent
from each other and can land in any order. The only thing tying them
together is that I used the same test to reproduce both of them.
Specifically, I could reproduce my problemes by logging in via an
agetty on the debug serial port (which was _not_ used for kernel
console) and running:
  cat /var/log/messages
..and then (via an SSH session) forcing a few suspend/resume cycles.

The first patch solves a problem that is probably more major. It was
introduced recently and has even shown up in stable trees.
Suspend/resume testing in ChromeOS test labs are hitting the problem
fixed by this patch. The fix hasn't been tested in labs, but when I
reproduced the problem locally I could see that the fix worked. IMO it
should land ASAP.

The second patch fixes an ancient problem that I only found because I
was trying to reproduce the first problem. Given how long it's been
around it's probably not urgent but it would be nice to get fixed.


Douglas Anderson (2):
  serial: port: Don't block system suspend even if bytes are left to
    xmit
  serial: qcom-geni: Fix qcom_geni_serial_stop_tx_fifo() while xfer

 drivers/tty/serial/qcom_geni_serial.c | 45 +++++++++++++++++++++++++--
 drivers/tty/serial/serial_port.c      | 10 ++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


