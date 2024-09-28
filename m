Return-Path: <linux-kernel+bounces-342308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429F4988D7C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFB8282D81
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE912B64;
	Sat, 28 Sep 2024 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEf2qBOP"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C3111AA
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489016; cv=none; b=CvdMcYGlITq/jqcmq0zFaKW0sB34LefcdZ3LfmS+cKJOyr/iWOSTvaDq9+ZODlZt/XB6eDZkoxj0mX/u/jqNLMM/6Iime5DEnwzG/gNZe4bCr1AQYxtkV/bAUVljA0zFH0e0a06BvfCsw9OPYWhzh7JqnMJj1MPBXKTEauM/rGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489016; c=relaxed/simple;
	bh=3YEMzurlh7qJNAx6PZBOe/N6mkm5F8N4BP5VSwieDls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mst/2IiYDA7HhXFshpIMH0zNVtihzPOjQE0A3qmtcf8HTrfRo+mv4vLi9b34U3bxeTAAMbMlo5gM17GnBBDmpjxsJK/2u7nvNSjxtu8GS2oyvk4QKaWSZD5TY04HBIlqfPG5pQywWqJmT0bAMx5r+GBUMf3PeELMcdbfda9lMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEf2qBOP; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8325044e388so105651239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727489014; x=1728093814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0UczL+R3tD/Ft3QVxFuzN55tfUGEJFRYYEEbRxmU2E=;
        b=cEf2qBOPUXpcwWZw2iP0hOieCGcobYf3mNQLZ3H6VtSHyWYT0PTvitHfxASsj01+Rf
         /xpClOyL2JcFrKXXyGKjoZlEFnWFtuV5nO6AymM4k1LLDBtNKhNzHlL2J6MtiwMYr8qR
         LuMA6LL/6hQmwMK89yIL/WsimgWUzoag8hprXvnRD+5+ZzVYYDmhIhsxft/VwJtBJzQC
         kyrwj4rSEqTRmvOsVBy7Zv1pL2UmMxF4S/h12Daxd2ubFlf3C8ZS6CsUninokisScAez
         8jqFsJunNw29sNDHaVGsRoQ2JELwutLhhQJF1Wg9hHyuluYbRT6ggIyf+mSo2tLv9CGl
         wkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727489014; x=1728093814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0UczL+R3tD/Ft3QVxFuzN55tfUGEJFRYYEEbRxmU2E=;
        b=SNTquONFrNtecYxk666ESIeGfxWS7s81QYJah+VpNDwi7LVGa0sM8EEloV0xTAVtTG
         MKRRrl7CS5ve+7Ja/lSRj1iE3e4zT3agbdAmgtYKf4+O9KHpzTSmNXvY68mhWvTqEGqd
         soiKxeG+bo8zQwZXi9JEylAVH+kN8wIQUlDLr61O/ZT4AWICGSYEM5tPpdJ7Y46NgIAj
         JCW6XZUfO5pa1pa+0x5XbKyG9B2MQWqTK3F5D2IZfbPe5hvg669/6eN0xYmxJEGjv+S4
         9Fm1uKCXgIzYaTVgM4QlDvU0FC7JqKjAwvtmDQ70yuI4EqeH4rvozF44By7cCz9bHz+Q
         Ntcg==
X-Forwarded-Encrypted: i=1; AJvYcCUecE+IHIjdmDVX9lcGO5RUAS2esL9z6Cm25wZHiTOE0DFfETglIdD3H5MFDgUTUexx2WmS2Ol08jj5esY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwApZrxgQPFIW0/1Xozc7xWrHoAtsv/lmdttxVFpQcvHuA/jl6/
	cnmWkqkUxQ9s3oo5nNuqJBD3sme1wCHpX2uPoMO7shuLWlzMFEYPtdcbihm7pA==
X-Google-Smtp-Source: AGHT+IHP4VWSEq6ViTOKDqfybNIa3TZYlGAA7HFUy7+R9x3J9EURD/tS83ZYLv/lTus4fayi5o+n6g==
X-Received: by 2002:a05:6602:1641:b0:82d:79b:ee8d with SMTP id ca18e2360f4ac-834931b1a4emr524668639f.4.1727489014480;
        Fri, 27 Sep 2024 19:03:34 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888351e8sm830347173.8.2024.09.27.19.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 19:03:33 -0700 (PDT)
Date: Fri, 27 Sep 2024 19:03:29 -0700
From: Justin Stitt <justinstitt@google.com>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] keys: Add tracepoints for the keyrings facility
Message-ID: <3ttplslryf2sdthv3aracoqixwoodblq2gw2vfm2mlgf2kh25h@4hc3iy23hlj7>
References: <20240821123616.60401-1-dhowells@redhat.com>
 <20240821123616.60401-8-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821123616.60401-8-dhowells@redhat.com>

Hi,

On Wed, Aug 21, 2024 at 01:36:15PM GMT, David Howells wrote:
> Add some tracepoints to aid in debuggin the keyrings facility and
> applications that use it.  A number of events and operations are traceable,
> including:
> 
>   - Allocation
>   - Refcounting
>   - Instantiation and negative instantiation/rejection
>   - Update
>   - Detection of key being dead
>   - Key quota changes
>   - Key quota failure
>   - Link, unlink and move
>   - Keyring clearance
>   - Revocation and invalidation
>   - Garbage collection
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> cc: keyrings@vger.kernel.org
> cc: linux-security-module@vger.kernel.org
> ---
>  include/trace/events/key.h | 401 +++++++++++++++++++++++++++++++++++++
>  security/keys/gc.c         |   4 +
>  security/keys/internal.h   |   1 +
>  security/keys/key.c        |  50 ++++-
>  security/keys/keyctl.c     |   2 +
>  security/keys/keyring.c    |  27 ++-
>  6 files changed, 472 insertions(+), 13 deletions(-)
>  create mode 100644 include/trace/events/key.h
> 
> diff --git a/include/trace/events/key.h b/include/trace/events/key.h
> new file mode 100644
> index 000000000000..b3f8c39cc0e8
> --- /dev/null
> +++ b/include/trace/events/key.h
> @@ -0,0 +1,401 @@

<snip>

> +	    TP_STRUCT__entry(
> +		    __field(key_serial_t,		key)
> +		    __field(uid_t,			uid)
> +		    __array(char,			type, 8)
> +		    __array(char,			desc, 24)
> +			     ),
> +
> +	    TP_fast_assign(
> +		    __entry->key = key->serial;
> +		    __entry->uid = from_kuid(&init_user_ns, key->uid);
> +		    strncpy(__entry->type, key->type->name, sizeof(__entry->type) - 1);
> +		    strncpy(__entry->desc, key->description ?: "", sizeof(__entry->desc) - 1);
> +		    __entry->type[sizeof(__entry->type) - 1] = 0;
> +		    __entry->desc[sizeof(__entry->desc) - 1] = 0;

Looks like these want to be NUL-terminated. Can we use strscpy or
strscpy_pad since strncpy is deprecated [1] for use on NUL-terminated
strings.

> +			   ),
> +
> +	    TP_printk("key=%08x uid=%08x t=%s d=%s",
> +		      __entry->key,
> +		      __entry->uid,
> +		      __entry->type,
> +		      __entry->desc)
> +	    );
> +

<snip>

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Thanks
Justin

