Return-Path: <linux-kernel+bounces-412022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272289D0279
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E141E284B76
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50585768FC;
	Sun, 17 Nov 2024 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="J31Kg2or"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC780A92D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731832342; cv=none; b=a9JDqR2kfpehmOrrOqJc7Jdipg/KMuHc/VPkaOvNfbwRPk7cwnhXWcxoS5ZLO6a3KisXiuWodgo4OkwNshFgmcdrkByoFfbnkAjgpSmdPPatMD+9EXsPdS0N3bWQHf2h+2gcERCxG1woNUPBVaEsLGtEfTJhFApz6JgEjkRS4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731832342; c=relaxed/simple;
	bh=bEdtzbEoybZw2elzR+5shN7afieydr1cqVkaEADVKqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUNcID1YoSlDKjR6e3DZSlcVttD/aMfBJeHBgP0LXcXJhBWCISGS2zSxl3pmTu97U0p9zUfWswSIsGp1CUp/7EWmpe3qf1GPLWabH65sWFHp3cgCZyKLxzthpL5hj1IkHJ6MxfjnuqdqtbQJ0MuUVCaUHL8KbOpIZjm9/NVStWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=J31Kg2or; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-382423f4082so235355f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1731832339; x=1732437139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xqOFH63hSrxX1dILSqXuu7UlXARoGwwkDBC60Jsfjg=;
        b=J31Kg2orYVJNBZ8e//Rq0DHyUvW1m3mjPr7srLgL4qpNSRf/8F26rS2jqyShispcup
         2L/ucFbYK2ZJzkex6KlLKEiRt2KnpGnVoOa5j7Y+rKCOlvyflFMBmbt+pKJ+O+esqhgw
         uNybT4QMOdJ7qAis19yDhea5hzon2FnuZkq0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731832339; x=1732437139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xqOFH63hSrxX1dILSqXuu7UlXARoGwwkDBC60Jsfjg=;
        b=jdk3FPvMI5ahQjrWD1SYtwU7wjttBUeKX/y0FoNONDcRGRc8dCF5e8Rv8N6XGxtCXq
         RFLU7H5hh/VwIVbfmyP8pN5O3t7xo/kzlWiqBTS2izmslRBwU4AnAJr3kvJusBj2omLA
         Ha14fv5pnwj+Xv2lvjJkzodPwZHlBcK3mAwmvqmfKJnHu5bYJ7GpaLaM8e7g+rI0oAca
         AuSx5ag2KdKeaXT8Yh0D5YAbz/LNFa702L5isV+2ruLJK6k22LMaEDFABc5yPXJaBBSx
         bQgG/eD82dG25kW2CyBiwwcSgFA+jqvb8icbSsViM5KF+Zfb3nDE7RNblzfF4XbHbLjw
         UW9A==
X-Gm-Message-State: AOJu0YwnbL3hENSAfJc8Zvpiddv5TVZ8c6X3ozMndiJ2ugB9x54DJiHH
	Y07PRk+XXWpal/t6J4Q0KFPgBNkLQZ6J4Oq25kYsgxS0a3wrm2GaBTpXW23YOfciBLP/L+6WTrC
	3qkw+YA==
X-Google-Smtp-Source: AGHT+IFqkInzKSrfWZDyAqHcKfytVQVzvBRf/xa6VaY1oFjx31mr3qwfdW5qrpoRUwLDctZQXKIcMQ==
X-Received: by 2002:a5d:5887:0:b0:382:42c3:83cc with SMTP id ffacd0b85a97d-38242c38557mr659457f8f.45.1731832338731;
        Sun, 17 Nov 2024 00:32:18 -0800 (PST)
Received: from able.tailbefcf.ts.net (94-43-143-139.dsl.utg.ge. [94.43.143.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae1685csm9466919f8f.83.2024.11.17.00.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 00:32:18 -0800 (PST)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: linux-kernel@vger.kernel.org
Cc: Ivan Shapovalov <intelfx@intelfx.name>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 1/5] net: usb: qmi_wwan: add IDs for EM7565 (9X50) in "MBIM USBIF" config
Date: Sun, 17 Nov 2024 12:31:11 +0400
Message-ID: <20241117083204.57738-1-intelfx@intelfx.name>
X-Mailer: git-send-email 2.47.0.5.gd823fa0eac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change was discovered and tested using author's own EM7565 device.

This "MBIM USBIF" configuration corresponds to the `AT!USBCOMP=1,1,xxx`
on-device USB composition setting. When activated, the VID:PID resets
to 1199:90b1 ("application" mode) + 1199:90b0 ("boot" mode, i.e. QDL).

The "MBIM USBIF" label comes from on-device help:

---8<---
AT!USBCOMP=?
!USBCOMP:
AT!USBCOMP=<Config Index>,<Config Type>,<Interface bitmask>
  <Config Index>      - configuration index to which the composition applies, should be 1

  <Config Type>       - 1:MBIM USBIF, 2:PCIE USBIF, 3:Legacy-Generic, 4:RNDIS

  <Interface bitmask> - DIAG     - 0x00000001,
                        NMEA     - 0x00000004,
                        MODEM    - 0x00000008,
                        RMNET0   - 0x00000100,
                        MBIM     - 0x00001000,
  e.g.
  10D  - diag, nmea, modem, rmnet interfaces enabled
  1009 - diag, modem, mbim interfaces enabled

  The default configuration is:
  at!usbcomp=1,3,10F

OK
---8<---

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 0c011d8f5d4d..9a33393d4ce2 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1349,6 +1349,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1199, 0x907b, 8)},	/* Sierra Wireless EM74xx */
 	{QMI_QUIRK_SET_DTR(0x1199, 0x907b, 10)},/* Sierra Wireless EM74xx */
 	{QMI_QUIRK_SET_DTR(0x1199, 0x9091, 8)},	/* Sierra Wireless EM7565 */
+	{QMI_QUIRK_SET_DTR(0x1199, 0x90b1, 8)},	/* Sierra Wireless EM7565 "MBIM USB-IF" */
 	{QMI_QUIRK_SET_DTR(0x1199, 0xc081, 8)},	/* Sierra Wireless EM7590 */
 	{QMI_FIXED_INTF(0x1bbb, 0x011e, 4)},	/* Telekom Speedstick LTE II (Alcatel One Touch L100V LTE) */
 	{QMI_FIXED_INTF(0x1bbb, 0x0203, 2)},	/* Alcatel L800MA */
-- 
2.47.0.5.gd823fa0eac


