Return-Path: <linux-kernel+bounces-240800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665F49272F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8273B1C22016
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E01AB511;
	Thu,  4 Jul 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1LQkm1q"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC861AAE0F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085187; cv=none; b=PKfWdQbCVFEwGb3yyap/t7ZCMdLk1fT20YbXVX+CccRdQ/SAhTOCfQJ5QayozM1noqIy0zRMJ8KmOO2eIUqaIWZueV25jftWFCyyDVpCu6E87fG2Es3/00B3dt6CWiXzcNeSFnRZ7xMfKjecDjIcB1daAuSiQ8k2ynuRLLM7Eew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085187; c=relaxed/simple;
	bh=jK4QiJYgMpqZHuOiFOYJ7LRloe0aUPmvOMr7gZdKz2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyXEQmFs7qr7pFklntZh9bw7Ma1H1CMdU6uJMqL8yDr+CjmeDj3fMPkjGuLea4nQcSZQAmEvSdaifyvPIUKNWTllQx8WnLS7+SQbvyuMtUzv+IBEEqqRZhOstcOu6UrsFLFLEYHlExV1tMkA6tpTHkE+0zpdaiRUtWbmnFGWQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1LQkm1q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42567ddf099so2680345e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 02:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720085184; x=1720689984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK4QiJYgMpqZHuOiFOYJ7LRloe0aUPmvOMr7gZdKz2M=;
        b=X1LQkm1qIhKmx2cXHDWcmiIyZH7j1qfnh6QbGyfLyyIevj3VsoKYxEEr70fXHRrJCH
         GoMAeqoV/WGnX3PhaJMozwPy0QnS2FvD+MRKKvBTpYHSPtjW5hJY/D9I39Ribv/jbGXQ
         z3BJftDmqwarjuta1GYq1mO+ZbI0uh7B9tbhdzbJgUhNMR0zmnPIZ99uQTLTRe+eINea
         grb9FoSBlY/UasLH5qKn1UVRPYSLeqSKmHG9XKO9WREvZTJlszyRrlJzQ6o9CFwL40Xd
         Bo6G4HeM4IOq7nxQYJxDggaPIb1Xvrwf0CycQQHcR4HcPw8yO56CfchaRXIppmUJWdfw
         3pDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720085184; x=1720689984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jK4QiJYgMpqZHuOiFOYJ7LRloe0aUPmvOMr7gZdKz2M=;
        b=PAHztiQhn9LfX7mpFDCHMCHF7sdHdkSHDekmuRHyvZqsP1hyiflGXgyJECUvic0Oki
         fuoZhiowGF9j3ZZtRGMMIiprUQmsgWfZJE10XACdBG2ExslQJbpFqaPK8JIbQZzLyPJv
         L0WNzQGCeUKkjRa6Plvifa5MCfFJsWN/H4io/s74bARK4VK69vyAqPYl9/8mhmX1be/y
         noWmZ7O2u6yoGzC16sF6JcZWlXdb+uVRlCOEQPyMBLlumGdX3Jj8gT4sNE4QWCTW9l5T
         29Le4bDqvqkkqQkI5dMbLb2AoN5PTger0kzWjIcLdFZB5ZPBiC94fRmLNOR4O3BcorZV
         3IdQ==
X-Gm-Message-State: AOJu0Yx9IVZAAxIQkulCuuM//51nXI3A7/qnOsFD4l/KGsY8yqQPIRxF
	HmR0a24EvjgyLIFalDGVK5EWaLeWE1aKUB5+BkLjirOylGs8PHeg4Qf/eK3scuYuUQyFFm1gIz2
	FzTUSKwGAx9T7QJR75w3UmlG+mljijkEwnRs4
X-Google-Smtp-Source: AGHT+IFv88LNQ+GBGvy774X0W9nVuAppKr5CisW/ZF3NA8NQh92OFnzT9hs2dwXxiuMzIoeI82UfG3HBNYc2ycinAtg=
X-Received: by 2002:a05:600c:4891:b0:425:6f96:8bde with SMTP id
 5b1f17b1804b1-4264a44d7e5mr8270825e9.29.1720085183623; Thu, 04 Jul 2024
 02:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
In-Reply-To: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jul 2024 11:26:12 +0200
Message-ID: <CAH5fLgiyDsmG-YvsxvPPS9dAnKb7jJ2iapQQ3eWXnBPDOiA=LQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm: rust: Enable Rust support for ARMv7
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sven Van Asbroeck <thesven73@gmail.com>, 
	Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:04=E2=80=AFPM Christian Schrefl
<chrisi.schrefl@gmail.com> wrote:
>
> This commit allows building ARMv7 kernels with Rust support.
>
> The rust core library expects some __eabi_... functions
> that are not implemented in the kernel.
> Those functions are some float operations and __aeabi_uldivmod.
> For now those are implemented with define_panicking_intrinsics!.
>
> This is based on the code by Sven Van Asbroeck from the original
> rust branch and inspired by the AArch64 version by Jamie Cunliffe.
>
> I have tested the rust samples and a custom simple MMIO module
> on hardware (De1SoC FPGA + Arm A9 CPU).
>
> This only includes support for ARMv7, but supporting other
> sub-architectures in the future should be as simple as setting
> the correct rustc target.
>
> Signed-off-by: Christian Schrefl <chrisi.schrefl@gmail.com>

With the clarification from Ard, I give:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

