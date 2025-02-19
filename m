Return-Path: <linux-kernel+bounces-521616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6518EA3BFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D48318864D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C51E3790;
	Wed, 19 Feb 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jng+Gckh"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07653987D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971795; cv=none; b=GRMd5eepqhyqZBTFxa0Pj8xvKW2bUlOKsg+HoMLLyDZE/PBYV1uPUPXpnjPVS5avVXcuIoifHt2KDa01vZqyztlLel5/mpWX40H9H16F2lYfnWZ/o52Crj6m92epZ+pzAdi9VxmJE53KeliK0q92F1r/sLyg34uhJRRwjhX6Bh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971795; c=relaxed/simple;
	bh=hVh55vJZtoQidTIM5XHWJzETxM2zRItmD6CYQpHEGcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs2hpcENfgRbytNhlVWQNXVOONTHEkY526ST8bCTQuP9m2og05p8Cm3ifmILpPL2UC5FISiVX9ODcClCcNPmOfP8CzbDsOviT/099ABH0PQPDuGPAj+5BoSlDpzMDbcMjUa8/BdzJ1rskaW4dV1fdmRY6DqjvMDDoF6ha35mrdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jng+Gckh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e66d4f3be2so57848056d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739971791; x=1740576591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EM8Q49ZKbqqP5TgUFZOFQqAwVb95aIumRELDXD00Y80=;
        b=jng+GckhHDoWrnvPRG0SSQeEAdnVqAGKohDDAHhjrNTEF/Ld3srtxbUWZfPxuFqaAs
         4BlwdJ4WNDfZZLcedZX5KsQgLMcqs7wjmJR0LOhx4+2RLMemEHPl8021+oldYYb97VEw
         XLrNmceSINDSl+ESvLiMmr4Wik84bXSUkWchH6yV63OSaQNg1qRjzIWiIz/K4IQDbkOg
         ZXhfvIMgLrdc6fCUrYo6qLlXo0y4NekXKXEHQGqXkz6HczB6dQ9mFeN6GCmQry9MW+T0
         GjNDApesPbkyLXdBRupeom3eEmAw8RnGnx6Bt8x2p7PFEQlEoaafAZp+cAptX1US6uGp
         DqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971791; x=1740576591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM8Q49ZKbqqP5TgUFZOFQqAwVb95aIumRELDXD00Y80=;
        b=wlK9q8HeAJ6BthWq/zAzl+U0XGBTcyFWPoyuZ2+P6Z1dj8VzImFzcxhnK3L/+BEErs
         +t2I5Yxw+G4iz2ZIEtTgCx+GnMN4/KBlPI+IJwRND8o9TgWTTCvwAFQV9X9VwpXWChgL
         nz5nzXgT0UXNnUDjOs+oDuUcQbZaZ/3Qkej8YHfyuaUPPGZpigbeKK4lpkV5ESCFNWhm
         6X2ORz6KTyYpCy5rEExxCSJ8I1LGiQm/5AU/Uvgr+Em+iixswrY4tCvauuw1skskeFRa
         Po3p3ZWVvVnokSoS2JaIIyCExZYWoaJfoZqCQOU4FQ0OwGJUMBH5l9weXPmoy+GqVn21
         qv6A==
X-Forwarded-Encrypted: i=1; AJvYcCXzVj6Xc9QOlVWnjFK5xgl6ubhOd9+2a4237VN6c3wl1PVXypjtYbjeMz+6G6l1K57R68ZC7em0D4wspa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpaYTqJbWWX67MJM4Ez83lfC2bwUnIS6q5c90r6bCTrKp+1A2v
	DrX0EYziw09VDsps/uuNOUBs8+5Z4XLxsZjaJLxFBeifNW3BewZx9XzmPVCI4UM=
