Return-Path: <linux-kernel+bounces-343799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69377989FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA396B24930
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76418C03B;
	Mon, 30 Sep 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxAOIwmu"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845D1CFA9;
	Mon, 30 Sep 2024 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693062; cv=none; b=nT8UdEzopQ51N57y7PHZ90bTLqo88eIAetKRAu1xJo45ll4ha22VZx2jmr3Y2D6x8Q7VDLd9+xjHIBKVATDGsTWMSYF7hPJm8pEfAfs7Szn0oHtf64XZMrX+WptzHpWAVitcsTNTmeu0F4OFhanmQRUAr6KanUDvj93Xp4tEymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693062; c=relaxed/simple;
	bh=iIJXuaoWS2dCefQqpt3EjOOTIrXnDZ8TgOEpxiksat4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdmduJ/kRV9ajeXL1+1mvm2Kc3qqW8jntrZEtlPxvEkZJSQxEgXJ0CBpNRGbkNjRGk2GVU8bHP+hQJeKPZIBEIYfvUrRcdw01xwSscxVkX4T+/5kWTBB5lv4TF+qqGccYqjuWCyo2m1ICL0G58TEDRPg2CxA3zN75HnQr8SmxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxAOIwmu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-717880daae7so222066b3a.0;
        Mon, 30 Sep 2024 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727693060; x=1728297860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIJXuaoWS2dCefQqpt3EjOOTIrXnDZ8TgOEpxiksat4=;
        b=jxAOIwmuRT3usKWEIy5wSXJshxKJKS0ss1Uwp9d76VPJCdT7VsmFXfxkAglyw5ZTgA
         nBjc/UguOw1R/WRdS8hzhbXVKuR/CbPcnB00eaSPTpCsQx/eyfnqNufZbGa0loY504j8
         0KhD45RRe7Bn/xTbFWnqJa1FPRoVCc9kA0fhNonWpiCURV3tMDNdlJoawxZ/IK/UufrW
         6TG78M7k/t7I0RlzPGSLqexwQbAI5fvlifNzGLbHl+h1hgOrrDETVePGBmLagXyvd8Nj
         zfTB3BIVR7BposzO29xrow3+BT2d5ZySAzalZfkcMwiC9VRhCQqIwVjuZ3uMJtUF3Yk6
         fjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693060; x=1728297860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIJXuaoWS2dCefQqpt3EjOOTIrXnDZ8TgOEpxiksat4=;
        b=BAGsbJg0lMk+nqd60V1qVQkPyDT9gu/q/Aeh/16v4VdgVtSt+UoM9tnEsqQFJBM3GW
         yzyE5xITWMZOU6PuOOek0wPU8+Y+ATeViXlJDvskPrbVTXQwBLShlsF62igYL7Tlz4UI
         PlYiinVGS5tqUXPzMOot9UwrcLryst07Q7AUTM13Fm6AFKmYPN4WAh2Fbf2dGISV/2ef
         2kCpJxoen5F3qivXar9tqhg35j+iFryQHiF3YwhpJPx2MqqjwUbY7NfG2XYKjEeJvGao
         yqCdRCP3yWJXFnExUiFC4mYMRRpGRKDhJ7SUWwpSVnYfmX2fyM1GW8ZUKeC09KIQfMI7
         8VXw==
X-Forwarded-Encrypted: i=1; AJvYcCVzxkuc0/q1ihjrQHHgoIkHOgAkqaPXSSWWMgnEXC1akBZtsja2zlmEaPeIKeV1P3BMLgVBonvj5XKfy1VGmAw=@vger.kernel.org, AJvYcCWjodTBuRYmk1SG2LYjETVJGFz4ERab9NBBhYNB2rACpR0sNOrzY2bkBdayWUX7soGXoSYPxJmgnfTxyrxi@vger.kernel.org, AJvYcCXEp8tj9gv8Ch4N2qK8yvwN+trrJUvbcOcbmH+aBQT/IWub+RFHnFO8ELlTpllFxhDZYzbiySi7FhLGlpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwawYYyRBacM1pTKzG17VszO7KKlWoTYGWtvt6A5aH8voRA0L2e
	6bV0MoL7B9TqvFiuAueH0ohew8NIa/3NdyVfYLDhW5y63Sp1rkyok8Tukj2R7mG/sOc69ZblcRC
	AgSYz9pvfBHoX+OBHVi6aaS3fTg0=
X-Google-Smtp-Source: AGHT+IHdnqIBrpEVdt86IggSYvKBA5wsLTFvf9YYCZxuv8g2PGuDbmINu5ve0jT+N9rkVZeRX+RZ3EH6nrHnSuRD7jk=
X-Received: by 2002:a05:6a00:3d50:b0:71b:64c:813f with SMTP id
 d2e1a72fcca58-71c636cebfdmr4725427b3a.6.1727693060569; Mon, 30 Sep 2024
 03:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
 <bf6544faba2b53ce901b2e031f3d944babcc7018.1727606659.git.hridesh699@gmail.com>
 <CALNs47vT=g2D7A_cDq_8F2xJRJTK-7KtQY4brFYfkopyCSjLTw@mail.gmail.com>
 <67il2JOf-dSurc3O-294W5k5mS-kf1FtFxKzXlxHHykGmIvIkfPel_pPe2LGX04HSnTg85LwEdU4Zz2VCrfXgIl5KVItUm5vPhbtkThc3BM=@proton.me>
 <CALiyAo=udy-P4ki1-_CAk7bHWfAjoioYEZ_ah+i6DJZ0MmmCQg@mail.gmail.com>
In-Reply-To: <CALiyAo=udy-P4ki1-_CAk7bHWfAjoioYEZ_ah+i6DJZ0MmmCQg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Sep 2024 12:44:07 +0200
Message-ID: <CANiq72nKBz1myZi5guA5uPCwwtUvjfF80dOx5saHvjMU-g6mpw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2 RESEND] checkpatch: warn on empty rust doc comments
To: Hridesh MG <hridesh699@gmail.com>
Cc: Patrick Miller <paddymills@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-newbie@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 12:35=E2=80=AFPM Hridesh MG <hridesh699@gmail.com> =
wrote:
>
> However, I was curious how conflicts like these are generally
> resolved. For example, if there are two large patchsets which conflict
> with each other, how does one ensure that they are compatible, and
> even if they are, how do the maintainers ensure that they are applied
> in the correct order?

The maintainers will usually figure it out (resolving the conflicts
when they apply them, applying them in the right order, etc.).
Otherwise, they can also ask for one of them to be resubmitted on top
of the other when it is too involved / subtle / large series.

If you are aware that you need a patch to be put on top of another,
then you can rebase it yourself of course. Just please make it clear
in the cover letter (or after the `---` part) what the patches apply
against.

Cheers,
Miguel

