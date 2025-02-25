Return-Path: <linux-kernel+bounces-530838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DABFA43918
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B1E3BB783
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE826157E;
	Tue, 25 Feb 2025 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8G+ZUrn"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3257261373
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474563; cv=none; b=cjBj+F9NubtADte/urDicz7CSN6NNicmyOsDDZEP00hWhY3jgweeX3StrU/Ryk727okK20wt7bLOGKRtC2FAtaMssHlgoVim+JxZJDq0FreE7uRZDsHE1yVRdpgCabmDemvvpEniAVCIN0BQYwgXqRxkYOcatvHyPld6TVjSK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474563; c=relaxed/simple;
	bh=vHP8iH87HLYw0EXAh2NXut+P7Yu/K0NXb69PESW79T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZXeR+im5zP3KgK2binlHmfhAxn+LWuIbd9rBLFBZgHnwDecEqosDKuBhAjTVEimDo3CT4pDge2WTvs74RJsIkj/UcxPG3l2LXhEdYziyCPimEso/PG4yEpI2kkN0cp8XL9r4GBmtiW/gwL+p0AiOpGw+Qa9Q9PsrRb1lvyFvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8G+ZUrn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso30564065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740474560; x=1741079360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EATRkDqeNJ+B0cG+644Rc49PEjwniyGIzEzuzyJ4FDE=;
        b=r8G+ZUrnXPY0hyo13ZmcNtMGGis+A5DjNAixKmaJmMk0o5g5IcZqTFsSeB7LVShZlE
         j3xEtX0mbldDun1+kQpkqDAMKJtx18kOy2g7M0WZDb+9nVbFWgPf/JmSW4HY+7v/c0t1
         5oHp3Kojt+xPA30JM7NfcDuDns9RSORHti7sOH/3HZFL1Y9yx3xCmC4T9DB3t/F7IXPl
         NqMbODBfgUyrE2L7uR+UV1Zfs7GUBUV1S7vpjrWdAJYtgOscjdt9qBNA9DuRgm+5mIbV
         I7aww6etnNAs/KNKuBIFE1YqUvNzbvrSXnTkAp8clcUuoScSm7YgxDHpqEeqmlD/c8M5
         VtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474560; x=1741079360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EATRkDqeNJ+B0cG+644Rc49PEjwniyGIzEzuzyJ4FDE=;
        b=CF1yQR2qYSnBoUu3bd0sqHUwu5JppS63e1F/xgdc5VzDAPfzext3wd5RPp2k0UXXpX
         nwIHT3aF9T3LPwWV0aUNM1az0iFMDnPjx9D+H9AyqWReZOo8FJC5uZjkxQnbsOWJpRM3
         SNbCOYHsi85gi9S2Wzh+IFuWiaVjRgOAne3GhcJbtXH+jkUUORzfXJ5JLuzMiGzLZp4i
         XO+24ZkEqtbFhh9thjR/IV0GzWBnJdm3QiXG5XM4eWYXyg7XT7AHm5dNww9ApXFSPIqq
         wP45hyP5cvkZhs5vqcO2g0/a1rXczSmBBS1d3ifkWLPr6/+pHhpfSouHjtJnNNMSUBUi
         7/kw==
X-Forwarded-Encrypted: i=1; AJvYcCX3iJyT7qoUJ1AO7VJje4sQyeBxJEykN6/oIqM9EJJq432BCdSQ8S0615cajIF/q2U2uBsDhWVe0meK5Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs+u+lprzwE5LBPNlq1KqxQRErqHe+Zq1jzw8C0QBwNtvtIiy8
	yFJqRIKGunDCb4DmrABSLw67/UrA5vibwjtQ5AMxoClfIUialfvMtLpq75jYIvW+/TruTjM5faW
	reRypGzUfkoqXKh2UZbNTezLClwJuBK4sBiOy
X-Gm-Gg: ASbGncv1VMAbeBebjhMCV1hWjehAsIKvAEqWu3fseQr8hdejEyIW8bKP/e19nLfhxas
	FFzbalSI4KEtPk/0Uu6W4HIc23+ziJ3YlE8JODJelt3ErZNGEE68ACYQD+nt0J2cBwztcZEu89/
	9gJUs+3WQWISuPN+NGrmLIi6kiACSmHoeyrw4bdw==
