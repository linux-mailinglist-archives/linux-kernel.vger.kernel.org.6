Return-Path: <linux-kernel+bounces-529621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F5EA428CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6C219C1B05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68223265615;
	Mon, 24 Feb 2025 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D3ZFpufe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E24263F57
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416260; cv=none; b=ip0W6Bca+e7j1bFoiuE7RkiWRoHnomvGjHqRB9o+qzFKwtnebfAYQWB87n0bInnwUvclYppX6NCR9H4pXN8xzSEjZTscp3zvloL95k6HsliofIKMRRALBOJTgMdL2DNMbI8qEUhp+kbZ7p9Zg5wzNPSqHERaRRdoJRHSmHHV9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416260; c=relaxed/simple;
	bh=Kbt09C33MAk+YKGq1E7A3qrzPN58ot8VJKi0PWNi2bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/9KByLFN7dLev3bVGaS+uWXRld3m092hcPKHNSMPzQ4TXvjWJLioKq+mYtkKWnoDKJ59/N+ecj/095ibigTyoxL+IYKSzXfUrOMfT8N2Sh4e0B2pDYRrRZFe1udHg6FU2Jc/WWoRrv9Kl6km2E6AapfywG4Ag+q3aMwVIptODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=D3ZFpufe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F07C4CEDD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:57:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D3ZFpufe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1740416257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kbt09C33MAk+YKGq1E7A3qrzPN58ot8VJKi0PWNi2bc=;
	b=D3ZFpufeD3ztTYfod4kVBl23ryUYa9qgrY34Cw7kVAXfFxcw2VPdISJ8a+9qEuJlsjWUzm
	NM98dT3zC59A0nivNybXrtHgaccxGIwlNKSnC8Yo7jiloMBrMv5M4IUGosElFrTMMnMNAY
	1mSW/NYPYEvF0JjYfxwE9Mc0ReKPSf8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0cd3d26e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Mon, 24 Feb 2025 16:57:35 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f41091f7c5so2267194b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:57:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKEQHMgOvrVPBDjbhUaupuHxzLf/5uYcbjrE4ao7MkReoNCTX0veNquG09/a0+xrPScjtWFZyIKt+xuck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOB9pltooMk5VFQjXwQzkjJU4FO2Js3UbgAFjCCZiR9x1pML/
	f+Vb09xjb944oHCcOyFhqQ9vaW7hMylctomJYAh4ZY7+cPyFaQmsXaD0aG/OD+Zw75qfJvxl0pH
	c/Mmk6sQkefB4AmJRcADbuvj/ISA=
X-Google-Smtp-Source: AGHT+IFFefefdwhnFakKRznoH6UM2IfBKZSke6V097+eiJJj9e+hqoCv6KiH8wOCXuXZQfbi0ZsL5zMRaMnNN/OiqLk=
X-Received: by 2002:a05:6808:3507:b0:3f4:1879:2af6 with SMTP id
 5614622812f47-3f425c0a825mr8214115b6e.34.1740416254414; Mon, 24 Feb 2025
 08:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224122541.65045-1-xry111@xry111.site>
In-Reply-To: <20250224122541.65045-1-xry111@xry111.site>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 24 Feb 2025 17:57:24 +0100
X-Gmail-Original-Message-ID: <CAHmME9okzk+Cj1yrXQuwjwDsJd+x=UJVM_rLUqgdB6oeCYjw-Q@mail.gmail.com>
X-Gm-Features: AWEUYZkuzElQp9cVAl_1iXa4R9rcNiIQYnYm0gUgHgwF0Zs5UMK7tkScIF0urC0
Message-ID: <CAHmME9okzk+Cj1yrXQuwjwDsJd+x=UJVM_rLUqgdB6oeCYjw-Q@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: vDSO: Wire up getrandom() vDSO implementation
To: Xi Ruoyao <xry111@xry111.site>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:26=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> Hook up the generic vDSO implementation to the LoongArch vDSO data page
> by providing the required __arch_chacha20_blocks_nostack,
> __arch_get_k_vdso_rng_data, and getrandom_syscall implementations. Also
> wire up the selftests.

Thomas noted the LoongArch copypasta, but also, there's no
__arch_get_k_vdso_rng_data implementation here, like the message says,
presumably because of the generic data storage work.

