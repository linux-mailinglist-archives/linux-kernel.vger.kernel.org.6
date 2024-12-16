Return-Path: <linux-kernel+bounces-447201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F479F2ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B556F166AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3494204564;
	Mon, 16 Dec 2024 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSQMmRCE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF52040B0;
	Mon, 16 Dec 2024 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347109; cv=none; b=VD47fLCO9BR5Dbi/SJDOUjSFE3zePuQ6HlFxoqDFD2U3EqlLJYGjjdh8lyKwnfxtUgD1YERmAQJH2F5KvnrhUqqAVb+aCpCCP3OiBtP6krIZmvFCQg3EK7wug8GomJPjKMDPk9111Y8A4GzA70OcAa7o4/1rAiy65S5tnkSPcVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347109; c=relaxed/simple;
	bh=gHGs/YYq62ir4jy8HEmxhcnPeXemMMlQT5Iqw73s42I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XrBePy9iq5M/GmHw0vVuxxC5lUuD2k7G8ueGPB6mVYJkXuG1Am6PTmbxm/f2XYGluUuRTCPpT/LbdhLpjFIld+8g2DhdLygnWwYsZSLQJ4AZBqij9JKxwthU/1a+aBxbOrLK8zaEjimLRcZEtBR/R4kSDqlZt2zHzBgrT/ECSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSQMmRCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D5AC4CED0;
	Mon, 16 Dec 2024 11:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734347108;
	bh=gHGs/YYq62ir4jy8HEmxhcnPeXemMMlQT5Iqw73s42I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VSQMmRCEPL5rU2DSy8O36rNVSB2JXos9uQerJcZ4keh5ggdJpI+a+Fy/uox1P5+qJ
	 gXupG9RoaRt51MIuyifTacwEuUsfIsZTcthJQIDBXMZlo4wErWGaEuCnnUchOg8VWY
	 LrTLv4kj0tj4djMpE50TV3JEjfs4D9hosVnVimHuXyLlyljFtDT95iRAV1Mq3+YBGb
	 E44myIopwT7QXLtAtA8Qik51OSc33DpKk473Eq35MG1PjlVk0Ravg3abqwMA47QGJL
	 boEXxVZCk+jDlgBZZoao6TkmqP3IAZ1vCewY2IgQ6cBOHlXdGkpX8tfnrBLR911T75
	 gD0AWO/WY+jHQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Matthew Wilcox"
 <willy@infradead.org>,  "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
  "Vlastimil Babka" <vbabka@suse.cz>,  "John Hubbard"
 <jhubbard@nvidia.com>,  "Liam R. Howlett" <Liam.Howlett@oracle.com>,
  "Andrew Morton" <akpm@linux-foundation.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Arnd Bergmann" <arnd@arndb.de>,
  "Christian Brauner" <brauner@kernel.org>,  "Jann Horn"
 <jannh@google.com>,  "Suren Baghdasaryan" <surenb@google.com>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v11 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
In-Reply-To: <20241211-vma-v11-0-466640428fc3@google.com> (Alice Ryhl's
	message of "Wed, 11 Dec 2024 10:37:04 +0000")
References: <nGnC07PmUqofHiX7HfZAOCIK1-CPS7DF8kdGhDgJgPts5KYrCrimmovP-4YMVgI7WRmFnGwbdndTtxCfp278cg==@protonmail.internalid>
	<20241211-vma-v11-0-466640428fc3@google.com>
Date: Mon, 16 Dec 2024 12:04:39 +0100
Message-ID: <87cyhrdh2w.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Alice,

Applied on top of v6.13-rc2 and tried to build:

error[E0277]: the trait bound `ARef<Task>: From<&CurrentTask>` is not satisfied
    --> rust/doctests_kernel_generated.rs:6884:22
     |
6884 |             creator: current!().into(),
     |                      ^^^^^^^^^^ ---- required by a bound introduced by this call
     |                      |
     |                      the trait `From<&CurrentTask>` is not implemented for `ARef<Task>`, which is required by `&CurrentTask: Into<_>`
     |                      this tail expression is of type `&CurrentTask`
     |
     = help: the trait `From<&Task>` is implemented for `ARef<Task>`
     = help: for that trait implementation, expected `Task`, found `CurrentTask`
     = note: required for `&CurrentTask` to implement `Into<ARef<Task>>`

error: aborting due to 1 previous error


Best regards,
Andreas Hindborg




