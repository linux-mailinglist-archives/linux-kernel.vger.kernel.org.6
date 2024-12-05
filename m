Return-Path: <linux-kernel+bounces-432519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096B9E4C67
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E51E1651BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF98217C7B1;
	Thu,  5 Dec 2024 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="YYdHrQSV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4Ilsc5o"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F11BE49
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366616; cv=none; b=kxxWw/9yTcucb1rpjpMk2YW0Euy3985QqMA98pT1sHZc0pZS00oUX96xgJfZiGGuMNMPXfzDDXDGyJ6i1xgp9LrVdpi1LDRsvUdKnD0oVFbs9Tg1R3KCeNpbEP0vqAsIcgObVveB2kj7yIidP6nYiOReY50umdgBZCgKtxC2XSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366616; c=relaxed/simple;
	bh=/3KMUXiv/onm7pmIKXEy7hcehO1oksn21wGDCMJg75w=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=BhwlSGEmSiY6jLOxWQpkNJB6g4Ejcks84UJNk7VG80s2iMjQswVsYm4+PZHqvLeQ78e7Aurf6+1BgMA3vBkly9ukTvsYAI2H8u96sI6BrbdpSj0LX7Ohwj6wQeiBcIWsAqtppkGWVioW0KrRJexqmbviN0BNQRMG2PeMCMH2K1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=YYdHrQSV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4Ilsc5o; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE73A1140179;
	Wed,  4 Dec 2024 21:43:31 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Wed, 04 Dec 2024 21:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733366611; x=1733453011; bh=/3KMUXiv/o
	nm7pmIKXEy7hcehO1oksn21wGDCMJg75w=; b=YYdHrQSVxVt3IiX+tYUCDdTxL5
	h/e46vf/Y7XWHFOonBR9yxeJsHv5TwwJ4Svga0231CACs/NflKiw7eTdT1l2H+T0
	+vhQCcDRvMhMF1iuw0sp/hsgbVQOugu5YDYcGRfZHmuG7zdmGkvD/1moE0goTydj
	q5F9qxALCnbor9Xh8UM0do0NERimArVI4AFtzn69x0feUR1um/2KKe/XBmUqtkOD
	ccoheqKG0B4i8+t/6VJ5Vkr2vHwL1hd1+oAohfpxpQvSPTB3M3EasxkfeWYDOjsO
	Txt60SjwL9c+QU3QRrBer3BH9TE0p900aWh+SqOBB7vPYXCZJFnfVqNl/ong==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733366611; x=1733453011; bh=/3KMUXiv/onm7pmIKXEy7hcehO1oksn21wG
	DCMJg75w=; b=T4Ilsc5oVoFR2LFa9hncnofn4IecpTvvfDUCX8E9SF/Irz17TyN
	aUv/8ZC2rI8PVjotYAhxnqaiUwfw5kExig5yRTP4k+B1Kx88ydNGqGKUnV6Tpd+m
	DFl45fo4oMNoUSthd4Bnih2gqyVzDQE1/RJy2+BPNDTjXpu8FVUzJrXJzAY+FscX
	G+3LpBLEgEUvgPzbEVCxuyrVyfNWqR+VrKAgZeUPBG2Rtkt6XFXB0l5IK8skacI7
	+cvhWTuKDHEnlGnx1nv7DAxy6vFWOtVgAIqqdH/6/xpcFDtsXwQL3gP3vRfySNgR
	+LCJdGQVdE2m84sl1tNtdt74ox1LRnUo4Cg==
