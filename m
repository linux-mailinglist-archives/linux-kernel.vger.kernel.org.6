Return-Path: <linux-kernel+bounces-537519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C5DA48CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F53716CA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6E227EB0;
	Thu, 27 Feb 2025 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WxBTBzur"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDED276D23
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699801; cv=none; b=WIynTHlBnB6ALg9ae+KJkA2po7bjiTvD9n37Vua3jwqFkFWCnoPqWHtCok1DFgH9Czsh4boPnlMsgDp/3eIVzOLPY60Nfyooo0krG/PN1cQ4qO8EF62n2zPCKH17N27zUOY0dLr36AzT0pOgNoX0B9uc7FTr9u3J89rTn0YHs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699801; c=relaxed/simple;
	bh=XTtVjQ4kq+/ahGTfmaEVrVy1YQKoKT9VRg0oViebMB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+UAbp1SFS/B0eHDogZX1VuJlmgwzgUENNccg77N3AEFxm/wcRUseD/8Lmo1swq3QlF101cJv49tFJV/LDR9NQ5nR/pSNYO/SY/laRxxwKYArjk5IPXlMkBd13FZnmcLszvL/J+yRoRXQUDGIew2OS5Ca3j+7Ce7/xqo9Wruozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WxBTBzur; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fd062e9f91so79326eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740699799; x=1741304599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTtVjQ4kq+/ahGTfmaEVrVy1YQKoKT9VRg0oViebMB0=;
        b=WxBTBzurUQLyNqrD3+VU3kzMoSQwYOcFX7GFcb3r/OIAxTy6RjHcO61bo9/8uvXjFU
         ZBDyEMg+sIwI3rMhrd2nXzUPsSVWubXjSZjx7nV88eYs9NCHR1xWeM6v/n743SDQdHQb
         Nel0+JtxE1zss3rq29Y0bR8EsC05+ZNP/fIKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740699799; x=1741304599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTtVjQ4kq+/ahGTfmaEVrVy1YQKoKT9VRg0oViebMB0=;
        b=c1Wn88waMlN+xZF2NhjEDjEJvS4MJdjwnwetw7MvTpUM8JYx0H/ZYN0AFTk+f91yLq
         KLidJmuwcJogJygUJuO3QBWWGfV2L7iXGkBx/pXA7e/OrK19fm9McnEEsky9ki0sOxap
         d178iTGB+ARCZiOf1qAftDz0oFnk+cv37G+LVYmPLgkVF5Kkt50tReuQWx+cIPxFjW5U
         oo/sJMpY7yzmtMDGuO8Bxzhez+9Czy8tRl5NP3V2LUi2hBHTFyAWoFyt5uJ9+umki7Yg
         ZmA8Lg9JP9TOtym5tIWfMqccGZ5WLPBGrN98sYpu2dfr0m5j8qKGb8RC79GgF8SVhMz6
         GHbw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0r29jL+teK41eMjGBJ2S61EBB55RiAxuNA0ww49+Di4n9GZoXB7jpVU9B7L22RFZlblBQ7jToAKa9CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMhnEQddw9zJOjpx40eC+PRpXvkHUvljXPRLaTGgpkrOkDQkT1
	rsMoDabYGF555sHsUMi647sV9jgg5ibWZQUt5vjPDByiL+z3KNrU8tAB9rG9SmgdleV2xpjdxLp
	1CatfBu9K7TFXlCoKp1vN68i7utbeI85g0S5a
X-Gm-Gg: ASbGnct7e3Vn7oAT0IAe1KZlkSgKJB3kqKOFokc/MddF00LepFvV/CjYB+J2CDiqJ4V
	9TXHzoT8yQMzghc6yn0VQ5w5B6borevYh7gfJBGyXozaK1uy3ILuQStJhx+vZMC6QbJshv90CR2
	GM1X35HPaynJB7CaBiDAmsE/8AxOqGUBJjYJEt7gNm
X-Google-Smtp-Source: AGHT+IFVUyUsYDptOf1uEkSXiVm2KUCfAt5kpvDR++NsMlronN4mKbbFdn4W8gEd5sIJVSXFhEkNggEOqBxyd7D1hps=
X-Received: by 2002:a05:6820:a110:b0:5fc:e9dd:45ed with SMTP id
 006d021491bc7-5feb352ea7bmr204153eaf.1.1740699799150; Thu, 27 Feb 2025
 15:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <30b4de93-70e8-4384-ae56-9f6b6cf0f347@lucifer.local>
 <CABi2SkXkfFAMhmXP1CKHCZMxdKWcHx8T9_0-nwBPWycTbxOctQ@mail.gmail.com> <afbaee91-3bea-4127-9dc1-7b43b0090229@lucifer.local>
In-Reply-To: <afbaee91-3bea-4127-9dc1-7b43b0090229@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 15:43:07 -0800
X-Gm-Features: AQ5f1Jo_gJY3RsgJ5xmWVYLTo90Mu9L8ltsde4Nhv3yL6k10ypx9JSGFT-uMpC4
Message-ID: <CABi2SkVcbuxm5j7xekSuyV=9goKxAPcDE_7OEz2JLds1+K0j0Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mseal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:01=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Feb 25, 2025 at 04:17:01PM -0800, Jeff Xu wrote:
> > On Tue, Feb 25, 2025 at 2:32=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > BTW can we please drop the 'mseal, system mappings' prefixes on this
> > > series, it's really weird and makes it really hard for me to actually=
 read
> > > the individual summary lines for each commit. 'mseal:' will do.
> > >
> >
> > I am not sure.
> > I had comments about adding mseal, system mappings, as prefixes, and I
> > think it is reasonable.
>
> No it's really horrible (sorry I know it's hyperbolic but it really reall=
y looks
> horrid to me) , I've never seen prefixes like that before in mm in my lif=
e and I
> don't think it adds anything.
>
> I also find it MIGHTY confusing.
>
> Please remove this :) you can git log the relevant files to see the conve=
ntions
> people use. Typically xxx: has something really short and sweet for the '=
xxx'.
>
> I realise this is subjective, but it's a small thing and would be helpful=
 for
> parsing your series at a glance.
>
I need a prefix to group the patches, especially when the first patch
is just a config change. "mseal" won't work because this patch isn't
about core business logic of mseal.

How about "mseal sysmap:"?

-Jeff

