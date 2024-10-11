Return-Path: <linux-kernel+bounces-360300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED5999865
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7581A1F23A85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94214A28;
	Fri, 11 Oct 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nu3bPKf5"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BFE747F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728607995; cv=none; b=f0bDq6PjOHN/XcxT0Sw8pAOUKPnUNqhb8t/UMCq862ScBaVad5VIAi3JOJIhYA3FRBREXr5V4dqgt9PjUMtCq3Yg+Br4pU2B4HDE7HluQZkMiWZLXQpjD7NHxEkjl3w2ZBbHgHfaaYEKEFLIXVVxDjl5/d9YgDID66XfK/Vq2bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728607995; c=relaxed/simple;
	bh=RkgmBIiT1HWUDu8EampwxpUfpAUQADvPp4FqgX8+rZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UsDB4TXRO86ksq8wcdlTA26WYNyVMdaNTU5k493HEpRolAMeWoyM1tWqnuwKzaFjsaYDAxKWieYME34cXQUivlIaWJUV0fYihSCXdjoV2Yd5ozVNg2hi4nPbCmvgxlqBrrEos1906LHf1SYz6+okQHQkyKKzDrrxsySAyNVW+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nu3bPKf5; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2883d7f6c36so46513fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728607991; x=1729212791; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLwtLwPuWAh2naPHwodMzmTHRgXKo38Ia3bfbc295cY=;
        b=Nu3bPKf5DTLAJykYazKBytXY4iBzCiDRT4FO5qSJm8KOzu6TfSjinGhrNs+XTiKmuZ
         ZMqyK2mPAgN6S0R0FwqNtlKLNpjuttSfP0AZesmVXbnHoFhEv3RGzgzS/SU01hd5+yVb
         flf4jnL600ZC/2kWvPdmV8SlitedDz1MTfsyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728607991; x=1729212791;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLwtLwPuWAh2naPHwodMzmTHRgXKo38Ia3bfbc295cY=;
        b=HBwaMPHUjBz1eqIUmq+lZjKdrwBWmHRypjkU1PRFyFFkXirjoqbfLS6NeF8ajlne9C
         N3JzDr1HTnEekiAbghL5c/nYESu4nie8aIpQSvayezrA3vsgZk37NOylADzpX2bdD2Xz
         TA3TEY/QyjaBzVMqtZdkxyQbtjFJmb8xhPxNLtPPLcBkrrWyRqHTIRFS2zWwSPQhEwzs
         g9wwvPfVXLRFG6TGYmpkLvcaq7NSGK1B2Jjp1X9fFcrY0aTOyR5eW+tbFomdL2LNrpH7
         3dAoBJQjvNapSWe2W7zt3Q5LHj0AsUHvO/6XRccMNMGBwXCzR7a1g4nHg1OxqG4IPSeJ
         X0UA==
X-Forwarded-Encrypted: i=1; AJvYcCWjXYdN4kCQ70xSHo1pZnFaR+/Lyc8p703xNkMSf7lqKUI9BZY1ZlBrZxCJnziFaY36dUCj7ZiwRr4W9Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymjiUpO4snl0zm+e9EUWJUcpX53UX19c/d2d0xLTyXLLITwjou
	BKJf0VOF1h+K55x/PlWwNUmMaywR/7E7dRLx1F4T3gwiFPg5HCefpYZEy5FK2TRPEabxg3vsoew
	+HGApCyKjoG6Mini+pv2OhL7F4+gzHlAYmSFo
X-Google-Smtp-Source: AGHT+IEwQwEkKiBKgeuxW+aagIyAxDVRfVgQJV6rvFsVR533kn+LASZBvPvFX5vGVB5b/t6IcNwX52l/azlKAJArvRQ=
X-Received: by 2002:a05:6870:171a:b0:278:2698:7721 with SMTP id
 586e51a60fabf-2886debba73mr180660fac.8.1728607991573; Thu, 10 Oct 2024
 17:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004163155.3493183-1-jeffxu@google.com> <v32x3rszfq7twguleqpj3xejsh6gtupput4dgfmvv357lxznqs@dy6fzjuhrs3v>
 <CABi2SkVfPjfbAMVEK8KFzS4RsZefCo8LAW9r7BkiSweUxVeJpQ@mail.gmail.com> <xaklq4r2afsqqbdamowzjyzxztlkctg4kg7xuqnyi5fuc3vanx@hwchttyq2kdq>
