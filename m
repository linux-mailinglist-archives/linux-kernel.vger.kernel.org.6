Return-Path: <linux-kernel+bounces-343501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 433A1989BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B781C2169A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D2F165EFC;
	Mon, 30 Sep 2024 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCTSJMGF"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06A15C13A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682287; cv=none; b=bVt4ioawbdtF4AFT8P1/Vr08vcCWnKAjMS70IlSwNpebDAmG5MbamriOcmMG6GoDtNt4S4OOjFOsHy97dW1QS9Tm0nZK76oS3/DZutDdIPHzD90A4Z9WwlPNW0CUPm6pxNqhb7drWQ5rpnB/PDL+2Fp4BmdgdiZO7Ih+MKDHYjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682287; c=relaxed/simple;
	bh=KYSaRZpyai2Viv1660kI2dZ5xHhGUTyEvRTAv0HKjM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VInYd/IkYigPsw6a9E2wjjyZmyBejkW+4VtLdTWLUCf0TqTLgBdrNJISTWKdrzo+GMd/tNhRv+eaEqnpGf1G4ZnZCcGsRh5yxxxDxXtL175HgirhmXggNNpbcoWDCDYKTLNDq0PbP3MVsnHM/NcfqJ0SmjOakT1OvMgVH2Ww0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gCTSJMGF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cd8a5aac9so1168347f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727682284; x=1728287084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYSaRZpyai2Viv1660kI2dZ5xHhGUTyEvRTAv0HKjM0=;
        b=gCTSJMGFESNIzWQI0Abn7HzDHbQVchdktnYf2mnsyhe7UsrbqOGfzCnsR7OcoFfVTa
         YjM4Jk/k/V4Ryj+UeChG2AyVkvQxHWPf0AOzcLknuukSvsp+XO1oGYp57oJFc5b61/5G
         4rxQGDkMpAhQ3Elb7YmhkG9TbnJx8zRiY16jH2260709Ue+rmhMZg2e9HxOVvOcMSuep
         vfFRyE5jb0+Ke2lNbSQg8yvQ4200klNlsHMFwGKOz7KyKdmztkB/IickDneO7UIL85Qh
         yAtt8RH0D5Y87T8SR2KTHGej4iOb6j5dG2dwfdozJPAo5764u+J7qAqtNKVYz4oMUbPD
         N6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727682284; x=1728287084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYSaRZpyai2Viv1660kI2dZ5xHhGUTyEvRTAv0HKjM0=;
        b=AdIupxmzzpnwanvVJ+gCe678zQ/9nJOpgur71zayXwxpRm7A4HCcBvIBuPLFq/t/b4
         9Ld2zsHu/wLrODunNMxLxj05Vaaw2Et7PYbPnQ2Xlonjmw/y9HiHvRw5X7aQhlXnkXnY
         EUKkf3a1MbjhMwTWpezHw4KYhCmHPhn/n+JX18N4pg1JXprgY61L95LAKyx463IKQt5V
         77orqSfvuWGw8Rl8HNvSLJDmhlaCcd1xfFMjR4+3b8TSTcywEJNmQEnl62+Wa7IXX8J3
         lfQt9GSfpPHMDDZv2VLo8g/2FeqO4JVFUsPmlL9lzaLLM9mTOn6h0w8mFFZQ6kjhg239
         w/CA==
X-Forwarded-Encrypted: i=1; AJvYcCUYOCak4Jv8pRU6ubazDi/vBKzQ18RUDP3jwfwbLgjjLRaX5f8OS0fRDtGR0VUcGarotEmq2CKo8crFVcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kZb6AfJtxnVhuCvH88/HCe7E7iOUzQMoDXyqY4d74RXoU4LN
	FJQ2sFNDxBUKiKEYN6AZxRz/wALMIJ4/R3lvkgM6PkXutt5mpNB/b4fS2JbO4BZuhvzIigxghxR
	aLh4qHxzs+BfJMKheDOoMXAQuhQwQn9XMUA3i
X-Google-Smtp-Source: AGHT+IGE/D6/QsIIP4J0H1QxONOWgQS7g25lI+QYgi6phml6YNi4c/xIuskX5uQ6Dmztfg0ZWQV/gHDvQRxzFlDLoZU=
X-Received: by 2002:a5d:4d06:0:b0:37c:d0f2:baaf with SMTP id
 ffacd0b85a97d-37cd5a8075amr5990512f8f.13.1727682283447; Mon, 30 Sep 2024
 00:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
In-Reply-To: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 30 Sep 2024 09:44:30 +0200
Message-ID: <CAH5fLgiCAW68tGaG0imi7ia4XvOp+EQcENjF-P-ec_MonEuFrQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2 RESEND] rust: kernel: clean up empty `///` lines
To: Hridesh MG <hridesh699@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 1:15=E2=80=AFPM Hridesh MG <hridesh699@gmail.com> w=
rote:
>
> Remove unnecessary empty `///` lines in the rust docs.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1109
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

