Return-Path: <linux-kernel+bounces-435487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781F69E787A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6ED288373
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4027206278;
	Fri,  6 Dec 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="AaKeSLfv"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6D204572
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511650; cv=none; b=NMJ+cVDmYxO1wjHS3bCqGTDW7D6CzGnj2EZ0FGX2KIXNGuRm6io7J4t3D1wEbW9mqGLyXf6FX1IyBbNaci4hIvn22tFluR0zU2q5DkB/YFmj7ddXubAK1RYw9lBZtCKdmwH+1ygqH6we2Et6hl4u95ZbjAO/G50y3xaRErV0nH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511650; c=relaxed/simple;
	bh=KWMNtKFHSXqIJRHh07Fhy/LOB/evmZgba6wRNVyYg70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=br19pOYnsN1vV0rk/T3irK8gSD8iQTc1/6WyVnjDWAHTRlp08HYgWjoO1zyRvO/Q9hDIrfeXuOxpDjUKSnzkmuJXHcl3pDvRWnhBQN2pyCxlDrPWa/+oSP46+8TlENpqtTyjjmSklS8PuaW6P+VI78E+VGCMWsYsROjy4peYmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=AaKeSLfv; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffc80318c9so20763351fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733511647; x=1734116447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2QojkySpM8U2FoZ7dctDq5YFcwKebuv3WnOzhKxOok=;
        b=AaKeSLfvAuYARQhOkn8ve0wlftNC3sC4ypk8JATHhwRbT06adA4sEHbDxd8YS3B28S
         mghGDaUCR1vHjKf3lrNzzBaG+NCBEScUvZg66xGYtsvT45/np4RPkXpjqEGAAMS10KHz
         hVg9pkvb7tNwTcXU9fYL07Sas/g9B6ndgGwZa7Oc6fBpOJlhVQrTYfPgu9fLhzqr/0SU
         7HNZHM+Otz6zC5l/5D3MMxPhh6o1koCSubufpkIZ6W3Od+as8eM51326nZlXRvmP490p
         J0gdAQHgQ+6fc9TyfKGllHvk6P1/GJSIa8Oi5OL/gKPPmt5JsmSucpte1FmlZSEtOpED
         KtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511647; x=1734116447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2QojkySpM8U2FoZ7dctDq5YFcwKebuv3WnOzhKxOok=;
        b=rcX14tkKGdRKo+/xyH2YYqM33kLp4RIwVyvs5lcx0+4n+ch8fxiBasCsILwr0OqWko
         dsobX63FFh60pphQf0rVpRZAChvE+tAzZItDD52+JbFvHK8vw0SjxeF/5smX7o4cP2nv
         ncqrR6IuKiAI2pAHeFe0VTkLNZ9QuTiDt9DIPyiSa/UKoQDLdX2r2e+npcbXxsaEn0E8
         Iz71U4/+Ey9RhJp1UcP/4I/XHBbxE7iTEbBDxRNf+xa5XniWPsWZ1EWRrb3VLbKaoQwZ
         otTBloNzhVhRb0I38HLklBBFTsUvFABTtUtc59FSdwmG8LSMYFt8aUKErr9udHs3eqLs
         chRA==
X-Forwarded-Encrypted: i=1; AJvYcCXRXAsEognjPMWruU8sXUOJBIZFZw6ibFsFdaArt1YmTg2RUtp/XSYJQiKZdhvgSw/a/WmhRhmYPh/aPIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY3Vncb7Xjkg9ZFFRJuZipJPTetf/BuMSUJbIkbT9Tx/wn8P1u
	x46AIpnajTI5pSmGV1jmgYZYb3lXRZZcf8SznYmCk6EEGYGm+mNF8btfST5Phq8=
X-Gm-Gg: ASbGncuCbVC2/y2pqpdojQtpj5+zXbhJtDalxYpd1O1NEI93C4P7XsfWdaRUmfdtvuH
	Ivpa/xnz7cU1noxciUrQPRxr7iSATHb13A+jTGK0L+aNoufNJv0pG3CaiVPd+fsb2iM1k0cdtX+
	MTgXHb2RaTaXRgP53NiqIIPbn48jQaxigejpCzfXgyUvsdeAxqruYzCZE/hlkDsQ2TZA6rUNcXf
	0StKppsl9aVEBlAXL6BxCPLBY+GH0Pwj48Ly9HMfCOORxmSBnFlyB6eqO0d/QYd
X-Google-Smtp-Source: AGHT+IEIsm4wQVX3IM84rN3fxaWi6YpUjvzeeTe6nAk1y92eqqKLDaXUQfpaQtMa2bkKEiL1wi3iHg==
X-Received: by 2002:a2e:bd14:0:b0:300:2278:9b1f with SMTP id 38308e7fff4ca-3002fd1b175mr15585421fa.39.1733511646671;
        Fri, 06 Dec 2024 11:00:46 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e58200sm5523201fa.113.2024.12.06.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:00:46 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net v2 3/4] net: renesas: rswitch: fix leaked pointer on error path
Date: Sat,  7 Dec 2024 00:00:14 +0500
Message-Id: <20241206190015.4194153-4-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
References: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If error path is taken while filling descriptor for a frame, skb
pointer is left in the entry. Later, on the ring entry reuse, the
same entry could be used as a part of a multi-descriptor frame,
and skb for that new frame could be stored in a different entry.

Then, the stale pointer will reach the completion routine, and passed
to the release operation.

Fix that by clearing the saved skb pointer at the error path.

Fixes: d2c96b9d5f83 ("net: rswitch: Add jumbo frames handling for TX")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 800744a6c25b..9c55f3480678 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1704,6 +1704,7 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 	return ret;
 
 err_unmap:
+	gq->skbs[(gq->cur + nr_desc - 1) % gq->ring_size] = NULL;
 	dma_unmap_single(ndev->dev.parent, dma_addr_orig, skb->len, DMA_TO_DEVICE);
 
 err_kfree:
-- 
2.39.5


