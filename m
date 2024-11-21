Return-Path: <linux-kernel+bounces-417566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402AF9D55D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF0CB23800
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61A91DDA2F;
	Thu, 21 Nov 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edera.dev header.i=@edera.dev header.b="jAwRt8zD"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2FC1D90DC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229493; cv=none; b=sqz7uNXXhGYi/6QEDCu/xmEurU3PJ4PpBWcQ1OB11pClWc73aTZ1br34KBlTkTQ7Ue9ID2LpeuWG4SGlTp0XnSYdIwocvHqKGSN/gX7vqv34sRBvbPscUJNPMbtyANYW64cyx7V4ZmcOty72/qmovadeDHiMg83XBSF1wbnsBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229493; c=relaxed/simple;
	bh=ssFA86Ebsud+qwvD2MYa+V+ZiLCeYzL2g4M04SUXcw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N74Fj16d9ZP2A+hDt/F3YLfypUb6ZYc2+or7Vhd9alD43XASDcBmXkpNhikCFTL+DKP4FlswQudL0MJlm/KJxow14Ehjq2KlfkUJ/5tmqMlg+TKmfP4EU09ytCexi6WzsnV/4Gt0pXVYtKF1XTnBfemKz1NDeU9Cmun1pJyXmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=edera.dev; spf=pass smtp.mailfrom=edera.dev; dkim=pass (2048-bit key) header.d=edera.dev header.i=@edera.dev header.b=jAwRt8zD; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=edera.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edera.dev
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-718066adb47so818140a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edera.dev; s=google; t=1732229490; x=1732834290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M5KMmAvOf7yexbO07PqanGNRWx1lbfxWV65SvdMYhlY=;
        b=jAwRt8zDX26UOhtIA0NNAMCzMTzQ791wNHU3Wd2G0+eUpGhPGwRHQ7Z64XCpnO2b2g
         bvO7SDvPU05RAlh4LBNqpZkp2IN9Kp240toJY49UTn80DUfOtL2U+1XzgfZK1JzYqsun
         ZJcbmd0+htbuq5h/L7it/dZslsfgNCCA3uWPHjNahDETlW435C73bwaUNm8mjyPF4F8n
         yuFlrk3Owq4lLMKazybPtH5EBj8hKoIGLKmTX1uVqbcbzL8EM6ZNccXSrdw5yKM+AkcS
         ULUeRSSu8PsmNPE23rdJbykqUhdjHwpwjPa5gzgEfON8NOiJd/Ky2jmpQFNh9S2vtLWl
         DOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732229490; x=1732834290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5KMmAvOf7yexbO07PqanGNRWx1lbfxWV65SvdMYhlY=;
        b=i69aWQSNMpMsEmo6Km1+snaKiQASul9Ns8tOOzGnwO0TgSF++CJjMCgPKCSkHZ2T7q
         U9vaVq277fwNOX6+PFOaiQnQaz/F07k776edRVsw9M15KSzLcmHAzgDtOz453BTvJhf3
         2yL8rjO7Sqg6iKvCmXDfq7aWOtCeS0ADoTreEoeYKd0ToCkSrj7lyPbDPilluZCaEiHV
         3+nwHvuKlMPB9Qdt9GTF6M1xKZaW8Mt3v6ho6WrkfjkVceFhXAt8dvQzzouHhbkXpYHD
         wjlFn+oOpoAFZDVJSrPxXo1nM88S6JBYMw/Szoy8O9jpa7d0OYuuoMJ1l5iL2bYZ+gE8
         W3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVDbwP7xZGm+puggO/VLHESX7gNtLq8TeY7wc43sFPtfHSvxhOmuowEEuHDQKx+eZAQRqYvODNjMfv9rzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mWzDizYzurGgyobvAFQR2khAEk5HMu6iowIIYLmu1N3Y+isq
	y9qlBfSZfAySFPktgzFv6HQaHsV6rr/XNLfrrnDwDFzLeo1yTlWvCHU3Q+Ze8ZQ=
X-Gm-Gg: ASbGnct7nvqusegTIUjjGRacF0/iQY/llZco8P9CElgi/vrxBCbTHzfoxGHCzhIHr+T
	UoPJujC5AtLI3/35sWCQAdmluwa0/rfnnEBeqD+KNBsR7LFUAZbYtBFOGmliksTCgp8no2/wTQl
	3y2oSKrv8HBhURDRwLo39HgCMpLmtiXUDrdiBArIgZJtjI3sTWUjN9F9bzNtFUKT6hziKHtUAIv
	XGswwpFxPn8pXgDhEVQXm8HF1hIJomRw0O28dquL/3W0VF6ZrT12EsZT3vm9cpVXQD5YLkOEx/X
	0SRmU20yste7OEXS/jOJHnfTcA9rB9imn0r0r5CDOsBVdvwiYwuUPfVaTHTQ2ja2Yd64r48=
X-Google-Smtp-Source: AGHT+IHRfgZ/zJdkaYat35UYAnjiCdb2X4OLEmzJdr9rSEx2OpMGZ9tm7YvUi1s+NAeKvDBAkLpcQw==
X-Received: by 2002:a05:6358:c02a:b0:1bc:7c1c:9fc2 with SMTP id e5c5f4694b2df-1ca7970dff8mr121232955d.6.1732229490351;
        Thu, 21 Nov 2024 14:51:30 -0800 (PST)
Received: from ip-172-31-19-182.us-east-2.compute.internal (ec2-18-220-54-129.us-east-2.compute.amazonaws.com. [18.220.54.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c3ee43esm4203971cf.22.2024.11.21.14.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:51:28 -0800 (PST)
From: Alexander Merritt <alexander@edera.dev>
To: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Alex Zenla <alex@edera.dev>,
	Alexander Merritt <alexander@edera.dev>,
	Ariadne Conill <ariadne@ariadne.space>
Subject: [PATCH] 9p/xen: fix release of IRQ
Date: Thu, 21 Nov 2024 22:51:00 +0000
Message-ID: <20241121225100.5736-1-alexander@edera.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Zenla <alex@edera.dev>

Kernel logs indicate an IRQ was double-freed.

Pass correct device ID during IRQ release.

Fixes: 71ebd71921e45 ("xen/9pfs: connect to the backend")
Signed-off-by: Alex Zenla <alex@edera.dev>
Signed-off-by: Alexander Merritt <alexander@edera.dev>
Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
---
 net/9p/trans_xen.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index dfdbe1ca5338..198d46d79d84 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -286,7 +286,8 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 		if (!priv->rings[i].intf)
 			break;
 		if (priv->rings[i].irq > 0)
-			unbind_from_irqhandler(priv->rings[i].irq, priv->dev);
+			unbind_from_irqhandler(priv->rings[i].irq, ring);
+		priv->rings[i].evtchn = priv->rings[i].irq = 0;
 		if (priv->rings[i].data.in) {
 			for (j = 0;
 			     j < (1 << priv->rings[i].intf->ring_order);
-- 
2.43.0


