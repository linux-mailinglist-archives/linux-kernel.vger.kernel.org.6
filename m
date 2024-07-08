Return-Path: <linux-kernel+bounces-244747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECD92A8DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103F81F2222F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFFC1482E0;
	Mon,  8 Jul 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egVG5gHv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7033981
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462677; cv=none; b=IDdIFFd55Poem8M6aWTNSyu0XZYdfn3ORK/ndOY5XperI3xQkZqB45Di7W/WdHyLjay3gJDG1C6WbavlY3LBiyq7O6uZmTzYfsdusHcUQfwDBc1LfGjSSC3Zx78069XfJ9F7FKnq3uXQ0wb0oAlqDY8wVV6FpouK6yBtO1U8WZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462677; c=relaxed/simple;
	bh=TckduDfzqYCmJUOLvh5Rb41T/8ULHOpzsQ7S38Da2UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQqlINEaKako4xBmUa8G5wAWlbrRo33bQuVsmSf97z7S7VI3lW2ZUXg38DIMdEpJs5wtM6csRXMflLjeGQ2I1HblchxIwx5ksYBQVGpd0bN2GAd1upPmBeWyyvhq+XSoN9liZO3Ao5HsEFqaqh9nWZFXotMIZyGv9rrEH3xxNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egVG5gHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE2BC4AF1C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720462676;
	bh=TckduDfzqYCmJUOLvh5Rb41T/8ULHOpzsQ7S38Da2UY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=egVG5gHvmqBsRFiBSSX98W+lgfW4BK28gODerJDkr/XHiIzospnY3Po5RfEZscKz/
	 rtlL59+4y0h+ryZRrbifHyjLBH4JQWFVWUCMGGB2VtfT9dMJdKxAESH+ClWACl3mwl
	 8RezTiIjn7azi4SOIlZaH5WMTF8o03ZsZeLpGrk9oZ/xXJqNqEJ4SEwmiX7zR6FEYs
	 rUFIeGE8VFYL3hIuMxiUEyXcbNlFDy1FotMSdLgKC8ZgrKGgaNYCWmOYbuHK1aQ7II
	 uZDhVlEjDzB1NZtG7TGa1NPAc656fRi02QR9pgPqvHh5O0gCVecZ1XoihhGZ0hhRKA
	 8YqOuf9VFSqJA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e99060b0dso4683359e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 11:17:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4VGPVXAhopmUWIjfv7lOzqM7HhVnrQ6TaEyKKnXONCk3w6Yypm8nXHcyBS6RX3d2FgMZH9WOZ+fgm+PjUVBc4jQ13qTmwMzPGp7aI
X-Gm-Message-State: AOJu0Yy5eTW4fbXIQ0BaXVtIUnjxr5UUc+5MRU3CPMhY49vDmWnWzYPm
	bTFbxH3JhRSyx4BKUYG2PCGaoMD/Ec7WsWF6bSePr/DpQkvWbBMjBMacq/hchLR0jDJeAEfi57R
	ilp9f+Iji3TWwD9wDnLf6Vf6Ezrc=
X-Google-Smtp-Source: AGHT+IFhVGMURb+9XEcAUzp8N4rLm9Z3cBW/UZ0HctpWgRRgjS3LNvb21ei0S+bKEATkAJRqJU0vbTtpKrefvIC2P4s=
X-Received: by 2002:a05:6512:131f:b0:52e:9ab6:cb53 with SMTP id
 2adb3069b0e04-52eb99da202mr92826e87.64.1720462674803; Mon, 08 Jul 2024
 11:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com> <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com> <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com> <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local> <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local> <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
In-Reply-To: <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 8 Jul 2024 20:17:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
Message-ID: <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
To: Borislav Petkov <bp@alien8.de>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Pavin Joseph <me@pavinjoseph.com>, 
	Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>, 
	Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>, 
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 20:12, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jul 08, 2024 at 10:42:47AM -0500, Steve Wahl wrote:
> > So I looked at the code more closely, and I don't think boot_page_fault is
> > going to work prior to the call to initialize_identity_maps.  In the current
> > flow in head_64.S, that comes after load_stage2_idt, where here we were
> > trying to use it just after load_stage1_idt, quite a bit earlier.
>
> But still after setting up the #PF handlers in both cases. So it can't be
> that.
>
> > Is there a reason you want to avoid having these areas already entered
> > in the identity map setup by kexec?
>
> Well, imagine my one-liner worked. Can you think of a reason then?
>
> So, theoretically, this should be reproducible in a VM too, I'd say. If we
> could manage to get that EFI config table placed at the right address, to be
> outside of a 1G page so that it doesn't get covered by a Gb mapping.
>
> Or use "nogbpages" and then maybe perhaps with Ard's help hack up OVMF to do
> so. :)
>
> So, can someone with such a box boot with "efi=debug" on the kernel cmdline so
> that we can try to reproduce the memory layout in a VM?
>

Happy to assist, but I'm not sure I follow the approach here.

In the context of a confidential VM, I don't think the page fault
handler is ever an acceptable approach. kexec should filter out config
tables that it doesn't recognize, and map the ones that it does (note
that EFI config tables have no standardized header with a length, so
mapping tables it does *not* recognize is not feasible to begin with).

All these games with on-demand paging may have made sense for 64-bit
kernels booting in 32-bit mode (which can only map the first 4G of
RAM), but in a confiidential VM context with measurement/attestation
etc I think the cure is worse than the disease.

