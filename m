Return-Path: <linux-kernel+bounces-574254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F979A6E2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1543B27B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EF0266EFF;
	Mon, 24 Mar 2025 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="em5UPKrA"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303426137B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842098; cv=none; b=ShNpfgrBbEP+WklvqbAPe3AC6VlTzComZ6h+enCeJ8fQg7jbXrQ16WwoVdOH/1ebzCn9iRz1a+g0wyMoxPD0i4ihJQcHzB3z92RFghg/QvK/Dt2FoMvBFKPsKHw2ep7MJHUK7GQJ6Creax6drYhZEVX8Ggsu8mFOEB718vVqjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842098; c=relaxed/simple;
	bh=EO/rLEqCvtmoL/dMys1nxObIy6QFEX4BDEzGpg63weA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHLFUGmxM3t1OErANKlqqW4+fOUpIgoquZXWbKsf4B+pOKvMhRF42Gq3w6jQMCab0k8CdpoFoFzdvxUVpEtpvkgyl8J5HWhD9xGbC018Wh5gz5T16dwle85jHqWV9y6SS9g6wl/ug8No8R5QloSbNaFJ5CQZ3M3AYRJ2qDH3IC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=em5UPKrA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2242ac37caeso30005ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742842096; x=1743446896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=48LADxYsPFNYpC9RkQxz/qJQj1A05qxmlsCgQxj9+pY=;
        b=em5UPKrAZ0Yama7jo86xb5hE+omM8JOiAE1tNwuxsXMXnhXIL/Gf6LTLyKiLGlXrq+
         1kUI54YCDXG9CW6Z2sB01tCLqlOL4r+PKNjy+JDTGkzNbWbq2QwUVx9YTeJ03tfeQIQ4
         LTJIW7jssb/+olYSx17kQMN2lbw3CNeBqgZdjO51mSt1mtOGB8hRWKTTiDuZ2DIFZotU
         nGOnVM1Oz2gpHqpuwzgxJgNCwqBmY0IDwQ8y6UaANju5/vJHiTx+Rjop0+TNbnSp9raZ
         2D8u6D+ssAJUUNwRmxPSu8l9GERo1a4ITe0gctrZV1pUoEey4sCpXd1LVKc7XIQX+iri
         1vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842096; x=1743446896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48LADxYsPFNYpC9RkQxz/qJQj1A05qxmlsCgQxj9+pY=;
        b=G8HzNqjCpc70/V2/Mo6OlR23d4cNShQQ/ruLDskQdkWp5urT7RExwhwAUQspKhMz+n
         /V5SuWl9foG9YkpYBuB7lBPdlFMw9pkg7gChSBTDGSKBR1zn6RuN0k1olcJDjnbq9zBu
         YSfEDxqMCuJNv2sU89zF4ERiAIzlIWKXiyX6DjlpKEoBBz0UZ1gHD5CsHAPprXK96XWq
         4wSf0CChxVcpwZna45CDOoFV3mwNIWGDucOWb3KQ+ZbCq/J2yJxmTvTKk6OMDkovZlHV
         fPLAX/IwMSpo91LmPz0LACQLMS4e414Ag/ZP1jyzfw31kYvCa+sQ+kuhSsUFGMBxEuMI
         35+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpMctNuiDXeo0TE3E/Jv/lP7goPbx5MfxZgZE0Y0gEdDrzFO8fZ234CvToQVCHIY9mDpxacOu1hn5XHuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnWyEcm5lmllvJW93CydyGLNOJGGdl1OHjV9L1+YPTsYo1uYj
	g6nGa7QaqVKPV5ZZCJFSUqjP2clMg0s4RKMwCucTiHAQD5NUA+gqXloczCtgFA==
