Return-Path: <linux-kernel+bounces-235790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E850E91D9AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A81EB22581
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C172823AC;
	Mon,  1 Jul 2024 08:08:43 +0000 (UTC)
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823681AB4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821322; cv=none; b=pk3Tl4qmcWssQcmIYl616MPWyy4vi3/x5kitRFXanuAv/ni4NYriZjf8n3l6u0LBTy/H3RDJkbNcZIwkcn7WalPYMuOvkirWDJuDyOWmmr2QfV//xconCfAn5rmOQx5umXhTiSAID7M+ofjBD3tAfEN/zgBB/orpvLBbPY9DXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821322; c=relaxed/simple;
	bh=CSsYmUBxfHc30L8B6vNlO22F5seUPiAqBtknMmFWbpE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qT1tILhvG91PbaIzytgYnA+0ZykfI/lNSdnYM2cCOOkrLjbskr2sJWozlWdXH5lZuGq1ecyzpWB4JbVJe+8PMdlhfREHtz5vzjb66Ftatztwk/QHsbCvNjr5+DobynMV2/1EDyOZa95lv4gbl6mGSx16v6WyiP30pP3owKbhego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4WCJRM2dJ4z4wxqt
	for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 10:02:07 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1c8a:3990:9784:a231])
	by xavier.telenet-ops.be with bizsmtp
	id i8202C00D4bcH3801820MT; Mon, 01 Jul 2024 10:02:00 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sOBz6-000l3a-9Q;
	Mon, 01 Jul 2024 10:02:00 +0200
Date: Mon, 1 Jul 2024 10:02:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.10-rc6
In-Reply-To: <20240701072703.2941315-1-geert@linux-m68k.org>
Message-ID: <bb1acd5b-1a20-646-8d99-12dcfa899c3@linux-m68k.org>
References: <CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com> <20240701072703.2941315-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 1 Jul 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.10-rc6[1] to v6.10-rc5[3], the summaries are:
>  - build errors: +1/-0

   + /kisskb/src/include/linux/syscalls.h: error: conflicting types for 'sys_fanotify_mark'; have 'long int(int,  unsigned int,  u32,  u32,  int,  const char *)' {aka 'long int(int,  unsigned int,  unsigned int,  unsigned int,  int,  const char *)'}:  => 248:25

parisc-gcc13/parisc-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/22a40d14b572deb80c0648557f4bd502d7e83826/ (132 out of 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f2661062f16b2de5d7b6a5c42a9a5c96326b8454/ (132 out of 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

