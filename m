Return-Path: <linux-kernel+bounces-414673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7781E9D2BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D431F21815
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EA41D363B;
	Tue, 19 Nov 2024 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeWOYOH5"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7DC14AD3A;
	Tue, 19 Nov 2024 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035154; cv=none; b=cPXO72uL2yvJWhmqOv+zHu3njPaqbrBJKay8HOdSQ5cyTHUyis6tsR/3ihx+bAjBzU5csFQgm/+ZlQntwnIFkXdjk/yqMfv/AGv8YdzefYaoU6Fy+NkKYOFl0PjATxKZKiEgrbutlwKDywpnO/wSIn9GtuMjp5tGT9Zi/NXLlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035154; c=relaxed/simple;
	bh=RuEom/lK2p6jCIYftMUeDyWgU25OW1CDCrs/sa9uhqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjbWJsIKKhZFkZmaKatYWReFThiblPXGDdZy2mDo1OFKA9r4p2GAihF6e7ye5s+P57w1NIQaiY1WV95mN2uu4zQuexF1MzBHBS2IfgAIyMr9wXvnVtTVKosNsdfCOiBHcI/cC8f17hSHKbvCr01gSjcFaE4CQnQjmt9JD2vY4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeWOYOH5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea2820efacso370321a91.0;
        Tue, 19 Nov 2024 08:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732035152; x=1732639952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuEom/lK2p6jCIYftMUeDyWgU25OW1CDCrs/sa9uhqQ=;
        b=SeWOYOH5g0M05w+aoxvbwobtgl4+FP1FME26PBeqVufV/sRcIlH9wWRs+gHLnqBTZ6
         ouk5Vx0p8VLy9nz8LsswHGg5yNeuabXbbThtBNyUprLBnupYze6lUJOM95jcUxEi9uas
         GK+/kGupavFvy51vUWCbXTRsarwLGoBfggch5hGtCvFOUXsa1LHoAvyH/jFIP92c8FUW
         X52f3bxPMWd/DKmTGb0I/cgd35jdtADC0w47DBl8ntAP3Suwiathj1jh6BzIPyHTkwU2
         t/FGrmYD+okLXDScidXN6KfDNRE2FSUqVxlXnlW86GSG6CK+IszpzvqRt/gYgG0xjcFU
         xJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732035152; x=1732639952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuEom/lK2p6jCIYftMUeDyWgU25OW1CDCrs/sa9uhqQ=;
        b=sXHZp7R1QBBiVTZP9l6TUHtEHo1uRBrbrFty+9XC3DTg18Z3yiWLxsLdRDGEYanyfu
         0XBIH8v53tXMjkgPpWRyc/ugnx5eHJWOCbBPrd/Uwv4SpHIeZVMNw8PgQXRWq3xEpJN+
         dbynBo4X74fc7Ngsj0mOITX9BQUwo0s9ypPbnEviH/mXAOF5fWRg7A75GzGjBy5brVuN
         odtIe09Y5ccI2Rgl3nbrJ1PIr6kpNLY7JgOHq1eEQHQnig8fgTDQqPP9gUSvnr1inmpH
         +hfqksdUptUb9kDthpwKXzgDkm2wQWofV+ZsrFSHUG+TfL6BCK6T1NebwgMtZP9SAVhl
         13wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAwxf8cdI9XaynjOOoIzqHw98SBMrkbHJkwMmEr6A9osL1FolsPzU2INGN5Xhx/XyGQXAwmPIlTXP0QkQ=@vger.kernel.org, AJvYcCWfHPnEe+w+P58/sZJ6/eRqhD+1O/LoDXK1My8+wyHfPfX2q6ntARgx+6wwNYTgkCUi93+4HjpgIBMDUW6Njak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4P8zX8A+XAaswn3FK01P/+7msgAxoTT9gEzMv6f/11/YrWnx
	YZgbvsA6019ej28F4ZhHeNwqK81xkfsEgy6gAMgMFKQxu7S7DQeiv3FeUhBqZULqhg8hlB7ddHq
	ebAF50hENP5bbkX28cK67TpBJWOY=
X-Gm-Gg: ASbGncsDoBclxzeM+HODNEe8d0+vT36A1Xf8Q/arhmvTxubbjP5s4bLksHvABaVWCsY
	Tv4Fzz190zgU1hgWxWWkGPOsUA/KYbA==
X-Google-Smtp-Source: AGHT+IE+83dCGWN/GL5FrxJEqREwHjy006RhoBHIhH+ifYMFu3Mb7xIx47E5jztv6fLxHlmGRIUTcPuSf+AhPQfKJ54=
X-Received: by 2002:a17:90b:1348:b0:2ea:2bdd:4433 with SMTP id
 98e67ed59e1d1-2ea2bdd4631mr7875435a91.1.1732035152300; Tue, 19 Nov 2024
 08:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <20241118-rust-xarray-bindings-v9-2-3219cdb53685@gmail.com>
 <Zzu9SzkDoq_1YQnJ@tardis.local> <CAJ-ks9mKArX37VzhcyymDoE-MsNxNcO8VvP4n3Xu1mdfOKiuag@mail.gmail.com>
 <CAH5fLggL7MTLVv2ym_tCCKH9hQtL=GpTwXjDUQzKQX9UdT7SkA@mail.gmail.com>
 <CAJ-ks9k4upcSfa2HXaMrtDJ37eTNc-ZiKZdcLuEYSnWHL5Bigw@mail.gmail.com>
 <CAH5fLggBZsarrRkZ1Mf5ND9-A6kCc65QRwhUW5X9nQxRJUOXrQ@mail.gmail.com> <CAJ-ks9=ZDRdh1UzBpV-ck2v5t4a3-81vD07Ndfmow4ABmQvJmQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9=ZDRdh1UzBpV-ck2v5t4a3-81vD07Ndfmow4ABmQvJmQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 Nov 2024 17:52:20 +0100
Message-ID: <CANiq72=MeVViwfFGaj7MFev0ZOodVo2dJqOeHiPodHjN-xh9TA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] rust: xarray: Add an abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 5:51=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Sure, I can merge them locally - but how do I properly send a patch
> that relies on both to the list?

You can mention in the cover letter your prerequisites.

Cheers,
Miguel