X-Gm-Gg: ASbGnctDEVKOyDfvcR2DX8p74Y2PYDBOXX7NJVsuQiW9E5gUo83I5fQxnXnxGpEGDJH
	Mambkl/jq2ANWm6gkLS7MHAqmI3N4u2PVrQZWGu+aSDPjOqy2eWrNzJoXVmze5KCqnB4rUgS0lk
	gNndRvsmXGG3yrqzRoakB+Q7oe5+QZrtXjLBBRaB6qt4iFiVzD3OWIQdGyAv1kzNpJzZazyiqYy
	9hs2DSE9ekEs2Paq9G3elJAqpU4rFXn+DjBU6dh+0l5oTT8PYK90yi2m2m7cwWRQ/oQ00CkmmOt
	50cnJua65b94QuDj6W68fd/TzhEbL6n+W/6BC3l4Tm9Y95zP5+sEpDq9ehFYV4TOJAg/tyylKeb
	DF/xe
X-Google-Smtp-Source: AGHT+IEl/BDRuPpJewk+vQKbAcJs2uIZ7+PLdJqF+rWL16ksihu1ArO9daUVUcc2yDxs2Mw2YVVROA==
X-Received: by 2002:a17:902:e54a:b0:21b:b3c4:7e0a with SMTP id d9443c01a7336-22799f6ad40mr5732615ad.13.1742842095918;
        Mon, 24 Mar 2025 11:48:15 -0700 (PDT)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a746sm74546395ad.21.2025.03.24.11.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 11:48:15 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:48:10 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "Tiffany Y. Yang" <ynaffit@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2] binder: use buffer offsets in debug logs
Message-ID: <Z-Go6qOLxT0ZfxyD@google.com>
References: <20250324180716.1012478-3-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324180716.1012478-3-ynaffit@google.com>

On Mon, Mar 24, 2025 at 06:07:18PM +0000, Tiffany Y. Yang wrote:
> Identify buffer addresses using vma offsets instead of full user
> addresses in debug logs.
> 
> Signed-off-by: Tiffany Y. Yang <ynaffit@google.com>
> ---
>  drivers/android/binder.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index d1aa6d24450a..994ae205aa07 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3261,20 +3261,20 @@ static void binder_transaction(struct binder_proc *proc,
>  
>  	if (reply)
>  		binder_debug(BINDER_DEBUG_TRANSACTION,
> -			     "%d:%d BC_REPLY %d -> %d:%d, data %016llx-%016llx size %lld-%lld-%lld\n",
> +			     "%d:%d BC_REPLY %d -> %d:%d, buffer offset %lx-%lx size %lld-%lld-%lld\n",
>  			     proc->pid, thread->pid, t->debug_id,
>  			     target_proc->pid, target_thread->pid,
> -			     (u64)tr->data.ptr.buffer,
> -			     (u64)tr->data.ptr.offsets,
> +			     (unsigned long)tr->data.ptr.buffer - proc->alloc.buffer,
> +			     (unsigned long)tr->data.ptr.offsets - proc->alloc.buffer,

These could be pointers to anywhere in user memory, not necessarily the
alloc->buffer. So there will be cases where this substraction doesn't
make sense. However, you are correct that we shouldn't log these addrs
so maybe just don't? wdyt?

>  			     (u64)tr->data_size, (u64)tr->offsets_size,
>  			     (u64)extra_buffers_size);
>  	else
>  		binder_debug(BINDER_DEBUG_TRANSACTION,
> -			     "%d:%d BC_TRANSACTION %d -> %d - node %d, data %016llx-%016llx size %lld-%lld-%lld\n",
> +			     "%d:%d BC_TRANSACTION %d -> %d - node %d, buffer offset %lx-%lx size %lld-%lld-%lld\n",
>  			     proc->pid, thread->pid, t->debug_id,
>  			     target_proc->pid, target_node->debug_id,
> -			     (u64)tr->data.ptr.buffer,
> -			     (u64)tr->data.ptr.offsets,
> +			     (unsigned long)tr->data.ptr.buffer - proc->alloc.buffer,
> +			     (unsigned long)tr->data.ptr.offsets - proc->alloc.buffer,
same here.

Regards,
--
Carlos Llamas

