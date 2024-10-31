Return-Path: <linux-kernel+bounces-390197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE2C9B76C3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1576B23EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39BB19753F;
	Thu, 31 Oct 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze00NFzW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198A119581F;
	Thu, 31 Oct 2024 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364662; cv=none; b=Ov+mLAguYgLTdlGi1IijfkPlPhP3TMyqCBdxa/qd8gQOpnB2bPuPMrzW+mHT4ReFZx+VXMPY+e48GNAV5R8hS7zv+qIPsZfTjNq0abpKJpH1iN49f+KMPTsO2CA7wVTZeUc6bo5EDALcyzMof1x0D7EXaLnnWt6vBohOcS6RX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364662; c=relaxed/simple;
	bh=yQzl9Z7XI1hNGcRFzwce3+wTJUhB5Z2qyakn5jWwZ5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C8pmC+Rv0enn3Z0sSK8FydYoHufDq87p10GTtq16xY+/6c1LzPmgz0uqYjqwNgsPjC+nvjmcoJ6CTygzPjn3Tz+4JlC4ReDKnh8A6KI28pHEBNdpXLRAtVHAVwRujRAygTVdyKsYfnYm/We8cw349dDEMZo4skesQiVhk7P415E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze00NFzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A898C4CEC3;
	Thu, 31 Oct 2024 08:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730364661;
	bh=yQzl9Z7XI1hNGcRFzwce3+wTJUhB5Z2qyakn5jWwZ5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ze00NFzW1HvZoO3WqAHJXJXn3Q1OiwV8kXPYWsNFMl52TUU1GPsD/nq/I/Gdch7WL
	 d1l+e3iu7l2xqhi9zzVK3CA6HSNWX1bhUW7RhkRhxBwynFP0vnNC0xlWlDMxUZlv05
	 cMdNABKLlT6L9hx9p3kk8J//KpApQ9EBcDIr+cWbEbmf87517OlTPW6J/Fc6769a6p
	 +NUwCfkUu3rjbAWVACSVRvL2wSxYtuKfGsBafT02PAZgxnycijEjWI25j/VJlGvO7c
	 fUQ22Ept6FQdv3bd3vPmyfP5Qxj9rud0b9NCDAyoJ/C8S0mIN6RAP99pZpr+nfO8cU
	 md4+TZDMzEiMA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] rust: change `ForeignOwnable` pointer to mut
In-Reply-To: <20241030-borrow-mut-v1-3-8f0ceaf78eaf@gmail.com> (Tamir
	Duberstein's message of "Wed, 30 Oct 2024 16:46:40 -0400")
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
	<oVgFAmT8rBrdYoquaCoUcWKqIOVnct8QxS55ZI1D4l0JhpL-VlkH70vlCZEqdmjcc1If4w0vrQczFHWPPVopMA==@protonmail.internalid>
	<20241030-borrow-mut-v1-3-8f0ceaf78eaf@gmail.com>
Date: Thu, 31 Oct 2024 09:45:39 +0100
Message-ID: <875xp8psng.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> It is slightly more convenient to operate on mut pointers, and this also
> properly conveys the desired ownership semantics of the trait.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>



