Return-Path: <linux-kernel+bounces-529915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A1A42C72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0156B3AFD6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0A1F416D;
	Mon, 24 Feb 2025 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTE3lUKH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CACD189F36;
	Mon, 24 Feb 2025 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424356; cv=none; b=FmcTQvfWO+e78eZ0ph3NuMxb1JTZ4tCluedwPutNiJKeinhLPm++Cny1YfmtP2Kvoh17S6xqQEi8Vkj5vAwoSI42auJB6Tj++6sCRaWYI5LuQ5V4K215SdBL9wipyBYrZRShtu1GBuXpF/aYZPtZBKRsXMxshg/cvl/3rlcGzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424356; c=relaxed/simple;
	bh=9mijU7ARMLzdycQikCzbXlvLV7vede6tJUsdFDXNimE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BWotzWlt/JfCCsiY+nMzgHDWVl5Red6oIRXDi/sOqITBHgBIQ/07uuWCFcPySJT4csBol0QbjIaTvlDYx6YaPEi3W9yVnIG0JjJvTCzOSgJNzgnX+Q15lLRGiJ6aqHhAqN4VWAPkBeyB5Ch4uBMLP+1t52aauoYvO2xHTepZANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTE3lUKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0696C4CED6;
	Mon, 24 Feb 2025 19:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740424356;
	bh=9mijU7ARMLzdycQikCzbXlvLV7vede6tJUsdFDXNimE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XTE3lUKHUMsrOl7Uj3AJ7gA+6QeZtJzut/GlZ9M4xfXiRbDu/8BLUVmKfdPKtF0wY
	 KxQD401m3nZTa2DnbqIL70ciQJuRXw11GyAmSGPhRpIXM4xAv+VAULt0v/mLBsT6xR
	 huLlKcnnpAYC9KcyLGQAUm+IGnmw7rF54wri9WwGE947/HVjY8cGb+UEuiSW+8HieC
	 7upfm9x0ZohQUzXw964U0gKt941Z8cxySKJIvd7xcSbUbmCJHKIiXrao2QWW1SIr+o
	 +Tl3nSD1uvlUO/GrJMeKv4Wltt3B0TKxwHWTLOdSClGSfwEMyXxW0D7/byf/FAwbEc
	 d/7a+u5SXBdDw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Joel Becker" <jlbec@evilplan.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Peter Zijlstra" <peterz@infradead.org>,  "Ingo Molnar"
 <mingo@redhat.com>,  "Will Deacon" <will@kernel.org>,  "Waiman Long"
 <longman@redhat.com>,  "Fiona Behrens" <me@kloenk.dev>,  "Charalampos
 Mitrodimas" <charmitro@posteo.net>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] rust: configfs abstractions
In-Reply-To: <E12F1175-63AB-47BE-88E7-B6DA627DA8E6@collabora.com> (Daniel
	Almeida's message of "Mon, 24 Feb 2025 13:55:59 -0300")
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
	<t3HAgt6AmpyBH69nH3KwO6kyMs4Gj1LJYv4rOTc3EEjay2VnLr2kjocaUlyKbb3xO3bNHi4K9usjHEwAZpB57g==@protonmail.internalid>
	<E12F1175-63AB-47BE-88E7-B6DA627DA8E6@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 24 Feb 2025 20:12:26 +0100
Message-ID: <87h64jyx5x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Andreas, FYI:
>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>
> i.e.:
>
> ```
> sudo cat /mnt/rust_configfs/message
> [  234.971000] rust_configfs: Show message
> Hello World
>
> sudo cat /mnt/rust_configfs/bar
> [  335.542585] rust_configfs: Show bar
>
> sudo sh -c "echo new_bar > /mnt/rust_configfs/bar"
> [  382.114901] rust_configfs: Store bar
>
> sudo cat /mnt/rust_configfs/bar
> [  401.348487] rust_configfs: Show bar
> new_bar
>
> sudo mkdir /mnt/rust_configfs/child
>
> sudo ls /mnt/rust_configfs/
> bar      child/   message
>
> sudo ls /mnt/rust_configfs/child/
> baz
>
> sudo cat /mnt/rust_configfs/child/baz
> [  600.651618] rust_configfs: Show baz
> Hello Baz
>
> sudo mkdir /mnt/rust_configfs/child/grandchild
>
> sudo ls /mnt/rust_configfs/child/grandchild/
> gc
>
> sudo cat /mnt/rust_configfs/child/grandchild/gc
> [  670.093647] rust_configfs: Show baz
> Hello GC
> ```
>
> Is that last one (for the grandchild) really supposed to print =E2=80=9CS=
how baz=E2=80=9D ?

Thanks for testing! Good catch of copy pasta on the last one - I will
fix that.


Best regards,
Andreas Hindborg



