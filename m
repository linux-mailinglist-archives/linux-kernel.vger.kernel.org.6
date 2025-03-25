Return-Path: <linux-kernel+bounces-574605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C591AA6E76D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9A73A9B81
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB88A5D738;
	Tue, 25 Mar 2025 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Qg6dTDPt"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51954B666;
	Tue, 25 Mar 2025 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742861852; cv=none; b=L4VmP7gasNHLIhSkhYallxJs3tL4k5SowI7kDBQhRwAiwgjehGAur5cvlPiKzr5+MTTeHtYVcx2NMmMIczOdRTN7ZePQIhDN5w2e+RmeCDWSVia/Eu9mHFTbGEQddurKJUYwSs6oAT4rqyngtMluiFJXBB7fIqb3guL5rV+TZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742861852; c=relaxed/simple;
	bh=cLAAuPtLI8/s6nCDYc9Z0I6GkG9Lzg+p3j7ak9XuX6U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoJXUJR/2G7TUqrrNOUArLluQlfZJPTego5BIjl6dQ4/o9PrFmrU8ER98RxAWTyRn1SCQ/7QIQ9IltP5s4/Qa+XtCHkspbZ2S3FD4HlRY1UtWDfYgq06nG/7EHhpWr55pwCCNKNJvSHTBujipCQ43z0Tfr+wAPlHA/5Z9W5QQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Qg6dTDPt; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742861848; x=1743121048;
	bh=cLAAuPtLI8/s6nCDYc9Z0I6GkG9Lzg+p3j7ak9XuX6U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Qg6dTDPtuDSNSCD7Sd6wjPnmzqS+8XuwqKkX6cxIqtB7g5uqaJA3qwQnxmJGLq4sd
	 LKESnpUn7wi1UD35URriiURudk/e+vSLz/EnbbV0km9bGvfj3fR/oeMozyR6sxlYlV
	 Hkc3VBRKw9f5wwZLU2w06p03bimS+lKPuexEF5nrf5nhHoRV4UdFHUhSlSvQ19xIkA
	 nsUdas7i3wEDGJanVRK/Ep7FVfHdj4pCOVpI8qwuMLg330ymFYLmLIeRzj2J1VRfUL
	 5P5qRQL1l9fyO2sP/gu2tWw4BOJYQjihzBy/mkpIFH1mOX5OsKA9wvIzjh1tcpFJRa
	 InPiAduz0SjNg==
Date: Tue, 25 Mar 2025 00:17:23 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 00/10] rust: clean and enable Clippy `doc_markdown` lint
Message-ID: <D8OWYJ6X7KIW.2CM77MJ6X8QYL@proton.me>
In-Reply-To: <CANiq72ng_ABVR5ihxMeN5Ast6Lu0-zxkgjnKzbtn4j3ghFKgZg@mail.gmail.com>
References: <20250324210359.1199574-1-ojeda@kernel.org> <D8OVATSS19YC.1GXZRNM6TBA0X@proton.me> <CANiq72ng_ABVR5ihxMeN5Ast6Lu0-zxkgjnKzbtn4j3ghFKgZg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d927ecfc36ab8efdc63673df1eb8d5f0416605d0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 25, 2025 at 12:09 AM CET, Miguel Ojeda wrote:
> On Mon, Mar 24, 2025 at 11:59=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> Not sure what you mean by this, but I think we need some way to disable
>> it for some acronyms.
>
> I meant that maintaining the list in that file (i.e. globally) could
> be a bit painful if we get a lot of terms, but I guess we can find
> workarounds for that if it gets bad.

I think we can just see if it's a problem. If we keep each term on its
own line, merging should be easy.

---
Cheers,
Benno


