Return-Path: <linux-kernel+bounces-433391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0631F9E57DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523E01677AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD15218EA4;
	Thu,  5 Dec 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="X6b5kmPo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XF9oihwH"
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F9218823
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406716; cv=none; b=EVSB+LI0iSsoZq+S7EoeilAMw0MQoyqCEptrNKZKPwidRF5skf+lMDKx2iUNursynxD+2QDcp9JetGwxJO9/EVF1S6oG1eXbKLliO/tevo2IKGFpAem1SKHtO15RLAjCLc34w7n/ibGjgw5ssBfD5qC/9Q8fUfNOQjZHSYD+c18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406716; c=relaxed/simple;
	bh=Lcc+lLZ0Xgk1xwZVaaOlG7qO7X80bf4SxOl5dduRaJY=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=FmxKGm3uO6ScR+OwWP/jxAMeRsIto1/d4Do1F30GbsoQQjE9bzkw7t56naqEuwku6OKvGP8pAFqihjJnk205axtwATqG38neDDbcFObTcN8WiuLGV/KditXlCniWKYsAdNU7rMmf5g/44rzY6DuY/G/SnEPMEz2TuDOM34hFDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=X6b5kmPo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XF9oihwH; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0ACAA114015B;
	Thu,  5 Dec 2024 08:51:53 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Thu, 05 Dec 2024 08:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733406713; x=1733493113; bh=Lcc+lLZ0Xg
	k1xwZVaaOlG7qO7X80bf4SxOl5dduRaJY=; b=X6b5kmPouXt4cz7I8wMBauODK4
	k258HKPfmKPsCbX0wc/WWoSKx1vkSd8mbCn3owdhEDTrqTiMLs7U1R92Vb2C+ihA
	8HXJIWgCM58/TKb0a5RpuhvbPGiw1Ie3zMByCvj+/HudPAiN4oiBuGqPHLJIyWqP
	DPVN9IJk+5aDGjXHmLk48VMAjQE0rzadVYgG+gZK5BFIl8LQQ7UJXkQZkyQhyTh1
	1RAON5XfaOdjByFQntzDMKfBFcKhYliw3jPhXVT4xwwa7Cof+HNSUQQCs7zIrL9Q
	FBtdflF82O4v4Jbb+Jg9pY9tIKLJSN/NpgjISA9dbpzfnn6R4F+OpFanUB4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733406713; x=1733493113; bh=Lcc+lLZ0Xgk1xwZVaaOlG7qO7X80bf4SxOl
	5dduRaJY=; b=XF9oihwHfdGXw7xmQBCAkuwsmLcXqmNEzNfCOm/uBQ2lzp41LFx
	NWPxCwua9j31ogCuACxapdZE6xK6Mqi/G5JoNEVZEXmmKxhSOJSnQMbN5sLrbH0c
	GXLeipucGALFd4+VBGQhLZbL1Eblr0PG88KTN7WkRbazpwiqWa3mAatn5gBAmAoy
	5ellU7iAmMuNfMBw0m0DwNf2ONNZPtz67GhHHWoIujDjflIpmnqKAAbGVoC/NItR
	7y7jQ+xJMjcJZTHcKWKjHgUYl0suzMDHVAGDd0BX5CuNx4bzGsMrehn8CfoyeWDY
	IdSw+gZpIme0e1usFOsyxfQfYr3gc54v9aw==
