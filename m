Return-Path: <linux-kernel+bounces-316781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726B796D4D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D2E1F28E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E5192D73;
	Thu,  5 Sep 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="xH90HT2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iadQwMJ7"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740119413B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530199; cv=none; b=JksCIgcIWS6lsIvzrSIYYoLTMYhHrA+mXPyHA5jhLm56DppHagwgSYtcixdT9ahkp7wHUMcR10yQDqfgKkdfKS4Lw19oPkPTkb0vztP4+pbjw7lfOr9JuoFVVpZ8kTvfZHIcUOs/ipGuz6T4FHfsEzqbu2f+opKaTEiCPdvKouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530199; c=relaxed/simple;
	bh=Hzz2twul5J5zhZNCAGX+lWkNskeCMNj/ZBdlAjXyJOQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BO+NWUtuJgnlWopSJ83bWWZ+gq63mquYx8xY+ajx/C2KZYdoKZfgPa53uxiqgeLN21Y3dxl87NLFYB3F8jq3IpjLCj+RoQaFL/kX8vXa3hsvmwZlXE1aR1jBQOYaZjTxSMk92cXmw5xNyGAnjMWK2CyDCGSJgz2MP8wtTt9OUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=xH90HT2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iadQwMJ7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C5EB138030C;
	Thu,  5 Sep 2024 05:56:36 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Thu, 05 Sep 2024 05:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725530196;
	 x=1725616596; bh=fpvXW45cCFPUgOD1UbFx3JsvBCsvIRuOMB9z0xPbXo0=; b=
	xH90HT2ihv337ZTOdSoekBd0rTQjMIirKJmltllKuRZUJTbWNLRF8jnNoGgrnKpB
	86k40oXh8nHhWqp+kBgPf4NGnv9ITmKQTMnW0MIDVVYTk4zjNycXe9RGJxTbuqfW
	Q2vdv45fOsgZzBV1rRxoImHH3tZS5WCGgjCSw+CwmJjEFrOWf+HzTQKrkHYZ0u7W
	7VmRUWtWwi/DlNQgXNRQp4TeIjHcl+6SPXo9C60nwdGmc0P0f1WJ63SI8ZJNBKxb
	4Z6E+AIcV+8xpKom+OOSOithfTorQWZu6upFLsbV5RjC3kA8EeenLN1GyqWfuNly
	Lp7ymjCmXKR6YBymkZbKaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725530196; x=
	1725616596; bh=fpvXW45cCFPUgOD1UbFx3JsvBCsvIRuOMB9z0xPbXo0=; b=i
	adQwMJ7bCR9L7mBRpnUZfn+kJYI9K835jSrJm22P060khYlnbvmbTJzzvadb5v65
	/ZGfMy6qQhnfXuhLwt5y0mHJSwVh8OEbfx1lVTosu60CZVt+mWSOwPgBnLiEAfX5
	D7xjA1XPdqTurrtRkVus8ZN4S+uVEzfCH4Zg4eWXyzrv9x2TcyWRMIcx37MOJKsB
	u/apcWr+Nr3UueCOWEzEuLh6Ifr+xgbTtdaJXcPKjJOBD0cWcqODaz8pjhH2BSrQ
	mW45nR7LvgH7Q8QLf9rjvHlg10FCFht+H+nnCP+elt/CBZdAk+TikSgzvcpUzOe/
	iNIKPFn9ZjeeYOJfSjLcg==
X-ME-Sender: <xms:U4DZZlJKRNK1Myy3fi7pUqfwtgTcsUjgvZnPO6ypnM1-bS1IW8Z2GQ>
    <xme:U4DZZhJtZ8m6cftICVM0SAYW4BtDTZ3SHLYdVx0B6aTr9a4z5KVHE0Sbh5ES6A5NP
    vc-Mi81aV0ApTSH1wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdfhtdelleeggeefudejveef
    feejhfektdeilefhhfeigfdugfffgfeiuddvteelnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghdptddurdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehtshgsohhgvghnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpdhrtghpth
    htoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgr
    lhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhgrtghrohesohhrtg
    grmhdrmhgvrdhukhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:U4DZZtv0_8zGN_cz6V665UB4jA6k7eWUOMf7mPmIJ-ElbKAbqSZAmg>
    <xmx:U4DZZmZvvyegcSyX6RfmDcCw9SAn5lAMwaA9DlmW24SJ1R4ES1J47Q>
    <xmx:U4DZZsbW40yh3ymnfi-IUEWCKFA4wxCVrayIHAOg_T1Ls5dASUrRkQ>
    <xmx:U4DZZqDyZqNWeKhfSKoLnxkAam9jMG4tBD7VvzVkZnlWWkpSUoYAzw>
    <xmx:VIDZZjU92oN8nFXLzZxbjAExBc-erMcR7cLl_cO2KoAIe3UOS_XlaLXn>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C99551C207BB; Thu,  5 Sep 2024 05:56:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 05 Sep 2024 10:56:15 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 "kernel test robot" <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Message-Id: <f661ed7e-5d69-403c-bfc8-7581eb8a6e76@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2409051011570.1802@angie.orcam.me.uk>
References: <202408310705.y2OPq3Xs-lkp@intel.com>
 <alpine.DEB.2.21.2409051011570.1802@angie.orcam.me.uk>
Subject: Re: error: ABI 'o32' is not supported on CPU 'mips64'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B49=E6=9C=885=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:22=EF=BC=8CMaciej W. Rozycki=E5=86=99=E9=81=93=EF=BC=9A
> On Sat, 31 Aug 2024, kernel test robot wrote:
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git master
>> head:   fb24560f31f9dff2c97707cfed6029bfebebaf1c
>> commit: 2326c8f2022636a1e47402ffd09a3b28f737275f MIPS: Fix fallback m=
arch for SB1
>> date:   7 weeks ago
>> config: mips-randconfig-r121-20240830 (https://download.01.org/0day-c=
i/archive/20240831/202408310705.y2OPq3Xs-lkp@intel.com/config)
>> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project =
8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
>> reproduce: (https://download.01.org/0day-ci/archive/20240831/20240831=
0705.y2OPq3Xs-lkp@intel.com/reproduce)
>>=20
>> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202408310705.y2OPq3Xs=
-lkp@intel.com/
>>=20
>> All errors (new ones prefixed by >>):
>>=20
>> >> error: ABI 'o32' is not supported on CPU 'mips64'
>> >> error: error: ABI 'o32' is not supported on CPU 'mips64'
>>    ABI 'o32' is not supported on CPU 'mips64'
>>    make[3]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-=
offsets.s] Error 1
>>    make[3]: *** [scripts/Makefile.build:244: scripts/mod/empty.o] Err=
or 1
>>    make[3]: Target 'scripts/mod/' not remade because of errors.
>>    make[2]: *** [Makefile:1207: prepare0] Error 2
>>    make[2]: Target 'prepare' not remade because of errors.
>>    make[1]: *** [Makefile:240: __sub-make] Error 2
>>    make[1]: Target 'prepare' not remade because of errors.
>>    make: *** [Makefile:240: __sub-make] Error 2
>>    make: Target 'prepare' not remade because of errors.
>
>  This is a compiler bug.  The MIPS64 ISA does certainly support the o3=
2=20
> ABI, so they need to fix their "CPU 'mips64'" definition.

Just for record, this has been fixed in LLVM-17 [1], while the bit is st=
ill
on LLVM 15.

Thanks
[1]: https://github.com/llvm/llvm-project/commit/7983f8aca82e258174849f1=
cc6a70029353e9887

>
>   Maciej

--=20
- Jiaxun

