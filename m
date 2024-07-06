Return-Path: <linux-kernel+bounces-243005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CEE92901C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C541C211A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3ED51E;
	Sat,  6 Jul 2024 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gAEErTLx"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDEC6FC2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720234586; cv=none; b=WJMrNFUfbtk8LrLeJ3xnZ7xBc5X58Nvi5JaGbzrXSuzddsJ9NYS5sLex4TUMOYFkKDcPRRVwRapZBVBu/XYX6ejCLkPd4MkDHv6gai1yWWwbOymfW/eq5+q8yks1I/bkb9zN9r4ZhUjQVBlIi3HChckAhggEQGNX0lzqIKw4ffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720234586; c=relaxed/simple;
	bh=j8NlKJHs3HpkPZXb7p+BZ/Vdi6mUzrTOnc5CKfHLLmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBpG3XbCNlDXu5bROt/1PpElI2JriOtNCxjOQiv1gybGqRGubBr4yxPDnFvwvXiKtnnpTaIh3X/j3d6m2fw+TzFgoGlQd6K1Zly096vI8ffEe3zVQy1GtAPbldj8Is8Ew+heR4JoM2AifN92aStdhUeyiVgcAOIbB6NI76VwS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gAEErTLx; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58c947a6692so2880441a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 19:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720234582; x=1720839382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eaTKlXf9YgluxGskEb87MYnC39vUHBvqvL6gWceypkI=;
        b=gAEErTLxz9GsIWelN/oKks3qGZeDHVQzxCOyz6WafKBUnytseaWkdJfkpgkfrz5/zw
         jOFSFk3C4bqx4v/7Oy25I4+O4AirZtA24ovrGNt55xKfHzyvhqGd2CwTZcfrtwcxoffM
         NuOhPN1INMcPX0Z3RF5pBNUiyKwLIIUXUno5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720234582; x=1720839382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaTKlXf9YgluxGskEb87MYnC39vUHBvqvL6gWceypkI=;
        b=Z/rgVngpIi9UURhXCIZfM5qHkNJ9LHoSm0mBxlcNZWAWeXcWTKM/KX6SD+oAjLiEN3
         kRfBGuy5kyq0ldBJOAoZzgR4Mui/uC8TmOUuj4IdY4gHX8Acmd4tFUFLwIY+NKqfOSq/
         aML/4Zg0LVADh2sB04Oio53aPeMglpL1iJXh37N8glvlqwvRVcKIeDO/1aMwJWJfvTcC
         pD55BLOY0BcGhaZOK0qxo8Z/O3Ldp6QfaBUqEpDOy9mUy5gjW54IqgccgPmKtn5hvBMj
         Cu5D6chzgWlLE4zfqeD22DhQQcONRaH0dhCWUyiVaLObozGoOnj1fbykvaxYyv1M7t2D
         VqUA==
X-Forwarded-Encrypted: i=1; AJvYcCVPZ4lSta4/ZR5eFKQBmGrXHxEu6/mzcjFG4j+IJWwta5OmZkkaWMjK+uoy8qgeTENkDV/gTzjeVJ4L/Jcp8HxrvlBiBvjLOI2/gMp4
X-Gm-Message-State: AOJu0YwXNRJpHD9pwbFBJTJIezHoJRyMLrqBsOwnTD64R9HHKjoiU4N2
	6Ntcf0U1MO4XrcV/Bu0oGytyIouGPP3xjiO0HYsvJpfafua+bhMNRqsCqPgyjqt+hG51PIIinnG
	fXcY=
X-Google-Smtp-Source: AGHT+IH1c391mPIJ25FRSihM7IAaekm/KGaOV/byb3aNkE3QKJp5KNyfBKoMXfDuGpHLJt3+f66qjQ==
X-Received: by 2002:aa7:d5d6:0:b0:58d:703b:c1d5 with SMTP id 4fb4d7f45d1cf-58e5cd151b2mr3462827a12.38.1720234582127;
        Fri, 05 Jul 2024 19:56:22 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58dafc1d009sm3358692a12.63.2024.07.05.19.56.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 19:56:21 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77cbb5e987so143668566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 19:56:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVx8e6CMBWq0f+Ql3miK5bR11JwvHZS02OtZmkNxwQezq0hts20qogYd3sjeF/+2knoCY6DoZBSdUQVKckoHHahJ+nc2ScgJ2gesJrm
X-Received: by 2002:a17:906:f0d9:b0:a6f:4fc8:2658 with SMTP id
 a640c23a62f3a-a77ba44cfc8mr414951566b.14.1720234580758; Fri, 05 Jul 2024
 19:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
 <ZogcxjLv3NAeQYvA@zx2c4.com> <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
 <ZogzJCb66vwxwSLN@zx2c4.com> <CAHk-=wgH=d8MUzJ32QNW_=KDQz7U5g_1Mm9sR9zB1iNUpxft7Q@mail.gmail.com>
 <ZohB6uPAVX03Sc96@zx2c4.com> <CAHk-=wgC5tWThswb1EO5W75wWL-OhB0fqrnF9nR+Fnsgjp-NfA@mail.gmail.com>
 <CAHk-=wjwU6o4QExra5qNzBxtX5NwTfaX8ytZKk8BFtOng6zqSQ@mail.gmail.com>
 <ZoiLzzM94m_sjfVK@zx2c4.com> <ZoinidZQY6hU99XT@zx2c4.com>
In-Reply-To: <ZoinidZQY6hU99XT@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jul 2024 19:56:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0qkgpNtm_OL-evArZxenQyJtk4BG0fVPGYqoooP6+Cw@mail.gmail.com>
Message-ID: <CAHk-=wg0qkgpNtm_OL-evArZxenQyJtk4BG0fVPGYqoooP6+Cw@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 19:10, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
>     https://git.zx2c4.com/linux-rng/log/

So we already expose VM_WIPEONFORK and VM_DONTDUMP using madvise().
Exposing them at mmap creation time with MMAP_xyz sounds fine.

However, I do note that both the pre-existing VM_WIPEONFORK - and the
new VM_DROPPABLE - needs to be limited to anonymous private mappings
only.

You did that for VM_DROPPABLE, but not for VM_WIPEONFORK.

Now, admittedly I don't remember *why* we made VM_WIPEONFORK only work
for private mappings, but that's what we did.

Anyway, that patch looks largely fine to me apart from that note, but
I do think you want to check it with the mm people on linux-mm.

> The selftest code is the largest part of it. There's no more syscall. I
> think it should be much more to your liking and seems like an alright
> set of compromises. Hopefully that's a bit closer to the mark.

From a "look through the patches" standpoint, this did look more
palatable to me, but I also would have had an easier time with looking
at the patches if the self-tests were separate commits.

              Linus

