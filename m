Return-Path: <linux-kernel+bounces-395681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3F9BC197
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C191F22BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BECA1B3951;
	Mon,  4 Nov 2024 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OxtsjyOV"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2E139CFF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763995; cv=none; b=vCM/bOw5xVGjbh2XrBvl5xRCZPlkwQLcBZ2g7kYvSDvPrtXW23f+oWrKFJkAleIQAsgSQlaJfXkmYIxf3h3MrKzJlU9kW89wWVCwEQeioGpgGdHFt5tbdA+wAYcXBKhtNSsVGwGq/HxEso9Thyp3SY0vL5RxLyv7Bjsx3khcLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763995; c=relaxed/simple;
	bh=f0FMisOvkvuPmdlTVpM9CHX8yGQwfrT6YBA8JhhRgbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVlOSpRAMY/4QS4HX6wzSb+winfJ4ETpU7hyqKSXVNB31TtphBFF7mYIEGCTcbaaueFO0CDLITQOTLi3YjrMvp9QJDcJp67lWI555knpy6BmWjHsUxQ4QepGyHwl4NXLrzIJ/gjwFrhGuHTmWkJmNV28/dEcPXU1GcchrBefc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OxtsjyOV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720d01caa66so3115401b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 15:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730763993; x=1731368793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQRWEXSlNd7mP98l4zwWQnMAdZ6BcDjt4sBruKE3xGE=;
        b=OxtsjyOVbjRHd+7mjDIoVzHsd1M3Hp3Tt+3HssnevgD89K1V14KDBXXV6g07pt4Min
         3x+HTIvZJbwN7xcU0TnALI6kxZapdb0AB0Rcuce0LSQRGEgaPAVnFpg1GIbXuiwFFRMh
         xyOxX+ZuZMFD+FXofwzq/hdr5rpYsgBfpiHYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730763993; x=1731368793;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQRWEXSlNd7mP98l4zwWQnMAdZ6BcDjt4sBruKE3xGE=;
        b=p9HR7M8314blxqUHhEmw+QzjVF7dNvcNxcWNYJEPg87Uk0fjdtqTfyp5b0BsjdpwgW
         sZrnLCA9H5HNjF+RKlun5zKsK8zav6joisVo0brlMmjf3kMlaKyYDcvUH8o7Kwsc7BeZ
         3y6PmdAhGVVUfz4l2el3VcazYA19izKXXGLhm7J3nEtZj5doB1v1FJkoHWF2Gbs9StlL
         WPm57rqGw61sUribK/7+taIIReuY7rZ9HI6Nbk5SU6Ov2S6r9ebvHYRtdmughi7g9wDA
         61Pp5iFuXM5RO+5r1KZwag2ATYfsSSpMsbhPY6Tj0U1mc/W2ORqJoIfWgJujGetfEgzl
         nFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwkbBziAItcF33bbFXACzz/9rJUUNfd/X5uy4M8rr/nDrV0KtDY2tRH2Hdr0sJ8esiXYto5m7s8/vjfWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvK7T/qMVJVIefeSEo7N5kwhUN4wmdy7XV1FjrSMCZTZ0EPVof
	eOTIpeznx0MsqZCT3mjg2B1ruUzjl72qFD9jVBZxkfdBp1JfnibD1OVjI1HWo59sRs19bZFb0Ga
	0
X-Google-Smtp-Source: AGHT+IEUc8c3n4qvcko7rjt+K9aBujY+y1Tu/ceBOoi/9V9J/fIILp0bl9s2cwSenMhY+qqOT0MGVA==
X-Received: by 2002:a05:6a00:cc3:b0:71e:744a:3fbc with SMTP id d2e1a72fcca58-720b9d9490fmr24339143b3a.21.1730763992930;
        Mon, 04 Nov 2024 15:46:32 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ba244sm8456783b3a.19.2024.11.04.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:46:32 -0800 (PST)
Date: Mon, 4 Nov 2024 15:46:29 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 03/12] selftests: ncdevmem: Unify error
 handling
Message-ID: <Zylc1dKzubaa0yWQ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-4-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:21AM -0800, Stanislav Fomichev wrote:
> There is a bunch of places where error() calls look out of place.
> Use the same error(1, errno, ...) pattern everywhere.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> index 3e7ef2eedd60..4733d1a0aab5 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -339,33 +339,33 @@ int do_server(struct memory_buffer *mem)
>  	server_sin.sin_port = htons(atoi(port));
>  
>  	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
> -	if (socket < 0)
> -		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> +	if (ret < 0)
> +		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
>  
>  	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
> -	if (socket < 0)
> -		error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> +	if (socket_fd < 0)
> +		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
>  
>  	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
>  			 sizeof(opt));
>  	if (ret)
> -		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
> +		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
>  
>  	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
>  			 sizeof(opt));
>  	if (ret)
> -		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
> +		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);

A minor nit (definitely not worth re-sending for this on its own):
it might be helpful to add which of the sockopts failed to the error
message REUSEADDR or REUSEPORT.

Reviewed-by: Joe Damato <jdamato@fastly.com>

