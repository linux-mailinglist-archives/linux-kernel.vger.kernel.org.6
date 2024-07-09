Return-Path: <linux-kernel+bounces-245007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3BC92ACF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA258282320
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23759A47;
	Tue,  9 Jul 2024 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxAjad3P"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0186B625
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483666; cv=none; b=A8SzRHsaKdihrpIXtEBc0iKJCQDX72iQnVEa5mQGbxySkXaDuP65FL9OcCrvQrRDZuW2ULdEybeSnNJYQPkA/uJ+nO1BzLYF6+jmS02QPdRzGLODWuq95mddjMEqLo3zlHAjPbMZ89Vu3dmXOLWbVPEFUaEfU93C242g0JzysNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483666; c=relaxed/simple;
	bh=dqA93HQg2usj3F7De2CQ8lrpCWOPOjJm7LpwpGMb+d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsZSg70Mx0keFjMs3sKyjiNbGihyzctVI2MA2wNig+YXheaIquJv6yE0yhkSZ4gyxr0seudxtl+MIBtfMT1zl3n8kNKXpLNlhOMXCdDk0/bqbK5a1/rpHOa3c+zuS1tDJk5i34cvVRdMKR2LsHTINS6+by0CqA1RH9qnsT6snUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxAjad3P; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8102bbc95d1so1504556241.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720483664; x=1721088464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqA93HQg2usj3F7De2CQ8lrpCWOPOjJm7LpwpGMb+d4=;
        b=HxAjad3PaWR6vnNDEvBpYMVvlynPcT3I2Sj3c6tHQZ1wbETORji/ihjI6iuvcI3Dxj
         gPpcDPiYEf4htKq9loTm9uW2l1YNIfcgPHLcWhZ8TBsWANXuwkYNaY0vkMM7e5d4Q0AL
         MtzRl4DWrBXP6DbeHXONZoVCQeHoigIr8OlAiCESA9PdGM2vMSbbedXP/6043WgZbIVf
         9b5WQo9zbXSaLvXMUGwrR+xD3JFJghXEU6Mi5lUP87L71kiOt9Y3XgJLPrCCzOoW3pwd
         BD0SizkKVPVUpvN9VBwdH2LiJa84kH30QK4qAKn7FyNs4mM03Mg7Gp3OHeaQWRHo3DdF
         FPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483664; x=1721088464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqA93HQg2usj3F7De2CQ8lrpCWOPOjJm7LpwpGMb+d4=;
        b=uHBGIxuQHaW986MpiI/ND/y2yME5rbJ4SDAYYAiZD5oouiXBPoEABWWi5I7J9KOVPk
         skt+kCNzZ9cGBcywAfSLAROgFZ3x6zi4M1d035I4zyaej8nA3wrrRbA+lzJsPP355EkO
         QDE2EGM9cPzeykJ/0sAo7MOqtVxDu65m2f5+99kPhxWhimJzUrPOlHs5rc+8PAafDW+M
         v62vh22gk1ofMFoUkgfmSXcOOYigkK1U0x78Otyzn32ZvsL1RA9+u4n+JHrmIHGHTfua
         4qGO7JZuglt6J+KFvD3GAphhATKTmrzceGLD/w7zQffHplL/z3UxdySQ1flEBxlKrl4C
         KfcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxHqUovAFPX/MbNmDKkl0HzIY86Ox0Pnf1tG67HbbgMzVdUI6JebHJWQlGIQOJtdyHS2nWRS/JXerbmINAroQPLLKLXw9K0u/DWQgp
X-Gm-Message-State: AOJu0YxA6CZwJeeEaif3z/umsZGyyQnW0gHwx2T5C5FEj6XBmWcKLfXV
	L3UueL5/x2BYgiLdaCkctpNB4Hd0S6ndnqBcBjRKzcpKaeipPjMHYwSaAsZiGE7UUeyZ9GpoEV6
	tF2FK5LTsbuL/sLxrt2G65aKxhYZ7PDX8XMFv
