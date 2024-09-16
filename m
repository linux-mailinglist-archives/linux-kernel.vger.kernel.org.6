Return-Path: <linux-kernel+bounces-330354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F6979D07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749151F21379
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2846B14B07A;
	Mon, 16 Sep 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c78mPFM9"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D398288B1;
	Mon, 16 Sep 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475985; cv=none; b=K/0UxCaejAH9Q/r+cE6iq6/NjuptIl9idYinScrtU3p+Jde5mHTMpBJR+4xXKXll0r4DTg+KDCKPt5UshHB/P4KiMuZQ1F9ga4mirizCqXm/8t55bT/tn51i//KQJYcVVFIrl9AueGgcgYCgq07I41zLIaEcTLhnDPGp/NzCg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475985; c=relaxed/simple;
	bh=r1aiawJAUvBE1ZAeT7ppZmQdx7tHrSaRGOpWfYAWL9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQQdGAy6LU9kYcwaBYMEfM3CF7hyUucdyh3JxI5uOSVUz5BrGySWFl/FxijnPVyBAh0OAFxxbjtR6MpFQnQDxVNUFW8jsrbUrg+gwiVeOoqSU0fvUb8pELnViljw6Qhc3dPKMBTGRB8i6hMt/dvGG9619AdElL2O7Wb2NPbnO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c78mPFM9; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db3e962c2aso101295a12.0;
        Mon, 16 Sep 2024 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726475983; x=1727080783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubkh6TTC0SSzHx8qCL2vYBVaYHXk6OuKdRV5nCiZIw4=;
        b=c78mPFM9jLYpmdMUVszxPL6TEys2JbSFgtw/nmVed1f7RlE23/kiOz+wmcHL//Cy8m
         vz6cmFAuzE0skRqY86up9JiUuOfTZUXWQDSswmrAW5v7WBM8vWZVd90nNzjA+FobROkb
         mK8uwGZAVSU4DmAZmcwiyWb2V5HoZsWLevyixTR1g0hJ+fSG6TiVRroRjSX/hrrcruXr
         xXIfSkv7jOehclWjyoAHVr533dNDd6IBFYjioC+aTGXSv/4KwgVsTrIIBPG0g/qpwk2D
         OBltXlCydY3+sUq+WaFWM3o8KpCrdPFGcP0Au+6t4tCkY+qxa3xa9Hd513e5M1o+ci+a
         QT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726475983; x=1727080783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubkh6TTC0SSzHx8qCL2vYBVaYHXk6OuKdRV5nCiZIw4=;
        b=r+tEK/6swQ/Yk+FDpQ1VB2xQCWCmlJr4iJ1eMimRg4jaX1lEopNv2b0Bbd+kUcUA+G
         v4dAA2fPhuxGpUlY++bzduok4sHfq2eaTrC5iqn0yIRAky87aAm4Sdd+Rv+n//n+dZYY
         on/viZi/4e8OqvdqOOkOvmXdvHF3U7DI95/UytA4+6LoNp3ojV7W+GGY2HokCe+9BZCC
         Emc6ekcK4zJ+qAfTGbrUNcqmzw8Xk3R0EjFq8WlYWOkO3AQhX358LlBaIq+ke1yRP2ZG
         LF7ct4WZjYEfyXyi2usRVu7C4N8ycXR70QMpMQXx3IKcNenTQIP6taZc+zNiD8kyXGj0
         3EsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW4e8eazQ0pFsf5xjC5+k40lEnbJKNT8YExV3WwRZpm2omY0wdggoYqKLsBWQrWGm9n6hbuoFKZQOxcv7qIjY=@vger.kernel.org, AJvYcCVqV0E3h/KfPEV7fFpb8aboSTnt/mHzZ2O01ytEXeaKW2ObJbFgsY8cf3pMQII4Mnc9Q9H59s5VLwvHad9o@vger.kernel.org, AJvYcCX9op1CopeJ/vzM8AsJ1vsGoxSdytctYQIoMzXwJ8B3gvD/08wOuDnIBzXa+gDtdCBnInJ+TBZ20Vho@vger.kernel.org, AJvYcCXCjDzczsAY5CzOzD2R+Nb+iamlLIqvlEN+3c2ZK1qpQfkZ0sfdlJ08j+B3jNMwFujsG0QNbEI0FRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWO50sBp0fqsL5e2Yz8ApdI+bZb+R0tdVGhalCGV5wTAnU/1fv
	2rh/wjXi0TkrZyrAvbHuXQOR/zHX4Dbejkoq30nYOUdZvBRObofUcU9hkYS5BYa8DIbjtCeEhv2
	gSZQXfxzlVa05ZtxMLQDt3F4Y2GI=
X-Google-Smtp-Source: AGHT+IF0jWg/1gtEp2K/kG2nA1SdhPfAODOi8k+DBysvYjHaORRnI+et6X1UBrRFVN0szySihjj1APTsUldJpffBdiY=
X-Received: by 2002:a17:902:e74e:b0:205:861c:5c37 with SMTP id
 d9443c01a7336-2076e370f21mr93895215ad.6.1726475983139; Mon, 16 Sep 2024
 01:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911185931.16971-1-carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240911185931.16971-1-carlos.bilbao.osdev@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Sep 2024 10:39:31 +0200
Message-ID: <CANiq72nVp=xMQHBbKwayD0e8PpysbVz8eegx+meGqqw3y5HTtA@mail.gmail.com>
Subject: Re: [PATCH] kernel-docs: Add new section for Rust learning materials
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, benno.lossin@proton.me, 
	a.hindborg@samsung.com, aliceryhl@google.com, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, bilbao@vt.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 8:59=E2=80=AFPM Carlos Bilbao
<carlos.bilbao.osdev@gmail.com> wrote:
>
> Include a new section in the Index of Further Kernel Documentation with
> resources to learn Rust. Reference it in the Rust index.

Thanks for this, Carlos! It would be nice to mention that this came
out of a session of Kangrejos with suggestions from people in the room
(or who suggested it).

Did you rank/filter them in some way? i.e. my plan was to perhaps make
a poll or something in Zulip and then pick the best ones.

A few extra that got mentioned: https://rust-book.cs.brown.edu
(perhaps could go into the Rust book entry somehow; having said that,
I am not sure if it is being updated, and it is part of an
"experiment"), https://newrustacean.com, the reference,
https://github.com/rust-lang/opsem-team/blob/main/fcps.md...

> +    * Name: **Linux Plumbers (LPC) Rust presentations**

I wonder if listing individual talks may be a bit too much, compared
to other entries in the file that link to the overall resource.
Perhaps LPC should be in a different section as a "global" resource,
perhaps with links to the few latest years' full schedules?

> +    * Name: **The Rustacean Station Podcast**

By the way, are these sorted in any particular way?

Cheers,
Miguel

