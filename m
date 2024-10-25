Return-Path: <linux-kernel+bounces-381250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 969F69AFC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263301F22257
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC91D2227;
	Fri, 25 Oct 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="iSyJ74fK";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="LmilzL0/"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0A1D2202
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844806; cv=none; b=PiTylQVcSeqND2qSDrWr9zC9jrvZyM/apj+S4WiYL6HDGMRsCj+pB9fPatWvU/f0moN1swMw3ZJ2MEiVBUf1Yry4H3Y/6jIUvXyL2pnxmDcrzUB9EcCFGM5V14EfixvZq49yYQ0akIS0DjcDLg5QE6d5nqpib+1oyoIT7EYFYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844806; c=relaxed/simple;
	bh=fbJyDxZN+U0aLs51zdRPYgn56ap1jOvu70jSaT0aEik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kj4kGzOcXWL/7sAM/r3m3lhrT6jtUKqBitwpdpcdXPen0EDnzKw48mc8WfmMTbOLAnornC0ltMN2IGIMHYgBKqJNJbbQL6t45phmIEIeBdqdoejhnpnb3CYexGF7lJFOJ9Dc7L7U3Tt++KULl0U6wVJW70qGwuHUiA3zD99E590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=iSyJ74fK reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=LmilzL0/; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1729845700; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=wm5L+Qoo/ioFGQt3DT4pcDXXIVurmW309DoYLq1KaIc=; b=iSyJ74fKCmnxKny27cN2VQT8Na
	bqgA/RZZkEMS8lnlgl66yyUA5mtp4rg5V/cP9WXs//63j93XvI8voBlS/qFOyfyIqScPt68RTXwKc
	KnBhdhH6uoeoQZ8hLG6yfNPZb3bNatHekWgkbaooVS+qPsjEFD3snQ9gMk7sc9cTw48hJKMW3McuD
	grqtu5LuSOH+Sr0p1bt8FRHG3c4Hy2I1Z3mDF1iw+rdPBe5AvirfUjipIllQSqV1wq0fATSqmJOVz
	l40brswy4ykLsdQ4Njpm3/iQ/GoQeGz+oTRDDorob9AL2s4L0lnkSmu2BRfYu11YP7Gh5TJpKRScf
	7LuP1eFg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1729844800; h=from : subject
 : to : message-id : date;
 bh=wm5L+Qoo/ioFGQt3DT4pcDXXIVurmW309DoYLq1KaIc=;
 b=LmilzL0/Wplb+XkvRyEdfmCFbzQhCRq52b3obUFLaHhM/lM/6bMQFnczfwnpUXUm/7sz1
 a1rSg/3eAQmjYV5aUTAY4hMpTSQBiD++AI3x6X8+0Yr1KIpIDmO5BmS+vgrJG6KTo/Tp79q
 tlEg1cMpK7FNFCRbixNPEg2ET+lYc5xoCSznV8st8hV0ufnmU9Y1s6M27dknMZdr832397v
 voIcxBg/AoCifVAy+jazJ/DGeWnFVXJMaP4VQ58RgRjljKB/llDr2i/zS8FTnBtbKLmK/oP
 2i4EenbwLrlC8sxtzk+Es56NFDmmx1AKa6/OLJfhU+3FDd7d44cVzdX7Ht0Q==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t4Fe9-TRjx1p-TM; Fri, 25 Oct 2024 08:26:13 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t4Fe9-AIkwcC8o9IX-JQxw; Fri, 25 Oct 2024 08:26:13 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 0/2] Improve ath10k flush queue mechanism
Date: Fri, 25 Oct 2024 10:23:46 +0200
Message-Id: <cover.1729844329.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: MzDV6u61KxNA.hZnAlz6Rvbd5.4vGbaAAMqL0
Feedback-ID: 510616m:510616apGKSTK:510616sq2b0s9roU
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

V3:
  - Initialize empty to true to fix smatch error

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
 drivers/net/wireless/ath/ath10k/mac.c    | 75 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath10k/txrx.c   | 11 ++--
 5 files changed, 127 insertions(+), 21 deletions(-)

-- 
2.40.0


