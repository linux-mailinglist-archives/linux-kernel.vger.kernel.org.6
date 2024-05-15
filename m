Return-Path: <linux-kernel+bounces-179586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B0A8C61C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787271C21CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80BA446BD;
	Wed, 15 May 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fBh8nkRi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsX96VWV"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D342061;
	Wed, 15 May 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758498; cv=none; b=l5l02ae6uBLiiGSuqedtNsds/njp/KhNDoK49XI9t54JT72p7+gQmRYEBmf78Qr4ji8XCzqX7ShtUar2qJ8nkZIL9Nq+2q/bpz4eEaj0GKh7TWKCuySFsiX5LxhN06CQxN1cAruer833rXuIIYkylLy4LrteNBUoH7sHd5BX7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758498; c=relaxed/simple;
	bh=o0K8SOZhFFx3AbDud2mrFyHDdGrcVFTLMD9MdfObI+0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=T1gtPYyMWuNmwoPeuEV2b98s2GeOonp/ShQIUc2u7FNP49cB5wh8RzlzXo3eXHIob5nMBDUPqG9dzjwI7dhLw2Tb963e6bHUhn9zlVGvCdmZrYD6cjejcwqeqI5RLvqEYG/Xnsz1IDgt7jQB4FGRAfqYfhlYfy6J1yDmlL+Ndqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fBh8nkRi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsX96VWV; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 664B51C000EC;
	Wed, 15 May 2024 03:34:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 15 May 2024 03:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715758493; x=1715844893; bh=vYBANP9AhE
	/d4SYDAtFqOYHR51zF89WgGBJY4yYfEbU=; b=fBh8nkRioN2mg4e68WVi/3USgv
	+hXgKI9+wvlzhnDN/BsJAkWcdpd4vm8XxJ1ytSeV9eA5dJPGsYAHiwAWKBkiqI0o
	Z/nnMXdhVsQeu31HeBjkvfsw4y90IS20zEd1XXS6LklsF5IhWirTXBibO9GGpTgO
	OosXcJG1YXO9uhW/OiIwAwyLnwrbLzE+TxQA/ilRj2/eS/eK/TQ0iElSpEJfQx5Y
	1kprX8MUZlkdQcPwZoG5tK67SyZ11d0Y+W+D3vzDK86aTsXACzwjRQBt6v2o8OKh
	r0lyugNyjYdec86oSIv5CyPIKMxBXWEstiyFwNtQAKa/87HigMWHWSmotCrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715758493; x=1715844893; bh=vYBANP9AhE/d4SYDAtFqOYHR51zF
	89WgGBJY4yYfEbU=; b=AsX96VWVBUDft5ySkos/jCnMBF+Jq5h6nP2QvMhrDCL/
	J27ZPMy9V8syoXKAfZN3bHQuKnpvYsBH7BfF81NGWq6bzD2/y+tM+zLjaZk8qh1K
	78uckXnN7U6hMCOAMlC+rL3VxX2ikeqlmpUZx3hw1zRAu8toxyTAjgCZsfvc3SY/
	BnfGNNpX17ggOEbdYUm5gmpyq703jVGoQPvs6QVDKKZFzr/NLZkUWWnC0k7lW4g7
	9idkhMwYDmCMjSuLxKXqlkx8UaEsCUmC72B2YKc0wsUAnmYwGrq/G8Du5vrHHLuF
	f4fV/bfY4HWal34oyDp92MK43avjyJTOfqfo3GId1w==
X-ME-Sender: <xms:nGVEZrTWXeO-r8Q2ZkDMO7k0wgBnmpFJZfBVoLPZoN4K5RgUU9bF-Q>
    <xme:nGVEZsw-wGtDI211XsS1nUc5k_52Ue7M9J3DuiTYGDWaZD_aJJTbfVPIm1zFmGZ--
    egzIGyEPXDnfyvkTAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:nGVEZg1dtlyn73t6SSZDCWleJ4f6fVHqNX91Oh4wgX-ZF2ZFc67Cnw>
    <xmx:nGVEZrC4HqRqXaolYHiHL0fI16fXbFBLc-0kAJaKf34bECT17kXqmw>
    <xmx:nGVEZkiHhpkzRvcSRDMRhoZ111s-M0KagK3KST73zwXZeDYopa2EBQ>
    <xmx:nGVEZvrlGOP-h5H9ccuKDmycdu6Mh7YZOUX7FBImidU7sEv-K9wGTg>
    <xmx:nWVEZrTJGabmz0WlGvhGr4yxxbHT4SGICnzcZ4SHDhWNLtrMqiCUSkAv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E9B46B6008D; Wed, 15 May 2024 03:34:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-455-g0aad06e44-fm-20240509.001-g0aad06e4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ace5ac5c-88d2-43be-9236-11d3913886b9@app.fastmail.com>
In-Reply-To: <20240514102757.b7034966a58e6cf44d75dc7d@linux-foundation.org>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-2-cb8f3e5d688f@google.com>
 <20240514102757.b7034966a58e6cf44d75dc7d@linux-foundation.org>
Date: Wed, 15 May 2024 07:34:31 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrew Morton" <akpm@linux-foundation.org>,
 "Alice Ryhl" <aliceryhl@google.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Matthew Wilcox" <willy@infradead.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Kees Cook" <keescook@chromium.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 "Todd Kjos" <tkjos@android.com>, "Martijn Coenen" <maco@android.com>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Carlos Llamas" <cmllamas@google.com>,
 "Suren Baghdasaryan" <surenb@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v6 2/4] uaccess: always export _copy_[from|to]_user with
 CONFIG_RUST
Content-Type: text/plain



On Tue, May 14, 2024, at 17:27, Andrew Morton wrote:
> On Thu, 18 Apr 2024 08:59:18 +0000 Alice Ryhl <aliceryhl@google.com> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Rust code needs to be able to access _copy_from_user and _copy_to_user
>> so that it can skip the check_copy_size check in cases where the length
>> is known at compile-time, mirroring the logic for when C code will skip
>> check_copy_size. To do this, we ensure that exported versions of these
>> methods are available when CONFIG_RUST is enabled.
>> 
>> Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
>> on x86 using the Android cuttlefish emulator.
>> 
>>  ...
>>
>> -#ifdef INLINE_COPY_TO_USER
>>  static inline __must_check unsigned long
>> -_copy_to_user(void __user *to, const void *from, unsigned long n)
>> +_inline_copy_to_user(void __user *to, const void *from, unsigned long n)
>>  {
>
> I think it would be helpful to have some comments in here describing
> why we're doing this _inline_* thing.  What problem is it avoiding?

How about

/*
 * Architectures that #define INLINE_COPY_TO_USER use this function
 * directly in the normal copy_to_user(), the other ones go through
 * an extern _copy_to_user(), which expands the same code here.
 * Rust code always uses the extern definition.
 */

       Arnd

