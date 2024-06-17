Return-Path: <linux-kernel+bounces-217165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4F790AC67
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A751B2F2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD171946CC;
	Mon, 17 Jun 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HQ9ZOdA6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WT3sEJ48"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4F194A6A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621685; cv=none; b=mf73UiA5ThLoLzWBY9pYDSX0a4/ngkOeMKkXPh5hvO5RHiOoDSrmN15D8D5KR8SPMT7VL/qqIoRvfbnfnEX7TOsETG/J80G2jFEHImxID46WFVoD714ffUsL8fxMLy41Y4VSqn57CS0KbG2htZiRm2448eq//KMMaMjS+vC/ljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621685; c=relaxed/simple;
	bh=lZ7JUxOXeFGxwjU5PvLfFCl0P2mMK2M8BeCEhui/ZSU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=erjY4I1/ER1V5GwhSqxMcy9WcZVtNAp8TBdI9QiyKQ32o1MYCikPPMpDnoQVDWQpNquiqECcFIEAZ8PBtzuZIfrH+7kmtB0trwatz4Sf4FLyKsEc+zjyZHlNDadlsimi5Oi58dzqSY1GtAGp+RBAf09hyI41LZFuNkaM0arjso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HQ9ZOdA6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WT3sEJ48; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 307D5180010A;
	Mon, 17 Jun 2024 06:54:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 17 Jun 2024 06:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718621681; x=1718708081; bh=a5JJkCuR/X
	wPxdr5oBNTracY7Jzomy1/FWwbjplsCXU=; b=HQ9ZOdA6qmtpvEgQTkrXiVFPos
	EF7G5U1j9AZQKgPVArHU0gvs6F+u+fJenNNkkX9i026YDnFgjG7Huqjsu/wrv4gm
	QPpxxO6ceW9I0Mor9f2PwV+hd0d1gCBkLy4ysWw0w1+UrEJrA8jCL4giHHuIBqMY
	6gTZZrI4pldK14n2jr2cCExT9OI5RHz1DX4AJ6CkFeByevAgmqH1u/+k6sFBXFcq
	YHwLKcdcgjypJ+rYMyAfgwMcAt3CD+r7G16Ypbsm8WVhgp8YITS4+W2EtVVueWwZ
	+sUFS6SI4ovlFgyn5H4H7a3vlCmeaD+L85U6iIK3NNn0r1UYoGpcGV5he3iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718621681; x=1718708081; bh=a5JJkCuR/XwPxdr5oBNTracY7Jzo
	my1/FWwbjplsCXU=; b=WT3sEJ48NbzWBd9xvrxL6mS7D20Dd7tP9R0+cLXcfaL0
	EDqBolyAOQybpsN1/5tJ/fEE6WmE5ot9D6lvRqnP9PRDLQnG+dQv61UIqd49x5Fq
	uz8ycLwQMwi6kX/PgQQdPuhYThSpEKFLK3JQUPkkXJFqYy3Gz0ByS+Bjd4Q8V2oo
	C0n8Ig6HEm1ErF5Sm38WD1mUhnBTGFPin1pqKGgqYrByKoLu7woQLkO4d0Vc7ESy
	VS+QXYUN/4NgMb5Vh539kB1O9rp4CkgnYcdg/qmLMGvxum2Qku9KvtJtht+AZSSE
	o/G8mv/rlpcm2TovFVb9b+YS+cabDegNNWt9I1ImUA==
X-ME-Sender: <xms:8RVwZpR_O4uRyuMNT3aioBX14J9M-p22oTV2bLmHiTN37sZl6Bd43A>
    <xme:8RVwZixmWvl-DMBCKKbhzVTk50y9yebDI36pCKFZw_Hv02Alr_uoqGc5VxanfuSnb
    jKQ95Upx9W2dLcDh88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8RVwZu1gObM5dxLDUmbkJfO_kYBrz8PsDS9xeEa22xGbhQYXahpLDw>
    <xmx:8RVwZhCf4gH5YSu7j1xd3MzAWSDmAC40vyIaOFColtnWhCBxnKol9Q>
    <xmx:8RVwZijeaSdFed46iEXcYoF367DOvyyKCAZnN_ujWWo1xM2QKutjkg>
    <xmx:8RVwZlojcuPIIOmj1Ty57fKHz3P036YInC69S_0j_v0l2nv0ZW0WNw>
    <xmx:8RVwZtXxl8up9EZBipXnTS8GJNbhpv4zntzlcUo1SDHSEzkunbHPfhHn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1F7DAB6008D; Mon, 17 Jun 2024 06:54:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45283ce9-5ce9-41c8-bc81-caa9624c4aa9@app.fastmail.com>
In-Reply-To: <20240617104509.70c447b3@endymion.delvare>
References: <20240617104509.70c447b3@endymion.delvare>
Date: Mon, 17 Jun 2024 12:54:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jean Delvare" <jdelvare@suse.de>, LKML <linux-kernel@vger.kernel.org>
Cc: "Karol Gugala" <kgugala@antmicro.com>,
 "Mateusz Holenko" <mholenko@antmicro.com>,
 "Gabriel L. Somlo" <gsomlo@gmail.com>, "Joel Stanley" <joel@jms.id.au>,
 "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] drivers/soc/litex: drop obsolete dependency on COMPILE_TEST
Content-Type: text/plain

On Mon, Jun 17, 2024, at 10:45, Jean Delvare wrote:
> Arnd, in December 2023, Gabriel suggested that maybe this could go
> through one of your trees, as apparently there's no dedicated path to
> upstream for litex patches? Thanks in advance.

Yes, if you send it to soc@kernel.org, I'll apply this through
patchwork.

    Arnd

