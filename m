Return-Path: <linux-kernel+bounces-556920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF25A5D0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B577C17AB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F24264633;
	Tue, 11 Mar 2025 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqih84gO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE09222572;
	Tue, 11 Mar 2025 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724423; cv=none; b=ETEJayGg7+781RmnsvKKL1Zz15yeiQWo8nY75+l8WQ/W1J5V0oqCoTCB7onEwFRj4aCkE1TI3cZOOTUGhGNe6+C6Ap+H79d5pM8ZZBx6AHioLw+77xT2Sok4dR4FQ2YQSgeYmdHQTdGAxmCp4GsGFkfipZtuyQ+BjMhz/m0WR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724423; c=relaxed/simple;
	bh=gaFQwOmMlxED9qfG2DcTfEvoKt9vKeHVKBWq+pt+Yxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ap/PKFfbTExwXwS2LoDTHdjG5RQHn0xZcVGCywcm+5TxaedKTjyfEBKHi9PztrsiFdbSrCudko7m+FvtIjvZHuIVforLyJmYLBliikwC+AwVGfb0TJSs9AKovv4iW082gQzg41trimkadC5wmgfoJNmzDv2eU950+t09tAk8aYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqih84gO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9550AC4CEE9;
	Tue, 11 Mar 2025 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741724422;
	bh=gaFQwOmMlxED9qfG2DcTfEvoKt9vKeHVKBWq+pt+Yxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qqih84gOhTQlMXcSWpL3D5+gis7CHqCCzPMgKb2wMp4rrFqhAdtE0YIAOZoGslv1D
	 Wt+EXZhNsknpqu2e2bygN/KWW38aDS0juSc0VM/3PyOdX8V1VA/5eZa5C4ldjreeQo
	 pxou8ZW8vhoNYntuM6FGr+F2xDwDD9a+gStr4c425FQm1Iw/5HaDVnhsYoFURxl7zC
	 h/bFElw1szpn6to4CGF0uhMMk5K8ry4AgcXMb4szaHD5dAnSVgjX7CLPdTZKSmDQ7b
	 Ncra90w45zNlTSX/35inXTGdIZFUPv971bBEMICzQfC6ECxOVf7r2HVXsz2UJhH+zo
	 JPmIrO34CWlsw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <ojeda@kernel.org>
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,  "Frederic Weisbecker"
 <frederic@kernel.org>,  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo
 Krummrich" <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  "Markus Elfring" <Markus.Elfring@web.de>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 00/13] hrtimer Rust API
In-Reply-To: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
	(Andreas Hindborg's message of "Sun, 09 Mar 2025 16:18:51 +0100")
References: <-Nl1GhL2X0kcAMrBu5I5y3g9tbYapE9MEn1yUYhCYWUSVmztyp-eC4IsSxeCm4oVUJiLEFuqRQfZ2v_eQa61xw==@protonmail.internalid>
	<20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 11 Mar 2025 21:19:37 +0100
Message-ID: <87v7sfjp5y.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andreas Hindborg" <a.hindborg@kernel.org> writes:

> Add support for using the `hrtimer` subsystem from Rust code.
>
> Add support for timer mode and clock source configuration during timer
> initialization. Do not add examples and functionality to execute closures at
> timer expiration , as these depend on either atomics [3] or `SpinLockIrq` [4],
> which are still being worked on.

[...]

Applied to `hrtimer-next` -- thanks everyone!


Best regards,
Andreas Hindborg




