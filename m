Return-Path: <linux-kernel+bounces-575514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B416EA7038E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92CA189876E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE225A324;
	Tue, 25 Mar 2025 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCZ1kG5S"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D31425A2C1;
	Tue, 25 Mar 2025 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912367; cv=none; b=PizUsnSs7l0iZp6WlvDhR7tgTYiMwiBHbw0FJITb5RQ12qFMJ/ZL+BctXxcothmImc6mmXnEquy652VfomCzO/Of9A3vRSXyT5ZREfpxPc4LGnsQGKty1kYtJEDsaHYozG9wda8WEyY0wJuvjYqp63K7FT8KqIcaI/HR4soUMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912367; c=relaxed/simple;
	bh=I2lblF/sEfHT7z3P1dCiKaaeoG5MmtAEKuRyQV44FuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoCW9TeXF5NNaV0d7UgQA9b5w0az5XVqb9z2uKK5yOH88lsetkcJg7OiiIyZC3v4thvdq2R7b3K5fsYF/A7FG3zcGiENkvJf9OwYdsfF/HNwroBCwh+X9Uj+lr68JozBCeS9PZClORGvF3YPdeKp/mHn+ZCDUhuT3ac/jU4QHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCZ1kG5S; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30363975406so413916a91.0;
        Tue, 25 Mar 2025 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742912365; x=1743517165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2lblF/sEfHT7z3P1dCiKaaeoG5MmtAEKuRyQV44FuY=;
        b=LCZ1kG5SpAoty+q/7lARXDOl95Erz2Yg23kMElBITvF6eHYaQ+dUZIaid7PcUGRJoi
         CD91071NKu2URGp8dpYAO/QZ17G/5Yunut3xSnAUcus9+oSZCKFhBBAIk6yJntewTFOf
         gmnxzL0uFRS0C9/bZOpeDkqiiUUSTPAsthEgsbF7eZ/6ALTKt5Zmy4/8w7Tow3CyNfX1
         Ccl4Axy0ePRiLHoSa5NIzHpBF9ardO6nLkFThwsrR84oJLmbhWg5uTl4u7vwkDVEi8fl
         M/cwTz6eC+IqyB1reeaNvWUYEkZQE1GV8Bg8hIr8CWKzR3/iBRBiFfDrQAGda4EJJXb0
         RuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912365; x=1743517165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2lblF/sEfHT7z3P1dCiKaaeoG5MmtAEKuRyQV44FuY=;
        b=VA9+AtpcrjHOpOED8IzC+s+WIFWZgWxdB9IiQEHCdBvHaBFjkQ/Dox60jq2WXqLMpM
         isItCdJZbSlWsZxzoc0ywbUNv+gNJEhcs9pjVP1Mv8Y6wh6qY4Wwd7MB2vG6kmnnAFbL
         Pzf15pTBMChpZ5nss44O/pyakoEWN5DGc3bAlzKKU749aRn3IaaLd0zJknC4iFmviJnA
         A3LETR3R56hOXoytF26Imqo7P6WUJfavdAjFHKGybW/3m4qJtDZn+4/zdfzKTqZo4K9F
         1HuY9BZZ0lqUuLNe5Y3O8NQZGqyN9MMr1gJCL0igZwxI+uKXKVt9GAv9rIZmPi/81TnS
         bkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU952RsofpB+uJ3MdqwBIsA03fHrzdwbxZKst9hNkzcA1dn3kPd51crlip8GF3JXCTazXXRO/9L5XdrZLoodbw=@vger.kernel.org, AJvYcCXDtRcnZCoxJ9o3D3y7o8Q02odwUj7SBEfWu11CUtvSbngI5V3/qKC2BY1DztR2IxqOCW1ysCRl2k7uudA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/33odFOFNQWC3qwzNPIg4K+wPkL89aetPO4+btk89Sb7nxjJ
	WZ8CoTnLyfJS7A+/wOdkof9QGS9foXg/z3g2qM0WqPWtkJdH9fWY5XkIZKfnhWz4hJiGRFTSaAG
	k9Aw8zD8X9//2sKJveLpxkXWVGns=
X-Gm-Gg: ASbGncv5EFKfhZjurHkqCuZH771NMxh+tbrjcfOxBqqePgpKPmeh/t8/jVY6sPGo/HA
	SfU8kSkc++bc2TwbzL/51skEDyfp2TaMp9f5sSofQ57EpdEvq5JljctPjhpqBrm3g5lzrOG4Bdh
	k58yl6m1ZSc9EgqS2g7pBODHz3SGZ/VdIg5C4s
X-Google-Smtp-Source: AGHT+IEoN/yvfpbSzdjBSvEx92ayIangXqWC+MRDBzrVrubs2HZ/X3k3nIEzR0YJ1Ux80oKRDjtZ/ndVyYiCL7hUkMA=
X-Received: by 2002:a17:90b:4d0d:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-3036b2c7bedmr1985451a91.0.1742912364690; Tue, 25 Mar 2025
 07:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-5-1f51f9c907eb@gmail.com> <FB3D0F03-B162-4AD5-B288-4E307421276B@collabora.com>
 <3DC4063A-3E9E-412B-AAF4-AA0C33DEEBFC@collabora.com>
In-Reply-To: <3DC4063A-3E9E-412B-AAF4-AA0C33DEEBFC@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Mar 2025 15:19:12 +0100
X-Gm-Features: AQ5f1JqAaqZQMBsZwvtO1tL-L9kNrwTNUGTZoX67HP__t3_ZqXvRMIQRHjCf-0A
Message-ID: <CANiq72k0J1PqH6mQ3DJVMbM=yrzXsFZU5NpDX-rPU-DP_4QHeA@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] scripts: generate_rust_analyzer.py: add type hints
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Wirth <lukas.wirth@ferrous-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 2:39=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> $ mypy --strict scripts/generate_rust_analyzer.py --python-version 3.8
> Success: no issues found in 1 source file

Should this be a Tested-by? Or am I confused and did you mean something els=
e?

Cheers,
Miguel

