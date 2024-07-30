Return-Path: <linux-kernel+bounces-267868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DC19417CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867AA284367
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0163D1A303E;
	Tue, 30 Jul 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcYjZxfH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF21A302C;
	Tue, 30 Jul 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355942; cv=none; b=C6neZlzJAcKguv/YKaQPMIcgXvm5tHeDsZYgEYHMKvUuuoFnuf9dcsveToU2IOcnWt+vb+WxXYNdfObGjJvnNh++SwDqKgfuLt5kXipoiw5pH8wzGiWitpyyxB9ZkGHHDg9Q790qpktYpyK5FrCWMLnmJaTd4evaROvwE5W4mZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355942; c=relaxed/simple;
	bh=dyYGwkd+8xGE4QTeYGQ1VzJupmpMyYNc5Uc4DdmZITI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFSfXrhuinYlu5MhI8dN/KGooXNFZhy4Cmg7zlwy98u3mJmMfD4/Qw9wROlQbo0vHqVFwDAeFFVTotQfgAWhb5QaGB8uwTJrUwPpylN7XgKzy6kUVBN6ay1cYVMMDomS/M7HjOoYwmiC24Mv1/jbL0WpnlpsSLx4mHJhFHLGiNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcYjZxfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2390AC4AF15;
	Tue, 30 Jul 2024 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722355942;
	bh=dyYGwkd+8xGE4QTeYGQ1VzJupmpMyYNc5Uc4DdmZITI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hcYjZxfHj6r7Uq9vbypCpTIxb4WjsTr2G1HvgvNi3KLbYEpGnSI7fnhsAdMNqDkro
	 m8X/vC4ovWQeblb1jcuKYCbHwGt0UohFmImI5BFqopIam3B4X4fZ4zVLC+cMIDulLD
	 FK+QNUGoh1r+vgjG3HbAf/Nma/93G4vRnwnjKqRdXVvhxfngLs6DQ3gjJ4fgt3eULB
	 6mL0dOB0ooFZ1reOyjidQIWZvoV5MYf1jVrzdI3hJK+dBPLpGW5hrTtc/Lvy+uxb7M
	 /hMj+lE9KHHFrrV/rphhPLez+JJFIDpha+3XKDsw+luTxmRlOmxK/c3NA3b1k412E+
	 1PKpzoZOz4lkQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso7660944e87.2;
        Tue, 30 Jul 2024 09:12:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQRbCudCk2oSJNzFAGjsKRGhklR4OrBmYisz0VjOFF6EhxZ8viTWSo2KxJX7dzoHq7Cy/142B3GR8A10Q3EvKR0Fut4WzFzsVUEQmSruO930ETJpVMY/rfJVm+6qoXc5fBaB0vdmMHK/36Eek=
X-Gm-Message-State: AOJu0YwgohZSTTXcQ7u+hX1tp/pibNjAKEfr9JpzcooLBKUsNAGnr2bJ
	gAtMljx9tAP2CmyKKzCqJZjhC0k/NjBxkQ8QlzklzlKPIH3dXyIfHuC2Zu1NxVuCLVcUNGvuUIp
	75V1cOOsWMzbPckjpN5dLLGAsGwo=
X-Google-Smtp-Source: AGHT+IH0ck9TTwa2cGDbn/iLiyhggazMPWGKvJP3S9fGn0rpH77IxbqhyNSu2l01jLMb1Xgt5i7TpIg+h6v9Pn+cAOo=
X-Received: by 2002:ac2:4a7a:0:b0:52c:a465:c61f with SMTP id
 2adb3069b0e04-5309b2ce625mr6738370e87.56.1722355940302; Tue, 30 Jul 2024
 09:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com>
 <fc3e956c-4f0d-4705-8429-2b7c50e335ce@gmail.com> <CANiq72=kAdq4TsCPvMWBwdzngeOst8g2cGzkk1DxM2yW=V4emQ@mail.gmail.com>
In-Reply-To: <CANiq72=kAdq4TsCPvMWBwdzngeOst8g2cGzkk1DxM2yW=V4emQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 30 Jul 2024 18:12:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG-gjTnT2=ZXJj_DEhg20gmnutxad50n+m8u24KiyV_Ow@mail.gmail.com>
Message-ID: <CAMj1kXG-gjTnT2=ZXJj_DEhg20gmnutxad50n+m8u24KiyV_Ow@mail.gmail.com>
Subject: Re: [PATCH v2] arm: rust: Enable Rust support for ARMv7
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Christian Schrefl <chrisi.schrefl@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Sven Van Asbroeck <thesven73@gmail.com>, Geert Stappers <stappers@stappers.nl>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(cc Russell)

On Tue, 30 Jul 2024 at 18:01, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jul 29, 2024 at 11:58=E2=80=AFAM Christian Schrefl
> <chrisi.schrefl@gmail.com> wrote:
> >
> > This has been on the mailing list for quite some time with only a few r=
esponses.
>
> Up to arm to take it -- if it helps, I tried the patch, including
> building, booting in QEMU, running the KUnit tests and loading the
> sample modules. Thus:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

If this needs to go via the ARM tree, it will need to go into
Russell's patch tracker

https://www.armlinux.org.uk/developer/patches/

