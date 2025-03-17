Return-Path: <linux-kernel+bounces-564025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3023FA64C56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B4716F023
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65931236458;
	Mon, 17 Mar 2025 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8GWI8JZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DA233141;
	Mon, 17 Mar 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210556; cv=none; b=DKvF7JONLTNhgRf5AiWoM8Jo79eme9SiyoBrs7BoapOiij7JIxWRB6QbqoECNUgphsPpXv4JyhHiOZZCScrWD+UJeDDdqcM+7TzFN+feyrrSno8gRURBoWALjwmjh8BIYFJemQ9AIb2f9z2d7FRVgJJ8FT7TIcEo+cWaUwKX23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210556; c=relaxed/simple;
	bh=SANJtUkZ0zwsElokWUpyA/lX4b4roCBs4fJGQpMCpcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AluCnxoapbK1P7mqncr1jytLQlqS7fKIQNbqnCKeDqhXY40w06PA70/heEDSRjwVJPhXmGm7N3xKuzdOKNBsuXPxLL8OOW+A88AylGALHrG1W9kQCghQW8LBJZx/8hsPieKHlsQ0bmhbDbiPXTURQI93zwIkUXUt97ZKJiuWtw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8GWI8JZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1016C4CEE3;
	Mon, 17 Mar 2025 11:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742210556;
	bh=SANJtUkZ0zwsElokWUpyA/lX4b4roCBs4fJGQpMCpcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8GWI8JZ+HeTApLCk80aRuEwLf/ZcRf1cxgV7Dw+G8slkW1NID62OgyejEz5o4mp3
	 VVvVZJBbnXKxIZHcbmdc1ABfMCmRsAXRUCo5Z0iSRLvtHoRQ1OCI9tYwjB4G/lmflo
	 RaZR7y+rpv0zXAIKI9LT5gVIC/slbbBqowWMVfezaTXWGnDoWvznE28XpDFYpyqM3K
	 NtlS4bSDikZVYjusyTbSz9+T/sBsYvkxE5gSjyrZhn9nGGPKX/yU8zFYRbfEdycmUV
	 OcZ8qQ+P/o2Y7EHr0jRI20P0bsPrVX8jRKP8lY3UmcY8O5MLzSJ0uIIPAz8W72KKxm
	 NhUPbRY1SbUng==
Date: Mon, 17 Mar 2025 12:22:31 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <Z9gF90wPSZTRQfRR@pollux>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
 <Z9dTspva0aJRWG3Y@pollux>
 <CAJ-ks9mwuLaULKW0cwD73yb3yH-p9KS3ZFoJJ3OxhvUOpXo3KA@mail.gmail.com>
 <Z9dYnSC13ruc-VC5@pollux>
 <CAJ-ks9mJYyJK7iQz+qS2TnwNgTqp3rRWGTv6hiPhJ3v6aWsLng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9mJYyJK7iQz+qS2TnwNgTqp3rRWGTv6hiPhJ3v6aWsLng@mail.gmail.com>

On Sun, Mar 16, 2025 at 07:27:22PM -0400, Tamir Duberstein wrote:
>
> Does this suit?

I think for dec_ref() it is not the safety requrement that justifies the
invariant.

I think it should be something along the lines of:

	// INVARIANT: We drop ownership for all elements within the range
	// `[self.len - count, self.len]`, hence the updated value of `set.len`
	// represents the exact number of elements stored within `self`.

> 
> >         // INVARIANT: By the safety requirements of this method `self.len - count` represents the
> >         // exact number of elements stored within `self`.

Please do not use the email quote mechanism for code snippets, it's confusing
for readers to figure out by whom it has been written.

