Return-Path: <linux-kernel+bounces-534805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DBCA46B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EA718893C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338D2571A7;
	Wed, 26 Feb 2025 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnPSJEZ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601AC254B0D;
	Wed, 26 Feb 2025 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599266; cv=none; b=Johu+CncLxxlASRN3JbNwgBT0NVCb4fFO71/Vct6ewS59sfMHcaa7c52SiMQnDgDvYq2lHJfGS3UbEqPX28HOJXXPGlBqSDRJ1x9H0ilZ1IVGPbVyOG+4uhyjccPF/tP8mgRf2qMjDJFL0kzxRJrPQoadftN3f9c6meKKu1SZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599266; c=relaxed/simple;
	bh=V9197N6CGfd5KndKFNoOcNl+vscmQovE5yP2/IiyHjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h3apO079k6piW5tMPa7GbcAZpjL5trEtqR67dChw5gsTua6LcWVjVzUQyjIR89vt6mR6z4J8R75Mcv8iN1DqJeIxFda0UDEU5FLhEKMXDMd6dEd+gWnXw6ZzLCFPBM+GsG1tHoHS9Azy6K5lGMKi/PEc+r5VT7U0EoWc4E+CCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnPSJEZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50112C4CEE7;
	Wed, 26 Feb 2025 19:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740599265;
	bh=V9197N6CGfd5KndKFNoOcNl+vscmQovE5yP2/IiyHjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OnPSJEZ9d7OEESSiCcr3UhTbXFn26d+2rKkYW8bn6IHsi49CS1rCa9cnlvmuw1w0A
	 FFz93VQl0e2MF0oXiVd/Z04yaTBLC0wkQ+Zc8iE9qHJITgLrjZU8LYRPX4Mb0nquQC
	 VP80ELYWD5mDy9C4OKkEUvGxkjBMIiN6Ku6y8M3NPeW4ByCN3Z+C4GfD03eHseo3K/
	 tCij6y/81LmoMm4kq1LVPNsJq9w0sAlwuRVzMHq2Tnq3rHX9/zYxvYuMqcZvUUXsjM
	 PR/ql/XwGxUTl8NbzTJoVFhVoXnNCK4T5LK6gEuSmM2i/VCMPWKetfIM3/Y/gLUUs6
	 ZwcvZPNj7TO5A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Anna-Maria Behnsen" <anna-maria@linutronix.de>,  "Thomas Gleixner"
 <tglx@linutronix.de>,  "Danilo Krummrich" <dakr@kernel.org>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  "Benno Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 13/13] rust: hrtimer: add maintainer entry
In-Reply-To: <Z78-mVAHdSq1zbJr@localhost.localdomain> (Frederic Weisbecker's
	message of "Wed, 26 Feb 2025 17:17:29 +0100")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-13-5bd3bf0ce6cc@kernel.org>
	<Z7yT5XU5gAm0ZCZD@Mac.home>
	<-IS9lsmszi-aq2CWaFfNbL-E3g39lgaOyL68jPoP9XDFF-HtVPiQ2IRi6-yjiaJiXBkO35Kmkp-uKkNuTRkrMA==@protonmail.internalid>
	<Z78-mVAHdSq1zbJr@localhost.localdomain>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Feb 2025 20:42:02 +0100
Message-ID: <87r03ktrw5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Frederic Weisbecker" <frederic@kernel.org> writes:

> Le Mon, Feb 24, 2025 at 07:44:37AM -0800, Boqun Feng a =C3=A9crit :
>> On Mon, Feb 24, 2025 at 01:03:47PM +0100, Andreas Hindborg wrote:
>> > Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Al=
so
>> > add Boqun Feng as reviewer.
>> >
>> > Acked-by: Boqun Feng <boqun.feng@gmail.com>
>> > Acked-by: Frederic Weisbecker <frederic@kernel.org>
>>
>> Frederic, since you've reviewed the series, and we certainly need your
>> expertise here, do you want to be an reviewer in this maintainer entry
>> (to watch how we are doing maybe ;-))?
>
> Yes indeed! Please include me as a reviewer!

Will add you =F0=9F=91=8D


Best regards,
Andreas Hindborg