In-Reply-To: <xaklq4r2afsqqbdamowzjyzxztlkctg4kg7xuqnyi5fuc3vanx@hwchttyq2kdq>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 10 Oct 2024 17:52:59 -0700
Message-ID: <CABi2SkWXT-A9Js=zskx57WAVzsF9yDutRX7TAror8H4OW++Ogw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/1] seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, mike.kravetz@oracle.com, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, nathan_lynch@mentor.com, dsafonov@virtuozzo.com, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com, Jeff Xu <jeffxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:42=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [241008 11:01]:
> > Hi Liam,
> >
> > On Mon, Oct 7, 2024 at 7:19=E2=80=AFPM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > * jeffxu@chromium.org <jeffxu@chromium.org> [241004 12:32]:
> > > > From: Jeff Xu <jeffxu@google.com>
> > > >
> > > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > > >
> > > > Those mappings are readonly or executable only, sealing can protect
> > > > them from ever changing during the life time of the process.
> > > >
> > > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > > generated by the kernel during program initialization. These mappin=
gs
> > > > are designated as non-writable, and sealing them will prevent them
> > > > from ever becoming writeable.
> > >
> > > But it also means they cannot be unmapped, right?
> > >
> > > I'm not saying it's a thing people should, but recent conversations
> > > with the ppc people seem to indicate that people do 'things' to the v=
dso
> > > such as removing it.
> > >
> > > Won't this change mean they cannot do that, at least if mseal is enab=
led
> > > on ppc64?  In which case we would have a different special mapping fo=
r
> > > powerpc, or any other platform that wants to be able to unmap the vds=
o
> > > (or vvar or whatever else?)
> > >
> > > In fact, I came across people removing the vdso to catch callers to
> > > those functions which they didn't want to allow.  In this case enabli=
ng
> > > the security of mseal would not allow them to stop applications from
> > > vdso calls.  Again, I'm not saying this is a good (or bad) idea but i=
t
> > > happening.
> > >
> > > >
> > > > Unlike the aforementioned mappings, the uprobe mapping is not
> > > > established during program startup. However, its lifetime is the sa=
me
> > > > as the process's lifetime [1], thus sealable.
> > > >
> > > > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > > > _install_special_mapping() function. As no other mappings utilize t=
his
> > > > function, it is logical to incorporate sealing logic within
> > > > _install_special_mapping(). This approach avoids the necessity of
> > > > modifying code across various architecture-specific implementations=
.
> > > >
> > > > The vsyscall mapping, which has its own initialization function, is
> > > > sealed in the XONLY case, it seems to be the most common and secure
> > > > case of using vsyscall.
> > > >
> > > > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) =
may
> > > > alter the mapping of vdso, vvar, and sigpage during restore
> > > > operations. Consequently, this feature cannot be universally enable=
d
> > > > across all systems. To address this, a kernel configuration option =
has
> > > > been introduced to enable or disable this functionality. I tested
> > > > CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS, which doesn=E2=80=
=99t use
> > > > CHECKPOINT_RESTORE, to verify the sealing works.
> > >
> > > I am hesitant to say that CRIU is the only user of moving the vdso, a=
s
> > > the ppc people wanted the ability for the fallback methods to still
> > > function when the vdso was unmapped.
> > >
> > > I am not sure we can change the user expected behaviour based on a
> > > configuration option; users may be able to mmap/munmap but may not be
> > > able to boot their own kernel, but maybe it's okay?
> > >
> > The text doesn't say CRIU is the **only** feature that is not
> > compatible with this.
>
> Fair enough.
>
> I read it that way since you pointed out breaking criu is the reason for
> not enabling this by default, although it's probably the biggest reason
> against doing this.
>
> >
> > The default config is "CONFIG_SEAL_SYSTEM_MAPPINGS_NEVER", and
> > distribution needs to opt-in for this feature, such as ChromeOS or
> > Android or other safe-by-default systems that doesn't allow to unmap
> > or remap vdso in production build.
>
> Okay, but you never stated that they can't be unmapped or remapped in
> this change; just that they will never become writeable.  It is worth
> adding that detail in the description since it isn't entirely obvious
> unless you know the workings of mseal.
>
Thanks, I will improve this section by adding more details on memory
sealing or maybe point to the mseal.rst document.

> >
> > Thanks
> > -Jeff
> >
> >
> > > >
> > > > [1] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM=
4XkRkL-NrCZxYAyg@mail.gmail.com/
> > > >
> > > > Jeff Xu (1):
> > > >   exec: seal system mappings
> > > >
> > > >  .../admin-guide/kernel-parameters.txt         |  9 ++++
> > > >  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
> > > >  fs/exec.c                                     | 53 +++++++++++++++=
++++
> > > >  include/linux/fs.h                            |  1 +
> > > >  mm/mmap.c                                     |  1 +
> > > >  security/Kconfig                              | 26 +++++++++
> > > >  6 files changed, 97 insertions(+), 2 deletions(-)
> > > >
> > > > --
> > > > 2.47.0.rc0.187.ge670bccf7e-goog
> > > >

