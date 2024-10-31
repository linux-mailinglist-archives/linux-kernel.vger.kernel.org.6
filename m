Return-Path: <linux-kernel+bounces-390193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF6F9B76BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917B41C20860
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70D2175D26;
	Thu, 31 Oct 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+TVny2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737F8F5C;
	Thu, 31 Oct 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364647; cv=none; b=OOA9vZZmMGfqMuFqJvDrkWyl+BX13EPMe/K6wWvYuKiRUxZlqYzPF3fvnBs4s7WoGGzgpPM/ZWtu12kxbneWACqtijj5Gm/paGsr1wpM6H9WrPx/OzrOgAOKCzRsmH2Ain5Dy2G/fY0uCdHRBkFxd4/UVs0RY8/Zl4B5K6p3TNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364647; c=relaxed/simple;
	bh=qbpz47siUEARnrlketKibxJ0cZIORWeeIBhValxZ+OM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qs12glaMws773z8PqekAr2y9xdIpJk9NVt+arTmqF5M7ZmYqx5VDViKBD1lEPk14vZhdFQNps4y2yhP7loL+P1i01NK613GVg0clz465B9F2m10gMO30n3EN2tXGgKNP4Nz/Qu0BYUWOI50Xg69MJdn2jMDW2VNPlHZGpiXu0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+TVny2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD619C4CEC3;
	Thu, 31 Oct 2024 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730364646;
	bh=qbpz47siUEARnrlketKibxJ0cZIORWeeIBhValxZ+OM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o+TVny2WTL9/ZpHleLatWDyhwM30Ct3r2EPCpkbphtoICNoBwF1EZv6Hanzo1MC0I
	 4i5if4dcRdZliVGv93Kphna0JOve23JSjrKA4s1f1YOdeu4LlR5N3RDfmro3v8tuX2
	 pNZKSG4IUtTiTDl3vurHMpTieJ6dxiGAzNA3UX2EPG+7FIXQnZYPv8FMdB4dnxNtl2
	 fW+/EvL2YOnv2I/lDoVvAhPDBLF7uJmjkNK70X0enwQOqpmGbLneKmoMZCticMkd+C
	 jFQBVeKhxcptcB7hEiwGLhXZDISSim8Hm0lSoDWtyVWM/YLeIz7KeAfyHov2mZN45F
	 Kf1ugu4slOlOg==
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
Subject: Re: [PATCH 4/5] rust: reorder `ForeignOwnable` items
In-Reply-To: <20241030-borrow-mut-v1-4-8f0ceaf78eaf@gmail.com> (Tamir
	Duberstein's message of "Wed, 30 Oct 2024 16:46:41 -0400")
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
	<Pn1b5OU4cqz38Aiv4RL7MuzPDwDGvxLVRrLuCF7Q3_HaeLzlh4jaM0krBqB39DCFmRLWK59Do8DPaVxLNaaTNQ==@protonmail.internalid>
	<20241030-borrow-mut-v1-4-8f0ceaf78eaf@gmail.com>
Date: Thu, 31 Oct 2024 09:46:22 +0100
Message-ID: <871pzwpsm9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> `{into,from}_foreign` before `borrow` is slightly more logical.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

I don't think this change is required, I would drop this patch.

Best regards,
Andreas