X-Gm-Gg: ASbGncuER0x9J7GbCDcV/a7JW7Ik8WJ91b2GlKMM8diezOW61dcy9w/R7neHKCmlDc9
	yVbyR3hKwmtiaXYIiQ29Wkq6jRhEQWrl4o8SGh8A6yeE4OQDkI5frPTNDyv4vPtKi+KxJOBBN0D
	+vbdzacnD0TL4O9JGr1W6+g/uJE0gVjj3odbb8y5f4WHDMCjrSCct6S/gi3dZ74ZJovlS0Xg5YP
	tB024DF2H9SvmsM0i+F4ooPeCmaKNLj1w+JdPTlAQV+GKoKXbFKM1JnSZH1EayO3Rd8/Tg70x4I
	cE8EBwS1RBeicTlEJVFM6XsAL8uSkgk/DLQzKMFeDhxFdINShEIQkkuytUSOdT841aCY7MRCtg=
	=
X-Google-Smtp-Source: AGHT+IHpnjPRpAHnRIkV3tI9dUEx+usG4D1JduwQF0CjSl6ExpZz/GvwHX4u/vdLvBctMykfB2zWTg==
X-Received: by 2002:a05:6214:194b:b0:6e4:3fa5:468 with SMTP id 6a1803df08f44-6e66ccdf337mr230029276d6.24.1739971791651;
        Wed, 19 Feb 2025 05:29:51 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e67c868dd8sm36111516d6.79.2025.02.19.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:29:51 -0800 (PST)
Date: Wed, 19 Feb 2025 08:29:49 -0500
From: Gregory Price <gourry@gourry.net>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
	peterz@infradead.org, keescook@chromium.org,
	gregory.price@memverge.com, Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] syscall_user_dispatch: Allow allowed range
 wrap-around
Message-ID: <Z7XczcHC-6RcBqzX@gourry-fedora-PF4VCD3F>
References: <cover.1739894594.git.dvyukov@google.com>
 <607562bf50ddc81ebd404e8dc1710e5221f80342.1739894594.git.dvyukov@google.com>
 <Z7S8SAGt8blFiFTg@gourry-fedora-PF4VCD3F>
 <CACT4Y+Z3ismwdeqa7iMo0JVD-u-nvSmN2eS5qJ5tUqXT9NjWcw@mail.gmail.com>
 <Z7TKvdjvmtzfjza6@gourry-fedora-PF4VCD3F>
 <CACT4Y+ZJhCD3Y-nNKb42K0561tOceYKRNm6Yi8r9-KwoWfvkbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZJhCD3Y-nNKb42K0561tOceYKRNm6Yi8r9-KwoWfvkbQ@mail.gmail.com>

On Wed, Feb 19, 2025 at 09:54:28AM +0100, Dmitry Vyukov wrote:
> On Tue, 18 Feb 2025 at 19:00, Gregory Price <gourry@gourry.net> wrote:
> >
> > No.  SUD's purpose is to catch foreign-OS syscall execution.
> 
> My understanding is that aiming at concrete end problems is not the
> kernel approach and design philosophy. Instead it aims at providing
> flexible _primitives_ that can be used to solve various end problems.
> It's like you are not selling pencils to draw trees, instead you just
> sell good pencils.

Fair point, apologies for being blunt here.

Mostly i'm concerned at the use of SUD for "sandboxing" when it is not
itself a sufficient isolation mechanism for this - it's far too easy to
bypass and has basically no guardrails to enforce it.

But it's not my place to say how to use features in userland (also I've
written a lib-c interposer for fun with SUD anyway so *shrug*).

> > Like I said, I don't necessarily disagree with the change, just a bit
> > concerned about the direction this takes SUD.  It's not a sufficient
> > interface to isolate the behavior of a single library, and this change
> > naturally begs the question "If we do this, why not implement an entire
> > multi-range filtering system? Why stop at one range?"
> 
> That's a harder question. I think we don't need to answer it right
> now. We can just consider this proposal in isolation. This is where we
> stop now.
> It preserves all of the existing uses intact + allows more cases with
> a trivial code change (actually deleting code).

You may also want to update

  Documentation/admin-guide/syscall-user-dispatch.rst

to have some examples w/ wrap-around, since most people would not even
think about this as a possibility.

(also, i'm not sure if you've sent a cover letter or not, but lore seems
 to suggest it is missing - and it did not show up in my box)

~Gregory

