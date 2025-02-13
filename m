Return-Path: <linux-kernel+bounces-512932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65844A33F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38953A49F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC522154B;
	Thu, 13 Feb 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi3RxPbz"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38333FE;
	Thu, 13 Feb 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450868; cv=none; b=glhqRs9dTVNzLSlnVyVfQscDFOGJlNAE+R+SM7RJmfpeoB5SDs44LFuF+DY6Sz3MsFnIeTpaRryl26jNAZfJQOkVclgaBr2qXKgJfS1zHth1nrBy7eaViCmQMd7UJAE1npKVcVAQns6Ht+n99pCXZxRTbHojZlIOsFq00tpMo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450868; c=relaxed/simple;
	bh=oaUFfCoxZvNNh5R7lttLzT90zWoqWvaSgj+qgbPZbLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXOWYThtIUVtlnzHVv5dkB5RGHhpavMkMt3qKCoAWDRQtVnxVVCR0QgJ696QAQ3vDSBYl3x301bp5BIGVeNYMTAG7L/J+QC7UkfFvjVijtN7tEIkmIMdbAi/Q1WDCeIB5cTpMWGDKSKFPxrw+nxTScOkiXUc+j2gWOSQ3ksv690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi3RxPbz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa0f70bfecso185989a91.2;
        Thu, 13 Feb 2025 04:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739450866; x=1740055666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaUFfCoxZvNNh5R7lttLzT90zWoqWvaSgj+qgbPZbLw=;
        b=Qi3RxPbzGXPeNgXgWM8UCf6LHhEy89Gdjz/sTdAr+b85eWilhTBso1W2Jwm6FTPGZr
         ui56AOR4fYEaJdYYGnwqQvg6b4MbS6OWyzPILUZjCtHkkegXWTo21IUI1Kgjfx08DyFS
         42yzZ4gOpMUcS8lUT8UvrNql9JBwQFf33tJpRbnhejUNnR91Jl5ly0ihPv/l/UUz3A/q
         QPH0UyDt6rgoElQ51afgGnIGM/Qzqkwo/yrFX4pakyiQrXr7rIz7svzbMKpAtFjkHFh+
         WxNXv9Rs6djf6oHBQPOdBn8PoIqzeEAoQU30a/TWApbvZiQVaHFIIDCj6o7WtyMoUIMG
         H2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450866; x=1740055666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaUFfCoxZvNNh5R7lttLzT90zWoqWvaSgj+qgbPZbLw=;
        b=wRrna1kbhAchSFstK6HRP9Aj6PfRvuqPc7OEtnKORlhCIdOFC0uahNd4R1bccz9TaF
         xQEvISJ4TlfOVO/Suipgs+sCi4W1OuPokRygOeFc05k/Py4ICQCV8gmNAz+3HD4LuR/r
         vmqmhTVou0YEigpVlLB/5MoHTZ9uOH1L7FL+ARztX5SCfmFPPFL3XgRdvzl9uUrBRNMf
         UIBRdL52Bm39GWcC9f5ACJFUuGa7DJEuPwaBvgwI7oFvLZYVfAtN+1/oDk+FwUeNfOXm
         RfRt/JQIz5y/exRgMWpESdyxa3RTsP9EQuxFiptab9gHHB4k5PgDMp1GoNdqaItYwRHK
         g14g==
X-Forwarded-Encrypted: i=1; AJvYcCUmiiaa0beCEdKdsNYzYxH0QiA7Ll6lLzzW2hi3tyRmrWQHmoRrrnW/QiE1Q+P9r8pDzD66xZeAPi41c00=@vger.kernel.org, AJvYcCVwdj9RZ2uU39xPv3b68PSEertxA5UXDbHRSgtGExxeFNT/UBs03G4urq711LJ1ui2JsSsE7AsmN6p4i6ot9TE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3CWHtGuQp94dj5oxrC8Fo2HJtkJsdFwN4RkHaIHp2br4i+vi
	t81XHdABzg/XF4J8DYf3xhNKH6kN4vB9MiRhn4If8EZ3Ax8OLDpTlHE2czprM5G7a1JxlC8nLfx
	r8Ai3PvEYb8gSPabjYBQ8tRTEIw4=
X-Gm-Gg: ASbGncvFBbCNd307Es6np8G7yzLX3+IA5yTyh4cWYtKQXGHBS1wUjL4UyQxc1ICdjB9
	WQLkL026RHr5H5j1ARWZqeGuAX7fvWm+Yp+22EGoOFv5cgF6xb/hKJA+nWbnGJKwSIRis2o8T
X-Google-Smtp-Source: AGHT+IH+xss/UegMB8XQoUZ41Agrh8mrGIWuK11EZoQlLBHoMAjtgW/81yjkyTUMUjbzRXjbETewC/iKXf34YwDR0A0=
X-Received: by 2002:a17:90b:4c04:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2fbf5ad930cmr4237098a91.0.1739450865927; Thu, 13 Feb 2025
 04:47:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212194717.191979-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250212194717.191979-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Feb 2025 13:47:33 +0100
X-Gm-Features: AWEUYZnp5TfzVjASpt2eRmEUYK1ofOEDyl3qGkpFMBXk15OAxOFUo38BeCkN3uQ
Message-ID: <CANiq72kQLizgq+uBEFz10MYPFcpXEA6zttXMz35cG6W93Z-Szw@mail.gmail.com>
Subject: Re: [PATCH 0/3] author field in module! macro should be a array
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, 
	ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joe@perches.com, lukas.bulwahn@gmail.com, 
	ojeda@kernel.org, pbonzini@redhat.com, tmgross@umich.edu, 
	walmeida@microsoft.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 8:47=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> In the module! macro, the author field has a string type. Once that the
> modules can has more than one author, this is impossible in the current
> scenary.

I think this was a re-send -- in general, please change the title
(e.g. increase the version number or at least add "[ PATCH RESEND" or
similar) if you need to do a re-send, because otherwise it is hard to
follow which is which (e.g. in Lore).

Also, for some reason, Lore has your #2 and #3 patch in another thread
-- please try to see if you can fix that when you send the next
version. Both `git send-email` and `b4` should do the right thing by
default when sending a series.

Thanks!

Cheers,
Miguel

