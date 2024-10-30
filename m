Return-Path: <linux-kernel+bounces-388755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D29B63FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDEC1B229EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99511E47B6;
	Wed, 30 Oct 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPkpOGUK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDAF22315
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294735; cv=none; b=Fb4+L7kINq2ogC4jA5j1fkW/atW940Niel4sEysr+9xH+0WSQiT3vJBVzaN7ORICy/ffmWjsRtjUMF54znJuxHFC2gS4kwvvpHUsYUpnmP8kq2V5uQE+eCD33sf4OOEkDJju8B2hB5OqwSC9iZpYmdfWF+aiAjSUdDwwpd5wLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294735; c=relaxed/simple;
	bh=DYyWWFhYRCAfnaQMpfQegjXrle2h88tfxIyelrqqD2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKc0HnyAiNIZ7VnMOY4I/dbQ+ZaKRR4lkpUiW5rN4SFlZ8lh9Pz8rCkm4bvmJYcip6lWq4MMRkmqtVwAJQkp2UUIdI84Mnq4b560hBWuwog1dspUsCyrOJkaThHDLuwR4q0WMuLZBJSibqgm17b52Wha9yG9iwTvV69+PhnOxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPkpOGUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CBDC4CEE5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730294734;
	bh=DYyWWFhYRCAfnaQMpfQegjXrle2h88tfxIyelrqqD2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sPkpOGUKP6YRh9qfnzWsuHdIo+HhAPqh83da8CmdT3vl2MIhKvanEItM9VPPvh/Yj
	 zdRdokMDa7L086/V4UuHi8lQHXvxxhggYmUUfHbcRsaKn5VEidObhdNoww6jCLAdLT
	 vEntsBo7IrZVxuVFsb/F99mnmULAI/CVALZI65eK2Pf0mvOcu35lo7GYQ5+ZTtpDpH
	 s+bDWsGYKK016o4/uzyhsujDiRnI4fIVaDruNJG+tPJQAI/uThymOQDrcHH73XmToV
	 Mc88tIfHrNVGaDZhTK0OKUbwp27JF8nUSQsRTOBiZFT2u0+IMqXwEh2m9rhmloq6pJ
	 93izJYRh9gi8g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fe02c386so879587e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:25:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVcCk9eSJNdL77C3XaXjVmFjesidWpTtfslpyvPw2kzQmNWcmwPcKiWH6WLhdv9Fz3RtkEAlIZ5jbalr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNehnmNMzI/GCbe+JKZihPbfOwjvBQuqSwjiVYtLEUazuCujhF
	/nOXZtiZXXeugiNRvh64OHSPWbcF1z814wdgOeYcllCw+A57YvKtgrFPLHGgldKL96zexibUaO2
	UlyLexKy1d3RO94+I2tgJ9BhCZqI=
X-Google-Smtp-Source: AGHT+IFa5NPZ4ZduUGr0zqQdLHnPC3Jah7Z4BcbBu/1AywhN6VuZsTUgtXoBp4uZWrclnlDPgyarxQIkykReYK8kL0M=
X-Received: by 2002:a05:6512:33c3:b0:539:f1d2:725b with SMTP id
 2adb3069b0e04-53b493d4205mr1736060e87.4.1730294733142; Wed, 30 Oct 2024
 06:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030101803.2037606-10-ardb+git@google.com>
 <20241030101803.2037606-17-ardb+git@google.com> <861pzx3gll.wl-maz@kernel.org>
In-Reply-To: <861pzx3gll.wl-maz@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 30 Oct 2024 14:25:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFysNcRiH6nFt3UMhJCuCr6VXZ5XM1Pd9x4gjLS6=ASHg@mail.gmail.com>
Message-ID: <CAMj1kXFysNcRiH6nFt3UMhJCuCr6VXZ5XM1Pd9x4gjLS6=ASHg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] arm64/mm: Use reduced VA sizes (36/39/42 bits)
 only for user space
To: Marc Zyngier <maz@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 13:44, Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 30 Oct 2024 10:18:11 +0000,
> Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The advantage of a reduced virtual address space size is its impact on
> > the number of translation levels, which affects TLB pressure. The
> > working set of translations covering the kernel side is negligible
> > compared to user space, where each process has its own set of page
> > tables, and so most of the same benefit can be obtained by reducing the
> > VA size only for user space.
> >
> > As a preparatory step towards implementing this, drop all the reduced VA
> > space sizes in Kconfig, and replace it with a configurable userland VA
> > space size that is reflected in TASK_SIZE. This will be taken advantage
> > of in a subsequent patch to actually reduce the number of translations
> > used by the MMU for translating user space virtual addresses.
>
> I think this may have an impact on KVM's walking of the userspace page
> tables to determine whether we are trying to install a block mapping,
> which assumes that the start level and the number of VA bits are the
> same as the kernel (see get_user_mapping_size()).
>
> Probably nothing too complicated, but something to look into.
>

With the crude hack I used, things should just work, unless KVM reads
back the value of TTBR0_EL1.

But once that bit is implemented properly, it is definitely something
to be aware of. Thanks.

