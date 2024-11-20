Return-Path: <linux-kernel+bounces-416052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAC59D3FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A47DB3B975
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60DE1537AA;
	Wed, 20 Nov 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAdDTUaJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020514B077;
	Wed, 20 Nov 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118337; cv=none; b=dlJwcxrwSXet5DEsrDYUHnUshgqT3cBeTD2890fDMgljcJ6cKN7vdLAbWS6DTsHGyTQdtiJAeJm+wiYS/M7wNwHhEjYqSvqWw1Go2uyRD+XjN0v2e9gpa17wMOQUke5YEeAJrfD85HORygUwb83BNHvArGwcxISBiIoJqFhqdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118337; c=relaxed/simple;
	bh=PBO+6ywj2PcgEksLd2QnUclp4cCButUpCEqwidE/yfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MBrg1ej5jnZHiWm9n/DNjCEfLLMVLs4CHARci3Q7uji91x1OIBnkQeJUTtzcT+RleeCtONEfGAlgREic1XxGLIgZLRXl0MmA73/qiskZ7ikjCxdab64IjOuUbHaG3KsZYfAqJxidBHrO+TP29RPIrgUfyNdwxnBBW+NF7IjDeMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAdDTUaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC64C4CECD;
	Wed, 20 Nov 2024 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732118336;
	bh=PBO+6ywj2PcgEksLd2QnUclp4cCButUpCEqwidE/yfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UAdDTUaJvZ8iVJrkMsWXcRaIIhFDT4qOfS+nRrPbQc0r8wUFLbg7i9MJve+ldQdOg
	 MFS3yzaYbnQy3Ymlnbux4JDHJ592hPmMuEVPysq5PJPvX2G00+wFqDNgsmyTqviESh
	 1Kr3fh1NEoqxtz1gmEwDR1C1Qa3AcgTXvocRBNb+U1yJS6DzJvEChscM8I68TTpUJJ
	 oGv9O+/J+sZ+1ZBFtM/tcg0MgkEWTmXIOV6jzTRGq9SmkKy7sS6Z5JrYVtZFw1My01
	 YUjTJtS4suVGGnKNlldCDn/l+iioZg1eVINnQh2I4vuqzBPQArcRUqsRlcnSlb6nFG
	 VGfHbP4v9cOQA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] hrtimer Rust API
In-Reply-To: <8fa20279fe8067602fbb106329a0f7d9c4146b3b.camel@redhat.com>
	(Lyude Paul's message of "Wed, 13 Nov 2024 18:39:53 -0500")
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
	<KuX-uY44Td6jpb3dtlR-S5Eo-KEFXad0UorWcwaspcNfH75QUPklyMfQmAsCPuLVV3PM3iNrDKdXJNhyzZm4cQ==@protonmail.internalid>
	<8fa20279fe8067602fbb106329a0f7d9c4146b3b.camel@redhat.com>
Date: Wed, 20 Nov 2024 16:58:42 +0100
Message-ID: <87msht3nil.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> With the comments I left addressed:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks for the review!

> (I'll have to rereview it soon when you rebase I assume, but I have a rebased
> version locally (can send to you if you want) so I know the changes won't be
> too difficult ;)

I did not rebase on the new C API yet actually, but I will very soon.



Best regards,
Andreas Hindborg



