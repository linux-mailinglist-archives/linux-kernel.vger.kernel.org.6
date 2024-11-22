Return-Path: <linux-kernel+bounces-418439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64FC9D6190
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD5BB20E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AB31BCA02;
	Fri, 22 Nov 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ezGqiQZ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525157CBE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290854; cv=none; b=MTldBUqpQdXPSLTLqJe3RbXAz4g5+pIojwcS0J9ApWE31u8qOGHpTITC93I0mai4TnDuMFF7b2GQU/9U0tau8uvFqBf1izshCdMJV0RF+mGHJLwxHiRqna2pAsKovkONfs/l7fr2sJAl98z7jPuBjkVhvKLoL8xwifFQWLU5VA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290854; c=relaxed/simple;
	bh=QVq5KFgL/UUdZVEO72cnRHkBo+D4+LvJLmuOecN8AIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSnscbIpdiKAMiix5GXkHFhJ3xwfZsH/QpWK6y7Bmy7RYHUzP2KU+pMz5Mq3kfWI/fyl75lLcfxwXfRc5eP1Xi599dcbUqw2ysrCTwBMDGFbKgAaBha3zfoEp2FbHluy5sL9XPGMuDQGoQ/i9ygfJoFaF6j05cqV5dD3CvZ0uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ezGqiQZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3823eb7ba72so1541737f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732290850; x=1732895650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHBTAP93QaIBDXulWGODeivaCePNLj+7NuQRGSnsUCI=;
        b=3ezGqiQZW6neci7zy/DKcacep2NFwEUOp2ISc1VmFvij8A0+HaWCTaUsZsWi0iiO9B
         +m87lv/+NSPIkladkCJIYp1ru1odYNiOE41umI1Vt20K+T+TlsPjfO99b+A/+JaykcmX
         ep7zP84+ffmctu2r3n2o2w9IXxXoYr3AnR9jH4epfRmGrycTOoZ2dXuUED7YvyynFu6U
         aNxDH7OTcnDZoNYOcsgfHZgXQ4sas6oY28xsL1LfnkgrPsrDw5xxHiXcDZbBumYK1lyh
         df3+eSnwTaFTNb4qWAVUAu9OeyhJW26bH/hEuGVGPeeUbCgyboilN2LTotgqdTnTki1q
         mHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290850; x=1732895650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHBTAP93QaIBDXulWGODeivaCePNLj+7NuQRGSnsUCI=;
        b=U6+ysWte4Ot0NfxOC50s/8TwTX4aagIWmaYLgbtHE5KMyF2Z2p0Kpye54zLEc0afto
         bzMPr7SRn+TyO1U+mCrRxErY3brWhAc7J4gbvF8vU07d2tlGyUdJPgS83ug8cFDMkIsq
         u7+8BjfZSWeVUkTcVoyPlpiiotMtE46LyJyDhebMxUgI34Wv9wKLBuqz/KGRmWEoGqcK
         yuea5nqNhwJ5aHJFKKPAfLY5t69IZkq/pAbbTtMr2IbK5zD+SOscsraXKoh133pWPPAI
         J4wdoELB/4BINKUxIY2f6YQ87LpisW6hNRpxOTadzo2am5YZKn85xSeybEI/J+ryVWL/
         5fUA==
X-Forwarded-Encrypted: i=1; AJvYcCWLeru8hUO6QMfNI7XK/Lc8DwcmpDnTZwscPQJdhEmjOjc0utRUM/Z8cOfywfKKAcLWHFoez92miQAnyow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoEqRryQ5c0S1bYT9GqUPPESxnfDMYFsVmQTyFtJ9lnbcYuBWW
	OFezybNKr8TLcYTWBVaQdb7JQH1WJXVnOr8w0xQEs3L3aaVeKjwroTKtvCZNos7RuER2/mT4RCd
	Uqb7qP+MhUwCv7RWOkjqiYywT/KWPqOc9d5Rt
X-Gm-Gg: ASbGncs7YVhQEQJkQEQbKivk89eLcBbIBzg2T/vdnR1ItJDQRoPbiUdgQjPxrCCSUv5
	6xf2iLPWnoSrBlBo/T2kfRfCfAaWsOxXx
X-Google-Smtp-Source: AGHT+IEcuG0i0OmqqiSqqKVO0WuWikpbjy8X2Ivl9jcnoCFeKPdNRQPrawD+zGaNnWE7FPTBKZ3WMQbtEUO3d5UYyj0=
X-Received: by 2002:a05:6000:184e:b0:382:2242:7a8 with SMTP id
 ffacd0b85a97d-38260bcb00cmr3039059f8f.40.1732290850040; Fri, 22 Nov 2024
 07:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-8-7127bfcdd54e@google.com>
In-Reply-To: <20241122-vma-v9-8-7127bfcdd54e@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Nov 2024 16:53:58 +0100
Message-ID: <CAH5fLgguMwp=jfSG=BSDWxCVO7cd2MQVfLsFLH2byDBJVZbOfg@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Introduce a new type called `CurrentTask` that lets you perform various
> operations that are only safe on the `current` task. Use the new type to
> provide a way to access the current mm without incrementing its
> refcount.
>
> With this change, you can write stuff such as
>
>         let vma =3D current!().mm().lock_vma_under_rcu(addr);
>
> without incrementing any refcounts.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Oh, that's awkward, I was testing this change using a config file that
was missing CONFIG_RUST=3Dy, so it didn't compile the code at all. You
need the following imports for this to work:

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 103d235eb844..60659076997a 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -7,7 +7,8 @@
 use crate::{
     bindings,
     ffi::{c_int, c_long, c_uint},
-    types::{NotThreadSafe, Opaque},
+    mm::MmWithUser,
+    types::Opaque,
 };
 use core::{
     cmp::{Eq, PartialEq},

Otherwise the code should be correct. You can fetch the tree with this fixe=
d at:
https://github.com/Darksonn/linux/commits/b4/vma/

I'll fix it in the next version, but I will wait for review before I send t=
hat.

Alice

