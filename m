Return-Path: <linux-kernel+bounces-413423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71859D18DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA6F281136
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E6A1E5027;
	Mon, 18 Nov 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ggvmb8Mc"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CC11E2838
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957993; cv=none; b=WiKgdRovrTlPXsloNUpPceKEMn+ZJpezG01GueB1aY/7JCtOTTjEg0q+IGdbD4nOv3ozjtYAB2Ig+g/OAB/jfGe5rAasd0c+PBScujyh4rRAL24HrdVQ4xzoX2dmYKJdfn3aVsHp/bEW4CdJtc90eO+MaA5KpFzSUXEbzOYB5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957993; c=relaxed/simple;
	bh=zUVH/uAD+IJTLUQDBYc09NFu0bSjr4OlrRtyJAhnrBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlZh3sVr0l/az25uJgqbkGL/v8C0vMXf9zWFhI/eJnQ9dAi5CiYFz9tEGhpZdChRfO1sMPfqOFkL97d631QiUAwfc5ebVQTGrF+1lK8w6Gq+hV6i4wtJJOVXge9Ly4mKtHEw/093d8LqDacGD/NpYAjLdSO41I09zWS7uMQhDKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ggvmb8Mc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfaeed515bso2824846a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731957989; x=1732562789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JYCS3Z6MiUnPrDvgzVamv2lmS38BP+UrcMAAY23BZP8=;
        b=Ggvmb8McADv0dJS5a1c+bREFDDd2pmnuS6SCw18hzYkx7Nz3UtZka8bWh6x0SWc5vG
         uZmYbDmy4n1v6jQKAuOwTXUUtgC/YYVhT5BgTcWIsTUvMlFMIyX7/rslfJtl3oLiibBD
         CHLK874swKbu0j5236YgyzUdCsvqWh5V4cn1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731957989; x=1732562789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYCS3Z6MiUnPrDvgzVamv2lmS38BP+UrcMAAY23BZP8=;
        b=K+1ig2JBr37kxHBqM2HBj1EhM/K4iIqQDayAkCELh+KI42ojHcYVR9tZuj/d9VKatu
         ZpTA/vouDHsTbyu+v2ECcWCEL41SZNXdPnPi3qTuj+Qbc8RfxR8Nw1Xfgih5VPagRw25
         SPoAOya/5xK7/vvXwsfj44yRI1icGy4lIQIZn/crg6JCtkJvvHG1HbokWuIxUqbi6co9
         iPBiEzDia8dL5ePPjC3XW5IWjmt6EaX+qR29PolBeNY6tpBEUHHDRCfswzanDfMAXH9O
         THlU7ILlWLa14X0n1GJ8tTsggkACHZL/XoMPgUYuB2v42lx1QrzuV+0m4zjgESivdg4o
         zw1A==
X-Forwarded-Encrypted: i=1; AJvYcCX9Mt1vNM9kN373jNOmrCivIo6iPqh4nIIdAHF5RDKoJVM8gk8RFaCdGP9nIg7osEiSlL/c1a5gju6PsHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbOXymcmJPRm1HZf6vDJWkEmmk9491HF4nJzab3g73ho0kLQ2b
	TGgistNlOjT49LZX1z3ozVqRdvHt7qZRk3rUT4uQKDDtdV7L51mCfAFlKoKPrxHHxa+CJHH3SlY
	1QmA3cw==
X-Google-Smtp-Source: AGHT+IGutuoOP5c7mh+SdGeoHNen20nLKdz2BqFrb+su3HbgkYqNju6teyNZCV0AvfqkW5X2whTitg==
X-Received: by 2002:a17:907:3f98:b0:a9e:d539:86c4 with SMTP id a640c23a62f3a-aa4833f41cdmr1121603566b.9.1731957989279;
        Mon, 18 Nov 2024 11:26:29 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df74fb6sm568925266b.82.2024.11.18.11.26.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 11:26:28 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfaeed515bso2824825a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:26:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZ4AZPxpF0b/vq+WFBjYAzfktOn1tZNP2QZ/eYuhOGMaeYBWdzwkrZGQocqJKehNl8yIsqVRZh/SxgeRY=@vger.kernel.org
X-Received: by 2002:a17:906:d7cb:b0:aa4:c8f0:6ea1 with SMTP id
 a640c23a62f3a-aa4c8f06f4fmr18763766b.54.1731957988223; Mon, 18 Nov 2024
 11:26:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-vfs-tmpfs-d443d413eb26@brauner>
In-Reply-To: <20241115-vfs-tmpfs-d443d413eb26@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Nov 2024 11:26:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgqUNhk8awrnf+WaJQc9henwvXsYTyLbF2UFSL7vCuVyg@mail.gmail.com>
Message-ID: <CAHk-=wgqUNhk8awrnf+WaJQc9henwvXsYTyLbF2UFSL7vCuVyg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs tmpfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 06:07, Christian Brauner <brauner@kernel.org> wrote:
>
> This adds case-insensitive support for tmpfs.

Ugh.

I've pulled this, but I don't love it.

This pattern:

    if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
        d_add(dentry, inode);
    else
        d_instantiate(dentry, inode);

needs an explanation, and probably a helper.

And

>  include/linux/shmem_fs.h            |   6 +-
>  mm/shmem.c                          | 265 ++++++++++++++++++++++++++++++++++--

I'm starting to think this should be renamed and/or possibly split up
a bit. The actual path component handling functions should be moved
out of mm/shmem.c.

The whole "mm/shmem.c" thing made sense back in the days when this was
mainly about memory management functions with some thing wrappers for
exposing them as a filesystem, and tmpfs was kind of an odd special
case.

Those thin wrappers aren't very thin any more, and "shmem" is becoming
something of a misnomer with the actual filesystem being called
"tmpfs".

We also actually have *two* different implementations of "tmpfs" -
both in that same file - which is really annoying. The other one is
based on the ramfs code.

Would it be possible to try to make this a bit saner?

           Linus

