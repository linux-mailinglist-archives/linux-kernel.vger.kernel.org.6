Return-Path: <linux-kernel+bounces-344451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DF698A9C4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443261F22EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A0419308C;
	Mon, 30 Sep 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ivxxvpRS"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AD192D82
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713784; cv=none; b=nPeAo4vbsNvsSMXTH5cauAKEYWypC3UV3x20UejC/y4EkYgZbscC8A6gGE2u/eGzzAQYL9ejNBFN9dZ3UDmZPFRSmRUURkJS7Bz44gObmB/p6IMTLyIVQDLGkGverZZwowKP5Pnn2ZazQzYv0N3S6XTg55Tc/ICmYae3BHIDszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713784; c=relaxed/simple;
	bh=GepLR1MXCvDebTt/jsMxUFggGLRHtMkq3G0437bRe6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZRVHL4iFo5TgQi0DrAgDlR3fZo7pqt+uZXrXviKoVYH+9xQdmz6pIW4tOJ8pP9OWNshJ7CbNKtngDVzmgnjYMuOtahxaM575IVDRVbD43ewYDCXphJuq8I2d8LITcdCQHnegQAq9N9hCmTYQr57S7VTnPpsH/D16Rn30K8qUTm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ivxxvpRS; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727713781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ctpjEXxAQhBELHgt/nsdF0ZF04pW65sAwCl2IcBKy8I=;
	b=ivxxvpRSBJKf/+2OVB8NJ/BZsJiYbTzE2I+4izIwNOORJBkjo63G6Puwz5ii0Gvoxx0xqH
	K+tKUYA5gs35KHocDmSPWrJCrcG+TGq+5D0hbUtAmVOmbjIhd6Y9OyMfa/dh3EzWWL08ui
	Q2a+i2h45tU6vLpBqn9rBcJBTZW8Wbo=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next] selftests: net: csum: Clean up recv_verify_packet_ipv6
Date: Mon, 30 Sep 2024 12:29:34 -0400
Message-Id: <20240930162935.980712-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename ip_len to payload_len since the length in this case refers only
to the payload, and not the entire IP packet like for IPv4. While we're
at it, just use the variable directly when calling
recv_verify_packet_udp/tcp.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 tools/testing/selftests/net/lib/csum.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
index e0a34e5e8dd5..27437590eeb5 100644
--- a/tools/testing/selftests/net/lib/csum.c
+++ b/tools/testing/selftests/net/lib/csum.c
@@ -675,22 +675,20 @@ static int recv_verify_packet_ipv6(void *nh, int len)
 {
 	struct ipv6hdr *ip6h = nh;
 	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
-	uint16_t ip_len;
+	uint16_t payload_len;
 
 	if (len < sizeof(*ip6h) || ip6h->nexthdr != proto)
 		return -1;
 
-	ip_len = ntohs(ip6h->payload_len);
-	if (ip_len > len - sizeof(*ip6h))
+	payload_len = ntohs(ip6h->payload_len);
+	if (payload_len > len - sizeof(*ip6h))
 		return -1;
 
-	len = ip_len;
 	iph_addr_p = &ip6h->saddr;
-
 	if (proto == IPPROTO_TCP)
-		return recv_verify_packet_tcp(ip6h + 1, len);
+		return recv_verify_packet_tcp(ip6h + 1, payload_len);
 	else
-		return recv_verify_packet_udp(ip6h + 1, len);
+		return recv_verify_packet_udp(ip6h + 1, payload_len);
 }
 
 /* return whether auxdata includes TP_STATUS_CSUM_VALID */
-- 
2.35.1.1320.gc452695387.dirty


