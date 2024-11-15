Return-Path: <linux-kernel+bounces-410825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9749CE169
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D528148B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B071F1B6CE0;
	Fri, 15 Nov 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XICTwa6S"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5F3A1BF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681548; cv=none; b=kRVIUyXa+QD0y4YZMUc5b9/zpcXXMRvH4OcGd7xZhAXHCH07dhjRU+iSo3G1fULOZWLl4Ya1oTux+AmjL3yXEke7+HlH7soGff5JRK3l6ylKtPjcMLBt/TXTiRucdypzsom8lLbKFEOmwl10sW/aVUnjfGNVj+6EDwErnNQJQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681548; c=relaxed/simple;
	bh=p2dvMXIDe+xckE06mxUIr99aVq3YSj+lqYRy7u4o1xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDWfFB/YIbjBAoOVTXCzJR4xlYhCJzC69WYF5n5cAg50EEaQ/4p2Xgd12IlYkzwyxSNsv0o5GzpwEtTGjmiLLd5K/vyTte3jXIeqSUf+8c4TiEDrmPiOzlvAycLg9WiXVI9AIja9BC979+Vk+VfOeDKItOE4j51szal7wHYykxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XICTwa6S; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-382026ba43eso1236369f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731681545; x=1732286345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmBG+81RP3tRz311rcroyqELokIXj7GbKvLwHQc/2dU=;
        b=XICTwa6Sb90C24+DA/jspHEfe9qhefdFcoZzM2o4lghVYp0kzVq7tiPRuU92BDid79
         qA6djU1bibjRDJmnJ4Ozgk+oUAgvOvUItW5JqqyE9RgKY187cTv12SRk42kF8HZ3ukad
         X14ua0FujTXY7VZJ9pyVJDJmjnRRPgdnz6Ri4hjEW9O+eOe2u498NWxhN1MVTx6KNFr/
         ziEtyIt0npLLjFZLFvhPpkejT2LXlyXEhJT2fRdLyxkC1dZrToEJZc0kizUcKWCMSS11
         4/m8XUkCosGF6SXHilDmmNqZ4NDg8B29KN7xBHmk24+aIBUOonryIvlAgxQWSIEKdMzu
         DrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681545; x=1732286345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmBG+81RP3tRz311rcroyqELokIXj7GbKvLwHQc/2dU=;
        b=px77ll11/wRiPLqb/76UFjFM44n7oc5K5a3ZXXtxGgk2okHRZQ3+FnZRWYNOr8bBMA
         q1DfdfLi5iVNm/UxBOgJ86KhHZV+UoCYSG94kIYxrv3QSMXcPULWX6VqG+J+fwG3apg8
         lgpexgPdudQI3wuCR+JYuZTlemgYmQa3gahMg3vhhliQs6GWTRwK7T3S7ay4+bEWYEpP
         MR7WsA3R1oFS3jpEVuQWnrMVhFmMIDdJtwy86BMY2QQDGL/tpog2G9bokcUUFW1ixhwU
         FYf90OipAVDrKT7T2zBbZHiKqJ3Q10N6EimNSL0bSyFizFxljRkioUpeL//YsvnilJ5+
         iXiw==
X-Forwarded-Encrypted: i=1; AJvYcCVzt2mPGVkh3Ac1w6Gi7tAGCvSarw2vgbQnM9Dpt8uDC+iYOUprHrY822q4p5U7lMHqTxkmwFrPup0viII=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5LLswEHtrn/jAzniOYpgKL3Xi/GRJ7Fkce9oh/xgFdSofQI4
	Q4z9ore+Y/tBcgAo5uueaIleJQMgjRJqqjKhAxvfaG2GkPDT0IpJ++gXo//P+AyLYDA43IP/b4y
	xwOXBwf251f1AK0XrCFeC89roz8M/Oqzm2SB2
