Return-Path: <linux-kernel+bounces-557692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52E6A5DC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C0D174B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC80241CA9;
	Wed, 12 Mar 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="BOY2Sma3"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E241F4CB7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782132; cv=none; b=iOvunGrJCoHVIYnEizaxBqwJj7E3IxEJBSr+1peVw9OatY4QgrEpdR3JA8UeKx8mPxZ3F8FIwDYKsnx6/jDvnOfhCsRLT9cUbrgKKiWb8MveUPNIsJZSLViKCLsrRDEu4VZ5vPXLBpoy4Xj0YbU04C31kfmsSH94YDAjUEYd3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782132; c=relaxed/simple;
	bh=dQEshaF8/RAkmjZOcU+Ndz4W809g96rTGJPqMUi55/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ilgO2cPN1m+1JDyPzP+J5Sf0lK8XHoQ8am3KEHQW3RU5FVB3n9/hcAdMFlOPiBAh84wKQFpbNV+rigaUZ/iStSB12xCcz98EpHFQK1o9ZWRC9Jh2bhRrTOYf+6KTbz7Yj2MeeYPefoIMf7tOj+t0RhAYNIXkxE3rm1P8hpYC4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=BOY2Sma3; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 7C408240105
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1741782129; bh=dQEshaF8/RAkmjZOcU+Ndz4W809g96rTGJPqMUi55/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=BOY2Sma3SdrK9tloIynxvqBRNH7+t01cTHrkY4p0f4Y/X93sp82kS2hucoCtHL2d/
	 zaWoooaTW2Zt4k02KLC8K6lbsdgA0hLwpiWirkwqXJxTVYF8/IozmUE38KDG1miHLk
	 /voNSFH+lrUondtnF3fU9sYGfFh8n230o2xRvE40eyy7kuGc6+oYeEBsjDFWGGga/9
	 QpCY7Tv6wz2M57bQ4MXXkGqx3lvARL9rXagjjJufc8AkRGkyaKcNnjYzh8RiXzuVFA
	 Ym4prpjn1mr0Gq6G+ZXqSIjxzLtpqgTxt6AdFajMN8DiVgRlWm5ZizcC0vsnI0mS7r
	 Fwovd8M6rvEmw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZCVB51Jc8z9rxB;
	Wed, 12 Mar 2025 13:22:05 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Panagiotis Foliadis <pfoliadis@posteo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Nathan Chancellor <nathan@kernel.org>,  Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>,  Bill Wendling <morbo@google.com>,
  Justin Stitt <justinstitt@google.com>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org,  llvm@lists.linux.dev
Subject: Re: [PATCH v2] rust: task: mark Task methods inline
In-Reply-To: <20250311-inline-c-wrappers-v2-1-72c99d35ff33@posteo.net>
	(Panagiotis Foliadis's message of "Tue, 11 Mar 2025 15:05:52 +0000")
References: <20250311-inline-c-wrappers-v2-1-72c99d35ff33@posteo.net>
Date: Wed, 12 Mar 2025 12:22:04 +0000
Message-ID: <m28qpacuc3.fsf@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Panagiotis Foliadis <pfoliadis@posteo.net> writes:

> When you build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> toolchain provided by kernel.org, the following symbols are generated:
>
> $ nm vmlinux | grep ' _R'.*Task | rustfilt
> ffffffff817b2d30 T <kernel::task::Task>::get_pid_ns
> ffffffff817b2d50 T <kernel::task::Task>::tgid_nr_ns
> ffffffff817b2c90 T <kernel::task::Task>::current_pid_ns
> ffffffff817b2d00 T <kernel::task::Task>::signal_pending
> ffffffff817b2cc0 T <kernel::task::Task>::uid
> ffffffff817b2ce0 T <kernel::task::Task>::euid
> ffffffff817b2c70 T <kernel::task::Task>::current
> ffffffff817b2d70 T <kernel::task::Task>::wake_up
> ffffffff817b2db0 T <kernel::task::Task as kernel::types::AlwaysRefCounted>::dec_ref
> ffffffff817b2d90 T <kernel::task::Task as kernel::types::AlwaysRefCounted>::inc_ref
>
> These Rust symbols are trivial wrappers around the C functions
> get_pid_ns, task_tgid_nr_ns, task_active_pid_ns, signal_pending, uid,
> euid, get_current, wake_up, get_task_struct and put_task_struct.It
> doesn't make sense to go through a trivial wrapper for these
> functions, so mark them inline.
>
> After applying this patch, the above command will produce no output.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>

Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>

