Return-Path: <linux-kernel+bounces-273988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC13947066
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 22:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A840281164
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 20:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168B28174E;
	Sun,  4 Aug 2024 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WxsCRjf4"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D910A2A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722803585; cv=none; b=F9SZcvdo1hjHSgLdO/NrDl5PrdJ4Md+Aq4ixv8Sck15aS9ONQ//vgUevF/PpM0yzCqx16x49KYtvTMB+VzHlZNDZ5+c6YxJOo/jsMeAq5kN8vE0nxrWCwGMMDFy0dEVQNV19GfUG6fRZx8MSyjFG0jtnF8fU7lB9JCDyV/EnWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722803585; c=relaxed/simple;
	bh=AZliAsMy1KQ0MTCOfVVvKYar8vTnwBzGjMoUW1Wh39k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHhy7wGITvmFYhhs8263PtvRsTAqaC4VAMRyKuc8M8s2gVm1yGmknK0lbT2/RILbrZZYDQEz0sVqXExopE0Wx8gWGJzHhWUPCp+sVKmGtkR+niX6yHXcmsHO+mzIIucHkklMLBg7BzLUucYOWsfQkWZXZhQC5wOQVcV+UKNLTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WxsCRjf4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so8520989a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 13:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722803581; x=1723408381; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LJPoUhGsSbI3MesTWfLPEQy046rL3cbhs+jom/8YIqc=;
        b=WxsCRjf4bRIkOyDOpbnem1k5VncSmonFv/+u8tOch96tjTBK5gQf2NPAFCP/8zN/T1
         BouFCI5cLpP6DN2QzRr+qBAJ0ivNMFaPGSWphlLZkaT+PFUlPRMIjvHZ5KIa5TatLXk2
         3KgGnAP9plpTK+kAHljoQheXxjXD5zAynd3G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722803581; x=1723408381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJPoUhGsSbI3MesTWfLPEQy046rL3cbhs+jom/8YIqc=;
        b=q4HLiuQvGGhocb8U14Co6YMSDW2z8zaic14r8eH2esXAJSCYcmm9EDrOKIi0YN7ghg
         h7teSQ8ZqDo5kQuN5rWiCMO1NgOPy/XinMZC2HLgaoarRwytA7u/riVqI7k7zQBAmjZ9
         i/rLyvkX1zcMrpc6z+wYREQMDCRwgkim00YBCIne//Ern1a/GZAh6674l1zyjp0saGRx
         B1Bt1qFleoetwS4S3ojiRmgMEiBdHWCSIDJO86kKHvNDHuJm+G4bRuAvcS/BumfVd2LA
         ZtAfz7ah+/OasP9rO+KRcg23wXMpX+bZM5l6Q4C/IIP/s502rJG2Z3xdsllWWu5gMv2q
         Vfsg==
X-Forwarded-Encrypted: i=1; AJvYcCUr8I9llXQSvBIEJt8ZkojUmtGMDq9ZiP2R5+epjqiNw4DoZprJ0owpNB+Ni2AAzrznJwn0IPNWQ1hBIcFAJHis+huCXqOBvVZybBsS
X-Gm-Message-State: AOJu0YwPthgOJDIkYCjQvliP38nSR0jss6WDCJ7WZOYf00cc0AWevB52
	MIp1zcX6R4/cGFuMBUON9+TTVBfVm8dbE3lLKXoyEhqo5cDr9pHzPh0M+G7ZDqPPiIWcENz2jMr
	6mUdxgg==
X-Google-Smtp-Source: AGHT+IGN0yPKQCCJ7g1M/HnZb6lucoCDj6CIrUorGwXZUPE3ofYIx0a95Tc4pwwtsf5ufrv6mZSz3g==
X-Received: by 2002:a17:907:94d4:b0:a7a:ab1a:2d79 with SMTP id a640c23a62f3a-a7dc6287000mr957613066b.29.1722803580929;
        Sun, 04 Aug 2024 13:33:00 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8deasm364973066b.208.2024.08.04.13.33.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 13:33:00 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so8520972a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 13:33:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZFBi1q/GlD4lYWqDtIeYeeLX7TieahJUOMxJDfa1GRNaxelvRiVeQWsgg/7mswLRjHotZnEBMISEijHyFAwSd0knKvw2ZB6bNS+GW
X-Received: by 2002:a17:907:608c:b0:a7a:1c7b:dc17 with SMTP id
 a640c23a62f3a-a7dbe63440dmr975332366b.22.1722803580241; Sun, 04 Aug 2024
 13:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com>
In-Reply-To: <202408041602.caa0372-oliver.sang@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Aug 2024 13:32:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
Message-ID: <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 01:59, kernel test robot <oliver.sang@intel.com> wrote:
>
> kernel test robot noticed a -4.4% regression of stress-ng.pagemove.page_remaps_per_sec on
> commit 8be7258aad44 ("mseal: add mseal syscall")

Ok, it's basically just the vma walk in can_modify_mm():

>       1.06            +0.1        1.18        perf-profile.self.cycles-pp.mas_next_slot
>       1.50            +0.5        1.97        perf-profile.self.cycles-pp.mas_find
>       0.00            +1.4        1.35        perf-profile.self.cycles-pp.can_modify_mm
>       3.13            +2.0        5.13        perf-profile.self.cycles-pp.mas_walk

and looks like it's two different pathways. We have __do_sys_mremap ->
mremap_to -> do_munmap -> do_vmi_munmap -> can_modify_mm for the
destination mapping, but we also have mremap_to() calling
can_modify_mm() directly for the source mapping.

And then do_vmi_munmap() will do it's *own* vma_find() after having
done arch_unmap().

And do_munmap() will obviously do its own vma lookup as part of
calling vma_to_resize().

So it looks like a large portion of this regression is because the
mseal addition just ends up walking the vma list way too much.

              Linus

