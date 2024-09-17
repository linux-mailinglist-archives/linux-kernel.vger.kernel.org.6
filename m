Return-Path: <linux-kernel+bounces-331769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE1397B100
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B721F245CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9502E177982;
	Tue, 17 Sep 2024 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SECdTm6n"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4D170A20;
	Tue, 17 Sep 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726581399; cv=none; b=rwPMOMWIAOELlQ/Y6lJnfNvRGEoKsAa5ed8FOX7Fk37Z0PAHEmQmOqdwHMzzdTHkhiFAcrcvhOMGAdNX/WEbS9MGCj2J6fYOooh5tWzw2O1bPB+n/uDUwMmQkN7dD0yRkC6E8F7InxGgeEBInWJ+d2dY8oBo8wdRbLswf2+Wstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726581399; c=relaxed/simple;
	bh=b01XcGpgVZ/b3Rb+1+ZTp1hmGHnL6vJVrMuUCnae3po=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=QDM115NuAnNd3m34iHsrfnYF7EDV1gifbpj+jBhS3eqdQXXspsAysSaXPg+NIMbxaPcWZdzgyXN31+DzUhNho89oTkfuosAtgkHivxPjz26ZAezn4lTRMSynaJYDrWZSRqqfbrjDe6bZYVztKzDJ9VxdTzctjI+zp3nMKMeSwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SECdTm6n; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32974fso7013359a12.3;
        Tue, 17 Sep 2024 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726581396; x=1727186196; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wl5lJZKo2InPHFwy70QqMNH9ys6Nw/9lea3YM3N2W2c=;
        b=SECdTm6nB+SLi7qtBcoXOVQRgHpWB5BtKeOQChtrKshtsxJ5QAM2J6XUpBXDVSixHY
         6J7HYwS7iOenQNbFmQY9mTg/lVGLXyyHfDAJBDPnxm3YujYX+NwKl3lnpL+hLtalbgTX
         K6ZOV1Hg7DER/CojfY/CBpiQVi9NFDtqsnYIsOIZC//EoGuF1mPd2FfPUCAnJ98L2otA
         4KBfgOGYn11N9IerFqmSjenUNwNRaGcsSo0qc00sh5naZ+wlO7DJDMBJwO7+WjheKARL
         fJYjObvFtEyJfgZ+CI6DQwfcvP3OAPbIeEReKfMIx19FHYncl4t98kyfa4ysdqzGd/CS
         h4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726581396; x=1727186196;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl5lJZKo2InPHFwy70QqMNH9ys6Nw/9lea3YM3N2W2c=;
        b=OhHaob+qH/0g+56tTRotebiz+n+h+uVJov7U2adX8Mg2q4Av0elf99Wpwc1fe/jClg
         SrerJpdN+H1ZyxpkXCyZFLYcjVJcJWy+nsPNZDUHrIzSOayoXCzulLzT+U6148eL7AVY
         VSte6w7Rv4q3HOA0+Q0IeiXM9vz0ZCtSoREN7BIO9sffz8iUCvN3Q1DNo+SLH+f0dAKT
         8SQjIqt6bw4CXYmZxxNxmWrWfpa6Ftr4naxiHHZwNRj8a9aD9Y5K0+J66ITQMssrfRVB
         80ZBT6YP12P9Y/urexVpwVzQtqys6BxeF7RZCev67IGwlVdTM+WjIza8ygd+V83lQca5
         JQvA==
X-Forwarded-Encrypted: i=1; AJvYcCUB6+T5Vra0JgVABukazwDYtGjvDy9k6cmSLlJ8ZOAMdGtTfMdP17Dt9/anhqnbQspkr3KzDbGDfm3X@vger.kernel.org, AJvYcCXs82WHfWVqOqlwEz1ASOdQfpIndObI+GMWFGFULLD6JknubpeSRIjU4IWzDkgpDK2y7iOTZXVs/fAc1fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynMYmxIkJG8U/milE2kXgtsHU2hgXTNuPcHzsUGK/DZu5kUuY+
	i8Pfsj5arsKJMlKicLHDsGP2XloBfRCGvUkVMmJ0wqLkCdz/q+C1
X-Google-Smtp-Source: AGHT+IEcCdajP+bwf7m0fr+lfVuodN90RXtvgydV3QS3XeNLgeP7uTT5l1qL0Lorxz0VZOBpoAqvzA==
X-Received: by 2002:a05:6402:13c7:b0:5c4:14fe:971e with SMTP id 4fb4d7f45d1cf-5c414fe9994mr16838943a12.23.1726581395341;
        Tue, 17 Sep 2024 06:56:35 -0700 (PDT)
Received: from [192.168.216.101] (public-gprs228163.centertel.pl. [31.60.38.132])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb49761sm3899034a12.15.2024.09.17.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 06:56:35 -0700 (PDT)
Message-ID: <155be9e56e650dd7f7baf1c7e193e1a3d85e7141.camel@gmail.com>
Subject: [PATCH v3] usb: gadget: u_ether: Use __netif_rx() in rx_callback()
From: Hubert =?UTF-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ferry Toth
 <ftoth@exalondelft.nl>, Hardik Gajjar <hgajjar@de.adit-jv.com>, Kees Cook
 <kees@kernel.org>, Justin Stitt <justinstitt@google.com>, Richard Acayan
 <mailingradian@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>,  linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 17 Sep 2024 15:56:33 +0200
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
Cc: stable@vger.kernel.org
Signed-off-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>
---
v2 -> v3: Added cc stable tag
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




