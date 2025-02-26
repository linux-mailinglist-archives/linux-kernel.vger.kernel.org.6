Return-Path: <linux-kernel+bounces-533413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632FDA459B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB5B1884062
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89580226CEE;
	Wed, 26 Feb 2025 09:13:20 +0000 (UTC)
Received: from hs01.dakr.org (hs01.dakr.org [173.249.23.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4181E1DE8;
	Wed, 26 Feb 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.23.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561200; cv=none; b=L72UYsZHY/fskUohDPObskYS/Fas/gZQYYKdLol2yt0JsmoeY/JBqKu6N2WciZbkuWmarvBKt5Qz0396XJn4qiTEcgRr3EmKF8rOfx+k6fAxPJ8THcf5436vSrJLl6lBcoS+K9iaJ+X4h8otXlDtfIVV50wyN5tLKo4rqI+rpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561200; c=relaxed/simple;
	bh=wqLvG3y2UMgVHqqoGv6tQ+X1KjSHy56FGjOmdX6Uhcw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rKaZuVkhGiuMEZQqwFRiV2BdtFAT8O/8o4DWz/L3T3eZdJDDsZiUv1j0xwhuGA7gcIuJNK9HyfDkm60qNT8aVQKr1b/JyeRy+PddeUMKsH0koG+FswPNQF9Cxqvr0yCaib+CgDEcr3FlubtobPfnzFMv1hYPWiayyY4KahCTZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org; spf=pass smtp.mailfrom=dakr.org; arc=none smtp.client-ip=173.249.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dakr.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Feb 2025 10:03:42 +0100
From: kernel@dakr.org
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust/faux: Add missing parent argument to
 Registration::new()
In-Reply-To: <CAH5fLghwkK4S12eMUm3bgMXvYMNf_1Gi9ws9q-53OZPdB+QHQA@mail.gmail.com>
References: <20250225213112.872264-1-lyude@redhat.com>
 <20250225213112.872264-3-lyude@redhat.com>
 <CAH5fLghwkK4S12eMUm3bgMXvYMNf_1Gi9ws9q-53OZPdB+QHQA@mail.gmail.com>
Message-ID: <ea2466c4d250ff953b3be9602a3671fb@dakr.org>
X-Sender: kernel@dakr.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-26 09:38, Alice Ryhl wrote:
> On Tue, Feb 25, 2025 at 10:31 PM Lyude Paul <lyude@redhat.com> wrote:
>> 
>> A little late in the review of the faux device interface, we added the
>> ability to specify a parent device when creating new faux devices - 
>> but
>> this never got ported over to the rust bindings. So, let's add the 
>> missing
>> argument now so we don't have to convert other users later down the 
>> line.
>> 
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  rust/kernel/faux.rs              | 10 ++++++++--
>>  samples/rust/rust_driver_faux.rs |  2 +-
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>> 
>> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
>> index 41751403cd868..ae99ea3d114ef 100644
>> --- a/rust/kernel/faux.rs
>> +++ b/rust/kernel/faux.rs
>> @@ -23,11 +23,17 @@
>> 
>>  impl Registration {
>>      /// Create and register a new faux device with the given name.
>> -    pub fn new(name: &CStr) -> Result<Self> {
>> +    pub fn new(name: &CStr, parent: Option<&device::Device>) -> 
>> Result<Self> {
>>          // SAFETY:
>>          // - `name` is copied by this function into its own storage
>>          // - `faux_ops` is safe to leave NULL according to the C API
>> -        let dev = unsafe { 
>> bindings::faux_device_create(name.as_char_ptr(), null_mut(), null()) 
>> };
>> +        let dev = unsafe {
>> +            bindings::faux_device_create(
>> +                name.as_char_ptr(),
>> +                parent.map_or(null_mut(), |p| p.as_raw()),
>> +                null(),
> 
> This function signature only requires that `parent` is valid for the
> duration of this call to `new`, but `faux_device_create` stashes a
> pointer without touching the refcount. How do you ensure that the
> `parent` pointer does not become dangling?

I was wondering the same, but it seems that the subsequent device_add() 
call takes care of that:

https://elixir.bootlin.com/linux/v6.14-rc3/source/drivers/base/core.c#L3588

device_del() drops the reference.

This makes device->parent only valid for the duration between 
faux_device_create() and faux_device_remove().

But this detail shouldn’t be relevant for this API.

