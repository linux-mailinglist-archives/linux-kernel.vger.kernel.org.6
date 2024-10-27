Return-Path: <linux-kernel+bounces-383480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002159B1C56
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984261F2196A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 07:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB843BB48;
	Sun, 27 Oct 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="M4skfE0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FGJiSSum"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9CBF9E6
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730012644; cv=none; b=iGsfD2oIkOkDSJNBLrqVNxnwlkzM3b/cvNdTLhA4w7hhxxdo3Ga4YVdMNyyS38ZB0WtpbbNOoOlzl6lSEpZRl9XGsUcWGdiNvcmu0x4j+JL7/v12NTe5Y/MG+4OZRYjET2+oi4gIg9MG0kdeXSKrJv2sGPCRFUK3TCGvk4GxQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730012644; c=relaxed/simple;
	bh=Z6Sny6sNho94dhQDivsDbwsHzUVDSnEpYigOqFSikfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZFERNDH4GNnZMg4z1nVA2wxsrpAIdy10QscqRdu1Y+OkKirAvZzlyEM5chMGhhmU3QSjSHQP4CDgscDgGCCAtEc7QFViZw3j3D8Mo4D1fv/Wez3dZhGz7Y0U7yNwEZtFUniY/upinaCB/YVmMSQQq+jnp2q2EN+ipkegrdEWBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=M4skfE0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FGJiSSum; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8838114013F;
	Sun, 27 Oct 2024 03:03:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 27 Oct 2024 03:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1730012638; x=1730099038; bh=K9B3+On1seQtdoA5l3dwU
	ONjZSYYv1Xr9X/2UyZuerE=; b=M4skfE0eWcWAT8YruVT65zaAzm5NAa38Etqi6
	z2kmgivDB+5CCtfw/iLI8euPHAVCMhl+m2g6osDIPqlKRwQFVS/CwCJQKp6A3Ntn
	t1DNN8lVXRWJJrBMJwllrAZUukT8QXggaYdvAWnsByJ5si/ca9TewDwZPDkWWNS+
	GOqRgQ/GPxLPB+ZnYrSwwXdfOmZiR2BcznVGZCm5LYpNH7eOALh5TykpnJWoQ5mk
	k4zRkK/3vQsneUkrGEHLDBffAF7zqKV5+mZT0UHI9FAgm8WSLguI+5+CtbQFuzNz
	6xhITSbNCQ1nxQB6FkX32B0qLszHiibnYM+JtEimnmOM6BdqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730012638; x=1730099038; bh=K9B3+On1seQtdoA5l3dwUONjZSYYv1Xr9X/
	2UyZuerE=; b=FGJiSSumW4do0A1A98zd1Y20Oocr4PYr6Z0hTRdGW5aRzxYaVz/
	i0oPuC9tyTlqfQ/oeV1wE9791eqY2pdfr6nRQTkdQWbNJ7KGPEC/9gB7x0N4uPx+
	wb+mwqm8lDCA9ZIq5uNI063cOHpnrXBXD/jni5oVL7O2AzR5U5vloUNMvMARwPkc
	4Mne3GsnixQlFInunmdbhHSA2DCxrzL1s9T1a6dyeBsTaLGVZYoVyrb/jTNIwN1f
	8fFtNkQQ6uSArY3cZXwjfj73ukTrZamj3jFpDu5GVNZpmBGmiA8Q5aa1avfRH6j4
	h8FFSeReRTufsHw28xpw5rKdOpKnJGW7leA==
X-ME-Sender: <xms:3uUdZ-w5-3fYwV5If3QYeWGdwTdcDleHb18u1rK4_Pcpmv6lKsNnIQ>
    <xme:3uUdZ6TNhyFNueqS00N6BtACfKk_jxMb6u9mev8e7EsjMYijXEiWTNseIlbp4OtEZ
    RgtdPu1Ce7ld2czDsI>
X-ME-Received: <xmr:3uUdZwU_JAzAUn9MH62F-eTVxi6ivXLR5v3Z97P0EIX1wGDU4cGr7DpWPsHAeQ5cciyyleHQZ7NJHSQ0BQV5-QDRUqh5ezLHTLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejhedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkgggtugesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhho
    thhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrth
    htvghrnhepteefieetfeevgedvgfegffehteeljeekkeelueegfffftdfgtdetteekvedv
    vdfgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgt
    tghhihdrjhhppdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggv
    fhhorhhgvgdrnhgvth
X-ME-Proxy: <xmx:3uUdZ0i_jG_PoPGyHhICJemo5PpO7yhlsE550nyA-jjxjtakQ8mCAw>
    <xmx:3uUdZwDma_Uh10sC1X19aFBsc9PMnowKtdBOpJDdzeIwi7dwwPfKhA>
    <xmx:3uUdZ1KKe_jOyY7rbfORhqoSnJ-_dHHbzpkWZfjDPiYAAFMuwjauow>
    <xmx:3uUdZ3AiFd37in125Y-KiVZmtGOh4fD-IF6b237s5jjGIAalICgqDg>
    <xmx:3uUdZzMoWJRVWbtVRqMCvKTVUbw2WXG-uka6rpCiXJN2wjUJsUeuSO7x>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 03:03:57 -0400 (EDT)
Date: Sun, 27 Oct 2024 16:03:55 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [GIT PULL] firewire fixes for 6.12-rc5
Message-ID: <20241027070355.GA146113@workstation.local>
Mail-Followup-To: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please accept this PR from firewire subsystem to fix a regression.


The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.12-rc5

for you to fetch changes up to f6a6780e0b9bbcf311a727afed06fee533a5e957:

  firewire: core: fix invalid port index for parent device (2024-10-27 11:14:35 +0900)

----------------------------------------------------------------
firewire fixes for 6.12-rc5

This update includes a single commit to resolve a regression existing in
v6.11 or later.

The change in 1394 OHCI driver in v6.11 kernel could cause general
protection faults when rediscovering nodes in IEEE 1394 bus while holding
a spin lock. Consequently, watchdog checks can report a hard lockup.

Currently, this issue is observed primarily during the system resume phase
when using an extra node with three ports or more is used. However, it
could potentially occur in the other cases as well.

----------------------------------------------------------------
Takashi Sakamoto (1):
      firewire: core: fix invalid port index for parent device

 drivers/firewire/core-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Regards

Takashi Sakamoto