X-ME-Sender: <xms:UxNRZ7-VQP5jrwvYiGkQtMCCBK12JKBBLgpvn1NOJbg7qzbPui_nQA>
    <xme:UxNRZ3t4Ez6A7UcPeUW_zSS3LmqvfH3VX6Hs5GgPZ5HBp9ZHYgDqv9DRj8yz4lw_M
    aiovB_piGmhACTTiFU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeigdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofgtggffkf
    fuhffvofhfjgesmhdtreerredtjeenucfhrhhomhepfdforgiiihhnucetlhhhrgguuggr
    ugdfuceomhgriihinhesghgvthhsthgrthgvrdguvghvqeenucggtffrrghtthgvrhhnpe
    ekgffgtefgjeehffeiveelveegfedtheekueffffelleeffeeitdettedugfffvdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgriihinhesghgvthhsthgrthgvrdguvghvpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshiiikhgrlh
    hlvghrqdgsuhhgshesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepshih
    iigsohhtodegjeelrghffhehudgssgefieduvghfhegrrgdukeesshihiihkrghllhgvrh
    drrghpphhsphhothhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UxNRZ5AmTZ83vFCc8mVvsPwbNVjkdE3qV6qL7tYBuZc71c9tMWXaHQ>
    <xmx:UxNRZ3c3ItbfO8lhMucguSCsUaRBxnSutuE9BlK-25jw7HSK8FDkjA>
    <xmx:UxNRZwNMXnoyYQATBt2mtBwQsUmDg-h5Z21x1qVTJvwWky_KKMFMww>
    <xmx:UxNRZ5mrGwCRmgSxarVgxhlZrzxkU14ceVVhB9LLiXVI6jj7OWGv3Q>
    <xmx:UxNRZ5a2l-1ucex4lWwAsOTgbUF6WI0Fio07qMxd1l8ZJiJdSXS-UNKt>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87D761C20067; Wed,  4 Dec 2024 21:43:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=81f49b2126aa99b6efbdd69ddca6872aa18301c548347c3c68ff459891de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 05 Dec 2024 05:43:22 +0300
Message-Id: <D63F6G8FUI2Z.30SG3KT5F58CE@getstate.dev>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: "Mazin Alhaddad" <mazin@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
X-Mailer: aerc 0.18.2
References: <D63E89JWB8QV.38E70BVWNMMVL@getstate.dev>
 <67510ec3.050a0220.17bd51.0083.GAE@google.com>
In-Reply-To: <67510ec3.050a0220.17bd51.0083.GAE@google.com>

--81f49b2126aa99b6efbdd69ddca6872aa18301c548347c3c68ff459891de
Content-Type: multipart/alternative;
 boundary=bf2dcb30b4b284543cb1f1dbd0a62a86ef2ded9a989d0b29b147d731132a

--bf2dcb30b4b284543cb1f1dbd0a62a86ef2ded9a989d0b29b147d731132a
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--bf2dcb30b4b284543cb1f1dbd0a62a86ef2ded9a989d0b29b147d731132a--

--81f49b2126aa99b6efbdd69ddca6872aa18301c548347c3c68ff459891de
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-TEST.patch
Content-Type: text/plain; charset=utf-8; name=0001-TEST.patch

RnJvbSBkZTc5YTc1YjkwY2MxMjEyOTNkMGM1NDM5YzA2MWZjNDkwOGYxODhhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXppbiBBbEhhZGRhZCA8bWF6aW5AZ2V0c3RhdGUuZGV2PgpE
YXRlOiBUaHUsIDUgRGVjIDIwMjQgMDQ6NTU6NDMgKzAzMDAKU3ViamVjdDogW1BBVENIXSBURVNU
CgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290
aC9oY2lfc3luYy5jIGIvbmV0L2JsdWV0b290aC9oY2lfc3luYy5jCmluZGV4IGM4NmY0ZTQyZS4u
MGFkN2JkMTdhIDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMKKysrIGIvbmV0
L2JsdWV0b290aC9oY2lfc3luYy5jCkBAIC01MjM1LDcgKzUyMzUsOCBAQCBpbnQgaGNpX2Rldl9j
bG9zZV9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQogCX0KIAogCS8qIGZsdXNoIGNtZCAgd29y
ayAqLwotCWZsdXNoX3dvcmsoJmhkZXYtPmNtZF93b3JrKTsKKwljYW5jZWxfd29ya19zeW5jKCZo
ZGV2LT5jbWRfd29yayk7CisJCiAKIAkvKiBEcm9wIHF1ZXVlcyAqLwogCXNrYl9xdWV1ZV9wdXJn
ZSgmaGRldi0+cnhfcSk7Ci0tIAoyLjQ2LjAKCg==
--81f49b2126aa99b6efbdd69ddca6872aa18301c548347c3c68ff459891de--

