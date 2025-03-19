Return-Path: <linux-kernel+bounces-568266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA1BA69356
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0A81B84EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E61F873E;
	Wed, 19 Mar 2025 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="D2T0AiMf"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE6202978
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396572; cv=none; b=O0JZeDCgcswqByqMcH6Z+Ba/OZdU2g4pPsZr32Vr6QLSCvrKq/3BTQHmXj9INPOLzOt7XmvJVlnDI4GRMistok2taRPvKAzqmErZfY4CoiyLCGfZnOGdTDqK3DuhgCpPWUO+lxELL5LIX72A5RmfyFTj7uBN39KPfw7J8kI+uM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396572; c=relaxed/simple;
	bh=5QpBopBXaf7O91FJNJKy0fbdI3zt/NIhlpSxK3YF/64=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXj2lE5r/QzD0XUcthNH/obEgBUnC4GfJvaorg0ry/SdP9QVSAlEudmiYbr+rriUqUbuaaSK0TohcDfXl+cryef6JD1vFVgzzfrp024nMO6SSzxpAwS2mWLvOEgGD+AbiMdDwWVvrFsl+rS2yXwQjWDAG7zMIxjzp7kW9P3Z4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=D2T0AiMf; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742396568; x=1742655768;
	bh=Bb5KLqE4RqgYQgZZhCEM8LO4O2vuC0PzFqYR2WWXvHo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=D2T0AiMfnOIDpEQ5wi+6pXtgbY6/sxPm+I+FYyNn35VOAZFcwczkc1AMr+J9RqHkN
	 47Di9GFTdVV622D/+cz9xijGJpRQPv334zwGN+sGzCDEJjng7F6M5YZw+Xza8zMabZ
	 ENBOQz7z+p47gEDwQ2LbNBr3qYuYKRQ3uDKLMcDirOHZp1BWL/p4D1iZPVPsb+tYzr
	 KqeUxPoz8RMfQUkbkMrhJwChs/vn9SeE3JjnXYSg+jOyzmmY/UKRsuls2wsz4diJ0P
	 aY1Sy4ni8ysRUw6xrHYm7GSiDD9JMQh5PhwXvzF+LsHz/oLQn9uCunI+ggui7J8lX8
	 9yp7SUlRSgycw==
Date: Wed, 19 Mar 2025 15:02:43 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: pci: require Send for Driver trait implementers
Message-ID: <D8KC149B0URD.6I35KIJOEHT4@proton.me>
In-Reply-To: <20250319145350.69543-1-dakr@kernel.org>
References: <20250319145350.69543-1-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0a13356b3bc01d5b532ac88cc72de70aeca6b9f1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 19, 2025 at 3:52 PM CET, Danilo Krummrich wrote:
> The instance of Self, returned and created by Driver::probe() is
> dropped in the bus' remove() callback.
>
> Request implementers of the Driver trait to implement Send, since the
> remove() callback is not guaranteed to run from the same thread as
> probe().
>
> Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractio=
ns")
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Closes: https://lore.kernel.org/lkml/Z9rDxOJ2V2bPjj5i@google.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/pci.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 0d09ae34a64d..22a32172b108 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -222,7 +222,7 @@ macro_rules! pci_device_table {
>  ///```
>  /// Drivers must implement this trait in order to get a PCI driver regis=
tered. Please refer to the
>  /// `Adapter` documentation for an example.
> -pub trait Driver {
> +pub trait Driver: Send {
>      /// The type holding information about each device id supported by t=
he driver.
>      ///
>      /// TODO: Use associated_type_defaults once stabilized:



