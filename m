Return-Path: <linux-kernel+bounces-205169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC38FF84F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CA21C23B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193A13F42B;
	Thu,  6 Jun 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Ozhe14ne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RvRJ654r"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1113DDCD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717901; cv=none; b=PIEuU//m2sLy2buvGNir1PGTXgx6czfg5+5W1dhE1LgpG2PMHWlMfMGgh+NQZ6rpMb9xxJA5pbhKLNQoUOFzDb/jZqswn49SM+nSEtDbB3gqilvhU+rUSSs5EUAIc10suUkEeDjP+KSLwf2MlC6crUHN2PtXogGvj14y1gVNci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717901; c=relaxed/simple;
	bh=ABohHHYnFGCHQQ0QDcs3l3ntJWi1Qy/K6W1Ae0bUfnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lowSTWa8pJB9warlKWQNYAz7O3dKgNF8Iz+nXmg9Fe1BKlO8UzYDUprg+t08hGpOBiN6gyhyMAcYyWBb2ryNCsAIKOb6GfnZE88MOd1kHt6MaLvd/glOg8zbQ93LGIDMpADBDRQ1AIh7n+KYJNoPsdDHHdmkD8psRK68UJXLnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Ozhe14ne; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RvRJ654r; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 16A3E18000BD;
	Thu,  6 Jun 2024 19:51:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 19:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1717717898; x=1717804298; bh=sbGYsNm3EA
	X9zOM5lpa8OVKFNwjt6nSlwmTErxltP9E=; b=Ozhe14neVtqdfE6HxMlDBpme2t
	UspFX9oV4hSNMM0iQQSFkP3I45hz/GoFbe/L06h7uA361EtLf3YvYQKY2kadm/hH
	mnY9gG0/jkpy41NIpyTJYfSp9AfoCTIEE8VbeoumvMO397LVooDXFiAiJX9Ju1Rz
	DyJ6l+XxcZWuDZKNn8RDoHHnI3mR7qQMQWp5FpKMhreHwwOzEXKax7YFZEqtfy7H
	b7xr4oq2/5MwCe2RmRL826COYtiHU8PFJeOzPFV0aR/3i80C0SiGwwaFcMKbbq32
	OOxtk5FdH1lZfJsalpF5hQ9h2QwcJNPH8Cfgi0H8H6TwQUC4/CSWn+UAQl/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717717898; x=1717804298; bh=sbGYsNm3EAX9zOM5lpa8OVKFNwjt
	6nSlwmTErxltP9E=; b=RvRJ654rPuK4cXr1gcIE9Bpf7/rmZ0CqUfL+mnVxSwQQ
	DfWi1pj/2P7d7BRmkqWvtHkx0LejkYXUVSUcYIKQMNjjUqIbyA23FUhfB257/ui3
	pG+FBiCjewuDM4skM91/hP1JqHCmZ6NuDnvZPDlt8a5ilG4YiQMrX87VYkGSfy12
	sWfZiMacavcE2IX2LO7IYIdMzH/+G8VFKhBtoHE0FFgKkxApE/WmU82TWEI/cvw5
	jyZe4NVVzMJZTnoD6y+3d83uadXkJNqhVZWzgQGvMkTgX5ueDliUxuxFSuiU8w3R
	Ax92SLexaIuT9jtdqrdD00WNRf2fWBBrglwvzwCb2w==
X-ME-Sender: <xms:iktiZtQ1TyciYjdZIvjiXQ6K69e3rWXzNYzJwrB2YLIJhDgsfI-i1w>
    <xme:iktiZmx_fKbdcc8_4uEasX0Pw-X9tvFYu0ckwEOwy-o2m7LZnQSAbxQm5U4u8t3js
    JxdJkOm1U_C6eMIW7c>
X-ME-Received: <xmr:iktiZi2hbdQH0htPzpSEXsp9DUF2OTedyIsN917qypx61BRgMY24nhoxDRH91ElNk39IXRdVO5fEmwNpbm2tBZx2PjtFG_AaMjEYb4uvM6iV5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:iktiZlB629F4SpCCiDuNgsQ3kPhgDmNAeNH2RTAdOg3_tHa9N6hD5Q>
    <xmx:iktiZmi4WuhaH9Tf0T0KyeuWwbwjJBTifNqmdDAlHEwJqtQgGRI1Jg>
    <xmx:iktiZpqQFCGcx51z4KRjmmvoPMNUrNzQVUxvVCeDpOWrfGKWTqU83A>
    <xmx:iktiZhh_QdymlzSURVFARojBB4bifAgSgyb4D3DzRZF_g8tsEtfbHw>
    <xmx:iktiZptqDUhSFUqg-VBoQILGLkfcyg2A387rHEo5QP_4dcIzJsLrS9Sl>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 19:51:37 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firewire: add helper functions for phy configuration packet
Date: Fri,  7 Jun 2024 08:51:31 +0900
Message-ID: <20240606235133.231543-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In recent months, the batch of helper functions was added to serialize
and deserialize content of packet in IEEE 1394 protocol. This series of
changes includes some helper functions for phy configuration packet as
well as some KUnit tests for them.

Takashi Sakamoto (2):
  firewire: core: add tests for serialization/deserialization of phy
    config packet
  firewire: core: use inline helper functions to serialize phy config
    packet

 drivers/firewire/core-transaction.c       | 22 +++----
 drivers/firewire/packet-serdes-test.c     | 79 +++++++++++++++++++++++
 drivers/firewire/phy-packet-definitions.h | 55 ++++++++++++++++
 3 files changed, 144 insertions(+), 12 deletions(-)

-- 
2.43.0


