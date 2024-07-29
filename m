Return-Path: <linux-kernel+bounces-266370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDFC93FEE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B342F2841C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5251891C4;
	Mon, 29 Jul 2024 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw/f1Xc7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365743152
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284057; cv=none; b=fEexjKWgKSdEIQKIRsLgC1U0fUlgJW0o+JpIJisl/XK+ITqHkq33oS20ZtQUQiT4kSBuV4bdG+DpFADULs7dTJJZB5/vWzz+wsl2byUK2PN9xPrbxvpJQE8NVsCA9aixp3fjqVAHDtQKAH/IwKF3Wk21FDJypABFf81oWHYjRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284057; c=relaxed/simple;
	bh=6qk7HpHLYEwpFQisMPINM615aHGawWFZGy/k2uka1U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsgXGPyFyoVtTWyal/FQGI7ZMkI1Ed2fudLV3qv9KoZxkNUC5HKGw6T5EZyHUGtWHLVdU+v/ZO6Ir8LA+rXm/uDk4oKlroKQhm3XB9cQGJWpsZwQh3M6JMH3tAUXM1IJz1jOeFAN7pJv70e1YXDfnSCyEjnKnAb+1I3I2tSsjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw/f1Xc7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso3145618b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722284056; x=1722888856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qk7HpHLYEwpFQisMPINM615aHGawWFZGy/k2uka1U8=;
        b=Hw/f1Xc70CDcZ3KcoQz9EW+wjE4jdtyCz9cooTk/TQV05GvuTA367YJgu7ZJYxL0Cj
         bgxAigf2Y1dnKicQDkNfZ7b40n6NpmxDm3V8U3mIQXDpaH9Jiop5MmcT6QxGZJaljtYB
         DivSdV+PXyFyA1TKOfKgKb/J5gjyUAv5HY32N/TiPxNKssEVxbww+OuGEJMBqsQdiIZv
         BjcKOMqupqEfVwrRFVowmyhCE/Mf+++ih7n9y2dVzKqCHWU88Js31gDqLlbx5oG6lTDp
         mfbRwpC3+0YP0bsgvGdZsZBlEpo1uivszMjolhGwFeP85SNYkUlqwG1pTj4I8GflGf4k
         wr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722284056; x=1722888856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qk7HpHLYEwpFQisMPINM615aHGawWFZGy/k2uka1U8=;
        b=nONZg8IIdjXk7X4fdMutG8N4DVvDx0AHiC8qJUNbRSWuQJOklra3sOCZNso3ObfIR8
         PtiGbcRJq+ObpExY9VTg4TbD0F/9hiQwYfSi+AObuRfe+jnPtSDHMugtgkwuh0gHvE32
         Eb2Eoz6VsEHTlxraeK0xXVYs1hSl/+RyG0US3ME6NhKuMkqefcseIFjOb5gbE9i1xKSZ
         at9+97hIHTS/iuBZij94zxzCPXdbgRgOIpGMuBC3C55dEs2GFXCJuNgmOmQVAd1K93na
         m/MyDA94ip3zIOus5K9HB6UKH02rbdNmEeGcFwSqhqrcP7KlXphcSC7gi5m1zUgD3Eu7
         evpA==
X-Forwarded-Encrypted: i=1; AJvYcCVSxmQyKHtbQPUjCcqljB7c+0zerjqV2cRwx0mX56tpuOFsWGH5E9gaH+4GdC0GrR93Zbll+obbppMF7rpcA3qKONsjHt6U+FemQoFm
X-Gm-Message-State: AOJu0YwUOShvDJhfyjh/HUC9Tyv1s00Ug6iFcdRg8TRFgxqwmPjXHdvv
	YO1D1MpU294rt4StHEZj2881jKzBQpwVV4PmWnS5i/XjXK/O5rBup/BV4JXUn9/n9A22fVdzOmd
	WG0/mAiT6XWFlCqwpVa+7GXlX2Ks=
X-Google-Smtp-Source: AGHT+IF1NSOQXcTtDLn17s4oBxIGTzFnq3W2Jf9YK/PPitYbhT2D0ah5RqbVUMt/rquJYM17X6DDvmsmxqf4MKKxwKM=
X-Received: by 2002:a05:6a21:9986:b0:1c4:244c:ebc2 with SMTP id
 adf61e73a8af0-1c4a1324e22mr10250575637.30.1722284055679; Mon, 29 Jul 2024
 13:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729-clang-format-for-each-macro-update-v1-1-9c554ecfec3e@gmail.com>
In-Reply-To: <20240729-clang-format-for-each-macro-update-v1-1-9c554ecfec3e@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Jul 2024 22:14:02 +0200
Message-ID: <CANiq72kFpS5BE7Ea8=Z6SUi_Y2RAt5wsssHyqL3ocgR1UOHJMg@mail.gmail.com>
Subject: Re: [PATCH] clang-format: Update with v6.11-rc1's `for_each` macro list
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Mon, Jul 29, 2024 at 9:56=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Note that commit 4792f9dd1293 ("clang-format: Update with the latest
> for_each macro list") added the macro `displayid_iter_for_each`, which
> is not part of include/ and tools/ (it is defined in
> drivers/gpu/drm/drm_displayid_internal.h), and the shell fragment used
> to update the list will drop it. In order to keep the macro on the list,
> manual intervention will always be required.

Thanks for the patch!

That macro was inside `include/` back then, so now it should be
removed from the list.

Of course, if we want to include internal headers, that is also an
option to be discussed, but we should be consistent either way.

Cheers,
Miguel

