Return-Path: <linux-kernel+bounces-392594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3039B95F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346271F21D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E461CB512;
	Fri,  1 Nov 2024 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EpviSNub"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198141B4F30
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480217; cv=none; b=aCxQUI0/GytTboXlKTH1yKKp9JfWJt5w/a7X+FQCFDlXAID8/rP1TVR6xNxdgBFCB7Fkyur6kxd5GrUxgLOgs3V2RqozSUvtMNg33gw2Vvz2vmBd3snxn+eluB8sc+tLnvJJ1IBQq1jNz+6Ski79MErhyZmmlybzQsoZ0SkxBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480217; c=relaxed/simple;
	bh=i8O+uZUxJvitzxO+GEB6MrzAKW3i24r0zpb4JuO31xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoIroccM8KsTv2CugFmFZhH894maIXVjUKg8LXQCLhkYfWleGTfMVI/+IN1W1hGrJyKPb9c7+PWcrf2w9KHz5OjyhgQG/doJ/hwYR560OkJnFwV2nVxCXGnbIBX6jTfcWOmyNW/n99J1RsOc64GXK8D0VdKeGql+GFFZfluspNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EpviSNub; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ea656c60a4so12371717b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730480213; x=1731085013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxE7WaVgo5r0HZcP1X6U835BE06QJIdzvrF7o7xI5VI=;
        b=EpviSNubGNAacQ1ss6AYuqTu84mCCgR2VEJE7cJsJ5UcYmZAQfAjuBKoZJEN3r4I9r
         sPxsc2HO6UnhwNtgK4On3rKPVtUH0lRN3lkYynYq9ZuuNpG2Ei7ubTVtdt9j1RpfGtgr
         sBbxHftqiztPU7vVFex+Rg8t7vuGNZ8aJJKuvLCDsBtMZddInHklArxkag9bqoON+UVP
         VsdWi2S+6n4ZQh+DeMUW7bxfti8vNuGnrb2wmmm+vOeeIi6ErzYeYFSp8TY/SDtArhiv
         28KN+L0/886ZEplR5baj+YOa0kvrrjhIQRXEJ2m1dvtxRpoXTPq3E1plP4lvTSitSsX9
         YoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480213; x=1731085013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxE7WaVgo5r0HZcP1X6U835BE06QJIdzvrF7o7xI5VI=;
        b=nrZ+/zW2kftjG8keh3Kll0ixro3zDvwNwkaDTf1phf9adHLoFyetdQqYHyJmA7fcxU
         tyLhPVNVh4vKbUcyb95/uyTe9tjNK84DGHj4rJmk/SOFll5Q24AjRZPCO5XjRxXsP0ck
         GZ6J06YFP4GaSOVL4u9Zrbs7RJixKyViNEIXCxXKRL4bZbYQ5XEJAOPb7fbWElz8lHU0
         +x3yTMwmkZ52dChVFxELK40y50Ho6cmUptp0z3NhrpP/H0zJ2amR2cTWieYmheyEvDsv
         z5cLVc2v9Jk+zEHWms6aNSeuuKYoB72xnXmAi3K4byeTAyX4Qy2wzu/JxiTxw71Q+c5u
         InXw==
X-Forwarded-Encrypted: i=1; AJvYcCWmQwFX1LLhEMwAiW5Qvo4HVF3cf29h0Gj6hWRlHnEkOk9g2eyWpZSwsAi13s7U+WjpKffVpchS/aWr6vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7lbZz7v9tdQ418MgPeBJ1/twxDmZKcYG8kCkpUJRdp/1QLe+
	fszGVClvY8p8qu6c5F1xPvHt5HIP1Gyw0smA7awR8VgJKMxVx4chHrCd7agt5DdVwhakh6LYl4P
	b0V6PksRKc/6amu2Ucnp4lKSn+XKJbjjwxKITTAeRMrNI6ZU=
X-Google-Smtp-Source: AGHT+IFrUTWzgyjlHFLv35YIhawUguqiFZlN8JkVX36bMb7nh64mC/bvCf2Gq6Oq2P3WorBR5lRH5khSJFZMf6kJNg8=
X-Received: by 2002:a05:690c:1e:b0:6e7:e76e:5852 with SMTP id
 00721157ae682-6ea3b96aaa6mr155834947b3.32.1730480213140; Fri, 01 Nov 2024
 09:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
 <20241101095620.2526421-1-aliceryhl@google.com>
In-Reply-To: <20241101095620.2526421-1-aliceryhl@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Nov 2024 12:56:42 -0400
Message-ID: <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
Subject: Re: [PATCH] rust: lsm: replace context+len with lsm_context
To: Alice Ryhl <aliceryhl@google.com>
Cc: naresh.kamboju@linaro.org, casey@schaufler-ca.com, 
	anders.roxell@linaro.org, arnd@arndb.de, brauner@kernel.org, 
	dan.carpenter@linaro.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, ojeda@kernel.org, regressions@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	lkft@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 5:56=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> This brings the Rust SecurityCtx abstraction [1] up to date with the new
> API where context+len is replaced with an lsm_context [2] struct.
>
> Link: https://lore.kernel.org/r/20240915-alice-file-v10-5-88484f7a3dcf@go=
ogle.com [1]
> Link: https://lore.kernel.org/r/20241023212158.18718-3-casey@schaufler-ca=
.com [2]
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/r/CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEz=
JazDsdk9o5zw@mail.gmail.com
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers/security.c |  8 ++++----
>  rust/kernel/security.rs | 38 +++++++++++++++++---------------------
>  2 files changed, 21 insertions(+), 25 deletions(-)

Thanks Alice.  Would you like me to pull this in via the LSM tree with
the associated LSM changes, or would you prefer to do this some other
way?

I'm going to merge this into lsm/dev for now so that we fix the issue
in linux-next, but I'm happy to drop it or do something else, let me
know.

--=20
paul-moore.com

