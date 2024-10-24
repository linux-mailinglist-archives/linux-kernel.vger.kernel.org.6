Return-Path: <linux-kernel+bounces-380191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDB29AE9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B391F22B28
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF841EF096;
	Thu, 24 Oct 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlDHjphZ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3601EB9E9;
	Thu, 24 Oct 2024 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782694; cv=none; b=ANm+yPdLeAWjeAncptHMbD4zDN25AbYZwYua1ZUmhdxNl7uWHNWYbjrWOEAs43ZY0DTrKMUaArBwMiPNa6Ruo6/Ezu90X87VVKDVJ/TVwzRE90Cj6X8Wm0RqBIoX+MM4GmgzPq8eZ7rDimiivVjRsbrGBu7E7HDcxHypgMOAVks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782694; c=relaxed/simple;
	bh=ChJjjmUOkenqb3cpEHOeJkT4zO1OgvJJ7sIw5ZfqDDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAGo9KFz1NIiHMjsyZaKlpZWSWAAqX6UZor/fVOgOdEsMnJ078LdbA8/UGer46+SQQxXcCePMK1LmRsTEiyFvOtvQqesPHXdXCr+7PsK/dWlvI2tACS+GAXdWOlqMAWF7lRsgK2tJXDCRK42Ul2W3LWu/AsyaxVSa/ruu9m0Cn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlDHjphZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e56750bb13so155420a91.2;
        Thu, 24 Oct 2024 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729782692; x=1730387492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChJjjmUOkenqb3cpEHOeJkT4zO1OgvJJ7sIw5ZfqDDI=;
        b=LlDHjphZav+VmATjAVdE5B8r4Cgk65SK5rKl/z6Am2mCotAgX/4GPGCARqshDPbZQf
         fOWb/RIveSCIzZkUV/a2JlkOWniSMxiJtODq7AWF/mLL4slaQEYgMxZUQoAf3ktXv6ei
         +QNN1bdCaPXgyyplUNZaMYZ0hB4moOtRsdQ2DogWqvq00K0vfTBNrDGIfrgXtLCo1fek
         AfCyON4bXRuvJ710Q0O49/rNAyd8ZOxP36c8IrfVuSdJDNCWBGKgURm6z+8hbcVugQZ9
         5XyXM5EGWOQ9x4IHdcYhNvhPeJv3EAYioEQ7LNzRjHqih1pwMwZS47dLjyHiLd1KQOHF
         GR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782692; x=1730387492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChJjjmUOkenqb3cpEHOeJkT4zO1OgvJJ7sIw5ZfqDDI=;
        b=JqM1jTOvszeP7PGQFh04s6BNal5UP5VuSOrrBYGcIqh3Omvs4oPkDVl4dibK1BujLD
         6vcy3HUGKcdgdEaP2iGzoPcAdYnhgEHZdSRp5zVBRS66JEnRaOG6il6mEz1C371e4D8R
         GbCTKa++M3L5x5i17jrYEU7gaxewlWqgGxZxggj9Th7JAyj1372CJJbV4F6feRHlPdFz
         rU2HxmKYqqJRahha7cBSjfzRxCJt76RZobgQPjskg/ZS3rYKM7EiCNKeqtL1hprDsuJA
         rgPM8xpDDLX2hxSRP6SN8GZlWkq5QQ3FyawpYbvt90PPSk7wsSjrV/o8IyLn6IY7PlFX
         0ZdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvsvvvuWpkK5K144Y55/E8QjGQ8/Eqr0G/M29U78H0i7uiUOeqM6BkddEgqktg1bKRjTEOvSjzmSzvCn4=@vger.kernel.org, AJvYcCXcifseQEvNNVnF4maKRi2ddt3fFEO678wWVsGgnQa8h2/t38LhdKuf0nBNzFts6uU9ODURfaxv4RW6wJZRH6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFG8LCWZI72G4ka4hBMGnF+K1WWay11Mg1RwbxIVRlRbcop60s
	k9jOX8ev0IyeLw11waJx0qg79Ri6JRjEbaZQkuoe7PxcuowRhBNY+pI31iR/Uuvo+pe89ZkqXRM
	DAa6XHvFBHbCnAYtiv9ngTpT8L/w=
X-Google-Smtp-Source: AGHT+IF58Lb/dCYGWTo4rXd+PQkoaOUoDK0Ly4TNLuDftx0txVM4t5YeKUH7ny/k0PCRtT2LigDRM2J5epTSAEwGc6o=
X-Received: by 2002:a17:90a:6286:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e76b5e039bmr3321192a91.3.1729782691837; Thu, 24 Oct 2024
 08:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com>
 <9A3613EA-3901-4C44-A3C3-7A6B7DB49CDB@collabora.com>
In-Reply-To: <9A3613EA-3901-4C44-A3C3-7A6B7DB49CDB@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 24 Oct 2024 17:11:19 +0200
Message-ID: <CANiq72=2NgfMhzFhSJAY+e4dkoPdrqjgOv=DPiHMZWbtM08tGQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: kernel: add support for bits/genmask macros
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 5:07=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Sorry, I switched to b4 yesterday and I am still getting used to the work=
flow with it.

No worries at all!

> This should read =E2=80=9CChanges from v1=E2=80=9D

It should also go below the `---` line (i.e. currently the SoB would
be dropped).

Thanks!

Cheers,
Miguel

