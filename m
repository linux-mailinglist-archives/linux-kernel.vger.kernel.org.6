Return-Path: <linux-kernel+bounces-282478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19C194E487
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4185DB210F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03C535D8;
	Mon, 12 Aug 2024 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="UVg+UuwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TTVVxOuv"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD8136A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723426979; cv=none; b=r6JM6WI6gbmX5FCfYrJiLaocGI8v/RZ4Pg395NEjn2sU3EGQuAldB/p3qyDc0+E2vre7qEaqXZgEzBZmNc6qfvM+JOPn9st6P0z7knvdnvnHnCLDHcFT0pVAhvYTIIgwZsBxLjc3Rjdj3Zz/byI+z/ufDD/D+q5FrPwl/5j4Ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723426979; c=relaxed/simple;
	bh=iGAVRTv2YBt6rFUVw3sBsDtefydXj6YvB6uHBOGCdX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/PKCFKpts6huMZKotXeUo3xfNXbPJhp78ruLge1FMbPpey/Uinrl1D4Yw0QbOjLB/kDtW9SLG4qXcuGtr7mfK58IZM8yECdMdLeh4wecYyUYnC+4pqQF2pVjUecqGvAhkqe1U57aOTL2lNZGmCaR+jmQ1LzQ2ZQGLxHetNvGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=UVg+UuwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TTVVxOuv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id DA05A13854CF;
	Sun, 11 Aug 2024 21:42:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 11 Aug 2024 21:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1723426975; x=1723513375; bh=ZiDTMdIzAf
	O3sACDBpZRIVM7mN18dHms2sa6dSgiMJk=; b=UVg+UuwZuYPH7KLqT72kJMuz0X
	EkgT954BDNgWRN/L1OIsb5MkzvGoU38j9jBRzHT7XDRUUewm5NjQNYKxvkEpB/Gx
	wWIDtzbjXNE8olB7sMUiE6xBqQRm96kSNxg7zG8r9qU4jGDsD+jeEXqCiXnrP9gJ
	GA66D+CFFtIuDx9FB9Z1t8Vm2K/Li0l1TojmfljQ+FmiymFjNvTGP37NMdK0YPkY
	ugB9hPQ5E1AzYQPgr9SxIFgS1Z4DKS+R/eB33/eAWYbULmWwIDWE67xNnFIQ1pgU
	KBhA0dsrq25JfDRqCXOAuK7EomoxCe6zpCUZ9EKmHkVhU1qHufcPmdmCRVbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723426975; x=1723513375; bh=ZiDTMdIzAfO3sACDBpZRIVM7mN18
	dHms2sa6dSgiMJk=; b=TTVVxOuviZoD62rOeHX++ppFYV35hFaEe+D7jreyKTsv
	Bky0CVDaohhUHoH6KnTVdEqBBH2o/yfMatroiZtzsDEUi3iFIJUyKMT8v3zzWYWO
	cU4iXUWZ4VHowo4o/0G0hV5gd3QvldLGbZUdlnhov8Vlf21gtM6hSvhC4innFTDu
	L3e6DOVfA2xzS9o5jrLWCa+QcBV8jpeyuVnAAUkDSoTg9eEwlXHUzKdTmnIbb0a0
	eLrlflWUAc8eYIdJg7LJblj6mRNMf0dkf0vGjoE35OwZSa+9gxcyS51ZO80tD2H4
	uuxojAjRw2uH/zHF1bZ/oqThXNg3pvVQ/+bYwH66xw==
X-ME-Sender: <xms:n2i5ZoDTOcIZ6SaNoqPOHn6ECRrNdMOaq8HN_e5q_7h1YNy-CCVZ5Q>
    <xme:n2i5Zqgpmuglol0WD1LhGlwKoWDfW6x4ibgsoSKP5IQacW-GUdNVl4RqxwGoNn0Iz
    n3nIRP3hm_lsB3Lbks>
X-ME-Received: <xmr:n2i5ZrkEUZnhORYv6ycDUgzKp_xZYfXPN3RsRVhhtE5nc3QSvGbf1fWQU2nobyqYxkHbesl3XY6papvHxd27i2uC5SZuwPvPAeQV52pvf-N6nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgggfestdekredtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothho
    uceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvg
    hrnhepffdvueelffevkeduhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqth
    grkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslh
    hishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:n2i5ZuykLB-BEbLasE0oSG5SD2GCn0oW5FV5bjP3TxMp_8I7iUZ_VQ>
    <xmx:n2i5ZtQEAlARQuZB8P2wGxF2f3j6Y5TL4FlYKmEy4zGJ49Atb_9Vgw>
    <xmx:n2i5ZpYiia2Nb5wNS1DSzup-9L1PLmSGtCGXPW3G09XyKGP3TAW6Kg>
    <xmx:n2i5ZmQPXIFVK994kiff7BHOqD36S1GKwOGvK0BMs08l7rDdzDScKQ>
    <xmx:n2i5ZodYsawScSv4n_GYStBPD1nDceSodU8YgNFtKXM2nIp8JzSZM0N5>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Aug 2024 21:42:54 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firewire: core: use XArray to maintain firewire device nodes
Date: Mon, 12 Aug 2024 10:42:49 +0900
Message-ID: <20240812014251.165492-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In core function, the instances of fw_device corresponding to firewire device
node in system are maintained by IDR. As of kernel v6.0, IDR has been
superseded by XArray and deprecated.

This series of changes is to obsolete the usage of IDR with XArray.

Takashi Sakamoto (2):
  firewire: core: replace IDR with XArray to maintain fw_device
  firewire: core: use lock in Xarray instead of local R/W semaphore

 drivers/firewire/core-device.c      | 30 ++++++++++++-----------------
 drivers/firewire/core-transaction.c |  3 +--
 drivers/firewire/core.h             |  3 ++-
 3 files changed, 15 insertions(+), 21 deletions(-)

-- 
2.43.0


