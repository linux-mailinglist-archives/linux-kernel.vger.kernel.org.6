Return-Path: <linux-kernel+bounces-300016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B126595DD90
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 13:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA9CB2112B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C01662FB;
	Sat, 24 Aug 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="GLi6/OP4"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402114B95F
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724499031; cv=none; b=tFiYUQUdXwgXpzV+fVIuQ0aY57YISWVEby13OdDpM1ZVk+Hk+dvS7gjGmhxA5pIBCZ0s+iInD+0G2gq24x7sPlpSTQ+J5gzu95EB9afq7ONq4L6Dup496txs4mknQS30RzPu59eW3zQkwR5Z57sJPVOHLF+L6kNQnZZdS2lw5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724499031; c=relaxed/simple;
	bh=BwZJ07m5fDvP+xNF6j8iINAkVMSAYkM8ARI6wMYjAPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCSMnWHuK9A9WAt3crr7LIoLF5SOTnlpAtYZjiKAAx8YDvDwXpkSEyf1QHumuvCepnbFF8oEAZhhHpQxIHM+MFWGLOyNhAad3vNOsoi+dEYao+iZai1YEwBlD6y7/opFA7YNhpjc+vkZRa8dXh0DQ/OEOVGQPOVdoYytZMx1f40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=GLi6/OP4; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6b8f13f28fbso24449067b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724499029; x=1725103829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwZJ07m5fDvP+xNF6j8iINAkVMSAYkM8ARI6wMYjAPY=;
        b=GLi6/OP45w+9ghJaThj9sIfeBW61k9CvlBjPiJvpdOOxNEuycXTAL1mJMSxr2rlsb6
         KAgTCy4S8xUebZY1tCQRmDwCG2VrRRus3QOSjthDh3l2zCRE7u+MrTg8GhVWvK5C0XMN
         Iz9tSvogDSsh5Jdz2g64EUEqrtGsRY2G8xrvLz9zJQ+4g4SPIp1MGE5qlyaQ5kVPyVB/
         ixf+5DgJZlQRcHJNISncED1Xs4p+hf3ErDUhqdmBsRWXu2D1F9paT5slHNIhL/ftLbpm
         ZZHP6sQKOdxmyWPZ+KoOdLVaUrmAOIIBJjOdTIsMJywZwa3ttepznCWDN3MAaCxsOynf
         QHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724499029; x=1725103829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwZJ07m5fDvP+xNF6j8iINAkVMSAYkM8ARI6wMYjAPY=;
        b=Ioqzi/ZPf2Ve887N9CtQMrG2JqAPeNKe3D2sKejKz6ogGnT2bkBOfRBfBMGLN6I17/
         geX4C1n1ypNLm5uK1WBSqIIFsJa0eSy0VKr0snaGegwhMvG88pfsGuhnh1/+IWaM8R+X
         DKa9CfHJHM+u8mRoMCLd9aPLB8t5SsPMPXmSQz/M/tZOeLnMHhYS1ksrPDXJMOTpxRdl
         6PlrCV7w5AXp8Kg56rY6axFyQky6oV2T4yeVy3CuwuQDTsvs5Bhp8O6bTlU0N/gRyBX6
         A2sROrjHtpPCGrKP/STKMGHzg/L0sPESsEIK3h628RdVGAfhiwY+ZI01nbrfKg8M0Fr6
         gwxw==
X-Forwarded-Encrypted: i=1; AJvYcCWe5cyC04CxmTs8LJXSx6ImCqS12Eftx/6DLi1hKV5gRHQ8cuQg3sjxkvLr/gWWmpAJOLc3JhB3/2RFiR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnThklZTIdpiyIvF40cZdsJUPAZ10R857Wvv5ju2beFhd4E04
	Ef6f+J9D1S016BpF/3xTs/AHowSToe5p+uPK/cqkl0Mrz8ZnXGMHf15PKe2DJxNJmT/QpB0BxFc
	vHPt1oTCj4cQzccKSX2i8gm9kSpHZR8ivsUAvug==
X-Google-Smtp-Source: AGHT+IFJaQU8pLvevzDDu8q7NmXn+7PVuBa8CEcqMSFYp2+vaDk5A73hmg7JH+usAplnTl1ihJSaw5aKBYrNSmraA6I=
X-Received: by 2002:a05:690c:7604:b0:6af:c39c:da99 with SMTP id
 00721157ae682-6c629fd7827mr54072137b3.43.1724499029274; Sat, 24 Aug 2024
 04:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819133345.3438739-1-nmi@metaspace.dk>
In-Reply-To: <20240819133345.3438739-1-nmi@metaspace.dk>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 24 Aug 2024 06:30:18 -0500
Message-ID: <CALNs47sF1o4x-=wPdy6c520-sCX_+sA=158MMP9c0SByKvwXfw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add `module_params` macro
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 8:35=E2=80=AFAM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> This patch includes changes required for Rust kernel modules to utilize
> module parameters. This code implements read only support for integer
> types without `sysfs` support.

Also, I think the subject line needs an update ("rust: add
`module_params` macro")

