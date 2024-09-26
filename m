Return-Path: <linux-kernel+bounces-339979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EB4986CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842222839F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3418D64D;
	Thu, 26 Sep 2024 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPDVaXvX"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7C18784C;
	Thu, 26 Sep 2024 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333373; cv=none; b=D8fROLNiOqu7Fh5bLIfWAixPAK0LQC7PwGYAmz3ucElf9rUatzYaPxqgyrYCdawmN0tEXts7mpMC4pxn8Ao3s1BjSFKnQNdXjeNExNx2QFuJKHGFAtd1jQNyZwjG0HUwgVoG9r3ngUwbWVlVT0eAnSzWB69AJPVhRwnjoqY6n/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333373; c=relaxed/simple;
	bh=2EjaJgg2Kh6R0gxzcs4CAsn7s9mMpxxHU4F/8eBHY6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f7UeGvsyqNK3+R95fxIBPxCIyNfuQmlVfizsnRv72CYwDYCgrPyOUqli4ZtMa8TpbJeqhJ4c2YYvNKsEN1c9kijbrXWTZO0mV9D+7DZPlxN++vz2r40RYGTVocrm+6o4Vs4l+Tkq5RkpMDePb00LrsoZ4Vk9zIMPXPSrT8ztPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPDVaXvX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso883313e87.2;
        Wed, 25 Sep 2024 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727333370; x=1727938170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zgnMrzwynFba1wRhjzmjE2vkGb+mgPFEdtMaT9NIW6g=;
        b=HPDVaXvX/7T65pYAIxQboWcgJino+ytesBwHPSBhvjC4lrbdrB0zMhPeaWd0md5+OQ
         nNsIAMoU9q0FGZxo/jSJob451Kjiiqbsx4YpQzBub3XF8x6RPwJzZw5SpfkSJj2ztyc+
         jO4mrF/sG8alW3avlEMOa6WFTBaQWfSkYTbF6dCHF8pldESrjzvchoeY77N0Sc9yjnvA
         UPsks8kApAqLJ/sNVvPs7agE2P9WDW7nMK3Q6FwfKV90YsD2fJVRBwCWi56VhsLkRCtm
         di3O6w5q+Yhx28zMNU/2Ns0AEFgKegH0iz/80GZpU5UbnhMAY2AkbmSTW7wiLIBimcbj
         LBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333370; x=1727938170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgnMrzwynFba1wRhjzmjE2vkGb+mgPFEdtMaT9NIW6g=;
        b=i/69Qdt5cqzkIhJGwxafv2Px152ioF+4Qo6UmTwWVRzoQs1xxSSmA/MrR6oOyVtfsK
         7EiDCsVVmeI0367GoH4CmRbhAio/BQHdDYIS/H+0iyJ0kAOJSEvimjOoGUw9Z5tTovh5
         RhK82fecNSxmNQUSo1ohSu7CCToPrmod6ZCplIFOAdbui71Wqr5Ak2XJyG98feDd7LGM
         PVFRZUb6L0jyB0xo+qz4UZRifB7k/xZ/I/4ywWsbzWlnS/z01wmSYbvxfNqSmu5ARTZQ
         pzZesFe8XDWckgqZKysdbrgPh0Ud5OdGAm1Iqe047JWh6LiRD7n+r40st4uANyMbuYJM
         rP3g==
X-Forwarded-Encrypted: i=1; AJvYcCVxrGz/Qnmjn2wtA3MUotqff1BlB80SIBQcv5qiRC51Tk8EZZtJnLibQzJ7KF/nBlZEnbWNJDqdIjO9iyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycTfWHot8LbS66bObQrHkN9jtIWlgVS5anXycsum+TpEKOvY9d
	FNUXIUE68fGsNdY8N3Z7v/s6O7M+uVMB4/AtJe+9xFKqnCfpo2qpaeCfiyDJcKo=
X-Google-Smtp-Source: AGHT+IGINfmXa3fp+xYx2jyAcimsm+PlqF9Wd1CFn0DOqYt9akL49L/Iq8d75aTSQFCui0F5um3MQQ==
X-Received: by 2002:a05:6512:687:b0:536:a695:9414 with SMTP id 2adb3069b0e04-5387048aa60mr4984849e87.6.1727333369711;
        Wed, 25 Sep 2024 23:49:29 -0700 (PDT)
