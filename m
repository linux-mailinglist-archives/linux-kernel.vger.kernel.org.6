Return-Path: <linux-kernel+bounces-387505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7729B5210
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E921F24341
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A844020606D;
	Tue, 29 Oct 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCPib8Aw"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571A205ADF;
	Tue, 29 Oct 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227717; cv=none; b=ZykpqiGIuAKcIn5OHgf/gpm/duAynXZS6o9sloWsJFlmdAam0f6CJK8kDa6pHvGnuZVEO8h+TWfCOmEa0IzeYP1vDJNfp+OWUFYyWYP8kvHfvNl34eZMYMmgDVUIcMhIWftarb/Nf4RO1MGu0E3oGctGGRezfX0bA/a4UdJklEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227717; c=relaxed/simple;
	bh=5WnX6mec9o85P35lihHwoMy/zr9nqgBrCUWkxtOD2No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwF8i9sfwYUMZfOpnd4/og/EoW5xDabAZ8KSxbbCPkbCcyOIBJupXq+2NrycTYwoMrwnuqxgaUF6RYZtnZMTbiukMQhJHwNZ5V7prgEGUjgQ7Km7H75Nb3ujUEYElKGYFn2P4j39BwMuLKVWNiOegfVPsm/pOpjXORKSznOJUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCPib8Aw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2b71fd16fso867793a91.3;
        Tue, 29 Oct 2024 11:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730227714; x=1730832514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCRE+6EZ/yw1XNuf7LsU8HLd7SdSlt1GHV/fpsit1T8=;
        b=RCPib8AwO45rMYqI59wXGx+qZ76q5laqOITbRlApyNEeGAUoLogjCgGmfN9V4aIg96
         wbN2aWMS/YLpjVfZLoKGRMTXCq+dMJF1Nwron0YavprKW+vHedToDZd2UYv6sBw0XpOw
         9QLD2bikNXetnGCrK3oMFp8LsbQs+NgzAF9PpITxf/iDpgUmiAbwXicPEdhAwgpI+Cu7
         2qMuaaH+Mw7g7DjbCfPmcxL7zOWOHRtDWQc7ifEu0cTvDTpzUC4yM2xf1JLbBPhQrcF5
         4XSXyFryYfDsdhkVy5CH159YtEVYpzh3ciRAP1mW+mT3lK9ZQqRvtnoPlTTz4+yWwpQs
         fCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730227714; x=1730832514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCRE+6EZ/yw1XNuf7LsU8HLd7SdSlt1GHV/fpsit1T8=;
        b=XJ5RV2cAPlN23Wkk1tLa5zw+/DkQi7Kr1fd+1Omt59N5h8P4K0+H77myibnR8vKmzd
         lCgZ5ip0T1X0Skn54RFUXy3pvjqvastFqbCHMC4NZbSkFoWV4eLvXmWlI219AnnQYKhD
         6RSMdnJvYISo4WAhzPmT3D/1Ekj1Qmlo9TWWrdrEWB/+vmvJmXNQagj2YYlddYP0oRx5
         6Tth40FJEr4bHnSYbGx0orhiRb/mxnHl420bcyty4Nc8kQ0t9FUe6md3+pLZKeBrinwc
         rUHMOR3FcGM88T62MlyuSrDc0J9gQiCUPUb2GjUEGdHDCrm8ETXOY/4rihaZ4LJVAGsY
         IjHA==
X-Forwarded-Encrypted: i=1; AJvYcCUr0AYMZiaTLFAKonc0uGFpTjaarwCvdC79ipU/XIPFubKibYJTHpFYKJyAYgw/GH6Hndq4qIu9UKW80mw=@vger.kernel.org, AJvYcCWz+fGDxcUHDKPITtdNRf0UooCLhJa7LB+ysq3XV3pCEs7bv9Z/ysy5cfg05BKotSn4WnwPFWgbWuu5Vnny1ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy8YzHPU1Nl/nKh/5Gc5tiLdqupo8waSNdyggS4pBlx0KoV0v8
	mUySFrSR1e1HefKEZjbGBPGvVcE09v85XiqgKX2CSMhR3BtTdY/UZYkEe9/oJBHugGWKPqjAweQ
	u+/IWkKbdfaNSxuKyINhVA1lJKCM=
X-Google-Smtp-Source: AGHT+IG2CQMkHrmxNtRfFEVPwh41ZlDTCRnQWP3Ar3wgBdllVXYr99MB7lqUQ2gQYyQcruioOgvW5dVlUkp/p8WXb/I=
X-Received: by 2002:a17:90b:ec9:b0:2e2:e860:f69d with SMTP id
 98e67ed59e1d1-2e8f11c0f0fmr6059857a91.7.1730227714615; Tue, 29 Oct 2024
 11:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023-static-mutex-v6-1-d7efdadcc84f@google.com> <Zx_OoCRrA_WTay_O@Boquns-Mac-mini.local>
In-Reply-To: <Zx_OoCRrA_WTay_O@Boquns-Mac-mini.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Oct 2024 19:48:21 +0100
Message-ID: <CANiq72mb9X0LiDtDe9ptbqm3Ls527Xp+szX7px+Zw6OP8-aefQ@mail.gmail.com>
Subject: Re: [PATCH v6] rust: add global lock support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 6:49=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>
> In addition, I've also queued it in my lockdep-for-tip branch:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/l=
og/?h=3Dlockdep-for-tip
>
> as I want to help route Rust lock-related patches into tip, so this is
> a practice round for me ;-)
>
> Miguel, feel free to take it via rust-next with my Reviewed-by, I will
> drop it from my branch once if I see it shows up in v6.13-rc1.

No, no, it is great if you can take them :)

By "if I see it shows up in v6.13-rc1", do you mean your branch is not
meant for v6.13?

Couple of things I noticed that I would normally double-check/fix in
place: the "// SAFETY: called exactly once" comment could be
formatted, and I think the "Link:" tag should be before your SoB
(well, at least b4 does that, which makes sense since you added it,
but I have seen commits done differently too).

Thanks!

Cheers,
Miguel

