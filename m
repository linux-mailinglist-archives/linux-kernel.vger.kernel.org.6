Return-Path: <linux-kernel+bounces-265197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038993EDE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE41E282CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E1D12C46D;
	Mon, 29 Jul 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O2COYZIo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a4UxPIhX"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2D74058
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236564; cv=none; b=IJFtK+qRkMcqFOfA69melxzuHlxy8dixY4kKqtZkDynNv12Xht/Q1D3x0ZZOsUbnvJ3UnkBJel8dk7xnkCqRVyM99RSDPfn7Zq2P0Vi4NF/aTutFNSm98OZJe3pp4aHFKATX8KyieA8jKizOOmx1YcWoYVoygbHl7pLFQx2XYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236564; c=relaxed/simple;
	bh=xljAVq2AI+HXD6xrKTZ/yyxJY5ISMHdHtrKDNx8zAs0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=cJ7UA84jSFgrPdr5CsYEpBsCJaPKuWaFJFvu7JdOXvoUaTUO5vudmyXq6ml6U580a5PeQmxebGtoBwNQ+zLGu6IxXAa98klZo6fjZenYDiz27EZZYSg6/Hom8IVIAzetLm3xtZnVJ0ZBqkPP18deU+RTT0sZFyrgSDlC87CQpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=O2COYZIo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a4UxPIhX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 68D971140092;
	Mon, 29 Jul 2024 03:02:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Mon, 29 Jul 2024 03:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1722236561; x=1722322961; bh=hGG+ePgWzn
	dtOiaFUWIwTWUzuqt+6sQvsZYw00TGxkU=; b=O2COYZIoyb0+FhS7EEyVzamFEh
	BZMSL4eVmqb2KBTCOi3wKm+Rim76ScafqxXmJBmaLYTvk7FRGOmtY+TfQX3xboRc
	m+/iYLX17EUaD9idKyCThTwCgyKYeFPKUbbmhSi5b/nIPC13J/37MrXGmQxZLsRL
	Q6nIdkvLyXIe+YSp712ZnmO/3XjxDPUjO/IZTmxCpwXXlJWRi6wuMx80FtrgiTH6
	IYAnzLt80Y5A2uj8spXVm6FludhYaBWHRbl8BbZdjxNku93oslMhSgw2Lm35NlGW
	yK4ll90vvIC/C/8yYzhvJMoi79sz9FlLyJj4yel63f0+oMbQ/FoBXxl5GzJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722236561; x=1722322961; bh=hGG+ePgWzndtOiaFUWIwTWUzuqt+
	6sQvsZYw00TGxkU=; b=a4UxPIhXUwpoHBIpdWt/xPQmBme7Oy+MAyjyI70we1oX
	VbySoSnXP+/+JHiVjuuovaX8SuA5S+SaHlIc0M2yQ52Dk0YU8Awj1LMkdPlL17CC
	eBfRhQO05QyhmWf6y3nMpseeLRWqWLnNpW2lf4VTfRqZQVVfNoQMvvu5klRfqxJw
	nR7u7rd9A2grzFGiNwYgPC0dhs/c84lAmqeJjWVc9HRm4DoxZ5sL1urMmQZDsqAv
	W/YLXOp6Uf+swuGDSC3M+IgCUpiQyN/nv9ddkG9+g1JHEqZbAhbUmMAD6kd9mmyy
	edYCyz/IoXeXBr0Os/bxvwLtgyqE6GjymKgMpQcs4g==
X-ME-Sender: <xms:kT6nZnRrG86bYkaW770XnQYtFPvGfQpHz4McMx-SvyBfeNv3Kqghng>
    <xme:kT6nZowUHVNfili--ArOMnpV4RQ5Uxql_whAOYh8BSMfv38GXLFTEQ0zH1lhmjpUh
    B4BjBuMK4hXalbuX1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedugdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:kT6nZs3fR9RvAWpWjj0mgN05HKGHkO9N_1lRXANqbfW4200DDlGhSA>
    <xmx:kT6nZnDki1FHRQbwpeGnQXipgsmGQBN_vpoCKX03eCtNVTfIrGtCig>
    <xmx:kT6nZgioUFtxPMcb2zc-JqRmcd13PmadLGjrQ9L8Ns1tFPKXDKeFtw>
    <xmx:kT6nZrpXlbCoExTKMrSyMCnK4cn1CYAAR40ojKKNpF5mDrLoIVpkHg>
    <xmx:kT6nZsYNcRUGFow8kBNH5T6BNFygE-943VBUryFm_VIbsjgggR4NHplp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 038B4B6008D; Mon, 29 Jul 2024 03:02:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <63eb1654-c614-4f6a-9bc5-8c8085eadf8c@app.fastmail.com>
In-Reply-To: <20240728203001.2551083-7-xur@google.com>
References: <20240728203001.2551083-1-xur@google.com>
 <20240728203001.2551083-7-xur@google.com>
Date: Mon, 29 Jul 2024 09:02:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rong Xu" <xur@google.com>, "Han Shen" <shenhan@google.com>,
 "Sriraman Tallam" <tmsriram@google.com>, "David Li" <davidxl@google.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Vegard Nossum" <vegard.nossum@oracle.com>, "John Moon" <john@jmoon.dev>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Luis Chamberlain" <mcgrof@kernel.org>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Mike Rapoport" <rppt@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Rafael Aquini" <aquini@redhat.com>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Eric DeVolder" <eric.devolder@oracle.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Benjamin Segall" <bsegall@google.com>,
 "Breno Leitao" <leitao@debian.org>,
 "Wei Yang" <richard.weiyang@gmail.com>,
 "Brian Gerst" <brgerst@gmail.com>, "Juergen Gross" <jgross@suse.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Kees Cook" <kees@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>,
 "Xiao W Wang" <xiao.w.wang@intel.com>,
 "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev,
 "Krzysztof Pszeniczny" <kpszeniczny@google.com>,
 "Stephane Eranian" <eranian@google.com>
Subject: Re: [PATCH 6/6] Add Propeller configuration for kernel build.
Content-Type: text/plain

On Sun, Jul 28, 2024, at 22:29, Rong Xu wrote:
>  Documentation/dev-tools/index.rst     |   1 +
>  Documentation/dev-tools/propeller.rst | 188 ++++++++++++++++++++++++++
>  MAINTAINERS                           |   7 +
>  Makefile                              |   1 +
>  arch/Kconfig                          |  22 +++
>  arch/x86/Kconfig                      |   1 +
>  arch/x86/boot/compressed/Makefile     |   3 +
>  arch/x86/kernel/vmlinux.lds.S         |   4 +
>  arch/x86/platform/efi/Makefile        |   1 +
>  drivers/firmware/efi/libstub/Makefile |   2 +
>  include/asm-generic/vmlinux.lds.h     |   8 +-
>  scripts/Makefile.lib                  |  10 ++
>  scripts/Makefile.propeller            |  25 ++++
>  tools/objtool/check.c                 |   1 +

I have not looked in much detail, but I see that you need
a special case for arch/x86/boot/compressed and
drivers/firmware/efi, which makes it likely that you
need to also disable properller support for
arch/x86/purgatory/Makefile, which tends to have similar
requirements.

     Arnd

