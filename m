Return-Path: <linux-kernel+bounces-559242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7904A5F139
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BA619C0143
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDC264A7B;
	Thu, 13 Mar 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UL6imIxJ"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDC13C689;
	Thu, 13 Mar 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862850; cv=none; b=ayOdLo5B9GmvYdibVOdqYUsalxWGfAiiNrhire74agY8fuPBIVCd1DIHTVDqmacYRDYQnzgTWMWCrDiYZ31XEaZx89W7wF9+EYam8e9YOAivpPLd8OHeQi4NJUoIUgKLdKwHY3vx+ad9c4jx+f8ZHIr+3dQS5qVMZeyPIBkjwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862850; c=relaxed/simple;
	bh=SLtSkwQWPnJ1tyVbpdjnonfobNcOyU3hfgLkBFlubkI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCulSEkxp2qt5O9UzmyY2D4tGTv3VH8+8ftbwodGn7sBLYdMz8BctsIPDpN5CwbJxM8SZ3+wz4et5MVUzT2bGZRO3CP3PybcoMX5J8RKqjuBm8jDuI+Ld8XqHqC2N9gUkyJu5izYMU1u7k8wFaN8INqKMc9kYFnzDjPVNsCPWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UL6imIxJ; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741862846; x=1742122046;
	bh=SLtSkwQWPnJ1tyVbpdjnonfobNcOyU3hfgLkBFlubkI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UL6imIxJd1w74nezCNjUzn+aVXKwa9DUIXDvEKAChU9JunuWFpnxMhJjJi83w3goC
	 eCKYzqE0ESAOqqsXXeB9bqHxdU2zL2leCgAe6z8g4O6Avgy9rkFxJOZBMd6Yj1DPLM
	 nOyP2dbMc5HUBip3vaTN5cfFYJL746PghulqNyOykl4eC5Uvzy6KauesZ5csicXIVS
	 QHeLK4pNyUrhnZWrlTKH+4KEc7S5r/S4Smai08cDfg3eFespWWMWlyqHgN6JflboZi
	 PZpOYbg6lm7T383AyCX5D+mUiZsblKDwRsSztttyTfZonTJ5dfpWLUDZg2Vvk5UjGa
	 HrEAARE9Rs3rA==
Date: Thu, 13 Mar 2025 10:47:20 +0000
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: device: implement device context marker
Message-ID: <D8F2UB2ZTHOE.JHFXN7W2YEQT@proton.me>
In-Reply-To: <D8F2GQ4WYT7Z.172Z7R7V8BIGR@proton.me>
References: <20250313021550.133041-1-dakr@kernel.org> <20250313021550.133041-3-dakr@kernel.org> <D8F2GQ4WYT7Z.172Z7R7V8BIGR@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2db073f845423795e7d127fdace01111c6fee6c0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 11:29 AM CET, Benno Lossin wrote:
> On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
>> Some bus device functions should only be called from bus callbacks,
>> such as probe(), remove(), resume(), suspend(), etc.
>>
>> To ensure this add device context marker structs, that can be used as
>> generics for bus device implementations.
>>
>> Suggested-by: Benno Lossin <benno.lossin@proton.me>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> I would have folded this into #3, but if you prefer it being split, then
> it's also fine.

Ah I didn't look at patch #4, then I would also keep this separate.

---
Cheers,
Benno


