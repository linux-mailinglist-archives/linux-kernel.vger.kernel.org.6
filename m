Return-Path: <linux-kernel+bounces-374923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D779A7207
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D6A1F256CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F81F708F;
	Mon, 21 Oct 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxefdqOd"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181A1991AE;
	Mon, 21 Oct 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534365; cv=none; b=H2V3+Kd/ID2kI6ZEz1GQhNBUySVVN475e+QuLZQmI+3XvUHsA7iupD4u9PjfYnAqelI/At11wRUDRKBuMPHndx0xK+UwNtxgfebtuDim0BEMAm5i6ie8gr/F7DWTbyHztGAmQ7kaLLp39NZz2fP7/vt1EcXs3Id5rP+bDOOcwzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534365; c=relaxed/simple;
	bh=TWnRJClcZl6Uf+e9g4uFsAZMAovmGd/oVdyuodT8JPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH7ZcoCy6IK3LIWkMsgOu1Iub3FVy9zhuqnElMfVyhdsraAhraMSOS+B8MTnBf+bVTiFU6IofxdhCBGs9IqBEX7Ns3wb8EA+hvHp4VfCd022dg4JhmLteXztBlifmtOVKXcstfE8hXC0d+Lira1QCAenJUlbyp7RQPUD5eNezsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxefdqOd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7eaebc773d8so172878a12.3;
        Mon, 21 Oct 2024 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729534362; x=1730139162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9A+VjYXugJOPACtYEFrsBaLcdapWpmus4EmgLLrpEw=;
        b=OxefdqOdfHu+JdR4u9wh1VDNZqqQE1haSWwm/kY/vnzrZypEs/Pe7ku6dJDUctqFDu
         PKTGF8KnMcXaAgmtfgA6KlQ8h16qeUqw6EcYsYKAoAa+FJBpwFQsQd+rfZ5hJq+dDPaO
         Kh9fIObnr3BYclV2PcGtWcLIlFd+ZRAxfbVCiZCemtWyCnZMpl4mqEG4xGezPHEr060U
         UfWE57bbjX0fQb9WjYqYlrDCp7yE+2fWUlUAHdoDeF5y5j23n/xEiez0f2NMuVlVV2XH
         7HhNamkxiDepG8NON8GLw3UeTfW+xCkZU52Nhn2aaeq3V3P3fto2/3w3evMPGPx1uVW3
         t0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534362; x=1730139162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9A+VjYXugJOPACtYEFrsBaLcdapWpmus4EmgLLrpEw=;
        b=FNPqypJ0HvpIXVsu4BywOIskWirnIoJlnqnWv5Aol3R2+letFHwRAJDvIbw8JYUno5
         4eKxXmLOEVz0ItHxKeZd++by2CstQH3v+hlHG71O+eD7QZ8AEOS1exw9iHu3aKiYW711
         2+IVQ9JfYR+xoyAtu6epYrNPdSt76tzrpZdOHlAMs66uGJJr858lD8uALK9XGFLl0meC
         wiqSr55liJ0Q3tuFTFq6dLu9elnXZmkD33LMs9yGZx5q2/WfUgnoWbAlVHvHsbh2MaCc
         g9uwGM4Qdd0ZzTvMZzLxaPCi2VoNU/HuoscUD5ybrwj7NdCNRu9UQA0p5wAIUFVRZsQ8
         UrOg==
X-Forwarded-Encrypted: i=1; AJvYcCUbHQrolQ91Be01hetDZy/vQ9z/Gf2doZoJOkprhl79jzCQBbL30UVyLnpiq4JOc/Yc3/qH8SZC5CxUOLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLB8L3V4BxA+Ah4mV1bmxa7KqgWOsDUFW9Zc2jHmH+tQSuazcL
	KIhyKNX1NVmqzZAX8NHMTiA2Kpcd21BbQs+7RbufkeAYwLRQHxEkNH0D8L7kL716jrS4VXq81Wz
	wEOKo9QWXh/KRps798Fg3z9IF88VZkIk+
X-Google-Smtp-Source: AGHT+IEB+T2cYEl+ly3fs7GwDgpI4SlkFwMsPEVGfyA/DlvdYvkSbSOYrXotFVtmBvEj/zVPhonOsESlTTKSH/Ild0w=
X-Received: by 2002:a17:90b:2249:b0:2e2:c04b:da94 with SMTP id
 98e67ed59e1d1-2e5618d0f69mr6042358a91.5.1729534362635; Mon, 21 Oct 2024
 11:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72=M+rgJGLOBeSYygQzJZa9XnVvaWgi3DKUyT1Z_Rq=1Kw@mail.gmail.com>
 <20241009162553.27845-2-tamird@gmail.com>
In-Reply-To: <20241009162553.27845-2-tamird@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Oct 2024 20:12:28 +0200
Message-ID: <CANiq72nA3EunhnHdfk2q0jZOE8oPszu2TYMhmDE1qNKDfXGoeg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: remove unnecessary header includes
To: Tamir Duberstein <tamird@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Dirk Behme <dirk.behme@de.bosch.com>, Fiona Behrens <me@kloenk.dev>, 
	Filipe Xavier <felipe_life@live.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:26=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
> removed the need for these by automatically generating the exports; it
> removed the explicit uses of `EXPORT_SYMBOL_GPL` but didn't remove the
> `#include <linux/export.h>`s.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

    [ Reworded title. - Miguel ]

Cheers,
Miguel

