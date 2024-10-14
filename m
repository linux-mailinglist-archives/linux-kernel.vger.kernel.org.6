Return-Path: <linux-kernel+bounces-364357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095B499D3AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33A9282E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151081CCEDC;
	Mon, 14 Oct 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gHmxVmqE"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A71C9B87
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920321; cv=none; b=uGyOpX0/0FssuzeQDPjj5P/5/l3lzlZM2q4UVWFWGsiN6PVjNcT9fIJVRc5VUEqr2dgWoRiBo8xl+oh5Kl2aU3A0RGNlExmK2UGmdEOzdM79VOAA4c9utE6B9iO45Kvwjpxshg9Gwuhiyt2PQUczfr8IDEbQR6HQc700o17Wwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920321; c=relaxed/simple;
	bh=tpRnxtvyDHesMuGsYGGagBR2XeIwxtaApq6sfrvnYrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGN0R08nHI4IxfGRHODXI9Rl3pm+ZDcZBPXOpABGpWoQA1cxOMVY0n8bUe6YA9WDQP0H/waEjr4kayx4Gx1lg0WFrwsh7CCA4u4TivCRSZPQFadFc/xsDU8ID7roI9h32fNThGvqiOL5B9ZQudOPMLrQmHGEPOpc0GlUuHZl5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gHmxVmqE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so2737386f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920318; x=1729525118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRdyGf4lfZr6TznDuyWqYCBTl3G4Nizl8+blfyYvkoE=;
        b=gHmxVmqEAq2H3WSZdMhuCmkb7TtWIvdeoxB74oty9UCExauTw/LyGcw1zxvAxXy+dl
         atl6R+YmvG/iOTONZWptqoYAvtsk18MOlOEoxma5Wm9/yUeJwdWl2m7eHekbakfFlNsp
         3WRnxaf09V5yQcY4IoY6C+Cn9sYW+fDiuUm5RphdLf0PVLs2lzP1O8RgC/9rKGMfn7MT
         V6zcXMCuSi4hB+mipouR6I9AqQY03la+55wgk4ESopEG5IFPB6HGn4BzXSeHR5OS1/ef
         25NRI8f0N7QtIu4fS/wpbbzKeoqkr8TXRr5iXDmJam0flodQyZ9ydnUGbxvSGqVh0tS8
         iGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920318; x=1729525118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRdyGf4lfZr6TznDuyWqYCBTl3G4Nizl8+blfyYvkoE=;
        b=gZqn/HD/PebxgK4sFgu/ukiLpd806BrBdTTh08qZzWGta7a9I05RGzJ29hCQEc8gGd
         8OpKbdgCmTGFsdAhzY7K7hTBDY5CSC1T7GBzxXghS9EMqim229/dmHoF/y7fycpO2o3e
         f/v2zttUt5W8fRkCazxAQlXU1CIJPYQR313DnmGuM5lQTmuxKFWyyTwK5sf905BIPELG
         BpiuFVr0KLaBAJPxAmxw5/nsd58EsI17J6yt5dmAmeKO7yy4F4cVLBlenGEZTog4+9us
         hW7umnHVIxBkjGUq3xWGP7rrScsFVtGLBlyr/H6EpB8lKUMfl8aBTKPbkgAD1Y0OFoYB
         8jSw==
X-Forwarded-Encrypted: i=1; AJvYcCX2x/H8ThTMpE21OFnb6G1Yk8TEVmQh5Iij7Kwt6xaNu15JoHA5gtZkGNzKLIa34eS7NMXsgV4YCFLxtQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOpWs5XVeKHszF0bLaSUfRo2xPi9wQZaa/fvdrEKrTN9kVfPj
	bgGWjiMeZbN0ShXGYifgydnevCBcTgVzvQVDWvFqGAgs3n8GseUQeEDAibO3SuQ=
X-Google-Smtp-Source: AGHT+IEvSESGNKtr3mfQllscjnvWPixVZXXYDJK2VErqCT7tUm2cqjBB5hZh+pW+OcOgTVIOFBIPag==
X-Received: by 2002:adf:e908:0:b0:37d:3def:2a82 with SMTP id ffacd0b85a97d-37d5529acb1mr9092817f8f.36.1728920318048;
        Mon, 14 Oct 2024 08:38:38 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:37 -0700 (PDT)
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
Subject: [PATCH net-next v3 8/9] net: warn, if pf->create does not clear sock->sk on error
Date: Mon, 14 Oct 2024 16:38:07 +0100
Message-Id: <20241014153808.51894-9-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All pf->create implementations have been fixed now to clear sock->sk on
error, when they deallocate the allocated sk object.

Put a warning in place to make sure we don't break this promise in the
future.

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 24b404299015..9a8e4452b9b2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1576,9 +1576,9 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	err = pf->create(net, sock, protocol, kern);
 	if (err < 0) {
 		/* ->create should release the allocated sock->sk object on error
-		 * but it may leave the dangling pointer
+		 * and make sure sock->sk is set to NULL to avoid use-after-free
 		 */
-		sock->sk = NULL;
+		DEBUG_NET_WARN_ON_ONCE(sock->sk);
 		goto out_module_put;
 	}
 
-- 
2.39.5


