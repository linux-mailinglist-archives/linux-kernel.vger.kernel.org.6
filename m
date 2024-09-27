Return-Path: <linux-kernel+bounces-341301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F76987DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC51B235DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2030A172BCE;
	Fri, 27 Sep 2024 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5Vrbm7q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFB15B15D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416178; cv=none; b=Lu09wfoBj667grZpdAjgOh+Kb0AvLP3fzeR4PBGbOCBRi5iFd8JhpYLd6giU0blX+cKEqTu30I7fbOPpsw3HCHKKOd2OGTRl1Uqib8mE/mPJQ/E8oFGai87biFTE3yttQsldR9HW4XoyCpBD3YQVY1QHMldT0y2etNviBXiB154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416178; c=relaxed/simple;
	bh=OAV6m7+cwGU41PmGCEjKHSA3XIOTJGqWSgQFRzIKJsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLG7MW7+hd/96EaXy3vs5sgJ+HUM3ryGAQh39ltb7S9Qml47n4qHdDYNn/IcWh44OSQ9vEfYlo6Bh4dSxAKgtKpHbWCXyOk2ANN+4BICYyoXjV2tWywC8l6HX9srkG5KyR5wfgSTqgeIEfHAn8I8DtoiBXn1wFg9J6NY90N2jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5Vrbm7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0244EC4CEC7
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 05:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727416178;
	bh=OAV6m7+cwGU41PmGCEjKHSA3XIOTJGqWSgQFRzIKJsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y5Vrbm7qwie8s3GLveZ8q7/29ZOrSo+X6do00jjdj8SHerflNUn32ClZSU8P64JfV
	 IFZKV1pHF+1W8Xf68L8OJIZ+WKX7o1rF25yYNcwJRkKwoUFH9XUfPcgEAau594yAve
	 bFsLBp8897N3ZGONvmCL7S5Dkgt+3GYR2dgnDOK6e9CFKGIJS92reVAB/gtukrJigG
	 OO5ijqHU2NfUS70tgoWYfLUdf9Cer2Bd/kZlAWX76/r/vi0aY138M5D9FwIWycZaY4
	 985s9EFdQpnVNMkV8nKoc3dKJvtNcVOTa0RUK/rvlyue1kvZcVnObYlzElxX338MEy
	 W5+aDqUoolbTg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f7502f09fdso15393961fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:49:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFsOyUlmLJ5/mLjPAu9gxXFceVMbCX87FzAqeVAQsRYf6pmY+pYYz9kg44h8DHErxqfP2tn4BUPFIojEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxafmotFoCZzNmn8/+8tO2zoJZQVzoB1JspTclSS9iGMmImZh
	EMTIPfZoyaMZ8hDkh5+lgRYSajn7DSFYDSpoMmrIrC1dnw1sFJvBTKCNDgSuil9tJO7zE8g2Ls9
	GPrPorcfNcqFdSlSG6i/wWUNaYCE=
X-Google-Smtp-Source: AGHT+IEg3i4mtfqzM/7ZJ4W8rvOfwugjXU1DbntNVFkHJiVWnQTCrLCOhkbCLplK8jRwu/TlJiMLQw7YtshLS+1MGCg=
X-Received: by 2002:a2e:9916:0:b0:2f7:6aa4:2266 with SMTP id
 38308e7fff4ca-2f9c6ccb761mr14735341fa.12.1727416176356; Thu, 26 Sep 2024
 22:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926104113.80146-7-ardb+git@google.com> <20240926104113.80146-11-ardb+git@google.com>
 <572b339b-7dab-4db0-8ee8-d805f8211aa3@amd.com>
In-Reply-To: <572b339b-7dab-4db0-8ee8-d805f8211aa3@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 27 Sep 2024 07:49:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGt76Z0VsWog5Y2srBp8MiYXqkkhOQvFiZ7ULhNB3p6KA@mail.gmail.com>
Message-ID: <CAMj1kXGt76Z0VsWog5Y2srBp8MiYXqkkhOQvFiZ7ULhNB3p6KA@mail.gmail.com>
Subject: Re: [PATCH 4/5] x86/xen: Avoid relocatable quantities in Xen ELF notes
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 03:47, Jason Andryuk <jason.andryuk@amd.com> wrote:
>
> On 2024-09-26 06:41, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Xen puts virtual and physical addresses into ELF notes that are treated
> > by the linker as relocatable by default. Doing so is not only pointless,
> > given that the ELF notes are only intended for consumption by Xen before
> > the kernel boots. It is also a KASLR leak, given that the kernel's ELF
> > notes are exposed via the world readable /sys/kernel/notes.
> >
> > So emit these constants in a way that prevents the linker from marking
> > them as relocatable. This involves place-relative relocations (which
> > subtract their own virtual address from the symbol value) and linker
> > provided absolute symbols that add the address of the place to the
> > desired value.
> >
> > While at it, switch to a 32-bit field for XEN_ELFNOTE_PHYS32_ENTRY,
> > which better matches the intent as well as the Xen documentation and
> > source code.
>
> QEMU parses this according to the ELF bitness.  It looks like this reads
> 8 bytes on 64bit, and 4 on 32.  So I think this change would break its
> parsing.
>

Indeed, well spotted.

> (I don't use QEMU PVH and I'm not that familiar with its implementation.)
>

This is what I used for testing, and it worked fine.

But looking at the code, it does dereference a size_t*, which seems
bizarre but will clearly produce garbage in the upper bits if the note
is 32-bits only and followed by unrelated non-zero data.

I'll just back out this part of the change - it isn't really necessary anyway.

