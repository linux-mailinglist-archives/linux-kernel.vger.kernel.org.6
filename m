Return-Path: <linux-kernel+bounces-559024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380ACA5EE79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135CD19C00C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F14D2638A0;
	Thu, 13 Mar 2025 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="dAmceuPX"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B434261588
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855882; cv=none; b=nbwBL3JH0fdpLZD9AYuBPVwXv9DfKp/nNWwU/vkFq/WRyxK5TvEb2wBeucg8pDNULgi9JyR16733/YyCxg4tZgU9qjOEi4aHWiQ9E9MqndSXpVQdkhnUL/OHsFaxkMhqwSj2J6JUAeuK8FaUuPy4h6waDSc7U/4t4QoIlmmmON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855882; c=relaxed/simple;
	bh=fgep6nm3VTiNPFBIpkJTHVkLiIgi804k7tW0VYVRhgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JspttmApOhZBhdwgVjt7JCSnZRQb8DWp+th4mCb9+CvmcAS0ygPRwO9GB6nB94uHIG3h8bW9UMB/e6L/wiNpSpkAWjntTYMmoF7Ev3fWqcxGjtSPF0Igh4LWg1dLoejO+t6Iaq3SCx5GHq2H0XIc+erPH0wCGY2zZkOcOMoQgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=dAmceuPX; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 139FD240029
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:51:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1741855872; bh=fgep6nm3VTiNPFBIpkJTHVkLiIgi804k7tW0VYVRhgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=dAmceuPXGzYmkyQtxQ0DKexexE7KFvaFeD5FSPOLJYkvx/a+CIonXm5lhgV3BTcV2
	 eiyeMQRay6K6+RTX95vUYOJvAyqS2Y6fr6NYIgdAsCEkTu7Jkk5ab9/IOZKpWibIEc
	 5zeGpn2X5Wj0laqL5ZNbHtNA+l7dAKIy5bmsdd0ZmJ8QzM4OvTRgdKXtItUkWS6M/a
	 uU7ThZOOv2BpfNilOHXIi6mhqdd2U4g1/KvPtXBzODVJzde1YRFyz/en7AyOZnU93/
	 XxWGryDh1ez+JPH01jIs3/UCGJlb5P2rhQgWxA4Wv2ZEIH964mTQetRniabBmM/bZk
	 6lesnrmYRkGBw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZD1SF28SDz9rxT;
	Thu, 13 Mar 2025 09:51:09 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Antonio Hickey <contact@antoniohickey.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Danilo Krummrich <dakr@kernel.org>,  Benno Lossin
 <y86-dev@protonmai.com>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: enable `raw_ref_op` feature
In-Reply-To: <010001958dfeacb5-9039aaab-6114-494a-9f1d-f13982091169-000000@email.amazonses.com>
	(Antonio Hickey's message of "Thu, 13 Mar 2025 05:33:52 +0000")
References: <20250313053340.405979-1-contact@antoniohickey.com>
	<010001958dfeacb5-9039aaab-6114-494a-9f1d-f13982091169-000000@email.amazonses.com>
Date: Thu, 13 Mar 2025 08:51:08 +0000
Message-ID: <m234fhco03.fsf@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonio Hickey <contact@antoniohickey.com> writes:

> Since Rust 1.82.0 the `raw_ref_op` feature is stable.
>
> By enabling this feature we can use `&raw place` and `&raw mut place`
> instead of using `addr_of!(place)` and `addr_of_mut!(place)` macros.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw`, `&raw mut` is very similar to
> `&`, `&mut` making it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <y86-dev@protonmai.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Hi Antonio,

Maybe we want a cover letter for this patchset? "--cover-letter" if
you're using "git send-email".

--
C. Mitrodimas

