Return-Path: <linux-kernel+bounces-529123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59019A42000
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70373A2A01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5024888C;
	Mon, 24 Feb 2025 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qva9YMbF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C823BD0D;
	Mon, 24 Feb 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402648; cv=none; b=d+PkSMqVkZMddfRIOb43tKmudetdHtnLMhwRuQpezmogTJqp16B/WofFQh3JdNUDxz3YW4bZVHSreuE50sdl21ZewDJDmZ1Y/IiV3vUBfQ+7ji31Miyrvc0MfYvfTz9DV+6J713fjCn/WIna9kwSEYMDSSMiqJGq+tlMf61qufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402648; c=relaxed/simple;
	bh=PBau582VvhtnJFclRjLHi12BapGweedf8uB9eJ2Dq9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nbyUhA2REPrXRcUIweqp6MP0luIrPQHlXRMR6i5TjiVUbljja7ByHADF7sZL3zAmNkDXqh9ypiyZvUrrjQ5BihyYqolzMB/14EwbxlRuGR2ZzlCSv16SWhqfaxokKKKK0Cb963Gk1YXhMVr6Tak6jb4nx9RZXB3aqs4sp4ZHwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qva9YMbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2E8C4CED6;
	Mon, 24 Feb 2025 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740402647;
	bh=PBau582VvhtnJFclRjLHi12BapGweedf8uB9eJ2Dq9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Qva9YMbFEXvTbGgS4yMuLOPU8Sfmqa6jN25hfYtB2yF30458N8n3DunrQvA/Gsk6V
	 T8JYTciduPtUC0t/ZJSzXiI+jMP80AcuYh93LKl1l9B/A7nrD02MqBJ/5P8TDzfSBf
	 LwzP5KHProcoHmxv6wLH77U4FWCAOfEnw2Kr3tdixC2ipHVff5gJQqjl7ucLiFpnW1
	 6SVl/ANRdp7IhREz/T/XC15uQwrClMByrI5HmScBLlR0eCYfwLVAned2eu12k2Gdlx
	 URDkIqZjFelip7krvCsBgP2Al7ZCrz2yTwmuf2binm1BzM33bGL+Lo9/eTvrZ7J7NG
	 0zCUeGSi+XjZA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <aliceryhl@google.com>,  <dakr@kernel.org>,  <robin.murphy@arm.com>,
  <daniel.almeida@collabora.com>,  <rust-for-linux@vger.kernel.org>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 3/3] MAINTAINERS: add entry for Rust dma mapping
 helpers device driver API
In-Reply-To: <20250224115007.2072043-4-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Mon, 24 Feb 2025 13:49:07 +0200")
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
	<ZqCVkVqk7FRgXsPlmVTvY60tuLKASGbZbKBIbmRrUJp1BgxqWfMhOYfZAxIVR0RcdC6h8Sct_h_s3ALZMCPfbg==@protonmail.internalid>
	<20250224115007.2072043-4-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 24 Feb 2025 14:10:27 +0100
Message-ID: <87frk31oak.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Add an entry for the Rust dma mapping helpers abstractions.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



