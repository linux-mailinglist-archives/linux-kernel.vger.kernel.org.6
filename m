Return-Path: <linux-kernel+bounces-275505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C06948699
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46336283496
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC23A947;
	Tue,  6 Aug 2024 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UPr2cHTV"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F408F62
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722903691; cv=none; b=rFYNquo8Uyz7O3CnapOrSOeP/dw6h3ZBvth+C0GnEqrNzYr4BqAUxX6+DttT185MYNAlMuBqeT2AFXsj8uOssLm3FCn/oESuONmtuUQ/nfkGu3JnY/WKor/eC2jpDLujp24ZU2zvhLeX0RZGqMKu8fFH2r2EeIctDv5qAoT6ku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722903691; c=relaxed/simple;
	bh=KhE7wem6k7+mMBHOIKFkuNlqunhQlQKQ2o5ffgZbY9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXW5LXPCDC17PU3ak5AX3/PkufZlcztkNd7+pOOHk0vaKcgTE9Cuj8fyv9hTBanc2MxTLj+zOc7x/TDpMBsnqziFopYbkioMMNs1oIqymJpSAo3Sj4lGtDhkjPdsSsHG/vSAB4JvFCzmT30u1ckiLrbEVlU4QmScpl3ePD0uUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UPr2cHTV; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so1698321fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722903687; x=1723508487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s/w/R50dzf1u4Y5vhvcxV6m9BvUcW7XkQaFxdwQ7Gmk=;
        b=UPr2cHTVto186VqlLyQ4Ezw9BZS6LVzaopdCdraNM8rsyWmdj61TM1O7Kvm2DIzCWl
         VZeQ+t6oM956EbylKVFoJWHYkGlg883UJS+/eSoqUZ7y+lzTW578FLg8JMMwLgirIxoU
         arzCtTQbnM5pfSc68+jlST+K4b0JOHB37FhJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722903687; x=1723508487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/w/R50dzf1u4Y5vhvcxV6m9BvUcW7XkQaFxdwQ7Gmk=;
        b=OBUVDw7iNwwLxc0wFbxUJWwv9GAVCs/kBXh3Wi3Jdx+MV3SaWbOa2bjpMfoC0krhSg
         P2RG4XZArsOnS7MkXWH0eLp9i/frxh9/yolObfxEPECpx9AWDKLPjvBNthKhLPD9itxY
         jOCqJ2gQ6gMKkmef5siz7eFZGiQYXrNFeyP9mLKSC4xWvPng2SKVNsU+oyqCg3gdcpNW
         H71RpaCkBeyzEgOC/M4tU9AV+jbyoCRsHEIfXzto8tFb2lkp0mpCNBepgipnO+0fsKYp
         PPBnVjCm3CtrI51cc9RTexKiG+GZgcgB9+AUQGZuNY5DGgGO4ILVzKh894Z0rC9E3X2t
         xzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1bG2Lh30FXnjmlonAtyOSEbdzUAvVB4n2HqddJtwH/vHE3+tDJUn4y5cKbXUOBDX62m4dBAH7G0n3A06UM9IqeZb2oHsVD9SNz/fe
X-Gm-Message-State: AOJu0YyB4a2ETMFuC7IM6lChigu0/Amfk9yb1NG51bCi1bztoKmXJtS+
	JOnZnVcv7P8yCa1FDoCi9DnTCJP2c6HM4JGmoWgS0oixQ71Q+BN8vZ/mRZkvpjnZs7Ni5n+4S4E
	kCObvjw==
X-Google-Smtp-Source: AGHT+IERNddCBQp1ghgQBPI4w2+fixMjfYaFBbw9Rd3RJeY/8Tu74fLgQyeQd9bTrSLDt+aUwjnZvA==
X-Received: by 2002:a2e:a415:0:b0:2ef:22a5:9472 with SMTP id 38308e7fff4ca-2f15ab23829mr91486831fa.38.1722903686795;
        Mon, 05 Aug 2024 17:21:26 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1c20basm12763661fa.56.2024.08.05.17.21.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 17:21:26 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efa16aad9so132086e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:21:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVW8DDvKmb6TAn2V4BMc1lC2vkTIBh+dl/1X4gUYLqWXsLVE+bo7pF9t1mGcXP8WXDv4XyUie/XTjFzwc6truThouFz0y7QpRj1OlUj
X-Received: by 2002:aa7:cd69:0:b0:58c:804a:6ee2 with SMTP id
 4fb4d7f45d1cf-5b7f4294a1emr9353286a12.20.1722903230289; Mon, 05 Aug 2024
 17:13:50 -0700 (PDT)
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
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
 <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com> <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com>
In-Reply-To: <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 17:13:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
Message-ID: <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, Michael Ellerman <mpe@ellerman.id.au>, 
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

On Mon, 5 Aug 2024 at 16:25, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Can userspace on other archs not unmap their vdsos?

I think they can, and nobody cares. The "context.vdso" value stays at
some stale value, and anybody who tries to use it will just fail.

So what makes powerpc special is not "you can unmap the vdso", but
"powerpc cares".

I just don't quite know _why_ powerpc cares.

Judging by the comments and a quick 'grep', the reason may be

    arch/powerpc/perf/callchain_32.c

which seems to have some vdso knowledge.

But x86 does something kind of like that at signal frame generation
time, and doesn't care.

I really think it's an issue of "if you screw with the vdso, you get
to keep both broken pieces".

           Linus

