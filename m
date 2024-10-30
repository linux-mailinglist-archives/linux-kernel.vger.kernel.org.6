Return-Path: <linux-kernel+bounces-389028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C39B67B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D1F1F214C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60A3218306;
	Wed, 30 Oct 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRc36dRY"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58A2141A3;
	Wed, 30 Oct 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301722; cv=none; b=jOY5xzJ5lIXNqU1FnR8qLHQ1YoBjw+mCsAefoj75Eze1Dv0ShnpnE+QTLMwiaJmr1RLgHNcN9D+XWyk+hr4obKz2J5TvfYNGO88tIZU+tD1CibNDL/Q1RcgBQEXu7Ijo+1WOBZDrlLty3tEfBqkLhyIHGT6Prh8N4EXPl+AFuy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301722; c=relaxed/simple;
	bh=JydzLZhqjXRCq7g2UKg3bYrwl1nkaOaLwkN61TI7YMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmlrIVZ2yxhyoQVzGtCzpAQA4aioL5I/ec/WW4aXG+I1fDHRUp0tI9dpFLm4mvmDCyvyQEhP3tUcO5adFKkwVL1+iWzJJlvuSvRM+2NiZ99BWttsdbx/V9mAGjJZ5JjyMGet12C5dWXicV3aLwGE2LXQiX9oOBBHNvKdwGQ/LQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRc36dRY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso1294621a91.1;
        Wed, 30 Oct 2024 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730301719; x=1730906519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JydzLZhqjXRCq7g2UKg3bYrwl1nkaOaLwkN61TI7YMw=;
        b=KRc36dRY64LfXkxEev++b6zOIoDHb+pXIfZdYOLCF8qxZDKcClCvfAC+QLLnh/iMF4
         t2kVrXWRawf1LD9kHUxHnHP2XAfzhZDuZI1UTRo+aTjNuvPT6TVh8ax1//gzt0xdGMkY
         uXHkd2zHlGyUPa8F+Z5ZrmbZhT0lzerLHIZNYnXZJuL3Gcxeczeq8LK7fsRFNP/NvBS9
         7d569D/KuTGRWhI1DnZM105swFDXNi6W/1c6MSa8jDTu3XUv+HhKFPEmPBwAd9bLmUrU
         mMio2tLipAYF505LZSPw7qc/mZXPaWbwK6NMSwRiRQwQBn+xSCaCu1r5K7rBJ5yyfEtB
         JAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301719; x=1730906519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JydzLZhqjXRCq7g2UKg3bYrwl1nkaOaLwkN61TI7YMw=;
        b=msSd43ExsEf/UZCEie1JU+zzblDPDzLhdUNAdY1V+ZQb/H/6RiWxNHsTULWSn9/knI
         D6q4GUlF3D8IZfgokClNa20r1EBblWLZHvbZ4/QmxeP4sHJu6oS553GZwHKekuSqpJ84
         Y+FLddfFP7DktgngOL0X0897S0EgsYdbb6R+mAs+mu1kIPlf+PERFrMELaT/wLtkmReF
         9GwbjxABNZnjZtXmk2vKuEE/5MRfHKpCdi0X8CNiicF2jq0QCPOSfFHklAV6Yrww+Gce
         JNoUpvQ1ICKjgT+rdaWurslo1xaK+Jm/zLxFffeQ0cLFXE2CWG5qAhV9UBcCXIX780Nf
         GP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAmpS6rCMKH2NWeuV8F5Ms0MtsmX0/HQuZBfWTTrjHyM0BCwGYBA33TpVhYePjEiXlJKphYJvvEtCc+pdsaLg=@vger.kernel.org, AJvYcCW5jpgtsMB4rbCViKCI6x9bAOLCNNE2eycNZvPvVU3Ah8Eblz1eJ6kZXNiXWeNWDGzjDvIX3D5Fcki3bxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGChl2zvb2EBgWVzVXoeosoveWdci3gfDcdNaQGoqrOVoBwfv+
	EtuxxHbzxd3Tf4fIZbxInP5oOh6MmX+UPMjwMJ8VQdeIBAXUCWvgP+0mKcX0/YHbIMOsTOIYhEd
	bTyVFtPLZjH8uuU/0PEsmgrROzHI=
X-Google-Smtp-Source: AGHT+IE7jQ9WRHLpkOeR/LklnujY7N+PY2iPiiVk3DpZpglLmToxZygbsk3WDUR68evZ2V+qIqnlo6o+Rw77PFprrVE=
X-Received: by 2002:a17:90b:3b48:b0:2e2:c423:8e16 with SMTP id
 98e67ed59e1d1-2e8f0f4ccbdmr7999916a91.1.1730301719568; Wed, 30 Oct 2024
 08:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-bindgen-libclang-warn-v1-1-3a7ba9fedcfe@google.com> <CAJ-ks9=8Bo94Fg_By956ce8X0r-6xBWGO_Ka+rCQ2h3tF2nkRA@mail.gmail.com>
In-Reply-To: <CAJ-ks9=8Bo94Fg_By956ce8X0r-6xBWGO_Ka+rCQ2h3tF2nkRA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Oct 2024 16:21:47 +0100
Message-ID: <CANiq72=2ALWH-TeHH+=YEmkWw9CEyNUp5EZoBFU=xvqewheeWA@mail.gmail.com>
Subject: Re: [PATCH] rust: warn when using libclang >=19.1 with bindgen <0.70
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:14=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Might be time to rename this script - in another patch of course.

Why?

Cheers,
Miguel

