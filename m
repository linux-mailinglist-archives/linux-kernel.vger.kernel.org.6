Return-Path: <linux-kernel+bounces-344297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C835C98A7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AC11C22B92
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CBA191F74;
	Mon, 30 Sep 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNu5bflg"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29723D2;
	Mon, 30 Sep 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708284; cv=none; b=Q1365e6Z1718mOoS3rfXQjBX9ThKJNiiCb7vcmdBCIZeY5TzgVbpal2qBtmhOO0LifH/pcUzQrDYapdkRWJtKVZ3kwAJi0SRBslcxOxsFyyBiTIzsCXbT5CY6o1xKQrW7ReOzyR72d1gLkllGwi5yATsGvtJ99W6vei7uzV5rz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708284; c=relaxed/simple;
	bh=ZYXFNKMpMJKZs/jopytSPFRtqO07ZKfYT/0NCDFBhYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWBA4uZCVh8NbVji5wfRSEbDBDyomDYenPCZ8GI36M3zIUaKMcj6nXPh0T9RzmQvv7QmKywzECCzX1T4HKAZY6ASM2ARfr/hNGuu1qbJ4aneeynENbjv0vuwLmpDur4Sbcks/jHzJ4b12Rsaabg5EEh4RhbAxfmDaoRZSw41ywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNu5bflg; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50abc034f6aso325026e0c.1;
        Mon, 30 Sep 2024 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727708282; x=1728313082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3STRu4cbHglj5Qo8K4nwrkA8bytC3Rp9dmwDT7SL+o=;
        b=GNu5bflgLmUrizyg6AeOmpbt7wUHuZlGWaLh5nxfJtNUadC+yyyiXq+HNrCmkf6P5v
         8jZsNiD/NIzIUmcWfyQY9H+sLYK/nQ+H24CAeu+z2jyHO6CSkzsGFIvGlOiAFmJpOdcl
         440cUlknBAVL1li1AyoBV6ukB1+SkLzInQ0JjBlwIh8saB/uDEShhAxbvLEXO0tC9Kdi
         XtZ+VlIRK8pbvDDqGvAXBI3WgWeLqKJ2rUlHsnUmtxNrI8M2sh4lFz4Oae9VoMmKYs2Z
         mwisMWpF51u69mVL3zdjRSBh1DnIjGgW/1H/LJ82kVP+bErTzPX3UF9d3Hn2HuPmE2/T
         2ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727708282; x=1728313082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3STRu4cbHglj5Qo8K4nwrkA8bytC3Rp9dmwDT7SL+o=;
        b=ue7Sy7Nmhg6duzshvZorSKT9yA2hIiQb428CnVVW2TEGSHFNunw7diKjFcVh0HIJJu
         pTaqRyP2o17KZmLuHeUfgVUON2mqPli00yAaeRxxBY40xdc0IDB0KRWAEorPuRNwqRVS
         CwY3HjYDKKMevJNUZAKseJsSeQ4eOzd17i2iqvX8syl8wsUlFNhBJPzQ7I4Ld8qhLqZf
         4wKl6Srqve8JgAKPP7d5O662TzxRoqZ10QXFngBPtB6GrYTqKC4xCDoDZacRZsLpQhet
         SXTURVDdOY57Ofywv9FpWif4FClPyRrgRen/kq0Vcj52Te7WAMSOeuYfI22xsK1i//F6
         +mGw==
X-Forwarded-Encrypted: i=1; AJvYcCUBfIhSVGPw54rdF0ug48mCsdbMx/UBY26cl26LbGyxsOEH8FWK3TYer2I30/LOOq5k8Aj6hy3CQb9OelQ=@vger.kernel.org, AJvYcCUm9gpvgnOjjlInTR6zNmqqsTCojZvGKhmEFZBi/ROzYCERwvP+i3WJxzqjspjP0fCQ10id+I8VGSkmZoIhnO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyci3GGcKuzCJ7yfC0pa7ld/pnndv2TOIMM3WsUHrpmVZGxx5Xe
	kFskHsG6OQDs7e3mWVc+Jk8Z+0YMzU1FVSCNQLi68runiIfrzco68FIarh/43V+ZgGB03WT9Lhn
	WH0rYl/ygLEvxC86n9BBSZ9+CZsM=
X-Google-Smtp-Source: AGHT+IEZHb++QhjTvB8G6SSCOAKGzRDqfccgpUNoWOf+e4Kmpi2KzjIvbBFOp5BGQW5LrWjjN598noYQxSFVh+6rZk0=
X-Received: by 2002:a05:6122:54f:b0:50a:c6f5:e672 with SMTP id
 71dfb90a1353d-50ac6f5ecf9mr1698566e0c.13.1727708281673; Mon, 30 Sep 2024
 07:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930144328.51098-1-trintaeoitogc@gmail.com>
 <20240930144328.51098-2-trintaeoitogc@gmail.com> <2024093044-violator-voice-8d97@gregkh>
In-Reply-To: <2024093044-violator-voice-8d97@gregkh>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Mon, 30 Sep 2024 11:57:25 -0300
Message-ID: <CAM_RzfbJ5qsHKfNxV1EzhYEDdCmXP0THH=g1MX1yHiRP=9tYFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] rust: device: rename "Device::from_raw()"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org, 
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greg KH <gregkh@linuxfoundation.org> writes:
>
> On Mon, Sep 30, 2024 at 11:43:27AM -0300, Guilherme Giacomo Simoes wrote:
> > This function increments the refcount by a call to
> > "bindings::get_device(ptr)". This can be confused because, the function
> > Arch::from_raw() from standard library, don't increments the refcount.
> > Hence, rename "Device::from_raw()" to avoid confusion with other
> > "from_raw" semantics.
> >
> > Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> > ---
> >  rust/kernel/device.rs   | 2 +-
> >  rust/kernel/firmware.rs | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

Yeah, I was think that only in 0/1 I should explain the changes ..
I'm was wrong.   I'll put the changelog in 1/1 too.

