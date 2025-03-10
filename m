Return-Path: <linux-kernel+bounces-553966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83708A5913E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425673A49E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1FA22578F;
	Mon, 10 Mar 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO02dZpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A52F28;
	Mon, 10 Mar 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602740; cv=none; b=bkk/HMNwB832uIxy26hbq59rgR/ens3XaHU0AHJoKSa2lGnHy9Yo2/XqFxeWs/Mj7xvbBGCfKCrh7+EWu5Xsf+StINXKZgSKa8uDYnGoLXZgeGskEu1kQ+aSd75YdSX2d4rl5FXzfU5ySb0JeaVjnftCR41wcTjMTgThqlnOh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602740; c=relaxed/simple;
	bh=fUWz8WRb4GOZ5o+XsLB94MiJRReEzG/TiZP/RGCWmmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7ABiGN12J07J93OZ4mLZ8C7BACsc0xarIGckzriEge7KAD+rQ3nJvpStFP3/Sw3ExFMtgW9R9o5cUYGUBlyHjDCaxDW2NwQcYnDGfHMWQEcWDVIzZ2H3v1WvCIqwD+oae6Lo8ZmUQ/HucuasiDSiOwG5QcKEC/AksOCGLrviKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO02dZpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0A8C4CEE5;
	Mon, 10 Mar 2025 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741602739;
	bh=fUWz8WRb4GOZ5o+XsLB94MiJRReEzG/TiZP/RGCWmmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tO02dZpIHwVRSevTsWb171M6E39+8E9x+VU1f9sIziOiLGaTb8urKCk/e8shkfQ4s
	 NcEdsQ1+Q24QQTISPQ7oi74rjIjoWqj3UuiAGLjvnENAWXKjQUausPJT+AShjXX3qJ
	 MEHw5aH/COrw2CzWgx93CX4hDndlpmsvGuNRyeNAYEOuMPIzatUmPiPVzLSSoY6iG4
	 VgGFPbilCwnHe5EmXW/i371xnAvuQiR4rkCExnMUK5T3J96XpGbdCeQVIb/EEf8XeQ
	 9QrSlmHI/pCadmEiPHgS37V2WNO2zaK+zNpArR4qD1g7dx7OQ8CLOPss6tgZsnTdpB
	 qhkQR9aSRIy3Q==
Message-ID: <d9072bc5-7dc9-400f-8115-970887fafaa0@kernel.org>
Date: Mon, 10 Mar 2025 11:32:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] rust: make Owned::into_raw() and Owned::from_raw()
 public
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310-unique-ref-v6-0-1ff53558617e@pm.me>
 <20250310-unique-ref-v6-2-1ff53558617e@pm.me> <Z8618XEgG1yNvppk@google.com>
 <Z864IGPJ-v8Ttt51@mango>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <Z864IGPJ-v8Ttt51@mango>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 11:00 AM, Oliver Mangold wrote:
> On 250310 0950, Alice Ryhl wrote:
>> I would probably just fold this into the previous patch.
> 
> That is okay with different authors? Just leave that authorship with
> Asahi Lina, then, I assume?

There is a 'Co-developed-by:' tag, please see [1].

[1] 
https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

