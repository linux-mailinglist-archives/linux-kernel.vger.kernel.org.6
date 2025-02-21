Return-Path: <linux-kernel+bounces-526060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D65A3F958
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA63860432
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E4F20FAB7;
	Fri, 21 Feb 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE9sEeWh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508B9205514;
	Fri, 21 Feb 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152665; cv=none; b=fBJE/R9v3hZ+m4xgihjQ/XqAFiAfk9RuoqHHsX4kzWzV3o2YbJIUeyhsZoVsbUnWLF4LlaSJNsrWfOoCQZx+vMX6qeDvkKJKUAaMcj6mqCK+tAtDe9tDmyE5/M6F5mgTqCTN8GGH3MttmhglMNWPhwm41rLVEi/463bbXpKnb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152665; c=relaxed/simple;
	bh=HO/U2K0VlOA7A2+ePqQL17SLbIZk0lISzN8lAeSxivs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W+ZT1GA2azR6U+h2JtzzoZiwPdAJL5RfwDgnqnptOQkBfSr+9FnKSk+sg6AdsAtpJ1qGGCGn5G50YeJkL6qklaVKmK/CWh0+H5F1JkJ0yvYYXZy1Aj88QvcNFHiS2CXS6VsWytmBgS+vzJKuQTbnRj/Igitz7SBtTj1K91NGYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE9sEeWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245A1C4CEE2;
	Fri, 21 Feb 2025 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152665;
	bh=HO/U2K0VlOA7A2+ePqQL17SLbIZk0lISzN8lAeSxivs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GE9sEeWhBaofGP+L7RDN6oxNV6/CrpqTIgl4Judv6b2DL98rILFXbMWkBbnGL71wl
	 RmNmpqdRsCu85/sDuceiZGwP+Dt+U6ZcfN4yAJrihGwtjvMeeqQxDeUAUs9V4Q+wHN
	 wfh9bVrF/kfqsjYoqJRXzSCvtCq+p+tQAtBdLjYoKV7NNYfG0cRLMf5/YEoQ0Mq3eO
	 x4cPMzJt3hleINr0x8SbnTd1DE5eiISW3brOpJ/3VLtj6+hB7Y8lNZsdNSgDUI6oz8
	 Pwd/6M/Tf4esD+N73piHSb3Rrjv3aXFj7s75XeOoY2g8xd75z7Qwvomf3EnMCsxCHv
	 YD8pshw4WMmUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:43:59 +0100
Subject: [PATCH net-next 06/10] mptcp: pm: drop inet6_sk after inet_sk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-6-2b70ab1cee79@kernel.org>
References: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
In-Reply-To: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xGhLLvT9C5RFpvlGZaPhSeZsH3tKwxAeTGRWovFQLzc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9HwHj2cdP8JdEWAW7+fxOMvTAWNMTF/zfFG
 whUJ+aagtuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 c4FgD/sHsOfaWNxJsg1FJPJIvvcqVadxxq0Fk7r9ShWf33kzeHEghEA7gEbMwdUhr/vcRTo9grM
 SbKZkyBUKMbsCwKHG+w/nIVUZ6KCazYkYy1cM+KqMbwtwa5EkDapbRW1D6l256GipbAhyjzcjNc
 PGUiXnc5A3WenFhHowtvRNfuTjsQLzHQT4hfObP+I0T1ZtVYWN7aeJ9fbASY0fPNFAwGb2E9lxv
 WIPVHMlhoP0X9Y3+XLyJw5XZirZxiJljQ3Zgca5HtUuvpdv4d+fgQBEdbJmkidcA/wlRdPfC4+X
 dO+zxi0DskGr8BamK6wyMZpXcF2PkmDug4IKF2vGWLamkATIPGKg2xjmRiFh48x2r3pUPeixdsZ
 6IBRIu8SO6ZJI4q+vJhqgjly6qh67MX3QT/wNNYAERGFVBfxRQdIGmlmtdodtBBqp/KlKFQ930k
 m2uMU+i3pTF3H8vHVHovcWl5ZvkwjpHPKK/j+7ajVxef+YoOkPJWkjUdHkEZQy7Ebxecfv8sJFb
 fCsYABBdYRUdi4+FcDKoUrk4RBEdoIcjYpD0Amcni5jY99TH1w3MUgF69FjbDlF2FYrBgpg4tJ9
 W+yYly5Qu27nrauoNLWcwoCm+WZOma4NfIuHx3qExAbaU+0z15SjAj2DbKBuL1ukoGqtW8mdMpa
 UufV/YUqBApHA1Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_event_add_subflow(), mptcp_event_pm_listener() and
mptcp_nl_find_ssk(), 'issk' has already been got through inet_sk().

No need to use inet6_sk() to get 'ipv6_pinfo' again, just use
issk->pinet6 instead. This patch also drops these 'ipv6_pinfo'
variables.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 8 ++------
 net/mptcp/pm_userspace.c | 4 +---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98fcbf8b1465649961c568c6f8978e91d0a53668..f67b637c1fcf7c2930ced8b5c6b9df156118cbcd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2022,9 +2022,7 @@ static int mptcp_event_add_subflow(struct sk_buff *skb, const struct sock *ssk)
 		break;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	case AF_INET6: {
-		const struct ipv6_pinfo *np = inet6_sk(ssk);
-
-		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &np->saddr))
+		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &issk->pinet6->saddr))
 			return -EMSGSIZE;
 		if (nla_put_in6_addr(skb, MPTCP_ATTR_DADDR6, &ssk->sk_v6_daddr))
 			return -EMSGSIZE;
@@ -2251,9 +2249,7 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 		break;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	case AF_INET6: {
-		const struct ipv6_pinfo *np = inet6_sk(ssk);
-
-		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &np->saddr))
+		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &issk->pinet6->saddr))
 			goto nla_put_failure;
 		break;
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a16e2fb45a6c68bc0c3c187122a54765ef0fb259..6bf6a20ef7f3e50750b648032c9e8961d3222890 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -460,9 +460,7 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 			break;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		case AF_INET6: {
-			const struct ipv6_pinfo *pinfo = inet6_sk(ssk);
-
-			if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
+			if (!ipv6_addr_equal(&local->addr6, &issk->pinet6->saddr) ||
 			    !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
 				continue;
 			break;

-- 
2.47.1


