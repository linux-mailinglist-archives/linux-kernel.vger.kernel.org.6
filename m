Return-Path: <linux-kernel+bounces-421340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE439D8ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D499FB2CF69
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819B1B412E;
	Mon, 25 Nov 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVJrgIHv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D041AF0B6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550376; cv=none; b=ndEAq2ZIIicJ99AHql/6Nxiu6VG0/wGdwQ85sdcQPoNJCZH/AxiLyJinEb5eQYaErnUw8le0QmwDGsjW6jfDdEzcKRlfdKWKQDz9HGsHh0KcLu/4Hd+V04lIm6L4huohqEMhme4y2nk7LzrAWWbkYEzfgk1aSjH4tlrhDiN9KXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550376; c=relaxed/simple;
	bh=bXxhz3W3PqXEJiRAVx8v6FyIkv3y1QoHxIoqaoPZfkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdKXPS2bnrALm/Jpu60GspLyDJhMzgAzOQBb0WniQO3aXIvRRz4nrOo7Z9svYLgYAfyTGs0hf85DOuL7sk14a5Y8L4JPH5rAkGnRRR+DSCLe+uSX8blF8JOppVeg0JaiMy1UEFo7VWdECFvwXRGLyKvTaEyddtkeDy4roOPB8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVJrgIHv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732550373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oX8scFsQuUadSRQ+mI03J3eg8Bz3TleAfCszq7nUkh0=;
	b=LVJrgIHv+tmVoLqJRuQWt8yNODB8OCxoX48Qi+3JhW12GEmf2p0d6d7b/Hztn16T/PxHQT
	rzCqDJMAuRGbcpP7Qp5Ddjlvxaif8+BR4LzFvY7x0g94KLNNvmmdbQSbdR5jv3cF/mPmMT
	BI9rAgakqVHikNTBb0C5RtxOA5IjVDY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-p3C95zwWPWS7x9SvM9ZSgQ-1; Mon, 25 Nov 2024 10:59:32 -0500
X-MC-Unique: p3C95zwWPWS7x9SvM9ZSgQ-1
X-Mimecast-MFC-AGG-ID: p3C95zwWPWS7x9SvM9ZSgQ
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-841a3f2aebfso78248439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732550371; x=1733155171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oX8scFsQuUadSRQ+mI03J3eg8Bz3TleAfCszq7nUkh0=;
        b=eXqbF32GT1eV0c+MFJbpmk7ai076YT3eMLXxODb4XGpiM9gmDiGX9yndOq0cdMjk9o
         vWxW6ZsZHcfJAOaO2UiLv3SQf/BdMxZnqqon7f+spio8XT9jQEdxKxCwI4VMt07otjvu
         GoC952H5lEfXSBSIyOfNoDh3awRgivlFNRij755Bfup001EFQP//RbaLBYwdXSlcLTCn
         PYvI1IyJE5NcXOkgY9TZyjMzI2mg/MyLVBzmB68Ft3k3jtkY6gL7lOQRRWC1jMB7NeJ6
         7ZOhSxF2K1z8jV9Y/SDUpL+EEwxPoLo3mC6VUMpkEwEwM8DAqRAbsDoKUQvbAklTcvVp
         63aw==
X-Gm-Message-State: AOJu0YyX4/EITZ/Wbqs7gVOZpOy1EliIOv2ApAq+fOJfPBh+ymX/FgVp
	oiRS5TVdky3wZOisEYKIAekhTtz/emLnEwTJ+tyTsWOYS7zr0Fsx2vd3LrcJehO6d0NURkp+IzZ
	Ia1qFW8BKrmFm5WMeHkwpmpCOVfSexyqA6e7jM0daZOXGaNx4/D9eiASmLEzJ9Q==
X-Gm-Gg: ASbGncu8it/53gie/K1INUnAe0HGCj6On19q6LMo/xmWd/hRg0dSI9D2Jfu34WkIwwm
	MkLoUO/hdcyhX6MPOgSA+gvF9ww4ILXHQl8jCp1k7mOcfeIvq3TLLGK5pBY2RNZX5wmuh6pao9W
	kZPSuILT4uQKApNUvoUI/jKrI1iA2NtKa+V4CGNX+LpoaUgVb4xHgMuLO/fEkS/yy2egiSeAI2g
	eCe+1mPeOErVxVq8sCK/yk7twsDPOsDPwggTAhfN6pEMmFK2VvZUiUYTUzmGphtvfJTRham7iPC
	wqi4pNTV8rA=
X-Received: by 2002:a05:6602:2b04:b0:83a:c0ba:73c6 with SMTP id ca18e2360f4ac-83ecdd0bd5emr1232839739f.11.1732550371506;
        Mon, 25 Nov 2024 07:59:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwkvzDL2G70N7j3gyA0GMId6fwzgZY0oXJrjHNI1Hm8/9p5wXTfiegtUAepZaCHcyr87RWgw==
X-Received: by 2002:a05:6602:2b04:b0:83a:c0ba:73c6 with SMTP id ca18e2360f4ac-83ecdd0bd5emr1232837639f.11.1732550371237;
        Mon, 25 Nov 2024 07:59:31 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ecd419260sm183641639f.48.2024.11.25.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:59:30 -0800 (PST)
Date: Mon, 25 Nov 2024 10:59:28 -0500
From: Peter Xu <peterx@redhat.com>
To: stsp <stsp2@yandex.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Message-ID: <Z0Se4BuVfqwjeCWV@x1n>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>

On Sat, Nov 23, 2024 at 06:13:01PM +0300, stsp wrote:
> Hello.
> 
> I tried to use userfaultfd and got
> that strange result: when I first do
> UFFDIO_API ioctl with features = 0,
> it succeeds. I check the needed
> features, and they are all in place.
> But on the second step, where I
> request the needed features,
> UFFDIO_API gives -EINVAL no matter
> what features I requested (or even
> set features to 0 again).
> 
> A quick look into the kernel code
> suggests that the problem is that
> uffd_ctx_features() doesn't check
> user_features for being 0, and just
> sets UFFD_FEATURE_INITIALIZED
> with no features at all. After that,
> userfaultfd_api() should always
> fail with -EINVAL when doing this:
> 
> ctx_features = uffd_ctx_features(features);
> ret = -EINVAL;
> if (cmpxchg(&ctx->features, 0, ctx_features) != 0)
>         goto err_out;
> 
> But I haven't checked my finding
> by rebuilding the kernel.
> So is this broken or am I missing
> something?

I agree it's slightly confusing but it's intended.  It's like that since
the start, so I think we should still keep the behavior.

The userapp needs to create one extra userfaultfd to detect supported
features in the kernel.  To use it after a probe request, you'll need to
close() the fd, redo the userfaultfd syscall to create another fd.

The kernel cannot assume features==0 to be a pure query, because not all
userfaultfd features requires setting of a feature bit. E.g., the default
anonymous missing traps doesn't require any feature bit to set.  So the
initial UFFDIO_API(features=0) is the enablement of such feature.

Thanks,

-- 
Peter Xu


