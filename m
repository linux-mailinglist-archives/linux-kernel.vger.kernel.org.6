Return-Path: <linux-kernel+bounces-539449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E86A4A464
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81C918983CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF361CAA74;
	Fri, 28 Feb 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyNAhA/r"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860123CB;
	Fri, 28 Feb 2025 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775725; cv=none; b=LGO2v1EaaXSdOPQuioxPKAcTjIXu2OkoIJtRpkpjb7ya+crf7qiK0EhliQTnA9ekWxpIrE5eAXWMcHxEFa1mzVt7N71zATqNf2KzCVCJ6ccF/UM4uVjv2nKmiM8jKRsRH2g2v87e+8JGtcMz5ATH0iKwadTxKaKJHYMfj9Mz3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775725; c=relaxed/simple;
	bh=xLRRhv95p6chtg6mKNSAQ7vk3lJx6EFuiG6hypbyzI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ms+477zu9WWc60xj+nO7liX21KF915PEwER+1emfJBKFwq/fdK9TXXWQ2PbRkI9xkKS4odr5lgX7NDZx32ZG7lxN3vJRW71z7uUdUJQhLIj65lqwMG3b7JQrjwrYSp0p11AiCWKZuDb4NbyBUqls7XNeBFDjuJvhx0AOIQvEDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyNAhA/r; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307c13298eeso30595221fa.0;
        Fri, 28 Feb 2025 12:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740775722; x=1741380522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLRRhv95p6chtg6mKNSAQ7vk3lJx6EFuiG6hypbyzI8=;
        b=iyNAhA/rJt/sUnNy9N2pcVWGjgCfbwxFfM3bK03JbhLs3sdXzVzF84HAMPD8T3RWj3
         ynboEWfMravVsyCJA4+eZ2JBqxHvvjHHsXPsLZo1s1IyOykO9bl8VRdiALzMwBhe50JW
         ky1on3M3s4dGlJRSqjAZnk5uW+gyG30zRG0I+nGthFt7zMangbwt5Fuyxp1ODtFEszD0
         cz6WmpGk339m7H5eaZVNZMieeIVG4SfkWHTH6C+jaX3s/sDIhnOBCa6r9vHmldaLmxGr
         SERNmyoyJPSE3cJn3gUjtitLG2QG6NcQCY9ke2qVel8tcPeL4qmhg+axpjPShBt8PEvz
         1Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740775722; x=1741380522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLRRhv95p6chtg6mKNSAQ7vk3lJx6EFuiG6hypbyzI8=;
        b=rwoYUnKdIVz9Hv2h5p95tceD07TLSMd3AeVtgRquv2gicqlBGY1cQVQ8sHfHI1vwNz
         Uz7pKntz8d7bbMMPpupL/wi2VWEcSyEleq6Rq7swcqVvlvaBhK5+atmUIT/n27QPGS/z
         npADIY8II+VbZbJRNW5sSaIwiDZHxyKG7WGUuJcNwEsy58gmj3V59SCu+HWSiYxhHhdg
         U4zGlxkbClU9dPCL5xDwBu0rs5Xdukv1LeJnLqlA/Uj1lpwkZE/nizr2fLEFR1UI6z3L
         BIThiWiSRLrTZ6vk768Wa+GJEbzPLJZZL+ea1H3Bqg34o+QMkqU6p4D0yHvRPxbLVRWG
         efKg==
X-Forwarded-Encrypted: i=1; AJvYcCWSH9J1jAqEFhL7KVpg480at4t0sW2aKbeOMdhn8c8CU+X8XBKDBgslaBKZNrlUJZYNAXYpR7UTM0Q1ubg=@vger.kernel.org, AJvYcCWvmX3tTzyGcQt1obQ9Ev2X8wNnwJN7CltMTnmVNDddzlF5/GvCi5nXTTH6wOj7vnpGONkGj66AzeYdnGIiS1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdhQ/wLNpvCBFwYpFPY+ASQ2WOm/qE+svbpMBkEpGBpwmKUWi
	EP1PbnqG+EKpwuhAu84SdM6AXj0eaLtBGO/+wuN9KSsoWukneE3RDpP1fFTKEUJBWTZTL/qhU3M
	la5ygL5xpUrshhDg91GdJGMiua94=
X-Gm-Gg: ASbGnctOjuElWQOx9N3rMGvzMirSDmW1oT8oDSuJy3KLuN0X0GcFAGxBr1dlMsb9UdU
	aF05tYcw/6dMTxfSwoF66mWf8Nqh1qhvvyeDpU/93MDbkJDP7xNtBo7QIHBiRupyCzZGqqe29Ru
	P7r8taE2lMRgfOAXv/G3RDNQTHIZs=
X-Google-Smtp-Source: AGHT+IH6rfW03h505pJtYaLq3LigS+x8FdWPrdV1OCfRQ6sP/1BmgFjRZAeBYZ80pjuf4xT7C7/qA3qLzMgCCDpjeVw=
X-Received: by 2002:a2e:9c94:0:b0:30b:a4f6:bb3f with SMTP id
 38308e7fff4ca-30ba4f6bfe5mr393141fa.16.1740775721670; Fri, 28 Feb 2025
 12:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de> <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de> <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
 <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de> <CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
 <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de> <rps5yviwyghhalaqmib3seqj62efzweixiqwb5wglzor4gk75n@oxki5lhsvhrf>
 <20250227221801.63371d19@pumpkin> <smghtqj4gnlo7dxo4t6u74c25e2qukhogsi5fysddputbuwbmg@lwuh2nipypqf>
In-Reply-To: <smghtqj4gnlo7dxo4t6u74c25e2qukhogsi5fysddputbuwbmg@lwuh2nipypqf>
From: Ventura Jack <venturajack85@gmail.com>
Date: Fri, 28 Feb 2025 13:48:27 -0700
X-Gm-Features: AQ5f1JqwFMqYXZDw3MuX3Lz0Q8VpEgT8dOkgwIyBShWuyye0GUdMw3PgkeyZhBI
Message-ID: <CAFJgqgRA3xqt6kBZtsZm11nkg7L=cqJtLovORsvq2FAofZJ0Uw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: David Laight <david.laight.linux@gmail.com>, Ralf Jung <post@ralfj.de>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, 
	torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com, 
	ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 4:18=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
>
> Those were big breaks.
>
> In rust there's only ever little, teeny tiny breaks to address soundness
> issues, and they've been pretty small and localized.
>
> If it did ever came up the kernel would be patched to fix in advance
> whatever behaviour the compiler is being changed to fix (and that'd get
> backported to stable trees as well, if necessary).
>
> It's not likely to ever come up since we're not using stdlib, and they
> won't want to break behaviour for us if at all possible.

A minor correction as I understand it; Rust is also allowed
to break for type inference changes, as was the case with the
time crate breakage, according to its backwards compatibility
guarantees. Though that hopefully rarely causes as big
problems as it did with the time crate breakage.

Best, VJ.

