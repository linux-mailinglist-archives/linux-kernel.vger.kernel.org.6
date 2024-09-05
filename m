Return-Path: <linux-kernel+bounces-317946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B9E96E5D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01ED1F24A20
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6CB1AE861;
	Thu,  5 Sep 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SH+sXFum"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A21917D9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725576288; cv=none; b=PVOPp/hTviqXsgMZIxzkkEkc5mrqO6XrGilNhoTvMBxvtOYGjxFqIQCP46JbaiF5ySZAHsE7+BKTKb8RAa77YMb2ofz1yMAwAwWCB44aow6dRQ38t3Vj4XbCCjGjyBwrXcIdHX6jjHJO/h9WJzJXKuRUyYKGQy2J3UQVwbQkkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725576288; c=relaxed/simple;
	bh=HxMXdIDgyZWWmaSLqm2XBtDbr44V1UizUHThWmxVRU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Umm0ykrpSdWjS3ju1wVcPnHu/GsJFwD3+12hbE2Vc2iOQ2osYglVcrbe9jDB/FpGn8RcLR/nUosq+hYFATWkfTT21X2VSAUQRvlyBnrGoBuYDwIHT6ywlvTI/HBWC7qVKv0L/oYviYJu8UBuQc6v19I9VVGAbNh0OwScKeo03sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SH+sXFum; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2056aa5cefcso34865ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725576287; x=1726181087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=msUAnaP1lwyW1gCpV+BMOp+iO1+Mv6Zf+wIAvUJML+w=;
        b=SH+sXFum01GKpQFZlvcnz6+0EB/RIVLejflKA7arT/yVTLhrT0QHKBbGgH4GgwxdSZ
         sNCUL1Rjz7nM/20c1eShXU+c5yC7+JLJqUsY7uDDgvrgzCBXA5AFLsF0qH9bRr7Hoxmw
         E9j/67V269vDDakArxyRGH4UR80DMpeDUeEx9HBUNASq4AOybtCkBIXFo+eyPyrg0z/N
         hScWFf2INGz3yUk1Z8/WfrXCIb2exReOpS1T96Hw+bO4qWRJw9IHKGHBOxx56KUiFG3g
         7Bk676KVN78If8XHiIOphNahfv5B9bU3rPZIIKRKtKzWeq8mdErMc1hq4vMaJJO1Bcdh
         41Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725576287; x=1726181087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msUAnaP1lwyW1gCpV+BMOp+iO1+Mv6Zf+wIAvUJML+w=;
        b=eCjEtr0nrOdSglhC+NjfLHQp+AcBq7SRWP0x/a3QM+SnhnYvsY1draMPAz8X2ToKZa
         GvpR+4LrWRZZe0i1LuvG4ZnbGxTVYNdCJ1CECALOUTM2vCGP/64EO8oeE4yB2Sgdu/VT
         XSnXIjNVwSEvx8YmBf6PW/iq6BbGlKMrUA3YfUZ8ghd/Ns23kIYBJD3PKZhNUZXGkDHi
         som7FeeebvlpUSpjdzSxFDIEUZTGxUqGdR+FuiML0aaQJF7Jem7PVy8V375riEYWIFI+
         9WhldBkp5FqC+zsdNbuVQqb4MkiDuzLQ0oZYmxeTax+9Hx1LE8sR0SgSaLEkIRrFmxJF
         eQyg==
X-Forwarded-Encrypted: i=1; AJvYcCVL85b8y/UGnVl5HLxiNmb2ukuL53soFaW9YBIipdq3NfBuYIgOj6uCLemCfsJH2k2rrle21aVtv7pDPt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2eOJWKJiAjukkvI/KaRaL3k+HY/A1WxwD3+cNYeRjzYu3Q3D0
	rL55GxEP3O7pu/1clhbI8CBgQh6apc5EdBxE6TbHGOc5TBOqGIABRsW11eBhqbArqAi1D4j2UUO
	osA==
X-Google-Smtp-Source: AGHT+IGu7boh7WxthvJLltmFfWHDlLO/mD5TiFLsFZqNCvxBIBv30uTWifEdd4AmhEE8IIP1O9B11g==
X-Received: by 2002:a17:902:fac3:b0:201:daee:6fac with SMTP id d9443c01a7336-206f2b447e5mr173105ad.16.1725576286313;
        Thu, 05 Sep 2024 15:44:46 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc12bcd5sm43724a91.53.2024.09.05.15.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:44:45 -0700 (PDT)
Date: Thu, 5 Sep 2024 22:44:41 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] binder: modify the comment for binder_proc_unlock
Message-ID: <Zto0WT8biWkrv-43@google.com>
References: <20240902052330.3115-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902052330.3115-1-bajing@cmss.chinamobile.com>

On Mon, Sep 02, 2024 at 01:23:30PM +0800, Ba Jing wrote:
> Modify the comment for binder_proc_unlock() to clearly indicate which 
> spinlock it releases and to better match the acquire comment block 
> in binder_proc_lock().
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
> Notes:
> v1: https://lore.kernel.org/all/20240830073743.2052-1-bajing@cmss.chinamobile.com/
> 
> v2: Reword commit log per suggestions from cmllamas@
> https://lore.kernel.org/all/20240902013636.1739-1-bajing@cmss.chinamobile.com/
> 
> v3: Wrap commit message. Add version history.
> https://lore.kernel.org/all/20240902025720.2334-1-bajing@cmss.chinamobile.com/
> 
> v4: Modify the commit information.
> https://lore.kernel.org/all/20240902033754.2708-1-bajing@cmss.chinamobile.com/
> 
> v5: Change the format and wrap the changelog text at 72 columns.
> 
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

Thanks,

Acked-by: Carlos Llamas <cmllamas@google.com>

