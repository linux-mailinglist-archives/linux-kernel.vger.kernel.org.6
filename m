Return-Path: <linux-kernel+bounces-300417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892DE95E368
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123031F212C8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B9814D703;
	Sun, 25 Aug 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei2qBNEF"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3BC29408;
	Sun, 25 Aug 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724590223; cv=none; b=lnqRHq1hcBy5kuvXmuqAr7/ClshISE30EADD9Ma0jgsPGEdx8dqG8nCax806e0U6qbzRYhkesxt3oyT1bhB0DLcke7DsqWHUpuOXXLw2EfR3guqL6e68MyVM5ArDeVfJOc5cHc+ZIanxFy0YBve/1QJjIGTBrMEcrj2h6h9bRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724590223; c=relaxed/simple;
	bh=wSsxZ7dI6+X7NQkH4B/DRRARY/PktUAwIQOrsJoOArI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuhnPJzWUJP6dOhZj8T4xfostI9u732z6KnHqwDEvN625bbWtcxRtQ95RiWl7y0rh2VFsGRjnlIfGJkpH4Tq2olJxrjtGtK8iG2tb4h++COOgzBTeDyFB4phZjIPfj6IzfqtHZHN919sog96OWngxGQUpJOrZg3tDjy3C7svaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei2qBNEF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso568947a12.0;
        Sun, 25 Aug 2024 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724590221; x=1725195021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSsxZ7dI6+X7NQkH4B/DRRARY/PktUAwIQOrsJoOArI=;
        b=Ei2qBNEFFU9ipOFCU8rObEYCKe3gJ6WCWD5G75MUp4eCdKHQySyTxAh8IfOXP++xLz
         qtTCP86bBBllie8ixMH1SG2+MEY+5pHoVnw7T7su0xokRxMsOauXjBFg2FeVA63pZyVt
         XOUBx8OuWXpagodCmtMbtz9pnS521t2mLXC6ViyyIEQrPtvL7f4e+0VlbqM8qMIBqAK5
         XJnlPXUGPW8XOWmPfq57igvydoHT9sUAgTcKtAaRE8W4u8ftjNaeq5VWJO7alYtVlF3X
         4SY5CumnlnwD7+5bLtgPax6Ubq20q2jKNEfOf6lMahMXXki5E9teOtoocHVEjlh1Wf3F
         CF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724590221; x=1725195021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSsxZ7dI6+X7NQkH4B/DRRARY/PktUAwIQOrsJoOArI=;
        b=vSJxeWZveuwTIHGFD1X9xVTGqn8llEEt7Q2SXTbXIRNtds2wKZEmJFIZDeKrSb5SvZ
         6wZPedY03jJD3zRLQIjhz5hRzxsOCmpQa58Gc8HKZX42Hyqjlxh4h6FNN3BnTtKKVt6b
         eavOaEsFl+iS18W8qYDXoN9sD0Tjw93TXU72AuM6wA0htM3CkoUoU4hqbZDpkmi4WRJE
         mDIRAvzGHL9irK2ffqqdCNZpYfxHs1uS1+PKniDHsVyADeX2nCRsbArx7tylw0qUz0zf
         rPn5oFtWVPlEoS82btBNT+OD8vvsDL6S96ETCG6MSUCCJhd7cx+yZjOzP0CBY4Hv4hmy
         aePA==
X-Forwarded-Encrypted: i=1; AJvYcCU+L3vXVt/IyBn5q4Mqk5w3HjNfuWnmov7OzIRVP15KnY8VATjK5+o7Awk3r+JvevhtxNo05arkXlvUKRz7lwM=@vger.kernel.org, AJvYcCWvadQMcSSlvzWjFoqfr/oYBhcC0EyMj+klU8Hnku9tXit5Lsw3haKjt4Qc+DQmU1ugzm2rBmIhYNvPWL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywizt3P+R8g/JVfNSYRabS6GTu6o9vUtY+X7hAcK42KxdZq4Vca
	t6DD578pvBaGXgUtTZ3jCRN0XvaIvt9/0743aPHjIMHv7JwrjUc9qo0JCl0q0nzrIYPqv5F5XOM
	0+s+PigReHujREUgS4gJ0/VjNfCQ=
X-Google-Smtp-Source: AGHT+IGUP/DfaB8aEfaxtY39P9KCRZBTpgnKO6o0P+JJlI1mDdidaAOCtFLZX+kqLiI2gqH878tXcACHcJ7jVSFugBU=
X-Received: by 2002:a17:90b:2e83:b0:2d3:c2a3:2383 with SMTP id
 98e67ed59e1d1-2d6465fad68mr5180628a91.0.1724590221151; Sun, 25 Aug 2024
 05:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816181514.45696-1-ojeda@kernel.org>
In-Reply-To: <20240816181514.45696-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 Aug 2024 14:50:09 +0200
Message-ID: <CANiq72k9_B6zvB=WumaNfb6VhYYUH_HH0RF4duJGtA23bwqRqA@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: quick-start: add Debian Testing
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	=?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <debian@fabian.gruenbichler.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 8:15=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Debian Testing is now also providing recent Rust releases (outside of
> the freeze period), like Debian Unstable (Sid).
>
> Thus add it to the list.
>
> Cc: Fabian Gr=C3=BCnbichler <debian@fabian.gruenbichler.email>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks!

Cheers,
Miguel

