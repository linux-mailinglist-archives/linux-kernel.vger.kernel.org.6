Return-Path: <linux-kernel+bounces-308434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47FE965CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E3128270A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57CF178389;
	Fri, 30 Aug 2024 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="esw2zVbz"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A3175D30
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010202; cv=none; b=db61jhtFuA/07cMSktQ9eRjbpdKeyGXd3+Mf0LyZ3DYjdll0n1eErhWvBEfcpL724cePYodU2JR6/8ny1jgkIRu979rS4LyV67CtW+RrqMAxKYEriXYq4ygeNBxOPaxLysnqxCeH8IyVn0Vh3eIDwX+ki5SJx4jwR28giOYXoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010202; c=relaxed/simple;
	bh=gok4qIrvd8eZ/lG1tSzczlS1npoo3BXRdtP0ko1TibQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Phyftfd3Gv3woHjvJbQt2Pl7MM7AkHRLhyYDMuX1Te3TBxZMWY+hlA6IiPrK066RhpfuTQ9jT603BK0pubr8ECJIwjc/IH72vpvUsHMVCIh35k1T1uzuXvaY464h3MefpTWQLnn+afhLHm+jWnMFDSfO8GrL9Q5nc9cQUY/Jj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=esw2zVbz; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e115eb44752so1689202276.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725010199; x=1725614999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/O5tyTZ8QanHZlKQ8JnQz0hbXvqfng0bQvJeFbqyrQ=;
        b=esw2zVbz2OdxjZyao6edtBCHKf++0d3N8S71w/zdyquQ+olfAufZNHSsT/z64YIbDG
         QZr7/P6L816rghsOeS4kz7H/txw5h4AiWvnCEWPylVYVJU1XfYHS3CZ27vq2b4Cn+u8N
         UpFUjNxM0yUPjWyXsXAdBRplpuhETckvMAe00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725010199; x=1725614999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/O5tyTZ8QanHZlKQ8JnQz0hbXvqfng0bQvJeFbqyrQ=;
        b=Hf3IBuk9K+t+/hH4RheHtyUXyKvUdsPf35HTn44/2W6DpyKVht4N6I4T0z4MMsmUVV
         kgytKH4OZyRHt9cTh+sF0dNzQ6bNAUA2SxsXYuRAiRmnsYp9+YA090FooqQRmjdO0gla
         aC5h4VWbs7VmAVb2T3+UsaHn+14HlDuTfa1S/BUtu7918ujB/3z9wxMILKPf8W4nr8+d
         2h7fZvYF5u7KTU5cEA3Vgs3JwO8dbwoHv44OyYf9Qn7K5NVeQ5IodK760pzwvMNsakPZ
         vNgB86p+FLLPP5J9Dzx99Yki2BlIQ1bjezq61BVArFyTPbH09iP88GdV+7C7t8w//kLg
         jt2A==
X-Forwarded-Encrypted: i=1; AJvYcCW4kCs4v1fKc2K/bj1xAQwFMk6CBatkJSpFl6ZhOPPhCFdFVubthG4fEp38DvNm49ScVSbqGm6IWzq7DaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqmlAz6aIVGUdq+TvOo2m3LbFX+CL0ZM2WcAAGNhFhyZTnliqL
	GsXXxLa0NnuMrcmbFV3CMDY/vIfiJeWRKfTLnmSEE0aOE14lK3XrswJDyQQFDhRvl6Rmw9nSv/f
	80okWzkep5bOsG3F/3wyXLQOdwR4e3rII0egHnw==
X-Google-Smtp-Source: AGHT+IHANSr1rO4Ht3P1FD0JTFCc+u2PUhAGPaFwhdoDevBLpxTuliEN4c4TzJGk2KcYX302MtwVf1BGDGmhcuLtNn4=
X-Received: by 2002:a05:6902:2309:b0:e13:83fd:cf01 with SMTP id
 3f1490d57ef6-e1a7a1d1dc1mr1683623276.49.1725010199518; Fri, 30 Aug 2024
 02:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827091920.80449-1-shenlichuan@vivo.com>
In-Reply-To: <20240827091920.80449-1-shenlichuan@vivo.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 30 Aug 2024 11:29:47 +0200
Message-ID: <CAJfpeguHFqZF=R=WH2zuECDWHRDD3bYtZGaSrYV-Am0zopbShw@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: use min() macro
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 11:19, Shen Lichuan <shenlichuan@vivo.com> wrote:
>
> Use the min() macro to simplify the function and improve
> its readability.
>
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  fs/fuse/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8ead93e775f4..aedeaa6014a6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -977,7 +977,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
>                         return;
>         } else {
>                 res = fuse_simple_request(fm, &ap->args);
> -               err = res < 0 ? res : 0;
> +               err = min(res, 0);


I find it more readable the way it is, because it's not a mathematical
minimum, rather a "if error, return error, otherwise return zero".

Thanks,
Miklos

