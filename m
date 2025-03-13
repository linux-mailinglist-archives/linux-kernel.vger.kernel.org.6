Return-Path: <linux-kernel+bounces-559733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB90A5F8AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0F1166A05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5F0267F66;
	Thu, 13 Mar 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BUvwPGI9"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800542052
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876902; cv=none; b=AWM8spue1E8Bi5NFxOy2PaLXe7qn9Vi2gG6CaEpVfF4FCTVkl09MLsFjVVxCaUFmxmpKsR2ImoxEv7YDH0/pRj6Z3eEPt56AQ60+WjIpIfkG+P5jMEhxDu/1HmMm+iRwtcyC04rytSfTBwY7qmMkcw4VIsDCvZYPStgX+Dq2re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876902; c=relaxed/simple;
	bh=9RV0gMVD17FtNzOFTr3x4pnTW9Ug+Ma/wZ2K3NEkm0g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmmOq3uaVXs8zqMol6oHDoH6A9ZFcEuXQ1nCg1uTlo4eRFYCHFnIZGgMd5rCQqegNeMeUVPBc1mC8Z1YLkl83iYQQ+PnBlLr7zpoXRoqkucxq8uBKertw45R/JlbPwowoTu3PYO92T+JFAiRg5Xj4317fhHJ/GbUZCMWBtFCITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BUvwPGI9; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741876884; x=1742136084;
	bh=9RV0gMVD17FtNzOFTr3x4pnTW9Ug+Ma/wZ2K3NEkm0g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BUvwPGI9bUkHaNo2kJl9oAInmgAVAVb+75G258HwNqPaEIOkyWT0Ug/oTycIIsRxy
	 XWWyL5mdpM79oKyLEqiO88q3WJxpS+WkJQJoP4tGBQ1bcbtPvSRXfBHoVyEtagBczs
	 o+sru8rQjpumpc8huDokzCXAJwRSD/TnQHW7kTfbLuvdpdASXxs6WvVwVdMNr8jVdl
	 /PKdEzSZqXLoPlrgEUCMgdrgD5mvXF3RnEPyEs4RKhNOrstCcZRnabqd+d14Xuk3xN
	 2hoIdVV9MAiCERliIK833lDOTp3uMp6cgrdczYmK1yyqSWmKXTa7ndbntva0PfGvss
	 oxReRjb3RPeFg==
Date: Thu, 13 Mar 2025 14:41:20 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] rust: platform: fix unrestricted &mut platform::Device
Message-ID: <D8F7TGXIVOSZ.26D6CBL91D9U@proton.me>
In-Reply-To: <Z9Lrp2fC4b22QkPj@pollux>
References: <20250313021550.133041-1-dakr@kernel.org> <20250313021550.133041-5-dakr@kernel.org> <D8F2WCIXO6RQ.3OQHU95WZFB61@proton.me> <Z9Lrp2fC4b22QkPj@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3c9d992c7bb034eba69ffa64ac3478ab728a2f00
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 3:28 PM CET, Danilo Krummrich wrote:
> On Thu, Mar 13, 2025 at 10:49:59AM +0000, Benno Lossin wrote:
>> On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
>> > As by now, platform::Device is implemented as:
>> >
>> > =09#[derive(Clone)]
>> > =09pub struct Device(ARef<device::Device>);
>> >
>> > This may be convenient, but has the implication that drivers can call
>> > device methods that require a mutable reference concurrently at any
>> > point of time.
>>=20
>> Similar to the other patch, I didn't find any methods taking `&mut self`
>> but I might have missed them.
>
> `platform::Device` does not have any yet. But we still need the pattern. =
Once we
> land the `dma::Device` trait, we'll need:
>
> =09impl dma::Device for platform::Device<Core> {}
>
> to derive the DMA methods.
>
> Besides that, I want bus device implementations to be consistent.

Yeah I think we should have this patch, just was confused by the commit
message.

---
Cheers,
Benno


