Return-Path: <linux-kernel+bounces-287192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF73952479
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E151C2103B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B621C8240;
	Wed, 14 Aug 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lLuF0AjM"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E01B0125;
	Wed, 14 Aug 2024 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669684; cv=none; b=mpql4pksH3Bs/QZBZmvwFFgm0H2FzSkZcVJtYaZzLHY3tsS4wIQ8cUY+ZcgWmBBNQgUPdgDnnP4u4SSi8sgQBcwh5p88jbF+cvqXBm88cBGRjzCW32AUX4hFxTNdHjUZuyxD5ZSgWWpsYSrH2ZCOKkeTQw3soBO5lHwmAzSZJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669684; c=relaxed/simple;
	bh=Pb2B017kQ2RwEzIA1+C+dMNUYvReVh+JO39yLw6h+s0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqsqhQjDMLnG0/Xj5n0AOzXD47+mit4WTik7AHoMfYe2983hcmzSYfL1MtH7Bz1W13U3sR8eU/6ntbbw3LzH4OhQ9KTAv7f5xLRVQuFf1GqQr3Op8p4qQSIfzTQeZv6grhfec+tOxdgjpbX5NEi2As8JiZiF0Q7xI1UkV/JI2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lLuF0AjM; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723669680; x=1723928880;
	bh=/T78YC5XxPNvA0dz06ctY6MEt4K5BQBSyBeL9OVQf84=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lLuF0AjMRLi8OdnJo+2CJg3G+el/YWp8YqwX9Sy8RyvYgr6kHBzQDuBqTSAVW8Re/
	 6LfEXwQAznX0glGq5js137HwkOSOs8/ygnres79mxT1cHoz2n3j7b/Eay3JGsVUqPm
	 6q6q9M0YEzIktKFEpB5Ngxej28BQ3HU2xxwGn31f+ky39sm8RT9vpKYRmk9/S/IItp
	 quKuQoe24rGKDmeZdX4lKH3Sn3EhftL3Cix+hkRVSj0gpH5CiefozewsR21Wh9Lvqs
	 GloINQrD6YBa0VhKULG379Qf2xGZm+J5O0JRUR9i2kybIH2Nds7dKleDxWoqcW0qsP
	 cOnq71Is2UM2w==
Date: Wed, 14 Aug 2024 21:07:53 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <00c48c22-52c2-454b-a5c3-15b6b1caa0a3@proton.me>
In-Reply-To: <ZrzmFHGXrXxSqXzt@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-5-dakr@kernel.org> <b6b3d965-c1d4-4c18-8db4-2e7c19f10a15@proton.me> <ZrziXqB5zExntYfW@cassiopeiae> <17bcfe21-1af3-4247-98d1-480944be400e@proton.me> <ZrzmFHGXrXxSqXzt@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1f2fff18e2a76f9c5fa19ed93ecc72e03decdf4a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.08.24 19:15, Danilo Krummrich wrote:
> On Wed, Aug 14, 2024 at 05:02:53PM +0000, Benno Lossin wrote:
>> On 14.08.24 18:59, Danilo Krummrich wrote:
>>> On Wed, Aug 14, 2024 at 04:21:38PM +0000, Benno Lossin wrote:
>>>> On 12.08.24 20:22, Danilo Krummrich wrote:
>>>>> +    unsafe fn call(
>>>>> +        &self,
>>>>> +        ptr: Option<NonNull<u8>>,
>>>>> +        layout: Layout,
>>>>> +        flags: Flags,
>>>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>>>> +        let size =3D aligned_size(layout);
>>>>> +        let ptr =3D match ptr {
>>>>> +            Some(ptr) =3D> ptr.as_ptr(),
>>>>> +            None =3D> ptr::null(),
>>>>> +        };
>>>>> +
>>>>> +        // SAFETY: `ptr` is either NULL or valid by the safety requi=
rements of this function.
>>>>> +        let raw_ptr =3D unsafe {
>>>>> +            // If `size =3D=3D 0` and `ptr !=3D NULL` the memory beh=
ind the pointer is freed.
>>>>> +            self.0(ptr.cast(), size, flags.0).cast()
>>>>> +        };
>>>>> +
>>>>> +        let ptr =3D if size =3D=3D 0 {
>>>>
>>>> Why do you do this check *after* calling `self.0`?
>>>
>>> Because I need `raw_ptr` in the else case below.
>>
>> But you can just return early above? I would prefer the check be done
>> before `self.0` is called.
>=20
> No, we can't return early, we need `self.0` to be called, because if `siz=
e =3D=3D 0`
> we free the given allocation, if any.

Oh yeah of course... I don't know how I arrived at that comment...

---
Cheers,
Benno


