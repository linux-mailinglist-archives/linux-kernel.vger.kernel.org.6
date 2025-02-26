Return-Path: <linux-kernel+bounces-534429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9C5A466EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312FF17F5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37C5221D80;
	Wed, 26 Feb 2025 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNTEV8UQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1981F16B;
	Wed, 26 Feb 2025 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587492; cv=none; b=j8oqQw7OU/wP1mTQw/HKJPDW60+UDWq3L++jTNA/re+X1zD5NpM047mr1MPYity5s4A1olnkU1PPv+gAOP3qaeAp5RyCUrhQ/tCdJncSf4ivQ/QlvKDyFZTkZpmIW+PhjZdMcbu6FxFr/UNjlojiD4lb4EU7GOmwHDdhCsEVIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587492; c=relaxed/simple;
	bh=fbUyMbVzemgHgNjXulx1F/b+A8SvYzgDEV9k1ywZNr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEGNPgBTtR+b0IRXJQLbvQshzE1IzZ6ykheNulRTKZlgPr3kBV4GfhXCPHaaiZO//DtzvN4p6svTTLiVHS/NO5uGhXtpcHk7vnfnn/Meb2TkhzznsIsvVq85swNgYVjlcnozoubSog8bGa9dTlvV98T1QDTtwMa3WngZ+Eo/AWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNTEV8UQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689E0C4CED6;
	Wed, 26 Feb 2025 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740587491;
	bh=fbUyMbVzemgHgNjXulx1F/b+A8SvYzgDEV9k1ywZNr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNTEV8UQ3w24YfxS2uL9nYsCo2h26uXzC+2iBxJ4wI6zk8ghUfiZDM4PkSyqpGjIu
	 VwzzGVCfYRJuUwN2smbBoyQ0r1vjwvY8ht8mPeKMQgmVH2tlQJSH7+t8GX8vkdJYT3
	 1msT3nxeKjxSgvA62ZyCbNaHmpbNRSkFFsfKLXYX+ZgCMwylrx4BS7TJIbZFWpNGf/
	 zR5GcADgmdevAYk7qWcvPXASC5cdgi35rGmqetWoUXEs8HWirRQ8Hv/25XYUB4/AkQ
	 fzvX1gL09nMp5SZKd1CWhZvEzsEhoo/6BQSgLsOC8ndfc8pZ/HFjb0zA+LdlbiUUPc
	 dlEgOIMtp2h6g==
Date: Wed, 26 Feb 2025 17:31:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
Message-ID: <Z79B4brrB_-SBstl@localhost.localdomain>
References: <Z7yUTNEg6gMW0G7b@Mac.home>
 <CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
 <Z7ye0MsACNWe7Mbr@Mac.home>
 <CANiq72=qayfPk+W4BRiXe9xBGcgP2zPf-Q3K6GXTg8MKy-Kg=Q@mail.gmail.com>
 <WlwmQ3r8VXTu77m77jclUgLjPh65ztwxUu_mXaElarFHBBiG2kWi0ZLYWNxKAUF9LK2QYrOWhtlFYhwaaNjYRA==@protonmail.internalid>
 <Z7yl-LsSkVIDAfMF@Mac.home>
 <87msebyxtv.fsf@kernel.org>
 <4UoaifxB7JgBVKsNQyFR_T8yc3Vtn5TLAEdxdXrojNmOzJSEncopauEyjDpnbqzr8Z74ZWjd_N-bB-BwBS-7aQ==@protonmail.internalid>
 <Z7zF8KF9qTCr_n4l@boqun-archlinux>
 <87bjuryvb0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjuryvb0.fsf@kernel.org>

Le Mon, Feb 24, 2025 at 08:52:35PM +0100, Andreas Hindborg a écrit :
> > It's of course up to hrtimer maintainers. But I personally nack this
> > kconfig, because it's not necessary, and hrtimer API has been stable for
> > a while.
> 
> Having the switch is fine for me, removing it is fine as well. It's just
> an added convenience that might come in handy. But having this kconfig
> very close to zero overhead, so I do not really understand your
> objection. I would like to better understand your reasoning.

If you choose to make a such a Kconfig switch, it would only make sense
in order to spare some bytes when no drivers use it for example. But if
you're afraid that the Rust binding is on the way while the core is
changing some API then I guess simply disabling Rust would be enough for
testing.

I don't think it's necessary (unless it's strictly selected by drivers).
But it's your call.

Thanks.

> 
> 
> Best regards,
> Andreas Hindborg
> 
> 

