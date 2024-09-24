Return-Path: <linux-kernel+bounces-337543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAB3984B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4E7283808
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C11ACE00;
	Tue, 24 Sep 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="pnNWKtZq";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="QUwC5IrD"
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770013B2A4
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206053; cv=none; b=KzCK8KPV11DZiZYsTPlvUeSDDv3867K3EEOtjCgx2kRnM1Wn+QSz65GKtqcfSNxSlv+xBnVh2cUuS2UfzidsxSQtBNnZpSVWEZTxrhKHPooo+pyVU65N4dc7zlES6KGdnmtz66pAIwlqTjjhA3aQW+hwf9n44dKcUPFUOPRfDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206053; c=relaxed/simple;
	bh=DTFUn5D+GS+8oAKFg96mSbEnHq7VklLZgnN8eBHLIVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M1OZPrhnuHVWecaTxD7/3W/Avn3DTH/kszV2dPmccWFUtIhPvdfDmQIpE09lB/rj4OmXarLFN6dewytlS7w6iz7mavQhAkdJhPfA8p4OEs1KV9O/UnUCn8A4QW+eROkLQkz+X9tYYzClPahaDOqvu8IOIDajMZ2PV8+ayHSyOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=pnNWKtZq; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=QUwC5IrD; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1727206040; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=DmPsxQ6uevwu4jCwUKgsQ7AW+OZEseqHR4yN51XYYYw=;
 b=pnNWKtZqt2Us294O3mxRH86aFItcq/EFn79E6mFwOIKIOdhlBVj+ayluBmTUCqk2WBJc1
 EKrtf1J6KZTWXYVhN97UVajJGOxNSVOtMRcHT7cor2nMdlfqXRum9uVS/OgH0FjF4DnLLc6
 umZIQ1ryk8jUJ70gXPJhKBLzGTbNI98S8/a9jWjvq20CiJH9v3gQEXwOWBLXzsdGX1b4D0F
 l/e4Cc4OotzgBjDoIVs8QH1D5HZsUqgexwjTeD/ALRODDauF6Z1O0b9VhynibFb+GBOJKb/
 fE9vEY067WpUhPZfr0m3xiu0X5Qn+ak5m9FI9wkG1+aldkKxsQ2YmAG4gs4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1727206040; h=from : subject
 : to : message-id : date;
 bh=DmPsxQ6uevwu4jCwUKgsQ7AW+OZEseqHR4yN51XYYYw=;
 b=QUwC5IrDX99c8Ds690LsijO/OAsOuqM2oxoZjVy9VZwyN2H3/qVLz11ksQNcBOXCf37VY
 IkPB4zKz/eeNQ7szHhPDZ2smb32bk91yMvBihhsLnn+AZjdv+Wi1xC8ZfqYA0z7pF5LiZG0
 VPtNLOksayf6ut/nG/gh0KjTaJ2QSngXYKWxpIknbRLxBkNv4bdJj+Cy+jegkO6tZ/q4cjr
 SJNqz3COMg2niV5Thk3sVG0DsLNVxKAUM4jrm71r46u25QDtbfncPRjonM+yw5Lp2lqhik6
 MIZCz8OJ/EnSpPdckML13n04v06nkbJxC/Hp3T0P7w+lsg5iRT1qG/w8thog==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1stBBr-FnQW0hPyonv-mJZE;
	Tue, 24 Sep 2024 19:27:15 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
	Nicolas Escande <nescande@freebox.fr>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 0/2] Fix ieee80211_color_collision_detection_work() locking
Date: Tue, 24 Sep 2024 21:28:03 +0200
Message-Id: <20240924192805.13859-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sLKtpkydaK
X-smtpcorp-track: 46rzRkMVzA-v.poVWMCrxAnXf.cL--pQBpyp_

Call to ieee80211_color_collision_detection_work() needs wiphy lock to be
held. This lock cannot be taken directly in the delayed work because it
would cause a potential deadlock. Indeed ieee80211_link_stop() is calling
cancel_delayed_work_sync() with the lock held. To avoid such deadlock one
can use a wiphy delayed work instead.

Thus this patchset convert ieee80211_color_collision_detection_work() to
use wiphy delayed work instead of classical delayed work. But because
this work is used to ratelimit cfg80211_obss_color_collision_notify() a
way to tell if it has already been scheduled is needed as discussed in
[0]. In this thread three different solutions has been considered:

  - Implementing wiphy_delayed_work_pending() to detect if work can be
    queued without postponing a previous schedule

  - Using a __ratelimit or an equivalent to queue the work

  - Modifying wiphy_delayed_work_queue() to mimic queue_delayed_work() by
    not queuing the work if already queued (while also possibly having to
    add wiphy_delayed_work_mod() for those who need the mod_delayed_work()
    behavior).

This patchset implement the first solution.

[0]: https://lore.kernel.org/linux-wireless/D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr/

Remi Pommarel (2):
  wifi: cfg80211: Add wiphy_delayed_work_pending()
  wifi: mac80211: Convert color collision detection to wiphy work

 include/net/cfg80211.h     | 44 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/cfg.c         | 17 ++++++++-------
 net/mac80211/ieee80211_i.h |  5 +++--
 net/mac80211/link.c        |  7 +++---
 net/wireless/core.c        |  7 ++++++
 5 files changed, 67 insertions(+), 13 deletions(-)

-- 
2.46.0


