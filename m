Return-Path: <linux-kernel+bounces-521369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64414A3BC56
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E401188BE03
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7561DE895;
	Wed, 19 Feb 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXkD/RLj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CD1BC073;
	Wed, 19 Feb 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962982; cv=none; b=QHLKFlKrUzCiuyc2W8x9RMnZoozwitfgUmW84jSK4CEbVoUcK3Dt4bd9YoIaH+VBgy3+Uj7QLykF1+V8cu0CpN+5OD5+4NYpH+4GARgGPugrR/R6Fh+tzXe+uwbGPDtLQYJyJo80tk1YZsnxg7EPAVugO5wZfCnqxZFQKFNswE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962982; c=relaxed/simple;
	bh=PT9NekV6XuKrP6wh8rR9069lh9ESAmFL86gNbFjzKCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T0WqYOaINnilxZlg8CY3/8kcUcEV2UTU7nSVxKVfEZFySfHHGFlD1A9zGcF/vfOr5R3OA5lbsOissHLgutqTUNMEgXM56EnBkOacd72hf/R+dFVKsbk4R67Kqai5uFTiOkGjlSln+IhypELhPNoF8OENwTyOVr4Cj3Qm0d305iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXkD/RLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384D5C4CED1;
	Wed, 19 Feb 2025 11:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739962981;
	bh=PT9NekV6XuKrP6wh8rR9069lh9ESAmFL86gNbFjzKCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qXkD/RLj01q7p4stwr4mQzb03CHRRVSH/paJNq4FGip3PSgszwxaqnbvPg1D6MWe7
	 C7MxFReG4LAnOTNDRMMvSd1WEIntbeefk1FQmlpLzj8itiBJFwOR/0PZaNLuf06GW6
	 1Mmw8khMk/oaQQ/nv/fF1JMPniswj9mHIf+aBwhhcs8x9EooHx4r+3TjfcBAOwHZhr
	 p7hQNCDZTTUzJNoraH3lzwXJ2lRYGa9aP1KUIQb5LwEftnVHY1CQompq3wAgjsWAL3
	 5TZwulSEEZGNuD5JjHtJ4ihObulVQfkfcqdaDjVZOyUWzIfryyWBWOP0YXalicxGXN
	 TEqGuJrSPWhRA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Frederic Weisbecker" <frederic@kernel.org>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Thomas Gleixner" <tglx@linutronix.de>
Cc:  "Miguel Ojeda" <ojeda@kernel.org>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Lyude Paul" <lyude@redhat.com>,  "Guangbo Cui" <2407018371@qq.com>,
  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Tamir Duberstein" <tamird@gmail.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 00/14] hrtimer Rust API
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	(Andreas Hindborg's message of "Tue, 18 Feb 2025 14:27:05 +0100")
References: <aIJ0ymzdUceCN05hwJpth4erH5u2SHYzYl52wGeT3uiO9bdk92ZkEmEEq9a9NXsInJYSz9uziwq-1fvdsXoeDA==@protonmail.internalid>
	<20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 12:02:50 +0100
Message-ID: <877c5mci3p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andreas Hindborg" <a.hindborg@kernel.org> writes:

> This series adds support for using the `hrtimer` subsystem from Rust code.
>
> The series adds support for timer mode and clock source configuration during
> timer initialization. Examples and functionality to execute closures at timer
> expiration has been removed, as these depend on either atomics [3] or
> `SpinLockIrq` [4], which are still being worked on.
>
> This series is a dependency for unmerged features of the Rust null block driver
> [1], and for rkvms [2].
>

@ timer subsystem maintainers: did you discuss how you want to set up
maintenance for this yet? As mentioned, I'm happy stepping up to
maintain this, but if you want to handle it with existing resources that
is perfectly fine as well.

I was hoping we could merge the patches in the near future. The patches
have been on list for quite a while now, and I am happy with the shape
of them. They are in my critical path for merging dependent code in the
rust null block driver.

Let me know if there is anything I can do to help move the process
forward.


Best regards,
Andreas Hindborg





