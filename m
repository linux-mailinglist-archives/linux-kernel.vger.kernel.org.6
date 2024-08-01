Return-Path: <linux-kernel+bounces-270941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16981944765
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400A4B24C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC9F15884A;
	Thu,  1 Aug 2024 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Igzvm9hv"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE216DC35
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502990; cv=none; b=PZu3sQOAb1G6wrFRGlIkk9Wd+lkVrQ7/vYKWTTPvopx9WzFAEvvQCKtwi2TKX+8JuDmc2sVQ/FWiTm9AmyLbjs90Qpls1ZScpBLXlGtE0mmPU9t4weDntNZBtcYOqbPCrSJy3vc85Ais5FG0Ga6W8UD73xNQBoTzwCG/B4OWues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502990; c=relaxed/simple;
	bh=3xs7xgvJ/ONhnh43H4LdGjo7+Y24b3EIyiZ2SWjz1Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCIMWBZnfBhAQIHkwQ0vNnFRY1FwYjVla67JpryKwhNmonEoa5JOKr1FFHr01txRNdCDnMHsvptHP9cflPjOYAOItQrDpp9otNJ+wN3CbbqAaWc37m7w8nYV+uaF+wkf7wtBX42b2Liw5HElM1f6gxgD82gj4O0gF1bstQDPuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Igzvm9hv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3687ea0521cso4372171f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722502987; x=1723107787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xs7xgvJ/ONhnh43H4LdGjo7+Y24b3EIyiZ2SWjz1Qw=;
        b=Igzvm9hvtlipIDMxSI3A7raeETCRxGuC3odauXw7qz2/WJZZymvQAc6qB0EMWQU5cE
         tIf3ZKBupjTPsm7R4L2Z5MJLjThKYdc1mfMwg4Gj9IVH3S1WQ/4Lg76B7j8Ma0KaPNXj
         b8yOF+XqjxwILGqYIsvMiCWD4fFJiUN6ZuwbibA/WZA26ZFqd4e2TlCzwVEd0AfJikjz
         RYkPr61b0qbgUKy0XjZfO8HeMdoLgE5ePzSnS5mbtyUB75qOawzsJ3S9655QkKv+i9hR
         36bUEjSDIhZz8Rg9bZZp9J5Y2y+ABYYCsiL5sW7NkmCL2/NCESto2G4lqDAqYpAWZQcn
         jXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502987; x=1723107787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xs7xgvJ/ONhnh43H4LdGjo7+Y24b3EIyiZ2SWjz1Qw=;
        b=v4LiVswJBCGm97ljXFXL/kPzCyHsX5zXaA1y2lV4jhVkd3Y3niTvvlZ6a9Zd9c5WUY
         zy0GBbYBu+HD8T/BlhO88XsP7gRAz998eGfYaToYHY1HlR3XAdiYbhFWIuvjhCjSHMP0
         H9xAsmsrr8dcbgXrrYp9QwqXc5m7r5zkNB8iDTVqS3gcDBUSP2bbi3t3k8MPDJSJ4SiY
         nVGPDBYTMtoVgtvMvMVwGJKx8+EggfJ8WL0GMzaO6V3r211U/dWgnbOsW14A/nCjpxC9
         1n4wydprI+9HWuZHzfNfSavTO/zfr6knq3XrmbhSPCi9g9k5RCs1PtMCDJKdZ5WpsTcf
         2oGw==
X-Forwarded-Encrypted: i=1; AJvYcCUh4QmYoRwAvaAmiZtTM13Oqy5xJSHAx2dPccdBozOSW+ZNvh2PcYmRSI/gq500f037atyxkJi5GJclu/xCwKaKGAfgunbHTfHDWSw6
X-Gm-Message-State: AOJu0YzJaOdYPk/9W5aUSAflchCCNkIf3SNa7W8cHQpvu7Zh3KZkAsVN
	JIK29becjtKiCTSQ+4tSwuwt4Uz+XDuI0CpogaBuPy0JxVEz85rhzrEG7WMXkZckMauLVDI6DYu
	ezQvhDe5Ao1GSir39ve0O8pXPdGIGNIK8PHCA
X-Google-Smtp-Source: AGHT+IFMKbPhev1pQbCoGwkpCVbTUvuV6UuRjh5+1mv4Dcxtyi2gl8tnKx9GqoaBnp3ls7IZoo/JGaUoUdQLNK+xSGQ=
X-Received: by 2002:adf:f107:0:b0:368:7e54:baaa with SMTP id
 ffacd0b85a97d-36baacbd019mr1494681f8f.4.1722502986680; Thu, 01 Aug 2024
 02:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com>
 <20240727-b4-rbtree-v8-1-951600ada434@google.com> <CAH5fLghFv8uYGbfjcjtxCET54xG06=Ck15fmoZQJF1L9S=sStQ@mail.gmail.com>
In-Reply-To: <CAH5fLghFv8uYGbfjcjtxCET54xG06=Ck15fmoZQJF1L9S=sStQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 11:02:52 +0200
Message-ID: <CAH5fLgj=Kyk6qFGOxOXsA9bM7dMYhFO+NZefW+UyiKUkL1hyiA@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] rust: kernel: add `drop_contents` to `BoxExt`
To: Matt Gilbride <mattgilbride@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Thu, Aug 1, 2024 at 11:00=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Sat, Jul 27, 2024 at 10:30=E2=80=AFPM Matt Gilbride <mattgilbride@goog=
le.com> wrote:
> >
> > From: Benno Lossin <benno.lossin@proton.me>
> >
> > Sometimes (see [1]) it is necessary to drop the value inside of a
> > `Box<T>`, but retain the allocation. For example to reuse the allocatio=
n
> > in the future.
> > Introduce a new function `drop_contents` that turns a `Box<T>` into
> > `Box<MaybeUninit<T>>` by dropping the value.
> >
> > Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-32=
3e134390ce@google.com/ [1]
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

(We may prefer to pick this from Benno's series:
https://lore.kernel.org/rust-for-linux/20240708205325.1275473-1-benno.lossi=
n@proton.me/
)

