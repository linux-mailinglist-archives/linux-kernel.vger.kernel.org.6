Return-Path: <linux-kernel+bounces-362469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F15499B561
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5636A1F229B6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE511991C2;
	Sat, 12 Oct 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="iKGgTkjx";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="YpjHfBLU"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE42194ACD
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742450; cv=none; b=p1YRMU7LGX9knX935APuqx85xLDlndOG18qMcZAjoz2W3onjSo3zsldx1K93TZ/Lv07WM3fT0F929aHBsYXnHMZZbxhQNycT0OKUVHhH3JcZ/q16Cjf9kiRGFIxWUZPR9z1YFyoWS4gP+AxGn6TABONMD0HUooUFUWkOQaAUxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742450; c=relaxed/simple;
	bh=Cy+R4FPDFUOG+iV2pPma0CEtX9bmeveSMtqN46TLDlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OsAy19kec7/Pc3hdCgYMY/OZVEG3QziC/tfGy8jCPZszSDquWmF42XbuaeQDPXvpK2BB4ScDJ2eGSLP+zcG0g50iE3m85cCXa46vpEjITk2ZAPG+DL/0vHRmf5xTfHVawVDk6dJn/ASzSgqMTnHQS39l6nS/R/D8EUCfI6C1tIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=iKGgTkjx; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=YpjHfBLU; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1728743348; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=nZwbub+Y+2CpDF1gb5jtpGb5EXEnMSxGMYCK7/dCUDI=; b=iKGgTkjx0iUnkQRSy00DEmB8Tv
	T7olKRbuY5eHimvE0R8RziciB8ev5Fcbb1z20353UmU1e4gSqhVOWxVLEMLC48yZ8uIOW3utrorc4
	8DaI6rjzVfWK+VOfunER5HXxdlaQP99u5v4JimFJ7zQmfPXJdsAIlJVK6EvhKsg+vTkMMe7m9vLVg
	Sg8rVtSDeZ4s7R3MRV9lCLiA8oUt/ZhCHitW8xCIvHe++GZ4zZCBa/gcwDkV37lJGcZPl9XzKusmG
	Fyj5ttVu3ihKzSCYWFcQ8crcNTnGrOwE2psAbbFnPIKBPWh5ZtS6SHwHtyKmrfmjllJXn/fqnQfNs
	AYyNXk3A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1728742448; h=from : subject
 : to : message-id : date;
 bh=nZwbub+Y+2CpDF1gb5jtpGb5EXEnMSxGMYCK7/dCUDI=;
 b=YpjHfBLUqCsXvQPlYRalY/AUFiPgUvvMcslIOZOuPgGD+GacknVZqnJBryp+5XDR22E/X
 A6DNYPwmk/OsgdNZ6CdWb5WhEcgR4J91W+hFQvY1lOGFThII1sM247wU4x5IKWdMumrfwRr
 AstlXjc4lem1IrOMAwvZWhZ+pMiYzErVvIGXqgCbGEptAWm2oHBveKEfyAZ+s1qwkVXLP+m
 yjD5Ucn3uLgusEaEzdKp2AamN4DfBOnD0iAm+iTaspV0iAJrJ061ERslV2/lLSxiE12fsQW
 Z40xt05kAeawlNxce5BXUTnu/kAQb5ZRb++qbAE92F7qFP7B52ZDnt94Oa4w==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1szcsI-TRjz50-AJ; Sat, 12 Oct 2024 14:13:42 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1szcsH-FnQW0hPuzUP-oFaB; Sat, 12 Oct 2024 14:13:42 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 0/2] Improve ath10k flush queue mechanism
Date: Sat, 12 Oct 2024 16:13:53 +0200
Message-Id: <cover.1728741827.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: wm0zXH3aL3Kn.DZ_sFwbD2G3U.xITMJg6oeV6
Feedback-ID: 510616m:510616apGKSTK:510616sE1o2YokP8
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

Remi Pommarel (2):
  wifi: ath10k: Implement ieee80211 flush_sta callback
  wifi: ath10k: Flush only requested txq in ath10k_flush()

 drivers/net/wireless/ath/ath10k/core.h   |  4 ++
 drivers/net/wireless/ath/ath10k/htt.h    | 11 +++-
 drivers/net/wireless/ath/ath10k/htt_tx.c | 50 +++++++++++++++-
 drivers/net/wireless/ath/ath10k/mac.c    | 76 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath10k/txrx.c   |  5 +-
 5 files changed, 129 insertions(+), 17 deletions(-)

-- 
2.40.0


