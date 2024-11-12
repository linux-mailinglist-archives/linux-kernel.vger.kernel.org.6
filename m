Return-Path: <linux-kernel+bounces-405701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB29C55FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C01F259CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88D21E136;
	Tue, 12 Nov 2024 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vADAEmDr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976321E12B;
	Tue, 12 Nov 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408595; cv=none; b=bM2if8oYSK7it0ZWM3GTNcu1N1ykNbodyt5G1qJRAwdHK6yEU1Cn4eYhjnopJdvIoS8Y4btT6ei879zlM61xAjc50cbmdbei9w9ROUJf/G2A0HXbMREbhyVumHRC4dH8PY7NRqrOIj5fUDryOH5B5z8sQm9BXV5TQreRByTJAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408595; c=relaxed/simple;
	bh=5yWyMoNHH1PJWy+5Izypd/cN0xc9MD9o2gOD4qKkVh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0jhyoZa9nCzn16IlnzLxqQrsPPpJml2p3YIZY5+y+aI/oiYKNNapNybMPye9LzKktYHjOIuYJosiiWr8/UMf6r7eDCqH2EzO8t720XsWWn7CyzTlTrpsKrpdXs/Q41CndgDVhPrcIQ5gXG7IIGBYjoNgnbE26xJ2CYSdZ0hh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vADAEmDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D4FC4CECD;
	Tue, 12 Nov 2024 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731408595;
	bh=5yWyMoNHH1PJWy+5Izypd/cN0xc9MD9o2gOD4qKkVh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vADAEmDrN4aU/kBFxCaLrs0wmzF43IGwsZVd/wPO3rivIzpLMTJY2fsd7W7f7xvRD
	 qahuje3wOpVXgAjSNYx/kGaUMUfh7Jg4Q0zCt6R6OnSp0XxsISQ5YgsBuI8PqW1swv
	 sBgROHsoRSq/Ol9/SywwdYBM2Xsj0NuXzcCqoo/tc5N0t6A9cjyuHm0Pe77t7mJWuw
	 TVfzxRVTkJ2wesAuLLKva8UxKVEyANn++56c4vlfweIRyAiRtgdA70gKlDlXTi3KTR
	 aQDt2wtNx6hJoTauklctWWDEu6rnA798HO9Lu1ArbPQmAFB3Ffb7f94sizHrLTN2Us
	 atoaa0t8JB1Vg==
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
Subject: Re: [PATCH v4 1/6] rust: arc: use `NonNull::new_unchecked`
In-Reply-To: <20241110-borrow-mut-v4-1-053976068215@gmail.com> (Tamir
	Duberstein's message of "Sun, 10 Nov 2024 09:14:02 -0500")
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
	<p16-2qRFB0ZRxKXeBi8cW0nd43KuMCW7J6lGiv4j_mLhtcKx7i6rFob2Hrg-OBwhrv-Iu8fbgr3MG_CvZVxAdg==@protonmail.internalid>
	<20241110-borrow-mut-v4-1-053976068215@gmail.com>
Date: Tue, 12 Nov 2024 11:08:09 +0100
Message-ID: <87a5e4sr1y.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> There is no need to check (and panic on violations of) the safety
> requirements on `ForeignOwnable` functions. Avoiding the check is
> consistent with the implementation of `ForeignOwnable` for `Box`.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



