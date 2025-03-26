Return-Path: <linux-kernel+bounces-576706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F674A71355
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D963B4465
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4C71A5BB2;
	Wed, 26 Mar 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq9hxf+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83A3D6A;
	Wed, 26 Mar 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980076; cv=none; b=CjJxa81yTX88Iesyx+2uSmtSSWtfAuke59ab3K5ywSCpfbfhtdfYqvM5+6gn7c6nVYePeuB1cJhPTaOm/yrM3TIzY0s9nVpSBnPbuumkVGLu65GFdKa5UDUXhJ8SttTWYNLEJBV1ieCSlj/cvAqWNMKX1eZ4XX7aXJBV6BIPQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980076; c=relaxed/simple;
	bh=L2t5HFJDwx1CY7bwvfOQjamBPEOLVGzjYbHFYv4C6Q0=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=BzelFgx7EzP06M4E9z2Y+coajz99xuZKOsu23lwgDKWa0e+YrV3FgDBedOpVvon427mgeelL9xo8lPYTmCuZ5L3ldU+L96ddQb0GBX0ewh21kqGJOvopjFKLq+MC+21yW+9SK43iyv+4RuoXKI7Oy20V6CMjg0FqDYhx1AY/zlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq9hxf+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88876C4CEE2;
	Wed, 26 Mar 2025 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742980075;
	bh=L2t5HFJDwx1CY7bwvfOQjamBPEOLVGzjYbHFYv4C6Q0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=oq9hxf+7poeUYApJeYHubRoEgnedRmnqV0fQlahZbYb/2lBGuig2LNFrrlqlFDIZz
	 xa9tPInKWCXWaSKrga2ZQ5BDztLvuvrwX4c88dYp3yfBb4oV1olTV97zgWMPRMMh++
	 ct5fUpkhf4/agpNWeLt2GTrSMOhUaHJ2sUjnrgnhYdyWfKLUnVDAS5bUC8GsyWCn5V
	 RhaKL6KcC/N/XAr6xu4a/ZD2POvsgikeWiPsc2mfvlQAE1a8i4InTNxSAF/vB7688y
	 9eknAEdR7MGDroi/WDWr2kY9BM751PZW9PE8ADejFJCYyMa+mredV0r7blnsh9/4hd
	 aeEpyS/H21XAA==
Message-ID: <5125a08fb0a028a4152a64dd8f194434@kernel.org>
Date: Wed, 26 Mar 2025 09:07:53 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Subject: Re: [PATCH 0/2] drm: Make some resolution info unsigned
In-Reply-To: <20250325212823.669459-1-lyude@redhat.com>
References: <20250325212823.669459-1-lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Benno Lossin" <benno.lossin@proton.me>,
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Maxime Ripard" <mripard@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 =?utf-8?b?b3BlbiBsaXN0OlJVU1Q6S2V5d29yZDogYig/aTpydXN0KSBi?= <rust-for-linux@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 25 Mar 2025 17:27:03 -0400, Lyude Paul wrote:
> During the review of some of my patches for KMS bindings in Rust, it was
> pointed out we have some areas of DRM that are storing resolutions as
> signed integers when it doesn't really make sense. Since there's no real
> usecase for this and it's a bit more obvious when writing rust code then
> it is in C, let's fix this.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

