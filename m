Return-Path: <linux-kernel+bounces-238520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC60C924B7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847B9291F6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600811DA30F;
	Tue,  2 Jul 2024 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="iKWSpVhK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JCOExWfq"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B301DA302
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958842; cv=none; b=o2Mpjk8jWN6eQXL7jAT/iEHdXjpVgRAd1wbcI+DXSt9YmUNXs0SE+MrN2XUYvcAm2ZIO8qJE2wCgBaBFvdNfNfmxQa6b8uapN7gn4IEZv1lxx7SLgzDmgIFn7P2KPKzqvgEg/b6vL+tzmvFFPXXv2304vFSR8Q0FeF08vqnD928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958842; c=relaxed/simple;
	bh=IXuwLsssN7ArM74s6YbeUpSV/DmXW1rDSxuIb5EwPgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjZJAAAvMZkRNEQGpq087R/Xj0OGUXHe8ckQPPryLsHClwBA3K+7l4uFiOh6w1e4oYZW6fz85HMXqcCYv7R14tkyKI2o8+qiiEK5BSJh6Sz1wNbrF8xH1XYn4vxO77aK0/PkLtEOHFszkbVPzoLuS7AlHYZEvyMd7KqdLK4i0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=iKWSpVhK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JCOExWfq; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0EC7513802B6;
	Tue,  2 Jul 2024 18:20:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Jul 2024 18:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1719958839; x=1720045239; bh=FbUUc7fyTE
	Al8NSpPBXd8iaJGVOMNRvxvKZqlBnoc0c=; b=iKWSpVhKKRKBtbjdlZ7a/kzW49
	Q8sXiDDqCxdIoD94ZDBs/cW41x21bOFXbcPdfj9IUM9EGH2hFnJo7Wx92erE7QZf
	3y7coZ4oxaW06p/vZion7c6kt42RpS3m3Yk+TI7dqOTN1g9IbjDG/mZ79N2Euwvf
	y1ZanrKflPQajIioF9nFM5dQJsfnWz5OsgoLAIwMZd0djMbqKxwQTKFgUc5Fh9qG
	4Q3OcotOh1PUSptIGjOFbxloiJPE6pPeh/MgflnQ9NtlLY5dF5BppIIOqBW6RPVB
	aOhwx/qokyvw9J8GUvWb7sSpYAyQ2d1cYIb7+G/a/YyxPfiENYaEpinKG5mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719958839; x=1720045239; bh=FbUUc7fyTEAl8NSpPBXd8iaJGVOM
	NRvxvKZqlBnoc0c=; b=JCOExWfqt1FcGbs9Zs/YxlCzvTgnODRR84gd845riiNu
	LHcHIepgud1gNKdBTakoOz30sxCdpKoPMzQURryk07l0f43P8Xr0nF9SAQH5CN9s
	yfEj/pbWcoJQ6F/7OXyoAT/H5QmifrcKiLqSX4/Kibf9NeiPwYAxeXuNiFZzOxYW
	GBY9pHZDrqdzGRxOYiDpVDFPNlIjg2yrWzICuV2Ju2DPDSICD6L3yvYU53/+XkyL
	CU9SZuc1z6HRRRtsa1VNz/I8oamf5orvosREadPfzxZiMf323PAcMSsbI6RTMDYR
	roz8+wHFGTTd738gaAmEfpHwbq0UfUEPmyjPF5SitA==
X-ME-Sender: <xms:Nn2EZrH_PLp5G3CWmgW_4HwILVePiCs7wca93LM5UF2PUcRKPXDQbg>
    <xme:Nn2EZoUA1JZVu-d5RIIt-ES8FSNd6SeY_-HUTrvWA5Wmm8k_qT1Z8LgaspT6WS5_v
    JdSs-6hFOcSgMIjOYA>
X-ME-Received: <xmr:Nn2EZtIOuHjGxvOsHNBE_mq0cMPpD_zpGA2L7ZEkdJTysV8xO8sS6anvnBga-ErwquL7DMbrDvUY4srvjOctUYJ5c0kfD7-3BYMdD0bPy0tAeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevke
    duhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Nn2EZpFnKs4wLA9H5BGb0GwzLKqESLyQ14jBHOCuRxPbJpCSQclxcA>
    <xmx:Nn2EZhUjClUkWrn9MhQi3jNSxRl6XOxX-NnDVqEtUDQKAomH_6vWVw>
    <xmx:Nn2EZkNqGF-ofSRQ52iq6zwoShDutv8OXiejvhBhNgM1OCVmmJDqSw>
    <xmx:Nn2EZg0CP-84qk7G2hBxhPPeTtwL0UqiSv_5EIhmyPVourbwyRw3FA>
    <xmx:N32EZuid7BtwwxOAIP9GbRNe2tBhKa9ep33DrB1SO0832DuYPppLzOqj>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 18:20:37 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] firewire: ohci: add tracepoints event for data of Self-ID DMA
Date: Wed,  3 Jul 2024 07:20:29 +0900
Message-ID: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In IEEE 1394, Self identification process is the last step at
bus configuration process initiated by reset. In this step, all nodes at
the bus broadcast self-ID packet according to the new topology. In 1394
OHCI, the contents of the self-ID packet stream are transmitted to host
system by DMA. This is Self-ID DMA, and configured by two registers,
signaled by an interrupt, has a format of buffer.

Software handles the interrupt, then parse the contents of self-ID packet
stream to detect all nodes in the bus. Finally it starts any type of
operation in the bus. Both the timing to handle the interrupt and the
data of DMA buffer are important as a first step to use the bus.

This series of patches is to add a tracepoints event to trace the
interrupt and the data of DMA buffer. It would be useful to diagnose
some kind of issue related to the self-ID process; e.g. hardware quirks.
I also expect it useful to investigate the timing issue between hardIRQ
and softIRQ contexts to process the contents of self-ID packets.

Takashi Sakamoto (5):
  firewire: ohci: use common macro to interpret be32 data in le32 buffer
  firewire: ohci: use static function to handle endian issue on PowerPC
    platform
  firewire: ohci: add static inline functions to deserialize for Self-ID
    DMA operation
  firewire: ohci: use inline functions to operate data of self-ID DMA
  firewire: ohci: add tracepoints event for data of Self-ID DMA

 drivers/firewire/.kunitconfig        |  1 +
 drivers/firewire/Kconfig             | 16 ++++++++
 drivers/firewire/Makefile            |  1 +
 drivers/firewire/ohci-serdes-test.c  | 56 ++++++++++++++++++++++++++
 drivers/firewire/ohci.c              | 60 ++++++++++++++++++++--------
 drivers/firewire/ohci.h              | 43 +++++++++++++++++++-
 include/trace/events/firewire_ohci.h | 54 +++++++++++++++++++++++++
 7 files changed, 213 insertions(+), 18 deletions(-)
 create mode 100644 drivers/firewire/ohci-serdes-test.c

-- 
2.43.0


