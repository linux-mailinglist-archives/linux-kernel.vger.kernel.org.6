Return-Path: <linux-kernel+bounces-442185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65ED9ED921
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8107C282709
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ACE1EC4D2;
	Wed, 11 Dec 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fu4f4Uel"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA21DBB13
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954227; cv=none; b=rqrEhj3KmOCMWbRvZ7sl8s1d5wXfedb/RxSqLK/BdJ6M7cLdrEUVXyvTbXxI8DVsEuT272UOvmcA5DNXGwHKWsTnGQ/9vqcoA7v1/CBOM0vVgtyWZaOWvM1I0jWKRuSX4KejXDjzEH5bP7lNn32JtYpt05TQEoWjK/QUA4hSc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954227; c=relaxed/simple;
	bh=XhFHkK4EH7ripxut0rTEo60ntAYNCbRPNz8/oZfn5ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkK2vLWrI8E+ZjnNvINLXCjY1ApcYCg6Z8CHzBGN+FNr8HEPV+w3iAzDjnli39phEZ5yVDGjxXmqHP8+1/tOG7sKW7ZK0VYQ4xfwiyWJAtsliaH5HOu/UOnmdI9LO93Z9OVt4xQ5CcjQT0Q57HMnQ9oBDlcfP6ZxFik7poivyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fu4f4Uel; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so7190238a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733954224; x=1734559024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KKxs298nGNGkrDha0ysKIASdV/ZG9FoC6k4s5+vTLeo=;
        b=fu4f4Uel8Kwtr1L2iiYjVTFXMn9qe863xQt+/XJoManO9kz2cExh2Z22oNxwpDI7uG
         BnVbdbbi3kROANZc7l+qY80RmbE+4exiV5rEfaYDgQcaPYbPZJT8j/6LsGo5MZymk4YT
         44lFSUHDZy2hREsF2Xc5/auYsnrCAsP38cCQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954224; x=1734559024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKxs298nGNGkrDha0ysKIASdV/ZG9FoC6k4s5+vTLeo=;
        b=FLC7vXyrlrDCtwhAJknZYBerLGDYBTEdw4yw+iWh8prOV5s12VY7ymE58bbaaAMF5O
         rD6S84Q7D6xwhGAGWYdp2W+DDfiARZAm3zKQooEQq2xXJA2AI7VlQXGVlZ8rf3d3T36i
         uQ4N/CDvC0RiHhNgVBhQZMwkKjeoKPu5rSZSkxEn7u1opLIWutymixrcLAMvmLvAAAPP
         jpAAMz4zf+OvKL7T9bxIvayP2o7T6GvKbLhWKf5ugTWWzp14vQQom/0AiMXSl16lNbqm
         TevKKMfwNx1L43Oo6CppxG3/zRcapCvaZ6WhdpppqOnGRZJbkqyW94qSHqsBoTQSmW7E
         LRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgAeLvnLWgRnz6je3m/c6bJH/GZeB1xbD4aLTRt/oD2zJnGerLDL3fUYzfse7FvsiOQTug+boadhuqxrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTTj4Qa9BzgE9NlbIJlH7AFWVf7HoNfirIBzAN2Iw/fDDPBbF+
	VQGN5EBLC4Q7Vif7RC/S6vTdR321vNGzsLBb27rBhG6YQ2aNl4FOIMtnG1/UqNuid0QbzIQLsrU
	aAsY=
X-Gm-Gg: ASbGncsRUzmY5cjW8xOb3rhYWUlkYbRE8PfUtxcjqTKh9GmIKYJb1p7ipziGQbwnjY/
	6w4ub3j7eCx+RGhCyIX0e6Dp1qOSJOHJGfIyDqLeowqKnfCKga4rTXZzcaWOq+4SUEAU0iitLwj
	U5SK94ib23nmlspIvBF/jPCebIZnTaCWdkIo62rUa7agbLooAb6B0loIe1vd9Qj6KVHO3IIBuha
	ZV/AN8D3g1QjoqsfVY3rS0u0LZUvMwKM+kBE5BrYbh1lxjW4YvnqhILF9bI3pPKSwdZKQOs6OPM
	e1xRntajzc8JuYFUCichWvrWD1gQ
X-Google-Smtp-Source: AGHT+IHeL0zkRALhPpGfmnAPWSLHLPq2+wpZxM6IMMzIXgTbNcx4NpqCCvqJ02/uCP2IOXdg+oKoPQ==
X-Received: by 2002:a17:906:3112:b0:aa6:8bb4:502f with SMTP id a640c23a62f3a-aa6b13cad1amr381980266b.50.1733954223806;
        Wed, 11 Dec 2024 13:57:03 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6845ab4absm535667966b.73.2024.12.11.13.57.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:57:03 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa69107179cso706901966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:57:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFBC8nizAfObSrQdVRQJnGsU1/xj6tW6bvezB9SbAkzysr5/xkXJQ2dKcgNTLFkff6LLei0qK+iSX9JN4=@vger.kernel.org
X-Received: by 2002:a17:906:cca:b0:aa6:81bd:5478 with SMTP id
 a640c23a62f3a-aa6b13e33cdmr372644166b.60.1733954221923; Wed, 11 Dec 2024
 13:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1mzu4Eg6CPURra3@google.com> <87v7vqyzh4.fsf@mailhost.krisman.be>
 <Z1nG-PSEe6tPOZIG@google.com> <87cyhyuhow.fsf@mailhost.krisman.be>
 <CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
 <CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com>
 <875xnqudr1.fsf@mailhost.krisman.be> <CAHk-=wi+ZB4fNiMTHOYo2__-NnBXryQwxJ_bHN+cUDsfBBt_MA@mail.gmail.com>
 <Z1oJ7PgRvLyctn0X@google.com>
In-Reply-To: <Z1oJ7PgRvLyctn0X@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Dec 2024 13:56:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whB_YjwB4sGsRGJx8AbxR8wRAJBfy+x2KhsAQ4QssZpMg@mail.gmail.com>
Message-ID: <CAHk-=whB_YjwB4sGsRGJx8AbxR8wRAJBfy+x2KhsAQ4QssZpMg@mail.gmail.com>
Subject: Re: Unicode conversion issue
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "hanqi@vivo.com" <hanqi@vivo.com>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 13:53, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Casefolding supports f2fs and ext4 per Android request, and only f2fs
> constructs hash-based directory structure. If we use hash of the
> case-preserving entry, we had no easy solution to distinguish file_A and file_a.

I really wish people had just done case-folding as a slow case, and
not used the hash at all.

Does that mean that you have to walk the directory linearly? Yes it
does. But that's my point: you shouldn't optimize for the idiocy of
case-folding. You should optimize for the sane case, and actively try
to discourage people from doing stupid bad things.

Oh well. Too late now.

             Linus

