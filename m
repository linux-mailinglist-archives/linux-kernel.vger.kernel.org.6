Return-Path: <linux-kernel+bounces-400258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60979C0B15
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B981C22F47
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217BE215037;
	Thu,  7 Nov 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epJMQqkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780ED215009
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995960; cv=none; b=W/Up7LX4YCZrESWJebLe/3cs1Wk0pbDKenfKcjtyH5hYUZQJhq+mi0uwTjVYYQmFhLkVDL6jOyQM4kOXIw1BcEcD+LYMT4fKkGqmdMuvOUgwm8WGwlzML3glASbioxayGgiXBtTOxsEZSjLEkdedmLkWs3SkCV5nbKw+o3JdUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995960; c=relaxed/simple;
	bh=HkyzQfU/YWQ94VKF6hjA3/zJTW/2/cuXNMB+jvmGzs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lj3XLUW/W+RjANfgCcVzKXE6ZQms09NlDtrf9bjFFG/FwscHOViJ6zv+REj9QwuiYuR18iM7Nyl110YLo7S+0/64c3m6zZEXG1yYWhM3P+081cwuIwThCNQsPrSc9SAsNNRMVqmpKvjBFdWbs+QcGpasCfe4xnVEiZTql+RuRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epJMQqkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B154C4CED2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730995960;
	bh=HkyzQfU/YWQ94VKF6hjA3/zJTW/2/cuXNMB+jvmGzs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=epJMQqkNM+ESNJjXDFaeoY+XigvHL9vtmzMOhtHMKqNwxuIUHYFhsSiXRDP3410Lr
	 JntpGF6JZTkMwTGNLlM+citARYCJ+ttCYETJ/Lj4qeo8iMX1SXBwoMKymtgt66iFGi
	 U+HbuHuhiJcbXdRG2HmT8hk+3lYemPdzJ2URbNQFcu1d7r5XyVJQ2eabjA3B3gTETI
	 fxyDuFsQslPrktBprSNAQLDWPM1OgFWsMu/9OkN/EaxsBSN0hD3Da5yrqd1XOvtcMe
	 wlqg7s0dLmm8sKXWo6MZtuZiVKqnW5PjGOZ3qwRnGrwUQpj7SN/A/jdCmWMoRujs0Y
	 pYtakgmFVcNMg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb51f39394so9924421fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 08:12:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9A0hdqWeFj4vwJ3EoMmt5Vr7V9dsBUMUAABE0QCDJMfEps220VQ/IqslulcOGAuW5hNAPhOP3ML8+qyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21FT9dS36OVA+y6J6XCcF7IwBOT3lnMcBMMMMG8f0Zs9JoxRp
	zkJh5ruppzT+Qo9cq89K6omZRTUtDlo04m9tV3P1rjMtZkpRA7wMHlrlD/KsS3VBkpz5noviPXo
	oBeh0O0HBZNrBY3neo6kN0higkvc=
X-Google-Smtp-Source: AGHT+IGSIFu3S2G+gZU6ZHKD5uBYHmfwUrb6PGP4MRbADkkQI2Kzfvxe395OTiakIVHFYTrU97KxqBuwCB+5rzdSmtI=
X-Received: by 2002:a2e:be9a:0:b0:2fb:58c0:de5b with SMTP id
 38308e7fff4ca-2fcbdfb098emr241770151fa.11.1730995958249; Thu, 07 Nov 2024
 08:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605101610.2824747-6-ardb+git@google.com> <20241107155941.GAZyzj7bhkavHswsI3@fat_crate.local>
In-Reply-To: <20241107155941.GAZyzj7bhkavHswsI3@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Nov 2024 17:12:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEy0B3Jf_njyign-WuPup-hEB4a9C3dPk4xrZzH9mz4Ww@mail.gmail.com>
Message-ID: <CAMj1kXEy0B3Jf_njyign-WuPup-hEB4a9C3dPk4xrZzH9mz4Ww@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] x86: Rid .head.text of all abs references
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 17:00, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jun 05, 2024 at 12:16:11PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > This series removes the last remaining absolute symbol references from
> > .head.text. Doing so is necessary because code in this section may be
> > called from a 1:1 mapping of memory, which deviates from the mapping
> > this code was linked and/or relocated to run at. This is not something
> > that the toolchains support: even PIC/PIE code is still assumed to
> > execute from the same mapping that it was relocated to run from by the
> > startup code or dynamic loader. This means we are basically on our own
> > here, and need to add measures to ensure the code works as expected in
> > this manner.
> >
> > Given that the startup code needs to create the kernel virtual mapping
> > in the page tables, early references to some kernel virtual addresses
> > are valid even if they cannot be dereferenced yet. To avoid having to
> > make this distinction at build time, patches #3 and #4 replace such
> > valid references with RIP-relative references with an offset applied.
> >
> > Patches #1 and #2 remove some absolute references from .head.text that
> > don't need to be there in the first place.
> >
> > Changes since v2:
> > - Rebase onto v6.10-rc2
> > - Tweak commit log of patch #3
> >
> > Changes since v1/RFC:
> > - rename va_offset to p2v_offset
> > - take PA of _text in C code directly
> >
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Brian Gerst <brgerst@gmail.com>
> >
> > Ard Biesheuvel (4):
> >   x86/sev: Avoid WARN()s in early boot code
> >   x86/xen/pvh: Move startup code into .ref.text
> >   x86/boot/64: Determine VA/PA offset before entering C code
> >   x86/boot/64: Avoid intentional absolute symbol references in
> >     .head.text
>
> Those look forgotten in my mbox. Do we still want them to go somewhere?
>

I'll get back to this next cycle. Patch #2 has become redundant now,
and I need to incorporate some feedback from Tom into patch #1.

I imagine #3 and #4 should still apply, and they could be taken
independently, but there is no urgency.

