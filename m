Return-Path: <linux-kernel+bounces-542977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49189A4D018
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB587A65F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935AE1F418B;
	Tue,  4 Mar 2025 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Rc8tkitS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2E1DAC92
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048488; cv=none; b=sdoDGp1IVs9RrsF6N4FLWnX5TozgjPgmsuisoL0CT6asw/ukys78J4uBSXn1d7DMieyRw3ZBxNubZgrTGBkyycYy/DtYmJG8H+2Ru6WMUKcJw4yLqSt+HHUdQik1ZkR5fBAM6VBNpQY7sywz4FjLCZloyOJMLYeUw552opzYC48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048488; c=relaxed/simple;
	bh=aF5BBJtGK7zOPdCppoubtothgTVc6dxPQzN+2KLtopI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqBI+8fxOU4KpcFjDgQtBAsAU6kM3NOgv7YQi2ZDr+22U/NS9TPC4c3S+OIo9B8egmBVMPtmzullPFIPRGv0lWJK79qle85Vn8MZDdjMf0e770Lmmz5fKfgBgcb5y7igJ3z4IhYqxcksLSB5NfnDYRFLi65nbrVnfITM1DqdIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Rc8tkitS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso32792855e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048484; x=1741653284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xphQpLgE76ewVr6j96fk0evfpqIkE/eVTNK7+FNJuuo=;
        b=Rc8tkitSZanQcJFdU79kV2F/OcXEKgQTXHKq3W3x70oBhq8wbwAY2wQcHR6ybMnFm1
         xO2KZGtqtqFdMFBtkoEZWWpQgcGBGCJGcxaWc76rs9aZ6YRkkq1Cz3zB4NKHa0y8dC/H
         AewSvGV/S7/IElsQZzY92u3u1teQbHxKisdVTWXMy6jMHORE0xfDdKuU4yiDJTTmkNAQ
         2LDTTeXFqOl3914gj0f1OfbFLBW/vdWF2+TPparQgDw1V/R/MdzbsFcYFl2aBL3Bt6I2
         G6cNrozASZQEd8XzD0F7RN/QpGN4XnA1Z+lhrEFT29muFurDRZ++FiHsmehK6dSQqh+B
         al5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048484; x=1741653284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xphQpLgE76ewVr6j96fk0evfpqIkE/eVTNK7+FNJuuo=;
        b=ZkILHg549i2ZlTba5x4cD4haUK1b1jOiT1PpOjL1+5yhZXPT9tGedjprtsFvBORU8e
         uHmQt7tdEBaiJWKrW0n90Kru97N8TjIiyhTRNhcQaqiuIechfEOcJ60/BgnRqUI19yTt
         /HAYVmCFu/JS8M40jBtNMXT6ZXlJ9RdrNK3HtDC6z0w9gFrr+WqGGO30tmkoEHKOJne2
         bB2H2Qc+Xh6FqUnHOtoPVZblWni5YW5Hiu1HwM8x7CmaWf395mksSU0JhA0Hw+SDoRR8
         AHMd6OSzHjE9AwzkC9xOqMhlXRskxYyeO3+7PWEvp24CHAdoNYUkS/lwjEvrthYrbxYM
         HfgA==
X-Forwarded-Encrypted: i=1; AJvYcCWm2tPORNeiOdd8rdzAP56LGL16gPZj19Jo2yAFJcgFuG1jnUPfikgWFtVCi8IyG3EwY9aWrkKeIpKrV6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0A9oLG/689+D5rH9G/6t0dr6Boslrj81thrAvu9le+72OjvMn
	FjsM7zfdBezbuXjeChzLxipMOfEbW2Q/J2Vn00M/+TPGCJboi/60v5c1RU8tzeM=
X-Gm-Gg: ASbGncsaBghgoroe4109U1GMgrk9YNU2AvjV13pP7QNLmZPbxJPWEBLkZrsOV176tfe
	gdYVOPoE+dB7Ik3XPRsiUqad3MVw1cSW5iadj4mCMPjy/YCztpDugYgF/euhbrZQSjAkdpzhu7A
	jX2mD9iigi6mynSsE+8kilHGvdu8oeRPXx492TE0Rgc+nZCTVJcOLhSN+7UxzsD2DeqDh8dcpPt
	chEPsI5BCO8fcu0UsbOJQPPwajd4ixp7OrKQ+w2x+D5Kmd9k9TgNrUB3NWvAm6sHwiIU7NAI9Y2
	iYcVKWmPUZibu7tvk5diDBP/QoJwL76mGoVrTT8dPg==
