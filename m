Return-Path: <linux-kernel+bounces-364159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9733499CBF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA23B23FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49D1AAE26;
	Mon, 14 Oct 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H1GXdiwb"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5E4A24
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914007; cv=none; b=an+MB181XDKKr8BjdumIDk0pK7hmkLHDvGd5WA1YFDf/8ymaUYhtC4Gp+gj/UDdJn9htFYg7ZRnVOVlDkDypjlQuJXiCCSGFQPAnh1ZVl6fWnWp1lswFgRKrVMB/Plkl0TcH7hgYPFN2AQFWuJXNkprC6bPJpijLOERfyl/ZKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914007; c=relaxed/simple;
	bh=wO1p7F8hTbe6EvNqBYXOiLlzfHpxDRcCcmzq1hS40nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxua01Nf+EHMxornyBZJtstvLInnd8wyRaK8E7TRE1ZeE619PUScsR7Iv52bOE7GVGUbgpvDEpywocHaVS6vkdNYr6PKiTONNG9XfPUVqfgGtI/kQPk6IoUsFJLWiePSpX1+yJPIuX0Nm9zlZuIua46bzXBB0aQ8ib4rF2FhlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=H1GXdiwb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d5aedd177so1963713f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728914003; x=1729518803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TIk4NNoYSacsyCpliVko137LO9s6zdaj7BCOJzXy4w=;
        b=H1GXdiwbgGpQHRFul3DLuub7dC05K0wOqeadaORQ6IiTsfe3mvzi62Wq+p3qZ5htPn
         jr/49aC9t1bkjSBrv69Vl8kNXoQiwL1sfr+oZ0oz2abVZaiCvbKGfz/+cRN483X+yzlS
         +XJRkll3VCw6vcZ2VtioDircp96J6ncYtdLms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914003; x=1729518803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TIk4NNoYSacsyCpliVko137LO9s6zdaj7BCOJzXy4w=;
        b=hJh6IBmWdxCVjisoNgCHp8GSTp2ZsvjlHOT6oxHH4L6jadWFtIvmD5mCfwrrNI0CeD
         zbvqnvw3lmaQ6UHgi6whc9g/y7VprXeqlfzTi7Dt/+oils8KXXxM2uLLNXRqXEdHAFDk
         Li3EwpUyh05rWEoBb3q4DVO/xJMvXHDOGzmRxOXUWulBtcZ+rlOEk4m4CBSY0NzFxPvU
         Kj+G/VCdVYp+JP7HJKsDGWz9v0zA9Ip4uV3Wyf/OZqheYAm3hW6p+4JonApN6p3Rmbfn
         TkmrE22l3hfkYMqryFceRovcmJFbohA8RcmyfkLHHQ8omuqPJV4AczVkdeZFv8O9jDRp
         Dn4g==
X-Gm-Message-State: AOJu0YxlSP716Pcl+jNIe5eJy6bra/D1ABwx2yMv0Pxuv9OkIBFmkH6f
	aCvVinTF+u1j19bubdGZyaajTGd7rlM1oSgpuORJUqfq2su66/mxuSDZxQbEYvO7K0bl7oqRAJL
	P3sk=
X-Google-Smtp-Source: AGHT+IFU8nMmMZvmAm92MZA8kiagzy2/gyT7Zuw/cdPJ3Tx8noMToQdFFFTMB/DFffOK7NOo+jLKdA==
X-Received: by 2002:a5d:43c6:0:b0:37c:cf73:4bf7 with SMTP id ffacd0b85a97d-37d551fca59mr7838791f8f.34.1728914003327;
        Mon, 14 Oct 2024 06:53:23 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cff9asm11404402f8f.48.2024.10.14.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:53:22 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Bhupesh Sharma <bhupesh.sharma@st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] can: c_can: fix {rx,tx}_errors statistics
Date: Mon, 14 Oct 2024 15:53:13 +0200
Message-ID: <20241014135319.2009782-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The c_can_handle_bus_err() function was incorrectly incrementing only the
receive error counter, even in cases of bit or acknowledgment errors that
occur during transmission. The patch fixes the issue by incrementing the
appropriate counter based on the type of error.

Fixes: 881ff67ad450 ("can: c_can: Added support for Bosch C_CAN controller")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/net/can/c_can/c_can_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index c63f7fc1e691..511615dc3341 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -1011,7 +1011,6 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 	/* common for all type of bus errors */
 	priv->can.can_stats.bus_error++;
-	stats->rx_errors++;
 
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
@@ -1027,26 +1026,32 @@ static int c_can_handle_bus_err(struct net_device *dev,
 	case LEC_STUFF_ERROR:
 		netdev_dbg(dev, "stuff error\n");
 		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		stats->rx_errors++;
 		break;
 	case LEC_FORM_ERROR:
 		netdev_dbg(dev, "form error\n");
 		cf->data[2] |= CAN_ERR_PROT_FORM;
+		stats->rx_errors++;
 		break;
 	case LEC_ACK_ERROR:
 		netdev_dbg(dev, "ack error\n");
 		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		stats->tx_errors++;
 		break;
 	case LEC_BIT1_ERROR:
 		netdev_dbg(dev, "bit1 error\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		stats->tx_errors++;
 		break;
 	case LEC_BIT0_ERROR:
 		netdev_dbg(dev, "bit0 error\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		stats->tx_errors++;
 		break;
 	case LEC_CRC_ERROR:
 		netdev_dbg(dev, "CRC error\n");
 		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		stats->rx_errors++;
 		break;
 	default:
 		break;
-- 
2.43.0


