Return-Path: <linux-kernel+bounces-574035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A190A6DFDF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944FB1895E91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4C263F35;
	Mon, 24 Mar 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="uoZa/noZ";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="bdKrIVzW"
Received: from e3i165.smtp2go.com (e3i165.smtp2go.com [158.120.84.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF3263F2C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834068; cv=none; b=tA8rBocJ9RaXHA9LvkyLygXmSBGOelD7ST40nnjVc42s76QWaOIOBuG1Otw16aoqsjmtILKgHtvXMZyaV1L61Z2Px4qrBX9CvPRla7ewQSbFVb4UY8a9sD4/o+yr8LVMxZOjSphL8LIDSU5kYCqzB/4n89It8D3UWtSzp6qpWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834068; c=relaxed/simple;
	bh=vtZr+kdulmEXyEwSmc6+O2wvWASjNK0fs9aMJTZW71o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMm7QDMc5Az+s919fHFejPnI8dNRIg6MGqk5a3qyUEZvYn/sXElXBASXQntz9r0g1DdR/ETFC4ptkHY3x/nX3PJPD7vtlU4vhdXkoFLnHOxh9F57XwuWOAxQOtl7u0fDxRQJQekvKNP9X7KVqUUtPDIjmDF2cg/YTx2GJPrFiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=uoZa/noZ; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=bdKrIVzW; arc=none smtp.client-ip=158.120.84.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1742834062; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=BwuwOuq+8Kdc1kpOd1ZfhyKeU2liqexDzuOzbtKiZao=;
 b=uoZa/noZn5EhfM5rhWm7FTwJ4KTFFo2gyH72EG6rs+Oh6/oigut+a2w9C/aoGDAsLE9hF
 isPlfqihCS++GSs2nTuuo1Rfz424AqEbucoQZWfhf6vPvjFn5/UcrRmsPk8zmYzHBq6/02h
 ffeCrwilR5/tQS7euQXIDXZrfQmt+RKUie8qaPRzccN1nkFJN7dcGLct2FPkaVi02Syj1c1
 n/J4kuayzpBsCg+uhFdwhJRzYS0cxhhJJK1u6MN8DdJLHd9kiHmuSKA+/PEKY6bsJdRC8mK
 ey9s1iNC1UgBTRloXlACuZ4Gv15laxKS8EjL8YZ6QlADnJTEYoNp2bu652OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1742834062; h=from : subject
 : to : message-id : date;
 bh=BwuwOuq+8Kdc1kpOd1ZfhyKeU2liqexDzuOzbtKiZao=;
 b=bdKrIVzW6uA7QSVxzLkrNbFp1OSvBvUjEdNctlEofbwiPbGCcixU6i3hIHbk679blQhWp
 KwlnbmHOi1gbo4g0dv3saXymwIWtmlvU26nIGfuY+C8YbviGfnygOlPkHJjcn+vWVg+Y/of
 E0/6IF/cutepVIANjw9pw+UgMvEssfuqGJWNlRB4bkvk6/1vCDvD8IbHPOJKfNq8ZqITFic
 XqAl6GxBGUCEzmGzzm5JynTlnrgZoJ//9lGCTT1xY6aTziuGbZOaXnpDhoSLrZwAuZjsnEf
 +mT0zCZlhMV7Ycg35v8SHf0hQTQUOQ2Zw+WBtOedUYznM6R4FhtU0vCSVusA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1twkkj-4o5NDgrs054-kFOZ;
	Mon, 24 Mar 2025 16:34:17 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless v2 0/2] Fix packets processed after vif is stopped
Date: Mon, 24 Mar 2025 17:28:19 +0100
Message-Id: <cover.1742833382.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616st8gJk_fpU
X-smtpcorp-track: AN1zDtdMeZvV.X6ZbOX52jY6I.0EYZeQ2M90G

Those are a couple of fixes that prevent crashes due to processing
packets (especially multicast ones) for TX after vif is stopped (either
after a mesh interface left the group or interface is put down).

The first one ensure the key info passed to drivers through ieee80211
skb control block is up to date, even after key removal.

The second one ensure no packets get processed after vif driver private
data is cleared in ieee80211_do_stop().

v2:
  - Add Fixes tag
  - Clear SKB's control block key before in ieee80211_tx_dequeue()
    instead of ieee80211_tx_h_select_key()
  - Add wireless tag and fix type in subject
  - Because subject changed, v1 can be found at
    https://lore.kernel.org/lkml/cover.1741950009.git.repk@triplefau.lt/

Remi Pommarel (2):
  wifi: mac80211: Update skb's control block key in
    ieee80211_tx_dequeue()
  wifi: mac80211: Purge vif txq in ieee80211_do_stop()

 net/mac80211/iface.c | 3 +++
 net/mac80211/tx.c    | 1 +
 2 files changed, 4 insertions(+)

-- 
2.40.0