Received: from hubert.. (89-72-184-222.dynamic.chello.pl. [89.72.184.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93931340b5sm309691266b.190.2024.09.25.23.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:49:29 -0700 (PDT)
From: hbuczynski <hubert.buczynski94@gmail.com>
To: balbi@kernel.org,
	gregkh@linuxfoundation.org,
	quic_prashk@quicinc.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"hubert.buczynski" <Hubert.Buczynski.ext@feig.de>
Subject: [PATCH] usb: gadget: u_serial: fix null-ptr-deref in gs_start_io
Date: Thu, 26 Sep 2024 08:49:10 +0200
Message-Id: <20240926064910.17429-1-hubert.buczynski94@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "hubert.buczynski" <Hubert.Buczynski.ext@feig.de>

The commit "5a444bea usb: gadget: u_serial: Set start_delayed during
suspend" caused invocation of the gs_start_io in the gserial_resume.
The gs_start_io doesn't check the ptr of the 'port.tty'. As a result, the
tty_wakeup function is passed on to the NULL ptr causing kernel panic.

There is a deterministic scenario leading to the kernel error:
1. Set the device in peripheral OTG mode.
2. Attach the USB cable to the host.
3. Do not take any action on the host side.
4. Send data to the host, for example:
$ echo "hello\n" > /dev/ttyGS0
5. Disconnect the USB cable.
6. Connect the USB cable and the kernel panic should be visible.

Fragment of the kernel panic log message:

Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: P O 5.15.166 #88
Hardware name: STM32 hDevice Tree Support)
PC is at tty_wakeup+0x8/0x5c
LR is at gs_start_io+0x90/0xdc
pc : [<c0623f74>]    lr : [<c083eeac>]    psr: 60010193
sp : c1001da0  ip : c32e6944  fp : 80000000
r10: c32e6934  r9 : c32e6928  r8 : c32e68ec
r7 : c32e68e0  r6 : c2be6c40  r5 : 00000000  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 60010193  r0 : 00000000
Flags: nZC»  IRQs off  FIQs on  Mode SVC_32  ISA ARM Segment none
Control: 10c5387d  Table: c3ac406a  DAC: 00000051
Register r0 information: NULL pointer
Register r1 information: non-paged memory
Register r2 information: NULL pointer
Register r3 information: NULL pointer
Register r4 information: NULL pointer
Register r5 information: NULL pointer
[<c0623f74>] (tty_wakeup) from [<c083eeac>] (gs_start_io+0x90/0xdc)
[<c083eeac>] (gs_start_io) from [<c083f0c0>](gserial_resume+0x6c/0xd4)
[<c083f0c0>] (gserial_resume) from [<c082a35c>] (composite_resume+0x70/0x10c)
[<c082a35c>] (composite_resume) from [<c082d668>] (configfs_composite_resume+0x54/0x64)
[<c082d668>] (configfs_composite_resume) from [<c07c26c4>] (dwc2_handle_wakeup_detected_intr+0x15c/0x2e8)
[<c07c26c4>] (dwc2_handle_wakeup_detected_intr) from [<c07c2c74>] (dwc2_handle_common_intr+0x424/0x630)
[<c07c2c74>] (dwc2_handle_common_intr) from [<c0190168>] (__handle_irq_event_percpu+0x50/0x250)
[<c0190168>] (__handle_irq_event_percpu) from [<c0190440>] (handle_irq_event+0x58/0xc4)
[<c0190440>] (handle_irq_event) from [<c0194f9c>] (handle_fasteoi_irq+0x9c/0x204)
[<c0194f9c>] (handle_fasteoi_irq) from [<c018fb2c>] (handle_domain_irq+0x58/0x74)
[<c018fb2c>] (handle_domain_irq) from [<c0101328>] (gic_handle_irq+0x7c/0x90)
[<c0101328>] (gic_handle_irq) from [<c0100b7c>] (__irq_svc+0x5c/0x90)

If the device sends data and does not receive msg from the host then the
field port->read_started contains a positive value. After disconnecting
the cable, gserial_suspend() is invoked and the port->start_delayed is set
to true. Connecting the cable again causes invocation of the
gserial_resume().
The callstack after connecting the cable looks like the following:
gserial_resume()
  --> gs_start_io()
    --> tty_wakeup() - with NULL argument

Fixes: 5a444bea37e2 ("usb: gadget: u_serial: Set start_delayed during suspend")

Signed-off-by: hubert.buczynski <Hubert.Buczynski.ext@feig.de>
---
 drivers/usb/gadget/function/u_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 5111fcc0cac3..384f219fe01d 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -564,7 +564,7 @@ static int gs_start_io(struct gs_port *port)
 	port->n_read = 0;
 	started = gs_start_rx(port);
 
-	if (started) {
+	if (started && port->port.tty) {
 		gs_start_tx(port);
 		/* Unblock any pending writes into our circular buffer, in case
 		 * we didn't in gs_start_tx() */
-- 
2.25.1


