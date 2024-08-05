Return-Path: <linux-kernel+bounces-275269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B65948294
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383F92835FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104816BE1D;
	Mon,  5 Aug 2024 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eQ5DPgcZ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8F16A397
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887305; cv=none; b=GOeO2yiWwQfYa9EfcANqCb4+xrRp0ezdBF28fZXyIahleURQFhsnZhfTHYxPekSjZ2wwGldrD8iI8a50OPpigaPZRTav1XLv6BVgI2vhIDgSAQRol9mAwJTV3Pvy2xSskGg9Q0zNP0f9tfq+rtur3ms34/ulpqnVCbEZa/Iym98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887305; c=relaxed/simple;
	bh=mgZkO49kXrbYPJTqfPbU/zGoDP6KaGhqgEz+BOKxzbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaVIx5+VCPeVQ5b/SiY1ZTKdgh5n2zpdJJjYQ4nle5d/rZqLKoa2+BjNZXDvjdd2aWicaHCM82CZ7jjio5CTdSi18mPtzkX+HQEtnm+Uri27qgZk+UFegc1XplM3vj65uBi5tkPx/8ZGFfYuVX3ujKQcD5WGv8leR4u7nrn233o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eQ5DPgcZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so1344028266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722887301; x=1723492101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wlI56xvrJ7x2cg4LdNK/30BBgdmdk2xf+663DeBt1mg=;
        b=eQ5DPgcZhUKABCv0ZH3XhZcG1qgJC/Xvq1psSOISkehVLv62xCdWdZ/vFvUTDI+Yed
         mt9e1jZTmgjm4k57o2JY1E5V2rFQlBvgV7JvbDeYo0y9Z10RBdOLeXtKt2hR5W9qMkA8
         +B2BVZ9E833akp04bSZ6lDYSJJlg4onxlFHos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887301; x=1723492101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlI56xvrJ7x2cg4LdNK/30BBgdmdk2xf+663DeBt1mg=;
        b=vxCoY87p7QLpgFefbQ7VDX5XCvXf/k08a3ufWujgaYsIgSMZtuhkPMlLbV2MSKVs1v
         5Ii0UP0IVN2JepBNbBxWajGcCRA48tqiEZtjbIxgWYknWo8Wgt2ANlT4EaxNuV8svXHS
         cbiggT11ln4xSt5qbft/SVu3S4H9yQsVO4f12IJtOF1RqGfG8P0hi/DfiOyb1li7kwQG
         U9Toy2I1TJ75opB6acLSlzMJXuvmv2FFUqTDAd7h88UFPpMqs60GRwiFnlUupLioQCel
         6EujtLW5qb/Bspuh8pap+8ECl0gXsMolVxbdqTJUEjZT9iAU+TQhFaAQmTVl9+An4gys
         bY0g==
X-Forwarded-Encrypted: i=1; AJvYcCW84JZOxgwadHmJF77BsLkx/octe794Gb06I8mb+3SqQXvG7Rz9t7h+W+Rx1zLW1prQ3esYfNjfZ4uXI8BPngFNgniYZmzyx9SYlCNX
X-Gm-Message-State: AOJu0YyQGYpah65U8J7JoxXOa49m4F1kEaAlGjRibomeZcwfwYlfes1O
	H7R9AaNaX3jUHVt/I23fxLKqI5iM7V3hceuei8uqK4qVRbtQLlo/oVCX6DMjp0QNCqmnzogawCZ
	TowOWxg==
X-Google-Smtp-Source: AGHT+IHILkw3fBeKwzRbvwkScuitBbAprKJASOykQun9zdM1MjJ4DSnAPxUn99zhOJfyCy0ztY041Q==
X-Received: by 2002:a17:906:ee85:b0:a7d:2f42:db54 with SMTP id a640c23a62f3a-a7dc50ff238mr931759666b.65.1722887301535;
        Mon, 05 Aug 2024 12:48:21 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d42615sm482734166b.99.2024.08.05.12.48.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 12:48:20 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso11493340a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:48:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDUyCvHmcSBvZS+FpO8tEHyJiMLEbL4CiLpJmTsqif6NJurEEK5lxYVN3bjobzDmb8hXE3MyO/ZwkhoxKTBpIJRHv+iCtjP2axFAQY
X-Received: by 2002:a17:907:3f8b:b0:a7a:9954:1fc1 with SMTP id
 a640c23a62f3a-a7dc4ea981cmr878526366b.24.1722887300410; Mon, 05 Aug 2024
 12:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com> <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
In-Reply-To: <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 12:48:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
Message-ID: <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Jeff Xu <jeffxu@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
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

On Mon, 5 Aug 2024 at 12:38, Jeff Xu <jeffxu@google.com> wrote:
>
> I'm curious, why does ppc need to unmap vdso ? ( other archs don't
> have unmap logic.)

I have no idea. There are comments about 'perf' getting confused about
mmap counts when 'context.vdso' isn't set up.

But x86 has the same context.vdso logic, and does *not* set the
pointer before installing the vma, for example. Also does not zero it
out on munmap(), although it does have the mremap logic.

For all I know it may all be entirely unnecessary, and could be
removed entirely.

          Linus

