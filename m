Return-Path: <linux-kernel+bounces-398489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24599BF1DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B422847D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DC8203703;
	Wed,  6 Nov 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAWk/1lE"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9C202F7F;
	Wed,  6 Nov 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907544; cv=none; b=SFPJWcT4M3DvWFOZQL1PedKajpJb/lAZlOK6Qj4ICKf1/IkIxE3dzI/s2gQLZSTskmxelXtqLPDYj8OMQo8ZznnMfo8wpSl72TOXckUBSsuPHxeG6ln28dZkhdgp/VWB9EFg7581xl1Wh8ksQGmby8y9tWxLaJw+8rf4DBl+Ca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907544; c=relaxed/simple;
	bh=R4LCKmgEkbNNWW/TnDfWiVpjQoR3BR95oEgAUKej3R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm/XNiC7R9O4XxdWbDX9JojOg8GZc/cSORlSDB1IWOL1eseuAgdsXatrDocUpJNibc12SjS42Rvr16ymm9PzjYbGbukMlBj1QLZSCq4B179+nNUp2SiMOH1z2Ex8//EKOrogYCkx6vJBjOSQ/X3/r84iSnyrb2xazj5wd8D8Ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAWk/1lE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so673472a91.0;
        Wed, 06 Nov 2024 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730907542; x=1731512342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4LCKmgEkbNNWW/TnDfWiVpjQoR3BR95oEgAUKej3R0=;
        b=dAWk/1lEH27ZKHANOXemj0KDmFpjxuDEoYR2PqJcda9/ByNKO1wuARXVIblgiub+kj
         KLbAAysaxAqGvMO77qNcZNRm+PaUKFb0lk/JymG52Q4Rn0M28MhtvvMVVkYvTyYPCaAP
         gdMWn28b09Sm62oZPXEBvuod+/ZyFImKXR55pOoLLTjYrtoPkDbSvSKy9/u0kziEI/Po
         7GJJTygl+rmTOVFp+DqkfVGHUbAlZfbCY4qBTytnIhNtUqmvqtTDZR/hs7Ki28/VJEkh
         DI00CvO5Oq04wsiXKcEnkoMhFF5BQWKF/d4q5Z/+aLc1S+JCmIk6l6fIPXlBmox9Fc7W
         /6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907542; x=1731512342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4LCKmgEkbNNWW/TnDfWiVpjQoR3BR95oEgAUKej3R0=;
        b=fsAsSLF0Gx/p1L7m/o8JyBCxKhYh/ySygItLznkdHoSRjru6PKP14m2cmjUuEAVg9S
         POMKfa8hCmCvNmbhuyG/dg16xWg6J9fF0hnWhz7xpN41+zorknTHGAOu1K8pnthBA3pe
         QLU50oKVwF6qW+JKv/AOODAyRqrXQM3KSm8/45xicq0DwyVvptnNiSfeYRr0h6fOXmEj
         BU/6gQUFXaa7I2Lyz8d0nXFdzIQplqZGUpk9tJscroUl3fAOpR61L3Qs9s6EXvvheHqu
         HJqVduqk3V3sQOeABHwYWoMlsEt4B7xtdWGc/nm6/jilJkNkoCumSmtkXgD5lu4sU+i5
         hpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJNtAx5s7V4ZkwPtBogecX6v+p17MQyB+50DDW8O8VKY2clgqh1yE8/Zg5AqElXgrmtzsgCu8e/U4dypY=@vger.kernel.org, AJvYcCWz0G4arg+R087EUq8eSSDuAxhbFnzR24JPdcmbWpFzFbDfNjv7vm/KhGgTORmuSQkJrz+YgiW8CcMgqzfKtn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8D5n9OdFk4LOlvCgS/IzkLC6aPjxc8cE5f047z7PJIZbYqTI6
	AhQCNQjEerTqkBKs0rVzAjxradxtDQQB9Sm9T4uQgvRZlsa3sscB9Y2SS2SKNnSZWzcQzGKnhb8
	TFrkeCtEI+25+xELjAobAka2/i6o=
X-Google-Smtp-Source: AGHT+IHlKNQSdtpP+/h/O0VSYCJyXq+JxxxSsENoyLPluTqb41ykxEg2D3CtMq4tmi5JPxo1WHS8rHdsi3yLTVJcEV4=
X-Received: by 2002:a17:90a:cb8b:b0:2d8:be3b:4785 with SMTP id
 98e67ed59e1d1-2e8f11beea7mr19504688a91.6.1730907542495; Wed, 06 Nov 2024
 07:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
 <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com>
 <CAH5fLgjXXE32k2VuC9yGrNG7ib5vo7V+fsvRxWG0ijopK7MDCQ@mail.gmail.com> <CAJ-ks9=b=UEp9KCZ5_dE5yDKWZ1BEfnTkAtS4LiNQ4wzMgdT4A@mail.gmail.com>
In-Reply-To: <CAJ-ks9=b=UEp9KCZ5_dE5yDKWZ1BEfnTkAtS4LiNQ4wzMgdT4A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 6 Nov 2024 16:38:49 +0100
Message-ID: <CANiq72=MmpyquVfi=796v0BAmx6=yuy_gvzeRgUVPhpq8E4rrw@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 2:45=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> In that case, should we reconsider this patch?

Either that [*] or we could at least add a comment explaining it is
not required for drop check purposes but that we have it anyway for
clarity.

Starting to use `may_dangle` is a third option, but I agree we should
avoid it unless we got at least an indication from upstream Rust that
they want to stabilize it soon in that form (and probably only if we
feel an actual need for it, since it is yet another `unsafe` use).

[*] Well, not this patch exactly -- the commit message should be fixed
to explain things properly (and likely the "Fixes" tag removed) and it
should also mention it double-checked the effect on variance and auto
traits.

Cheers,
Miguel

