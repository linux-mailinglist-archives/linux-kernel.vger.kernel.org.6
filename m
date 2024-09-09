Return-Path: <linux-kernel+bounces-321557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97520971C06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38091C232C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F91BA87D;
	Mon,  9 Sep 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Wvd2ctDs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n3IL8//j"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A151B5826;
	Mon,  9 Sep 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890425; cv=none; b=dlskBI2l7+JMSl4QvN7i4gnjU1JkXopPKQ1hx8ZVBO/eswUTbHpW9KZCk3G4WDKh+Tr2eANGCSqhPoOc1/RnvuGHpeqX1LzXeX7N93e3cQgRWb1A8VX8N2ZnUQ+gmySbihBKxQIXOjXMnIjzrAA6G4JwcxeezKeutuSSZcbkpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890425; c=relaxed/simple;
	bh=AUj/qDTEGwIzQH6l4V8JXJ8sjbho/Smw+/CfA9yfPCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bxyed8Wc68s3piZpcYnDerg+ND9acnplcrm2h7it68RBRDZfhHpA1WiZZcapXKAwKuRYrUt61Jc2x8iyN4oaO7Xa+hz0bPXKdKbR4YxIKreZcVbOblQfz0eIkNVP3Xz6Q8tTa/bxhbTThXU/wkEJSYzHk1Vy2s8wq2xQ38F0sgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Wvd2ctDs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n3IL8//j; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C7D9D1380207;
	Mon,  9 Sep 2024 10:00:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 09 Sep 2024 10:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1725890422; x=1725976822; bh=oU9d5e0Jzv
	vz62Zmns3G3+XGJan1Q52qH2zmhn7bogU=; b=Wvd2ctDsDPiQMk7+3QKhkIqn1s
	r2WpcDDOUev1/qQ3xo1MSmpS/0qK4JlJTqMlt4gcpoUzxqSJ28sel7Fj0E/uMFly
	uxIKfglm/fPSlm+DNdQ+V+FFcV+TtS+yRTDhWS6DR78AT2S0ZpFy47jhGyW/JL0j
	rlbsxIQB/MgZqVwOnks3tmnGXsgsyQiI2gmBZt3JnpgkXHUVx4iMrfJjIfhntlTr
	47fsQspGmmD4DerJbpy0pJswaS7SGNhds1+afYxPLyzrz9G6qvVscvYGPEpkDE2z
	2w4DF6NUbGl7ZMXicctzYOHjig6bhfhUp0nInCIlY6Y7URFW6lhDqsJbJj3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725890422; x=1725976822; bh=oU9d5e0Jzvvz62Zmns3G3+XGJan1
	Q52qH2zmhn7bogU=; b=n3IL8//jZZ2LH8W76riiVJ045N7tPWfsHkspgSx0cp65
	4FQPea7IzmD/D8ooarSC6zUbSlUTEgfNr2IPKrjh4B+IC6/kG3nemsj/OPVbwCgg
	OWlMAjskkDNJbovNlDdrLEuDJtXkPGGHra8cPPP/EKO3P2Jizvf+UBHmfmonJmRM
	kggNBNdTBj2TFL8mdnt0r1fz4itbV+dlyPsZlXJJdndWOhNpg/UPTNa4Y0L89dxu
	YEhVSgyYzUD4mcNv8RQO0ywxv1oiCQ79XQUCTsQ7zzU46sB5IU5FTqmf/K/pREkO
	3THxJzXgNtFcxEJ9wZjOm939Xp51RPXkYfOWNtaKIA==
X-ME-Sender: <xms:dv_eZvR6moJno488LL8lIG6B55t_e1gdlj1D1Kbg4YBl_ZRL_KuQ4w>
    <xme:dv_eZgyuI59y7M7VqMBAZRdN7uXZJlscjaTzkPjBvTIzJqUczitESeybWfV5J_aFm
    jVwf5uBJtq5TfZR5ww>
X-ME-Received: <xmr:dv_eZk07AKMFjR92Phvxb2j0hWf8i41rfFZgsqHFDrLPHF89J_O2fsm76rufmRmdvI2GyDo9FZd5WzfJgsWqr758BywUErCTAqZm7B4s8tLVzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohht
    ohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtth
    gvrhhnpeffvdeuleffveekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveek
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqd
    htrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlse
    hlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqshhouhhnugesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dv_eZvDZP1JfrWpVrCXO0Jsf4q_QLgKGvI3N8ZlsG34e9iwQpo9Y0A>
    <xmx:dv_eZogvgagnwOnN3HT1MBvR_1yU70VfIZk_nxdTzZIrQfn0yWgoLQ>
    <xmx:dv_eZjoJ_BGaX1WyeYafMYcQUuSo0VTWu6b-UqFrvl2b8XHL9Snnng>
    <xmx:dv_eZjibr1hldmWlOsylLVK2YTJlLEu9tiTQT2Yw1KpZatTS_UYxew>
    <xmx:dv_eZhucQhxNZkKuMNyq9VFL98RFRTtN0EUjZevaC5aFzLCDd6fAjicE>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 10:00:21 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 0/2] firewire: core: optimize for concurrent calls of fw_iso_context_flush_completions()
Date: Mon,  9 Sep 2024 23:00:16 +0900
Message-ID: <20240909140018.65289-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

It seems to be the last week for v6.12 development. I realize it
unpreferable to propose intrusive changes, however I also realized that
there is a room to refactor core functions in respect to handler of work
item for isochronous context for the next merge window...

This series of changes refactors the core function to call
fw_iso_context_flush_completions() from the work item. It optimizes some
event waiting and mediation of concurrent calls as well.

Takashi Sakamoto (2):
  firewire: core: move workqueue handler from 1394 OHCI driver to core
    function
  firewire: core: use mutex to coordinate concurrent calls to flush
    completions

 drivers/firewire/core-iso.c | 31 ++++++++-------
 drivers/firewire/core.h     |  5 ---
 drivers/firewire/ohci.c     | 78 +++++++------------------------------
 include/linux/firewire.h    |  1 +
 4 files changed, 31 insertions(+), 84 deletions(-)

-- 
2.43.0


