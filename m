Return-Path: <linux-kernel+bounces-247428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17A92CF61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07801F22C41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F318FDB3;
	Wed, 10 Jul 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOvTAdzB"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA2139CFE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607786; cv=none; b=oXrfr1vxP4zzgJoGXY/clflaDi6dnEtR6lnw1DN+FQ1FpNpEVvike0W5gUgmYNwcGQvzqrBhcvMlakSp/jciseaU2xwAVDPDjD81I006Hww13dtpiMET3ARvp0khd1eEu7ECCei0JZMwu0CXKblhVlk+5fm+HkpCibwXxwi95Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607786; c=relaxed/simple;
	bh=EQUsM0PpNi/C3viEDbep0V+nVVtCBCQ3tQfYWoLwmAw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r6Ch6UMsCcVz3gU5ugqHyEHU2g1u7rYjLnjokx2aKATSm5XBzYnfojBd50gJ8S1qXDjrnwar9vL3QHP39oJT/eX1iG4Zi4Adg+Jnl0D09Dh/dukbf9RVs5OmsNDKgF9L5+7pQuoPZzsuwt2n99VWVhaqBJLr7Z1HNEz55oyhvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bOvTAdzB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77e85cb9b4so430877066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607783; x=1721212583; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=to5V6qVCdGxGxsByGLn0z5Szb/YbIZ3br1hRHITNGUY=;
        b=bOvTAdzBwA0ZXWq/p8NMQYniD72DkQFa87zL6/sA+FdvY4KnHdtcnCTpzwr4DOwRvi
         oxv8w+CD8MIlaHMWGaOrqjsphlYcew+biFpMB4K1TCeHAHQbSlJDRNtOrd460m8fhRIw
         +Znf8K8dRWkwAv7uP4OUztoBGNKNsqLe14NXThmNK+0YjWvs7uKlAHPMyZDRGt8TZJpe
         xsSCJg576T3tenRknjt2yC/b7M3gxBNhuTcUYwnp7K5jkudlVK3dpa/PSX5YC4226s6C
         n+t5xnXF07gx6+G+jWc8SH3HqNrgVhR5qN0q9ANr4vcpLXk1DOwW2zBeeweWsTUGLZlt
         0xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607783; x=1721212583;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=to5V6qVCdGxGxsByGLn0z5Szb/YbIZ3br1hRHITNGUY=;
        b=I97X8s2bMhXi/oMQBaC6nvVtFp1j9xTVOr48VGzcqbRSEbbqNrmCXdftnX0CVU9L2G
         RBMHzygSnBAdvZ1B9vbNcqfu54dq/MD7tdJZj4nlRboKIn1A04uJnVPk0BbN4ciENcxA
         5/81S4N6kVYL5Eshuq2fLpA6EbcpiBzaJjCwtOWsKWWcHTzNbNyJd4sa+wPlFJ1iIEHG
         qfUJaIc7ceTjlc5QJ6HAVmuOuCXj5N4ZtH4w4ANMZWr/Uoemsk2i94t9uC6RDYHAp6j2
         ooIZ6QsEMVkuzYVQG81ti8NPHz5Qr4ulSgNlyg759ofYuvP3YmGp8mSQyieXfv1N9dNt
         Q5Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVz25v8XKFVhH85a4WqcNbPd50Ww3Sm3nL4chS7XV/NQR4IDifjIQgMckGqpR1RL5DyE1hMSMS1Y3FnC4Mig7lPQ46RLyK9dO5F+C3r
X-Gm-Message-State: AOJu0YzN25tP8XjokAI+ZTfhSx1UWUseCgezFS20C6zKmA0RnXNuAryI
	9nc1ZANaTkRwBKWVtWMrcJHBG5Aw6vQiuYV59jrLDxDMY61giasQ5BnVFD/nbZk=
