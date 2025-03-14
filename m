Return-Path: <linux-kernel+bounces-561300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 089FFA60FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B821B61256
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C91FCFF2;
	Fri, 14 Mar 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="yMfYYLhm";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="kIKroe/R"
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D111F4717
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951547; cv=none; b=GBz25EpcrCz24rOpWq9YgQmyeJsChJx35qxXUU5h3t5YY3+RAd4qo/+lIM1Ks8wwsFFNlP88awsn3Yrvm1fC/BZUBNTtnKRmiMEaKBZO7YCzv/k49z7ZB9gshPAEOjfLBbEDnNcE5ll4YXHjwnlIGow++HB77X4aVdTzk6MZJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951547; c=relaxed/simple;
	bh=K/z4t4NOhqkkqSl6CQ+AsBENi23rk6XIpH50FaBpmSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pUiI+qIHh/SD5Gy2dOwfpYzGIUYE6r+8mDwIedq8aHHMl30ft0rFWzmG5cHysmJ7Bu5eBCGBYWUzteFWAZyGx5WBdEZEUieH3H/11FLtpXu+N2pjbKb413ICd+JvoJUufUqKGhaholInBHt6K0h4Hx6kZ/3S4rMtkV8tf/18q1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=yMfYYLhm; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=kIKroe/R; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1741950633; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=Q/0NWtuCGURDovv9ooP86q0n2kOTSTLmQGJcGN0Cr98=;
 b=yMfYYLhm4Kz9tymhoqvnEs+06fh9z6MQOSp8S1oZ1RM4CiV/SOfqW+BIox8gf5lVLhx/T
 t9H435R5qA1PMvytzni7ERq5jW2eGYuIE/vPugbgH9QJzd/nZoZNsxhjjeLKOeaZ98tVNa5
 evyD8Q130+ktHPcaFk3uxj6e2OABy5GuK+oAHgrwARqghY16atfySBMHeBUEmPpQDoCWDYd
 dhLF+Ta2/O39+UFzn8xnYjmJ7J4nC2TgVxhET1Lq84TVhpNPFMFFL6pLo5xgYWqPltrOHiG
 CKk6PzDHgcfKozJ8zFhztCNqpK4n9jhqiWocqgn1fw2FyzD/0CCEEaRrPdDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1741950633; h=from : subject
 : to : message-id : date;
 bh=Q/0NWtuCGURDovv9ooP86q0n2kOTSTLmQGJcGN0Cr98=;
 b=kIKroe/RfzPtPHCN6j8ggncAGOwuMnpKb1tuFLMtfnzuVD5YwczB8q4rkHVt12Yc+EoYI
 WB86cy4AlSEJ4A4ND8TS/2wYecbdpJCjmpzE/n/MiWL5yLm2iUXhJSWTMA1WapuUvTp8Kth
 +BUgFv1asb7e8RDeivjgNRp9hmXuCmZJlLMVsM17L0CgDIUcW+uo+WChoc9EID1PA59vK+N
 72sM3A8oKGAEguYO8OOkMRWz88NiJuLV9H7kk1QoHcuAsj9LGZ/W3p3jbLR7C4SmYUEEfxb
 8tn2gRyGjSjPmtrqbEs8X1bAHYyeJ/y5x8pmRCip51ESrN8JJhEdletkP+cw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tt2vv-4o5NDgroS7Q-rZnl;
	Fri, 14 Mar 2025 11:10:31 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 0/2] Fixes packet processes after vif is stopped
Date: Fri, 14 Mar 2025 12:04:23 +0100
Message-Id: <cover.1741950009.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sFgC3_wmkW
X-smtpcorp-track: Ic1l3KQJhux6.k1lhbjisfJcB.PP06FQKkFRA

Those are a couple of fixes that prevent crashes due to processing
packets (especially multicast ones) for TX after vif is stopped (either
after a mesh interface left the group or interface is put down).

The first one ensure the key info passed to drivers through ieee80211
skb control block is up to date, even after key removal.

The second one ensure no packets get processed after vif driver private
data is cleared in ieee80211_do_stop().

As I tried to explain in second patch footnote, I can still see a
theoretical reason that packets get queued after ieee80211_do_stop()
call. But I was not able to reproduce it, so I may be missing a
something here; making that more as an open question.

Remi Pommarel (2):
  wifi: mac80211: Update skb's NULL key in ieee80211_tx_h_select_key()
  wifi: mac80211: Purge vif txq in ieee80211_do_stop()

 net/mac80211/iface.c | 3 +++
 net/mac80211/tx.c    | 6 ++++++
 2 files changed, 9 insertions(+)

-- 
2.40.0


