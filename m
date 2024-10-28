Return-Path: <linux-kernel+bounces-385627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A074C9B3996
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF8282507
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC4B1DF990;
	Mon, 28 Oct 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ei8RURQN"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3018C333
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141474; cv=none; b=RCjZ+jXmqap6NY8M/J8VXX9kNB5HuQWYxBS+7LxovkwnQrUbCN23x4YZ4lPO20ViUXlmgCUBDbrm8v+XVn2H6mSLXzl9ZK55IKZNnp4/949F5wt9osVNE6eSXpHv73spcT0PozlayyU54N8575fqG1ZTto/TTFvz4kkYCs8HD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141474; c=relaxed/simple;
	bh=f9kepVkx7ozexatwzky/15PVvfGex2hIQ3aQJm8Uw0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKMk/U+jp1N4ajrRGqnPADRQ8kxroO7QQSR4iH7ULL9Me+NBbseup1qIAdRuptulbibDckQr8mmN4As54SUua8wnH76Fj1iZ3J8EeGbhZcnDvWWQ/oRaXcye0UYjRjn49ETs/NsPe9MzhzlDtV/Pn1lcWDvNNz0cWwU2maKt3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ei8RURQN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso651256566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730141470; x=1730746270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kIxdURF54ugS0I9GsxO6vUsWqiwPODNyGYtyXOv/jbs=;
        b=Ei8RURQNyz+AMxrbXT/mbhn/I82fkNBpBmqDQ4gEOAEXTnldYFQPTHZtgR3KTSaoJW
         NnjPWMFYwdAL+Zctkd/Imx10dSBKb2I4DGSgkAqRrlRdGY7PbL2p236jdDd0H27uCyI+
         Idfm+YRLEO2f1fB4gHEYbb+/6WuUYDMkj637o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730141470; x=1730746270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIxdURF54ugS0I9GsxO6vUsWqiwPODNyGYtyXOv/jbs=;
        b=ari0o2q0ChwM2/6LA1J3kztLn7eKOUSpG6ByGokdmpMbrTrJW66hL4osOOnYlSwDBK
         OdGr4iTUPZXqzed2Fc1oSyLrxkL0EIW/yF/kXjo19kYGCjAtkeNbDIu7cHKrxs5qHApK
         aUOChE/nySHKw26APiwnxyKFlKt2GrSrwsJDUr6+z/se/OOqkBYNm4HCLn03fur/Ggj8
         8XYSD2CGGtk05GV4BzhFc+K21mCxrG/aW7kyeOr30d12l8pyGaQXSZmLcLDTlr0979jo
         n8Ylfwnw2WN6YIAIP5ba9ZMHu5jRPBKc0heCYPQHD1j9/E3soDXwXJA6S07vb7FLpo35
         pMRg==
X-Forwarded-Encrypted: i=1; AJvYcCUd2i9EnSoHNok8pfd+LYma0P4xUffAsBMdp5ppoqAG2lojDNJ2TZaTsgD6926Cs1TBWK9oA7hBwZvBiNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzLNSRf01mudRxy4vKDZgFzo5oqtijxdbv4fFiy+C/lRwmzn1N
	B0V3rZpXT646e2hh5d7j8gAMoF5ksTsPeTVgK6h+bgLoZ9z7wK7nC8PanXKzojU+ddYMxhjek7R
	NqRs=
X-Google-Smtp-Source: AGHT+IH7kfZo2fFFEkikELVkqvA0ULKFjs84OHW4cYddx9ryjdt/OXyQ5O8MiQXxGUOhbGluG8cp8Q==
X-Received: by 2002:a17:906:f59b:b0:a99:f975:2e6 with SMTP id a640c23a62f3a-a9de5f6ddcbmr974785866b.35.1730141470301;
        Mon, 28 Oct 2024 11:51:10 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1ee3dc7csm396251066b.46.2024.10.28.11.51.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:51:09 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so728381566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:51:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwvyhEYcbRXIZQrsxezUUesq0EoqYSNwGbJMJsd2YUQ3YS2fHnKzYwm//dN0uDTLmavpcesxVkWATSPc4=@vger.kernel.org
X-Received: by 2002:a17:907:7e9e:b0:a99:61f7:8413 with SMTP id
 a640c23a62f3a-a9de5ed3f62mr706790166b.23.1730141469413; Mon, 28 Oct 2024
 11:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com> <874j4w4o1f.ffs@tglx>
In-Reply-To: <874j4w4o1f.ffs@tglx>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 28 Oct 2024 08:50:52 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi4+sVr6MUsybh8v-fPYoruZK9AmtasqMYi7z09UKHf6Q@mail.gmail.com>
Message-ID: <CAHk-=wi4+sVr6MUsybh8v-fPYoruZK9AmtasqMYi7z09UKHf6Q@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Hugh Dickins <hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Darrick J. Wong" <djwong@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Oct 2024 at 22:41, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> It has caught real problems and as long as we have highmem support, it
> should stay IMO to provide test coverage.

Yeah. I'd love to get rid of highmem support entirely, and that day
*will* come. Old 32-bit architectures that do stupid things can just
deal with old kernels, we need to leave that braindamage behind some
day.

But as long as we support it, we should at least also have the debug
support for it on sane hardware.

Of course, maybe we should just make PageHighMem() always return true
for CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP, but I suspect that would cause
more pain than is worth it.

But yeah, I do think we should seriously start thinking about just
getting rid of HIGHMEM.

               Linus

