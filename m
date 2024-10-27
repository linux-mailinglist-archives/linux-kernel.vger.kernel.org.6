Return-Path: <linux-kernel+bounces-383670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C049B1EEA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FFE1C21399
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BF18EFF1;
	Sun, 27 Oct 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmyvdMz9"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB918DF99;
	Sun, 27 Oct 2024 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039847; cv=none; b=GKXBHTi+sRWFXOp9AC2YEclC6Pjnt7ZBLSG0DZu0UpyWSkfaytxEbw/0h01f1wL1mxUjjLqvihlwqnaX9RALYuXp1W1IdbZBGLJccO5zRo2GIbGIRjtU/vQLIhANfn0/jdYfK0oZ/uOV4cvT8VxVJoESfVAItyxw9JGi7aLKKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039847; c=relaxed/simple;
	bh=UZLPE16D0SvePE3euTy3VpCrt5OIv0VVP1ed6bJKKY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fk44DTGOr2jRqguWmGKSvcJyYtwClM1Rp8gNNwpwr3ZVg41qv4I0A2aVNNEihSbTNw/wD6jdqPqo0YH5JMgnpxT9HPnXRq4mhWdkWpDCIFr9MLLBigOJx+pvXlW3KW2TtdQJkU4KS4x409NKOGCFzWl8qZTju4hBxVQAK15lxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmyvdMz9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c8ae7953b2so623924a12.2;
        Sun, 27 Oct 2024 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039844; x=1730644644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALQ0G789yX2QxWgAeZU696rjb10RRbMPX63KNEkpfwQ=;
        b=RmyvdMz9pE4BlKo+uHElk/YbpCi63mh8XI8Op3Wpa1cfOnKtNBk7SNjjoh/YyAyPhz
         vqMe5TuV8/UYL3LbIK2clqnwhRTXr99vXhqGYTMJOnkKUwWTDqTwRO/JdfDAChKX3+a1
         314OkeZRyOocl+gifdtlkkU2OxtARiLoAfx+PjZ5FaDIjWCGXRkP4ExdQiPh9Xm3BUvK
         IINa6P8IksS4HarjE0Qm4gYG2dPRa6Mc9UWjYvDtCewORgatwD4E/XaZ8pC1wvz3S3if
         eE5pWQ8lgk2XgURrAW9NWTzG7nvjqs1NRuzza7bYLauzQorZGv9EKZjKSvZZiBcU/gwb
         MH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039844; x=1730644644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALQ0G789yX2QxWgAeZU696rjb10RRbMPX63KNEkpfwQ=;
        b=jb/XEpQ2ISpo0FEm2eNuNCh/TO2WrwAm+J0JubqKumioBHVZ1Sa791IozqFYsZl4QJ
         Wlb7IFJQ3zUYBCUGlqm9vMTjNtkRvwQa3ABpA/LTM3OLeYFVBuy+mt+JXvrW0M1RQhRZ
         bCsyFAiLDYglSPUHljRWz/DEltGtm/Bavi6Yo09oyl6Huld9YDFS25Ol/sM/yx/H7Udp
         w1tHJGtNM1tSk65VxcI2UDQb/ICF5sEp8Wj6QvaaOozPsOHU1v5iAN9kaVU1b2VQKKwM
         /p80wTnp59Pwf21Vl2r0nIxQZ674+5tgFeLysOOI0x1TW6WjYK0XuKyAWma1cU8ffkMU
         0S5g==
X-Forwarded-Encrypted: i=1; AJvYcCWVxvd0UeAWuZ5TRZhzj+6ConqfjQxEZB2zPlnmrJVrdkrrwcKQd+fGyJ/51KlG2ax+4K3jVXBM7Fzz/1mn@vger.kernel.org, AJvYcCX5vGc574bcpfb3W8xTc0+ZocxCyAW9gDfUtw+U0wYYpbw1hXr7/8dambn0tlJY+f97aElC7faiAHuz@vger.kernel.org
X-Gm-Message-State: AOJu0YxcQDl8K0y1IZwL8nlvIfipTAr47yTevqJpgatsHZv4k3RQrJ1D
	b3OYd6jmai+WPMlJCxWrZH0tdjk/NqhVwdnkqWOf0dkrSmM36EC2/6mBAA==
X-Google-Smtp-Source: AGHT+IGjqquI8ZNdsFeKNYPmZEsrSLrcDXSdm7t+N2iyw0Z7lQDHVB4spIwQE0rg/a9q9n1Y9if9oA==
X-Received: by 2002:a17:907:7d89:b0:a9a:3dc0:fbc3 with SMTP id a640c23a62f3a-a9de5d0ad17mr204017866b.2.1730039843860;
        Sun, 27 Oct 2024 07:37:23 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:23 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 21/22] dt-bindings: altera: removal of generic PE1 dts
Date: Sun, 27 Oct 2024 14:36:53 +0000
Message-Id: <20241027143654.28474-22-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the binding for the generic Mercury+ AA1 on PE1 carrier board.

The removed Mercury+ AA1 on PE1 carrier board is just a particular
setup case, which is actually replaced by the set of generic Mercury+
AA1 combinations patch.

In other words a combination of a Mercury+ AA1 on a PE1 base board,
with boot mode SD card is already covered by the generic AA1
combinations. There is no further reason to keep this particular case
now in a redundantly. Thus the redundant DT setup is removed.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 51f10ff8e..1561f0164 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -31,7 +31,6 @@ properties:
       - description: Mercury+ AA1 boards
         items:
           - enum:
-              - enclustra,mercury-pe1
               - enclustra,mercury-aa1-pe1
               - enclustra,mercury-aa1-pe3
               - enclustra,mercury-aa1-st1
-- 
2.25.1


