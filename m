Return-Path: <linux-kernel+bounces-546875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EEDA4FFF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F167189A919
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197F24889C;
	Wed,  5 Mar 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJiX8chl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF01FCF4F;
	Wed,  5 Mar 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180128; cv=none; b=JVowwGlThV6HUCork+LMmLQji/38wtqTsQiKCO+Wl7Trb1O4tvfMIvPcnn4hSuDUNoZ4glQp/UVDhlfMfFqPEqm3p24ayC3cx2VZ1b6pISWnRxnHWITi7iZAKh929xnzIVAkpBFhNLR3u2ElYVJNJowaUlCQ+oHi+4UdI5mUVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180128; c=relaxed/simple;
	bh=E1opgwS/ce43fl3V2dWSSkVOtGCFbxhC7zLz0/gCWmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q5sW6byZORKm5LSUcbOlQ4vMqmm7PO2osADDsgfYH3BL0xh1uM8Rnosc6TmnPtj1OaiFgEGlCBdNkZZckUEPZGBXBxQM1/DQ0McLocGXxETEJZ36ib10mMVo1QEXInb7GPWsMvPxZYYD6OJUL1h86AoV3DKW8Hvj4hohw1C4hm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJiX8chl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A89C4CEE2;
	Wed,  5 Mar 2025 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741180127;
	bh=E1opgwS/ce43fl3V2dWSSkVOtGCFbxhC7zLz0/gCWmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oJiX8chllCwriF4mQmk1is2DUiB20Xfvsf2eVncdYgrfECCmPFQ69Zn6Ne7ieF1rU
	 BtdDstkzcFWwghQo45fHwkAEvR6yQNSazG7WLfA+6oOKgA2DGwE+UGRv462SjOMK4o
	 XG8caWQ4ox6JUts7zV6CP3qrFwwTftF0Ln1Lb63jVYzzApXtVByUg4xhZnNYz+Uo4U
	 grvwMDXCPGd/CD4IEVnCBTIlMRYnYPmCSpXNmQVD5+DsKl7jx6ePZJWlOuE1e5UeBu
	 Ry3NRRDSBU+GEXRowtZ4TTKHspG6NcrTuvIcyenU3E4Ek9ET2lwd0k6td9jSy6r9VM
	 sOgmw2j6Ue0Cw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/22] rust: pin-init: miscellaneous synchronization
 with the user-space version
In-Reply-To: <20250304225245.2033120-20-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:56:02 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<hCdz_iDipWW3ePNJFAKA8_lI64CwhD93gRLKeWrodZzjvVZtpJe7D1J4qDqrLguMWRyBIZ70MHkLlkOSy80XFQ==@protonmail.internalid>
	<20250304225245.2033120-20-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 13:57:19 +0100
Message-ID: <874j07bpow.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> Last differences between the kernel version and the user-space version
> are removed here.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




