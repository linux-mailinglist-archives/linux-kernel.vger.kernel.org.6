Return-Path: <linux-kernel+bounces-426922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463439DFA1A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B3C281B76
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC561F8AE5;
	Mon,  2 Dec 2024 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6supe+h"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EE2F46;
	Mon,  2 Dec 2024 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733115762; cv=none; b=XyNeAZiddLa/uwTaISGY4AphniR+FqqoGRlIhzeXQytZFByShyS8c0c81zZK0Ln+ZHfGSo0eF4W5QyHU9liXyLHjLMgmCNYO1eX43KUGZ5X7XbQs2qqeBV6Dr20Tlx5WCqh35cwWHIDRIETGGvsXzdaX1/BYjjhjnha4m1j0p9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733115762; c=relaxed/simple;
	bh=4ikIEsU+W+e2hoO7liGbdu/DYueAPavkn1wiJrMa2XI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mHBUzVaqx6cYv3NxJxGDc1Bqr+RGTGm2ZCMtTct4Mo+vDiV2gP5apoG44GEP0RHgN6xMuXeI1ErHAj8F2J/KFaUG0TzbVViCh04720545Fmqo8CCwTeneJq0Gp52FUO/ft6NhTcKnu87cxwIfgUJsUE5OGf7jPmqpfxLnMuMR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6supe+h; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so3091717a12.0;
        Sun, 01 Dec 2024 21:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733115760; x=1733720560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+j9IC5yOXv1JTRyF5XSayRukRHAqen5dl9p7+tZk9ho=;
        b=C6supe+h6ePoU8YOWc52SxjCyBSZALTB5ixociVF2kDNMxnL4BMCb3vFmlgjRT0UuJ
         QhSCnhE1XQzmG+LF60OEOpT85z4vg+FsDwUnXteNZgFnar+H+SgueVj9fNIXRD6QRdId
         XtoBHWac8suCgUenRJnnAKpQdeZQQj2duoYX8WRGSg+JV6P7WZjzeFT5TL1bwk0tPKwg
         Ra42XefQ70SRyyPTY5xXtrMDkTevf1MmjTmySBjS7OqKPJuLANFs80FxVJnMubFU1sDH
         MDvhl1HOiDpsx/ez8WWOBl35suOpEedDPoT1u1TNDaBOl9Oxtz0lY9k9X9XxOB+0T7Fe
         0/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733115760; x=1733720560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+j9IC5yOXv1JTRyF5XSayRukRHAqen5dl9p7+tZk9ho=;
        b=vdMugEodfEBGMBvlKlqChJh/YPoWaMLFUFzUKjyXHR6guO6Bh2PpJW1FAjIyb9Jour
         TzJlceAjTRwAVKOBY8tP5nyNbCXfnCK3PU1jzzkHx5KxnjKKy0QRNcfD8W8UYLlSdd0y
         SYT1PYXGksiHIVelmatEEhslOy4TaUnMmSfjwqr5YYae9O31Y3VNUSr5bv+wIFMWWmrp
         rpozIxYtIGO3HwYi6zP3upYV0mfJeSe9nrxUZ2n0rz+StkjhmlbLpBQwUB4WA10kI0sW
         O1qzyXf3NnAulbRnccRh0tM/rQ6o+Ta9IoulEF7m191FGEuurznSaVUI+gsb5TyGJzbj
         POpw==
X-Forwarded-Encrypted: i=1; AJvYcCU2EQ6Q/w5WaJPKQhFnrpkHxjMyVZZbUNpgcbCsMwnYgUgt8j21PzUzy7vOVof5bTrmgFXwukCT9MGvsuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5xAbF7LRSxn4zCf6YCaUm97wJsJpGEG9vy0kBkpO7bfHsMLw
	w5Wg9XHqf71bL0St9F/AZZYVCvsHzo8FXEhKfe0BwkXusTiEdxv5YRpJ+A==
X-Gm-Gg: ASbGncv9Yp3ZVkIQzP9Ebvd98hAcROaxViyRi2ZhdChLdLqyQBQ7CdX7ES0bn8GqevI
	JWA9c3pp6slpu/KWWrOwrzulZ8Ok4X1oXJap+RmcTRazWq1VImir3m2GlfuTTZ//O5X2eLRGvmz
	Xhc70GABzoiNwVaG4rHmu6OhIjnoQfov2nrsksnOmb8jIhh3pyX27JgNYJmgk8DfVaCKj8Mkwc8
	50XJglWyY+G/hJl97oGIVISjYjxaoXhystucHBkeU4Dwc/8Nx1goDqZL4j5cXJjC37KHXTVj38k
	K9Lrq+TW4IZ+sfhwnO5zzh2quDvI4SRqUWBa6XaGLQ==
X-Google-Smtp-Source: AGHT+IH3vryCaeBX4bRAztqst6zuSkFgqnrZnOJcXfAGJYfBjOBQKYZ2G16BZgOarv2Y6NbHFRUv5A==
X-Received: by 2002:a05:6a20:6a28:b0:1db:f01a:cf12 with SMTP id adf61e73a8af0-1e0e0b5cc80mr32083457637.34.1733115760456;
        Sun, 01 Dec 2024 21:02:40 -0800 (PST)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3034c8sm6844302a12.31.2024.12.01.21.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 21:02:39 -0800 (PST)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com
Subject: [PATCH v3 0/1] xhci: Some improvement for Etron xHCI host
Date: Mon,  2 Dec 2024 13:01:34 +0800
Message-Id: <20241202050135.13504-1-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent the xHCI driver from printing a "Transfer event TRB DMA
ptr not part of current TD" error message when an error is detected
while processing the last TRB of an isoc TD:
  xhci: Correctly handle last TRB of isoc TD on Etron xHCI host

---
Changes in v3:
- Update subject and commit message
- Use error_mid_td instead of last_td_was_short to solve the problem, as suggested by Michal
- Link to v2: https://lore.kernel.org/all/20241028025337.6372-1-ki.chiang65@gmail.com

Changes in v2:
- Modify commit message
- Remove XHCI_NO_RESET_DEVICE/XHCI_NO_BREAK_CTRL_TD quirk flag
- Add XHCI_ETRON_HOST quirk flag, thanks for the suggestion by Michal
- Check device speed before invoking the workaround
- Add (xhci: Combine two if statements for Etron xHCI host)
- Add (xhci: Correct handling of one-TRB isoc TD on Etron xHCI host)
- Link to v1: https://lore.kernel.org/all/20240911051716.6572-4-ki.chiang65@gmail.com

Kuangyi Chiang (1):
  xhci: Correctly handle last TRB of isoc TD on Etron xHCI host

 drivers/usb/host/xhci-ring.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

-- 
2.25.1


