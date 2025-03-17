Return-Path: <linux-kernel+bounces-563828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D046FA64949
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739E13B4D19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACA12376F5;
	Mon, 17 Mar 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eEMVrUb2"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72D11185
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206509; cv=none; b=kb6I2Ebmuh6PYx1iHS2bRCH1qQrEKPkUym49bOLUd1H8O+eptBBk+ijdM3TT5v8ne8s3YIY6r5zic9gQquuaSw+HN/4HAlF3P2mvc92YUR/yuF8g0ihKCc3yyl/O/tIGq+2+z1r4hHPO0JRcwJA2SGh6LrLKQDD3f+WFY4KiAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206509; c=relaxed/simple;
	bh=6lX6qd6cHpyeXJtN8CbDJig30k7qEU+St8Ur0Q+BBN4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1p30B765r1qFKS61rj4Pf7Byj4+tjfv9Hwv11T/DqtrfZmTMIr8AN8V3wwuWy7MoRzS94ADKsiOfzOayrDJU+sVVwK2UQe2Or/TcqSelb7Jy3DcVEyc9Mh9qYmyHp/BMT/7oF2VLnGzZfXI0XFbPuxUr3dEsLO5gN69dnsSKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eEMVrUb2; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7dlnzbwkrbdztmvpnxie6e4fom.protonmail; t=1742206500; x=1742465700;
	bh=IpqGC6kjpj6asVKqkNZWmw1IDhP0itPNVW7PmK6LSVA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=eEMVrUb2yhzEWNshPrV4mjw/plLWFOaMJtj9b1jMtF7zOGpkqezMj8q9rgOtl29w4
	 zKN3N8Eman9k8RvFBma/jF7r4AqLHf/U6OnCV+xS7qxMon4ZOrlqdfWfG5FDxFtA+9
	 gliew1Q5l1GwV8JVucZO1/LEk8Z543Hd85//JH/FQ7GySdVeu+DqYf1IImS/dKY/hK
	 u8hYrOFhAXE8AIPL5cHSqT8cW3ypuX2d3HSnqQi1/UeyTaJs0Jl9n6O3SZ0sOBfo4B
	 DIXezs+bH97aRUiFPBSRn4Iy1Q+16BQpkTbKXLBJibg+9FjVjCGKg6E7JFNvdc9BUJ
	 kvqnRhaHMDgxQ==
Date: Mon, 17 Mar 2025 10:14:54 +0000
To: Kunwu Chan <kunwu.chan@linux.dev>, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@Gmail.com>
Subject: Re: [PATCH v2] rust: optimize rust symbol generation for SeqFile
Message-ID: <D8IGNMOL2WPU.P9UB057VLDV3@proton.me>
In-Reply-To: <20250317030418.2371265-1-kunwu.chan@linux.dev>
References: <20250317030418.2371265-1-kunwu.chan@linux.dev>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 27001cdd7b13d5926d7c25cd21d0175d031e299d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 4:04 AM CET, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
>
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=3Darm64, the following symbols are generated:
>
> $nm vmlinux | grep ' _R'.*SeqFile | rustfilt
> ffff8000805b78ac T <kernel::seq_file::SeqFile>::call_printf
>
> This Rust symbol is trivial wrappers around the C functions seq_printf.
> It doesn't make sense to go through a trivial wrapper for its functions,
> so mark it inline.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
> Changes in v2:
>  - Add link and Suggested-by
>  - Reword commit msg
> ---
>  rust/kernel/seq_file.rs | 1 +
>  1 file changed, 1 insertion(+)


