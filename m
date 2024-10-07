Return-Path: <linux-kernel+bounces-354193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCEC993953
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0904F283F6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031A192B82;
	Mon,  7 Oct 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KBDTEout"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E88190693
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336947; cv=none; b=Nl1+UfgU5F/KJp1+pgeCnwDAlqhrhBAWt5qHBPCQx/IKHZvksMEHKwU4keiIhCWflb4VRdd/gROZxggqT2jIjNrHQbZV4Z7l2pGktYt+G3eQ/VxmzIcmI1QvnFV6frku2rUiBWafDXTeU0CUbDVwFriI981MGKUfxfu/tkSeJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336947; c=relaxed/simple;
	bh=+sATRWeawQEUv1+UCi+L6joXgd2sN0KH+RYIISQm3Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZmA31t2j3tex+U4/TGwwJ52VBeS/MYMBTvqVv30TYlI1cJE4KxHpluaHh/Ce+BIbdpBKkwjBWDPX7b+omwnTp8t18lZlKTUs61OGEFv1jChPiaRkwO4QK6xgu+ezBdBRODyNqYKUl7Mh9etUfVMYptow/YBKZl36sNicvfExik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KBDTEout; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ccfada422so2985449f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 14:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336944; x=1728941744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47ahDvpGlziX1HY/1UDQ79MexuwMxPJ3vAc1BGnN1yo=;
        b=KBDTEoutuH29YwT8WzkPAPKLJDUG/cjK6Om9wg87AHH/iCN0MdpwPqSE1jUWp7c5lV
         Ogl09k/IknswIFe9HVxXuJM1mwSx8AO7ZFhZL82naqyzQh0hJxR4slCSyLG2QYr50LYE
         bR6a4cqcN2PVsCc1Oj3vCt3/dggJTpGAkvp5qmtt0trGXDCsbFgIYx/AICFp/ULLkfDh
         gcJwBOXbwHjGIyrxKd38HoExOtW8O3k9QDl5TCJO0H0WyQ+GabB8JqRA5KYilnjHAPnQ
         AscpjjwKI2w0gn2UY/awN/vI2fT6fBQtUqs4gO1/glHtJW5gfjJpM7pPgIUZBF3hNNiD
         7D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336944; x=1728941744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47ahDvpGlziX1HY/1UDQ79MexuwMxPJ3vAc1BGnN1yo=;
        b=beziIVLQCY0tic0Oti+iYis9WBgJYVfe4DzJBXLvzudCxqspr1MlQ5SmRGWMK3550U
         8Z1pc6mvxHx8BAvbG4WGjquKoIXvNQSjmgvsVXwAkn3kIdCdV3QOBLYy3IX1b9x554oB
         cCDj5nlvAOBEX9JJ72PXxej0ehSC4gZyBqNAKkOaF3J3ebaKLtKBXNEExA+Kq1gy/smg
         IBe4PXrDxG21Gn05gHaGQ+x04fNgwt2twjpeonq54WLZnld7NWI/uftEaOGwN4nMZNIW
         JNu0numnA7bXeqvpZz4kd4EO3aknW4G8MDBZW5pc2gG2a9dPgAHiDyBnhz+3lIGlO2ae
         InHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4X7pn2NpbHfSphoUS2KAYS/PEP5HdJKFGKiNQnhBylpaRy7hPKv4VZqj1TYDK37sDT2mZbiDyahyvUsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUABpk4MsV61QHjwGZ5PrP+VOBxMTOibUEW4lcF/JIzhxNxml9
	BUxcJMgAFTtwxXqqgY/KQVtC1sPOCSrLGTzEz8UrADJ3w6d9rd9mRoiSs3RYUVA=
X-Google-Smtp-Source: AGHT+IEh2nNtGTy8ZHuRwyExnrSdxDBOaaRu0AmF4uU5YudljkVsFMbPD2jmqiCN6O47wxbJKhk2fQ==
X-Received: by 2002:a5d:4d06:0:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-37d0e6f8eccmr8676059f8f.14.1728336944360;
        Mon, 07 Oct 2024 14:35:44 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:43 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v2 4/8] Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
Date: Mon,  7 Oct 2024 22:34:58 +0100
Message-Id: <20241007213502.28183-5-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241007213502.28183-1-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_sock_alloc() attaches allocated sk object to the provided sock object.
If rfcomm_dlc_alloc() fails, we release the sk object, but leave the
dangling pointer in the sock object, which may cause use-after-free.

Fix this by swapping calls to bt_sock_alloc() and rfcomm_dlc_alloc().

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/bluetooth/rfcomm/sock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 37d63d768afb..0d0c4311da57 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -274,13 +274,13 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
 	struct rfcomm_dlc *d;
 	struct sock *sk;
 
-	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
-	if (!sk)
+	d = rfcomm_dlc_alloc(prio);
+	if (!d)
 		return NULL;
 
-	d = rfcomm_dlc_alloc(prio);
-	if (!d) {
-		sk_free(sk);
+	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
+	if (!sk) {
+		rfcomm_dlc_free(d);
 		return NULL;
 	}
 
-- 
2.39.5


