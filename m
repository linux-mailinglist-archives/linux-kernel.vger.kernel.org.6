Return-Path: <linux-kernel+bounces-521201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1EFA3B81E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B55A3B0657
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B91E5B76;
	Wed, 19 Feb 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtr12H1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74C1DE889;
	Wed, 19 Feb 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956140; cv=none; b=Bg2Sqpseh62rcZATtScqn3y+jkwB2ltEzIP83Riz39L++TwjKPl8xzPe+e9b9mmacx4pDKLLGLrsByPx+QL3BkaOYBp+tSmyfwfoOTYhPAgj2+lRjTc2Hp9nOmfPqk+UgZhXM6TukX97kgDnr4jYh6hjwjTJRO6l7IU5jFZge5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956140; c=relaxed/simple;
	bh=rSLObtOYNhvEbwoHR+5gOiO7o0p1QXTJY22C2gSMTXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BXJDN0RwfEA0YVEN3HY6LM46IH9gljF7f5+iITAjBQU1v3Z+y7AO3dl6MMDP4p9c303THqcDMbfmjbKMbB7BruaY+htguMjRNEi+HqG5cFI4TAI/q/WWd+DyUhD04PZsugNnKiXe+pNXh/L+sQhDxFDMXah732htjnrOt7AV7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtr12H1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78249C4CEEC;
	Wed, 19 Feb 2025 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739956140;
	bh=rSLObtOYNhvEbwoHR+5gOiO7o0p1QXTJY22C2gSMTXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Vtr12H1GRzYENaEK4wQdVRf535eQVAMbGLkcePMXoZv9W3FCpva06gkuUw67YkmO7
	 KH9hjPmx2xqnuvHa019pC1Fj1+Zw3ZjouUTTjG5C+QXyJC13ZOaDzqfgUUW63nF/kI
	 Oe/5geFRm2W6Ud2AbeYYYkqL8mA/GXlKhld28igIlaJXw9Sm0CnN2vQ7BZYPbKRZOu
	 E/rQDU7S+zK7Or8CZT77BvmKzQNNB5FWUsc7LQKo75G3Izlxp219jDqq3HOj1C4s8k
	 ZADa5INYK5ghLn/UcCNoWdfVmj+LIsMwIpMt9TJ4v3bBLMt8jp8gdNBm/VsgBgBq/Z
	 WW/Pg+ezwMyjA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Asahi Lina" <lina@asahilina.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Jann Horn" <jannh@google.com>,
  "Matthew Wilcox" <willy@infradead.org>,  "Paolo Bonzini"
 <pbonzini@redhat.com>,  "Danilo Krummrich" <dakr@kernel.org>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Valentin Obst"
 <kernel@valentinobst.de>,  "Andrew Morton" <akpm@linux-foundation.org>,
  <linux-mm@kvack.org>,  <airlied@redhat.com>,  "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <asahi@lists.linux.dev>
Subject: Re: [PATCH 6/6] rust: page: Make Page::as_ptr() pub(crate)
In-Reply-To: <20250202-rust-page-v1-6-e3170d7fe55e@asahilina.net> (Asahi
	Lina's message of "Sun, 02 Feb 2025 22:05:48 +0900")
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
	<oRvzr1HN7fPhMdrzHGHQEpLWs7h0WF9FP7GgmaVnKlIXPWEV5OYawIagJ8RvmPHMaIvPsdxwO86vivlw3foqWw==@protonmail.internalid>
	<20250202-rust-page-v1-6-e3170d7fe55e@asahilina.net>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 10:08:25 +0100
Message-ID: <87ldu2cnee.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Asahi Lina" <lina@asahilina.net> writes:

> There's no good reason for drivers to need access to the raw `struct
> page` pointer, since that should be handled by Rust abstractions. Make
> this method pub(crate) so it is only visible to the kernel crate.
>

As I mentioned on another patch, we are planning to split the kernel
crate per subsystem, and this would need to be pub again then.


Best regards,
Andreas Hindborg



