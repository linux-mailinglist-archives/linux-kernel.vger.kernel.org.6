Return-Path: <linux-kernel+bounces-239031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94EA92551B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8111B282786
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C013B298;
	Wed,  3 Jul 2024 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IEeKDY/z"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA613A863
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994376; cv=none; b=JgroUv+fLFkzTw9UShklccWOShdQFa1HAvlI6mZDDyHwqg63G0+O2JER8Ec4hdJ7N6U1rQ3DT3/8ODzJzauyi7oQLsAVQTvatzcXWjQAMmJz6ab6CfpM0tQQbPuc3Ex3OwRj77NU3rdHsysiFvxCKvaPWVrCOb5CaKfkkbfhEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994376; c=relaxed/simple;
	bh=liRpZl4IWwGyImnY5WnWNXsLYqZlwepr8DqzpwnJB+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROtvhDIgmCdRq7hg9ba/J5A8xPDmaS6RH/QFQRUM4M5AH2vsxIZlLJV2fMW4CPkiEXwE/OIIsb4EBfD22mhkyK/lbV+jYwJky/XUe4pKBi02othZFeJvSJo/6Cl8jcAoW0OXn5H+t18vSMGPYNUkLZdfcfySDY3SyCvrVbnrpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IEeKDY/z; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e72224c395so58248141fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719994372; x=1720599172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdyT6ioPy1VNeKmL4j3XjcoiZwneAHmBRTL0mGefOq4=;
        b=IEeKDY/ziqWaB/ZSYmi4XUzZ4kaLM90R8qWgWGW3vxI9mSW0O3ELuKwybhAQ/5yCmR
         RBo0lCJctwDzWiXbnFAwtWC9RcA3be42xvF6RKhxxKo515/SxBbh5wi4OTYSVYZq8aGL
         P0glNdIDrojcB/6Z8SlQTTUswFof99e6qrLfIXTuW9MzbrhYiyRl6sxausqNEQK7ni8l
         STwz7PxuFmrhexeppujFG4qakce52SFP9YW71DUSre4ISIhwzDpmq/2SfWHqgNjx7+5z
         QUq0Hc/UCzodd1PANO150ohHWYCNaph4BVXGhU0rZ0aRwZQFuTwXQ0bVglKg52WeYmKN
         HRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719994372; x=1720599172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdyT6ioPy1VNeKmL4j3XjcoiZwneAHmBRTL0mGefOq4=;
        b=i5U5BE3Hrz+I0UsBSoPSsjzKzn6rFho8vmEsx/1iyJN0u90O7i+8BA3idVWa2Pyl+u
         Mv+8GPWsIWKeyb+oipEUroG8RhAUBYZ9Zln98k4Lh4Cu6QQFfQIyrMyGUaoS60wA98Yo
         hQpxjreT3pPdR5I+9qz54hj0ZwizKAqwwXYKK1lr9+C2KzcSFDjyJw3MgZoy4QIWKfMc
         KXvpg/9gR5BGAm1DvKxtU16cUA5BBcmt5V0VxYUs5F+jHMsfv23tJ7TU6N6Srjixwf+y
         vlTqXM+ETCha0uUxLgmd9h2WdHcFJF53pq88QLGdqD3iLZeD3nTcE0pdNZfXtfelQ46Q
         Wm4A==
X-Forwarded-Encrypted: i=1; AJvYcCVH1abkzraqHl6vYchYd+tvWTyrbD5pU/m2pl5hqB3+us4Wg74l2d2q+7gGhvu54kYzJfr+RsG/zSO4fZ7svmIXVbsm9kVGzPaiQZ3q
X-Gm-Message-State: AOJu0Yxywbdu63V6nrR9LPHvFg2Re2X08N+JwKammQacuKY7G+KXpYmq
	onCo9tAM0O3BLthaMqLrDOVM1eQnCTgRD0qMYavfsCYNxWY8IHbTSphRQZzhTV4=
X-Google-Smtp-Source: AGHT+IFCrx5O8SyoDb7pv8NJaiksMiDUk0MIzdtkS+naCkfqpA17Gjg/ppieWiNLDo4J+A42AblrZQ==
X-Received: by 2002:a05:651c:2010:b0:2ec:550e:24f3 with SMTP id 38308e7fff4ca-2ee5e337c3emr70900071fa.10.1719994372235;
        Wed, 03 Jul 2024 01:12:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb0c2e10dasm15659175ad.223.2024.07.03.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:12:51 -0700 (PDT)
Date: Wed, 3 Jul 2024 10:12:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
Message-ID: <ZoUH8S4j164Ovfiq@pathway.suse.cz>
References: <20240702122639.248110-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702122639.248110-1-jfalempe@redhat.com>

On Tue 2024-07-02 14:26:04, Jocelyn Falempe wrote:
> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
> callback.
> This patch adds a new struct kmsg_dump_detail, that will hold the
> reason and description, and pass it to the dump() callback.
> 
> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
> function and a macro for backward compatibility.
> 
> I've written this for drm_panic, but it can be useful for other
> kmsg_dumper.
> It allows to see the panic reason, like "sysrq triggered crash"
> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
> 
> v2:
>  * Use a struct kmsg_dump_detail to hold the reason and description
>    pointer, for more flexibility if we want to add other parameters.
>    (Kees Cook)
>  * Fix powerpc/nvram_64 build, as I didn't update the forward
>    declaration of oops_to_nvram()
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

Looks good to me. With the minor fixes suggested by Kees:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

