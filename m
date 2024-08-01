Return-Path: <linux-kernel+bounces-271476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E3944EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76EEE1F22D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D050F13BC0C;
	Thu,  1 Aug 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv53q9hn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50F130A47;
	Thu,  1 Aug 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524786; cv=none; b=qRSJNba0HIlUYFsekihEQ92yAcSpfQ4783Cl4em3/Fxag14uCMSrAc+B1R+HkGVxZnumYf/TQzruLNbKLSYXJanaPFCvMGouzC8Id624eMK5B7tTNllxCGzvcDr/gGO+ZmEDIeVUR6sVzWdJUsCxUpMvwMqj5l8QNik1gVXmWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524786; c=relaxed/simple;
	bh=KLKosC/0WnLSGu89H792+NzrL3mjfsS/fx01jQld8x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQLI9xBDHch5SJctKq2cpESOO/FLtzeM6psz3+3z1jTp/JzjTomMrC+1SQoQBfbFWfN8kH/j/id2MWYZX0abOw1SjDN5dJ8GH5v+PdheIfl/mInmBJlms1W4h7x1MFcRvFz33FHrr8+Gxr93AnLOnhegV6u0oeT/On7nHvJ5mfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv53q9hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73596C32786;
	Thu,  1 Aug 2024 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524785;
	bh=KLKosC/0WnLSGu89H792+NzrL3mjfsS/fx01jQld8x0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kv53q9hnJEzzIGQc3njWyI7718Nptnx9dzqqpd0GubVKk82APPFwkTlPA6WgDh4Hp
	 ZbIJkUc3TPry2uMPf/vF+X8nHFZB1n57P41Quo90W4SkFpJnWvXG1j5maZrAQOzPVd
	 jZvWhiIhZkN6TXAve5F1RcX5/S+s8Pzwa+mI9T1yvh07V3HBWnOhgknsmH0w23N1fu
	 hm+EdF9dCqE5rKOyzJuPkaf9PCxFqNbgtHhyzIpnfmkDKpGmRIgxlviJ8PJVOGS+tR
	 SXtGgke4ylWgViSryPSIfwGbE05H8VgB1YYBBfRP1Zmz4rZ9fAnbuJI1jX61E/QP7x
	 LVC2mvrMdsSoA==
Message-ID: <69dbff07-f774-47ef-b5d9-5b534f0cde59@kernel.org>
Date: Thu, 1 Aug 2024 17:06:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: add `ARef::into_raw`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240801-aref-into-raw-v1-1-33401e2fbac8@google.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20240801-aref-into-raw-v1-1-33401e2fbac8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 4:16 PM, Alice Ryhl wrote:
> Add a method for `ARef` that is analogous to `Arc::into_raw`. It is the
> inverse operation of `ARef::from_raw`, and allows you to convert the
> `ARef` back into a raw pointer while retaining ownership of the
> refcount.
> 
> This new function will be used by [1] for converting the type in an
> `ARef` using `ARef::from_raw(ARef::into_raw(me).cast())`. The author has
> also needed the same function for other use-cases in the past, but [1]
> is the first to go upstream.
> 
> Link: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@google.com [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

