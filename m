Return-Path: <linux-kernel+bounces-526308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E0A3FD0D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01567B06C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629E024CEC0;
	Fri, 21 Feb 2025 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Kh9Ef4oR"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7620469D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157687; cv=none; b=fLVox/5pS0rMb9ztc9JZCRBolBWb/gNpDA2qmpkXH+z6GMgz2W55wyZeIw2Vm04BLjjO2XWmHdCvwMfQnCHwIXkWa2lZmpUUWb0ruaaBJhhJEyHEuhRfJYfzsWencJW6hRvFJMrFYmxKHJcaeVnK1wXH8kQCnT9xKALFiWB3fJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157687; c=relaxed/simple;
	bh=uzJXDYroMiG9IX2A8d1Xth+4arzE1WuOd20hA7s8ZM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YLdKixsFVz+2j3o0M0UE8ZpjqRgm6+EK4IodVZ/NUKIzwDsKNcjIe6UBt+KVNkbDKFkiv633kNOR968bVOB4GqSQoBMtqnFVIDlUCi81gnL9d8924Qvlq8c4jOFew6MNDIBd6/ZfAq4DjUQW5uThSxkVf1vgNDNEudRsbQ1/iQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Kh9Ef4oR; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 09955240107
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:08:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740157684; bh=uzJXDYroMiG9IX2A8d1Xth+4arzE1WuOd20hA7s8ZM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=Kh9Ef4oRok7sHgttYS67Fd4VZOVC7JHs46uW+6pHqIG9CxoE8X9ue9pBnCRGP+iPK
	 j6hQprJHHxO6JAQlGGifrz8B24JGYJ2Q2TENG9kztNhrFMV+1dyGyil1GCRynxakCx
	 zH8/aLTjVzieRO4fsK2jGB0E0ZDWuJTXn2sU4DefwuLBGwbtnrc10oH8czO3Z8DhVO
	 LVqoemzO/mRl1IRCmuLBgj26NeiO55DdJz8wY2S9tqXIzSP2t9gGYICJrR5yjYBebP
	 d4PLY1NmqxT2tig3ZBOduXLUcdIZSjkkYVQbNLZjlMxS7ecF5zb9V4EzXfrw8gEOCL
	 MARuclboyTzlA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YzxQl1v2Yz6tm8;
	Fri, 21 Feb 2025 18:07:59 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org,  alex.gaynor@gmail.com,  aliceryhl@google.com,
  apw@canonical.com,  arnd@arndb.de,  aswinunni01@gmail.com,
  axboe@kernel.dk,  benno.lossin@proton.me,  bhelgaas@google.com,
  bjorn3_gh@protonmail.com,  boqun.feng@gmail.com,  dakr@kernel.org,
  dwaipayanray1@gmail.com,  ethan.twardy@gmail.com,
  fujita.tomonori@gmail.com,  gary@garyguo.net,
  gregkh@linuxfoundation.org,  joe@perches.com,
  linux-kernel@vger.kernel.org,  lukas.bulwahn@gmail.com,
  ojeda@kernel.org,  pbonzini@redhat.com,  rust-for-linux@vger.kernel.org,
  tmgross@umich.edu,  walmeida@microsoft.com
Subject: Re: [PATCH V3 2/2] checkpatch: throw error for malformed arrays
In-Reply-To: <20250221165327.5459-1-trintaeoitogc@gmail.com>
References: <m2pljcgpek.fsf@Mac.home>
	<20250221165327.5459-1-trintaeoitogc@gmail.com>
Date: Fri, 21 Feb 2025 17:07:58 +0000
Message-ID: <m2wmdjtedt.fsf@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> writes:

> Charalampos Mitrodimas <charmitro@posteo.net> wrote:
>> Hi Guilherme,
>> 
>> Will this work now that the field is called "authors" and not "author"?
>> I think you forgot to update the regex here.
> I don't know, I make change in modules and samples, and I forget runing again
> the checkpatch.
> Sorry .. 
> I will send a v4 

Keep in mind that now we also have the faux device sample upstream,
which uses the old single-author module field. Please build against the
latest tree and include the fix for that driver.

It can be found under the path "samples/rust/rust_driver_faux.rs".

>
>> What do you think about this instead?
>> "Prefer each array element on a separate line$herevet"
> For me, looks like great
>
> Thanks,
> Guilherme