X-Google-Smtp-Source: AGHT+IGZInk/hQzrlT6txuFwQsEo9tTw27WKXN7JW2r7IlfD+fs1wRIJAj+kaIZ/YJM1ku4z/kVfmBxq/4O+Kp5n6Yo=
X-Received: by 2002:a05:600c:1c1d:b0:439:9496:181c with SMTP id
 5b1f17b1804b1-439aebdc9e1mr120554755e9.29.1740474560036; Tue, 25 Feb 2025
 01:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com> <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
 <a65125ce-524f-4226-9e59-32b731ad97f0@gmail.com>
In-Reply-To: <a65125ce-524f-4226-9e59-32b731ad97f0@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 10:09:07 +0100
X-Gm-Features: AQ5f1JqWFjMHJGx6yaV8UawGsqN9xXNnmKqO6WA4uvUistTtsMQKb-M2EASAR3I
Message-ID: <CAH5fLgh_Hu8-DkNgPBUM+k+4wrfznz0HcRxHnVxYnEY+XwVbxg@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, dakr@kernel.org, robin.murphy@arm.com, 
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:15=E2=80=AFAM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Hi,
>
> On 24/02/2025 22:07, Benno Lossin wrote:
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// It is the callers responsibility to avoid separate read and w=
rite accesses to the region
> >> +    /// while the returned slice is live.
> > This safety requirement is worded quite differently compared to the one
> > on `as_slice`, why?
> >
> >> +    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) ->=
 Result<&mut [T]> {
> >> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
> >> +        if end >=3D self.count {
> >> +            return Err(EINVAL);
> >> +        }
> >> +        // SAFETY:
> >> +        // - The pointer is valid due to type invariant on `CoherentA=
llocation`,
> >> +        // we've just checked that the range and index is within boun=
ds. The immutability of the
> >> +        // of data is also guaranteed by the safety requirements of t=
he function.
> >> +        // - `offset` can't overflow since it is smaller than `self.c=
ount` and we've checked
> >> +        // that `self.count` won't overflow early in the constructor.
> >> +        Ok(unsafe {core::slice::from_raw_parts_mut(self.cpu_addr.add(=
offset), count) })
> >> +    }
> >> +
> >> +    /// Writes data to the region starting from `offset`. `offset` is=
 in units of `T`, not the
> >> +    /// number of bytes.
> >> +    ///
> >> +    /// # Examples
> >> +    ///
> >> +    /// ```
> >> +    /// # fn test(alloc: &mutkernel::dma::CoherentAllocation<u8>) -> =
Result {
> >> +    /// let somedata: [u8; 4] =3D [0xf; 4];
> >> +    /// let buf: &[u8] =3D &somedata;
> >> +    /// alloc.write(buf, 0)?;
> >> +    /// # Ok::<(), Error>(()) }
> >> +    /// ```
> >> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
> >> +        let end =3D offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
> >> +        if end >=3D self.count {
> >> +            return Err(EINVAL);
> >> +        }
> >> +        // SAFETY:
> >> +        // - The pointer is valid due to type invariant on `CoherentA=
llocation`
> >> +        // and we've just checked that the range and index is within =
bounds.
> >> +        // - `offset` can't overflow since it is smaller than `self.c=
ount` and we've checked
> >> +        // that `self.count` won't overflow early in the constructor.
> >> +        unsafe {
> >> +core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset=
), src.len())
> > Why are there no concurrent write or read operations on `cpu_addr`?
>
> Thanks for the feedback! I noticed an additional safety requirement in
> slice::from_raw_parts_mut:
>
> "The memory referenced by the returned slice must not be accessed
> through any other pointer (not derived from the return value) for the
> duration of lifetime 'a. Both read and write accesses are forbidden."
>
> I can see now though why both as_slice and as_slice_mut docs needs more
> clarity. i.e., they could be worded similarly and add the additional
> safety requirement of slice::from_raw_parts_mut of having no other r/w
> access while the slice is live?

You can use the same wordins as `Page::read_raw` and `Page::write_raw`
for your as_slice[_mut] methods. See rust/kernel/page.rs.

Alice

