Return-Path: <linux-kernel+bounces-553916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C08A5908F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F9E16732B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8227A2253E4;
	Mon, 10 Mar 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mRItwu+f"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D022371F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600818; cv=none; b=dB5n1AA2YNKbrGVKk6rh2dbLc0+GfBN3Ncn6eSQNDGc80EKJotvEMdiq7r5A8eucxRqvLO5BT6KmolCF5Erv2k1e1Uj/8dtu3ks4ymddMAPlWIMrs3DzrL3m2uOwsjfM3TBXztp4VcdJ8K3aLimc+Zo8tAsOdC+jsvdsvICNltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600818; c=relaxed/simple;
	bh=zXA6vQFhc30A7EU2VUj2nZ7hAAlciGqFu6RCAmOQkjU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSi/ZAE1OL56dTI9C+kL/tJ4rFnJqE0W+E+hCwv4pCSPoRTc1jcWIGlzNWpu7j29lOEXgxmk6PWSnpBLFrMfphEBsOirqBJW4n1LzgPDDhdh9xlFeVc4B2AodzFRwuoBHNw2lZQmD+yMa8xvebQYcIeDY16O/OJQFAQ/Osola+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mRItwu+f; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741600814; x=1741860014;
	bh=zXA6vQFhc30A7EU2VUj2nZ7hAAlciGqFu6RCAmOQkjU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mRItwu+feXHR6uwlvGrye8dF/nrVBJGOJoTrgwHMG/+ozqaqcV2h31nseBmqm4vf7
	 3+1lhWzFb1d4c1PxSkdlZOjQxvCr3PA0gq3hO2BJdwhW2ZYCsC4O+LVoWV1Fe5hHd1
	 /LWTmoVaInOGhaBoABrFv4A91xqpCAv6a2Dl2C9nQ+nDkjuLMboai6WjDyyC2K+QDk
	 IaqjlRyyv7bptnQGtX+CcHnQyeWlnOYz90QWD4Pa1NxKCViUufydTmBFehi9ppe0qC
	 5sVCsyFBcTpI923s4XSyMwp6y6Npb7bggQqFuPeePKNBJws3rxMnuMHRnkxmY+VXtf
	 ATUwX/Wotah8A==
Date: Mon, 10 Mar 2025 10:00:05 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] rust: make Owned::into_raw() and Owned::from_raw() public
Message-ID: <Z864IGPJ-v8Ttt51@mango>
In-Reply-To: <Z8618XEgG1yNvppk@google.com>
References: <20250310-unique-ref-v6-0-1ff53558617e@pm.me> <20250310-unique-ref-v6-2-1ff53558617e@pm.me> <Z8618XEgG1yNvppk@google.com>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 03bc40ba1dfd58add8200b81e1d5c65fbe446f86
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250310 0950, Alice Ryhl wrote:
>=20
> You can't send a patch by others without adding your own SoB.

Ok. Sorry, didn't know that.

On 250310 0950, Alice Ryhl wrote:
>=20
> I would probably just fold this into the previous patch.

That is okay with different authors? Just leave that authorship with
Asahi Lina, then, I assume?

Oliver


