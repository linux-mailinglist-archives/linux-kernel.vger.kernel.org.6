Return-Path: <linux-kernel+bounces-424096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5F79DB090
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D67B2317A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C725238FA6;
	Thu, 28 Nov 2024 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2BH+OQE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA212B73
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755422; cv=none; b=L05VP0B0uW6wGYhmO3vTMKpYbDOcASOa5Cpw4rZQbZVqQfhdqd2gSVL4W/C9xoscMuM7xeIEc/wBsqZcJmItWb+WYSX9D3kRCuTmQe9pV7IXkLTgvY4ZY+tVGCxlrR+QZYp7e1S86oC4kzdzGUTdYe979oYCNhmGD42T8CVCvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755422; c=relaxed/simple;
	bh=vs6YXMnxVt6ZuO2IeY6OKd6OXD6JflY5mqVHPDRj7lg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSU9reCloMMjOli+4MJw4gi3mMOpyI4YWrRn1s2TwYKpGd43wcidGVlXnzv9AByMAEveMz+jHwOikhecxx6C2gOEzDGVOWdQWR1CtAGPFLON1vcHUS8HZfUYyr5LwLtiwj9QkB7zjhdiuDlCd4xhk2fEd8bRjH/5PInR2EUT/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2BH+OQE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732755419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3M5NXT5NgYcv7o/jCn6O1ltoqUkEXIHN0lrzxbItZPY=;
	b=e2BH+OQELUCneetGpm7axEAv/6UEu6bFG+DlRePFRUj/lYpdIfuCvA8xDUpqVs+Eyb9i5R
	UCw7trXsRTGxjLm4jssZNX/PphJtjM6ZTNtJ9uU3B6iaj9sPM5r58X3C2ZnMuu5Hryxb4Y
	JHJpLG06BazYl5OtnQOgsC4736cIcs8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-Ra25zobUNJmJdR_LQ2E24w-1; Wed, 27 Nov 2024 19:56:58 -0500
X-MC-Unique: Ra25zobUNJmJdR_LQ2E24w-1
X-Mimecast-MFC-AGG-ID: Ra25zobUNJmJdR_LQ2E24w
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7a1e95f19so3027575ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755417; x=1733360217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M5NXT5NgYcv7o/jCn6O1ltoqUkEXIHN0lrzxbItZPY=;
        b=VHxIpc73av1jbO7E89uali3YEpuCJ/kissha2ScErBHgdS5Jb++sRyzw6wFqwSef6R
         U6oqF/8MzIAf1Qj+YgEWXFSuhMP6cLAjGu67ZG0GjE+Wo6hFUs6/RQQiJ4Dg+PuGSCRe
         xS3x6Zg4ke43kJZ61TQwydD2k8Bhhd0B4oqDNWwST53zHoR8a/S6PL4kwNroNs9O/5KL
         stJujmHuEoqLUzxrbcTaVnCFTTDiz6R/g95gDc4Bc9Ac/qJsv1xf3Lk6UNgch3pQpfzO
         /ae6JpXlqzOni55B+9d7nwE6FZbHzSWD1H2CdcNRLH0wtTn0SHMALlXUCYfiEBYCqViM
         fhWA==
X-Forwarded-Encrypted: i=1; AJvYcCU+s/ImlVq4nkI3u/PfxbztXGgkdrPtZ14FAJQgOqUgq5k1hxWwk8dhrsTqxZHvvKEUmlE7nZyIsFj/XjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKz2bwVJcPEaLezKRJUULhn1Z6EwZZnF9BFHCYPcazwLc/97ZG
	Xfi4eQD1HkrSWTI5y7h5sSuqoBW/fh2ouRs8wGCTOzWxBXFdugLz27KrEoSlM6BVbPmBQrEZ1A6
	ddWG8NiZYzstkDrwSfVTxTaiY68fLgbk6NySdFXVspvUz1Mm01uJS/yG8/U8CGw==
X-Gm-Gg: ASbGnctbY0zT/lP4FkFCkA2IS0iwQTDL2JK4UksteMfSqmSq6vmBVZ2HI0geWB58Ul5
	U6VtXmCN5BFjmwVXT9KGfxkvClNlj7Lto6AAyBj0v8kvlGa4704ETWnwydxBS7DC+jmwt3bBRSc
	OUvXmdG8u5qhUaH32/fNEAs9h9bo9Lxd/jGb4kGeDy8qEzyMqScSLZ40YCDy/In+8R5GrYPbamE
	XCP2Ymr5/aclyYKONvX9kZIQ1Hm
