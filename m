Return-Path: <linux-kernel+bounces-546939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7412A500F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418631884AA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB0E24A06B;
	Wed,  5 Mar 2025 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXTNaxtH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193E824EF7E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182230; cv=none; b=iXryfwMyEXw/cWWUmu6Jk5bQbUGyss3TfIh0i32d5EqkM4D9k8gtZG0cSlRxaTH9x8rBrgye++0XIeBSsF//ihH+OOpZCz1jm5HVYfR4mCcu7M1dgnd3S2G4nIbTTvZQjdY1mHe4DGFkEGxsTHbD4fPlSeTX0/7c6nfuDhMV9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182230; c=relaxed/simple;
	bh=OsJvtG0FJl/+ppRTU+sMDaH2l9ngtdnUkrowqv116QY=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=iOTXHgkVyeJmvw2+ewEAICu1DJyTe/BdKsz1rDWC+uaSY8Aa2RAOzImWNadmfdsI++as0/rG07YsqKzqftNpTMTk21PO41LMuFhG//alahV5sHn4Y8m57hLWO8FGBit3khq3zbzr6JNnq+pznd9Qn3/e3humwyK18BlmiznXVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXTNaxtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB03C4CEE2;
	Wed,  5 Mar 2025 13:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741182229;
	bh=OsJvtG0FJl/+ppRTU+sMDaH2l9ngtdnUkrowqv116QY=;
	h=Date:From:To:cc:Subject:From;
	b=SXTNaxtHRDKql3fnx/R8wmaheB3QAnvstIJJ1U/1ByWakTvNY0MhttNUwuORzifR0
	 ZSkzhaF11MWNGRO0wvDYznHdsW2kArnnRUbj7YOgN275B4zjJFC3CTBLIOWXceevNv
	 ywFoR+Un86d1YhuWkASAn+O/877KWQg557H9XCepsyRuYesxTRrIO7Edf6QFjg+7yO
	 Lwu9LRJ5Gf2mkzHDGplNUS0gKOAZsWUM97fEkf1qXTTXYYJI/wFPwHVP4fX1fXCkxW
	 lAeO0beiPKu8ILW7qwAWjetBJu2zvpidEc+ZnnsT/ZV/ZMPncEReT9/zswA2TkOzgh
	 PZtJtwE185bMw==
Date: Wed, 5 Mar 2025 14:43:46 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: [GIT PULL] HID fixes for 6.14
Message-ID: <0o3np45o-r9p7-s59s-0oss-opn264op2ron@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025030501

to receive HID subsystem fixes that should land in 6.14 final.

=====
- power management fix in intel-thc-hid (Even Xu)
- nintendo gencon mapping fix (Ryan McClelland)
- fix for UAF on device diconnect path in hid-steam (Vicki Pfau)
- two fixes for UAF on device disconnect path in intel-ish-hid (Zhang 
  Lixu)
- fix for potential NULL dereference in hid-appleir (Daniil Dulov)
- few other small cosmetic fixes (e.g. typos)
=====

Thanks.

----------------------------------------------------------------
Alex Henrie (1):
      HID: apple: disable Fn key handling on the Omoton KB066

Colin Ian King (2):
      HID: debug: Fix spelling mistake "Messanger" -> "Messenger"
      HID: intel-thc-hid: Fix spelling mistake "intput" -> "input"

Daniil Dulov (1):
      HID: appleir: Fix potential NULL dereference at raw event handle

Even Xu (1):
      HID: Intel-thc-hid: Intel-quickspi: Correct device state after S4

Ryan McClelland (1):
      HID: nintendo: fix gencon button events map

Stuart Hayhurst (1):
      HID: corsair-void: Update power supply values with a unified work handler

Vicki Pfau (1):
      HID: hid-steam: Fix use-after-free when detaching device

Wentao Guan (1):
      HID: i2c-hid: improve i2c_hid_get_report error message

Yu-Chun Lin (1):
      HID: google: fix unused variable warning under !CONFIG_ACPI

Zhang Lixu (2):
      HID: intel-ish-hid: Fix use-after-free issue in hid_ishtp_cl_remove()
      HID: intel-ish-hid: Fix use-after-free issue in ishtp_hid_remove()

 drivers/hid/hid-apple.c                            | 11 +--
 drivers/hid/hid-appleir.c                          |  2 +-
 drivers/hid/hid-corsair-void.c                     | 83 +++++++++++-----------
 drivers/hid/hid-debug.c                            |  2 +-
 drivers/hid/hid-google-hammer.c                    |  2 +
 drivers/hid/hid-nintendo.c                         | 14 ++--
 drivers/hid/hid-steam.c                            |  2 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  2 +-
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       |  2 +-
 drivers/hid/intel-ish-hid/ishtp-hid.c              |  4 +-
 .../intel-thc-hid/intel-quickspi/pci-quickspi.c    |  2 +
 .../intel-quickspi/quickspi-protocol.c             |  2 +-
 12 files changed, 70 insertions(+), 58 deletions(-)

-- 
Jiri Kosina
SUSE Labs