X-Google-Smtp-Source: AGHT+IFazUCK2pW49tmggI6cTKrEr65ter7afwNvBKcOQKLjjJ3tCngVWDXN8G2a4RpWvMA81hWtSw==
X-Received: by 2002:a05:6000:4022:b0:390:ffd0:4138 with SMTP id ffacd0b85a97d-390ffd04350mr6732331f8f.24.1741048483824;
        Mon, 03 Mar 2025 16:34:43 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:43 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:42 +0100
Subject: [PATCH v21 12/24] skb: implement skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-12-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=aF5BBJtGK7zOPdCppoubtothgTVc6dxPQzN+2KLtopI=;
 b=kA0DAAgBC3DlOqA41YcByyZiAGfGSo+iSHI447nm7KzkqUcnIIhiQzWQhkG+x2OAvCly89Vx8
 4kBMwQAAQgAHRYhBJmr3Gz41BLk3l/A/Atw5TqgONWHBQJnxkqPAAoJEAtw5TqgONWHPxcH/iMY
 XlTV6nLpwjlJSOfrHdjTvo30rcYb8C+uHC36P3XwEEf3JEQqHe7TiFE6dJM2z7jreH7+hgd92zC
 CyAEQY97gBs0lFUA8gf9l1x1XmkYTOXzB2HhY4leIkLj1InfEt6O0fEEgVf4ynB55uyloJAujq8
 ir+P+6DG2IgpmaadLKOnUsT0zUGIHOkpjNYltn6SypO6UJdC+dLD8ojGbYhPCc3RwCecooeZy17
 jm1iz2S4jtWS5LjFRVgNzHe0lcsDFSYcXtbGf386NiNKOUyuYNCkIc4emXArjLCiEIymeUWg6nX
 GWzt4aq5dAtdpctROcs08kjsimHkxiGELvIYPTs=
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

When sending an skb over a socket using skb_send_sock_locked(),
it is currently not possible to specify any flag to be set in
msghdr->msg_flags.

However, we may want to pass flags the user may have specified,
like MSG_NOSIGNAL.

Extend __skb_send_sock() with a new argument 'flags' and add a
new interface named skb_send_sock_locked_with_flags().

Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 14517e95a46c4e6f9a04ef7c7193b82b5e145b28..afd694b856b0dee3a657f23cb92cdd33885efbb1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4162,6 +4162,8 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    unsigned int flags);
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len);
+int skb_send_sock_locked_with_flags(struct sock *sk, struct sk_buff *skb,
+				    int offset, int len, int flags);
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len);
 void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to);
 unsigned int skb_zerocopy_headlen(const struct sk_buff *from);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab8acb737b93299f503e5c298b87e18edd59d555..bd627cfea8052faf3e9e745291b54ed22d2e7ed3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3239,7 +3239,7 @@ static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg)
 
 typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
-			   int len, sendmsg_func sendmsg)
+			   int len, sendmsg_func sendmsg, int flags)
 {
 	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
@@ -3257,7 +3257,7 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		kv.iov_base = skb->data + offset;
 		kv.iov_len = slen;
 		memset(&msg, 0, sizeof(msg));
-		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_flags = MSG_DONTWAIT | flags;
 
 		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
 		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
@@ -3294,7 +3294,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		while (slen) {
 			struct bio_vec bvec;
 			struct msghdr msg = {
-				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT,
+				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT |
+					     flags,
 			};
 
 			bvec_set_page(&bvec, skb_frag_page(frag), slen,
@@ -3340,14 +3341,21 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len)
 {
-	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked);
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked, 0);
 }
 EXPORT_SYMBOL_GPL(skb_send_sock_locked);
 
+int skb_send_sock_locked_with_flags(struct sock *sk, struct sk_buff *skb,
+				    int offset, int len, int flags)
+{
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked, flags);
+}
+EXPORT_SYMBOL_GPL(skb_send_sock_locked_with_flags);
+
 /* Send skb data on a socket. Socket must be unlocked. */
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len)
 {
-	return __skb_send_sock(sk, skb, offset, len, sendmsg_unlocked);
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_unlocked, 0);
 }
 
 /**

-- 
2.45.3


