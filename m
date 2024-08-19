Return-Path: <linux-kernel+bounces-291310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A469560B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96013281637
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C6F17BCE;
	Mon, 19 Aug 2024 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hkx81NqT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2301BC20
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029617; cv=none; b=iXAMLH9ib2X3pjzb52afCJQX0Clf9SDTOHmGGXIBmVPYGXsiwLrAbSbfkfDTr5zXiGpZCfDGh2ocuPIASYVx57aVEybkkTbnQ2vafB72Cl2VjdFV2gGCoGfad/DlKAFzkbzAQguymng8TALqhG5iYP8Ix6k0aNJYk+ogOli796o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029617; c=relaxed/simple;
	bh=L6c1J2WXrp7NVX37JVowYQZSo6lUpBH4Ibe6W3H0r+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alxkOSxiqhQOLS+SA9N/nkCgb3LJBEmGJdfk/UtFR5o/r1wHyuum93ci211ZLgJT5ry+yOiXI98VO0wQtFtmqLA9rguQ+iTE1tcjENowMwnG38ka46SYmuRr8fpGg9EXC4t3BYKqQ3H706rMFi+iP/HtobPaccTlEErUPzkczOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hkx81NqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724029614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UJxCUfooDx982PsvxoAPnrAaQ78Ph8CMB2TyRJoz2g=;
	b=Hkx81NqT0e5dPNvej9Cegj1i9tV+/cA9YGYc2wTi3ADktvl0+zbvWvz8MPm/up0RrNmjfo
	oxAiKEEpNTyvGOIpjcb2tbHdCcRY78v+xG4bgL57FoBtAIYqBzhDWDp71uLWUss99x/9qg
	KMLGI6Wa2l5lACpE4ymYTHCJei7b5f0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-foEOEWXWPb-4_BEgYPHyKw-1; Sun, 18 Aug 2024 21:06:52 -0400
X-MC-Unique: foEOEWXWPb-4_BEgYPHyKw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70d1a747ee6so3577541b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 18:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724029611; x=1724634411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UJxCUfooDx982PsvxoAPnrAaQ78Ph8CMB2TyRJoz2g=;
        b=NPNHcQlkwX6SF/2rvbvkDelleX5F+e6uQD1PU2YSBSEf8fE2JRzVhGnHuGXcl2l9oT
         +LB8AaEDx8xyK4ii/vAPVpg0zuRuG7TkADqDgb1J5IaejNczioOMDZAwnxEt6BUWZlcC
         f6QCydONerROHVryQPowMaUxJAx1RuK8ypXgw1VCaZD9TcVnQHGv0HIpWecbbTTYY+jP
         mCTlFL3TS7Fs4y62ZNNpX3F/axafB3Wxnq9MnCVqcTLyK9RadA5SVaWCwW/si92zhm7U
         cGczP1tbLnSjBIvZ2czZ9cgHxzdVGbkkc9SLDhmzf4wvoTF61ThfnQkYsoG50KR9dU8a
         6XUA==
X-Forwarded-Encrypted: i=1; AJvYcCVkZy8vLIs4tH7TEgc9rTHABsPXKKk/wCPNRgE42XdKgfAIOAv8VYBK4cAeWLjh7ExIZ/B11ujWgqCXQEc3Qvugd4R0fUU3etUi9t/o
X-Gm-Message-State: AOJu0YxMeftiqv18ucfVod1MdqSq5t+h5va+iC5XX7/NjM8q7e2ta7gg
	KycD6wWfSs9hA+UacBhZyR3X6Fw3qPBLmeSPYsmhgSsopc9Cak0laRo0ogtf7TVQLl/8IEfQroM
	fdJ2VoYq5wRpg1TPDZl/20LzmUVRayb7/Qm4OPhsEZCyiJmSFH5XWdw158JAG4g==
X-Received: by 2002:a05:6a00:c94:b0:70d:2a5d:867f with SMTP id d2e1a72fcca58-713c4ef433fmr12334991b3a.21.1724029611389;
        Sun, 18 Aug 2024 18:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE//KdPTvqm57ETLoKkIWgG6I19lqqUn2OnAzMMhg/yCUF7bwIQ9qbAigULIcGNWz8ku3u71w==
X-Received: by 2002:a05:6a00:c94:b0:70d:2a5d:867f with SMTP id d2e1a72fcca58-713c4ef433fmr12334967b3a.21.1724029610885;
        Sun, 18 Aug 2024 18:06:50 -0700 (PDT)
Received: from [10.72.116.30] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef6590sm5686002b3a.131.2024.08.18.18.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 18:06:50 -0700 (PDT)
Message-ID: <b8c6e357-29f2-4da2-ab57-7035627b0bd2@redhat.com>
Date: Mon, 19 Aug 2024 09:06:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ceph: fix memory in MDS client cap_auths
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
 Ilya Dryomov <idryomov@gmail.com>, Milind Changire <mchangir@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240814101750.13293-1-luis.henriques@linux.dev>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240814101750.13293-1-luis.henriques@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luis,

Good catch!

On 8/14/24 18:17, Luis Henriques (SUSE) wrote:
> The cap_auths that are allocated during an MDS session opening are never
> released, causing a memory leak detected by kmemleak.  Fix this by freeing
> the memory allocated when shutting down the mds client.
>
> Fixes: 1d17de9534cb ("ceph: save cap_auths in MDS client when session is opened")
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
>   fs/ceph/mds_client.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 276e34ab3e2c..d798d0a5b2b1 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -6015,6 +6015,20 @@ static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
>   		ceph_mdsmap_destroy(mdsc->mdsmap);
>   	kfree(mdsc->sessions);
>   	ceph_caps_finalize(mdsc);
> +
> +	if (mdsc->s_cap_auths) {
> +		int i;
> +
> +		mutex_lock(&mdsc->mutex);

BTW, is the lock really needed here ?

IMO it should be safe to remove it because once here the sb has already 
been killed and the 'mdsc->stopping' will help guarantee that there 
won't be any other thread will access to 'mdsc', Isn't it ?

Else we need to do the lock from the beginning of this function.

Thanks

- Xiubo

> +		for (i = 0; i < mdsc->s_cap_auths_num; i++) {
> +			kfree(mdsc->s_cap_auths[i].match.gids);
> +			kfree(mdsc->s_cap_auths[i].match.path);
> +			kfree(mdsc->s_cap_auths[i].match.fs_name);
> +		}
> +		kfree(mdsc->s_cap_auths);
> +		mutex_unlock(&mdsc->mutex);
> +	}
> +
>   	ceph_pool_perm_destroy(mdsc);
>   }
>   
>


