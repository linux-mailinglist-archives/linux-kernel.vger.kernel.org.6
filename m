Return-Path: <linux-kernel+bounces-537880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A54AA4920C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183B816AA98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B01C9B6C;
	Fri, 28 Feb 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGkTi2JR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB01C82F4;
	Fri, 28 Feb 2025 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727172; cv=none; b=aNqMLwK39INUNklI7kXBMdi4ZXYvPi4agET5xHUlyREsV50o/Co5+Jb2GSALrvv08bswS1RiJc6CAtYlE+a+7UhQSB5A1kaRBcmetqylrEmx1co8nAz+sDK34cHQKsNOcVq2eDP+rqYO8mh7dnZUwiK7HkEgao7fQQ8SuploseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727172; c=relaxed/simple;
	bh=JFPGqxxqRZkkHMQpC6NAIa713K0DriM3Y8/V0d2b3W0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mKgjp4D0AOaGtRlziri2Zs2S4/dcjdBXk4xI9UXY/HTpV3xFQ19u9Nwso3gekZSSZSG6LKeTYTavEMG7UmyZGGIXRqdheUjJJ8wQ8pVnhlc8vbiQPU10wo8TRgg6k+nhDbQwIkF/UhJhgbc7j/apBTIZo2BgmkpLA3cVjkfrB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGkTi2JR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51005C4CEE7;
	Fri, 28 Feb 2025 07:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740727171;
	bh=JFPGqxxqRZkkHMQpC6NAIa713K0DriM3Y8/V0d2b3W0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OGkTi2JRhOOArxzG+LxU9tpIASg2gvYH6FbZwiiuzMBbl07sxlnrQo9gCgdEO5IeF
	 ljSqEDkSOLVeeNvOj0iyn+CKGGCVh1KQOJzMCScbluO4SCH3JG6GGuPdsaMYDphwsl
	 6/YicYgBSbdCDsrDDmmYSrCtJMTIB+zLAemEWt9GtvLxZ4V3T16ioQ5a6jhsXToMki
	 Lj1mUXThClyKc0K7bNB7+Lvpq8mH4oNhGHlOrGz0COIvx+3/6mxlciuJbtY5w2IGMG
	 N6fBbgNDMWlPB82y1b9QCxXmqQEn4A9E3s2W2IC6S2drmmzs50B9BBhN5Pu+GOlw05
	 YbOs34rHBEXsQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Petr Mladek" <pmladek@suse.com>,  "Steven Rostedt"
 <rostedt@goodmis.org>,  "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>,  "Rasmus Villemoes"
 <linux@rasmusvillemoes.dk>,  "Sergey Senozhatsky"
 <senozhatsky@chromium.org>,  "Andrew Morton" <akpm@linux-foundation.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,  "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/4] Check Rust signatures at compile time
In-Reply-To: <20250227-export-macro-v1-0-948775fc37aa@google.com> (Alice
	Ryhl's message of "Thu, 27 Feb 2025 17:01:58 +0000")
References: <UXTosjUFv_CKOV-K4oqNGBhMEv64tds9NgXWhHEYdCHuKM2qSPFrpBnTqhFGkcbv5_KXYERykIXhn-sYnEeuUg==@protonmail.internalid>
	<20250227-export-macro-v1-0-948775fc37aa@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 08:19:21 +0100
Message-ID: <877c5apmdi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

What is going on with the cover letter of this one?


Best regards,
Andreas Hindborg



