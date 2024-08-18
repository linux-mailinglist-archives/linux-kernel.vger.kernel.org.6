Return-Path: <linux-kernel+bounces-291225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1B6955F55
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498231C2031E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 21:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BFF15535B;
	Sun, 18 Aug 2024 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrbrK6I1"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED130171AA;
	Sun, 18 Aug 2024 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724016729; cv=none; b=HTNMfDYb18ejgKiM5SfWCtKbu2WJzdUHo29U0zoaSaEJmzNgUjNGzC0BPxA+7WC9IPmWd7eemBQqJnFLdTsgAR6Ams7okYNsNhbtwg+DuHt3Wu2nPblvA8LDM4GY6mUsZwm7bxCeV2CWWOOA89kMwmpgnSuXxWkoqzsXVMPHlM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724016729; c=relaxed/simple;
	bh=IoWx7i0vCeulomfayb/N9YZ9QO6STgMm6TMDi3Em86Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gy1Y6kVYqmPe7fKCpjlQamwSmW/m9h5QNHfhC/BkWns3tbrwzDd5VyT5G2fKzoDCWWj2h+NSqCKCOHScxMwT8aa59YKw0YMDLLr5TMfOOgrfNujosOn0aZ4N1i6iT2UFyGR+5mevfC/GfhjqvL9YQDSM8G5U/rW7Q3bPh/L6ZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrbrK6I1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so2480390a91.3;
        Sun, 18 Aug 2024 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724016727; x=1724621527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoWx7i0vCeulomfayb/N9YZ9QO6STgMm6TMDi3Em86Y=;
        b=SrbrK6I1lR/zm1+Z3pqJaXMlSWH+XCJx5i3B4NbI1AI6d6MEHDtHTLSu7Ma6qaCJbB
         jG75vxF+knjpY66TN99co2L10zJGMeM07Eon9wPQ2CNETLFqaJ+vhaBhWfSQBGpUltxM
         IgCEaqpWP69UEfPzIZk1LEsdba8U3gjpEBDJZyB+7ZjpahXa/MPUhl9IcXVABgdlDK4o
         4zv1xJ6mEGaa4ZJUuLA+EN//uHskFtwGZr+JPabqk6UuDA1P61IOz+KGNCjbYzKAWgF1
         GaD8up8D0miu6ZfU5o8lTiC5zggHHYXkUonvKtFNUTD0LFNbz72rYPRHKwGa8wF45nWG
         /I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724016727; x=1724621527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoWx7i0vCeulomfayb/N9YZ9QO6STgMm6TMDi3Em86Y=;
        b=bLaVTDU2PqG06THfnepY4Zr1VwYLVA2yMUfojPZNhRuaoF9Eo3vpU7id1b1kkkQ4hr
         ZL5I2gsHglequfvaASRplkxK7b9OLMbPJeG5pdS+N/HoGOXf1V/y+YGGedxp6kSMvqBd
         lvJ27tPpAXFZKDOAjGRSazNWKi+6Wdv2z6aVL7eVR4bmoa48BbiiQwMma5l/Q5KM6hTs
         GZmmxXi/jP0fF/M6fLM8rGALch1FrvFIZpikqymmk/s2J6QMq/5SJ3vvtGwPnQjGKWT3
         J9IMG90PM4URDqiozpSimGWjYcW/i/TzBD/i+2leUNIs/biL/Vuvx62VRIFq3tx6SvBA
         DXJA==
X-Forwarded-Encrypted: i=1; AJvYcCX3SbQfYTRW583vdJ2/ca+MZeAC3QLcOjxK54XmrYI1vPCyx+HPPOG8ZMB+cEkyJNOwQA/0kfYEuh34iNBdJlE8SQMtBcw9rlip6XQW6YJ+jE+bMaB5S83n/7iNI0yrKCY5NwBJNvCMEjrjIAE=
X-Gm-Message-State: AOJu0YxwjvcoxrBX8DDboyrLpFsuB+AEl68EBNh0GRiCt3wauFObiBvV
	FCvNoQ5mk0gFrVDgU4sIWE+vBUTryPG007gPoQT4Iuqp3UpiRqOvFAS+fCwAGeUba8DN9U/Hovu
	2U3GXIcfQ+mCOb2GXnMoHo7bbK+c=
X-Google-Smtp-Source: AGHT+IFgQB4kYNubDRByXmcv8kAi/0df2ntv24j7cZGW+gg7QCLO3HHu/KF9YdJbQFnaavs8FHOyd4vtC/iHzwfUjGo=
X-Received: by 2002:a17:90a:bc8a:b0:2d3:bae5:87d with SMTP id
 98e67ed59e1d1-2d3dfc3a581mr8047698a91.3.1724016727135; Sun, 18 Aug 2024
 14:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-foreign-ownable-pin-box-v1-1-b1d70cdae541@google.com>
In-Reply-To: <20240730-foreign-ownable-pin-box-v1-1-b1d70cdae541@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Aug 2024 23:31:54 +0200
Message-ID: <CANiq72nkyZyHWi0dPHfXWpJjEr_oSeGRbOCR3usbN6CfQ8t9Yw@mail.gmail.com>
Subject: Re: [PATCH] rust: implement ForeignOwnable for Pin<Box<T>>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 3:06=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> We already implement ForeignOwnable for Box<T>, but it may be useful to
> store pinned data in a ForeignOwnable container. This patch makes that
> possible.
>
> This will be used together with upcoming miscdev abstractions, which
> Binder will use when binderfs is disabled.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

