Return-Path: <linux-kernel+bounces-242115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF74A9283B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DC31F2363E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698EE1422DD;
	Fri,  5 Jul 2024 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sZ5B+QWD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HhvpgReD"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBE45000
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168463; cv=none; b=Ks9FbdwgI0eljCKk7Us2yMsNaMA/rC2rlO/sKh3ByY7zIcqFW5if4wYnY4BQ89/wgN8gD4eCF02/1C8Db8l56J2vuG6qopj4BFKsrd709XdcAs3NTakyaEu+Lwk9lEl6AnzRMevkh5J7UZ7CH28pmt16a6Q2n6ds58haIb3CuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168463; c=relaxed/simple;
	bh=wq1OXdw5fckgkdVticya1OorSX/AjNtS6uG+TrLLbi8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PEIh4hGtAmstUDvJ2oP0mY5vN2aE3K6C5qjgXqHV/Akcutosq9iXV7glNs9xya62PqrwauLFuJJxXp0lcG1T2HPyPadUtsxrPcFHcWnmIeue9n5N7NA5g5MuPaKB9IVYsI6SQuPYsoEZGTChyzylafUNiYdv6ztx+M2j9yNbv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sZ5B+QWD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HhvpgReD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EBB651380468;
	Fri,  5 Jul 2024 04:34:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jul 2024 04:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720168460; x=1720254860; bh=Ujxz2Zg8MP
	K4rDkoHZ0Q2RC3PicxQIwL5aImPfXn5GY=; b=sZ5B+QWD1VwTv45eGuGbZ9Ti08
	CmGKc+1C+BD/9BTizdIpNgcawYFCbyDAl29kw1eyKg6+on8ZzRcJPFFyBjpff2Bm
	Jm7Jgqcvkgx4u3aUsuqAkqbYTdr0budLYnVFe121NdrGmLhMVmN0L1Qry821aSfx
	INbTdNJ5EzXgA4ECTo2g9efRJj92+SFau4V8/oiGC4QXt3ItHydjDvmPqfvt1YfI
	aEDcXZnBqGIcZzGX4TYhMK24ApLyvRXbQUiY3mBHRXtXLJgAwguxKSc3R3ywCU49
	WWadD/3V2e+gaDtcuViBUzokqRhjM3RiVNEbTg24ZHNo02a+QN7c3FaZqDJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720168460; x=1720254860; bh=Ujxz2Zg8MPK4rDkoHZ0Q2RC3Picx
	QIwL5aImPfXn5GY=; b=HhvpgReDb7DLeu2TPzq2TmNF8Bs/WkMZ/KfDTfBAyCb6
	PTNlTxOvCDNKdLJkyPZytbmQKm2bNZqGCqap4ANfPyseqcLII8NFwtz3GVR/lUVR
	ac0OJbAZZZkI8AA8mSE1XYH2OZ0lPo/SlJ4ExETX9r/VL0U2EG4OkJ2zxmWnQI7l
	5w7Fp3eNW+gXIQceZAqqI2wiQoFQm3o+UgoIxu5ncp8Lfj0CBtLpd7eAsswEiuht
	nrX19DhMgu4hD3fBEmX6QxrSToLN8Q/zVwqlPpEFK/MP5logm5XVESa46MEgSjmz
	ty/7BACmfTO2zKggYqE0tYIGTIzUQev47/aj942yBg==
X-ME-Sender: <xms:DLCHZhlNjtvtH7Z3xHmyfg4Ny1Nqpb7P-Gw_cXRcBpaMEN27Oz-1RA>
    <xme:DLCHZs1l3V0VRET-CFnQtdjKjz4knI_QyZzVhD2zZFYoQw_-AFWh0h8xRuDeFCMhk
    4Vc6a1VwRWDJs21grw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DLCHZnreFnfn9Ld29PLRlW76ta0NzDQhuwaqusqfgB_Oc622_2KADw>
    <xmx:DLCHZhnC-Wn9unLSFgGlULPHhe1cCp7L44XTIeO7_eun-G_jOx4cuA>
    <xmx:DLCHZv3eCV0brnQZZUooC_4HFndZiXy4idNR5jwbepiQ104ZMz_yjA>
    <xmx:DLCHZgvcrfPDK_OXoTOfWCaVekxKE4QTr5-ALAwO7X6S_mvQ-XVHLw>
    <xmx:DLCHZpoqfdYBYttA-ZLaJCaz9g23Xe4cBzk2wvTf4mPCmgKSJX0iJVlU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 79951B6008D; Fri,  5 Jul 2024 04:34:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb2f5427-521c-40eb-90fd-f253b41d5422@app.fastmail.com>
In-Reply-To: 
 <CAHk-=whabFzoT+iLSF1A-u-4fBvtLGMBvi67xUOqww7PGp2B8Q@mail.gmail.com>
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
 <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com>
 <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com>
 <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
 <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
 <3a138dda-5351-41ac-8c91-f7295036729e@app.fastmail.com>
 <CAHk-=whabFzoT+iLSF1A-u-4fBvtLGMBvi67xUOqww7PGp2B8Q@mail.gmail.com>
Date: Fri, 05 Jul 2024 10:32:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, cgzones@googlemail.com,
 "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: deconflicting new syscall numbers for 6.11
Content-Type: text/plain

On Fri, Jul 5, 2024, at 00:07, Linus Torvalds wrote:
> On Thu, 4 Jul 2024 at 14:45, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> It's not random, it's all the architectures: the ones that
>> don't have a syscall.tbl file are the ones that use the table
>> in include/uapi/asm-generic/unistd.h.
>
> Ok.
>
> I think it's bogus to reseve system calls for everybody even when it
> makes no sense.

I see. Just to make sure: do you think it's ok to still
reserve system call numbers everywhere if they are used
on most architectures? I posted a series yesterday to
convert include/asm-generic/uapi/unistd.h into the syscall.tbl
format, and I did this change for clone3:

https://lore.kernel.org/lkml/20240704143611.2979589-8-arnd@kernel.org/

The reasoning here is that we want this to be available
everywhere but there are four architectures still missing
it, and having the macro defined in the generated unistd.h
avoids a special case.

On the other hand, I left memfd_secret a special case since
that one is only implemented on one architecture using the
generic table.
 
> But it's also pretty moot, since I think the whole system call has to go away.
>
> All it is is an odd wrapper around mmap() anyway, and it's a useful
> enough thing *outside* of getrandom() that I pretty much guarantee it
> will be used for other things than vgetrandom anyway.

Right.

    Arnd

