Return-Path: <linux-kernel+bounces-527459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88784A40B7C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E06A3BB958
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C34201026;
	Sat, 22 Feb 2025 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXDLaZTt"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98820101A;
	Sat, 22 Feb 2025 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740253326; cv=none; b=nn8EwwlUwGae2IlVJkgMKkW5bXzNOzNCbgYkXqFr5O46q5Dhfic4lwOgFWuybHpSX21baD17Wq/Tp6gXsgDJJ9RLp4ftsEo4Eaw3fvVawKsy+hHlzD69HUJ0/c3Q8TGEtpdu0ATgKTDmcmAjIoyeEqIEbUSnA4qyhSFJX+og9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740253326; c=relaxed/simple;
	bh=kITtiZ18+LO+sCHEc5eH+N7HF/ZLQrNdJwvZ+WL3fX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Glw+r71ATdKj+hHg1olWVKlrYo8EVD57+SvgJmRkWEZjMvGmpR4NSBawk40zB4E77eSvhnboEKjE5PtE6vo6wlOMcCzr1oQOGcxeuD76EfGvRwpvtRW47wnnpeFVXfGXhw3s+2c9lCkFstsXNFd7UEXIbc9XJmtJ9ZDbs08TNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXDLaZTt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so839082a91.1;
        Sat, 22 Feb 2025 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740253324; x=1740858124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CRvgQmR5ivMD1h4F3gokRfm2MjjJsLjsc4JEynmsAM=;
        b=BXDLaZTtHvHRDxmFZhi9jc6pdzgKdjDudEfPmnlB0E/O/c/IAGockZIlRQ3lzeGMzn
         i2EjRHQWo3N4+5V0p0sreIPIuSJwWbuA6ZVZ2bUbCR+Cd6qcCYySP3B7JHq5hgawO9Gs
         YWwiXOWvpY2EYBbBiYzF9C2YdSkpQNQ/C0GyYT84hjhiJeJwgA8nL7I948gxUVEESKAc
         xqlTevwNV9EdotmNwmz4MM6vekZ0+CKVvGoaSlCPlMfGVO3Ro9Khqimnf7t3ro3J8f1a
         layDQ4Q9fqZTZjbk/tFSuX1cXUD4x6ZSY86Vnj0cmHZsKFVDVrzvU7+zdbvvPeOGjLFw
         80lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740253324; x=1740858124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CRvgQmR5ivMD1h4F3gokRfm2MjjJsLjsc4JEynmsAM=;
        b=Apn2Qq39yinnElYwSmbxw9f+3GfgV9TfsgE83q5Qkvy/sSgARkFMXzn++TZQZDel+/
         phXjWIkVZNP3xFKI52pZ5x5ZuaOHcG0A0coCwGskSgsoozaxAnOmbhKw8Nfz/LBX96go
         IIYd91XIADTDWggnWHEYZgwimfT/y0MkP9wDl8DkTTR5Hro3x85373ZIXd1LVKOb7s1t
         lkwMKadZ6ClEp1ne7TIgeGNE6nYBKfu/qFxLfsCTMrL+jU3/hCol8xh95shzFkTdhGXk
         4JqqTZFOMCMVc1K3Fp7Z7TGFA9boRHec88Qu/HWQi4frCaihJKVDi3Q6lTIpfhl+PIoK
         E05w==
X-Forwarded-Encrypted: i=1; AJvYcCUI/wR23H58G3m1wHe2mkNmPkWNtX14bA0GSAaZdFQJ+itUvsROou5F2eH9mnAvPIaj0Aqh/jwIf2bPeTs=@vger.kernel.org, AJvYcCWSsg1cdSLpA8lC6P1ADtUXDv/YoLxtIcT5wfU+5Zuj1kTV9AYciABx926bRvLTbx5xji2BHoH+guPXkJvMy48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATmFDQ7g5/K9jQf7c9WC3UkgiUTe0MTcZwFYZowH3G8q7a60P
	uqwGwLM1PV1LdQAx9oQlViDMXoHJjhknleslf7xG80PpFsn7AmEEdcbChyPBRw6vpaFY16j3130
	DouY0l5LUngBRaFYQbdWAAg8INs4=
X-Gm-Gg: ASbGncuJY3ti5c58ZQ4srWhCYeyJEXUghBuZuZWC6twhxtZdhSeYuADyG99Il1LrJDQ
	DFYymxCikdyYSyxK/dJWfsBNKc0ozcfOcQbzFGfZfo2c/aDHDKnWPDpuCIYODoNPRpu76sryLMT
	o8SiPMAwU=
X-Google-Smtp-Source: AGHT+IFgZq6EtapkL/u2tRyEnlmt3/Ly4MJg608kxKvNn8pDExIg8vwxtxcox28h6NSfSKflN7BU/IAH6EaBRdtBdDc=
X-Received: by 2002:a17:90b:3907:b0:2fc:f63:4b6a with SMTP id
 98e67ed59e1d1-2fce75f086bmr4985795a91.0.1740253324455; Sat, 22 Feb 2025
 11:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
In-Reply-To: <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 20:41:52 +0100
X-Gm-Features: AWEUYZlCk95OYeQYgvv-2CpvGrLCm3JCYmLm7qyKFLs0_jdzIIGhbSshJZkxX-8
Message-ID: <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, 
	torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Ralf Jung <post@ralfj.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 7:54=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> I believe (Miguel was talking about this at one of the conferences,
> maybe he'll chime in) that there was work in progress to solidify the
> aliasing and ownership rules at the unsafe level, but it sounded like it
> may have still been an area of research.

Not sure what I said, but Cc'ing Ralf in case he has time and wants to
share something on this (thanks in advance!).

From a quick look, Tree Borrows was submitted for publication back in Novem=
ber:

    https://jhostert.de/assets/pdf/papers/villani2024trees.pdf
    https://perso.crans.org/vanille/treebor/

Cheers,
Miguel

