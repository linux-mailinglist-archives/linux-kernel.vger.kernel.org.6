Return-Path: <linux-kernel+bounces-286946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B20519520AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC35B274AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4C1B9B2D;
	Wed, 14 Aug 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QpMo7CaT"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109133D8;
	Wed, 14 Aug 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654984; cv=none; b=axiL5sApLnJuEldAec9LG42xDjph8D4cR90XVeA2C6RKs1SMMggoKVA4s6d8SDjR5/dhaBjNj0C2iCPL+hlds2EoNs2IwTZawsRgVsUOypJ92oRTCD2nBD1HAp+bKBdXR9Wh8KyIihhjZOFsAJau99rNm4AWb+MlZoKES5Y9nI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654984; c=relaxed/simple;
	bh=L+MFfDCL8MSkPKpY7Pb84tdXTpsYUvbltfCv+5JR2R4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSxmeNlfMfKJd6I+AlN43USWYJ1gxmjQGPbzYB+A0nJr3bMVYYfS7XGPXL4gnppmuigAapcMCLlCGJd6FvAqJYu8ft++nQmRz3tFVfLR4z3+avXpBW5mMzGy+MH8ZdXivnG4g1LPOJ0WtKsgb3Ms+B48haYqQST17PICZnsOkLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QpMo7CaT; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723654977; x=1723914177;
	bh=31U8EN0/5rNfSJKqoCsAMni+Dc8kU/DomCur5NUnA/A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QpMo7CaTXFX1gFBgvIMYVxiurFQhwC/WhkX6TRvgmcLiUkuOtW144LwEGg3CWoGCj
	 p6PiHOEHWUKRHCa21+9JS7Un6MCoiojTcHt0oU37gVSJtYTW38Cvz0sXUQrIs5U9K+
	 PFEBtjBAig+Cw5QhN3YINPqEhK/GFWO1eBcQn5UbRxOPefu6cjEMlKrXNkb95HzxJx
	 1fuFtxAuXW6LKbyLubj0Q/N4jTJ6tr624Ib0G6gAHQw0xZw2SqgrWTsi/G6WdioSde
	 YBkcGyZ0jsdxK+IVsP/+LuuspPxQKeiE6eQw29pG1qn7dqrHA9OT/KxhfeHx3ynvfZ
	 InawfwVxNcoZw==
Date: Wed, 14 Aug 2024 17:02:53 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <17bcfe21-1af3-4247-98d1-480944be400e@proton.me>
In-Reply-To: <ZrziXqB5zExntYfW@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-5-dakr@kernel.org> <b6b3d965-c1d4-4c18-8db4-2e7c19f10a15@proton.me> <ZrziXqB5zExntYfW@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 97bcd4a4d90f2a9a617d5828adea3741acb156dc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.08.24 18:59, Danilo Krummrich wrote:
> On Wed, Aug 14, 2024 at 04:21:38PM +0000, Benno Lossin wrote:
>> On 12.08.24 20:22, Danilo Krummrich wrote:
>>> +    unsafe fn call(
>>> +        &self,
>>> +        ptr: Option<NonNull<u8>>,
>>> +        layout: Layout,
>>> +        flags: Flags,
>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>> +        let size =3D aligned_size(layout);
>>> +        let ptr =3D match ptr {
>>> +            Some(ptr) =3D> ptr.as_ptr(),
>>> +            None =3D> ptr::null(),
>>> +        };
>>> +
>>> +        // SAFETY: `ptr` is either NULL or valid by the safety require=
ments of this function.
>>> +        let raw_ptr =3D unsafe {
>>> +            // If `size =3D=3D 0` and `ptr !=3D NULL` the memory behin=
d the pointer is freed.
>>> +            self.0(ptr.cast(), size, flags.0).cast()
>>> +        };
>>> +
>>> +        let ptr =3D if size =3D=3D 0 {
>>
>> Why do you do this check *after* calling `self.0`?
>=20
> Because I need `raw_ptr` in the else case below.

But you can just return early above? I would prefer the check be done
before `self.0` is called.

---
Cheers,
Benno