X-Received: by 2002:a05:6e02:1689:b0:3a7:20d5:8157 with SMTP id e9e14a558f8ab-3a7c556318dmr49585465ab.11.1732755417411;
        Wed, 27 Nov 2024 16:56:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3OUPVfIS+/L/sPPeAdCxXP7P6uumIqlNzsg8OI4AY+2yONPmztCAgPhLuzEUCMU+Gnm5xTw==
X-Received: by 2002:a05:6e02:1689:b0:3a7:20d5:8157 with SMTP id e9e14a558f8ab-3a7c556318dmr49585275ab.11.1732755417126;
        Wed, 27 Nov 2024 16:56:57 -0800 (PST)
Received: from jpoimboe ([2600:1700:6e32:6c00::1e])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e5f229sm54157173.82.2024.11.27.16.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 16:56:56 -0800 (PST)
From: Josh Poimboeuf <jpoimboe@redhat.com>
X-Google-Original-From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Wed, 27 Nov 2024 16:56:53 -0800
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: annotating jump tables (Re: [PATCH v2 5/5] LoongArch: Enable
 jump table with GCC for objtool)
Message-ID: <20241128005653.st7xwkv2gry2chlc@jpoimboe>
References: <20241105123906.26072-1-yangtiezhu@loongson.cn>
 <20241105123906.26072-6-yangtiezhu@loongson.cn>
 <20241105141530.GE10375@noisy.programming.kicks-ass.net>
 <62df4c24-68ed-fbfc-ed98-2df796697d89@loongson.cn>
 <9589c5b673f45f02e2b0fa9d9a96eff0f0df0920.camel@xry111.site>
 <7e8adb0b-e681-72ae-40d8-740dc3f9480b@loongson.cn>
 <20241113211119.lfwlxv2bjyqfqeh2@jpoimboe>
 <CAKwvOdmE7zZN2x9echrje7dqunda=SywqurkyXyJaaUp3M0aEg@mail.gmail.com>
 <CAMj1kXF=55+z6udToxO=CZdTK910-jxKdCXpryQGg580J9eXEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXF=55+z6udToxO=CZdTK910-jxKdCXpryQGg580J9eXEA@mail.gmail.com>

On Thu, Nov 14, 2024 at 07:13:18PM +0100, Ard Biesheuvel wrote:
> > Looks like this was added to clang in:
> > https://github.com/llvm/llvm-project/pull/102411
> >
> > A comment in llvm/lib/Target/LoongArch/LoongArchAsmPrinter.cpp
> > describes the scheme:
> > +  // Emit an additional section to store the correlation info as pairs of
> > +  // addresses, each pair contains the address of a jump instruction (jr) and
> > +  // the address of the jump table.
> >
> > Ard had a prototype in:
> > https://github.com/llvm/llvm-project/pull/112606
> > which used relocations rather than a discardable section.
> 
> Thanks for the cc.
> 
> I haven't followed up yet because doing this generically is not
> straight-forward. The main issue is that AArch64 jump tables could be
> emitted into .text with scaled offsets, e.g.,
> 
> adr  x16, .Ljumptable
> ldrb w17, [x16, xN] // xN is the lookup index
> add  x16, x16, w17, sxtw #2  // x16 += 4 * x17
> br   x16
> 
> .Ljumptable:
> .byte (dest0 - .Ljumptable) >> 2
> .byte (dest1 - .Ljumptable) >> 2
> .byte (dest2 - .Ljumptable) >> 2
> .byte (dest3 - .Ljumptable) >> 2
> 
> So just emitting a relocation at the call site and a symbol covering
> the jump table might work for x86, but if we want some that works in
> general, we'll have to come up with some format that describes in more
> detail how to infer the potential destinations of an indirect call it
> is known to be a limited set at compile time.

Loongarch is emitting an array of (insn_ptr, jump_table_ptr) tuples
in .discard.tablejump_annotate.  Would that work more generically?

Even better it would also emit the jump table size.

-- 
Josh


