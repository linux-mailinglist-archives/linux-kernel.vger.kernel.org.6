Return-Path: <linux-kernel+bounces-261068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E493B28A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE591F218C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB9C158871;
	Wed, 24 Jul 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="ljto731+"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791F134DE;
	Wed, 24 Jul 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830805; cv=none; b=ArFaXjqGW3RgSPgP9Xgp5KBkZ8aW/xS23Ys+NQcrBuk4XcYIGVBKBDrcdUmAZ20aICg9JlEojjN4SJcGXT+sNzBBDnkZ6i1OGc9M2mHt8tgeMO/k1bkfnaG9wmyufhgK/hwDl3K5hYIfS6guNmJY4buQi8F4F2SkSUSWf31IQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830805; c=relaxed/simple;
	bh=nduDyf2mVkpF0BlMR/ZRgIDySlcytzfUVo4agrG7pkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goYCO1hd7bI9VmysQj69E7uclAn/+aSwP9mIUfNz/6pkIGVvH3+rBadIlgegjYGbIphmWpF7Kg+9kW4CoE8NnIxqk8ZadyPuudVZf+MoluPw7+tteXU5f5u61k7SqjK6DRORoqFolELiwibXX4qlzEVZzmGFMP0/ypFIK1T/i0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=ljto731+; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valentinobst.de;
	s=s1-ionos; t=1721830772; x=1722435572; i=kernel@valentinobst.de;
	bh=TMTfYWXz/lWprUxH5gsNGWYkVZFiwdN4scbxDLAk3i8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:cc:content-transfer-encoding:content-type:
	 date:from:message-id:mime-version:reply-to:subject:to;
	b=ljto731+GNzYIE4Erea5pH4JNAlHOsQC2bHNyPispyUv4w88gHIiPFmr7DXrki5t
	 sfbBD2WqbqQjXT2Vdqbr3J9HYioChQMHontLWDhCZMRhApQLm2F1h8KzaK8oLSeXb
	 DF/7HHmlKFVcTlETHlNGOOse1pxUhtGlQBsKnixOzZknJIIeXLrRS93Elvn5JVaqG
	 Wehs6ImnEYjdVugZyRUpjz5ReEwhHpai9sG3K8elG+sNRiiuAQJOBOFja0zTt0VIL
	 sp6QP2ZuT7Di8pZj3w4RzDxNBMgm9V1Z2m5kbZkpgWFELlRDMFmWmWM1x43Mz2x00
	 +qEQO85zc7aI+2q4Pw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.guest.fkie.fraunhofer.de ([129.233.182.128]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MF39M-1sUT6K0z5E-002t0d; Wed, 24 Jul 2024 16:19:32 +0200
From: Valentin Obst <kernel@valentinobst.de>
To: alexmantel93@mailbox.org
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	wedsonaf@gmail.com
Subject: Re: [PATCH v2] rust: Implement the smart pointer `InPlaceInit` for `Arc`
Date: Wed, 24 Jul 2024 16:19:27 +0200
Message-ID: <20240724141927.8232-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719192234.330341-1-alexmantel93@mailbox.org>
References: <20240719192234.330341-1-alexmantel93@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:D6IlgZA0q+aRZgcfTT4F6NENMPE8lXcPzKcX3NZ6ZcWCUYcuQmp
 VQ56BXGWUZiV1utEvPSBaPQdxUuJnx9ZWovyBJJedJGBM6tnxOFBU99rhIOddmUHgwi83yy
 CrP5/83dvhSqAwh5IovaKBMuacr8Kxg+pA8EIY90jRIhcclr8/35kAGdh1sJkwZ78Ry6fDt
 GRFghKHplAkPJWgaA6KFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:40b+vTKip3I=;9tyIQlsFSwVpKAzkQg57ryTi/nf
 frN6nO78DmCZlx4xqgyH92xxApPIzCMdTlcPF4MaHs+AFHL+ZqQxeeCts/kDzn6fmmNRZb9Av
 ktqTkFcXNonJ+t/B/e7CckrWv+3WmdIyTYO8ae4HI9k39K50SM9iBa/7hyQ6brWiPNs/CBSgE
 tRVfMl0KkFCmJQekBJoGKH7Z/yvead1CgWbZap/tS6WxrhADljoz7nf/34jogodZjLnsqJv60
 nMtMyVoXtBOKgD7sIlU0bz6dU5P2HiYF/mOLE2nmJ2ZuUJCdMo9USCQe3rDtq7aVOmLpX5pFE
 pwItF547yoKH2HzUhdHd1vPkAU0+Ld91mJZ6/lP8jMj9ImlDXreX/lwly89MSAUkSaKkvyw2y
 Jq4hbotCyYDoOBnEacpSDmccdKj5WQWGaYxDe2k+n/6t6s3rHHxyY8s+NZCXwPZmF6TnlbyDj
 eo5+YZdht9GsRlJIRlkEv34YkIWXmEZGQjc4WP8qVO8LIU+gbtUkj8w6lhTongrPFMQ9Oi1mT
 syg0u8uwCUNSa4SXFLFWXo9S5IED27Mh6KI1o2WXE6bVyVszdqympkAvsw+RieZRYaKUIE4Ys
 NYbtjm1+/Olg4OH48gXbQYnXHNHgpNMtvwHkztVj12W6DeXKLJIuVRnyJWnvEcwqqlZclCsIY
 xVSLZcZKPR/Hfc3iJz/yEJYI6LCABB9XRTOVg40MD5QBGI8LSG2c9b30sn+2HYM7+mIDoDsdU
 dZ02ADwxkNcp1LXUp1QTLqY+Hx0he90/g==

[snip]

> @@ -1112,11 +1113,15 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
>
>  /// Smart pointer that can initialize memory in-place.
>  pub trait InPlaceInit<T>: Sized {
> +    /// A type might be pinned implicitly. An addtional `Pin<ImplicitlyPinned>` is useless. In
> +    /// doubt, the type can just be set to `Pin<Self>`.
> +    type PinnedResult;
> +

[snip]

nit: Typo 's/addtional/additional'

Apart from that, I think "When in doubt, ..." or "If in doubt, ..." are
more common choices than "In doubt, ...". But that's a question of style so
feel free to ignore this comment.

Rest looks good to me.

	Best
	Valentin

