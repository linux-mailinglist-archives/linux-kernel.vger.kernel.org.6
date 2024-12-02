Return-Path: <linux-kernel+bounces-427633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49B9E03FE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EACA166E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9A203718;
	Mon,  2 Dec 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="Hq3T9o5Z"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954B202F61
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147372; cv=none; b=Uoly6SiZG2Rpm30r+/fsySZYvKTTTaM55MfHs7vt0fOoHEEEmiFJscr9EI6mDa5ygkmznzcQTEsGUmaJmX7DzporzvYOtBEpLCTA88ZrOk39kYuSN+rzSCpvzntayGgZg8IlCB5Sp16by0T8mWMTAdumAe4teuEYhZrp4KgUBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147372; c=relaxed/simple;
	bh=ikLggKYh0Un8afUAvMUCGvNq/h+HGVzb6q6YC7Oxa3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUHPMr0CeYqdXtXRvpbaD1tAK3qsgYCL83LX89sqKZHByS82lxzzJXoCuKZBrtma4Jpk4Zs4vniKgjN8sRWhqUxDqwT0wrR6rg/DU+0EdWOItnjBf/rvePSzSXhM6UE+ZwLQW5UjBA3PJa4Sgf4osVQ4k2g2opi5nKF0e0cgfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=Hq3T9o5Z; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffe28c12bdso37824841fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 05:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733147368; x=1733752168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4PkmDMX0LCsciSdEuZzJRFJdqj1nfUT/bpDSGbr0kc=;
        b=Hq3T9o5ZO8J/XNIYur/Mmrju6aQ+W7TP1s6nkkl+uuMQYSvzGImfNbnr4pyur+Z7TB
         2Tfacnc3UObebZLIykraVC8fROTkMBbk0WxpSPlXDF9vqggZx/NAYHXGijxWQf2mfFqB
         y51TLTKjsOUUdln0rF453qR0OU9A82yjTuH2MbmHIujPOZ5Os9YPDT/7TIZSNs7uhXrl
         GQyRg0zfdONLZNjWMiO+wNAl51t23mFnZ8K6Onj1Ixhx1p/nK00fYGi10hgCOZoGtFWF
         AyuqD5Whz1QqtORL+i/dNpZY4bEMA+pAm5qVckSJn7RNiyIpcoNDp6Js4cInKNajIGOx
         b9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147368; x=1733752168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4PkmDMX0LCsciSdEuZzJRFJdqj1nfUT/bpDSGbr0kc=;
        b=wfoPhu4RAByGuHimwLA30LGnI0+82leEmKrO8h4IGqhjZD/jyWxrWUAQ+Fot1YThw8
         /t6lKHsXL4Lmy3N38PrlPwMLjVKa8BSEFJxvjKy6D6Hp+RNCRjH/zXH9oT91oby+Qhbe
         qjraoMa4QlM3pm1XMhInXWlsv9/3tah08gS8clvAUhzkQworyf7hABektBdlFxsWSa25
         nDgTWPDzZLWWXP40sX9fspuk9spYSw4r/5pFB3XM165dUc7I2HTW70hF6r1dx6M4nOH1
         NAPun+XMYrsEm6UfRtwzOSkMf/Q7spn4wQOnsT0eQ34tMRPkLoiBTpJAb/ZajI7b5zES
         Sx/g==
X-Forwarded-Encrypted: i=1; AJvYcCWsiK4gkfsLQzZvVf3nu19SVfyGDB18GndAA/x94mVcsdILoRb+ckjrNAvLRJSRpyzlWUw9OSj7qzX+l5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwr66OdwvwtH9kYyoj+yH111OY+n0boEflBjIybYDxkNENhmR
	wPM6ss2ETtSsozqdWT+WaoCck2HGwyj0c6gRsq9bDs0Zo7leeORAmIjAIKsA7tw=
X-Gm-Gg: ASbGncuw80Rucxy76Y5FPxIcVPP2I0cexcbKrLDYECgoKG8ozoT+sTkgaOMIkqSrLlX
	ZEltLdf11aE/vtIgUL1JanmDPFSJYgKAdpHWgRhUME+tWnO5cN8ZqaoZNCK34YhqGu8LAW0NtLc
	7AFrNBF3IbIHyHHQAemdgtfvk+jwjp1fAWuF6guSB3dKttaC+oUQpo5dloSql4jdMDdVZBk0c5i
	iRLnZDHEEDZTrYzGI2UUGM8uF6KQMPjPtqmz8buJK9cuvNekR695meSB1E6we0I
X-Google-Smtp-Source: AGHT+IEsaH+gdxnFkWmsXqpHCD1Zei6m+iH0fYiLGHgbg3pVjQplVpLyAye27YVe8QxL4WzDTSyj7w==
X-Received: by 2002:a05:651c:2207:b0:2ff:566e:b583 with SMTP id 38308e7fff4ca-2ffd5fff0cemr104563321fa.11.1733147368492;
        Mon, 02 Dec 2024 05:49:28 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f2csm12972661fa.15.2024.12.02.05.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:49:28 -0800 (PST)
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
Subject: [PATCH 2/5] net: renesas: rswitch: fix leaked pointer on error path
Date: Mon,  2 Dec 2024 18:49:01 +0500
Message-Id: <20241202134904.3882317-3-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
References: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
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
index 32b32aa7e01f..3ad5858d3cdd 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1703,6 +1703,7 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 	return ret;
 
 err_unmap:
+	gq->skbs[(gq->cur + nr_desc - 1) % gq->ring_size] = NULL;
 	dma_unmap_single(ndev->dev.parent, dma_addr_orig, skb->len, DMA_TO_DEVICE);
 
 err_kfree:
-- 
2.39.5


