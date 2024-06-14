Return-Path: <linux-kernel+bounces-214150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE66908039
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0AEB223C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC3C79CF;
	Fri, 14 Jun 2024 00:45:35 +0000 (UTC)
Received: from hs01.dakr.org (hs01.dk-develop.de [173.249.23.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A73D6D;
	Fri, 14 Jun 2024 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.23.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718325934; cv=none; b=gFdlPdT9kG8HWW3G18Pk4WRup4YqZ45Ga51n+wy/VDfOPXSv2Hs70jCkkaXfoGnh0TewMU4zxWnjAB1N5I71OOtTbrf295u4fIv648ST7sP1psf7swy9Dmvi08h9GfY2gWzlqqGbvlA4ntCuR1B8oK5TzYuS/e3/r3re/bvf+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718325934; c=relaxed/simple;
	bh=pQIPQmz3HFftB8YRuoR/0qJyW0yjUPxdGGwBX4Lhkq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjiP15RMrRoQiF55UnShrc4TrUnbElCYYDWB7tpRiEIZ0qE8WpWmp7oiVVpuOm/TI9kin49veokO6f52NA0q0aw1iQQaQqmfk3+84JCqL/fCRX1NazaQcasKE8gs0BFFCv6m7ZswG38xEz/lNjDH1lLesOokqN9QQ/QbrTjMIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org; spf=pass smtp.mailfrom=dakr.org; arc=none smtp.client-ip=173.249.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dakr.org
Message-ID: <8de8c3bd-9561-4b54-8bbe-13115bad0800@dakr.org>
Date: Fri, 14 Jun 2024 02:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] In-place module initialisation
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 Wedson Almeida Filho <walmeida@microsoft.com>
References: <20240328195457.225001-1-wedsonaf@gmail.com>
 <CANiq72=Z8=tpeoeQxd9sH4QN2rfBzaKE7P_6Saz1a_WYHB__Ug@mail.gmail.com>
Content-Language: en-US
From: Danilo Krummrich <me@dakr.org>
In-Reply-To: <CANiq72=Z8=tpeoeQxd9sH4QN2rfBzaKE7P_6Saz1a_WYHB__Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 4/23/24 02:42, Miguel Ojeda wrote:
> On Thu, Mar 28, 2024 at 8:55 PM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>>
>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>
>> Introduce `InPlaceModule`, which allows modules to be initialised
>> inplace, as opposed to the current state where modules must return an
>> instance which is moved to its final memory location.
>>
>> This allows us to have modules whose state hold objects that must be
>> initialised inplace like locks. It also allows us to implement
>> registrations (e.g., driver registration) inplace and have them similar
>> to their C counterparts where no new allocations are needed.
>>
>> This is built on top of the allocation APIs because the sample module is
>> a modified version of rust_minimal, which would be incompatible with the
>> allocation API series because it uses vectors.
> 
> For the moment, applied 1/5 and 2/5 to `rust-fixes` (tagged for stable
> too) -- thanks everyone!

What's the status of this series? I'd need this for the device / driver patches.

- Danilo

> 
> Cheers,
> Miguel

