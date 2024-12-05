Return-Path: <linux-kernel+bounces-433218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD0A9E553E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D4E282BB1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495F7217F3B;
	Thu,  5 Dec 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="e7SiaHYJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GmZH2S4c"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88301217723
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401120; cv=none; b=sIMSu3+Ftj5/2gQe5QP9dK+bJfX4Xbu0+DuQpaQRqPi6nAuUX7fXFYL5GW+QiMZCur0wHLgG0ZiK3HXoCPDYgR4QVkFWxMngyCXABVwHqu6Ra366XSaFU0MA6FK0L3mkGEJUWuItz3BWRXCUSIpK7pBci+llf+Mju9CIWlVKolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401120; c=relaxed/simple;
	bh=2v6iqMuVmL1btOIBYYR8znk6IrkE38Ow5yutyWXKAPQ=;
	h=Content-Type:Mime-Version:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=J/znDbLBFMFVwnKsS+QygURJcvCFnK2XmUFWyoYgbOL0romv2MkppUj2xVRprFBTSrTFuiv/QzYTWIp+ZDPEA/YOuuqhb6lk28hkapcla2As0Fvfqvh+sBHtHzJ7oYLruF2hZysxpK+9laj31anvusqamvpZhxp0Vq2j+n22LEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=e7SiaHYJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GmZH2S4c; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C00511401E2;
	Thu,  5 Dec 2024 07:18:36 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Thu, 05 Dec 2024 07:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733401116; x=1733487516; bh=2v6iqMuVmL
	1btOIBYYR8znk6IrkE38Ow5yutyWXKAPQ=; b=e7SiaHYJb51mkE1u6io22TYvxa
	ZKpvkNhACJg0uesErLd7sXVOTXFJV+ykB6bcSrtMHZZQCVeTUNvhK360fNVUDiuJ
	j6ejcgFHZXEF0guGTlshv8rfEm1A5S+UQFuwk2HTptscBU6i3VSFkpn+YOuIhTW8
	zuFj1Gd3cPypU9aI8WcdtToCylHSC/NeTYEA2ZGDDbEXB39JoMrYxCRdvkRHEbod
	Ap9WCaB4EvlBSydfe34cT9DFyHyzKJzjrvXkN3bYbcP1CAk+BPfUUCxa26aPqal2
	bGPPo92ovycSNpgc7xlVv+EdrYdn4pH1m0nIcx/qVajfHoSgC+3abSybsJaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733401116; x=1733487516; bh=2v6iqMuVmL1btOIBYYR8znk6IrkE38Ow5yu
	tyWXKAPQ=; b=GmZH2S4cxZUu+9JykiWE7pDNvNgUTuwvpElGpF+lqt+RibF13SG
	ChsS/LfBthljc+YFCDq7lhUzZQl8kZF6YGUUxcnR/tlg8+iSbPjirbkcnDiZQU31
	eoQl+/gcXwSe0Nul+wg/LirJs0VpxBcIQWm5d7OJ2A1phmnlcgVXXPZLUsoRhZA7
	T760RRrjUQu0VfO06uzPzA+zbgTdTVJCQG6ZdQdR8qaN0Jf9qaH6m3fQuo0Wb35V
	RVTmpAs191IJlQ9aKBO0vTm2EfO6HI+EHfGKN/+eeeOzgSrCv4iKBECwEk+uRtZ6
	rXGbYlJiH+mTPHZOR3wuynJCKGI6V5pQbjg==
X-ME-Sender: <xms:HJpRZwDGhzXi-TC1Zcd6iiO-a47-2k9EIaPdlC5pLUo3niFZhGmyeg>
    <xme:HJpRZyhqqZY9URINius0bCVCr0lFwnr_JSELvosdo7gCFbzWOwv4S3TavbibzLBCf
    eEXqQAK9L6RhLD8QEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofgtggffkf
    fhvffuofhfjgesmhdtreerredtjeenucfhrhhomhepfdforgiiihhnucetlhhhrgguuggr
    ugdfuceomhgriihinhesghgvthhsthgrthgvrdguvghvqeenucggtffrrghtthgvrhhnpe
    ehieeuhfegieehtdelkeeihfekledvvdejhfduvdekjeduteevveehvdevfffhudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgriihinhesghgvthhsthgrthgvrdguvghvpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshiiikhgrlh
    hlvghrqdgsuhhgshesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepshih
    iigsohhtodegjeelrghffhehudgssgefieduvghfhegrrgdukeesshihiihkrghllhgvrh
    drrghpphhsphhothhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HJpRZzl7wt-oewYvZJ0-4LGW28s_YlRcsWXZFPMT1awoAnAAv7FW5w>
    <xmx:HJpRZ2wZ80uNZVqWDJACmI3d3I48A9saDr4S2nyYucTKgAPj5VYJYQ>
    <xmx:HJpRZ1SfLBN8x_VNWyFWLWSN5Ehcrdy71OTSjG1uti7oiQw_WxYPOg>
    <xmx:HJpRZxbre3uxVbFERHfwM05ZF5l_0VlQ6NMmpExf0RF9faK1WGYFsw>
    <xmx:HJpRZwfDpB8gOYG_paQldk2E2ybG6CwSmZKuSXgc3lb6RG5CCjBC-wLP>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1B8BE1C20067; Thu,  5 Dec 2024 07:18:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=e15f8747848842f31d56e6ceecd76e8eb01a93244ad866e5c839dfc6342f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 05 Dec 2024 15:18:27 +0300
Message-Id: <D63RERM1B1U9.YBW3S55TUSN7@getstate.dev>
From: "Mazin Alhaddad" <mazin@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
X-Mailer: aerc 0.18.2
References: <D63QK91VZ3BS.3IA9R221PTFE5@getstate.dev>
 <675196b3.050a0220.17bd51.009c.GAE@google.com>
In-Reply-To: <675196b3.050a0220.17bd51.009c.GAE@google.com>

--e15f8747848842f31d56e6ceecd76e8eb01a93244ad866e5c839dfc6342f
Content-Type: multipart/alternative;
 boundary=286148bfa00de18ea0dbfa120ad62db96baed4905cd8dd4e75dac9993687

--286148bfa00de18ea0dbfa120ad62db96baed4905cd8dd4e75dac9993687
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--286148bfa00de18ea0dbfa120ad62db96baed4905cd8dd4e75dac9993687--

--e15f8747848842f31d56e6ceecd76e8eb01a93244ad866e5c839dfc6342f
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
--e15f8747848842f31d56e6ceecd76e8eb01a93244ad866e5c839dfc6342f--

