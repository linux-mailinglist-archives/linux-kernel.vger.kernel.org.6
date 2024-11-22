Return-Path: <linux-kernel+bounces-418523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D89D628C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05440B24439
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B446A1DF969;
	Fri, 22 Nov 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="JxL+Q2ix";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="SVFm8dE7"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF91DF753
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294191; cv=none; b=TsF4F+aBsRzlJzUxUNL4pbZAzseJlWMSbYHT4SeKYBePO0xvWXW8GVo/agC74nYY9w3iCiWEhTnQIeCafYd9cg5EI2GNB/7DGynwfNe4nW2mX+1VFpzB6COOF256DkC1jfG7T9dviTr6kaaDyQUnRC+DGcDbZ4lL5J40FpkYFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294191; c=relaxed/simple;
	bh=fbJyDxZN+U0aLs51zdRPYgn56ap1jOvu70jSaT0aEik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OXJ6l7W8uNGwCFh1A1wkM6XmU4oOJA9xTGjqKvWinURkZr1bWhgfCToTxBznE5njlh0nWyir0pdOmbavJpvlCNhvaIAeF4YBmqUo63IXgEgFlyLi95F44HQKTyB1GbkpWOT80Vo+9/zkJAjxWwFhdT9dsGjuvyEPPEXAQLMOIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=JxL+Q2ix reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=SVFm8dE7; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732295089; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=wm5L+Qoo/ioFGQt3DT4pcDXXIVurmW309DoYLq1KaIc=; b=JxL+Q2ixUuOHusccsvi2fOfFeg
	bcxhkZXPIkXGX4gTX8FlpKIExuX3PVvKxdaYXl0rMCrN7tAzdCLdo5g6dOcBXwtAMadJDsbgCpK7B
	Q2bMqaILqWlZKxHeNs9D6TZs5HEyqfcTdZyrhN0WobKWQFbD49Qwl4/3gW+hEJypBA+X+/WY0T/zE
	AHdoB7aVS/fRJoI+yOxt5yVMSYjA3d2fHzeqWQwfaTM3tMsM+yavjv2bYPPcrJKOpOm4MHvAU9JkO
	N+aHqJEvjk3q+ZXB0YQqoHc+PPgNFqruo5f8dwLWaMhUhLl692HclNsgOBs4hoybcCqDXnpqeNzj9
	hlJzVrzw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732294189; h=from : subject
 : to : message-id : date;
 bh=wm5L+Qoo/ioFGQt3DT4pcDXXIVurmW309DoYLq1KaIc=;
 b=SVFm8dE7lP8/ls/gMlj4Ddy/tkSBMqMbZHiAyLPsoqftIMVXbW5tvWUfAqFoAGOWFA5sK
 NXshFBa5czWsM2LJiiJ9EGS1S1z27s9MpxdbLgyXUEsQERTdmmqAVFp9miByrLbyAGcrI+9
 z8WicF3+p4iaZMeXuLzhQHCI5fRo3bGg8odu0ogy1TW/Z55kO5v36M56xqgnV/OcQE6S3mQ
 6QI9TJR61xAfe3WTMdz3BdBrFuLHQ8ETIZSuiMI5RTD7R/2+Z0Tz8+IQipNoU2dz/tfHUG/
 xQY/subdYsggnu6vLEHU4rO42B661boLk7mm/w25ITmQcXsqSwORxRe14xew==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEWqR-TRjyJk-P1; Fri, 22 Nov 2024 16:49:23 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEWqR-4o5NDgrgcby-m1Zz; Fri, 22 Nov 2024 16:49:23 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RESEND PATCH v3 0/2] Improve ath10k flush queue mechanism
Date: Fri, 22 Nov 2024 17:48:00 +0100
Message-Id: <cover.1732293922.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: f7juQoXObcjq.Xs5XFeEVo-6j.ucvNzgCJ_I1
Feedback-ID: 510616m:510616apGKSTK:510616saXhY0s_Pe
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


