Return-Path: <linux-kernel+bounces-277089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135F7949C3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E868A1C20CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DAC175D5F;
	Tue,  6 Aug 2024 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhlxMu/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8256A16D9B9;
	Tue,  6 Aug 2024 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986195; cv=none; b=kcXLmyoAmgpyQ43UV2PHGheFgNLnGGxRgADQN1WInOjvbdXWibfy6Y8+OgQ79zVpmggdrhZ+NO/BXZnSC5oXWH5ygLytdIsy7T/9s75HIvf9q1KHMMKQ/Tf3mTbcp4eNDYt715O7ww7/xmViDE+43z9A7TfXsf+k/I5K6AV1jbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986195; c=relaxed/simple;
	bh=8kkQ1wxUZ06yf6lZfRm9I/hc7QvpA+YO9fvbZin85KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yoxf9R5ehcKaO8QoJC4kPAeGYEyrJMP2MDlkamivFugtFsWdWsMzNuwBj5ZsBr/vJae9dQx8yc1PbvRPm2Lp55A4rLwKezGXVQ3LtO5B/pcgf5x1NsGNkpU3pXf10Xj6XfEHnDwTezIePM0wLV2ZWKMuJWW1aqS9GFBfXG0/uTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhlxMu/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFEFC32786;
	Tue,  6 Aug 2024 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722986195;
	bh=8kkQ1wxUZ06yf6lZfRm9I/hc7QvpA+YO9fvbZin85KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhlxMu/rfuQFBejOOhHAmgzNR2B9cmJr+MAb+7nmWGYl/Q2NpDUSBjwHop5k7gbTs
	 4vLDTck/f2lsXITihVwS0ofzaBIfpkSbHGAb6cKkbNYH1HxSgGin7M4cJxjKyLiRwm
	 zOcQPF0CLrrmhWxWzFNAehT3s3GMonlJbW0xx0W4uyFfy5sWLWi54/wcNgsy3P2sHx
	 W6JUxB+9jqbUe/MeahAUW2+yVWvxvrbbkZzrrc7sLtREXgXALthapwKOr2t6ququ3p
	 3nH2C0IeJyGkITuzN0lRw7E1ws4qjz/yLJg1Qr96fBFLUgdL8Qpkc9BieU41UYoHEm
	 MHbrsRclXUIlA==
Date: Wed, 7 Aug 2024 01:16:27 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 08/28] rust: types: implement `Unique<T>`
Message-ID: <ZrKuy--AoaegYrIm@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-9-dakr@kernel.org>
 <ff0826af-9430-4653-abe8-25fb80cd0e97@proton.me>
 <CANiq72mbrxFqqRMpdbuuOCy+mKtjFbLaSd-OVd_ntOeqaYRyzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mbrxFqqRMpdbuuOCy+mKtjFbLaSd-OVd_ntOeqaYRyzg@mail.gmail.com>

On Tue, Aug 06, 2024 at 07:28:45PM +0200, Miguel Ojeda wrote:
> On Tue, Aug 6, 2024 at 7:22 PM Benno Lossin <benno.lossin@proton.me> wrote:
> >
> > I think I already asked this, but the code until this point is copied
> > from the rust stdlib and nowhere cited, does that work with the
> > licensing?
> 
> No, it doesn't. They should be put into its own file with the right
> license and a paragraph about it, e.g. the other `std_vendor.rs` files
> we have (if it is just about `Unique`, it could go in the existing one
> at the `kernel` level).

Thanks for catching this, I once thought about it and then forgot about it
entirely.

I didn't know about std_vendor.rs, that's pretty convenient. I will move it over
in case we don't drop `Unique` entirely.

> 
> Cheers,
> Miguel
> 

