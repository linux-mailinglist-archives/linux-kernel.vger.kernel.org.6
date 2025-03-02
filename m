Return-Path: <linux-kernel+bounces-540815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C0A4B552
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 23:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463CA3B03F8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14661EEA4A;
	Sun,  2 Mar 2025 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUqkDUAQ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CCA13AF2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740955097; cv=none; b=l3Y5d87wathldOle9TmQkeiBYzMTkbSWyHWP/fkNWOyU59XxTPeuxniJ7jvx7enRnwwXzapFuy45URdRPBDYAqSpVKq3sHk5+DWmUNd8niDWcRrdbEWt/2UAFFx3EWywM0VxqUSPK+/Lj3EdBUHJFyoatdagYQjOpr2QmsU0ozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740955097; c=relaxed/simple;
	bh=CxvF3eRuZDm/cgzY+K9oc9vLrSB0MRYleZdARx8lXjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaU97bW91JvKOjKAL2hdLLN/2vmPaPPMAmfrwfWOzcu5NGDOKXfwvtctSREVu7pRUEQWkzLMxkuVcAESmOSdjJlnxpdUOfzmLNZGkmiNn8Fa3n/KIRMSK1NYjQ1tC0/mMfCXePtCG+k0usVfLv4k4Dbm82jJUe/HilGMTsbEEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUqkDUAQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abffb7b9619so42805666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 14:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740955094; x=1741559894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw+dL3ih9Ru5ocXdzNTtXnWXwIbaMQzi5SPDYTk7tLs=;
        b=JUqkDUAQ7Px9boIK0MG5LksdmRcUK1/hFGQdqbgS73escwcac+b8Xg6AT7qRcd34eK
         W9SFeGSCeTx4SCVK0kHhnzmJ+vLfI/67A6bM7iMm14oaiupr7ergX2GxKssNWhl8KUSA
         BdSgLxBGS05pVnZaNAyxwSbtpYhUK2Fa+mT6899D/o26FnRkDFI/e3f7quCwqJrZ5s0U
         IJB/Nx6qTtdafF61LpzF0efHT3jRepCzC809ZEsymJ7CHm63HJMPCCuXm8HZW1dQsd80
         HFAovgKlf19k3oWyYfTbc6YLrG1eUdrnccJNxv49GXvTGRTw8Rr/yqxOk7PzOeFG4hod
         vYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740955094; x=1741559894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aw+dL3ih9Ru5ocXdzNTtXnWXwIbaMQzi5SPDYTk7tLs=;
        b=tlU5BRr1tkZuIulovrdcrv0hmtpFZ+QnzLGEJGuj+ABgSrha/RQ8DGRMx+x+RmYU0I
         JcYj/WYUiAObxE6ApiRSLB5fdkYzxr4Beo281pmb12SFyic4vAdqnuBriz1BR0ISN5Nl
         maOFAdZzhsq/wr6sTg9QtJUkv46BkCrMFvfpuL2c5oIeNSijh8ECCtS7EcSTOwf57RHl
         j6RCAHnxRV/NV2GJVE3BrRfiNHUOdhytUAc4z3946wgl4Esq+Eo0hsu4ynnR5gIETwhP
         KdBQA7nzV6stjp6heFmeIQ04VnCJlFUhobffggInMUELn5S8QyCLw4bjJZz5ui/TAozN
         Iyjw==
X-Forwarded-Encrypted: i=1; AJvYcCW4f4/UEDB4+wTzR5pyTaquj+I8kmQQDE6douGzRscoHfW3TYeC66Wj6LKRdS9x7Lt4dn0RW+rRb4H2eT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyIoQVe6BGMvKFrSfHoTRd3uwci73ObVBat3VoCRxBvaHRiMZ
	eKz6m+2rL0w1G+pXo+RQPBBXnvRhtcg55YNE7lRAc1hfzMO/s0Hr
X-Gm-Gg: ASbGncvnSjZtRi1v3bxS6Bago5y6HI5MvYFY4h8lAb5BrsfZx1sZCUQ08WsEWptLfEN
	biPIEIlItWKyvwEVPrmafH47yLQMLAeRZfX2TMO9wJNTil2UWbv3wfKri6Vo8bQ4zvmC/wgw7J9
	l1rPabM16YVEAVhCGXdbuJwYdvc/QD5WlFFOPwu3vnFzaasipMDoQEXtM2tH318cpsh7klmZxyL
	s8lAe58ZZvsBDJcjAwcxpHhGmZAco3G2/uevyqv+d2QRKTQVVZHABFSSq87mBEiGwWB/mKNzQCy
	BF0Q81SCXnmE55UhBrFHcqXP2j+JhtUqiuolGI3GRC2ZF+39R5Tf/ENr1RdukCzbeAasovpBQvo
	+IU1t+Ew=
X-Google-Smtp-Source: AGHT+IESXLdNXUeU8vHSEFoGyD+7dwYAf35LUDTPywZbGoKmPGIwyW2ehDuBvDVJfwhz26dqjrDkJg==
X-Received: by 2002:a17:906:4fd5:b0:abf:73ba:fd60 with SMTP id a640c23a62f3a-abf73bb00b5mr250603666b.29.1740955093593;
        Sun, 02 Mar 2025 14:38:13 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf40a603b7sm462758466b.170.2025.03.02.14.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 14:38:12 -0800 (PST)
Date: Sun, 2 Mar 2025 22:38:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: yury.norov@gmail.com, anshuman.khandual@arm.com, arnd@arndb.de,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 skhan@linuxfoundation.org, mka@chromium.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3 RESEND] uapi: Revert "bitops: avoid integer overflow
 in GENMASK(_ULL)"
Message-ID: <20250302223811.1a54deec@pumpkin>
In-Reply-To: <20250226065623.1567363-1-richard120310@gmail.com>
References: <20250226065623.1567363-1-richard120310@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 14:56:23 +0800
I Hsin Cheng <richard120310@gmail.com> wrote:

> This patch reverts 'commit c32ee3d9abd2("bitops: avoid integer overflow in
>  GENMASK(_ULL)")'.
> 
> The code generation can be shrink by over 1KB by reverting this commit.
> Originally the commit claimed that clang would emit warnings using the
> implementation at that time.
...
> The results of code size reduction are summarized in the following table.
> The code size changes for clang are all zero across different versions,
> so they're not listed in the table.

I've been looking at the object changes.

I think all the big differences are due to the compiler changing the 'inline'
decision for some functions.
This is most obvious when the functions bloat-o-meter generates differ.
But I've seen odd things like seeing an inlined (IIRC) pud_val() immediately
followed by call to the wrapper (which is just an indirect call).
(The kernel I'm building is for the machine I'm building it on and has pretty
much all the mitigations compiled out for speed.)

I suspect the +1/-1 and extra negates all depend on subtleties in the compiler
and whether it is doing |= GENMASK() or &= ~GENMASK().
Some of the differences are also in for_each_set_bit() which used GENMASK()
with variables - plausibly it needs a specific implementation.

Sometimes you win, sometimes you lose.
But simplicity is a good win, and the current version is anything but.
(It is also broken for ASM because _UL(x) and _ULL(x) are both just (x)
so GENMASK() and GENMASK_ULL() can't both be right.)

	David


