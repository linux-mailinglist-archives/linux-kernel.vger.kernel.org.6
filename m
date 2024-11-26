Return-Path: <linux-kernel+bounces-422624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A684F9D9C15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0E28418F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDABE1DA0E0;
	Tue, 26 Nov 2024 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQiJN+9k"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8A5B05E;
	Tue, 26 Nov 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640888; cv=none; b=iRR44ZJDbGr/E+Gcx5hZILT4stan+PypdrPz/EbwxdUl2/2ZdzqJCGR+7xI8NMjoUSuwu8zMYjTj++OVJwvHXX5VA50xgiYfvaUwTT8nhrqtyqwvoybOl7T4m+/LdOB3IJFOjvOVYp4p87cALZ7BD31QOlYJlSh3bKSF7vAlCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640888; c=relaxed/simple;
	bh=sGAbKuAjs4FGCo7VF5YtQ8HB5V2FhfM9zHKnIDnEZ6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcsbhDBKXFnEXlKpcjlHuJ1S7IliDBqrUPbjpYH2RJVjcxzgA4zLmzlIhar39yWBWgk5+RP5vBDmF6tigzaa+ql4aWAyPcXcZZ8neDP7FmvB9fhmckGaSRkUMeEH51yM+7e7UlW0GuiQDzkvQ/NFsDYkBpcu96z1xWSZHv+O0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQiJN+9k; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea85fa4f45so705818a12.2;
        Tue, 26 Nov 2024 09:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732640885; x=1733245685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGAbKuAjs4FGCo7VF5YtQ8HB5V2FhfM9zHKnIDnEZ6E=;
        b=nQiJN+9kDFLDReT7WybYhhgMGY89F7cIS5YYTOj5NTbMk8cewtLoDtIx0O6jK6Y9VK
         lnJd9EdYI0IMsIb3/jLuIHxXIT6KPPlDq8B1OFpuegjiIHn2myo10Fd0gGhcN5kPebHQ
         iesGjUqbUMBFqv+uilPFN/9Zl5kQQsnEZ9xqPlJISwow6UJmJX+vNbfKP8hAM9qitwIB
         bZG5xVSuKJYN14LFfsRWoXpADg5lU+Jk3HwTZFU7WKCuc4WsTlKaXhqlQ33GM+2C3LIx
         YDkQvqBWT7fooxPXCEOP9CsLi2tFKlb78UjLDtCiTJnmFJifTAh6qGhvte15hPj3WFg3
         nzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732640885; x=1733245685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGAbKuAjs4FGCo7VF5YtQ8HB5V2FhfM9zHKnIDnEZ6E=;
        b=dnCncV2GwfKlj8AtqZbXocaccd8hakPJtpc8ZxGzgfYnOhvBvCT6byPfBmXtoaR4Uw
         f8ZPdSSMd0elJMtbJ/Lw7YftQykfuAJ9Gt3+AEWNXiRxMO2Iork++gwezJLG2blLwF6f
         OWhXF7RbvS0lmDa/pwMxZFOE7HiBivEQyiJZ1KJomR2ksNNvrW0HFaOmvXAZaTFEXjzt
         7cg/8KC0F8n/sANDwLyqyfZscDbciEe5D5ysbMbMd/bfuR9qfroR787ouaxYNWLhPHrx
         coZA17z1LiYtOpJk9bEDbNysRa/cGaVKxGLNE0Go0ck+1iyXzFjmdU4k4zQNX2bImB5i
         wjcw==
X-Forwarded-Encrypted: i=1; AJvYcCVUsoPs4g1krQRSOP2ETJTHN1/es770cbJQT7LHC6/UTzMvMBHVQgucPR7DXmfuAxLhtg2uqgcG3nEQJ2M=@vger.kernel.org, AJvYcCWayQUon512W6gdbkAyG8Tx7dtyXZaEIYoqws0F+2aS07BVT25xtpsKn3+HGRo4QXlJHArLjwrI0bnTVCy3xBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2pprO9PpXE52sd+II+QWc9idNvBY3iz2AB/kZQvhPZFAd53v
	bGF2XKmlIxcN0iJ6EqIsQ4vsBsyyvC+j0tFyk481YxxM3Mu4alnY8oGCEJWHsxN0KVv9n1dXYew
	lzNY/SA8LyCPT8fweu4CWqfu/BKM=
X-Gm-Gg: ASbGnct8EE+x8L317n2uQlCS0MHV88riWkFt74DFZRYQuX1sId0Evy5ZhoMzayuDnLu
	SXPxkFcPdXDhUcSndu/EBmQe8Zz5wVGo=
X-Google-Smtp-Source: AGHT+IGq0LOfWcqUBu9DNEKeqZq/Imrpg9CARnCObzfFWEnTcxLjrR+duzIa3pxUIQrd7GkH9xgFAybHmheVIFZq8l4=
X-Received: by 2002:a17:90b:1648:b0:2ea:5c01:c1a0 with SMTP id
 98e67ed59e1d1-2ee08ea8cddmr17554a91.3.1732640884968; Tue, 26 Nov 2024
 09:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io> <20241126-pr_once_macros-v4-3-410b8ca9643e@tuta.io>
In-Reply-To: <20241126-pr_once_macros-v4-3-410b8ca9643e@tuta.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Nov 2024 18:07:52 +0100
Message-ID: <CANiq72m-dY0b7UiBiWOg8g1SFPqLxuhkDdWwNh8g8OBk-Tjz=w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rust: error: Replace pr_warn by pr_warn_once
To: jens.korinth@tuta.io
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Dirk Behme <dirk.behme@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:41=E2=80=AFPM Jens Korinth via B4 Relay
<devnull+jens.korinth.tuta.io@kernel.org> wrote:
>
> Use new pr_warn_once macro to resolve TODO in error.rs.

Thanks for keeping the work on this!

I would mention here the merits between `pr_warn_once` vs. `WARN_ONCE`
and why the former was picked in this patch (especially since the
`TODO` suggests the latter).

Cheers,
Miguel

