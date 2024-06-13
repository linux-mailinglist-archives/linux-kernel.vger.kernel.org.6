Return-Path: <linux-kernel+bounces-212462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C16906150
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D5A1C209A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536EE18651;
	Thu, 13 Jun 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AJ9MZTqp"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A58472
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243361; cv=none; b=WoC/7zL7FEO8gk78XeLA7FQAJQ4XrqocWq6N1jwenBgQI+HxwiQtjWudBPnm6WphSX/up3aUy1OQ57EGMckiEtRbfKskfeRUiwqEvCktZAXQ85G1lldKU0z3HeaC09eCrgtrUpg/GOUvV+ROIlLjG6hM9sD8r4LbUiz3X8lETjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243361; c=relaxed/simple;
	bh=MKXNxvjvDMlEDAFGJ+FZDsHfj2sWvELkDCT2U73q0SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8QOfCsUy5xg85+56A0tUTCfILJ5hKWwQAmr8oirJiI1Bl+J7lTrXMGfmh1vE8PexJZGV2DEc8uyKGyDFgjbYskSjzvrkfv6Uvcb2cSMXchhWXMLtv9Zk+xzoNKVJNVjNuWhpfdkbLlI4Q0S+lKt9MUfN58ZdwSCfPxnWDS+w5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AJ9MZTqp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so344483a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718243358; x=1718848158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u7oeDTF4u1EiwyzNNT5qA5Y4WKuC5XsAbUMmFlcK0R8=;
        b=AJ9MZTqpsDIki8eGBZhJhIpVC3BYX0NdDln2KSv2lGxd3t48V5x9Wxr6U+fMpINALR
         QtIn0liIvzPSYKEvHPa8RaAx37Qr/KvCecrzp7cAzb3Ivh650dTX7Y4nxTRxr3R0gmv0
         jpPvoDtTSQ6wS5WaoMseGleCRxEs+ahv9R83o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243358; x=1718848158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7oeDTF4u1EiwyzNNT5qA5Y4WKuC5XsAbUMmFlcK0R8=;
        b=EX7zEw25joGChBOAQs2ytHXvyj4bLCHL+B6lFdQgnFdxZFq+knAYC3qqJzayHSQtzC
         Y4BRjrvSetu+EQjdGVmpOERxq8B/YlW30vf41vW+zgpdsqPk2oSfb2rov2BP1rQ5oDyy
         e958k2SGubibCUOF5XovDyLAhQqQYleD5RcNcu7QKkZSSYcPDhRzg2v5QYKHU63+VL+u
         31qQOMUZfj0EIQLkMTELrQyXpjEz3CWxDh2/RD1ONPocf8WJQhNuRAJqiLbwBYd46KUH
         0qTQOFCASi8S2Aa4w0wFChK2V3is5tRpan7P45zNoCfGZPpAdQuijJ0f/abX8/ReavX3
         3qzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUhYUgGyDO+uDwgkaDiEctXqLYNV/GY4W4BR+J+pPQ6qfXNziEh7FQk1m33MigCfvlG990qZcUzosWVSZLYDf+Y8917cmk2WUCakN5
X-Gm-Message-State: AOJu0YwQVatEImS7o4FPKY83GPDOy+ydbv8wT7YART7UP7yjq2EfS/qL
	uSKpbkP0PW09nW6f+RZ/j2Oka9aEvv/igLDgrcbYemTd4PkbGp+UyQhTUF5UF5ahEvRWULxNfhS
	ZptdyuQ==
X-Google-Smtp-Source: AGHT+IH2pk+qXSab7PBC9mpL4F79sOCDpEzfcBg6k0HqUdQsIkqkC9UB2udFg72DlqKyAI/KCEcrRw==
X-Received: by 2002:a50:cc88:0:b0:57c:61a4:e56 with SMTP id 4fb4d7f45d1cf-57ca97697b5mr1957903a12.19.1718243357591;
        Wed, 12 Jun 2024 18:49:17 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da713sm236362a12.30.2024.06.12.18.49.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 18:49:16 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso73484866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:49:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYiepbWCKJRs/f45f7IlpmP3u1P2QvG2lwKTN2JGTUXkrw+9vhM8GjCLsBYpyNULKowGSvnzCBqPPZncyiIJHZJHuoktGjRAajcxh5
X-Received: by 2002:a17:907:eac:b0:a6f:5815:f5d9 with SMTP id
 a640c23a62f3a-a6f5815f6f8mr12518166b.52.1718243356240; Wed, 12 Jun 2024
 18:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
In-Reply-To: <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jun 2024 18:49:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
Message-ID: <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 18:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The natural thing to do is to just make the "wait for unlocked" be
> part of the same loop.

Oh, and while I like my approach a lot more than your patch, I do
think that the real issue here is likely that something takes the
d_lock way too much.

One of the ideas behind the reflux was that locking should be an
exceptional thing when something special happens. So things like final
dput() and friends.

What I *think* is going on - judging by your description of how you
triggered this - is that sadly our libfs 'readdir()' thing is pretty
nasty.

It does use d_lock a lot for the cursor handling, and things like
scan_positives() in particular.

I understand *why* it does that, and maybe it's practically unfixable,
but I do think the most likely deeper reason for that "go into slow
mode" is the cursor on the directory causing issues.

Put another way: while I think doing the retry loop will help
benchmarks, it would be lovely if you were to look at that arguably
deeper issue of the 'd_sib' list.

                   Linus

