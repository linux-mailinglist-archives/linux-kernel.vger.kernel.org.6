Return-Path: <linux-kernel+bounces-414988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E89D3029
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FE81F23480
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37B11D3578;
	Tue, 19 Nov 2024 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0cnJTTL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E119340E;
	Tue, 19 Nov 2024 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732053266; cv=none; b=FjUfNOXRy3u1Z3HjBrDTstsE+ZFoCrPMKsAjzrcdUTQEaRcFckj0kTiJqUG/rFRgkc7PCk2ZNIZjcc7U/e8OBdLnDCAqwXhHaHK3XbPdpx2z4HiXfUSxS8+Xiqjfklx7wkpl+XB3H9THb1e5sBTYEa5GqmRgpLnIJkNEI3MXyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732053266; c=relaxed/simple;
	bh=LR6RtMiCLf62/FPIbKk3ZuNT9EAYt1ABSfyQCNPw5eE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tojj0OkSk2PsnwP5oRikYLmM7TSA1/zuqi2n1nPuHM/bqpo6CS7+rPUWrhJluw71ooFHq1jZUKd1JRFmDerxOVJTdKaaLGu7ei0/yO7PTo1E4tFzHhmvFQd76rDBzzU7vFd7xv9I7fT1PzwPkZTYLxVustOWgQrqMT/NvCICIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0cnJTTL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so40999955e9.0;
        Tue, 19 Nov 2024 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732053262; x=1732658062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rcpbtm7aUHGqx2bVM0iKGOigGKjaryXW48lA24pdOU=;
        b=W0cnJTTLqXt+VvrCZpflweXY5Q2799pcMlaI0osmMIu5Y2DZodUC4sN5Vvb18uwIKU
         q4UPZQtet6KEzqD/j9YUEi7vcVPUWdqQ1z6Bpszda4aAFhmRaw8EfOM1Lt1EbQAuaxXg
         weInZtUWaQ3ojwJkkpislMS2gtS6NG77GTmVGNKP6Na0Vf9BoqBQmOCJ079MIOigR//c
         dFa9AOP8fpXl+V+LW1ayUPNWlAd8bYZDHzkWC4qJssX5JC349rybyeecrB/3nBmK76mB
         tu1c8wm4XQhhiFyL49vBdkTrI492iNUdZoOkXAEk4fo73kGm8yac6gIbL2LMJEyZ01xv
         bL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732053262; x=1732658062;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5rcpbtm7aUHGqx2bVM0iKGOigGKjaryXW48lA24pdOU=;
        b=maE1ugLy5qEl2xKrRScz+IoRG5TYCudrtQiYL6/VgmuRzEJGClVtbSr00qwgZt4Nlz
         fHjVByZw8sLH/eIVYre0WxMMEs9KYFRF5YkuKzIT0H+0GWSpf1V0AbuwO27h6xa7uVdQ
         id7bby9xYBTClO9e0k9qx3/YT4pMRdaT+DEWVES/hzlmFG4QHUqCZaJORprUnuOgq+4a
         jdDcCEzuzjiUGVUlh5EIF+E/jcNInHdq9I1wknn5a/mX3Np+hlfLR/vKTej5jiXw9wVB
         R2PBo/96jft0/d3KmF8U4KQ4eNFZrKzhXzwurBUPGeDmmQwstZfXiL0m1z96F3H20zZ5
         0ruA==
X-Forwarded-Encrypted: i=1; AJvYcCUEeyerPbVru4aN0O56P8c4/bYNioVKZ1cSUTzkkzCPknawH2FUJfXRixtQRSNN6TSrz92WsFginsIh9KI=@vger.kernel.org, AJvYcCXxP06EFfGVqnlm9MKfG0GDBR+S7OH/zNM2m96pC+cutIcifZoZSPLxY278ni0nMWbWYhu/0J0ud8dve+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Wg0OV1/iwrGZ0x2+hy9MefspKRa+ikWcfTz29Rri4fUrlpt/
	j7U5iPkz8obZoO6pBFpTQFcjtncPKYWHO5BdaCDuOI4cXiqci81J
