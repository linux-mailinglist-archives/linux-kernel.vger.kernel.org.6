Return-Path: <linux-kernel+bounces-386974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B313A9B4A54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CED8B220EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3B20650E;
	Tue, 29 Oct 2024 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liL4lnLl"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AC206070
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206541; cv=none; b=BBb6SAmE9D05tVE3OdZ3ilclsAMy7dzcIJ+TV6AhP3DtCk8QJNDF6D2Odgga6Ar423EdmKmH0NpPxb1YYMmNYIYDrSAQkwltN95I45V94cKjqUFOdzG/ajB3bleHgJcVmQb/Df+td59sn3FTf5fR1S7jvo9TuRgZ2RFFzxoACKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206541; c=relaxed/simple;
	bh=Xo5tjCzvkjU2q79mZUINpDF0j63nMfsTwMbRISK5XWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG+/R7OCTqTf+nKVaUYHVz2aesfYLcWOxxOQxnDVl5QrnLxtT946apfR/UEHXFaBy/jgyyXqEG3+F6BiXS7eYxO+IgYDU6Vpg8uWCroHUdk/ZH2oHO5TiJ80QrBkrXQPlixMPpyvPZ+67IYKDF5imROcxhEXnOR4I55UJ8rP8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=liL4lnLl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3623737f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730206538; x=1730811338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo5tjCzvkjU2q79mZUINpDF0j63nMfsTwMbRISK5XWg=;
        b=liL4lnLlX9DxaHaOdkOXmubQk0roBoobR0dl3s5ESM3KJPlEOx/ifqlO2X7OfrQJU8
         eiRSzCIy+epyt7LECq9Ze/hM1lC+5CQf2TwdbJg502ZGiF7YlZ7N5zijJLeqbNVOrHL5
         4m4ahiFR71RchLT0gU01T9YhMeuCNv3fk/Asoei2oOtq66nxpUQ2zVZHaLbrGCZzKoqB
         pPgS1DSs0lPPzFgZG1y/5tDOgmHS+JFDTeaHIAX1imRtansy6XqtdhDVMWN/XCrxuyVg
         zcUMciUnKSiUVY2Atg+4+FLMCXgNiIeIWAHU/TiFJI7Gs1YqQw+FJSF0rJ/guC9rdJL1
         BmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730206538; x=1730811338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xo5tjCzvkjU2q79mZUINpDF0j63nMfsTwMbRISK5XWg=;
        b=T2/lTzgEURoT7Qlg6S2sxokFMIKzDEDZBjm0XFKkh3noCYgyRKYmohP/JfhyZfBNw/
         722Y3+ZvB9QS0uOk+b/yQObtoVU7Z4fmQpJLngggMZfIb9s5oNHScfUajRk7z3lWpZhK
         10zp85Xhry0m3JfOvVel5jNX8Y7ek9zTU6Ny3WlqSqcs3ECh/4rebecvK/8nq6lq3pwg
         SMsxiSbTSUl1HFM1tY0R0fl+/JlqcSqBWfWiGdrz1ea+0ZDFIXvXfdkQljnN06noLAqk
         8zYflw340/zlXJ3dT3ZxQfbUuAlQbjQXRRJc/Fbx8aK2a/09Lg1KWDsTnZS9tDEUGApP
         yi2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ig706azzGD2n96CeuUE/aLnTuQtSkWyB03ix72cSj7R6zSCQNvHICYLVIub39iL8A1go6IZ47ygrd+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlF5m4utYobaSNsb005IQOWqtqF74+ipaQYdI69aPDRXUbpcN
	XQrVpjiA+CWb7eNrkVc05KOhXXlkfmgUNX6/ulB56aNAfC5/J41pQwlJDXuT2pJp44x0cC+wz+i
	lrJIdt3lYD8zFTz+kf03Khszx1XTkKVfi7Jpi
X-Google-Smtp-Source: AGHT+IETmQQTDrL4vzmRoJuOfPmcPv8jJvaCBtX/7GajtM20569P5Q3g1pr1IEWMYE0imQiiY7vndpIG9NNADzh62fw=
X-Received: by 2002:adf:cd83:0:b0:37e:d715:3f39 with SMTP id
 ffacd0b85a97d-380610f7bcemr8407978f8f.10.1730206537735; Tue, 29 Oct 2024
 05:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-4-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-4-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 13:55:25 +0100
Message-ID: <CAH5fLggCouwZa7894SAdkVtCHVO-y7iV2G0-b0pjec9gbt6V6g@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] rust: pass module name to `Module::init`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> In a subsequent patch we introduce the `Registration` abstraction used
> to register driver structures. Some subsystems require the module name on
> driver registration (e.g. PCI in __pci_register_driver()), hence pass
> the module name to `Module::init`.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

The C-side just uses KBUILD_MODNAME for this. Could we do something similar=
?

Alice

