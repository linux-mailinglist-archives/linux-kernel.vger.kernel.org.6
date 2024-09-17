Return-Path: <linux-kernel+bounces-331655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6E97AF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E3D1C2139D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02A1662F6;
	Tue, 17 Sep 2024 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktMB1LgK"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C766E57D;
	Tue, 17 Sep 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571972; cv=none; b=YzihL6aJhXIjvxk9J6cNRLHD0jL4Tq9zl1NLUHy4lGyqqa80gcA/DQu6Luy7TM4NNvEr6rA7IHHYZ7HvjB9b52VfqaS9OJue99o4qGxdBm2LSzSGNFeffOmF09OU5kvaQJQNZCoqy2yE2HPCWmGPYEvkzhJvtpDiDaLkw1e4LqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571972; c=relaxed/simple;
	bh=oDEGe+IbXnjXP8bHyViYlZMJBe3NK2+FwSE2EiOLfyg=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=uxTIGv4Bca7PKzSgJP0gItKblHq8y1SRAOPwN6AbEXiISqqB/6K4alhZ5UhU70dxmXZV45Ey7F9vExRqRRwo85GsJ/qrWUcPvDlBYxATWyVJQdbSyG758fVQoW+D4N/79pHOfQo43iTo8Em79e/x6LVRmtS7Xe4ihhUv67+Arg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktMB1LgK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so758874666b.2;
        Tue, 17 Sep 2024 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726571969; x=1727176769; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tUcm5Im+md7LODP7Hdr/71vG84FUle4ybr5JwMog4Zo=;
        b=ktMB1LgKf40PhY5vrYIxuhGHZVJKgktj8y3D2Tb36yUwnIDml+QHcRAPeqDrL4bbaD
         kGu7+WN2Adq/bR6rqvOdPjWi1ziOxxmH2zVddVCuZ4LsRvHNL03jttGcbLETnWyVBcV+
         W/n112AJ8JYs7floeWJqQr62TIKeblAqSIz8zLyUQpQcBy+iCucZ0p33kTwuBYi5uh9t
         GkNx7WyGJ2Xdpv91Xw+UgL861PsZ5QBBqcc00D8BkcAjmeJ1vVYhoqprJpr8BbVO/yy5
         uMLokdt2UrAYEyMirnyxp27bYQRVnD5yY4kEcEtZzafajRovt3iYDyhvHeZFgUfCXMHo
         fQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726571969; x=1727176769;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUcm5Im+md7LODP7Hdr/71vG84FUle4ybr5JwMog4Zo=;
        b=Ztx07l8gksSy81Ob7y8WDR3qXxJBN6xvRPJf7ECCnYQEg1V7PTu0U1dzNInUZNvHL0
         LwpiZcqVo+1B8XLevyVdVJ+wHKxYi7cTloyNFmzIIf2qjqqDvVysCwQTD7mq75k5Ddiv
         PsBZvv59le+P/VeE2xQuks954cJsW/qfNf5QxjRlIbZmuNVdqBdGoIl+H/ymS/sDroz7
         LwEAwdom5qpi5YAQLMfDDWcW7k97Bbl1GKy2wZZSM41w+cXsiPovSk06FftBdGw1UcQ2
         wFJVm2ml7ypfi2eZ6Nc/k8CpdmgvqRMn7Igruu6Y5cBPeDGdl7EaE2tJw4r44NOENXI6
         0bQw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Iapl/CwmC94xb070iorQ31ARZLFRStoNyEA/dv8TEQ3feoYiNzVt+hAdtFkTRRK6/BHYBjDPVhyi@vger.kernel.org, AJvYcCWliimfNbxQqv/vSgM7/9VwcMGttRGnftTEgp7I8lJwRoCp9az7xtUlHbJ0189OJCGGnXGpNLNue1ogrUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQzM2pALbkPvt/gBLF4Ko3Z3QxwouRbkL9uEnTnQ7BODofqpx
	/+7Tv189BTGiFg2JuCq7SHddk1CVCWeyEjaoRIOfd4IPhYsdZSwy
X-Google-Smtp-Source: AGHT+IGRsPna0vulZPvdgVQ9MXw7LBoiLMdkxyJ6FtgzWvDfBBAgk+WpzcsIQvskCOqECufdF+vI4g==
X-Received: by 2002:a17:907:e687:b0:a8d:2c3e:7ed3 with SMTP id a640c23a62f3a-a90295a6a66mr1785252766b.35.1726571968515;
        Tue, 17 Sep 2024 04:19:28 -0700 (PDT)
Received: from [192.168.216.101] (public-gprs228163.centertel.pl. [31.60.38.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061116c28sm434275766b.95.2024.09.17.04.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 04:19:28 -0700 (PDT)
Message-ID: <10019b141275f7fa3e2446e207e7a9afaaa98b3d.camel@gmail.com>
Subject: [PATCH v2] usb: gadget: u_ether: Use __netif_rx() in rx_callback()
From: Hubert =?UTF-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ferry Toth
 <ftoth@exalondelft.nl>, Kees Cook <kees@kernel.org>, Justin Stitt
 <justinstitt@google.com>, Richard Acayan <mailingradian@gmail.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, Hardik Gajjar
 <hgajjar@de.adit-jv.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Sep 2024 13:19:25 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

netif_rx() now disables bottom halves, which causes the USB gadget to be
unable to receive frames if the interface is not brought up quickly enough
after being created by the driver (a bug confirmed on AM3352 SoC).

Replacing netif_rx() with __netif_rx() restores the old behavior and fixes
the bug. This can be done since rx_callback() is called from the interrupt
context.

Fixes: baebdf48c360 ("net: dev: Makes sure netif_rx() can be invoked in any=
 context.")
Signed-off-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>
---
v1 -> v2: Added Fixes tag and corrected Signed-off-by tag

 drivers/usb/gadget/function/u_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/fun=
ction/u_ether.c
index 4bb0553da658..fd7e483b4a48 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -266,7 +266,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_r=
equest *req)
 			/* no buffer copies needed, unless hardware can't
 			 * use skb buffers.
 			 */
-			status =3D netif_rx(skb2);
+			status =3D __netif_rx(skb2);
 next_frame:
 			skb2 =3D skb_dequeue(&dev->rx_frames);
 		}
--=20
2.30.2




