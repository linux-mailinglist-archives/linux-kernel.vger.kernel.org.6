Return-Path: <linux-kernel+bounces-180501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4B8C6F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F73284190
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF8250A73;
	Wed, 15 May 2024 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="acNiLnVl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC54F8BC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715817512; cv=none; b=rWWfPHv9YC5a5qnnFgCzD3Vuw03qaSFu+UrNo2cTQ+YtHtT9iFJFcZjD2Oy3F57Iplza3w8Ta937T0qznGszbGwS99qMGBvjdJJNymAS7nUmYLGrGnfxNfzt3qDROEshtYOiEQXT0NfiwQZ2kZoVxHXXUqUkenXOOhrNXWXTQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715817512; c=relaxed/simple;
	bh=Xdhy0ZJdbkzPCdJTvL4nND8bn3uXxmqDr9aA9jDxWjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHUz1ZLDB8Nx8dFeDAZtOuuXeuMIdhAw8zNcKMad6bJKWulT+pUxTn/iUMwMG4ZnkSo/Amu+MWIhMefn2vhCvBnmzoaegyxdXjx5sgbY7aKll/37S4ZAvavvuwMUg2Cyyvg/xXsxgKrCG0Jg45KQ7mcu5ewbG3iV5jGlNyafZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=acNiLnVl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52389c1308dso223177e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715817508; x=1716422308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rQkGsZkxdko+C8Sw0W5RkLIzgexrf1Kb8aIsn7Naypk=;
        b=acNiLnVlvH3AJO0kU5ywItHFmLA5cJL/aRBSLES6fdGcdyjwcsZIbMOXugWOmfkEGe
         xzNPf+NQkzLRh3dd5ztMPTPlwwyoP4BLj8TvXpNFqNsBzjazaCtJYQudRHX98PCm58Yc
         T6PbRN35jzfQE7gdfV97TsMqiltBR1VsdmGD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715817508; x=1716422308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQkGsZkxdko+C8Sw0W5RkLIzgexrf1Kb8aIsn7Naypk=;
        b=mZQ4giuXiy6+RV8N84RQNSnxhMhlCYeTnLO93OK+dvZ7Wh/kHFWswbBBqHbBpoQmNV
         lZDJbuts0Ds49quxZSoG/b/Rt4uYZT591jJpdRzKZT41jQIT0bCz9dQPatoIRhJL78Pk
         bTJFBeh0DcWiVoZKgHEX2lSamQMPBpxQF5Lktw7kDQy5kxKy05hY2FuK6U+1YJ00vSsv
         2ezDX1f1iT5VykfRCGYm8Z/KLuLh9Y065iZ9zIViZ1AfTuWLH/dfPrsQyuJNfYOpMy0E
         foT7SiJHnb9rviEaGz2JpLePgXcYEXKE01lU5u7G91jrmzj2VnI8+jXnbGYm7zrdBlhx
         fMrA==
X-Forwarded-Encrypted: i=1; AJvYcCU1syprieDV4yHShX97pikwPq0ocb4sFif3Q4+noqvrsWlS4C/XpJ9ebiHLUp0NYimxh9GDGVZLZxUT5HGJdxsFMlfQuEDbKHURbbUt
X-Gm-Message-State: AOJu0YxMWxrqa1byWxQoiL9WguPQx0i1vNO+5/qtk5EOJabTgRKpeVJr
	Y+5nJH7lskkaeV8+j/h1TzlMLYgkTp+8CKAPZrW+mFTHl4xr4vAO4BB0cEaZcoJQOdiLgpUOBCI
	+9Mz33Q==
X-Google-Smtp-Source: AGHT+IEagWlXFow6zWyVv3ONpDL03HnM+fQnEQkbFvSwWuL3/g22n/ORanRZO9DshZSkhHdToP1Mzg==
X-Received: by 2002:ac2:5598:0:b0:522:297f:cb06 with SMTP id 2adb3069b0e04-522298f0e12mr8023962e87.32.1715817507690;
        Wed, 15 May 2024 16:58:27 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d8b02sm2715172e87.223.2024.05.15.16.58.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 16:58:27 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52389c1308dso223153e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:58:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiDVML5kRN1uo/bqnoaQXP3qAg4RMIC+XCKm4vDHYuOU158JRlv4MFBJAygPB3wwxKwpxL2VKvKfjeoPriDQe1lzvz6YtW+2VMJI+I
X-Received: by 2002:a05:6512:74f:b0:51e:11d5:bca5 with SMTP id
 2adb3069b0e04-5221016e7ddmr9442194e87.54.1715817506678; Wed, 15 May 2024
 16:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com>
 <CAPM=9tyOtH24Mw_2X+bgV9iChOQV3LtmRCoR5x6KXhSUD6FjUg@mail.gmail.com>
 <CAHk-=wh8DWSMrtuhZOzanfBCFcuJCihO9x7fkzx-dBhLddXF-Q@mail.gmail.com> <CAPM=9twCVkx9OqndCcvjjgx+P7ixBRwttiz25-R=bkycEo5vrQ@mail.gmail.com>
In-Reply-To: <CAPM=9twCVkx9OqndCcvjjgx+P7ixBRwttiz25-R=bkycEo5vrQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 16:58:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuCX-NAGOLzwn5sObPDJX-pdqamZ7YTpHFHODAMv4P+A@mail.gmail.com>
Message-ID: <CAHk-=whuCX-NAGOLzwn5sObPDJX-pdqamZ7YTpHFHODAMv4P+A@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 16:17, Dave Airlie <airlied@gmail.com> wrote:
>
> It's also possible it's just that hey there's a few others in the tree
>
> KVM_WERROR not tied to it
> PPC_WERROR (why does CXL uses this?)

Yeah, that should be fixed too, but at least KVM_WERROR predates the
whole-kernel WERROR.

And PPC_WERROR predates it by over a decade.

But yes, good catch - both of those should be silenced if we already
have the global WERROR enabled.

I mainly notice new questions (because I use "make oldconfig"), so old
pre-existing illogical ones don't trigger my "why are they asking?"
reaction.

> AMDGPU, I915 and XE all have !COMPILE_TEST on their variants

Hmm.  It turns out that I didn't notice the AMDGPU one because my
Threadripper - that has AMDGPU enabled - I have actually turned off
EXPERT on, so it's hidden by that for me.

But yes, both of those should be "depends on !WERROR" too.

Or maybe they should just go away entirely, and be subsumed by the
DRM_WERROR thing.

               Linus

