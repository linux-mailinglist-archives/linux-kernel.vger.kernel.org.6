Return-Path: <linux-kernel+bounces-534246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F225A464A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CAC17ED5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE00C22A818;
	Wed, 26 Feb 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdtJ9fdu"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF44227EAC;
	Wed, 26 Feb 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583571; cv=none; b=dl10bRXPLH8qRo9g9zmSYA/w5qyfB5M66/l83OM7eSeBTBaz3t5sP9StKCM6Pi7kEdBLp1sL9+lVF/biek24VB/BV2HUdrIH4+lQQlNICtUMdAPJYkvJ05rQCjwTOVqQtW9K05LIudjLPs8InMjiRxDOVMV5pdY8WSA3oIvZ3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583571; c=relaxed/simple;
	bh=8XjmsQDkntEBgJsjmtnOI/sauexv/Yv5JvByjw8HAjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sta0iNZLkvMO/CL3M+qPLTxzFeSmocWFH8ksPAZDCLhBroj+zW1TjTqDSmFK63/XYxVPTBGKm3UDUNNtRi5vGjAPFLuO9qBreBJzIvotQ2qZc3zTISk8MS6/XC2z4TOWpUNxvjovXJavHBcb/Q3KXa78YbI9A5ymfY21yoyK82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdtJ9fdu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30613802a04so73884331fa.2;
        Wed, 26 Feb 2025 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740583568; x=1741188368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XjmsQDkntEBgJsjmtnOI/sauexv/Yv5JvByjw8HAjM=;
        b=MdtJ9fdutG3E51vEcENVqfxPXCw+m8pZFsrmTVWuBxW8ZKuVErwCB4IucjPPPrHo6L
         gA3LjsKaPAcmGcF0kE1q6XYCmnSdV0BO6qVBRMMUDh48tOfNDbPTO0ghIIeGwl70eBhj
         wAnsw7zfYnhwTIY9qeC7D2no8VrMcb7srrFmQ4DMPnF3ek4HPqxFP9WaLxlZkzfW57xe
         owIfDX2KePBipKWIeeXXu2G2LV2QC6k0VI/PRetzylepy02cAu6RF8nqCOGnxUP4XzsM
         wcRxP/uqgDqPj3ZK8GQHe473zZ+6avztaCroUTWemLxJo2ojwc93+z30ROCTdKqqWuUh
         fJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583568; x=1741188368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XjmsQDkntEBgJsjmtnOI/sauexv/Yv5JvByjw8HAjM=;
        b=t39v/nQZwwdhXhT+w55M64tmcBd2CJVrCbGU0snAWjVSk5XyQykiERwFeYBmG/QUac
         hUTO6FiYNSOOik8noeI2HDVr0GM5M5FWulfhJBKT4FQdFgtctQ1T7L/kRusSMqhm93YM
         bPJeJsrb5UqwHWTV3G53JCB3Kp+jpNUJBqWVebe/xwW2pnFdGgKN6uUA5OWntdExYitT
         t++9Nvp5v65IAacdLXy9AczyGQso0vYROjT/Aqiv9f8gfQV0UH+6TO+5a8MLtepn+9G1
         fF/0gfLQXvEpK70AUi++sOmIPEnAIvOwhpNSRra3EOHzQW9/tKthn2jjv2VcpCwI35Ms
         mlCA==
X-Forwarded-Encrypted: i=1; AJvYcCUJnUEAn3ofo8K/GWgAkmrP/Ytcfm4q0spVK0n77c8daA1FXur04NtDW8rVHLbnaO82GRdBmA6RXjK0Qxw=@vger.kernel.org, AJvYcCXR2OpLSjSEIE/A0njuaxYYvBRRwqqZEDR+iG5/NnQCcDjiIQQgl8v9nwK+9CFbCJIIHmtXXgbYN06Tx6V5EFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/Idl+WlbTqf2llBn92fyuqhHZJK8uIBTiKCk0R/5bfsppWcm
	wZu9ykAG0a+Y8FuAvYv1m5EQAMynywq8EetgaHZYJHpvsXLHh9YHt4im4aoVNMhiSAlDnUT9rZi
	wA/4muk0gt6KPkjiv4ucO5zBJAs0=
X-Gm-Gg: ASbGnctd1HldVzhLNjqwLv2yJvy1zpucaXDHi3sTNVyuc4xZsAlEoFMMuQxudBELRtw
	6B7WXTl79qxanf1ZcEfh0OM/fHe7jH6omjXwyPkS30suHYGXsazqygxOHP1+2sE79/gYdJqcHfD
	hRMrL8udE2GOTE+RSVA7POpTs=
X-Google-Smtp-Source: AGHT+IEo6F6Eub/MI72UFzKRiuCZYn7Q0f2CDjQaKMP01k5i6AFAAlHiQbutLSWJZ4jrKbFdwcsBady9hy4qonBzAzw=
X-Received: by 2002:a2e:9f42:0:b0:309:2653:5dc9 with SMTP id
 38308e7fff4ca-30a5b217b39mr88573601fa.37.1740583567445; Wed, 26 Feb 2025
 07:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <uCkPc4oYMQYOO_OIOr9hdmmD0i6lpFa28yuPw6NZIf9H6UXHOExwYhoeVH4ZTnxI9hRjHj9fJTqNXMeDptF3vA==@protonmail.internalid>
 <20250210-rust-analyzer-bindings-include-v2-0-23dff845edc3@gmail.com> <87tt90h5ir.fsf@kernel.org>
In-Reply-To: <87tt90h5ir.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 26 Feb 2025 10:25:31 -0500
X-Gm-Features: AQ5f1JoTfQZ-CLXLy42Yr5tjd69WL_qJDULnWRDElET5BESGkBSPGXVB68dFLZU
Message-ID: <CAJ-ks9nDR8C3Og0rgVxKVxMUx678CYnEFgeUSxzFf4Ev9CVG9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: fix rust-analyzer configuration for
 generated files
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:21=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > The individual patches should be descriptive on their own. They are
> > included in a single series because the second patch uses a function
> > introduced in the first.
> >
> > I've confirmed this allows me to navigate to symbols defined in
> > generated files as well as to the generated files themselves. I am usin=
g
> > an out-of-source build.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Hi folks, gentle ping here.

> This is amazing, I have been missing this for so long =F0=9F=98=86 With t=
his patch
> I get auto completion of symbols in `bindings` and `uapi`, without it,
> no completions. I build out of tree.
>
> For the whole series:
>
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

Thanks for testing!

