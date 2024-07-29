Return-Path: <linux-kernel+bounces-265452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A0D93F16A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121521C21A59
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460713DDDF;
	Mon, 29 Jul 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cvUjs9BV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qa0SMz4l"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6678B4E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246211; cv=none; b=XrkwRJkDq3BGuiAQnyrnzPTdyvp1eMIZAQ6y8Ec/rg5818jzJ8rbJGft5sOVQjsk/bFRiwovu+If3zFNw1+OmdQr3OpZ5c4qemTJ4fpxN4deW448R8opYFI+akz/cE0eLzXwIF4eLZ4Ho076Sd6Bl7/y7Ov0dfrq3zZ1E9Jo/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246211; c=relaxed/simple;
	bh=LVKcQwrHhMVQVfSwd72w3LFVbUGzpXzzH93bJA1iWws=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=o74eSCtS7sz41UFds6ukIkLJjY38p6vV7TTD/soyIsU4r1cxzl47yU28fyJvhEEl+dv2A3qfBlUJMG0cd3S1trXyvMjpUOGY8NR/kP+5xmpk1n0CJJ6OENYCOeI1PHhkLNziUiJfGjZWGiErFG5MKqjKUJLTWzm+9Tqd2/wrThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cvUjs9BV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qa0SMz4l; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 35B7F1140139;
	Mon, 29 Jul 2024 05:43:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Mon, 29 Jul 2024 05:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1722246208; x=1722332608; bh=Wz55K8nOXQ
	h7pFBz71/M4pRWW4y8Av4zPe6/94WVOs4=; b=cvUjs9BV/nTuYhL/olbeXiAdT2
	i1s394z0oXI0x+jLhjfwBAbgXZvu/feCRiIgd2nLfbx8LJZ6WBR71Lsc95IiGz/b
	sztd34kcFag6KUze8BNRQURHkB2guuyOsbFyZXMRw6KIMFxv8FYXImoXs68KprC9
	ykAJsHl1cl3n8K13aozR99KTF3CjONGrFllw1Ww08G2QMVaAXYsKEmczbXiTB6Fl
	ICendvX0csZ9N7jrl0IaCHZw13dmiA6dVOEG+ctQ0e5lqLuulfNPE6oEw2Rpqzme
	ZLDeNrDjvRH/mlljj1xy2W6MNVZQyrRW+eaBenzxtcuB3U2OlimFW5JfizUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722246208; x=1722332608; bh=Wz55K8nOXQh7pFBz71/M4pRWW4y8
	Av4zPe6/94WVOs4=; b=Qa0SMz4lGAgdml7ohBL9F3NXASFmErqOx0RtSIyguaKQ
	/ZbQfeqmaj10wpiDvIXWzIf0PjRH/S/4RizbqqdeT6qvYm1gniN4s3xKL7OLlIh2
	ihTLrMdItl7cV48dG/1xXq4iFdRBBViZ0PKitz0pEpfcGn5MTo+UNdb+GMIPvij0
	R5WQwyJzXeL891xTZD6T9tdS1zfFUjxTabhXxlO7E5AwA8KtanQDodXRAvNwLty8
	B5HVGsL6Rr9TTAZGZCIUpZjOrFi9bzMP2bHIPhoOLHgJ0OpSo3FhZBuxV1PPf4Bp
	Pzrcn6cheuxztLtWIb9m1NntCOhmf4muX5cpzpZ6pw==
X-ME-Sender: <xms:QGSnZsnxGyRK9HCIRRqkegSqInUpunThJE-Xd15g3ZdtH1qQO6vW-w>
    <xme:QGSnZr2kYvbTSMk6u9zUArDKQfhM-odRvf7nH-esNSzismkEPfxAWhrdIh2Z0UKSU
    IkuEf5_xitVbogOyQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:QGSnZqpKnkNQNPtob2xPEdEs84bRiqfcqlMh4bmZYsFxMuEskqyhbg>
    <xmx:QGSnZonyFYcLOS9C9koXgzLaMI5kSVDRAZrxf5vjHTmeokB3VihLzQ>
    <xmx:QGSnZq0ez9ziFMWY_YwDSKt3c-_5a6lFUYVjC5d1BwYKRpivwJqPwA>
    <xmx:QGSnZvsZIujQbiW907p5PHSZocnPG9sFKpqrOpwJjuwBfIk7IWnuWQ>
    <xmx:QGSnZvyjd6blYXNB0mI9QLIayTjaXUP5ZJT8zmex_TnGA8pUBVn4t7Gt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id ECDD1B6008D; Mon, 29 Jul 2024 05:43:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bbb597df-5bd8-487a-8b5c-9118814632e8@app.fastmail.com>
In-Reply-To: <20240729073511.61935-1-zhangjiao2@cmss.chinamobile.com>
References: <20240729073511.61935-1-zhangjiao2@cmss.chinamobile.com>
Date: Mon, 29 Jul 2024 11:42:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] char: misc: add missing #ifdef CONFIG_PROC_FS and error checking
Content-Type: text/plain

On Mon, Jul 29, 2024, at 09:35, zhangjiao2 wrote:
> From: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
>
> Add "#ifdef CONFIG_PROC_FS" to control misc proc create 
> and give some error checking.
>
> Signed-off-by: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
> ---

I don't think this is an improvement: proc_create_*() already
prints a warning about how exactly it went wrong when it does,
and it can usually just continue without it. However, failing
misc_init() is likely to prevent the system from booting.

     Arnd

