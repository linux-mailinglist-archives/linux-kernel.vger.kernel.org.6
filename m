Return-Path: <linux-kernel+bounces-276411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78DC94934C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B181C2189A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B61D2F7A;
	Tue,  6 Aug 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="duMNRmdi"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78C1BE23E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955112; cv=none; b=pkk7c8R6MrExlFedb81amc3Xsdifa4QSIvJlqZB+qMZolHMB4DKiIobenAo/XNvHsA81ZWYlUFkIuBBRTdisMzrdv0UUR1ttiEiCamPoFhCAPo4sTvfk14sZ7Hl8sTjK9eAtIWNzFzgCx8KBrOJlBMVh96oha9/lwXi6MhD3uPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955112; c=relaxed/simple;
	bh=2fP83v8ZDZ7pc5agamWj3NzXnt1SQztcQNzK097z7/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B208qggrDcEbIWvBGzRfMvI/c1kmQBW3pmDzp5GV7XxzsMp2VhdzxseKn9Ef/ZJcyRW/UtNsnXgRh8NEazRmjzoeB6aTNuNslplJF9XKM/DmcSuG3cxBhQlHLgQfDtFbmgXTTs8JfmetT4qXGlbJ2w6Nnlg/uz8MY4k8SaUAmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=duMNRmdi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so1117742a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722955109; x=1723559909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MWWrNlqBqyxE+pa3MBe3r8meejGqG07YEY2OhAnz4Do=;
        b=duMNRmdiQMn9X7dFKN11RMOaC6OrcSgq1bllh7cjAEpvqaJG2Tz2OMGBRlUC/P/2Qw
         u8MWWAnfy/x3C6gQCPf4imqyLhwqxPGnFXGhEgYfU+PXhVXGpW+GeBLSEwJZNxdfwhsl
         TDl6VArfOOA0n3LPg9y7+/foRj01TRaaaqgro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955109; x=1723559909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWWrNlqBqyxE+pa3MBe3r8meejGqG07YEY2OhAnz4Do=;
        b=RCqr12N8ZMRnNWTeL/Kn2t0ptxHutZDdlgVj3IviHY+T3UVGQRazFQrRq+xnwVdX7b
         6NEC1u30LksHfcjUkh2fxCY9jz2+MWfoPYSZl+KmSewHDulZttfl7quk6lf4UJyuN1bh
         5QMrUOBnjgNQnN/hogQvKEAbZz5XnLbv8UtoCWP6bZGrlMKwll1Gh0Dl+aKHLUxq7Lcw
         +h2YnjQD5b2zRiT8I72w1ASp/rbWMPVYcLWkHEmhHAIrEU5jhexPAJbIhHkFAN+NxnuW
         SEuGH9e4m800dBdt4kSFBLibFc1ZQFD/H/v2pHPcfzRM+YiZsAlbupYKQ0OOM9KkSD6H
         0HEg==
X-Forwarded-Encrypted: i=1; AJvYcCXXFPNlEYtS1AePJDMsxjMpEupDRnsoK1d1Vds9BXl+W84b3jH8MNghaYDgZogpg1jQI1MjhcZCOYJvItAcxU+RHMNXVjxvo6DBJ+KU
X-Gm-Message-State: AOJu0Yx2ZXvEPYfbdf2NzrQIYcjJ/uY70k7n6e6Dn6fqceJXNdq4uR1d
	I4fBoli/zeAhWsz/Jt12xHJqnHvxZlDhfSfwVi3Q2yS1m8ELngdrfYryW87r+wlNr8DR4FsHVk8
	7WJUCGw==
X-Google-Smtp-Source: AGHT+IEu/vUBUT4EXGvAfF+V852TO8vPBUGRCMbyWYeQZJ6LSEKi2+JjMX825jFfx9MHKg39OiaNUA==
X-Received: by 2002:a17:907:1c2a:b0:a7a:a138:dbd2 with SMTP id a640c23a62f3a-a7dc509f3bcmr978999866b.50.1722955108725;
        Tue, 06 Aug 2024 07:38:28 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec6b07sm546640766b.202.2024.08.06.07.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:38:27 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so1117657a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:38:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDTGZkgYK4BX+jWAVPD5qPzDl9mHH7tYQK600Oy7fcs0WPaLIJyA1n11HEsexT440JuOsUk9g4oYBXJoiefKZgXP8SSt8PcjBjdgOx
X-Received: by 2002:a05:6402:22b2:b0:5b8:1035:214 with SMTP id
 4fb4d7f45d1cf-5b810350411mr8834214a12.33.1722955106581; Tue, 06 Aug 2024
 07:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com> <ZrG8+/1YjxN/Hsb7@xsang-OptiPlex-9020>
In-Reply-To: <ZrG8+/1YjxN/Hsb7@xsang-OptiPlex-9020>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 07:38:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+rSKmNvFBpaKW+Hcn8YSzd2az2Lp5ii7Q4_o0PepJ_A@mail.gmail.com>
Message-ID: <CAHk-=wi+rSKmNvFBpaKW+Hcn8YSzd2az2Lp5ii7Q4_o0PepJ_A@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: Jeff Xu <jeffxu@google.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 23:05, Oliver Sang <oliver.sang@intel.com> wrote:
>
> > New version - still untested, but now I've read through it one more
> > time - attached.
>
> we tested this version by applying it directly upon 8be7258aad,  but seems it
> have little impact to performance. still similar regression if comparing to
> ff388fe5c4.

Note that that patch (and Michael's fixes for ppc on top) in itself
doesn't fix any performance issue.

But getting rid of arch_unmap() means that now the can_modify_mm() in
do_vmi_munmap() is right above the "vma_find()" (and can in fact be
moved below it and into do_vmi_align_munmap), and that means that at
least the unmap paths don't need the vma lookup of can_modify_mm() at
all, because they've done their own.

IOW, the "arch_unmap()" removal was purely preparatory and did nothing
on its own, it's only preparatory to get rid of some of the
can_modify_mm() costs.

The call to can_modify_mm() in mremap_to() is a bit harder to get rid
of. Unless we just say "mremap will unmap the destination even if the
mremap source is sealed".

            Linus

