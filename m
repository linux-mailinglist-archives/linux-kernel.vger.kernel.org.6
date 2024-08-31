Return-Path: <linux-kernel+bounces-309933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BD696720D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2631C215B2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA64417BA6;
	Sat, 31 Aug 2024 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpIMurxg"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB943D69
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725113800; cv=none; b=BQn/73ev3Ny9WDiv8Y/vFhUQ/fwTw9shDoVkfx/weS5jt9BYciWSD2jt5gCv4s8CQ8Zj/Zz9PW9PjAnBNEkm9akMoSQF5tU7j2FjzX3ZdwjfzVsAZPbEODZAXEeCAUVhhilC/8nqyNYhLMBDLlU7U/+P/bHxfD12+/ZJ/Xb2U/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725113800; c=relaxed/simple;
	bh=gDYtFOHMrfolDTvNAFtjJn9mfwTFmR9nA9jdoD5Jv/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqOYVEI9aiOPO9+INiWM2UkUp2WD+rblMeXlzia1rbU7NDB/kBKeeujDiVAvhbTVujoEx9IF2077sG8BeG/lcbTX3P4jYU8H2RZ4jbOQsvwwJNYPTJoRwEgUUp1pbo29c1IH00sMTTVtG0iMQNXki7CQKHhDL+qlArAKYcBST2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpIMurxg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20260346ca1so107965ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725113798; x=1725718598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba/pxJAHh9y7H5IhTBZ9PZj8V6p7TJB/L9kXBwk643o=;
        b=MpIMurxglnUPB+NToph9rBBXb/u5bGGHnGXmGMbD0eGXc494KoJxS22eRBO59w/pR4
         6zXTDuJf/pJmF5F2Ku34tfMHwlORK2YUmaS9TLios2zAx+1g+2ti0cKPLmwUvyDyuBgb
         PzcBUg67v9Xp5ULdAS90nOOl9dLUlZ7m7FVcPvXtzndb/uH0s/rLW2cDucbdQJ4XOpRU
         /KzOBfgz/9XPdA7siL7QX9QMMQPx5VFWPF+1OekSFh3sukIgLXWwUjbGDfCg8ygyiAQk
         h6WGZDvq3Vp4EZ8bff+aC3T1wErgzypDnYBs4yBzqg2dP684oRKcC9b1A/KQU2m8Fyot
         coIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725113798; x=1725718598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba/pxJAHh9y7H5IhTBZ9PZj8V6p7TJB/L9kXBwk643o=;
        b=n4tZoxhD6khiY0VFgPpbEmunBQ705P3631wTN9W2pG6hiGn6RU/K5Hm7hoNzCtLuqz
         wn7jEzDIiAMgweBZEHujK++MxT3OZ9SMjO0GEmG8s/AOPzXda70J/BputW71pb8Wsdf9
         hI/mDTP+65L44CCm8VpBbEQ+1paGa6B1Ej3kWaC9u5NIG6EZW4TkiBb1vQeJy0qQNLrO
         j5Y0RNFJn7HuYMe8zbahw2Zf2L0NozPz/dSn34ExNDOJqZIYdVeGTkwDmFvjPGbda4+u
         njGHM81juYFjT4HsIIwNd7TDjVCPYMZ45mJJEsZ2BzHwlFnm6Hh6/10yFT+0wZE2fZhM
         EqEw==
X-Forwarded-Encrypted: i=1; AJvYcCW76Ga75vyrGzCJThM/fPlpaQ5Ui3ib19vB3rzHvPjhBa0+gwUNjugvwx/TKHPIPA8X+8NOn0IDZrK8j94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxVOhxz6s2VmFLPPhtHP4Vupo11bZRSCyRjjgppc/ihmgYF9pA
	Jni9K/qFRIBjAc7uMfhvhAIfP8OXjL/I+9uy+2Iinp5fa2ZY9RtvI7e2eIb/tw==
X-Google-Smtp-Source: AGHT+IGHTtFQXbgRwYPukzmkvxQvD+PqgOG8vE9sqAhv+ckwliuBeUA5ysj+Ep7kXoDhTBkSkCUx+g==
X-Received: by 2002:a17:903:191:b0:205:40cd:9c70 with SMTP id d9443c01a7336-20545595830mr1863145ad.26.1725113796997;
        Sat, 31 Aug 2024 07:16:36 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be627sm4710970a12.57.2024.08.31.07.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 07:16:36 -0700 (PDT)
Date: Sat, 31 Aug 2024 14:16:32 +0000
From: Carlos Llamas <cmllamas@google.com>
To: bajing <bajing@cmss.chinamobile.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] android: binder: modify incorrect comments
Message-ID: <ZtMlwFZdMjgfgdOv@google.com>
References: <20240830073743.2052-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830073743.2052-1-bajing@cmss.chinamobile.com>

On Fri, Aug 30, 2024 at 03:37:43PM +0800, bajing wrote:
> The comment for binder_proc_unlock was incorrect, so it should be modified.

Can you specify why the comment is incorrect?

> 
> Signed-off-by: bajing <bajing@cmss.chinamobile.com>
> ---
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index fc55b5d0e4f3..578861d57045 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -277,7 +277,7 @@ _binder_proc_lock(struct binder_proc *proc, int line)
>  }
>  
>  /**
> - * binder_proc_unlock() - Release spinlock for given binder_proc
> + * binder_proc_unlock() - Release outer lock for given binder_proc
>   * @proc:                struct binder_proc to acquire
>   *
>   * Release lock acquired via binder_proc_lock()
> -- 
> 2.33.0
> 

I'm ok with your change. It is specific about which spinlock it releases
(even though this is obvious from the code). It also pairs better with
the acquire comment block in binder_proc_lock().

However, you need to modify your commit message as the current comment
is technically _not_ incorrect. Can you please send a v2?

Thanks,
--
Carlos Llamas

