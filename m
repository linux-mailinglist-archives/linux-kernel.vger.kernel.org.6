Return-Path: <linux-kernel+bounces-291890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C55A956898
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56F61F2182D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513B16193C;
	Mon, 19 Aug 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0nK3+GN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5611607B6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063611; cv=none; b=GE8eChyEd/qEk0m7RteMGsHaVU0qObHV7Xv77N8hsgomSCmMYjxQRhZptYs+m5MYGVJ8dbP26p9M/c2Ax890cURaz7nMwKrpsc77VPO2E2DogQYYA4R/izPCpsKBUwIK1OEVarAeLzcgsnIw5Wc+Ch0M8c6rLE0ilROyEBfAiOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063611; c=relaxed/simple;
	bh=ksM9jUYsIPvfvdmnq7YYGhoJD+RKEJJHwouJTHkKhKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCeLd1Y7d1+EZZGy6zPS46213jnHhiL0EVj6XmHTIc8HjoYhl+0ED5wn58vCngGJlPCC3d8bt7DctYSBX395sA6JqBwbrZazi3VL9ULYd1UFGxKV3kFsui5CvRwjZW1Y6Rb7Hkx3qHux3Uw7Yyk4oCSkFs6ouoLSo8aYLvaEwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0nK3+GN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724063608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmIbOrxDtvXOoZbZMr4nmgxGDaAym4vjdVSm0EMN42I=;
	b=W0nK3+GNHubyHaFctKZVydmvfEH+pFZI/+M/2wnltMDWDdkxjWfvAx5FiF9r3xOou8Z8Bu
	me5NVzQ2fwMTK5rT2EpMzPGX5j1WEnqN1coipaCgTU5/gItRjLcTl+oZ16mcpUdiIFjlQa
	cV16xA7OSVimDGeG3KDFGlW1nQ90zy4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-VrvJsWF2MVa7fYKeYvFv_w-1; Mon, 19 Aug 2024 06:33:27 -0400
X-MC-Unique: VrvJsWF2MVa7fYKeYvFv_w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d406dc42f4so1719005a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063606; x=1724668406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmIbOrxDtvXOoZbZMr4nmgxGDaAym4vjdVSm0EMN42I=;
        b=M4V/cJDyDB1q2WBeHz1E26pG3LITA35egxBRzqVDsvwCiWFmyo2xFk1TyHL+zV3Thb
         GS0HR95Ziij0q2LUdGPb+717O4joeG8oz+LerN6qcRxEnN529HiwsdAgl1Q+jaAL/ild
         gyO3lmZ/mdKjDVUnJ8YxUomiqIZWTu0AC6tuqeanGlzWvyiQgGVoj3OjhkNOIRjIOv8G
         m+j6KDChGWQTm12h6uM3GMeZih7noAWd4Jfyb7mEzr6IhmJRVTd3f6emcjz7iOD3EE6m
         ZaJqqETLatxy6cd9rhMOvThm8ihfunW+87U+56UxvWpj1N8Bb6M70P11UEvrDXh+xIOF
         BCTg==
X-Forwarded-Encrypted: i=1; AJvYcCXAzux3vYzEgWPzDWrMFMOLUdkI+FDwSq51nFg/Yee4EIH6Dq0HoR7gVTFvyzwzvjDvpFdK+mtgWwKTInQDXsCXyjBUjXnu8JaW4ta8
X-Gm-Message-State: AOJu0YxFXZxecbeXTG9bL9Zz32zMJ1/NOHA3Y+5C3JkTavRQUsloJIaM
	prPbexVjDJkZLRVVEhn99JLpIgul7Ok28z1mI7rEF4vUsv9i1+BvlWrgeGZgQX39oJLuSTjq6HY
	4solhaiWopLUHN8k63tOw45krWWwXdznbsSwKK8oMi/0LIbqp7bFW6cU4mysjzcJM3K7+uFGJ
X-Received: by 2002:a17:90b:238d:b0:2c9:9eb3:8477 with SMTP id 98e67ed59e1d1-2d3dfc6b117mr8947530a91.16.1724063606052;
        Mon, 19 Aug 2024 03:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqOEd9IUMwqTR7dUGvVwj2MvBYZAh4vjdUIO0TAjDZont7V9TKefsVCjoVrWsmSivBJiZCeg==
X-Received: by 2002:a17:90b:238d:b0:2c9:9eb3:8477 with SMTP id 98e67ed59e1d1-2d3dfc6b117mr8947517a91.16.1724063605615;
        Mon, 19 Aug 2024 03:33:25 -0700 (PDT)
Received: from [10.72.116.30] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e4a39279sm6842266a91.3.2024.08.19.03.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 03:33:25 -0700 (PDT)
Message-ID: <9385a27a-da34-4bb3-96a4-9e54f5273d0c@redhat.com>
Date: Mon, 19 Aug 2024 18:33:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ceph: fix memory in MDS client cap_auths
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
 Ilya Dryomov <idryomov@gmail.com>, Milind Changire <mchangir@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240819095217.6415-1-luis.henriques@linux.dev>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240819095217.6415-1-luis.henriques@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/19/24 17:52, Luis Henriques (SUSE) wrote:
> The cap_auths that are allocated during an MDS session opening are never
> released, causing a memory leak detected by kmemleak.  Fix this by freeing
> the memory allocated when shutting down the mds client.
>
> Fixes: 1d17de9534cb ("ceph: save cap_auths in MDS client when session is opened")
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
> Changes since v1:
>   * dropped mdsc->mutex locking as we don't need it at this point
>
>   fs/ceph/mds_client.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 276e34ab3e2c..2e4b3ee7446c 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -6015,6 +6015,18 @@ static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
>   		ceph_mdsmap_destroy(mdsc->mdsmap);
>   	kfree(mdsc->sessions);
>   	ceph_caps_finalize(mdsc);
> +
> +	if (mdsc->s_cap_auths) {
> +		int i;
> +
> +		for (i = 0; i < mdsc->s_cap_auths_num; i++) {
> +			kfree(mdsc->s_cap_auths[i].match.gids);
> +			kfree(mdsc->s_cap_auths[i].match.path);
> +			kfree(mdsc->s_cap_auths[i].match.fs_name);
> +		}
> +		kfree(mdsc->s_cap_auths);
> +	}
> +
>   	ceph_pool_perm_destroy(mdsc);
>   }
>   

LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

Will apply to the testing branch and run the tests.

Thanks Luis

- Xiubo



