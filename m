Return-Path: <linux-kernel+bounces-178394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC8D8C4CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C721C21655
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AC512E48;
	Tue, 14 May 2024 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHCHIdnh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CC1171D
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671648; cv=none; b=l6s98rFZXOOOhMX1QvB75CrNetImeNnJvQETUdm11T4TMgKZKDLbO++D1gr5nPysAkpRdurY0fBElDtOKU7CjbkLwo0LsvTyFFQsmWUhhdRVbsmrzVdE9QP6e7hgE6MhyT96toSPOEBFm4NatjhV6ag4wODDIpReduz1MFbzR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671648; c=relaxed/simple;
	bh=TqhinNFjSGuaDrXWXAqhFvMXWjYHGbbwdwxYawJQ4sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aj7pkQHiNdHquk760fT1IC+fmnFnmhFHzpFW/6XHNwrEhqeWORbinA1wcUGumzDtuYA6jiiKLi2ChKeoYYPi2LqoHYkRlAykTJrCnkOHRL6PlHdM9GjuuGM9JWjgo7Gg3zywu6PzzhOmIIYGIFlPi7gKL4KmLbo8ZJ4BMi2xi/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHCHIdnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C02C4AF07
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715671647;
	bh=TqhinNFjSGuaDrXWXAqhFvMXWjYHGbbwdwxYawJQ4sw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BHCHIdnhPX4RsaleVTOntHFdPgA5VCdTHvBewqlv00zzYBaUErHK5skEPpWvWHHDQ
	 25zr4OdLD9HKBYf6j94LZaZ6NpKuaII1RjZO8aDPw1xEpvndZ++9Xar77Jp6Oew+QD
	 abxaC00yNIjpQLOx0F185nOg0mnCAaufsT5xAnoNS1mK5xBZbTORyzNyNkg7iSwo7Q
	 PztrHYjV6NjIDhdqecSDOb0yFOKBoU8mBtG0B7X/bGYyAzVtWmNTljUVAptBgW1FQa
	 PuPsQ55oa0Xxep2lMzmnrqbormcxu7oyUCdNnkvmc4iVYKqC3VeKWm4/xyT03EkNCO
	 fu0ByWbhzICHw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51fdc9af005so8410713e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:27:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWu3ICZcYreh4adRSKlQtTiVrjLcU8bqZlrGzNAFEo3vISmNIa9vZcPfRaq+C2pO3rkDjEHBWnw+57UIBDnvNtZG0x2T5dVJTrip4qi
X-Gm-Message-State: AOJu0YxnBPTamYrrzIKDwQKlLgX9Y0VH4uI6HMJzBpUSF3HXugLcmdOh
	eoEdSNrDkjqEM/3ZidUhXhGcsp7Z8tx0PPajNO43gsIjLfdW4UsC8Av+YebpNMAxXQOLCIYfU/Y
	pfCCRAOJ6SRDrbgsttk2cy2TkfIU=
X-Google-Smtp-Source: AGHT+IFb2Fu6tbJ7U/OU1BNfRtkuj5gKMgvA3G7Uzj3W7z+HI4TgzIHdON4/eq8tA9A/tjX3D+TSvmuEroH6CpUQMPA=
X-Received: by 2002:ac2:42c7:0:b0:518:9ce1:a5bb with SMTP id
 2adb3069b0e04-522102786bfmr8597991e87.54.1715671645978; Tue, 14 May 2024
 00:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkG4cMe1TFI5w7sc@gmail.com> <CAHk-=wgf=jwo1HZjQN7UeFw7iYPtQ_i0ri7JNOci+7Rn5-pDcg@mail.gmail.com>
In-Reply-To: <CAHk-=wgf=jwo1HZjQN7UeFw7iYPtQ_i0ri7JNOci+7Rn5-pDcg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 14 May 2024 09:27:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHm_tmBPNTvnvn3r6myeRo5x1fX3_J73UA1j4bVBo_PSg@mail.gmail.com>
Message-ID: <CAMj1kXHm_tmBPNTvnvn3r6myeRo5x1fX3_J73UA1j4bVBo_PSg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/boot changes for v6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	"the arch/x86 maintainers" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 03:03, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 12 May 2024 at 23:51, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  - Re-introduce a bootloader quirk wrt. CR4 handling
>
> I've pulled this, but shouldn't the compressed boot also just stop
> setting the G flag that it didn't understand?
>

I agree. But not setting CR4 to a known value is what caused the
regression, and that could cause other problems down the road, so
fixing it was arguably more important.

More than happy to send another patch to clear the G bit from the page
table entries created by the decompressor, but at this point, it
shouldn't make a difference.

