Return-Path: <linux-kernel+bounces-554298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D7A595E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A2B189012B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C2822A7EE;
	Mon, 10 Mar 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XHB+6Ha/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nYIa9LG6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE222A1CD;
	Mon, 10 Mar 2025 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612502; cv=none; b=RKedZ8oJKPMKIpIfCFfnVVbyL0zfV35qtdFbGv7cZfMBdW2JvA5nxR9fA8vAQ7TId08TOQ1zxRXPsONMQ4OZs2/yjCc5fwyt+mX52FYs6rfCfFeoAqEzZbDqHZxDQ10BJifnJyLAyfltoflVsQEjJrwNr+CL+/7COK4vfTmfbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612502; c=relaxed/simple;
	bh=Kquilv86s6eN4jO6LhATImW+5Qgdpul8/DZ4u4vPph8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l9Y1Mx27x/+qGB9d5dE9c1pOj/7NpDWQhhAEJXOYATVgEAeOlvlTIv+lL1ABwSyshLnW470/v7KMyzLA7YbyrOiRQO1BGCrelMSG58IzkLP3l6AvzNpt4sNa1fzf3Atyt4z+g4klKiXsXC45xiPKgTSez4PGA7VwJ4wJs8deGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XHB+6Ha/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nYIa9LG6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741612498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kquilv86s6eN4jO6LhATImW+5Qgdpul8/DZ4u4vPph8=;
	b=XHB+6Ha/RBiey/Rpj1xbSFfcRIPpKzLao9wKvFzi5sOm6QVV8yzLrIMkW0Upa8BpIyRYt1
	3aTlcAa5S07yYczzzp6FBLqJctKml3uO+S0QbfphhqlKrCTN6hDSlQNErhdYdGWJfoDhx/
	80S3RIZFliZykSBEsPaa+ug38cqnbt5m3AvBdioB0sHktcQTMTQAbooadw4oMfbKY4ZKql
	Dy9clv/YTsz7nZ+MaCPQomYQRzkavb1EhJcx7LNvqWYCaHt5poJpSTT7cdPk7x+jRQZJ8y
	Txg5WLToCTP4oWuGxHqhXmq4YA4G1SRNtFbugs293m4bI3BcruJb6S1Ghj3BIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741612498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kquilv86s6eN4jO6LhATImW+5Qgdpul8/DZ4u4vPph8=;
	b=nYIa9LG6u6XLBoI874kNB/RjU2WTOfM8waox/rrARFlt2UwqgM4+636nLFdxuwOd62S5VT
	Npl4MpwjH2oQ2TBA==
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo
 Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>,
 Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v12 00/13] hrtimer Rust API
In-Reply-To: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
References: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
Date: Mon, 10 Mar 2025 14:14:58 +0100
Message-ID: <87tt8110z1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Mar 09 2025 at 16:18, Andreas Hindborg wrote:
> Add support for using the `hrtimer` subsystem from Rust code.
>
> Add support for timer mode and clock source configuration during timer
> initialization. Do not add examples and functionality to execute closures at
> timer expiration , as these depend on either atomics [3] or `SpinLockIrq` [4],
> which are still being worked on.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

