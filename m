Return-Path: <linux-kernel+bounces-199532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2128D8835
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDF31C2152D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0885C137C2A;
	Mon,  3 Jun 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzZ5bNhx"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2B137923
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437172; cv=none; b=CYh7DOBRDZslvIP6v6s7+zyM8NAGZsgA2rQNfi5taATSLmepmmI8WQ/O2upq+HIV9AG3HUmF1ddCkFZbpTDHpkiHTrXt3n9z5g3vpT22ZqCN52k9/T7OVSXthg3eMz1bnjwi4tQJlubnSC80r4IL2KPt6EQTPg0DFkPTDEm/3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437172; c=relaxed/simple;
	bh=m0FweyHdPSFpIkTfVZW//pFgcOZYHKV+wSHlMJh9TJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBX9uUrSFh1nwOQDlW7fRB8uPA0t6iHuSm2FSiEUmzoGGoJiovigR4P+NuwuHx9lpFdIbR+BsmKnAHAE8yG88yXcDwg8+8ixOEOJp9XUeIQdNeBQXY1jpLfd5nG/IL593/Pu/eLr50+ZtAGtwxeJRT1KOFGMyxL5DXheKDTTqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzZ5bNhx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35e1fcd0c0fso220486f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717437169; x=1718041969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPGBLbNhfIBiQu1H48kkSjUpEcH7DNN2Yir8GhdMltY=;
        b=HzZ5bNhxn5aGtQkw1VuBDyFvsombNwZoKhNq3jUBc9lsSZ9nbpefvKWd3uj528Cjae
         diNPSTowrSLSMz8xrHqxZZr+ljdmWil969mX2nEppJW61aDcDfZBFQGoKonQV87umNvc
         yxIrJTtn7IxRNbsN/Npu/XfunGnhB/nG1JRloGrjtBwOpLvdQVWXbs7pku8HpmSgo8Qt
         5Eht74+1RlWgRg9b4c9J2fRJbm9K98LYtYNfhw7kNJMxtW8uWL6JVCKCRf48aUerv3/Y
         nshXBD8yaT1iC6Y7RJ3tUvCq72enV6JXXIBYCqXlLdh7wAYW31aCEJWAvJIzK+LLOE+K
         Znjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437169; x=1718041969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPGBLbNhfIBiQu1H48kkSjUpEcH7DNN2Yir8GhdMltY=;
        b=K/GSclWZEIt/Za6UyXHcSX/PG1l99TSoNQWNyhOotNRqiwyp387fnaVdPxd/p+uLbH
         9CyVf5mDgBN/jrBsXrDUTlsv93zg7mg3j9J/SahvZMgtdHTxA7dj83lN60WSS7qFeX9X
         62PFVKxbxLqe6iO99EMhKm4yUfifhgn4E1NelC3x+q/CoZI+45LULc8zwIG1dStRYC7y
         0jhHDstcu6LsZrrZBLQCDujxGAPBJlYq+xlLiyMcmVFU3+aC4sFC1IOTw/tigPkqD0cC
         y17jaYTfgfVmu4Awth7NwNWMpCSsc8Rt5oo/C3PjxjPLTeiwgz3aApQ6C4RggaE/ksaU
         agRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLWPyygC1CSzQPBx11T6/UXrelG5iBpAw9FSH9g+YzoM3P882IiAK7YvZdKUZ0bbkfgUuZx7PtTBgqttS2V8gTTq2RaDPiCyuYZqqd
X-Gm-Message-State: AOJu0Yzb9Haim/g4P5xaEU3lg+T9zUhVDXAADDCYVzU0jm7celQFTUYx
	hSqmzbfOZeb2Z874QHktO0MSKg0eWYZ4pnOHiglOHfvBlHo15nXNIVarNIhwquwv0zNzjyU/L1d
	nXaxZq/I2PXENSPnAes51NbaZtYs7vPNFDSW6
X-Google-Smtp-Source: AGHT+IGT7vuNvV+/UZ3RyhLSvxAihEQitzlypLgGkLqd3nrZ7SFySLqLiMieU6ERiozMYwiGcYicOPgQMNPD0/zrwB0=
X-Received: by 2002:adf:ee46:0:b0:355:7ab:2a86 with SMTP id
 ffacd0b85a97d-35e0f285ab5mr6799341f8f.28.1717437168661; Mon, 03 Jun 2024
 10:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
 <20240603-b4-rbtree-v4-4-308e43d6abfc@google.com> <Zl4AVUqq8Hd-a230@boqun-archlinux>
In-Reply-To: <Zl4AVUqq8Hd-a230@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Jun 2024 19:52:36 +0200
Message-ID: <CAH5fLggfMNcuu0KD13_K49NBXXWD133BB6uc5ph7xQi0WTxBZg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] rust: rbtree: add mutable iterator
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 7:42=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> On Mon, Jun 03, 2024 at 04:05:19PM +0000, Matt Gilbride wrote:
> [...]
> > +/// A mutable iterator over the nodes of a [`RBTree`].
> > +///
> > +/// Instances are created by calling [`RBTree::iter_mut`].
> > +pub struct IterMut<'a, K, V> {
> > +    _tree: PhantomData<&'a mut RBTree<K, V>>,
> > +    iter_raw: IterRaw<K, V>,
> > +}
> > +
> > +// SAFETY: The [`RBTreeIterator`] gives out mutable references to K an=
d V, so it has the same
>
> s/RBTreeIterator/IterMut ?
>
> Also `IterMut` doesn't give out mutable references to K, which makes
> me think...
>
> > +// thread safety requirements as mutable references.
> > +unsafe impl<'a, K: Send, V: Send> Send for IterMut<'a, K, V> {}
> > +
>
> we can lose the constrains to `K: Sync`, right?

Either Send or Sync would be valid here, but almost all types that are
Sync are also Send, but the opposite is not the case. So I wouldn't
consider that to be loosening the constrain.

Alice

