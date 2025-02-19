Return-Path: <linux-kernel+bounces-521199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF96EA3B770
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0CC7A7421
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707E1E2607;
	Wed, 19 Feb 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paGQSjxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B31BEF77;
	Wed, 19 Feb 2025 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956129; cv=none; b=oMzWb3ikFwU0NAL8xHvoGRereEz8f4A8dlqSKO3aYbZ08aYwoApfIgZ1vN8w/oM52SRuuBSPE7M9SgUeQbxRcZmwosXmQhmH4QwvROrJet7Mro9hhCsnWDq5DzMkD4zlJYXy5oFG8b0Ed4YqTRG2XYwENT0J7rBpDG2HwU9eGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956129; c=relaxed/simple;
	bh=WavY994ImH+6vVfaOIyHvMZl6wQiGaFr1rTWRlWpgfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TOwZHlBd2h074qIFdamUr7SKak9RLz5AThHKxWgp8TXp8atK2WfBfvQwvidunGTioHkMsqFtnDBOzUGUmklajq1Y2nd1kqmK+wiSSOCADU1BafSDygrqrydE45Z/oXIUPrXaUdZUSh+MXrDvhFsZenxhcGr4OHxrN0qFRTVM/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paGQSjxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E219C4CED1;
	Wed, 19 Feb 2025 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739956129;
	bh=WavY994ImH+6vVfaOIyHvMZl6wQiGaFr1rTWRlWpgfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=paGQSjxXTFG7jVuMf7V4iFRM8t0z6EHd6iPQPFit0XlBoH29zAR/lFZW4XRUidzv2
	 tYkXIVjLAkUV7rW43lusc3XjC8HABOppojvUtOD/epZSZ2M2WjfhnRvewyfIoR/KR0
	 swZbULdCarHdYJSe+GGGMLAS0Hz5XPyzohLNJhEOm2yFhrEPzb2KIyaspjmacJQVsZ
	 tMCME/buvIs5B1OHAmIfej3/m99TCFLxbVRmVfX7JSuPXSydI2ZYK0lSXXQXlDLU0n
	 atj96cGJpiSA/ADL4UPpR7wu61BG34HSVVj+RB34A9xv7z/X6SysfUFAMDfJvt0YYl
	 PWHDvF4Pya0kg==
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
Subject: Re: [PATCH 3/6] rust: page: Make with_page_mapped() and
 with_pointer_into_page() public
In-Reply-To: <20250202-rust-page-v1-3-e3170d7fe55e@asahilina.net> (Asahi
	Lina's message of "Sun, 02 Feb 2025 22:05:45 +0900")
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
	<8SSOcw1x87yoICxI-OXO8ASHvDXN8eQ9f3CHr-JcBGKYhNKvYjdtbDiWK21Wk97girzWseb0vI1PkkOUUA8dXQ==@protonmail.internalid>
	<20250202-rust-page-v1-3-e3170d7fe55e@asahilina.net>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 09:48:04 +0100
Message-ID: <875xl6e2wr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Asahi Lina" <lina@asahilina.net> writes:

> Lets users do (unsafe) complex page read/write operations without having
> to repeatedly call into read_raw()/write_raw() (which may be expensive
> in some cases).
>
> The functions themselves are not unsafe, but they do take a closure that
> receives a raw pointer, so actually making the access requires unsafe
> code.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



