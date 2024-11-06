Return-Path: <linux-kernel+bounces-398018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E989BE44D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247301F23A1F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7D21DE2BF;
	Wed,  6 Nov 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bY9MPnaX"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A21A1925AC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889127; cv=none; b=g5Z6cjzy+VHB2YLZBhNAse3NTIa19wIDdVcq56ZrXhHpW0dGJRn5iUuiG2C21p2FTtH7CccK3P2bOkn8XYEPYLcIbjK7HEl9vSe9TAmC67O8ocNSRDNhm2qkqwuzaLcx2bast4H4lEodcpez9U2Eod//gKsr7/mEKHh9Me5TJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889127; c=relaxed/simple;
	bh=Q5poYfktsvGS71s9aS4q+CSekomjeLYYAsuyry1Y2Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V35JmrFzyV9BkeKWwiHU0VZ07VFKX0D5cj28TXjvBvdReXnyhMJF7wTeGYYGz2vrMizLu3FGURLeiuJ1E+FeAj1wGQTyTX2K/7ASksmnw8y/b/UwvuR3nyq856IHKvzp5uv5gNa9vYbayktqCOZAvUTCXV6xQdFvMz1AB5FSUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bY9MPnaX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so4407374f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 02:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730889124; x=1731493924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZafzsinukWqaTiyA6PRRzr4gyDshbzX8EvcpHMVNLns=;
        b=bY9MPnaXiTHpGt2VRx+ZVCesNiKuXDN40BCamomGEhckCyf7/uJ9gJXeiOEJTEZGl8
         tXfA7Ulxo77q4SqdSV6DUY4D22szylPP3PLnCeTdBp+JZuGQhv4U8EK9+CUT8VK0Etyt
         tZOv+kYGCAU/4W5P147BputAjr+b2mOUK4NIVAGIWTrb2tEvlxdR4f+guJ+FGl/tQ6ms
         uppFrQrBLyxtVF2xk2C6UVLnTu0raU6/Pg67tFqgXRYI87p53/CRoWRBDgNrPTdHZYPj
         0rNu8um1hN35L200LTKPYjAAZfFJT3fwO9i03A/6u0gzC7I43Nhheos0j8Qwr56VkO6R
         rbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889124; x=1731493924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZafzsinukWqaTiyA6PRRzr4gyDshbzX8EvcpHMVNLns=;
        b=wh0Ujamv5c4FodIPqS7mHkCJP9rmP9WhZcwieg3v4LhyeYIorXqw8vm6grl1AhpSko
         rOXGy3T04JDM63Asga3kPO9PbeWA58YBosSIP3OXTx1H4nTcNKnGU8kPJU+Th4rd9qej
         8qhtYxxJzPKK/HbQGed6AguxbqmJjnFXm2H8tIe9yf5+uw6kgDoR3Uh3iLlEnFolIUd9
         ePgRTlgVKPe5gkYzwKk80MKa0N5jyIi65XMP/tT/zPNWqfmz1/Wf9sQok8i9mb/F/cwz
         kB7yJeZIQnxVtVvP5Dcx6HOA3GP7LktKTiBHJu9BWP8MkiJxyONjGRemrnFchakM12Xg
         rRVA==
X-Forwarded-Encrypted: i=1; AJvYcCXOB2K+RAvOeRm+JWfw7cLGopMIKnmyAgPHMcB7y1hpSQF7ZhMTOMc57UDdBIHtYfVehmRfWFI3BKCuugQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIf+JBB/1aM9orzg42otTfe0kZqgGobCJuL3NnDbwNXrl1OyIN
	597pv+3PeoCIXX4Q97e2999TD+OwxTbdmOGIDzUTUu9hZjkj6OxeyLWlNhCJJGkpgQBGzddeH+l
	SXjrf0c5Xqzcr3PbhNRrrRgUh5oUyZLFhXqmb
X-Google-Smtp-Source: AGHT+IE5skJ22YR7bGRMtACJ5E6pg6v3a0PstIzVtR6wDeA00nLsEbZdA7aI5AhsIKnBKuim3PR8pEe6G6r18yg6IbE=
X-Received: by 2002:a05:6000:1a8e:b0:368:37ac:3f95 with SMTP id
 ffacd0b85a97d-381be7d8f8bmr19584152f8f.31.1730889124182; Wed, 06 Nov 2024
 02:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
In-Reply-To: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 6 Nov 2024 11:31:52 +0100
Message-ID: <CAH5fLghzPr8KgneqX=K=AfMYy2Neej2ayfkzMaRWjwYaFiS+kQ@mail.gmail.com>
Subject: Re: [PATCH] rust: platform: add Io support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
> +    /// Maps a platform resource through ioremap() where the size is kno=
wn at
> +    /// compile time.
> +    pub fn ioremap_resource_sized<const SIZE: usize>(
> +        &self,
> +        resource: u32,
> +    ) -> Result<Devres<IoMem<SIZE>>> {
> +        let res =3D self.resource(resource)?;
> +        let size =3D self.resource_len(resource)? as usize;
> +
> +        // SAFETY: `res` is guaranteed to be a valid MMIO address and th=
e size
> +        // is given by the kernel as per `self.resource_len()`.
> +        let io =3D unsafe { IoMem::new(res as _, size) }?;

This cast looks wrong to me. You're taking a pointer to `struct
resource` and casting that to an MMIO address? Shouldn't the address
be (*res).start?

Danilo already mentioned this, but I think you're missing a call to
`request_mem_region` as well.

> +        let devres =3D Devres::new(self.as_ref(), io, GFP_KERNEL)?;

What purpose does the Devres serve?

Alice

