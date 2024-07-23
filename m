Return-Path: <linux-kernel+bounces-259862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5AF939E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA22C2834A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B095D14D6E6;
	Tue, 23 Jul 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UrILBezM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I8e9/qgJ"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366C14C59A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728711; cv=none; b=p36p4cJV6reYP9nPg+TQSM07olmRiX+oZxigzVM5v4Dnw1qIW6XRwDRc8vLpNvUvONMrJu1n4gwoMYSdaosy4VUTuVaW/G4hUMc23p9189nhkuNrmAOy48iROZW3gmFcTZh6orUiO5sXkWMVbGJKAP2OCUpOw3f9vtLpFwE+s4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728711; c=relaxed/simple;
	bh=js3iM5NDADRjbj25m5GGrBNN3YCFmPtzVgmUCZOSLuQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=crlJmcl1XMgvMZU+qqzHK/x9yf7S2aCYV2nl7MWaKaBERqve7Ln++PqcCY4ftur86mzyzSnTbuHe1Hy570HiG6mXjtog/oO64gyXzjnDEnDNBm5j8pJv2EiASOfJ+rsxt0HWzfEG+XPmlqb1lB+bY5MoR8T8mkg4nkwifeD6V34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UrILBezM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I8e9/qgJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 27C791380705;
	Tue, 23 Jul 2024 05:58:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 05:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721728709; x=1721815109; bh=GNtJm8grYf
	cNturY58sqcvd+Ty96tolTOB41aMlppSA=; b=UrILBezM8n7MCyIc5p3/ZwuGUu
	+l/Nsf2Mcg6+nqFDAj54kxvG3bVyHvMFNNkAZtI6kwBMBpl9zLhEEq83jHG/0QJ+
	iPGfRMrJmvSiNpRGLaginf0e+aNaER/zRnIy4mtZ5rF/7gY1JJB/iMuTLWYl1i+p
	Ua4SlIq9+2eBjLUWxXZKL75cPu8PC05WTgqUxwSnw+mJXEP9bVPYAS6sMPhHq0Uw
	S8ODPiiqVHYCC/EPB+KpxcAQJpX4OPtdB2rMWlWv/un/i+9uhY66oENt/IFsKYGF
	/Z01WgWTEIvBW+DioiP/kilmcYKM3wzILIv6dfIe5zczKzg1Hw6XWck0jDzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721728709; x=1721815109; bh=GNtJm8grYfcNturY58sqcvd+Ty96
	tolTOB41aMlppSA=; b=I8e9/qgJsLnnmu7MLK+qCyFWftJdfb6fB5jVu2xBOBqK
	zYDryD8Up7JwPLqbULtBK3wP57Oq4vZap9f+M7NjOwhiVXTvzUSelJW36muStLfq
	XgmeZsEDQDCmydDSIggwygyuq1Rcpai3KuxBwjTYY3PzE4ciognTbqkMeq/z65N1
	z3ZgPl5OjzTdcC53DPIYIxzWkwlSEZJo+BZ1zrXvc5jiJ0iApRJzaiRrx5kgr9iU
	3oIc0LwH3JnGIvhKggDy7JV5sIdG0wJQP5u68fJagfWEmKTxi6GDngYTWv0vd1dK
	8uRpFEmF58ZMYMMYH7WHD7caKXh+AJNlni/zuwk55w==
X-ME-Sender: <xms:xX6fZlISrVP-SXw1kA1qLHMGmTsKodZBJrcYNabQMWQH271HE0xq8w>
    <xme:xX6fZhKVtGYp1pfkMV4fJ4fVT-CINMHbzIv9NAnx5JS6HeERXJ5ZDr4GzJiCu7Oou
    AkJMCvU2XolTfD1H3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:xX6fZtv8yfiwRPcDQTrF9Em465XpikssyAEtLlYZlpBsbZuotR1k4A>
    <xmx:xX6fZmbX9K9j4wc8UEjL-RZX-i4bRkkQyEmCNmU9quOv_GEBUGJd8g>
    <xmx:xX6fZsYeESfiReZfbKxhGLXG0YlvEHpXWa-fg5F6oS1rBqozVBSIEQ>
    <xmx:xX6fZqCaXpeWzW5Xywo2ND0wGutpZbxN9cnqwJeldnYxrc_7z3EzIg>
    <xmx:xX6fZhOwq1EgGCPk-em_MC962zvrDvqyNQgSX5QI8F6x-oFPy6SgaW0w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id ECB23B6008D; Tue, 23 Jul 2024 05:58:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9e957f11-eafd-4116-9fc6-c0b397be5ce4@app.fastmail.com>
In-Reply-To: <20240722094226.21602-29-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-29-ysionneau@kalrayinc.com>
Date: Tue, 23 Jul 2024 09:58:04 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yann Sionneau" <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org
Cc: "Jonathan Borne" <jborne@kalrayinc.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>,
 "Clement Leger" <clement@clement-leger.fr>,
 "Guillaume Thouvenin" <thouveng@gmail.com>,
 "Julien Villette" <julien.villette@gmail.com>
Subject: Re: [RFC PATCH v3 28/37] kvx: Add misc common routines
Content-Type: text/plain

On Mon, Jul 22, 2024, at 09:41, ysionneau@kalrayinc.com wrote:

> +#define memset_io(c, v, l)	__memset_io((c), (v), (l))
> +#define memcpy_fromio(a, c, l)	__memcpy_fromio((a), (c), (l))
> +#define memcpy_toio(c, a, l)	__memcpy_toio((c), (a), (l))
> +
> +#include <asm-generic/io.h>

You generally want to define __raw_{read,write}{b,w,l,q}
functions using inline asm here in order to guarantee
that they are done with atomic load/store instructions of
the correct size.

Does the PCI controller support IORESOURCE_IO accesses?
It looks like you get the default PCI_IOBASE, which turns
into a NULL pointer and is not a good idea for accessing
fixed port numbers. This should hopefully get resolved
soon once turning off CONFIG_HAS_IOPORT means you don't
need to define inb()/outb() or special ioread()/iowrite()
functions at all.

     Arnd