X-Google-Smtp-Source: AGHT+IGQscRoij4qCimfqvOKmYiZ9D55HBJJ3Gewjtfvo2BOYK6U2ZbezAhC1Laqj/Iu4Mq6nkjQh26qknQ3f+JLiWg=
X-Received: by 2002:a05:6000:402b:b0:382:1e55:d3ca with SMTP id
 ffacd0b85a97d-38225a8a5cdmr2270310f8f.43.1731681544604; Fri, 15 Nov 2024
 06:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-topic-panthor-rs-platform_io_support-v2-1-0dea1edc3a49@collabora.com>
In-Reply-To: <20241113-topic-panthor-rs-platform_io_support-v2-1-0dea1edc3a49@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 15 Nov 2024 15:38:52 +0100
Message-ID: <CAH5fLgjnu-Yg5+OJn7-yC3pT8tZFcje=+ct_iKXTggu2poQefA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: platform: add Io support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@collabora.com>, 
	Rob Herring <robh@kernel.org>, Daniel Stone <daniels@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:32=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Add support for iomem regions by providing a struct IoMem abstraction
> for the platform bus. This will request a memory region and remap it
> into a kernel virtual address using ioremap(). The underlying reads and
> writes are performed by struct Io, which is itself embedded in Iomem.
> This is the equivalent of pci::Bar for the platform bus.
>
> Memory-mapped I/O devices are common, and this patch offers a way to
> program them in Rust, usually by reading and writing to their
> memory-mapped register set.
>
> Both sized and unsized versions are exposed. Sized allocations use
> `ioremap_resource_sized` and specify their size at compile time. Reading
> and writing to IoMem is infallible in this case and no extra runtime
> checks are performed. Unsized allocations have to check the offset
> against the regions's max length at runtime and so return Result.
>
> Lastly, like pci::Bar, platform::IoMem uses the Devres abstraction to
> revoke access to the region if the device is unbound or the underlying
> resource goes out of scope.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

> +impl<const SIZE: usize> IoMem<SIZE> {
> +    /// Creates a new `IoMem` instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must make sure that `paddr` is a valid MMIO address.
> +    unsafe fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> =
{

The safety comment seems outdated.

Also, you do have another safety requirement: The caller must ensure
that the IoMem does not outlive the device (most likely by wrapping it
in Devres).

> +        let size =3D pdev.resource_len(num)?;
> +        if size =3D=3D 0 {
> +            return Err(ENOMEM);
> +        }
> +
> +        let res =3D pdev.resource(num)?;

You're still calling `bindings::platform_get_resource` twice :(
First call is `resource_len` that calls `resource`. Then you call
`resource` again.

> +        // SAFETY: `res` is guaranteed to be a valid pointer to a `struc=
t
> +        // resource` as per the semantics of `bindings::platform_get_res=
ource()`
> +        let res_start =3D unsafe { *res }.start;
> +
> +        // SAFETY:
> +        // - `res_start` is guaranteed to be a valid MMIO address.
> +        // - `size` is known not to be zero at this point.
> +        // - `name` is a valid C string.
> +        let mem_region =3D
> +            unsafe { bindings::request_mem_region(res_start, size, name.=
as_char_ptr()) };
> +        if mem_region.is_null() {
> +            return Err(EBUSY);
> +        }
> +
> +        // SAFETY:
> +        // - `res_start` is guaranteed to be a valid MMIO address.
> +        // - `size` is known not to be zero at this point.
> +        let addr =3D unsafe { bindings::ioremap(res_start, size) };
> +        if addr.is_null() {
> +            // SAFETY:
> +            // - `res_start` is guaranteed to be a valid MMIO address.
> +            // - `size` is the same as the one passed to `request_mem_re=
gion`.
> +            unsafe { bindings::release_mem_region(res_start, size) };
> +            return Err(ENOMEM);
> +        }
> +
> +        // SAFETY: `addr` is guaranteed to be the start of a valid I/O m=
apped memory region of
> +        // size `size`.
> +        let io =3D unsafe { Io::new(addr as usize, size.try_into()?)? };

What types are involved in this .try_into() integer cast? Why is it necessa=
ry?

Alice

