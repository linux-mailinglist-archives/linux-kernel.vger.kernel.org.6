Return-Path: <linux-kernel+bounces-375980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DFE9A9E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D7B1F241D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D3F1991BA;
	Tue, 22 Oct 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="ouRoW71E";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="MfXud8dO"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE30196C7B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588554; cv=none; b=r49hJMyqJSxiUhfN2kuKeihwwHqnQKbugghXpGMlvitn+oHpI6abub6oLBC9TUkehEfoQZ+3ynHaeFLDnXC6oNLx/5a8zqHpOAP9ElVGSEioSC0y5Q5lRmThVMmWMaa1GMKmS8ffqqaE1jt32y/VOLXe0ZMfnzTRxeMkGgufWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588554; c=relaxed/simple;
	bh=fHZ7UidSxFuG5eHKJZfZuj1oorwTq6W0YHdbUlWJv40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lryYcVbV7Wb56XCuG9/r+Gy2S4NEmf6PMAc0qyCSCJsW3k5Q+dBNb/k5TgDBrsk6KOZz/5QNuXzorj7WUTOO/GzwJuebU1YXHk+/ZqS8t/KKTYNo4Z6usd0c9D3KK5r9skc8BoYi3MMEv68ASUw2FM7Q79pAaeH8ZCX/XD3fVfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=ouRoW71E reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=MfXud8dO; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1729589452; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=xb/z+UNQUk2Bzm3fUSkikryYi3CIF7nhB0KzTo+RcOg=; b=ouRoW71EvtEl9x1eAzvxhCIUik
	z76rUTgmlN+AYJL9aTZV4F75i1EPy2+VQv8grnoeGdG1Vq814YejTJtg+P/pdNUbr0qvzqka4dchM
	0nsWNrK0LHRsm5IEJLxN0AtKJHrASqWUXJbg7lbGq6uTPz1O9tx4mFI/7tLbyMzqlVOz1qwIRhgcA
	B1uu3mmOCiYrFnJ8Wgcz6Y3frq3GrbzMSZNV2Qo9vBOYqs+e8djAB7Or7cLecovzK6OWtbpSTFFOv
	Iw6WnnyCy5L1Unj5y3g6g19awMaM11TxcLSuWXzxu74USL8aCC459ZA2FpuCNZhjHRgHRtYFy65c+
	2t3GK84Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1729588552; h=from : subject
 : to : message-id : date;
 bh=xb/z+UNQUk2Bzm3fUSkikryYi3CIF7nhB0KzTo+RcOg=;
 b=MfXud8dOYO1ELZTRz+6TIrwlohYYURQ/sFiO6S13T1eQiZoyo52EIqLNIZQAjFgRxGiJ7
 iuRF5htl0DDIH2aLbRI9QdEs7+x541L5caovoItIL5ApSpJW28FvjPIrfaifVC6xsXe6ouz
 JF8VOobjvxypdseFNWB+rQXk3BEk5hhLbb3SAl7QCX7cRKdZTm5rPNjeya+PTr+d5PiZ5Go
 PVAAtWLUzGz7XrWNwe6RHnSJ5prlKpZdSVNSvIieoH/bKyoHZxReqIQ2IWQrlXBdZ50nzZR
 ko35KpNYGLx+ipgpjTIuu3P4fbuO/TbaoyMnAL95KHTXf23OiXuQbGbbRLCg==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t3Ayn-TRk3iE-Qs; Tue, 22 Oct 2024 09:15:05 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t3Ayn-4o5NDgruWbA-qiYi; Tue, 22 Oct 2024 09:15:05 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 0/2] Improve ath10k flush queue mechanism
Date: Tue, 22 Oct 2024 11:14:56 +0200
Message-Id: <cover.1729586267.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: QL_OyQ0LBQYN.6_I5Nfohgv64.jvigEwkUjx-
Feedback-ID: 510616m:510616apGKSTK:510616sVJz0R5toj
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

It has been reported [0] that a 3-4 seconds (actually up to 5 sec) of
radio silence could be observed followed by the error below on ath10k
devices:

 ath10k_pci 0000:04:00.0: failed to flush transmit queue (skip 0 ar-state 1): 0

This is due to how the TX queues are flushed in ath10k. When a STA is
removed, mac80211 need to flush queues [1], but because ath10k does not
have a lightweight .flush_sta operation, ieee80211_flush_queues() is
called instead effectively blocking the whole queue during the drain
causing this radio silence. Also because ath10k_flush() waits for all
queued to be emptied, not only the flushed ones it could more easily
take up to 5 seconds to finish making the whole situation worst.

The first patch of this series adds a .flush_sta operation to flush only
specific STA traffic avoiding the need to stop whole queues and should
be enough in itself to fix the reported issue.

The second patch of this series is a proposal to improve ath10k_flush so
that it will be less likely to timeout waiting for non related queues to
drain.

The abose kernel warning could still be observed (e.g. flushing a dead
STA) but should be now harmless.

[0]: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
[1]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")

V2:
  - Add Closes tag
  - Use atomic instead of spinlock for per sta pending frame counter
  - Call ath10k_htt_tx_sta_dec_pending within rcu
  - Rename pending_per_queue[] to num_pending_per_queue[]

Remi Pommarel (2):
  wifi: ath10k: Implement ieee80211 flush_sta callback
  wifi: ath10k: Flush only requested txq in ath10k_flush()

 drivers/net/wireless/ath/ath10k/core.h   |  2 +
 drivers/net/wireless/ath/ath10k/htt.h    | 11 +++-
 drivers/net/wireless/ath/ath10k/htt_tx.c | 49 +++++++++++++++-
 drivers/net/wireless/ath/ath10k/mac.c    | 73 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath10k/txrx.c   | 11 ++--
 5 files changed, 126 insertions(+), 20 deletions(-)

-- 
2.40.0


