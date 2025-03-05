Return-Path: <linux-kernel+bounces-546633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E87A4FD1D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5DD3A8BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6AD22E017;
	Wed,  5 Mar 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB5FiU+k"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AB1A2397;
	Wed,  5 Mar 2025 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172708; cv=none; b=GF0Fqfdv+apoCFt9Jj8bfKiBzW11uAquWHTYyhodXJMb2NPlMnRPJWKFpB9pJejgNZ+OTqccpYOfun+fQoBQUBJzMrBA2vcWGv1AyQA16bPyLbfveQKpn2mrGubofMQSSlbHIouVpJIGb14oYl5SGk80qxO+2M9d+Bwt12orj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172708; c=relaxed/simple;
	bh=HQ0QTVZ3R5LoqNs//ormBERFF3chfVglnFHba8lkORQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5eXLaFB4Q8PH8le20NOw9FE2ZZIBclgNpMARVEiTOvSQMI8+zWTOIYj+vZ9Jhy4s3aEMdPZzigKe8Tili1auh+llXJx7uKnOieqGfq+20bum5bHHdMmVDrUOXZjOUhaUMsiBs55eD5Bn135dyrTaGKp0fzfLRClxPuAIuMSPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB5FiU+k; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22400301e40so247075ad.1;
        Wed, 05 Mar 2025 03:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741172707; x=1741777507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ0QTVZ3R5LoqNs//ormBERFF3chfVglnFHba8lkORQ=;
        b=QB5FiU+kL9WXGL6jhBFV0ggbMg1qnuKpUuGkGiQiy/0JgXVpLY+VWNqhmnhUahcSmI
         fnfiOYAV9UZAY035nj60hjnv7ikhPFGCYQ4+SA+2e4AGwaq4yWr+BUUkYazWi3rEWjyM
         v0/gOBJ4X0+riCBrL+rk+h/rT2139eWk84oJh9hWRyWoQwzwymb3nRAXjj6N541KMfkh
         ZOSNH2jcFpAFfC9fHgtqJqJQurn+o9tZxZ0w9opYFkFJKClREAgeUnIhEhuw0Mthtf2K
         4fggoOg33EDp/KGi6q3Tmg2HG/xu6wRFARPgGydTW25HtaqEMl6NHiudjl0DGaTH4xCm
         Ynmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741172707; x=1741777507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQ0QTVZ3R5LoqNs//ormBERFF3chfVglnFHba8lkORQ=;
        b=mIc7OcLQ4V6bMSAuWvpZDyJ5A6ZQdMdGaV2Rq9UjvrkAQ7J676x6zZVGB62R5LJO07
         lyd9gjKTrc2x5q1YusHQwGuZ+Zv/B+mX89xFMCSf5i3hO/OQ2icCLU1HJg30jR/uxx6G
         hYM4q0cLRVvQ74yjpt49huUD/s6O+3qGc/3ZUXtDJT2h0GEhwFZmyKybnCDiI11/17m2
         pMxPsKQ12bkOuCa0LSJX+3YSJd+L0SWMJglRjoPLAefK+J23CcF0MB2HSKt84ueXAZoB
         C5RjgFG2/K5vLiOHpd5ZeHON663LxTeGJlEokt5c+XOVjqWbbLGlN1ZI0d5XNlEQqNN0
         SdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoIBhen+LEh5CtzptitYHqCErZH8ls+oLTxrCXl8FyKYsbma+FPpCLcD7bRS1LbBg64itW3lOnRZ8AhlY=@vger.kernel.org, AJvYcCXquViZyvdThTpQ3tnKfGp4ZlV7k7A500uXBu/GGBs02Z/Ezo5EMkzkSaPM7nHTNoLciNg7PEzrNekz2k0vcgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LsinAsWPtqlDBjITMQ75M4EI6EJIAwuCR5W2EydS0w6fpL1c
	p6CuEvoVlSml5QC4Y37imJQhnlwlTwSLIm4FmvKGXyjmrSQsCALWj7X+y4R6vYsU4gHu+Zk8PdM
	IswUMscAYNw4lNwOZQCEr/mTjbBw=
X-Gm-Gg: ASbGncveGByQYdXgTlKLaarY5XSsY+xDId4s5ojsBNq0tfxUT2f70SnoxJH1poX3h/L
	RuUrjkuYYBM1bpEW1szvxuXulDyoMfIJ7d/0loXczePxzlIMAp+0YGOXc+/YlLS8fx0h01tHGfb
	AgPplTYBr8lITFWNBXQ68TJwsU
X-Google-Smtp-Source: AGHT+IEg7PgdT4aEeeQR60HiwXdxh2jox4AxEq3uxwMm8kTNjq49YMJ2i3+iA5hZs9CDFRHyFKVrztP4nTpVP4dB+mo=
X-Received: by 2002:a17:902:e881:b0:21f:1365:8bcf with SMTP id
 d9443c01a7336-223f1d33ae6mr17479845ad.10.1741172706720; Wed, 05 Mar 2025
 03:05:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87tt89gfe4.fsf@kernel.org> <20250304205054.207285-1-trintaeoitogc@gmail.com>
 <CANiq72koDba445gMYtC_VEcFk2+O-Xg2-2y6uMyp7onBy=7rcw@mail.gmail.com>
 <4D_uEoEtgYCzOLuPzhX9Vs7J1uScCFl9I8iUfPXkglvk62R7uBUyCd-_o9rqmINGO1eVIm5gGyfC2_25bhigHQ==@protonmail.internalid>
 <CANiq72kNG7jZf+hZARjyAp-uG=x99CrUKZvJYT_icaF0x0G6iw@mail.gmail.com> <87v7sngbgx.fsf@kernel.org>
In-Reply-To: <87v7sngbgx.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Mar 2025 12:04:54 +0100
X-Gm-Features: AQ5f1JqZf0nDTmEUcfyYnOline9I6JcDBwaHjIR1efP4SRernMDboH64pAgQynE
Message-ID: <CANiq72md_orajH_TREr=ng8Y=o3Xkgw-V5oxbX8vYXOE2UDNaQ@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, 
	ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joe@perches.com, linux-kernel@vger.kernel.org, 
	lukas.bulwahn@gmail.com, ojeda@kernel.org, pbonzini@redhat.com, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:53=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> Right, it needs a bit more tool support than running checkpatch.pl
> needs. Perhaps we could move it from checkpatch.pl to the rustfmt make
> target?

That could perhaps be an option for this case, though not sure if it
applies to all cases, i.e. `checkpatch.pl` also checks things that
only make sense to check in a patch and also things that are not
related to formatting.

Perhaps we want an entirely separate thing in `tools/` eventually, or
even out of the kernel tree, so that it can be easily run as a bot
etc. like in the past.

In any case, landing checks here is fine (as long as Joe et al.
agree), they can be moved or removed later if needed.

Cheers,
Miguel

