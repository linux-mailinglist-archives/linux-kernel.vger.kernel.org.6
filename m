Return-Path: <linux-kernel+bounces-286816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF96951F54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5FC28686E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665541B8EBA;
	Wed, 14 Aug 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvAVUI98"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3F1E53A;
	Wed, 14 Aug 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651361; cv=none; b=Elhh89INvIzkA1CyP8ANqq4T79IS+oNPRgkGekbl8xLxAj3NPWfOQGVBc48ykttL8p39cfI0FGEiCvAXEkYVBGYkR13rdyZQshHv3T4071Do+Bjjpz//NhhTUhwLO80iorrD2+ggoLJm+FhuyptV41msEQgHP+TzRXa4kk4P4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651361; c=relaxed/simple;
	bh=PnaHZ21qHW7pHdJLDZgHh7MgU/es9ZF/4IK2R/DC3kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/0g+Cg+VC35+4QPnKmNmyG6eFMmVRztWmN2yhOv2gwWvMxtIr/ehF9eGoKYwg8tVr/tfnILip4ak5frnKTJZHm6ksdQIWrFp35vyQF9pNAYB04+LpDhWVXh8qdEz+Tezd8LEJLAbVJHPUVXk5qlBIApdVgTOeEM1wv+b+2lWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvAVUI98; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f1870c355cso371241fa.1;
        Wed, 14 Aug 2024 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723651358; x=1724256158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7DaJyWm74H8+0ptv93yKtRvc3RFiY3qs13u3YpRi7w=;
        b=MvAVUI98rfj2bkf87YOHMHecyLTs+Ytw491dzEnW/McPB69zeTAsjQSRKWh8Sm3Xuu
         yZnNVwnAOxPQEtY+wT0Rh15LIdYpkvf8O3qcmAtea+4K5bQdHLA6m5QCaBlJv2gARcce
         ybLPo2a863UyjckdLMiQvG9hnwp4kR+pmI6Cf2/8nzmbJ59+jrQj1kirbTStD4TiDawd
         vkB28QY6jvscT+QBqnTKlIW2qssDTTUYoTZQobphnoVZH0IBX1j9cBxC3rRbLExDB5ql
         lh307L5CaXii5iaDxHjWHnz1AF/FxJuS0JkC15ElkvGdoKR0QgpEGjV6TP0dA2hwuZi7
         saog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651358; x=1724256158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7DaJyWm74H8+0ptv93yKtRvc3RFiY3qs13u3YpRi7w=;
        b=GdEIspC3Ow+fSIxH6HzdG/6aAe79nHmNVGBTMyqt6hb4rV2ffByQZtu+LzzSxqOFQ6
         /hqjA2gEuo7lYA7cnnbrrw063UQQgBPQMj8xmX42uym2qQSmSSJ7aY/RixPzfBynqCSR
         388bX3wRTAYNKHbvvRRs+tDQPiinYB2jtmhC8agvkNW4TFYzEA0bOIbnMuV3Bovjtaax
         bjXJp86qvrRb7EDHf7FrH10ovgPonYhyLv8QX9nfO+8WW8D9AEpEOlRRMddjsiWT7+bl
         vXbM9Vxt1YD279cdgvA7G+3Cyc3OAGHAxgkS749I6YeZNCfMA89HWBvW7vdDic8104qX
         Rm8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXd+nzVuJPGk4pXgOBGxsgU1zx/1WSbohia5QRHjDApdVhtSR3SSsCHQBCZv+rTDP6UuNMN7T2U+9DHK4NKQJq6mbZkT1TSeYPIEKzHkpj0+hW+ybPdX9/wbKnBC5kJMNc0uqTVVTHc5Y3lJQ=
X-Gm-Message-State: AOJu0YwvGKrB68VJLeNX6dTJfqP9Zezd8gu899fHalYlCiMTBPZVTraN
	ig1KJFCUsdenODshwZfnEDKlWlhqqRcFNwoCLCT8ligyYATbHaiRE244C8Cls9RrlSuaG/3R75i
	ugELg9F1bEUXL8QWGFk6mtmgT1TM=
X-Google-Smtp-Source: AGHT+IHPEfjt4tSwyaQ+mFcJTrUDUfvWWME9N3uFHGKGWzymbz/YnxR9JdVv75DKZqWaQHTCC/TZWw0TDjzoorJheVw=
X-Received: by 2002:a2e:74f:0:b0:2ef:24dd:8d86 with SMTP id
 38308e7fff4ca-2f3aa301363mr18379791fa.49.1723651357378; Wed, 14 Aug 2024
 09:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-5-dakr@kernel.org>
 <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com>
 <Zryy04DvEsnxsRCj@pollux> <CAH5fLghsONUtxFPgD6vC139H-Uj5LDju7w5eS0JB+BnDMmfngw@mail.gmail.com>
 <Zry1qwJnPDUtp2Nw@cassiopeiae> <CAH5fLgjNfJyyZygWzeTyrNi8TQNAquufxFxDgJHzq6dan=b9BQ@mail.gmail.com>
 <Zry4iOGtR0nd6lNP@cassiopeiae> <CANiq72nsSOaG=WhGP5GUQ=ygCh23iDQBc0kgjRP3B5MoF0CUjg@mail.gmail.com>
 <ZrzLHu5Ey9vLwNJg@cassiopeiae>
In-Reply-To: <ZrzLHu5Ey9vLwNJg@cassiopeiae>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Aug 2024 18:02:22 +0200
Message-ID: <CANiq72=u5Nrz_NW3U3_VqywJkD8pECA07q2pFDd1wjtXOWdkAQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, 
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 5:20=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Indeed, and I think once they're honored we should add them again.
>
> It's just that I think as long as compiler attributes aren't honored, we =
should
> not have them in the first place to avoid confusion about whether they do=
 or do
> not have any effect.

In the C side, many attributes are not honored anyway, depending on
the compiler (or tool like sparse), compiler version, etc. So it would
be "OK" in that sense (even if here we may know there is no C caller).

> It's not so much that I want to remove them for krealloc(), it's that I d=
on't
> want to intentionally add them for the vrealloc() and kvrealloc() helpers=
,
> knowing that they don't do anything (yet).

One can think of them as "documentation", e.g. seeing `__must_check`
tells you something about the function, so I don't think it would be
bad to add them, if they are not too much work to maintain.

I checked about `__must_check`, because it would be nice if it is used
by `bindgen`, and it turns out it already does, but behind
`--enable-function-attribute-detection` (apparently for performance
reasons):

    int f(void);
    __attribute__((warn_unused_result)) int g(void);

gives:

    extern "C" {
        pub fn f() -> ::std::os::raw::c_int;
    }
    extern "C" {
        #[must_use]
        pub fn g() -> ::std::os::raw::c_int;
    }

So that one should be kept at the very least, and it is a good example
of potential improvements later on based on these attributes.

In general, I think it is not a bad idea to write this file like we
would write other C files, even if it is not a regular C file. And
adding more information to signatures is, after all, part of what we
do with Rust overall!

Cheers,
Miguel

