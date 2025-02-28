Return-Path: <linux-kernel+bounces-539268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFAFA4A2A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C967A5AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4EF1C5F1F;
	Fri, 28 Feb 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIJhVr+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DA1AB52D;
	Fri, 28 Feb 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770764; cv=none; b=NVik6O7Wx8bm2/X8D9EHRhJkJbtDgxZPdUe6uEkZJM4GhlAh7U5T+2N826qgwNFSKYyOgme4uBkoWGlBwaB1Di9pZMB0BtXvKOU7M+OuxbDENRCrGv2iZ+n3McnVYTFmg5R/7onP9CdCBTGPlEEUfcs8FjmzM7XBJPjKMXLKq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770764; c=relaxed/simple;
	bh=+NzFaJb2XG1wVijYmYQTMs9+cUx0L+bWi7O4O2sDCVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nHTIiL1Q3fNJg9s8voHIohrZfj5D8jaBXeKgpaTKdoCP6zmaSdIDfX6oakuHuFceYguhSWqzKb/abem60ESmb11y/cfWto46T0YxZS0JedoF7hrlCzoemGlqUp7obI4F00XUfjatq90OfiUlCbCNr1SUb+sqluCTx+jgRrgfBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIJhVr+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878FCC4CED6;
	Fri, 28 Feb 2025 19:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740770763;
	bh=+NzFaJb2XG1wVijYmYQTMs9+cUx0L+bWi7O4O2sDCVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cIJhVr+MZ7XLmnIZyQH5oXfA0N48vnUNhkitkLLE2xBtd3REX/xQAP37MpU5tuHLU
	 GKH2h7R5rblwC2Fm9mlkw+yf2rpOorS+3Iosg2IpG8VGcJTzzyRT6iA/LlEEaUyxje
	 yOdTL9ey3KH8LUrQMYKvPFKYlMweXbLyk19K4glZeMeOXy9j/giBS7y7Wn/SY/G6nt
	 f7XZJRHCfzdkzBeFQ9N4873W0GXA5ZqQYR2W15a5fVv68Wc0YLAIliPqdoPaqRqNY9
	 g17w3HCI3uM7OdGkUK24LDWaiuTb5QwO29y8AQK02ArY9/ArjV4N9GDtnQCUBfcNs/
	 URi4Xq8r4GmFA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
In-Reply-To: <Z8ILlUMGQ221hLJY@laptop> (Oliver Mangold's message of "Fri, 28
	Feb 2025 19:16:41 +0000")
References: <I2EuahEO9YG75qdfIlsanLJ9iOfr0OlKJr6nw_cqOG0rVrZUEZGhdfENkLawNCpSqP8uSGMODCeEmsYv6clgYg==@protonmail.internalid>
	<sOipp6LTmtfq5A37VN_kCA4Kw9zfclZ2HLIMSJYnOdG4ebnuTKUlXIlT4X3GVRLMXFmwT4IwyIA-eqF69yOhSQ==@protonmail.internalid>
	<Z8IBiBi6CSRxfxiE@boqun-archlinux> <87senxlwpo.fsf@kernel.org>
	<Z8IJPzlvioBZaV5M@boqun-archlinux>
	<IKv622yLvPB8cQqazDuceWqKbX5PKmf2VTjx5wG-nj0X16d3B-xJBwvbDR_bt5EzerCjmCY6aLZM4emv07saVw==@protonmail.internalid>
	<Z8ILlUMGQ221hLJY@laptop>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 20:25:53 +0100
Message-ID: <87mse5lvlq.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> On 250228 1106, Boqun Feng wrote:
>>
>> Probably because some of Oliver's replys don't have the "in-reply-to"
>> field in the email header. Maybe it's a known issue of protonmail?
>>
> I think you are right.
>
> Google couldn't tell what to do about it during the last 5 min, though.
> I'm using mutt through protonmail-bridge for mailing.
>
> I will look into it, but if someone has an advice, it would also be
> welcome.

I am using protonmail-bridge for sending as well. I don't think the
issue is in the bridge, it must be in the way you compose/reply in mutt.
I am not a mutt user, so I don't know how that works.


Best regards,
Andreas Hindborg




