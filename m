Return-Path: <linux-kernel+bounces-546438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61100A4FAAE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A641668D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F32063DB;
	Wed,  5 Mar 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKB1NeDW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E0205E00;
	Wed,  5 Mar 2025 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168391; cv=none; b=RlyDVTQ7PyGCEgwty0pfO3AYvAcffBRBbLbGG+yQD2/w3Mb+SX17PakF46YB+7/Z2qrb3aUCYD+uA3BLVcAO/P6kyxuI9mIh7Iw2eprzuM2BwsMTjCuWR8oSQ5XU1i21MykcrOilNAyXsjjh/IOLeuGzCJf/0Sn2pguZ1NUjESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168391; c=relaxed/simple;
	bh=ORz+k9E937zUXxSM6Mdl+BAqe5cpwM14R43zz4VgLrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uRKBD5Un8vmEk5j47p+Fbdd7BHEjsGZ/IIKZPEjl8doYwNPOKhxHEWix7tCsEzUwiv6LgRqyJVEw/atPuSqI9asMCe3T3gPYH2CeCtGaYxAHkFVEqTQz8x6GBcQOMR1rQO5zgW6RvgSwFyysdQM2kUOmYnpdgs4dlWsBcS9bcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKB1NeDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9CAC4CEE9;
	Wed,  5 Mar 2025 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741168390;
	bh=ORz+k9E937zUXxSM6Mdl+BAqe5cpwM14R43zz4VgLrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iKB1NeDWNmuScpb3n5W1BaQ8klO8hyfRkGYytMV56R0mYtC7DHOTCx10SN2kLXxwM
	 ZK6so1KgWXrF/EBqsQdPYdIyFNyU3nYsytmf9vbx/Cqv3RxYi5FHwcpZ8rP9/dS1Se
	 /IMQl7o9vbrJtv179VkUkinuX46JF4l9E33iYJP+o4o9dqTrfD7mM6oiCDxl/I+r3v
	 fN93lTd2BQPLrn+YHgCng4m5TzwsMqBR/lxxLggYuLRH6vH8BPanZyEsjDGCAUcfhp
	 aX1+8b2Z/qWhA145O3IvSXgco/xoHyBnweNEgCSqd5l0xDpuchD30FQDuAbuqh46ut
	 yJPcq41B045TQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 03/22] rust: add extensions to the pin-init crate and
 move relevant documentation there
In-Reply-To: <20250304225245.2033120-4-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:26 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<WfFbEdgY77_F8Av10-sYEt67FhgZBBdxKadOSC-iOzAoK2YvI9JSuaOBybuOyZT-nzpRubp2llVQcXbmE_Ffow==@protonmail.internalid>
	<20250304225245.2033120-4-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 10:11:00 +0100
Message-ID: <87eczbg7vf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> In preparation of splitting off the pin-init crate from the kernel
> crate, move all kernel-specific documentation from pin-init back into
> the kernel crate.

This patch **moves** very few lines. The additions to init.rs seem
either copied or new additions.


Best regards,
Andreas Hindborg



