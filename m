Return-Path: <linux-kernel+bounces-433300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB69E561E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E3428831A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6442F1C3318;
	Thu,  5 Dec 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="TFU3ZQqm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bI+90XcP"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E61D515A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403731; cv=none; b=IMktofoSJpQUgp4tdVHLlVkBHWHBZfrC9byT0OgdzOrLTmqyRNcs43xuUb0umwOFtc0Hu1B4aS3SxL2YYmSfoFLfk22Wrjyh02xkqX34Tb/MhCwcsQzESZsc8D9Ov+jjaiLbsekjzNnc8D+RcDjF9AviO0AWz8MXHRpuEmYmK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403731; c=relaxed/simple;
	bh=N3CzETeBFwSfHP0TXvSqEesp/D/lFvBsosz98ejvPcQ=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=nd9hiib8/d43HqlfIDBTFRjRF4BouZhE80XjSKQL2P3wMhNCU4NS4HLJlDVpBh8F1Y5eRy/aJ//38BnbB2kfFHQ3T0ovFfz8u4dapNrPhJ4C5UemcrvUjRRVBtAp5IIAg6oiVBXQ3xs4z1qbDFJepiYWqTIK2NsFEqDwP614TIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=TFU3ZQqm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bI+90XcP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 1665F1381D37;
	Thu,  5 Dec 2024 08:02:07 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Thu, 05 Dec 2024 08:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733403727; x=1733490127; bh=N3CzETeBFw
	SfHP0TXvSqEesp/D/lFvBsosz98ejvPcQ=; b=TFU3ZQqmxSFzeHDAC0klGYSIcn
	n7RJ2bycIBPFJgQoJ1fb2GXnop2LQ7gGJVsAYvUT6rPRdno5+5WlFDWRJkcXELLW
	SGec0yomrUM2f+jWoLF32k2nViqQea0C6p3uvYeQscUI9M/kPJK1u2tDUlKQHIto
	5sgEaF5v2LGCsiTZjwS1AUtgNgMk0q0SXSiF7oWk1dqCtmh1qaf8nNmvCy/bQWog
	UXBjZfNhVJ+duE2KrIKIpJ9tdxae4WlLpAuMqCC7xtgIhSiuU2h5NgQimrvEqDIl
	LGGtjn1XexznG9CJHiyRJlBo9y3JxsmRTMFKWgLS4vVQUntEMxNvyR7p5KFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733403727; x=1733490127; bh=N3CzETeBFwSfHP0TXvSqEesp/D/lFvBsosz
	98ejvPcQ=; b=bI+90XcPz+xPAfc7bmuDkJp2v0zftCx8J+v49YEpDfucETbi7Zo
	IwOCQEagYzAlwyHVY0Q1ktrax7U9e0svJscZmAkoGhVH14svB+dTAMVC0favQtJZ
	t3HvQxxIJg16qweIuBT93jAU6wYsPGDQ5itSds4C8PXMZGzZqWOmrG6LxjW1+jGR
	2fonAA4p7iDUZir2Xtpl4qqP3RDjmjKtMNKg5FBQ2LQq7i2vVSVX1+OX4ZvaXs1a
	tDhMQDf4yQftmRCwMuZE/IWdCVHcwcYpolMuH8X8VhLaUwa0U/w9anmsc/9ezfvx
	pDlszisZnWQwwlZV6cKe6yPwmFPuOddxg6w==
X-ME-Sender: <xms:TqRRZ8iV8WF3Cx6W--bwsKDuRPbQZOJgRL7-08VeYwy-Hs7tw8ktWQ>
    <xme:TqRRZ1CSxIwIKzYgnliru0aVfucXvEbiUdkv1kYtg6qhrpssG7Sgrz1gerVwEQboX
    QXtLu0FrU1JqJDVmMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgdeghecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:TqRRZ0GERsSs0jorVcPjpZLUQFoeoXe19XM-Pdp2ptTo9maI5k4bzQ>
    <xmx:TqRRZ9QhqHs7JXokaUE_9Vihd4qscAW0GgoonNUJ7zKqD7qLTJqrCQ>
    <xmx:TqRRZ5yjrvieMUaO3BYs9gLBuJ4Znit9kfe1qHvm7qZPQ6PCfAEo4A>
    <xmx:TqRRZ75tEGa9hVvB8L380Fdp0GqEcw4zT2VNApPXDdfk4--egWdzmg>
    <xmx:T6RRZ08IeMzw1h2YFD1vNUwx1V24EUMK8_8czEa3WQd_sfenh9JzKV21>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 897D01C20066; Thu,  5 Dec 2024 08:02:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: multipart/mixed;
 boundary=06c30ed3e1af55944d5cef269ae5125605752132e43d184e9738660b566e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 05 Dec 2024 16:01:57 +0300
