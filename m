Return-Path: <linux-kernel+bounces-576074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39982A70AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFFE163372
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B11F1527;
	Tue, 25 Mar 2025 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkxxXbog"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629B1F0E59;
	Tue, 25 Mar 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932112; cv=none; b=hAbCqGr5mepxy4blXOu+HQ/Os0IUBe99qSLrmZXabdpZpF4pa+Wv2SfWgL8NVWPAFqt9rHTOtvBYQq11UEBJDpg7EBk11zoflGsp5Wh+DUiMzRyftp3Z32M77s+JpgWMRPg7Q1NvuVOALZWP9nEFQSNHuyBU3jW3wFjfkqOzmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932112; c=relaxed/simple;
	bh=kWRz7TnGEyqbpdoqqbqwf78f4CQUMOrIDZK4ebHnEkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2nwpS8nOPssCcxy8OAIACxXdo5YV02jk5lExqnlv71wI88I539kZsADfypPQQHEmk0NT6r/sgO966LeLlCuakuuCs9grSeOoHh/cKwjjjVpu5T3P69FYMXZzNOp1R9O2PamrzuW5Ow107DqNsr832xIgm/+TYDjP1lDuRM3/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkxxXbog; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22403c99457so14007025ad.3;
        Tue, 25 Mar 2025 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742932110; x=1743536910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8OkNb0Gk1huvCdNeb+R5YeTaXEOuCO6fGN5IzB1KVw=;
        b=nkxxXbogKk6zfxQRBGT/6ooGRow+99Bws1svl8U825Y5g7wOi8gSbhuhklSx36TdnJ
         mMnWqB1tGvjG5swculswOyqX4UpVQ5gw592PCx5STijyWIgD8Ecyskg7ruyIcy49EBwP
         Y91lbg7Gjlac3CiqaRfLBn8C3ekjdq0n4qmf3jd7LVGlLzOTiGQ3mOVq3pa0A6tKDnKg
         nPloQiJGnVeiHJ6YzFOVKp2X/l9R6m7PfxaJItDd18xYkzdL1AWvUHCLFHVdPJkuhD1e
         81PtvLuPyqgWMltHvcZBuB21p5EalG1+XxXMLC8kktgHRJ/c+nE07fUHfvURNkaKLrD2
         4jwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742932110; x=1743536910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8OkNb0Gk1huvCdNeb+R5YeTaXEOuCO6fGN5IzB1KVw=;
        b=vIwA0Up8mowI9F2MOCbywK9fYOR+2Y6CQMIrnQhhbshIh4SqdNB2Jkqyi6gMRJVBgK
         FDpUNuaetLwXqtzyEnU0O/AdvsX+e11ai4Qm1naJUWDo/LbVsGQDCRDR7hyLAjVuKi5D
         qPAxqDTSI+SdZvC5HYgwmhWmlSUjXfVANUiA4x+IL5FpkkG7mewoZGQbrJRomS3/S5P/
         FxLMgdWVIrBFHRpdKGkF2rpSK0jEPLfw8dlu2wgRlB2RXIs3N5Jp0Pwj9Z21N4w+ZSt4
         guPbJY+i0Bvq0Y2frySkqawkayK6twOfEeKi3Ju2XCWXNRVAUSlZoEjUx8dKYlgqASX7
         ZEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbq44M7KdG3E67V5dVsgfkJB7swCx0kQdOitoguagBuWNAsVTfZYGyxZJOQGSLHBuEZWGnK6PbQALSSEd6S60=@vger.kernel.org, AJvYcCWGzAA1nTSDsnyd4Tpa7kJUJfLyMwRGOF+OhDOXAkcqArnXw72dFfaz3U8yPrAktP+kPxpa/6f6FzW2NFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhVp89mjCo+o62+J67iEOnUF3INza/SmjMMywdQdzJQEk2SVO
	q4rj2u/OZt2+UN/ieIFicyoVjku+cxcyMuau/kfTwlZ34usR+yS34zfGBoK/SqCRAlILcOMTGSz
	OLp1wdKqEGMRl1kLqLqatAIapUHk=
X-Gm-Gg: ASbGncucvKdN2e2iC8p+O3KD8k8nNvLDFzokpoPMplpCKKACqQ+oQv0RI+Gb7I1FOgq
	WrUt79ewg4EMisZhxPNaTcHpL5dPoVWj64m1ngsN4f7FgN1RA4CFWLw8jpIs1zs5vvn7jC4CDkj
	kWMTNA8F06SJWRfsj6N0OlkH1zUA==
X-Google-Smtp-Source: AGHT+IFxBWD68KB8/HxS5e8dGM3BB7KTxo4N4mhnjuZj5L+9yyTC70mMnIp1cyTclOTT83cY3hEXidYZMRLFX4HVM5Y=
X-Received: by 2002:a17:903:234e:b0:223:5525:622f with SMTP id
 d9443c01a7336-22780c503a9mr99495195ad.1.1742932109937; Tue, 25 Mar 2025
 12:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325184309.97170-1-ojeda@kernel.org>
In-Reply-To: <20250325184309.97170-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Mar 2025 20:48:17 +0100
X-Gm-Features: AQ5f1JpNyVdd47wH2I_NWPgt1x_uShOAv6Q_Kz6PcSYhTfdjyZuGqcfgDJh1oE8
Message-ID: <CANiq72kWumOHt=VgV3mb2G4mOE3bCVUCUrKdjk4caFJPVCTBbA@mail.gmail.com>
Subject: Re: [PATCH] rust: workaround `bindgen` issue with forward references
 to `enum` types
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 7:43=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Instead, let's have a section at the top of our `bindings_helper.h` that
> `#include`s the headers with the affected types -- hopefully there are
> not many cases and there is a single ordering that covers all cases.

By the way, I was curious and from a quick look at generated bindings
lines matching `type.*i32` for a x86_64 build I have, I see only other
three cases:

  - `key_serial_t` is not an `enum`, i.e. it is correct.

  - `fs_value_type` and `drm_mode_status` are both `enum`s, and they
indeed suffer from this issue. However, we do not use them and I don't
see any patches posted for them either.

Those are good news.

However, there are also bad news: if for instance we actually needed
either of those two latter ones, then we cannot just include the
header that defines them, because that header happens to include
others that in turn use forward references to that `enum` the root one
defines.

So in some cases, if we start to use them before we have a fix, would
require C header changes to avoid the forward references. Thus, for
those, I think it may be simpler to instead use a cast and mark them
with a comment so that we know we should clean them up.

Cheers,
Miguel

