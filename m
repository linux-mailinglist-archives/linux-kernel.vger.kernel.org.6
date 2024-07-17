Return-Path: <linux-kernel+bounces-255358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1848A933FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE3AB22516
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F1C181CF8;
	Wed, 17 Jul 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vyo6K0ku"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF1ED8;
	Wed, 17 Jul 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230084; cv=none; b=YzL/kGfjAE+JKpcRgiPsxiq9cdhfhULSdKds2JPJFGA1d1KMRUELYrHhIUOnGbrxNou77HLPFctWxC+chWV3SbzwMgdXw1E3e9NjMPDz+1CYAPCa90ri/g0Ff0CgQphlgzE3jUuGxmVwi/iRMG3/S9zkFXKuzvFjW8kn4p6Gp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230084; c=relaxed/simple;
	bh=ENnMXkbUlVBZRnVOFr0OihBlKzM9U1/92RLACOT17mY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JgtVwhLLPna43Kx04Dhi3eKG5yd1kdMXZeQo21n3e96mOo09ekLpCzbRU3HhGFeizZDHNlASgMZH/MROrC6hdYUu3rxl9o4da/Gq1qRle/7L6mq1QUtHlDXmtMdxwI26TZ+9Ba2UnHWuh2dFF2B0QznwTmNHRdy1YjLanr8kwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vyo6K0ku; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58be2b8b6b2so8319009a12.3;
        Wed, 17 Jul 2024 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721230081; x=1721834881; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVtP0KXuTgh+5kyCFPusMyNTsCSk4gTUE1Cpbo7vu1U=;
        b=Vyo6K0kurxClmCxMYOP4lW1GehNtU0MkG4Dhj94hPOIPSgunJEweHan7w5av2QyHii
         nvYkrzodR4lzKqlzQ+XucQqxu1RE1WPnybcjZZxOjJajyFLEoZJ7RQixcFk5umZafN3i
         noydXGcF2KBhWU4b3PbXx+4/+LGO3SzE0aVS0dgK6rJ5vE70YZtzPnM2fNKhOoD6Gdv0
         WoZt8iTTkBRcLTOxZUUNr8frRPf+OHJgIs9nQGSdbdVnvdZz7/vEYtdwqFMgLpLdqYWn
         Etz2FSY5e4a5IRb5wYhZw56VbBKfVPgYRcFyFHWHcUtH60Bib/VVWNr0BOm7QqBTiDYi
         33qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721230081; x=1721834881;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVtP0KXuTgh+5kyCFPusMyNTsCSk4gTUE1Cpbo7vu1U=;
        b=YL14VRNFPfKujfoZv85F635nV953MO2ACUz7LMIUsZ9twZ6fJ3V1z1qr10t1L+SWdG
         GYm2SjolyOD2dRr0ldP0wzl+8WSDlznzfNfwSWB4JlGB3h2yn6a7xqrjSWM4oFcsYvfv
         DZTiBVC5Pn2fmO2nTpGkFA6R7iR9uCK+7NuvRmXg/MvKLBfxRVWICxHeNCLm7d/tM9Xb
         Ky6yPVV0sF9gazUWXQiZ4IfFCRXN+EubymX+9TTQ2OOfDtkNntwkVKLZgmxlTcvKyy9D
         lazBVQ52ntYwTOXv3zzgquk9y7BxRt6LzBWjbbs6GSCy9uJKOcLQRQwqDF/XvEn4VBWy
         gRmg==
X-Forwarded-Encrypted: i=1; AJvYcCUhV5ZSboAg9sKhned/t5Q+xs/DGocFFfz6HgNs6b+6o9cs31xMJ4P/d5aiRZU49whXtm8MVDnIzkb+0YatfUsKYM/+SxT4WMdk/zJdyT36v41wzu6f/iCPtMQZ2pN6tojHdH5oT8gRMA==
X-Gm-Message-State: AOJu0YzyUXY50chH1Ndmi0dnmVfH+V4IfnDAXIwCzXBoBuoVwN6ZTc5u
	myDnKG9/GB7YFzSrj6FMMXPxIFP9iCvSupDZXBRhsXw0iSByO38C
X-Google-Smtp-Source: AGHT+IFwfFQ95cvDCDN5pYyxFv5Q1bEn4v+zbiEvHQgGqiSS/4N8ycjawmA3dKgiqdg5b74cqs3cFw==
X-Received: by 2002:a17:906:b246:b0:a77:cf9d:f497 with SMTP id a640c23a62f3a-a7a0119eb9fmr140957866b.40.1721230081069;
        Wed, 17 Jul 2024 08:28:01 -0700 (PDT)
