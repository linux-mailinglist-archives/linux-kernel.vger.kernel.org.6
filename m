Return-Path: <linux-kernel+bounces-304127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A4961ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EFD1C22D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205A41D47AA;
	Tue, 27 Aug 2024 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbawGLMs"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93E19A281
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802241; cv=none; b=TUIrG1w121lrrezpMlIPpn/I2IfHFnDMnY9i2k+ipYEDnD5QBFDFPYcIEyaAYmwdGPzzQ+FiLxIVJeO8BqM2Aqs6hnWc0QsXNo+dPXWD9bHiIT3EocSA930p7OaRNCXaJJlz2TsuzQcOsk4hFhySyi9Kbz5vbRaXiDYhxDpY5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802241; c=relaxed/simple;
	bh=jdMDiYvqrr+rE8/Zc4mdBuXyJ3vietZyIOw9UrumohY=;
	h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type; b=A9Me6l4n7iYb34J69i89YsT2ZsD1SsnRGoCzQjwDXKw7DQ//80ML7Aol5c0Y2RfZy3jUg8aGstLh22Lyk0Rw9p/JbxcMPL1DDdWPbQ3PVN0nweVTHKntE/WchDg6zjonYjYy/mEnJXmRghVZtyx6C6Pn4yq4dTvqK/naP9P7YBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbawGLMs; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-829e856a173so96830339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724802239; x=1725407039; darn=vger.kernel.org;
        h=mime-version:user-agent:date:message-id:cc:to:subject:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RtZ793c5PF/PlyiaYuY3ojH4us3fCIL3xb7vwRdZ1T0=;
        b=JbawGLMsatDfFIMf0tBvGzfEFfGRBYriL3MiQpCFyyYiV/YZt+23cN0WBPwgs4ciaD
         clUs53jAoPjkziGWBx1WFrXeR93FcOALokLhErJ8L40O47ouW6to54bQB0y+aAF01ER6
         A5ijjy6SdVPTj8pvQ1ZiGsydlykTo9QnkSLP/8eylpDANn76VT9cFUD2EZFqGT3Z2tj4
         +M4VWEwanR0uHkt5pPqd2jchNA/cNblY3F1Xh0nqTXKYkGCYr1J99DkHKUFmGJ0rtLH9
         8Jhz819+2pgQ7zvWM6ACNFNyvSm7XpW1qJUzrnNWOZ/7vox527oyVxip5vFiYirb/ozD
         9NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724802239; x=1725407039;
        h=mime-version:user-agent:date:message-id:cc:to:subject:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtZ793c5PF/PlyiaYuY3ojH4us3fCIL3xb7vwRdZ1T0=;
        b=PXzZIFUXh+Qygybekh9TBKIyk5BoQMEbOrsRGXf6QLxIlCS3w45C5QTUKOBv99lLUy
         mDg6I3Z/Lq5zYdWVRQgfqqKiBQkuCq01W4BMB7D2SgXthQYTx1QGHevi8pWvhUPk3FLi
         LJUlNDBH0ySQR92B1Yi3yW3E76cCQo7T2BJ5NvekrHo4mKxGimew9x0OOuvhBcsgjKns
         6Q83j8vTffUqlskz70sOZjst6daHky9+D235v9VgKlln7wAf5SpC3/6MAeQS4YKSc3HD
         gQ4CYKcStIicj9uh7muhujo3yW34GkRAP+082i26LX5WMUAwJ9ZTA+XPtm15HCMxF/v+
         Warg==
X-Gm-Message-State: AOJu0YxYI7JVnqhMXuUkK2eu/6eDgZSoF4HPmcRbyM/Y9Vfx0XkcoNEI
	EDlXxovPx1gtf8SmHthpfbWh0HFjr6x8uG8cYHoJPYntOd0zEv0=
X-Google-Smtp-Source: AGHT+IGPVzc7tEV8of35SmbuN3A0ZATOM5eUiJgnsRJAtxGtI0mPFOHZVu54isK6ovfyAThzoXXmAw==
X-Received: by 2002:a05:6602:618b:b0:825:2a43:27e7 with SMTP id ca18e2360f4ac-8278812b479mr1643785939f.4.1724802238853;
        Tue, 27 Aug 2024 16:43:58 -0700 (PDT)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f1f664sm2846156173.17.2024.08.27.16.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 16:43:57 -0700 (PDT)
From: Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH] mouse_cypress_ps2: Fix 6.11 regression on xps15z
To: LKML <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
Cc: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <a8252e0f-dab4-ef5e-2aa1-407a6f4c7204@gmail.com>
Date: Tue, 27 Aug 2024 19:44:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E632F407AB9BDF8B038BD8F9"

This is a multi-part message in MIME format.
--------------E632F407AB9BDF8B038BD8F9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Kernel 6.11 rcN on Dell XPS 15Z:  touch pad has stopped working after 
the patch

commit 8bccf667f62a2351fd0b2a2fe5ba90806702c048
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri Jun 28 15:47:25 2024 -0700

     Input: cypress_ps2 - report timeouts when reading command status

It seems that the first communication is with an invalid packet of 3 
NULLs, and that
status failure used to be ignored. With the above patch it is now 
returning an error and
that results in a dead touch pad.

The fix is to stop flagging an error for 3-byte null packets, just keep 
ignoring them as before.
[    2.338016] [    T591] err: Command 0x00 response data (0x): 00 00 00
[    2.338032] [    T591] ok: Command 0x00 response data (0x): 33 cc a2
...
[    2.770029] [    T591] ok: Command 0x00 response data (0x): 33 cc a2
[    2.998030] [    T591] ok: Command 0x11 response data (0x): 01 00 64

Signed-off-by: Woody Suwalski <terraluna977@gmail.com>
---
diff --git a/drivers/input/mouse/cypress_ps2.c 
b/drivers/input/mouse/cypress_ps2.c
index b3c34ebcc4ef..d09272f2fed2 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -115,8 +115,10 @@ static int cypress_ps2_read_cmd_status(struct 
psmouse *psmouse,
      if (!wait_event_timeout(ps2dev->wait,
                  psmouse->pktcnt >= pktsize,
                  msecs_to_jiffies(CYTP_CMD_TIMEOUT))) {
-        rc = -ETIMEDOUT;
-        goto out;
+        if (!(pktsize == 3 && param[0] == 0 && param[1] == 0 )) {
+            rc = -ETIMEDOUT;
+            goto out;
+        }
      }

      memcpy(param, psmouse->packet, pktsize);


--------------E632F407AB9BDF8B038BD8F9
Content-Type: text/x-patch;
 name="xps_touchpad_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xps_touchpad_fix.patch"

diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index b3c34ebcc4ef..d09272f2fed2 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -115,8 +115,10 @@ static int cypress_ps2_read_cmd_status(struct psmouse *psmouse,
 	if (!wait_event_timeout(ps2dev->wait,
 				psmouse->pktcnt >= pktsize,
 				msecs_to_jiffies(CYTP_CMD_TIMEOUT))) {
-		rc = -ETIMEDOUT;
-		goto out;
+		if (!(pktsize == 3 && param[0] == 0 && param[1] == 0 )) {
+			rc = -ETIMEDOUT;
+			goto out;
+		}
 	}
 
 	memcpy(param, psmouse->packet, pktsize);

--------------E632F407AB9BDF8B038BD8F9--

