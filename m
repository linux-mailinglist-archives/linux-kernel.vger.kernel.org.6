Return-Path: <linux-kernel+bounces-399249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD39BFC86
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A537C1C21DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798AF4AEE0;
	Thu,  7 Nov 2024 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imVxp8Xb"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58619179A3;
	Thu,  7 Nov 2024 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946431; cv=none; b=tiDi54Hx4bmplj8e6e+Hc4XZyzPEhFv0emQN8t4RorW8+0uXQ++T8zitHFluWe8V+p1SXUjKiZ3OFGiQ6yFJRhNyZnzrA4DSFHdOFMZzmCwQ6lcqzOV8hWJfrCyeuHSJT7wdxLdHmqlJ1F8Q0aFsUwhxKKWe/CKhVF3DVDYH1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946431; c=relaxed/simple;
	bh=fHs5q4k5rq5BftA5sdq7a8kaK37gZbgEBMtkn06uELA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8AHS0eBxDteBogg5RZqYrOBQoASnJIyfanZjTLkH4T04DZd8WnXFpk80o2i6oNH9SZ3L1jUt2aQiySCj5+t5gj44s8PXUgLIW3ifazchzs/zSnkb1XdgWkOXHQyIyxdtg6vf1XdLHXsQO6Zu0kGC8F4Qb/DFBQaoZMqYCBRy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imVxp8Xb; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84fed1ff217so1126499241.1;
        Wed, 06 Nov 2024 18:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730946429; x=1731551229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDB0vac9yZpc1+41LDWOLCqJ1t14TIX2ljxErRQNdMI=;
        b=imVxp8XbJ+wA2/rRFMtNRhhCNjMs+yRrzzORtzLjPghRHItO5e73ZRMZSTdx7gnPA7
         WkMePWsb8jXlSsATPY5CUeYXtO2bmXIt7vkVm2b/nNbTkggR3Fl9Ex2wdfJxPitzdAlG
         4YRWy78HL1UMtkL6up4sRWJBjcUaE9xHpK7Gk+I65RUhjH/jYDaI7TS0Nn7rRC+tVt2m
         ggKtPKaDjwsg4U82i5LAQUXKqofRhwY4bO6JpgwQFr/KidvF/GGUgh88aISPay795Qqj
         tg2HZXLYGljeVfjkAoafKKzdXwBgvw2gOdTu/2Zr/IDdCzcytG2V1tfAW+yHKqdvhUNU
         vMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730946429; x=1731551229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDB0vac9yZpc1+41LDWOLCqJ1t14TIX2ljxErRQNdMI=;
        b=bCvj65DXZBhZXr8x1nulhgPt8lTf8yuFCiwIb1+uUfUY/i8Tw6DBQb6iMpBhHgNe/U
         PEoAWend5meJzX/DxLZQDSBvMrrA0xV/RO0MtLf02pXPy7ugnC7UzCNrgTTHd7bkHiuk
         w1FDrJKAqExC+BmHm77u5DEOe59O2hWYAhLTh0O3UnbOLoD2WGQCqu7mqo/VQUwNjG8C
         oavlbxGFjR8BP9ps1kwa5a/6emG9KJz1XoI801XABBSGtih8FkhNcptMTQmvi8J2X88u
         dkfJP7fofNusk9Ru6b5mjNOkJ4NfquviA5ejLBWYH1u/abx138M0ase/1unbTOVqqzMM
         GXxw==
X-Forwarded-Encrypted: i=1; AJvYcCWcqn1dpOLHU0QkrGiQkOv9z4MoKmNBszqBDWtar9CZWO2MvYA1WkuPBl6pbOarXqBsJi1yjCYi1Wii7GH8+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2BnMIjga1OlQ+TJVM4AJzJjw7hyQFSJAHK8TGHDM/ZnPBAhp
	woU2ZKaTYiNBSQJ1eE6F5NXlGkNYfcWVSgjjmJlosWOcH6a4RGMatJK8SQoEEoHLq3uwqZ+SLVz
	Y2Vd0AqL9BI5x30aLvkaH9pfnQGw=
X-Google-Smtp-Source: AGHT+IGR1uyWzsnFIIFD2l2Z6YE/azZSGlygVbco85VucmCYuQpkaeZfeEX1wZ8HeqtFCnH2L+sTVjza+FwdPrIaoDw=
X-Received: by 2002:a05:6102:41aa:b0:49c:7af:2ec4 with SMTP id
 ada2fe7eead31-4a9c24eb93amr1423192137.13.1730946429122; Wed, 06 Nov 2024
 18:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105022143.1087112-1-alistair.francis@wdc.com> <CANiq72=L=CMUBu7jBn0H2Wb8vupYzOYFrSQ_9gyFZj_w2JU_uQ@mail.gmail.com>
In-Reply-To: <CANiq72=L=CMUBu7jBn0H2Wb8vupYzOYFrSQ_9gyFZj_w2JU_uQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 Nov 2024 12:26:43 +1000
Message-ID: <CAKmqyKPv9DrvisrLOWX=i2qqKbRbNz40__FSGm6piC_0y94m_g@mail.gmail.com>
Subject: Re: [PATCH] rust: bindings: Support some inline static functions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	ojeda@kernel.org, boqun.feng@gmail.com, a.hindborg@kernel.org, 
	benno.lossin@proton.me, aliceryhl@google.com, tmgross@umich.edu, 
	gary@garyguo.net, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 7:32=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Nov 5, 2024 at 3:22=E2=80=AFAM Alistair Francis <alistair23@gmail=
.com> wrote:
> >
> > If this is accepted or at least Acked I can work on removing the
> > existing rust_helper_* functions and convert them to be auto-generated.
>
> Yeah, we have tracked the feature for a long time, please see:
>
>     https://github.com/Rust-for-Linux/linux/issues/353
>
> So it is definitely in our plan to use (assuming it works).
>
> But, yeah, we would need the patch with the conversions, to show how
> it would look in practice (i.e. comparing before/after etc.), i.e. the
> usual kernel rule.

Great! I have done the conversions in a patch series here:
https://lore.kernel.org/lkml/20241107020831.1561063-1-alistair.francis@wdc.=
com/T/#t

>
> > +       --allowlist-function crypto_shash_descsize
>
> We probably should put this into something similar to
> `rust/bindgen_parameters` (and remove this variable).

Fixed in https://lore.kernel.org/lkml/20241107020831.1561063-1-alistair.fra=
ncis@wdc.com/T/#t

>
> > +       @cp /tmp/bindgen/extern.c $(src)/
>
> I don't think we can use/assume `/tmp` -- we will need
> `--wrap-static-fns-path` or similar.

Fixed in https://lore.kernel.org/lkml/20241107020831.1561063-1-alistair.fra=
ncis@wdc.com/T/#t

Alistair

>
> Thanks for trying out the new feature!
>
> Cheers,
> Miguel