X-Google-Smtp-Source: AGHT+IGbaIZW50zLMAyxfLsAKsc6ORm/NxD5uU4AkcC9GVHezofsIPzVhNzRU9hVPR3VF+nIjs6QhQ==
X-Received: by 2002:a17:906:e20e:b0:a6f:c268:ff2e with SMTP id a640c23a62f3a-a780b68a303mr294850466b.5.1720607783105;
        Wed, 10 Jul 2024 03:36:23 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:22 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 00/15] usb: typec: tcpci: few TCPCi & TCPCi-Maxim cleanups
 (mostly genmask())
Date: Wed, 10 Jul 2024 11:36:07 +0100
Message-Id: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABdkjmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MD3ZLkgmTd5JzUxLzSAl0zw1QjS0Mjk0QL8xQloJaCotS0zAqwcdG
 xtbUA2JeY3l4AAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

While looking through the TCPCi drivers, it occurred to me that all of the
open-coded register bit manipulations can be simplified and made more
legible by using the standard GENMASK(), FIELD_GET(), and FIELD_PREP()
macros, which also is less prone to errors: e.g.

	if (((reg & (TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT)) >>
	     TCPC_ROLE_CTRL_CC2_SHIFT) !=
	    ((reg & (TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT)) >>
	     TCPC_ROLE_CTRL_CC1_SHIFT))

(arguably) is much harder to read and reason about than:

	if (FIELD_GET(TCPC_ROLE_CTRL_CC2, reg) != FIELD_GET(TCPC_ROLE_CTRL_CC1, reg))

and so on.

These patches do that. In addition, there are a few comment fixes and I
added in a conversion to using dev_err_probe() and
devm_add_action_or_reset() in the Maxim TCPCi driver.

I kept the patches separated by register or register field as appropriate to
simplify reviewing, allowing to focus on one field/register at a time.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (15):
      usb: typec: tcpci: fix a comment typo
      usb: typec: tcpm/tcpci_maxim: clarify a comment
      usb: typec: tcpci: use GENMASK() for TCPC_CC_STATUS_CC[12]
      usb: typec: tcpci: use GENMASK() for TCPC_ROLE_CTRL_CC[12]
      usb: typec: tcpci: use GENMASK() for TCPC_ROLE_CTRL_RP_VAL
      usb: typec: tcpci: use GENMASK() for TCPC_MSG_HDR_INFO_REV
      usb: typec: tcpci: use GENMASK() for TCPC_TRANSMIT register fields
      usb: typec: tcpm/tcpci_maxim: sort TCPC_ALERT_MASK values by bit
      usb: typec: tcpm/tcpci_maxim: simplify clearing of TCPC_ALERT_RX_BUF_OVF
      usb: typec: tcpm/tcpci_maxim: drop STATUS_CHECK()
      usb: typec: tcpm/tcpci_maxim: use GENMASK() for TCPC_VENDOR_CC_CTRL2 register
      usb: typec: tcpm/tcpci_maxim: use GENMASK() for TCPC_VENDOR_CC_CTRL3 register
      usb: typec: tcpm/tcpci_maxim: use GENMASK() for TCPC_VENDOR_ADC_CTRL1 register
      usb: typec: tcpm/tcpci_maxim: convert to dev_err_probe()
      usb: typec: tcpm/tcpci_maxim: use device managed TCPCI port deregistration

 drivers/usb/typec/anx7411.c                |   5 +-
 drivers/usb/typec/tcpm/maxim_contaminant.c |  46 +++++++------
 drivers/usb/typec/tcpm/tcpci.c             | 104 ++++++++++++++---------------
 drivers/usb/typec/tcpm/tcpci_maxim.h       |  18 ++---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c  |  71 ++++++++++----------
 drivers/usb/typec/tcpm/tcpci_rt1711h.c     |  27 ++++----
 include/linux/usb/tcpci.h                  |  31 +++------
 7 files changed, 144 insertions(+), 158 deletions(-)
---
base-commit: 82d01fe6ee52086035b201cfa1410a3b04384257
change-id: 20240710-tcpc-cleanup-61e29124a87d

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


