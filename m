Return-Path: <linux-kernel+bounces-241728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7DE927EBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69498284125
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CAC143C53;
	Thu,  4 Jul 2024 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xcHiXOu4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRLpNTIj"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D34CB28
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720129500; cv=none; b=eCPb59MjYiS1GJd2DCPsdNCsPWjQe4HGHvL4QggNevJzgO2/vTwjbdXR8wfXJly9vCeoFSabmBOVE299SRJfdJVlEn+hI18yuG0vnT5t9vBjfpzks9GhG65cgnAPHjd6dPJyb77Y4IE6g4xY8G/FYeMyAOcLfhRlfpGXYdLx5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720129500; c=relaxed/simple;
	bh=KYmknjOuYvpk7W9I0dqGFAx17X8EtZIHbKQy75DKDDU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=OyJTYeNhan87yNA/X4kWoSnOTkpkatoJZFTTvdmTvRFfiSyB356aEPS7JtzbstIxyavsn0cxWpjozrb3wATdQhFeRIkC2bvQU/jJ4sTvaEpBgOHZjdUbMjAjFcUDzvSeLrTAoxs3+5r9QHrTSH1eUv08OxiXN0RUXSEw11hzeNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xcHiXOu4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRLpNTIj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E35A2114014B;
	Thu,  4 Jul 2024 17:44:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Jul 2024 17:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720129496; x=1720215896; bh=zOqAQnxbaU
	zK7xr6fcMmLgOkmzXD+kCJjRCLEM8yskE=; b=xcHiXOu4tfMnD7GqLsHlnC9Oon
	eXPTdoETY4uGTGWraMHJEjXBEV0Z6p+SYStWDF8TXaktgsjQriklp3V6CR3Re4Q/
	4SHt7Qtt1C0TV4/nZ9618lSeM4yMBYB1bXsyeqKSZA0XD5L9FMcnxwizkPB2Wt/O
	KHVfmO7UNrw36Wdig/ncFfVUR0w2KN+Q1X4BuEZms4ZzAvF507kNJnD0jr5R9FBs
	sSnwb28bTGVSct5dwzNjqQkfmgsUZDJ3UXnq4mDAtlENRaOvGOGzwLCIK+cuE9Iz
	Refdfl/ZdJgqsA9RrpYgvH2k5uHgw2K1kVXnIbtnJGgNrM4cE4az5unhmjqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720129496; x=1720215896; bh=zOqAQnxbaUzK7xr6fcMmLgOkmzXD
	+kCJjRCLEM8yskE=; b=jRLpNTIjhWFjRre3z992jGx26x3xEhKlInTpXCXztvYw
	EJdSk07YjKKzHoGQLIcnAsxpbnApLgMhx0YjN09yj1/XSV3KjkXgR0mUN8X1jg0h
	IC3D5lPykPMBi0+aOss/t1yKe/C1ltZStQD3U2o0B48xk1ahxVjQyqn62Gi6wrKC
	LHyUtW/63LBamMQYDObqOefSaLJff+6x41ryceUbVFKZfn8Ay4dy5aCTev0JSYZm
	lyV1waxhln1z+z8cgq/1L59MX7r+jEWjddYFBPsTbYHnjHDIvZJ5G3CgobphTOZ2
	N7L0u5BdJNMAaSz4QCh0cA/tw625icrUZoBQQMYejA==
X-ME-Sender: <xms:2BeHZtofYObI261Sp1gfPWqhgk056BMc7GD8K2XbjgCxu28rEGLdrw>
    <xme:2BeHZvqHeSQU33Glq0lU1slKg8N6VyaRgUdgpGhsf8022N3AQWrU8sQf3MoUu5cn5
    xwyurnbkoqM7rIY1BM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2BeHZqPZwdX21Ulg97_1hXjanvznk2VghcPTcVtL1HFZ-m96jvBasQ>
    <xmx:2BeHZo6IOW5ZFoXQAUe9GyHk-2ndkHBtmkUMT0pCXJqAFX-hzfNnEQ>
    <xmx:2BeHZs58WuIyl9hu5QrTv5MzrLM2bYeTjCAlCHXbXYJYZv2eoXTC8g>
    <xmx:2BeHZgjUdt9eK2ABTI5MdcI53B-OYzVbeDRtjwPMlNP3WqXK585-1g>
    <xmx:2BeHZpsv3RhIdfYxFE5CMbmIPC55RkrmPsAGZlbi1jcwls_6KSXzXySJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 87812B6008D; Thu,  4 Jul 2024 17:44:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3a138dda-5351-41ac-8c91-f7295036729e@app.fastmail.com>
In-Reply-To: 
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
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
Date: Thu, 04 Jul 2024 23:44:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: "Jiri Olsa" <jolsa@kernel.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 cgzones@googlemail.com, "Christian Brauner" <brauner@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: deconflicting new syscall numbers for 6.11
Content-Type: text/plain

On Thu, Jul 4, 2024, at 23:07, Linus Torvalds wrote:
>
>  - even 64-bit architectures don't necessarily have anything like a
> vdso, eg alpha.
>
> It looks like you randomly just picked the architectures that have a
> syscall.tbl file, rather than architectures where this made sense. I
> thin kyou should drop all of them except possibly arm64, s390 and
> powerpc.

It's not random, it's all the architectures: the ones that
don't have a syscall.tbl file are the ones that use the table
in include/uapi/asm-generic/unistd.h. I generally recommend
doing it like to ensure all architectures define the same
__NR_* macro for new syscalls even if the implementation
gets added later. As you say, this one is a special because
it's not useful without a vdso, but that doesn't require making
it more special than necessary by adding it selectively.

In particular, if the entries above number 402 are kept
consistent across all architectures are the same, we can
more easily move them into a shared file in the future to
avoid some of the complexity of adding syscalls.

     Arnd

