Return-Path: <linux-kernel+bounces-433122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B16E9E541B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD3A163946
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EDC20764B;
	Thu,  5 Dec 2024 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="h8FAkVKy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VAzU7ilG"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A9206F3A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398729; cv=none; b=c0Q93Z166of4C7kcp/E2IftNl9L2+OiamK3xTSjrq7NKeJjbJp2lswwQlIKML1LOsICodXZhQqEKZWmRQzR1dVWSi+b8fQsFvxZbpC7C2nBg3UxSlLIjJXVShjGW9MYtdpQlxboOUEBydeOw4iy6TQKzfhj4C2I8Z8ctF1UFlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398729; c=relaxed/simple;
	bh=XUKlgTLMCEOADZfz19EX5/+PwJ6aDRpXO4YVXavp1ww=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=XVhlMsPJAxKp1//WiqR4SdF7s2bJUOtzzyBn1v6DRty17xPwcuvy6HgdixReIDLts5aI4+isesIQCYIkYLL6deWYaACV3bC29hXrBwTeK+LMgJI0Fdq0oOvD6hG3VMXcZoPo2dAYQAiegRKftfXi9Had7SoS3L2qaa+2jFX0Rb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=h8FAkVKy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VAzU7ilG; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 740592540223;
	Thu,  5 Dec 2024 06:38:45 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Thu, 05 Dec 2024 06:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733398725; x=1733485125; bh=XUKlgTLMCE
	OADZfz19EX5/+PwJ6aDRpXO4YVXavp1ww=; b=h8FAkVKyx34jfKf9zP3ydxb6vC
	eyQorMDVTkYwML5tArKKDnT1PNtbPi4IaZar7HL80LhcnxBZpqEmDr5EfJVRPcdu
	vrdsfFWxBX5a9yRsR+7JONMwYO6WhAOgV8d+/Ol3+PQq9Uy1LI7tJq91mfsPRolL
	OWRkGrZ7UVuVlf6uTqODOhbg+rqeBlOY2mFvaWfWSqm0AOvAN1kEqNeZh2gkjy/2
	lN4crMIPqGjOj8xeA1TJJCDUmRjxvaFmYHcsvrk3snbhvP2OzTlRDfuw/z+KwgdA
	auiZhxGDQ5gkjuN+HKpjGQY/EEYtWyJZzebyxM94gzcZG66v/O98SF8qt38g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733398725; x=1733485125; bh=XUKlgTLMCEOADZfz19EX5/+PwJ6aDRpXO4Y
	VXavp1ww=; b=VAzU7ilGv4zM3Icq8g3Tch2Q5XzWJO4NWfLZygtduhk43lz5Xb4
	VtpqhfEQ12Ev4t0Tl3HqSXwFjK+rrTaQLLMsirMxOVN3SH1sLeqs7G/wlvQ9kfB9
	gBJMVuESpFwsyA3oDHuiu68CA/Xu1QsrqvQKl4TVg+8Pc3v5aRHlfuol6D0ZBYpW
	sZI5Dtl/KAMOe0y75+e36gwp2Q2uT6FM/DqSgTm5Fd5FpONoED+ddfUXz2NT7S42
	hl8g+MoV7iBZG2d62UcSY/rZJHoZBOiDAZvGAZSrFbUODsLFxfonTAaJmJ5qJXmk
	6LpOonJdwqX2dWjvRimOvk0w2V0U8APQAEA==
X-ME-Sender: <xms:xJBRZ60PgISd1vabFWh6AwjzwQiLZfHBeF-RgB_IzDZl_MNJzTIVgg>
    <xme:xJBRZ9E2Djon4-GtOlUr3PhBoXXJ5netkwQwq5l91aV5Y7pylvCri7s8-gg4WcDFJ
    22eGCaG11DizrY6KDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddvlecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:xZBRZy51WTvoYbV0ZRXvxfGShmvQhXfDwGUKmYH-GT25j9sJbQO_5g>
    <xmx:xZBRZ72kqdOuJWT8Lajd7xORpmcW_0Z36XHNWaRPPfJhYRFXPApd3Q>
    <xmx:xZBRZ9G2vIkbWuHI9e8G0FFNIB4QIE5R7NtoObJxN2loXHnFWdXqcQ>
    <xmx:xZBRZ085LHlkinZ90U7Xh0jq6Z7qxFx0HUf8v7cASpYzAiq2oS0ZVw>
    <xmx:xZBRZyRt3-6NWXHnKLM6LoGRNUE7tO6RAnzyF6rqfBbpga1aer2dPPF4>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E416B1C20066; Thu,  5 Dec 2024 06:38:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=777717baf60b770709a69c8789c3bd0aa54c5facf18bed1d263cb3f606d4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 05 Dec 2024 14:38:36 +0300
Message-Id: <D63QK91VZ3BS.3IA9R221PTFE5@getstate.dev>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: "Mazin Alhaddad" <mazin@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
X-Mailer: aerc 0.18.2
References: <D63F6G8FUI2Z.30SG3KT5F58CE@getstate.dev>
 <6751189a.050a0220.17bd51.0084.GAE@google.com>
In-Reply-To: <6751189a.050a0220.17bd51.0084.GAE@google.com>

--777717baf60b770709a69c8789c3bd0aa54c5facf18bed1d263cb3f606d4
Content-Type: multipart/alternative;
 boundary=88aabb080e624fe68ddd99ee82f27b6ced67bc9be3dfdd34d50caa541c05

--88aabb080e624fe68ddd99ee82f27b6ced67bc9be3dfdd34d50caa541c05
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--88aabb080e624fe68ddd99ee82f27b6ced67bc9be3dfdd34d50caa541c05--

--777717baf60b770709a69c8789c3bd0aa54c5facf18bed1d263cb3f606d4
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
--777717baf60b770709a69c8789c3bd0aa54c5facf18bed1d263cb3f606d4--

