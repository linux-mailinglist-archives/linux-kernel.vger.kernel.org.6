Return-Path: <linux-kernel+bounces-187568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1398CD42C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71A1B22D24
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802614B081;
	Thu, 23 May 2024 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TBlNJTYW"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F014B089
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470525; cv=none; b=fNe9YSeYR2hcsgAjYAbED7YOnulcC541wzwpNepilHCEczwEEndxFH66/R1ojuef6T7Lu8vKQzL5omPA3mEvs18vB+dQ+gifZTkN5sOleR4M894Jp/Zf0UCkDI/B3gJrrDT8Rwhnfo1TDq4XDVBGP1S4UXijmz48VW5aza++rlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470525; c=relaxed/simple;
	bh=NH24LVGdDYeMPuYOJqA4c6ioraAkWYckArYfePkuphA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqqRyu19Mu8s529FS4kXgir6odY4oDZdTeWhgbeCJrmCJm6SZqk9+GI6zgj/8C6WMpTgmJEoZED4j0JVo9L8v0cFUKinjsBaTqBxcRjVNBJXJA5qFXcWGmprpRVh2twkRzoOg3M1RxPdab/LI2dQvr26Z16LmxzPOL4ehsN2ABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=TBlNJTYW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a8bd02e8eso81559766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1716470522; x=1717075322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On9r6HMkgaTSzrnf05gbFZryZJM5WajSuUMiqmrGLOk=;
        b=TBlNJTYWU5SqMAL9bKhXyayirD1yhqkc9Qc7vZCj4acOA+YcYMkcCISYlrUUyXV6Ju
         iA2HnaV5ir6Km+ylNGX16uFtxfY6pYaoHJxnQwKM/cwduGhHje83HsUNxbL3AOoyEz1+
         jxJUzd4LNUJ+gQWglyS4APohz500Gzr9Tb3ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716470522; x=1717075322;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=On9r6HMkgaTSzrnf05gbFZryZJM5WajSuUMiqmrGLOk=;
        b=VauV/XTuBDwIV2a7ztwJ4plYCBhdjWgwly3cBcXM/WglRD4k5gXspFowcosyEOywPL
         z01PBE8AicrW5gBKYQXebBkHRQe5GUPdNq/lzLp/o99/I9j3Xl19ujmyZjrIW2BUrFDU
         3QL/Ro4Gb1RuFc4c3EfA7eYmENsKVlEGn+6g19g3edQ+fEsIk2vJjPrDTZx3HH0zU6Xa
         I8Iw4oX0OEW+Xk5+/BZZBjpAOmmNCX9O5bsqLdtD4v2HwxghKtBQdKBLi3yKvQ3wA2Xk
         jBt43e4BHXjssVDqzVLlq3u0BYVVc/Q7RMBHigS4X3oLlgkfXWvpfsQFp8eoO4xJCmqR
         cPDA==
X-Forwarded-Encrypted: i=1; AJvYcCWrQTRoOENwcB6i7hJW410gepJZwqBfiZqW6LZlwFMv4S2TkMmNBAHVnF+gm8wiGye7Ez2AT/JaHaUMMO2733iNHM1t8L+pKLiKD32x
X-Gm-Message-State: AOJu0YypmtAh9uZwA6REmicjVKfeaLhc5u6THupQbIbSVAPlUNlCU693
	wgqf8myv0sp16N/f+eP4YxpTg2oFgIhu5B4+j9/f7ZoDAmHjW7itJDuxoV2wVjY=
X-Google-Smtp-Source: AGHT+IGR0y2bdIOAPy2UsVNakF0nkcO1SJLtEWKLN+I3EqK+AagX4rPCgY602MbsaeBciZNK5T/aag==
X-Received: by 2002:a17:906:64b:b0:a5c:e20c:8255 with SMTP id a640c23a62f3a-a622814aefamr315661266b.4.1716470521180;
        Thu, 23 May 2024 06:22:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d350sm1934790766b.23.2024.05.23.06.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 06:22:00 -0700 (PDT)
Date: Thu, 23 May 2024 15:21:58 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Helen Koike <helen.koike@collabora.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	Nikolai Kondrashov <spbnick@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com, pawiecz@collabora.com,
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
	kernelci@lists.linux.dev, skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	laura.nao@collabora.com, ricardo.canuelo@collabora.com,
	kernel@collabora.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <Zk9C9mCj15hVWUyL@phenom.ffwll.local>
Mail-Followup-To: Helen Koike <helen.koike@collabora.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Nikolai Kondrashov <spbnick@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com, pawiecz@collabora.com,
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
	kernelci@lists.linux.dev, skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	laura.nao@collabora.com, ricardo.canuelo@collabora.com,
	kernel@collabora.com, gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
 <CAHk-=wiccniE=iZDC_e7T+J8iPVQbh1Wi5BaVee9COfy+ZaYKg@mail.gmail.com>
 <17341b96-5050-4528-867a-9f628434e4e6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17341b96-5050-4528-867a-9f628434e4e6@collabora.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Mon, Mar 04, 2024 at 06:45:33PM -0300, Helen Koike wrote:
> Hi Linus,
> 
> Thank you for your reply and valuable inputs.
> 
> On 01/03/2024 17:10, Linus Torvalds wrote:
> > On Fri, 1 Mar 2024 at 02:27, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> > > 
> > > I agree, it's hard to imagine even a simple majority agreeing on how GitLab CI
> > > should be done. Still, we would like to help people, who are interested in
> > > this kind of thing, to set it up. How about we reframe this contribution as a
> > > sort of template, or a reference for people to start their setup with,
> > > assuming that most maintainers would want to tweak it? We would also be glad
> > > to stand by for questions and help, as people try to use it.
> > 
> > Ack. I think seeing it as a library for various gitlab CI models would
> > be a lot more palatable. Particularly if you can then show that yes,
> > it is also relevant to our currently existing drm case.
> 
> Having it as a library would certainly make my work as the DRM-CI maintainer
> easier and  also simplify the process whenever we consider integrating tests
> into other subsystems.

Kinda ignored this thread, just wanted to throw my +1 in here.

To spin it positively, the kernel CI space is wide open (more negatively,
it's a fractured mess). And I think there's just no way to force top-down
unification. Imo the only way is to land subsystem CI support in upstream,
figure out what exactly that should look like (I sketched a lot of open
questions in the DRM CI PR around what should and should not be in
upstream).

Then, once we have a few of those, extract common scripts and tools into
tools/ci/ or scripts/ci or whatever.

And only then, best case years down the road, dare to have some common
top-level CI, once it's clear what the actual common pieces and test
stages even are.

> > So I'm not objecting to having (for example) some kind of CI helper
> > templates - I think a logical place would be in tools/ci/ which is
> > kind of alongside our tools/testing subdirectory.
> 
> Works for me.
> 
> We  can skip having a default .gitlab-ci.yml in the root directory and
> instead include clear instructions in our documentation for using these
> templates.

I'd go a few steps more back and start with trying to get more subsystem
CI into upstream. And then once that dust has settled, figure out what the
common pieces actually are. Because I'm pretty sure that what we have for
drm ci or kernelci right now won't be it, but likely just a local optimum.

Cheers, Sima

> 
> Thanks,
> Helen Koike
> 
> > 
> > (And then perhaps have a 'gitlab' directory under that. I'm not sure
> > whether - and how much - commonality there might be between the
> > different CI models of different hosts).
> > 
> > Just to clarify: when I say "a logical place", I very much want to
> > emphasize the "a" - maybe there are better places, and I'm not saying
> > that is the only possible place. But it sounds more logical to me than
> > some.
> > 
> >              Linus

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

