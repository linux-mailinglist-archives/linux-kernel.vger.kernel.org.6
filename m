Return-Path: <linux-kernel+bounces-271077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEB8944937
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1159B27654
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4DA183CC4;
	Thu,  1 Aug 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gr5Sor4O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14117084F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507650; cv=none; b=p1DF7JkW7ia+cRIW4ltvZUdvn/KyixrEiZfXc9+Ht0YNCni2slNjFA7WiU6plG2VPWUXfQvXgboxyJOrDE1ZZrL+85/BZ0xxt5yH41MG1eapkZlUCEhZKZLYxnoc7R0gjI36phBCIRoCIB9pZvP7xSULbSkW58nH1YQbrScO/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507650; c=relaxed/simple;
	bh=4qh2nmM/EexeuHVq9VR3ZhNY+D/o3BBt1yZ6uIKW0iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMa1Wgm6JNpsi/rQlpQbC7fAXMLGTNaKhoHzksNhifmF4bHC1m/4mplEU9BAR8DxWB/1tYDpGQ/1mHt9gFTDWSOYb2HTBzdaqtBdamRqOBXAPWXYQjx4Y/oVOExSb1SZ9T5yQJyT4ldozdAZPR8GJSWC9Fr9BTTzD8zL7//OQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gr5Sor4O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722507647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ryj/byZM4/CkBZhyM4lK7iN6hcD1ezI3JrBfHWgefU=;
	b=Gr5Sor4O0LlGjobpaED4f4+Ecy7pXtfmKz0IThRaMcOduwtRnqCfWh87/yLa4HV71oequ9
	0BNQqwo5fweLG3R9dPuSPK2wcnfbvwnwVC/TvDtbZRhFl4AHWCGbKYNF+/ed9BWRHlwPL9
	PGmeBJuijW5Pjd8TuOZeXHWqP8NoLsk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-4nysCp1UOUOQ7zpC6wdx_Q-1; Thu, 01 Aug 2024 06:20:45 -0400
X-MC-Unique: 4nysCp1UOUOQ7zpC6wdx_Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef2b0417cdso65673531fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 03:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722507644; x=1723112444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ryj/byZM4/CkBZhyM4lK7iN6hcD1ezI3JrBfHWgefU=;
        b=petofkCo5o6hcUNTnPZ39yGXbu/nz0W2hNZWA5CmNsxFFxEOwDRXqTLHfMHWijwCLo
         Yg1sMAdNI/7mQsLRg5xv/tPvoyk0p1MONGQoF9z7w6+4TrnuFo8yxGFNcajnpTPiwJeY
         LcpZAwg29EDxLN7PzwyieRqRLxWiygQVlYy9u7uP6l767a/kbuuXZ9d9HURBdUz628u3
         VkrUKVTVDc5HSegYKhRGOMzuao4Ze2MdQKeZvqYljq76K2GltvO3F1QT2TYfx1B5MeRQ
         RS37lT0DmIYoy+sjZhIdgGyhixs/1aSuHvqjhuq87Ok6eaiR+WvSB+3TkzxRatfGBCWp
         SkIw==
X-Forwarded-Encrypted: i=1; AJvYcCULbwrEYYsgDsSSjgujzG1BLQv3Z/dGoZuYi7n8KUrqzcls2hdNqT/CMCIVkOuIjyNZR4So182qTsYeB7h0tHtjTs/dyi2E8adi+9TT
X-Gm-Message-State: AOJu0YzwGOWy2bD1h51yPUekqdrFWzxEEPlSzWLOs7hDzgncqYO7MxFu
	2+aGIqnEKd0irtRQtCzYEf8WQRcSd2BqSbwcc6hNJ0d0vIhWgZoQ67c8/IM1EPq4L7iFUbo+sEU
	ZXX8iydzQ8BeezSbekwws7ksvl62UrNx62luTh79o3RY+vmdENyxWStF8t86UGE7DeZUlqhBuNi
	Wq88zd+En23GwkBggknlA806K8MS63moTR5zKW
X-Received: by 2002:a2e:3512:0:b0:2ef:251f:785 with SMTP id 38308e7fff4ca-2f1530d391amr14052761fa.1.1722507644135;
        Thu, 01 Aug 2024 03:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFedGze0XoV3r6eGI/EkC+bRZ26eUIKglkquRK2Ld+t5vx+Ab5czWpQjolrImbSl5+Ok4MZwWvBYtvbBdCIsyw=
X-Received: by 2002:a2e:3512:0:b0:2ef:251f:785 with SMTP id
 38308e7fff4ca-2f1530d391amr14052441fa.1.1722507643480; Thu, 01 Aug 2024
 03:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731083655.375293-1-tglozar@redhat.com> <20240731083655.375293-5-tglozar@redhat.com>
 <20240731115222.21e99427@gandalf.local.home>
In-Reply-To: <20240731115222.21e99427@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 1 Aug 2024 12:20:32 +0200
Message-ID: <CAP4=nvRnaM6ViT6t67prij+DLBso+0DB971G7ke+7OqEkPQpig@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] rtla/timerlat: Add --deepest-idle-state for top
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jwyatt@redhat.com, jkacur@redhat.com
Content-Type: text/plain; charset="UTF-8"

>
> Could probably do:
>
> #ifdef HAVE_LIBCPUPOWER_SUPPORT
> > +             "            --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
> #else
> +               "            --deepest-idle-state n: [rtla built without libcpupower, --deepest-idle-state is not supported]",
> #endif
>
> >               NULL,
> >       };
> >

I would still include what the option does, even if not building with
libcpupower. I'm not too sure if the help is the place to say the
option is unsupported either. I see two perspectives on this matter:
one is that the binary does not support libcpupower and should state
it in the help, the other is that the version of rtla as a whole does
support it, you are just using a build that does not, and as such it
should be in the help (you will know it is unsupported when trying to
use the option). I suppose we can add a note like this, keeping the
help message to inform the user what the option does so that they will
rebuild if that want to use it:

```
#ifdef HAVE_LIBCPUPOWER_SUPPORT
             "            --deepest-idle-state n: only go down to idle
state n on cpus used by timerlat to reduce exit from idle latency",
#else
             "            --deepest-idle-state n: only go down to idle
state n on cpus used by timerlat to reduce exit from idle latency (not
supported due to rtla built without libcpupower)",
#endif
```

What do you think about that?

>
> We could get rid of most of the ifdefs if you changed the header file to be:
>

That's a neat idea, thank you! I know this approach (with defining
functions that do nothing when some feature is unavailable) is very
commonly used in the kernel to keep the API consistent across
different configs, but I didn't think about using it like this here in
rtla.

>
>You would think gcc may optimize it, but I don't have that much confidence
>it can or would. You may want to change that to:
>
>                int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>
>                for (i = 0; i < nr_cpus; i++) {
>
>Otherwise you may be calling that sysconf() for each iteration of the loop.
>

Nah, that is simply an oversight. If GCC optimized that, it would be
in fact a GCC bug, since the value of sysconf(_SC_NPROCESSORS_CONF) is
external environment and can technically change during the runtime of
a program (think of CRIU live migration of the process from one
machine to another with a different number of CPUs).



Tomas


