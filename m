Return-Path: <linux-kernel+bounces-293052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF6C9578BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351991C23A59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431FA1E2124;
	Mon, 19 Aug 2024 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ac2Ojsv+"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1FA1DF67C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110904; cv=none; b=dXYfnF+dY/MQN4xBzUzFSLTRWJ2dLT+eIbGo7cHTDCJInb1yzQTptsQG7+Xj9MVJeuQZpwx6mzTf+8BTSXGy8NmdAZXuvvj+XGtPZvPwLEn0nPZEkQTZ1VYf/pdE/u8SMYY+i091EWJtlW6N/hx7CqbEMBUyv5sqlBBSokQ36rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110904; c=relaxed/simple;
	bh=VyJ7DwTEeQRwF2J9itqF7qF9lyR7ouza0PHAuQm+FtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOwzRhND8TCrPbse06K1qu/2n5U0mYUhptqiFlS3jz2DvSDybtdzDfejE9xZ4svhCHPv29Fu92Z6MOnK+lrxIqTxdLmF5LdV7TqS8jwXUaRGgDdNAhwxdU0LzmMaqpsnzj2eGBkfBWH+6h2yFy3h4Yw4C8MjQaSbNNBt8gMhDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ac2Ojsv+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bec507f4ddso3432a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724110901; x=1724715701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyJ7DwTEeQRwF2J9itqF7qF9lyR7ouza0PHAuQm+FtY=;
        b=Ac2Ojsv+hT/DVDertFOoZEdRExcr/WaXAMQbTdz93ijpmy43bOKyv3uOZtKHPIZzr5
         uB0cl7HeJG1v2KgAvPxqdqg+cOkf6Za8ohHy1BbTMGfVL4F4qKYrqalzlymfs31szu/H
         G+jTa0ZhrTGYk/pJ2i3OQeoOMzAlAMU9AJ7RwTuWGzPGKRt6EwndtRrArxrWBdX9hCsk
         CkTv9DNovdTNrSvD4uE4RoTt2CTZOMemhGH3vk4tjLgh0n8AqT8a032uJn0BBuym71Mz
         YG/fd2jTeHD+leGzaIQRXVJi9/+T7azt5CaPxn2Yg01BDTT8ddE82iwbLOBsq1C4Hwq+
         9LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724110901; x=1724715701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyJ7DwTEeQRwF2J9itqF7qF9lyR7ouza0PHAuQm+FtY=;
        b=s8URwgv6Q6HcveR7yY/UxVUoBepZp18yWBTiX8xRxSnSe3BigmyZkyhf+MpEtbV+kJ
         zHjq173Ly9vKbhe9FxwsD14pIi8lPYSrHIFjh2tvkhrC6iOb9TDna6l7STgWG0ZKn5r8
         vkejp0246dyWIwMbMJ+Qv3/69sIF4u3VMMT27ygAhns1xRZ735Sz9PL1RTpb53p7FPIt
         CpJfHniVHo6iLADJmdb0Zgg0LfxROchFW5IOOcxLhHeH1gWaE+P+yD73W9eQTi+oWxSL
         X0QCWCfG0VRSgQU8pIqFvY7EnRp9uREtArmy1Kz2rgk5CxDjcwB5+eOV3WC9pc0u34QP
         94tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdBlY16pcSa3sHTOKTGlxYvgTkIn1HjKBPbEo45J4JWv8d1cYtif4GbtM/L2wI+Ua3Ded30VethfQBmvxOn1oHoux3+rGhtB9h+oS3
X-Gm-Message-State: AOJu0Yx60QWyHa1E7T6ytMG+I2RkiNLQX8cejiRQSqG/nzGX4OOLq0h/
	cyakfhYzTSNRtiVjy96UMeyc+Q6v9ucSZUtsxwQKgb/u0dL3Lp4aZ3XcmiZs90aHaPT8OwDtV9t
	17Hh9LSfG/4o6rpmIS3KE4wLTyqaTsPMrvhPf
X-Google-Smtp-Source: AGHT+IEFf0La4uREmgZmbe880Nnbs8CZTxbPC4ox9daCMh8bMB0DPDlb/vwxR0dv4G47Vf1sgvElegvu9c36SV8SoxM=
X-Received: by 2002:a05:6402:3546:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5bf0c262b15mr42504a12.4.1724110900976; Mon, 19 Aug 2024
 16:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com> <20240806212106.617164-15-mmaurer@google.com>
 <87le0w2hop.fsf@mail.lhotse>
In-Reply-To: <87le0w2hop.fsf@mail.lhotse>
From: Matthew Maurer <mmaurer@google.com>
Date: Mon, 19 Aug 2024 16:41:29 -0700
Message-ID: <CAGSQo02r3NhWnpBF--5nB2RJ=1Hh97VshtiZmasDfknnL+UjmA@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] modules: Support extended MODVERSIONS info
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Nicholas Piggin <npiggin@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 4:04=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Matthew Maurer <mmaurer@google.com> writes:
> > Adds a new format for MODVERSIONS which stores each field in a separate
> > ELF section. This initially adds support for variable length names, but
> > could later be used to add additional fields to MODVERSIONS in a
> > backwards compatible way if needed. Any new fields will be ignored by
> > old user tooling, unlike the current format where user tooling cannot
> > tolerate adjustments to the format (for example making the name field
> > longer).
> >
> > Since PPC munges its version records to strip leading dots, we reproduc=
e
> > the munging for the new format.
>
> AFAICS the existing code only strips a single leading dot, not all
> leading dots?

You appear to be correct, I'll update that in the next version, but
want to wait for more feedback on the rest of the patchset before
sending up another full series.

>
> cheers

