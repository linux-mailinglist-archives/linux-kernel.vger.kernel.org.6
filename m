Return-Path: <linux-kernel+bounces-286841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5E951F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62AB28303C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694FC1B86FF;
	Wed, 14 Aug 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3NPgeQE"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4E1B32A2;
	Wed, 14 Aug 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652216; cv=none; b=UINogzajjWDtlhJC0eE+DaCnWUDIqKDE8xM3PMapg+++Tju65j0I1jl5TU0aR7KrAy/eHI+wnoT5LyltJFSJKwO4tOwLni4QGbegmNA+FLjpHu97B0slijpR0DF3bWnzFRIDUCzxf7wpg14XMNhUDjEmjy3p809TEzLfR9B+LsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652216; c=relaxed/simple;
	bh=0wtNhPfsoOWpzkfW9v8ugZFNDz/WZaTEF0+6UcbVk+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idxR1Z8B6viStUEGz3Uy4jyG7GiQ/wy1pdMoeB+gkw95v6v2jf+AIkgW6mUmH1B9IukNtoYu4Mo/PtnOWCy2LVYNF5ONA0AUegmSpLaUbLJSV83elSsYVXEpt/0rCCZbCjKWAYq/SRNECtDUznAcD6GsQCICK01M1tgzLkYYQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3NPgeQE; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f1798eaee6so832511fa.0;
        Wed, 14 Aug 2024 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723652213; x=1724257013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wtNhPfsoOWpzkfW9v8ugZFNDz/WZaTEF0+6UcbVk+s=;
        b=j3NPgeQECWhpOcJ5jmyQBWNW7rjd8bD3pF9XzTcKujQatSJ6JG+W8q0Nxr6BS6Qfqf
         alIGwoTTMHX/00tlv8uo6jqYZ5xnVwZWCVKLt8SUIThU7Rh+LJTbwHm6EsI8eB26O6aA
         yHXxKiezMsAWmoy9CQy/3hXVKnhgtTdFKJsaJM+m3WIYicdpgON1OTnQQ64ucGvuF9pY
         Vg/KnDX83WMLGV4WsJ/H4ydbLO2JxR22WjwbR+N9j4pp25Awfh0UVwY5gZ/6qEu5yiCO
         u3lGO51DPvogWZtAqRTz7Iwzcu5V/trqRBfZ93wwaiUy/eD1T7e6zzr08glNCU9+cejt
         d8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723652213; x=1724257013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wtNhPfsoOWpzkfW9v8ugZFNDz/WZaTEF0+6UcbVk+s=;
        b=Z8+Ga8K35FBb1N7IJaaGjGLdvQMx3Igi2B98Pb1CaLfLUc+KVWsoy0IK9KmnG41cQA
         9TGeZgf4Q4910SnHdjOGENC9qeeHFiCKDBkri58O4SpLwwnfwDITG0BR4meqdlMefsWX
         VZQ3NqKSSTmk+sdHHYX7ko5AAjU2eaNiTeOLoJ4SksCcNIqYUKD6sY6vdwWSOcF9k1cG
         lG5DdSfYo+nSuwpDX2cdHLXTmAfvVZtr+JXXvoPtEk8w9YqCzpOANeKZUh8tmubCjK/l
         lfDrD0efZs6WTazdDdJTwFVOSlClthzu4Cn5EO+stjRx7W6fKUv361O2q7mXVK65XsR6
         bS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPIhbvZCcRruOWIw2FMMhFpZbHdbb/W9CVEgcLt9D0DpfdgwZjDFI62c2B4B0SuwpcFMIsCWnBVSizADiWTKlZOK1tM74tmyq1SUpMk32nsPOcTIg2ZskYoAcDfFogPxrKgKiYwwULA9YgXr4=
X-Gm-Message-State: AOJu0YwpATA0hZWr465zVUvWOf+j6ok/5g3NwK9Ta6Lj8rb5nXKMSQqa
	aJYA3xFC0G0i4AzcQ94lkCNs6hhb5ussqgqTAioPFu32cnlw6DT0Rgb9HRc6DovXyTHjn+PPX3j
	b5dz+46eKohZovu59lmNTccC9qsg=
X-Google-Smtp-Source: AGHT+IGGxFolXAn5sKgoSLwBzNNjf6GekuvINS6ByP+r2PaCJCqaKLNH1bYjBXCYHJ+d2A0ANc+TtQ0RzNBdy9K8P0Q=
X-Received: by 2002:a05:651c:516:b0:2ef:24e8:fd83 with SMTP id
 38308e7fff4ca-2f3aa1f9630mr23202131fa.38.1723652212806; Wed, 14 Aug 2024
 09:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-5-dakr@kernel.org>
 <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com>
 <Zryy04DvEsnxsRCj@pollux> <CAH5fLghsONUtxFPgD6vC139H-Uj5LDju7w5eS0JB+BnDMmfngw@mail.gmail.com>
 <Zry1qwJnPDUtp2Nw@cassiopeiae> <CAH5fLgjNfJyyZygWzeTyrNi8TQNAquufxFxDgJHzq6dan=b9BQ@mail.gmail.com>
 <Zry4iOGtR0nd6lNP@cassiopeiae> <CANiq72nsSOaG=WhGP5GUQ=ygCh23iDQBc0kgjRP3B5MoF0CUjg@mail.gmail.com>
 <ZrzLHu5Ey9vLwNJg@cassiopeiae> <CANiq72=u5Nrz_NW3U3_VqywJkD8pECA07q2pFDd1wjtXOWdkAQ@mail.gmail.com>
In-Reply-To: <CANiq72=u5Nrz_NW3U3_VqywJkD8pECA07q2pFDd1wjtXOWdkAQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Aug 2024 18:16:34 +0200
Message-ID: <CANiq72k-haQ5dnUcNx5h1bE1J6_K=K3X+aqv7qJ2K6nag8izyA@mail.gmail.com>
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, 
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:02=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I checked about `__must_check`, because it would be nice if it is used
> by `bindgen`, and it turns out it already does, but behind
> `--enable-function-attribute-detection` (apparently for performance
> reasons):

I just tried, and the flag seems to work, gives us a bunch of
`#[must_use]`s which are nice, and apparently no other change (in
usual x86_64 config at least).

I don't notice any significant performance difference in our case, so
I will send a quick patch to see if others find an issue with it.

Cheers,
Miguel