Message-Id: <D63SC2SEH0D2.Z2PVQQCYDRF3@getstate.dev>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: "Mazin Alhaddad" <mazin@getstate.dev>
To: "syzbot" <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>,
 <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
X-Mailer: aerc 0.18.2
References: <D63RG2V1SJD8.3JVR47OT0IN39@getstate.dev>
 <6751a103.050a0220.17bd51.00a2.GAE@google.com>
In-Reply-To: <6751a103.050a0220.17bd51.00a2.GAE@google.com>

--06c30ed3e1af55944d5cef269ae5125605752132e43d184e9738660b566e
Content-Type: multipart/alternative;
 boundary=90ed07080bc22cdd225a64c4ae5124af79e085b511937065324e000db9d8

--90ed07080bc22cdd225a64c4ae5124af79e085b511937065324e000db9d8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--90ed07080bc22cdd225a64c4ae5124af79e085b511937065324e000db9d8--

--06c30ed3e1af55944d5cef269ae5125605752132e43d184e9738660b566e
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-TEST.patch
Content-Type: text/plain; charset=utf-8; name=0001-TEST.patch

RnJvbSAxODgxZjk2ZmVjMzVkZTllYjZjMTkzNTRiM2IyYmU3ZTRjNjdiMmIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXppbiBBbEhhZGRhZCA8bWF6aW5AZ2V0c3RhdGUuZGV2PgpE
YXRlOiBUaHUsIDUgRGVjIDIwMjQgMTY6MDA6MDMgKzAzMDAKU3ViamVjdDogW1BBVENIXSBURVNU
CgotLS0KIG5ldC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9ibHVl
dG9vdGgvaGNpX3N5bmMuYyBiL25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYwppbmRleCBjODZmNGU0
MmUuLjlkMWFjZTBjYiAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9oY2lfc3luYy5jCisrKyBi
L25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYwpAQCAtNTE5Nyw3ICs1MTk3LDExIEBAIGludCBoY2lf
ZGV2X2Nsb3NlX3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYpCiAJICovCiAJZHJhaW5fd29ya3F1
ZXVlKGhkZXYtPndvcmtxdWV1ZSk7CiAKKwkvKiBmbHVzaCBjbWQgIHdvcmsgKi8KKwlmbHVzaF93
b3JrKCZoZGV2LT5jbWRfd29yayk7CisKIAloY2lfZGV2X2xvY2soaGRldik7CisJaGNpX2NtZF9z
eW5jX2NsZWFyKGhkZXYpOwogCiAJaGNpX2Rpc2NvdmVyeV9zZXRfc3RhdGUoaGRldiwgRElTQ09W
RVJZX1NUT1BQRUQpOwogCkBAIC01MjM0LDggKzUyMzgsNiBAQCBpbnQgaGNpX2Rldl9jbG9zZV9z
eW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQogCQljbGVhcl9iaXQoSENJX0lOSVQsICZoZGV2LT5m
bGFncyk7CiAJfQogCi0JLyogZmx1c2ggY21kICB3b3JrICovCi0JZmx1c2hfd29yaygmaGRldi0+
Y21kX3dvcmspOwogCiAJLyogRHJvcCBxdWV1ZXMgKi8KIAlza2JfcXVldWVfcHVyZ2UoJmhkZXYt
PnJ4X3EpOwotLSAKMi40Ni4wCgo=
--06c30ed3e1af55944d5cef269ae5125605752132e43d184e9738660b566e--

