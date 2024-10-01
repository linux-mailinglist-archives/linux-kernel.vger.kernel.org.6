Return-Path: <linux-kernel+bounces-346772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D5B98C879
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30A8286610
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078F1CF28D;
	Tue,  1 Oct 2024 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuDbzK6W"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1061CEEAF;
	Tue,  1 Oct 2024 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823521; cv=none; b=GZmBmUHI/f14zFRVrI9I1s84GnJn2siY5k7WG7XZGRCdZWolVmDgpShHyWymTUUb6AS7WHNN7jlIhBjrEljn9oKI7hAn3THCiVtR9o0PyouG8fZ60yZFF/3KtnIoEk5OZmdbpQjkoS2J8Yr8/1TFzjHZMED2k1Db/5o/6AcLjo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823521; c=relaxed/simple;
	bh=GcCXpoXuLQ65zsvFzzvLaNncg0Knqr7CMFRJpjt6oO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tv8C98bGiPRsHLL+UN1xhLZ9GV5ypwuZlTSgzuebRj02OcMVcbSGJ3RW30pZ77zk20K4lX6CVq2Y8IPaGBjRNywpGdBtqOuUCXdh3pz0MYai3XQBGCvjTw0pgwS5T3MgKCuyXKCbBVTLE+SkOTImM/zddL0XfFEEmUzTO/J6uvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuDbzK6W; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e13718283bso430840a91.3;
        Tue, 01 Oct 2024 15:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727823519; x=1728428319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcCXpoXuLQ65zsvFzzvLaNncg0Knqr7CMFRJpjt6oO4=;
        b=AuDbzK6W8nz4tXxqG577q81G3PdZ963rItH4x2p8W0ZoqGWtZjal6J/HGrQs3UElo8
         zZLVdy+LvmuOin4FSNmRqVuTlTdjwx9/YO+SDqPvuVtYpcleT3L3Ht/YtYBdrVOuYJHM
         y566sB+u5ys3klHe0A5k/LlOffKDiwC0k4QRF1gt6gBilc2SpMwQ0LxpRwu37b/Wryw6
         xoeu+mGZQprgC6TSIj05WqcpGhagdf7xG4p4VOPtRWP4zs9o1ok0OUFXfAVZ4rtu+Stz
         SEUK2tEeTelxaNPV6Iy6cw0s6F1DDCvmy1gXJjuznbgy+3YIoZDWJEoRF3eV2Wo9ci+J
         hZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727823519; x=1728428319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcCXpoXuLQ65zsvFzzvLaNncg0Knqr7CMFRJpjt6oO4=;
        b=kgDXYVNTShWWUzqqAHaJUZXn134PWwqsMyWJlejZhpAwjWkcOGouRxppMTLHN6kRnI
         UrKfuPlumpRy7Ijec4rLq+zeb4N2KRLDCyGEtjBAzbeQqxaoVCQ1hNPwjiLWBVE6VxPY
         0LlKydgjvlUV/ivJIuJIJvvTc5gdC9Uv/lQoXhNJQfaE6A3ofOYE1spAvmRJuY+wMVvP
         8zSuP4+kkn7nNiePTyyG/0hPARdJsgDj6y3EOltt/29vX3eR0WUwQhBIZYd6ngylK0x2
         /DVfUi2YI/q1FjHX52CGgMqYB3ZTVUlMktCJzXzOT3NZq+nyTqMYYGXjWOJPJe5/q1Qy
         y9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWW+BUnK9ASBZxzn8PnWhhZQy1/ULND0+nMBYS8lQd2kLdhS3eQJpwcnbXCps2d6NM5DAQdWh/fjJ3+4T3yJzo=@vger.kernel.org, AJvYcCXabIZfHPDxn6vraFpBOlml6djz9nCLJ/GNA8aYUiW9fbtdBQHGz28W7q+A0H6MXMxHliqPKVCG9JGDWBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kh+0CAzIbTs4UaXFJjNgs7Bre1dYV+mr9v3KQCx8a22HEVh+
	yvPzXq8MFYR8x3OqxPF9ZMCi/MQYMGwLQcKfYvAK6X+ZhoxmNSiHDhXHQUNE1f0AgsI6wcTFOl/
	LP47E2yCszgqcaxri2ADPHHXuJWs=
X-Google-Smtp-Source: AGHT+IHpaFbsZOabANZ/CJzRes6xXXQciJO4D+GF2dnFUH6bN7daLXhvMWbeLXhJOcjuqRLGFQ7VvzUeXuMcEWXDeSI=
X-Received: by 2002:a05:6a20:a129:b0:1cf:2be2:6525 with SMTP id
 adf61e73a8af0-1d5e2d25ea7mr965934637.11.1727823519000; Tue, 01 Oct 2024
 15:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925140600.275429-1-ojeda@kernel.org>
In-Reply-To: <20240925140600.275429-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Oct 2024 00:58:26 +0200
Message-ID: <CANiq72mPN51iHAzEk-Bn59X+ZhzzsioLoVPD7nDJ3wbPpDa0Ug@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: quick-start: add Ubuntu
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Zixing Liu <zixing.liu@canonical.com>, William Grant <wgrant@ubuntu.com>, 
	Kees Cook <kees@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:06=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Ubuntu has changed their maintenance model for Rust toolchains and is
> now providing recent Rust releases in their releases, including both
> LTS and non-LTS (interim) releases.
>
> Therefore, add instructions to the Quick Start guide for Ubuntu, like
> it is done for the other distributions.
>
> Link: https://packages.ubuntu.com/search?keywords=3Drustc-1
> Link: https://packages.ubuntu.com/search?keywords=3Dbindgen-0
> Cc: Zixing Liu <zixing.liu@canonical.com>
> Cc: William Grant <wgrant@ubuntu.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