X-ME-Sender: <xms:-K9RZ8CR7j2HvUCB1wHEcmKej_sPWw7PezUXDjJhtnTeKe_rJFdEuw>
    <xme:-K9RZ-iqfNrlqr5SZnakAnHAIPv4YzhrM5zyR-fQmUmH6JVq-ubantI6qaRdyi2DL
    0f_RkfO0PUdZ0owleY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgdehhecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:-K9RZ_mM4b1yA3nGEyiiMe6e137WNXRa8Lw7rR4XXKOg5WXRtAgd5w>
    <xmx:-K9RZywoIKaghvwC3Uzu-5iSKYeamTaPRnL4_bUClggjcn_xGG4u6Q>
    <xmx:-K9RZxRnnAzemyIIxeojwSH1z6s1EtHsDL91LEGe4VMzJK6dqh4PSQ>
    <xmx:-K9RZ9Z3isKx7vatZM6mHALOmeu8T6iVGHy6MJMadKxbLZzAZO3rkg>
    <xmx:-a9RZ8fC3dL2L_cVemjhR_AXMMhBP-XhAaSv2zi-q6oFe4fQGLPbWUqn>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A4EFB1C20066; Thu,  5 Dec 2024 08:51:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=574c326ad023cfe968c5a6bf3f4f43e11ba5442334ba3b40c0c98c831428
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 05 Dec 2024 16:51:43 +0300
Message-Id: <D63TE6HWP7IF.2VGLGANFA6OGW@getstate.dev>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: "Mazin Alhaddad" <mazin@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
X-Mailer: aerc 0.18.2
References: <D63SC2SEH0D2.Z2PVQQCYDRF3@getstate.dev>
 <6751ae23.050a0220.b4160.01d4.GAE@google.com>
In-Reply-To: <6751ae23.050a0220.b4160.01d4.GAE@google.com>

--574c326ad023cfe968c5a6bf3f4f43e11ba5442334ba3b40c0c98c831428
Content-Type: multipart/alternative;
 boundary=b64e7c12cfa0ddae1dc44fc5d6c20bfc777118bbdbe8711206a2dfbc322a

--b64e7c12cfa0ddae1dc44fc5d6c20bfc777118bbdbe8711206a2dfbc322a
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--b64e7c12cfa0ddae1dc44fc5d6c20bfc777118bbdbe8711206a2dfbc322a--

--574c326ad023cfe968c5a6bf3f4f43e11ba5442334ba3b40c0c98c831428
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-TEST.patch
Content-Type: text/plain; charset=utf-8; name=0001-TEST.patch

RnJvbSA3MWRhNDYyODY1YTAzMjQ3NmQ4N2I1YmYyMWNlNjE5Njg1MDJhZDM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXppbiBBbEhhZGRhZCA8bWF6aW5AZ2V0c3RhdGUuZGV2PgpE
YXRlOiBUaHUsIDUgRGVjIDIwMjQgMTY6MDA6MDMgKzAzMDAKU3ViamVjdDogW1BBVENIXSBURVNU
CgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9ibHVl
dG9vdGgvaGNpX3N5bmMuYyBiL25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYwppbmRleCBjODZmNGU0
MmUuLmYyYTQzNzYzNiAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9oY2lfc3luYy5jCisrKyBi
L25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYwpAQCAtNTE5Nyw2ICs1MTk3LDEwIEBAIGludCBoY2lf
ZGV2X2Nsb3NlX3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYpCiAJICovCiAJZHJhaW5fd29ya3F1
ZXVlKGhkZXYtPndvcmtxdWV1ZSk7CiAKKwkvKiBmbHVzaCBjbWQgIHdvcmsgKi8KKwlmbHVzaF93
b3JrKCZoZGV2LT5jbWRfd29yayk7CisJaGNpX2NtZF9zeW5jX2NsZWFyKGhkZXYpOworCiAJaGNp
X2Rldl9sb2NrKGhkZXYpOwogCiAJaGNpX2Rpc2NvdmVyeV9zZXRfc3RhdGUoaGRldiwgRElTQ09W
RVJZX1NUT1BQRUQpOwpAQCAtNTIzNCw4ICs1MjM4LDYgQEAgaW50IGhjaV9kZXZfY2xvc2Vfc3lu
YyhzdHJ1Y3QgaGNpX2RldiAqaGRldikKIAkJY2xlYXJfYml0KEhDSV9JTklULCAmaGRldi0+Zmxh
Z3MpOwogCX0KIAotCS8qIGZsdXNoIGNtZCAgd29yayAqLwotCWZsdXNoX3dvcmsoJmhkZXYtPmNt
ZF93b3JrKTsKIAogCS8qIERyb3AgcXVldWVzICovCiAJc2tiX3F1ZXVlX3B1cmdlKCZoZGV2LT5y
eF9xKTsKLS0gCjIuNDYuMAoK
--574c326ad023cfe968c5a6bf3f4f43e11ba5442334ba3b40c0c98c831428--

