Return-Path: <linux-kernel+bounces-538109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5906A494A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C767B3AF04F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A362580D0;
	Fri, 28 Feb 2025 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ9n4SuA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA2257AE8;
	Fri, 28 Feb 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734342; cv=none; b=Gc5qQVxaPYJ+zgemtskI/NkPr/SY25HN2lQ0Ui2M+vMEmWRBeTGlPgsbWxaddC7ncqOPSFp3vjUQ4BCNjFn89EH1n5XiZ7iPLZakC4yCTS6ZD/SHwWOHl1wOPd7yFne1danJtywUkG4eA/IwHfqp7DNlMaTx/Qf/5d1dTBKVVIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734342; c=relaxed/simple;
	bh=A25tAOF8LWK1knSivsYAeHkV8bvcON0THzor7i3KpNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kZUdE6/agYF4MCyn89fjIFdgV4asgsZgZlhvQpaNIeExDhZ+RRcU99Jn+CCy2Hrgk9MD/2Axyn7iwAjUbAzA7iYhKOObHuRnmL4XKECc3wBpX9UnEKvnmaYg3cj7oWUaHfwCuFeLIjSnBFTp+1QkyWqZfUsgw8hwqDSDXbrvHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ9n4SuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ABCC4CEE4;
	Fri, 28 Feb 2025 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740734342;
	bh=A25tAOF8LWK1knSivsYAeHkV8bvcON0THzor7i3KpNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SQ9n4SuAbYUG5cK3GuLC6Jw53T9Fk7t5QzujB7vK7BFIV3+rgPTYCRGB6Oru3uuin
	 4FnrbMCgNN2QZMzHpgW7Qo15+ZI7cTSOkpKtqo815rNxoCeEm8BPlpliWNDvl5W/bO
	 KxUGxS8YWm1KagDqsuezs3xthzpMNRaaBhwiNI7hNU9sB/SaTgXQ7W6v90DIp8Q/lv
	 ccEJhs0z5eH/OOM8U7n42azhnvqsBEHGjAWImyEtzVPSiKEhh6qYvFm5OnavYvPrK8
	 GaewI4/0qms4BZqqnJ5fmhFw5yDaDv5GnHA3X92nC/RlbtNb1ckjR5I6ID/rzLd7By
	 6vyFqEJlh+mHQ==
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
In-Reply-To: <CAH5fLgiNs-VKEQduL16eymSPnqA0_6aR8WDRYm68SE8FXGDHRw@mail.gmail.com>
 (Alice
	Ryhl's message of "Fri, 28 Feb 2025 09:46:32 +0100")
References: <UXTosjUFv_CKOV-K4oqNGBhMEv64tds9NgXWhHEYdCHuKM2qSPFrpBnTqhFGkcbv5_KXYERykIXhn-sYnEeuUg==@protonmail.internalid>
	<20250227-export-macro-v1-0-948775fc37aa@google.com>
	<877c5apmdi.fsf@kernel.org>
	<n_SgeABndEnm2Yl1urxt15OBDGbfaY4y8M_DCt06Cwoql_kH-ErUfE48HL1gXbCy0eTa7sKHXdHmhyfuJteS-A==@protonmail.internalid>
	<CAH5fLgiNs-VKEQduL16eymSPnqA0_6aR8WDRYm68SE8FXGDHRw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 10:18:14 +0100
Message-ID: <878qpqo2ax.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Feb 28, 2025 at 8:19=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>
>> What is going on with the cover letter of this one?
>
> It's empty.

I can see that =F0=9F=98=86 Would you consider making it not empty?


Best regards,
Andreas Hindborg