X-Google-Smtp-Source: AGHT+IE3hXFlYFoVOFU0UJC+y1MJl5OnSIhHT8uqYSudjha0MxXIm6lSQSbeNUfOdK2HnHolICtBIDM2iFaTkzFmBbY=
X-Received: by 2002:a05:6102:304e:b0:48f:9897:8385 with SMTP id
 ada2fe7eead31-4903212d7c5mr1199444137.9.1720483663696; Mon, 08 Jul 2024
 17:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605032120.3179157-1-song@kernel.org> <alpine.LSU.2.21.2406071458531.29080@pobox.suse.cz>
 <CAPhsuW5th55V3PfskJvpG=4bwacKP8c8DpVYUyVUzt70KC7=gw@mail.gmail.com>
 <alpine.LSU.2.21.2406281420590.15826@pobox.suse.cz> <Zn70rQE1HkJ_2h6r@bombadil.infradead.org>
 <ZoKrWU7Gif-7M4vL@pathway.suse.cz> <20240703055641.7iugqt6it6pi2xy7@treble>
 <ZoVumd-b4CaRu5nW@bombadil.infradead.org> <ZoZlGnVDzVONxUDs@pathway.suse.cz> <ZoxbEEsK40ASi1cY@bombadil.infradead.org>
In-Reply-To: <ZoxbEEsK40ASi1cY@bombadil.infradead.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 8 Jul 2024 17:07:05 -0700
Message-ID: <CABCJKucSUA_fc1eWecWAZ3z8J-T=s5zsZunJHF2VgB=9V5c3tA@mail.gmail.com>
Subject: Re: [PATCH] kallsyms, livepatch: Fix livepatch with CONFIG_LTO_CLANG
To: Luis Chamberlain <mcgrof@kernel.org>, Matthew Maurer <mmaurer@google.com>
Cc: Petr Mladek <pmladek@suse.com>, Gary Guo <gary@garyguo.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Andreas Hindborg <nmi@metaspace.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Song Liu <song@kernel.org>, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, 
	joe.lawrence@redhat.com, nathan@kernel.org, morbo@google.com, 
	justinstitt@google.com, thunder.leizhen@huawei.com, kees@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:33=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> Looking at this again its not to me why Masahiro Yamada's suggestion on
> that old patch series to just increase the length and put long symbols
> names into its own section [0] could not be embraced with a new kconfig
> option, so new kernels and new userspace could support it:
>
> https://lore.kernel.org/lkml/CAK7LNATsuszFR7JB5ZkqVS1W=3DhWr9=3DE7bTf+Mvg=
J+NXT3aZNwg@mail.gmail.com/

Matt, was there a reason we didn't move forward with Masahiro's
proposal? It sounds reasonable to me, but I might be missing some
background here.

> > I am a bit scared because using hashed symbol names in backtraces, gdb,
> > ... would be a nightmare. Hashes are not human readable and
> > they would complicate the life a lot. And using different names
> > in different interfaces would complicate the life either.
>
> All great points.
>
> The scope of the Rust issue is self contained to modversion_info,
> whereas for CONFIG_LTO_CLANG issue commit 8b8e6b5d3b013b0
> ("kallsyms: strip ThinLTO hashes from static functions") describes
> the issue with userspace tools (it doesn't explain which ones)
> which don't expect the function name to change. This seems to happen
> to static routines so I can only suspect this isn't an issue with
> modversioning as the only symbols that would be used there wouldn't be
> static.
>
> Sami, what was the exact userspace issue with CONFIG_LTO_CLANG and these
> long symbols?

The issue with LTO wasn't symbol length. IIRC the compiler renaming
symbols with ThinLTO caused issues for folks using dynamic kprobes,
and I seem to recall it also breaking systrace in Android, at which
point we decided to strip the postfix in kallsyms to avoid breaking
anything else.

Sami

