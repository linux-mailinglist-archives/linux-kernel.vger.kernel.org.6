Return-Path: <linux-kernel+bounces-394516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF29BB071
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735281C21F26
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791118A6BA;
	Mon,  4 Nov 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yElVZdUf"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4F189916
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714458; cv=none; b=KfEujOuFdB2aMy/cPC1toZcJiVUv3s5FplpqMz6EyJgS0UKLNMW3m8Wxw2UcuNf67VC8FzLvcyBZgciWKOF+P52Afers1jlT5rrvCedmZNKJmc1bNd324MUPETYwp5aO5W6xj7273ug9ZJnUq/rJQ50WooJrGLNsZHHmPJXIMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714458; c=relaxed/simple;
	bh=vlGQoK40Pe4Xgq408cAyMPIYAteoi6N6t6C7WUJDxSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLSBH134o4WhRQuTGskooU7oygs6ghWYHvP+I866lOay/DW7+wvSKHbJLtGez4ZQ6cdUyO31sXvGzR3YJZUKY1wUgL4LZ02sAP1HhozxNC425bjgnaVjOYu0llOWHpXhhwipyIBkLRFa/m8w4nYhqCLc4O53c3tiQMVLcTA+e7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yElVZdUf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d47b38336so2991883f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730714455; x=1731319255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDag3PaAeqUzZC0f2Lfe29ejFGb9q3oeg6DZ2pnEkZc=;
        b=yElVZdUfCviszWdd0xfjmAjklM1eB2jorLXzXt37K7A7/eUJBvMou8Y4HwKYStXpfE
         Epi5rpKjxczM1FRamjQhqu9WeTSynfoC3ZRtGULUphskLuOdwYZaX8ukEHoBDPd7Wbjt
         zPamGSpwisRvQ2d9LmvlZWT/ilFbAH8HXwi1MCz71p5mSAYO4cgL7zQPLIzxhb7z9UPy
         thkFZlM0rG1qu9Hlkt4c/y9dMO+0qnw9sPr1PJeVCDQlNy0rq8myNBaOIm4nwO7SzCNC
         13FqBg2yfP9BjeQ4bv3E1C0is3oxnRQBt3/RjTABGwy3GPVZ9y7vAGLOdRBwBLudadfX
         FAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714455; x=1731319255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDag3PaAeqUzZC0f2Lfe29ejFGb9q3oeg6DZ2pnEkZc=;
        b=jc4dupQQrdwoHbKthN16jIAcFQ1j8zCye9hGXvILJ7lMeOhF5rM/O1Mly30Lu1YjAY
         EUamMYG0JAqiwWKjjcsts5Kg/spUJuxOUFcu52H87v2oiuq2X5M2gUaJhvx5UsLgaMMp
         bMbzptkEOONPzTlivdrMdD9Tquv6aCC9SXOAD9yAUcN5gyS6wAgONg5AxJoTB1AVS0oL
         dHLNueBBahxi/0vMa7qBqmlXdaeIygK8zh5/6ps52LUI/KYZLWS0oiWRwRA0mz28vGix
         D/EMl5e66rkScDgPUfy3iyii6E7IbvQ41RQMHD4N34rpud5Tc/4hoYt63MQfX8uZfFHv
         MJcg==
X-Forwarded-Encrypted: i=1; AJvYcCWxu5pXVnREkQ33F6Dv36QlBluvmc4mkXs3CS6hOBiHkI92oA5hWyZHIAK8cXWjkvQ59jBWiQjn3tj+Dgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHbciWwG5YTE7qbdcZZ8O9H2VQOpV0wj3O2Z1jycolPWBUK/N
	XCc/LjXk+l7slZA2OdMjT79sEprcA9/UtZLO/M4Il9gCGmmFTODFuMVTOjUmMrHOvVmPHuIbP6J
	xhY9eIphE2JjThGmBWzzXogTo+mlkCaRgoBXd
X-Google-Smtp-Source: AGHT+IEBeFoa+PT4a++mpLtZr5eKShcDSGLxn9K3aagNUJJYzjyFbsfMaE/+MB3nPDpPVqL5MT5lOKSsGO2hv34X6MI=
X-Received: by 2002:adf:f784:0:b0:37d:4aa5:eae5 with SMTP id
 ffacd0b85a97d-38061221e2cmr20821534f8f.55.1730714455433; Mon, 04 Nov 2024
 02:00:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104090711.3000818-1-abdiel.janulgue@gmail.com>
 <20241104090711.3000818-3-abdiel.janulgue@gmail.com> <CAH5fLgisLyW-d9rsHJ8Vp8HpWh7PZxtkXooVQyMTxs445Ah4GQ@mail.gmail.com>
 <f6889ce1-f1e0-438d-a9e6-4340a92cb6ef@gmail.com>
In-Reply-To: <f6889ce1-f1e0-438d-a9e6-4340a92cb6ef@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 4 Nov 2024 11:00:43 +0100
Message-ID: <CAH5fLggDqXiyXLbmGQfUcgx3nCv+uhsqwWBwk2j522v8jOp9aw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	a.hindborg@kernel.org, linux-kernel@vger.kernel.org, dakr@redhat.com, 
	airlied@redhat.com, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, 
	Andreas Hindborg <a.hindborg@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:36=E2=80=AFAM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
>
>
> On 04/11/2024 11:31, Alice Ryhl wrote:
> > On Mon, Nov 4, 2024 at 10:07=E2=80=AFAM Abdiel Janulgue
> > <abdiel.janulgue@gmail.com> wrote:
> >> +/// Abstraction of dma_alloc_coherent
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// For the lifetime of an instance of CoherentAllocation, the cpu ad=
dress is a valid pointer
> >> +/// to an allocated region of consistent memory and we hold a referen=
ce to the device.
> >> +pub struct CoherentAllocation<T: Add> {
> >
> > Requiring `T: Add` is very unusual. Why?
> >
> > I don't even see any additions anywhere.
> >
> > Alice
>
> Background here:
> https://lore.kernel.org/all/ee45ae5f-133d-4d38-bb4a-d3515790feb4@gmail.co=
m/
>
> Basically this aims to restrict the abstraction to non-ZST types. Are
> there better (clever) ways to do this?

That doesn't work:

struct MyZST {}

impl Add for MyZST {
    type Output =3D MyZST;
    fn add(&self, rhs: MyZST) -> MyZST {
        MyZST
    }
}

You'll need your own trait, or you can build_assert! that the size is
non-zero in the constructor. Also, you'll need to require the
FromBytes/AsBytes traits because you're converting the values to/from
bytes, which is not safe to do for all types.

Alice