Received: from tablet.my.domain (ip-5-172-234-79.multi.internet.cyfrowypolsat.pl. [5.172.234.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff780sm456378766b.169.2024.07.17.08.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:28:00 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 0/2] ARM: dts: bcm-mobile: Split out nodes used by both
 BCM21664 and BCM23550
Date: Wed, 17 Jul 2024 17:27:53 +0200
Message-Id: <20240717-bcm21664-common-v2-0-e9bd6cf435e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPnil2YC/x3MQQqAIBBA0avErBNsmCy6SrQwm2oWaihEIN09a
 fkW/xfInIQzTE2BxLdkiaEC2wbcacPBSrZqQI2kexzV6jx2xpBy0fsYVEfa0GjIkh2gVlfiXZ7
 /OC/v+wEntgpTYQAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=ENnMXkbUlVBZRnVOFr0OihBlKzM9U1/92RLACOT17mY=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBml+L9nRkhdZ52Oc8XtVksn7+fE26E5vnwucRKF
 sBWfOcQH0eJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpfi/QAKCRCzu/ihE6BR
 aJZ8D/9yKJi3vEJvutaph+OzaK/Cyu0qNtNSF9Y9rnr8/XdDse1aF+6AeNplr92nepXt9MVEbPT
 s/X/Kmaf02V29K0rRbPjF35gDkxO9JRNqeIjYFyTHNCSGSBGiV7mg9ZkO6lWZmudSPGIowFyTOK
 +3N8AxyYPrKFCLnIppy/3D+o4EfW96NoSsmR9hEcOrPWCmdUocR0kWvVkaOtSkTjvLXDdkQBoMz
 j38uRs4l5FqrdTk4rwENIBs6CnS6uY6AZJLMFbdg32Pb0NEjB7KUlo4Ry84pEmJrfUND+vsT27Z
 tegreNjy4gcS0zwwiLafRZxswwm2NR17TALU/jRt44s1RwPqntiOw8f6Cz83dKEEi1LcPV/QJa+
 HBZI2bLaCnFJNdwxnaT6JxEKowtOZgozFa32/gag3J2NinvcdClyJBze634uJYFKFPOzw9Rrl/E
 YatK9MbtixOKTdLzqH7KUPHNaBa+J5DzxojlpQQiwTbPtzjHshwi22wJQdJ+dTwZv8ZEHt8h8ru
 GPJ3aZtBpe37QGUVz/aZkKX+5qIRiwhDQ282DNDF3iaEFVtitX5GYWIsj2ngN8duMLjxF8hZVDF
 3u1eR67XSPDvvjTT/GL6Rzbrua4jSHV80k5aiIYlW0OSKjtimVP2s+EU6QXg1Mwu5Z0Y6UrWZgA
 PdC9e51liT8DXmg==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

The BCM21664 and BCM23550 are nearly identical to each other in terms
of register layout. This was verified against a downstream kernel[1] -
Broadcom's kernel has "RDB" directories which includes headers with
the full register maps for the included hardware. Running:

  diff --recursive arch/arm/mach-{hawaii,java}/include/mach/rdb

reveals that the differences are minuscule - some things related to
ISP and H264 decoding. Most of the other differences are related to
the different CPUs in the two chipsets - the BCM21664 has 2x Cortex-A9
cores, and the BCM23550 has 4x Cortex-A7 cores.

In mainline, most drivers are also re-used between the two.

To make development for both platforms easier, split out the common
nodes into a separate DTSI, bcm21664-common.dtsi. This only leaves
the device-specific nodes - so, CPU and related things - in the SoC-
specific DTSIs (bcm21664.dtsi and bcm23550.dtsi).

The new DTSI is based off the bcm23550.dtsi, with its split into
busses. Since it's pretty much 99% identical, I kept the licensing
of the original file (BSD 3-clause). The license for the bcm21664.dtsi
file remains GPL 2.0 as it originally was.

make CHECK_DTBS=y on bcm21664-garnet.dtb and bcm23550-sparrow.dtb
seem to pass fine for me (thanks to Stanislav Jakubek for converting
the bindings to YAML format!). It's worth noting though that some
bcm23550 compatibles now go unused, since the bcm21664-common.dtsi
file uses bcm21664 compatibles.

[1] https://github.com/knuxdroid/android_kernel_samsung_baffinlite

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
 - Renamed bcm21664-common.dtsi to bcm2166x-common.dtsi
 - Dropped model/compatible from SoC DTSIs
 - Moved apps bus peripherals in SoC DTSIs under "&apps"
 - Re-added SoC-specific compatibles into SoC DTSIs
 - Fixed warning regarding address in GIC node name
 - Link to v1: https://lore.kernel.org/lkml/20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com/

---
Artur Weber (2):
      ARM: dts: broadcom: bcm21664: Move chosen node into Garnet DTS
      ARM: dts: bcm-mobile: Split out nodes used by both BCM21664 and BCM23550

 arch/arm/boot/dts/broadcom/bcm21664-garnet.dts     |   4 +
 arch/arm/boot/dts/broadcom/bcm21664.dtsi           | 342 ++-----------------
 .../{bcm23550.dtsi => bcm2166x-common.dtsi}        | 111 +------
 arch/arm/boot/dts/broadcom/bcm23550.dtsi           | 370 ++-------------------
 4 files changed, 77 insertions(+), 750 deletions(-)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240528-bcm21664-common-14064864a4a7

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


