Return-Path: <linux-kernel+bounces-194094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37398D3685
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547C728362C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FBE181312;
	Wed, 29 May 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ayX9n/3u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFMiFhMN"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103013F45C
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986233; cv=none; b=ES3XXQRZuFNQr7BjWfSeaIyIu7FxI2HM4C0EI5E3GyhGLdlhpmPDrCuU4FNh2Jqyhuyd0tEvBC6jJfDJPG+2q6cTK1Hn0glkQ8pp5iHBQeXbXDjQmsWhkHT8PokH5LZ7dBo8VNgI2TlcTZldyvrQY5FbSuI+DhRvNUklUvIQlfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986233; c=relaxed/simple;
	bh=+qJDyavRqe7gbpZxTRvqO14ih1t6jxl7M7I6K1//B6g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XlzozJekOPuRu9QRzmJVYmAPm8T4SgR8NXRoQrc4QDbiZpETYnR7epBgN4vPb8PLtZdnnRZJR+tWszj0LXoI2fHtrgJvosJE9Es24Y5dGS2jbiRH4PNMZETdXIW16GBC53C4PQCBLKsTW+d/xCzSrnyn27xzG+2Vu/qIe3ONv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ayX9n/3u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kFMiFhMN; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3D7921800128;
	Wed, 29 May 2024 08:37:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 May 2024 08:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716986229; x=1717072629; bh=olMpVwRAcy
	cNTnwZOlUv/a3tq9UZFjzc3lJy/rkEFNM=; b=ayX9n/3ubzMeXnq46yh8XGVksw
	sPMw41hfHrkbbn4xrSl/LoJfgU5Cd/AmJvF7tq+0sGVkir0t5aqcwRAd7sEzdvLr
	08WQy/fslLuMIK/WctgiI5dFuJ1XVloYXBIhTmh2nP2evm1WM0opXEB643m8PO0K
	EV/mTcTyiCw0nqaAafmvfoZmgdViFe5Iteo8el1kbbdmcssGfILeYACnuajEukO7
	R0EAprGE1CYmMF2ku7OmY05fB/xIj98u+gpyyIsnhnca0I3v4HUMA0nUYpUJ4je4
	mRJarSYQt3uCeShPXThkZb/dBIRR5F8Rb83D0LwSsQtHTeK3LevygWMySjjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986229; x=1717072629; bh=olMpVwRAcycNTnwZOlUv/a3tq9UZ
	Fjzc3lJy/rkEFNM=; b=kFMiFhMND79jsStvXwmRXofFKdbfI9Lyl7HMYO53TlWq
	QoLe9Z5DVeyyWSasvshKsGpc0zZQpPMg9APu2boobiuk+b7e9Rib+ShH04q3D1KL
	QJHKaaPBl+PkZjzyyyRbyhPdUfgWCbXgdQqYigQ6gJXnHzPkVdEnJx3IM9Vdw0jn
	3919rmb0S5BGafYfoL5TkyZPnvuj/bL5vh+p4BJZYOX0DbX5v9xYtU0VE1p+VIqj
	CHlPf/ppnEiNiZQnhsYQDSGJiIBDxRF9/IpmLBE3v4cOfpLY1O5znro54NhJYYfZ
	jkGjgGc1I6QCKz+NKt/vbeLDWbH3nXkOMcLmWNKAvA==
X-ME-Sender: <xms:dSFXZgsPcq67EZq1snwZAmm1jG6DaeWDimFDCF-jMHUzJugskL9-_w>
    <xme:dSFXZtdlLnA8vREuisBdgDQGPDKko4fgLCVQ73P9q7BJJzMCWQLYfARbdJjBaJYgy
    ugbMqReAzBi1PgnQ6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dSFXZrze1L7G-gWEdit6BY7oZHIiRPmOlYMujt-Nbr-coZMImyKoVw>
    <xmx:dSFXZjMq8yL3GKP-Tup0ssiJ_oBw99uH4TDF43lkgrZCYFuKmvendg>
    <xmx:dSFXZg-OurZhWXMM8HqmQ3_OWs--CZJ3povMN39eOuN2KcvlHah60A>
    <xmx:dSFXZrWSyuFXLC2KNUG-RhPidBly9DzIfecDDAuJ6SOWYCdD_ssc8g>
    <xmx:dSFXZkTuqMKxabg6wlIb-tNzWcsw_E42enT-gCnizjENuBgmxgbzsdMU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5736DB6008D; Wed, 29 May 2024 08:37:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <48738af1-545e-4261-a8b7-fe224071910f@app.fastmail.com>
In-Reply-To: <20240529141323.7015f3d9@xps-13>
References: <20240529095049.1915393-1-arnd@kernel.org>
 <20240529141323.7015f3d9@xps-13>
Date: Wed, 29 May 2024 14:36:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "David Woodhouse" <David.Woodhouse@intel.com>,
 "Akinobu Mita" <akinobu.mita@gmail.com>,
 "Artem Bityutskiy" <artem.bityutskiy@linux.intel.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: make mtd_test.c a separate module
Content-Type: text/plain

On Wed, May 29, 2024, at 14:13, Miquel Raynal wrote:
> Hi Arnd,
>
> arnd@kernel.org wrote on Wed, 29 May 2024 11:50:39 +0200:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This file gets linked into nine different modules, which causes a warning:
>> 
>> scripts/Makefile.build:236: drivers/mtd/tests/Makefile: mtd_test.o is added to multiple modules: mtd_nandbiterrs mtd_oobtest mtd_pagetest mtd_readtest mtd_speedtest mtd_stresstest mtd_subpagetest mtd_torturetest
>
> I've never experienced this warning myself, how did you produce it?

This warning is currently enabled when building with 'make W=1',
but there are only a handful of drivers that run into it, so
I have sent patches for each one, with the plan to enable it
by default in the future.

>> Make it a separate module instead.
>
> I'm not a total fan of this just because it now requires an additional
> step to insert these test modules (they are likely used for
> debugging/development purposes, so not properly installed in the
> rootfs). Is there any chance we can find another way?

This should only be a problem when using plain 'insmod' instead
of 'modprobe' for loading the modules. Do you think this is
commonly used here?

Another option would be to turn all the helper functions into
static inline versions and just include the header, but
that does not avoid the duplication then.

     Arnd

