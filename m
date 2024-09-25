Return-Path: <linux-kernel+bounces-339614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A479867D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5CC281D21
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB714EC77;
	Wed, 25 Sep 2024 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNuVeNgl"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A171534FB
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297401; cv=none; b=FwLoEwn8Dz8oNfDoER73Xsc1ZeGy23r39AMRoOWvbulCY2s6spW/OrEt0IzEbetQ9fap/lPMAPnX6HxstocEdsnrrh3Ny8COCBMhBwgyeM5mTK4UeRKHWG072I8Dhre4DkJVXpZfLCVJD5u3vvvc6icpTIKxsJfto7E3LvYW5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297401; c=relaxed/simple;
	bh=yFyt4ZAfbTza4kgpQ2ByFfmkCT4IPxCH65j3lXLi7cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2aliNTBVAeKI2Jftj4+nDjOEN9Eh0g8lh8KXPhZgPhmk0p5c9H2I1nNvH35CNP/6ISSDZPNiER4IezSU/4XZqNOP6o6jN2gaDbUi6RtcNrHtnN07R/SYZ7nS7CWX3vIzI98MD0JjWP9Vvo2Tm7evMm9iWFMHpvvRbwUBpCS7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNuVeNgl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4582a5b495cso22671cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727297397; x=1727902197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvYmhrylDEbk9n8b2naCO/v3xUja8t5gV4dA2FQkQ7I=;
        b=YNuVeNglKQXaqvVX9rim92ZTpFPMaHtfssyaUtYjUxx3ncQy1+3qEsy85cmE3lyELq
         cAbyd9HNx695GgjNhdVs/THibGad/RmXosE3M4B6o+Tlmq2aXlFToNzXuRcZ/Y5VKSeb
         Pwvx5J1YjfE99ET8RFZ1jlV9FU72rDdj9lL3ipPeBXEjw/NhWWHdijB+f1M2bdyvzRvZ
         IUfdeIXfLn9kX4idLCMJ/rSvhhIB0iFuNUtPgrMfM00cwicsD69PgBFkopQzhSZ3ikZa
         T8PfCUXiKaM1Ga+boEz1YxCg6H81jfDdXePc7hnMkg9Wuvk07KlM3VMQ9/4NKkYWtR5n
         oMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727297397; x=1727902197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvYmhrylDEbk9n8b2naCO/v3xUja8t5gV4dA2FQkQ7I=;
        b=iqX2+9Xuy0lPN3UiNhUUJxkwXN5JK5gnPLtbyuOetyXc7iSet1B7qPwrcyA+IPqd83
         lS9mlytix5zN0qxLfmWHdht6yTj+ckVYtLm6f4KKU4ECRriWrWUUl38BWjjPbx0UMJeX
         xYNLiH7EIfZmBJbTFejKqlMH707ZPpYBRwJCpY6iGKSJMK5uGWqkQIhQcnDskMPYMdEl
         0pHY7HKVnBk+VvVJCezTuWom1l34KIPFvyTsxhrr7pYpNFgLIaLB2ktTTc5g+134dLbO
         iSAlfMTraBhWm4K+uFLgO0swwhdT05iB6UUnmIjDzxUGzsYosN9NM2sy7OAsOrE8TqvN
         J7LA==
X-Forwarded-Encrypted: i=1; AJvYcCW62CNr1Qd+hQi4NKV+1NThP7gDR543c6PtGytcQoPMfzifWH09EdABDNPkJOVWkyzrgr2z2vChz4pdQQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotQNOOGjVmSNI/amNOiG29CoCmNpBo8OayrGcCa4Y6qoe+XgX
	q9GvbMBMA4y2jJ3pHjXRrps5rE2HAmNEBEUunp8+0kyZNVrdI11op/G5ezC/q3EHEPMqRn0T4lw
	D6Hq0rSDR0rL5C2sTSvssu2X4ckhm82Zu5CxC
X-Google-Smtp-Source: AGHT+IGWFq0uUM30Rl9pLsPQ8yT/Z+iLdvuHWHRcOOv7CSHswcGCnvxhsS+E7taeAjlF9bj9AGIbRzczXwTmweEJDk8=
X-Received: by 2002:a05:622a:5b86:b0:456:7d9f:2af8 with SMTP id
 d75a77b69052e-45c96bc1d07mr139391cf.7.1727297396761; Wed, 25 Sep 2024
 13:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817165302.3852499-1-gary@garyguo.net> <CANiq72mGbdKRKuEPbmC7TLOJVXMmpvap8Vinpex-TCtorKaUVw@mail.gmail.com>
In-Reply-To: <CANiq72mGbdKRKuEPbmC7TLOJVXMmpvap8Vinpex-TCtorKaUVw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 25 Sep 2024 20:49:16 +0000
Message-ID: <CABCJKudqAEvLcdqTqyfE2+iW+jeqBpnTGgYJvrZ0by6hGdfevQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: rust: auto generate rust helper exports
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Dirk Behme <dirk.behme@de.bosch.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

On Mon, Aug 19, 2024 at 1:04=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Aug 17, 2024 at 6:54=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
> >
> > This removes the need for explicit exporting all symbols.
> >
> > Generate helper exports similar to what's currently done for Rust
> > crates. These helpers are exclusively called from within Rust code
> > and therefore can be treated similar as other Rust symbols.
> >
> > Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Applied to `rust-next` -- thanks everyone!
>
>     [ Fixed dependency path, reworded slightly, edited comment a bit and
>       rebased on top of the changes made when applying Andreas' patch
>       (e.g. no `README.md` anymore, so moved the edits).  - Miguel ]

I noticed this patch when I was rebasing the modversions series, and
it breaks module versioning for the C helpers because they no longer
export anything. Since helpers.o is not Rust code either, it seems
we'd have to add a special rule to generate modversions just for this
one object file, which doesn't feel ideal.

I ended up reverting this patch for now in my personal test tree [1],
but I'd like to understand if there are benefits in using Rust-style
exports for this C code other than being able to drop a few lines of
exports? The comment added to rust/Makefile says that "In the future,
this may be revisited to reduce the number of exports" which sounds
like this might be a temporary clean-up?

[1] https://github.com/samitolvanen/linux/commits/rustmodversions-v3

Sami