X-Google-Smtp-Source: AGHT+IFTV0yGBotQfy7ZT3VUJcU92aUwm1o86+KKHyT7DbD8nR3qVC/44UXJ9MVt/dWXlmYpNUeAfg==
X-Received: by 2002:a05:6000:178e:b0:382:3527:a162 with SMTP id ffacd0b85a97d-38254adeec5mr266447f8f.8.1732053262339;
        Tue, 19 Nov 2024 13:54:22 -0800 (PST)
Received: from ?IPV6:2a04:241e:501:580:1cd5:f4bd:17fc:6eff? ([2a04:241e:501:580:1cd5:f4bd:17fc:6eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff454f78asm118209a12.81.2024.11.19.13.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 13:54:20 -0800 (PST)
Message-ID: <25d5b0d8-4efd-4630-9d33-7a9e3fa9dc2b@gmail.com>
Date: Tue, 19 Nov 2024 23:54:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leonard Crestez <cdleonard@gmail.com>
Subject: [RFC] ALSA: usb-audio: Fix missing xrun report in lowlatency mode
To: Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I’m investigating an issue where USB Audio does not properly send XRUN 
notifications.

The issue can be reproduced with aplay: enable xrun_debug, aplay -D 
plughw:0 and CTRL-Z - no XRUN message is seen

Disabling lowlatency_playback via modprobe parameter does make this 
issue go away - XRUNs are reported correctly without any changes.


After a lot of tracing the following seems to be happening:

- prepare_playback_urb find avail=48, meaning 48 bytes still to-be-played
- snd_usb_endpoint_next_packet_size decides that 48 is too little and 
returns -EAGAIN. Specifically -EAGAIN is returned from next_packet_size
- The return value of prepare_playback_urb is propagated through 
prepare_outbound_urb back to snd_usb_queue_pending_output_urbs
- snd_usb_queue_pending_output_urbs receives -EAGAIN from 
prepare_outbound_urb
- since err is -EAGAIN the ctx is pushed back to the ready list and 
transmission is aborted but notify_xrun is skipped
- no more playback?

It is possible to make XRUNs happen by caling notify_xrun even on 
-EAGAIN, diff looks like this:

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 568099467dbb..da64ee0cf60a 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -495,10 +495,11 @@ int snd_usb_queue_pending_output_urbs(struct 
snd_usb_endpoint *ep,
                         break;
                 if (err < 0) {
                         /* push back to ready list again for -EAGAIN */
                         if (err == -EAGAIN) {
                                 push_back_to_ready_list(ep, ctx);
+                               notify_xrun(ep);
                                 break;
                         }

                         if (!in_stream_lock)
                                 notify_xrun(ep);


This mail was not formatted as proper patch because this seems very 
likely incorrect, it undoes an explicit check. What would a correct 
solution look like?

There could be a scenario where -EAGAIN from prepare_outbound_urb can 
happen without an actual XRUN, but I don’t understand the code enough.

The fact that usb-audio halts playback with a non-zero amount of bytes 
that can still be played prevents the XRUN checks inside 
`snd_pcm_update_state` from triggering. This means that the driver 
always takes responsibility for reporting xrun, correct?

It seems dubious to me that unplayed bytes are kept around - shouldn’t 
fragments either be played or dropped? Perhaps the last fragment should 
just be padded with some silence and sent anyway, then core sound code 
should report xrun anyway.

USB Audio has many parameters. In my particular case:

- lowlatency_playback = true
- channels=2, rate=48000, format=S16_LE, period_bytes=960, periods=3, 
implicit_fb=0
- nurbs = 3

This was originally found in a complex application which checks 
snd_pcm_state regularly and does not find the SND_PCM_STATE_XRUN state 
but audio gaps are seen in a physical line capture.

This was seen in Linux 5.19.139 but also affects 6.6.y and latest 
sound/master branch. There are very few relevant changes in this area 
that are not already in stable branches.

Hardware is a conexant audio codec, USB VID:PID 0572:1410.

--
Regards,
Leonard

