Return-Path: <linux-kernel+bounces-199464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8A8D877C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236231F214A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955FE1369A8;
	Mon,  3 Jun 2024 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAZy8YUU"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588F136995
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433674; cv=none; b=XO1P38TnyefW6SG6g9+FPCpyjtyIfcnIXUvAXENeT/vmwFTOytKjBfLRZHcHSgSCwTb9kaW5YoPMCv9ArV8LqAjc7sPLdcLGn79Wd7xXW3PTThch/XGApoxM9EaKv3NTE4cUIwAyn4S+uw9Sn61VYiBIc22ldtgr5zuccyj5Pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433674; c=relaxed/simple;
	bh=9uaWDRDuJpCiADdyudSPKqt6qyaBHx3becUI8L3KqVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwwVWo5fy11lBJZHu2482/uBm80aFqiX8glepMJv4Vn1dNmVmqKl8yYeDW8trth8wFSqZPub5e116qTfOuTOKwGzru0lY9EmdHwQ0V39ogsxboyxCZRQ3kIZPlso2Dy2W1ybCOz/ygoj/dz9fFR9mPqGjXmu+Roysjgr6+mycpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAZy8YUU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a68c8b90c85so242771166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717433672; x=1718038472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uaWDRDuJpCiADdyudSPKqt6qyaBHx3becUI8L3KqVQ=;
        b=kAZy8YUUmizHEcFgLO13dqe8xANE1W3udTSJXjIvUOgibXfm2163/2tnsToD8LuDBj
         KJM3J5anV18cbz5GUjitxUWWCYK6FfFw6FB1rZkftbrucUtPTcrSu6UJysv7iznssFgg
         57/3k3ZxkzJQ8MtmY++E0Nf7jiu3rJSrY3AkW8gGh5YctMyvY6xVWct6tV6gU37MFrAD
         OqdLfzQXhp2VNe4MLPEd5noBA0AKn8fO2CojbMrMoIZElOjck6ItaVLJHXYP1PyqYZC+
         DWiU3bzt3+Q1o92xX0LB64IfYDuVFVaiGZT8A1WftNAYMWm7h6TiGyuzyZoH4576pGGB
         vwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717433672; x=1718038472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uaWDRDuJpCiADdyudSPKqt6qyaBHx3becUI8L3KqVQ=;
        b=Xqljc9BnhP3UTvexuVMTvzifFpZ18YODzQgL52PgCTZHVhVWhHcoEAUm9kL+K6ffqJ
         WtZl5FqYTrtvQPbo8SdCf3U7RqxNxFDPiVrdx3iuosxHM2KWJZOcjL5018TJmO6LL1qA
         sZYVHe/iFP3+LvKXNZSjITs5Qx6nRlLwrGqjeIm+aEXqAFymNSWhDoiF/3Y0Bg5b0oZO
         oUBLB6VCadNL9IO5wbHwW5j+WN2YYZNm5SzBl3oNsLb+1x+WD9Qsn5tX3dZffQMpm0Ls
         GeFbjfF1Vu+dszHaWQ0J+oiaqlUltGJLg4pC3d0JAYcLITNiWthHXtHNZyQf1TkwnUtI
         v79w==
X-Forwarded-Encrypted: i=1; AJvYcCX/nIlBXGUhp/xt5MSo7uJQfUeLpPXYEBYpAd2JIz2c6CSK5dw49vNY1ngxgKDTIE6Uhm5XPyyArmrFtSkdZmpwHcOGK2k2ScRpFBqo
X-Gm-Message-State: AOJu0YwNWyUs1nPtziu36GJ3zJ8I2EMHLFLqRBTEmTVxP4NH2jjPndC8
	4hkJCs9U9UBH6HEQ0cFh7emiVaQHXeX9PhqyoPjiXBx/5SbdkeljeLrDFyvTjwUzurTAciSWPip
	oxdHYFJ+u2X+Fd6CyO+JqKJPzX+E=
X-Google-Smtp-Source: AGHT+IEDqulxph1OA4imszzJwE86zTngn5eZ0gB/XB0ChXYnaAOsSniC1qdfyLOF1SBhF9erk2zgSPNTxtULf9lX7R8=
X-Received: by 2002:a17:906:d153:b0:a68:e7f3:7ed6 with SMTP id
 a640c23a62f3a-a68e7f38368mr358544466b.21.1717433671524; Mon, 03 Jun 2024
 09:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405311534.86cd4043-lkp@intel.com> <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com> <CAHbLzkqphyX473LBCXXf8rWEr-8m2PB--CT0cwCax3mUyZPGhA@mail.gmail.com>
 <CAHbLzkqG=9VmAcOgFr-50ZdZtf7xj2PqpfD3UHUsMX3jR=+snw@mail.gmail.com>
 <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com> <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
 <a088b5cf-503e-4ed7-b427-f17a9ec5d1a8@redhat.com> <CAHbLzkpnDPYWq=HnaJcKhKnppdNikX4YG+1Ysu8Z+XJCoKK4SQ@mail.gmail.com>
 <CAHbLzkr5K=4Shiyb5KgPTQ20jE2Zo08wK=mT3Ez9ADEdJe0Z9A@mail.gmail.com> <Zl3M7iniPQaPFDrW@xsang-OptiPlex-9020>
In-Reply-To: <Zl3M7iniPQaPFDrW@xsang-OptiPlex-9020>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 3 Jun 2024 09:54:19 -0700
Message-ID: <CAHbLzkrOTAaYahG4JYMNrJDhQNZZxW9u+2n71J=v1XYJEVpUdw@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: Oliver Sang <oliver.sang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 7:02=E2=80=AFAM Oliver Sang <oliver.sang@intel.com> =
wrote:
>
> hi, Yang Shi,
>
> On Fri, May 31, 2024 at 01:57:06PM -0700, Yang Shi wrote:
> > Hi Oliver,
> >
> > I just came up with a quick patch (just build test) per the discussion
> > and attached, can you please to give it a try? Once it is verified, I
> > will refine the patch and submit for review.
>
> what's the base of this patch? I tried to apply it upon efa7df3e3b or
> v6.10-rc2. both failed.

Its base is mm-unstable. The head commit is 8e06d6b9274d ("mm: add
swappiness=3D arg to memory.reclaim"). Sorry for the confusion, I should
have mentioned this.

>
> >
> > Thanks,
> > Yang
> >
> > >
> > > >
> > > >
> > > > --
> > > > Cheers,
> > > >
> > > > David / dhildenb
> > > >
>
>

