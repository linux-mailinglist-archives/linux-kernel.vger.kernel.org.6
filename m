Return-Path: <linux-kernel+bounces-533893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4387AA45FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59A016E0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF81448D5;
	Wed, 26 Feb 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="n6TpBZ6E"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7C4A1C;
	Wed, 26 Feb 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574839; cv=none; b=E+enumym78vJq1JM22pWkBJUC0FNBi64CoATeNIGhogRdxbXr3o4pv9DmL505ENrG8cbrebOt/f2fqLot9yfRxuhLruThhsWL3a/U1KPocFgRMtMLdOKTRhBhgbr0HebquKbD5AMEzy8Knpl5JGi7AD2lgGXEZhMWD4Q9VImBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574839; c=relaxed/simple;
	bh=uK5DfTcav53FQCKhHviaCB54ExGEs8Md5849A3/Wplc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PTLHZ+jcuPXL3UnqU9MnlVKWtHx4TI8a/QYnYhDUm2eMF7kjOPGkFqOJpVBNT/M4NTrbmV2ciu3Mwl8x+EhpXFjTUkACoSuuUqXYD33O2gYdRfwhXHLpKLzyh8YEAQ0NiN+XhsrvdUYVAy/PJBmj7S6xug2tPq+Vdf890X/waUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=n6TpBZ6E; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1740574824; bh=s6A55YiTxDcOpJY45Qvvrq+Jjpo7e5VcEP+85feVteQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n6TpBZ6E/sG64y3/SpJfSB+ZiWB2YsbsCdI4B/vo07yLOOLST/U6KU3599F8FyrlO
	 Try1uwMdo+47BBMD7sn4U+SKAxXPsCam31Ku4RzY5/J8aycz8vUCsr46dX/xj5KWS1
	 /U8aV3buvEuAtDZb66GSnuSqSkd9l3i2EiXnkwVQ=
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  =?utf-8?Q?Ma=C3=ADra?= Canal
 <mairacanal@riseup.net>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  Danilo Krummrich
 <dakr@kernel.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno
 Lossin <benno.lossin@proton.me>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 1/2] rust/faux: Drop #[repr(transparent)] from
 faux::Registration
In-Reply-To: <20250225213112.872264-2-lyude@redhat.com> (Lyude Paul's message
	of "Tue, 25 Feb 2025 16:29:00 -0500")
References: <20250225213112.872264-1-lyude@redhat.com>
	<20250225213112.872264-2-lyude@redhat.com>
Date: Wed, 26 Feb 2025 13:59:59 +0100
Message-ID: <m2bjuolv3k.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude Paul <lyude@redhat.com> writes:

> I think this change got missed during review, we don't need
>  #[repr(transparent)] since Registration just holds a single NonNull. This
> attribute had originally been added by me when I was still figuring out how
> the bindings should look like but got committed by mistake. So, just drop
> it.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Fiona Behrens <me@Kloenk.dev>

> ---
>  rust/kernel/faux.rs | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> index 5acc0c02d451f..41751403cd868 100644
> --- a/rust/kernel/faux.rs
> +++ b/rust/kernel/faux.rs
> @@ -19,7 +19,6 @@
>  /// `self.0` always holds a valid pointer to an initialized and registered [`struct faux_device`].
>  ///
>  /// [`struct faux_device`]: srctree/include/linux/device/faux.h
> -#[repr(transparent)]
>  pub struct Registration(NonNull<bindings::faux_device>);
>  
>  impl Registration {

