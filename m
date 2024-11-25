Return-Path: <linux-kernel+bounces-420364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F509D798B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10021627DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5407F624;
	Mon, 25 Nov 2024 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjENRZAF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733AFC08
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496001; cv=none; b=qHRxqk4K3FxvjkgZwadQ5nPVMo/N+B5O+DE1vwy6VMc81Aw/3uxAb9r0nMxNwsI6QPEhKEI4wo9ZmtrqVwRjUmkgvDTj7SqI/fp5sMEhhEtpadH0QSEtiuwHD0x1dcRoOCWy88mGK30wMofCti+wb8awZvv5caSSkVnG5bp7bt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496001; c=relaxed/simple;
	bh=rBiPXAWhL7prSEE+oWNLyafaf94BI4KgDg7Xs99syVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntJiY4HdES+71zHP6ospFSh7YoRREn0/F1M/BG9gInjefveLBgopWSg9bdokLxFkqDsYgtzPfzvOxXIASUxLLa5iHN+sesXstuyYMdE7eYdgAsIvnS0eQuxxvF5pSYchltHJ7wkCSmfDRjreP23zFu1N6G8UX0GptTLSxz6KWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjENRZAF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732495998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYCrh/uGGFSMSiT9SxGgZt0ghT6J1XSTHnQBI60venY=;
	b=QjENRZAFMZ/HQ4NSXTQKWTYDRnhm5oWRALXx5Cq5UqvTKlgoCaNorV2S22PKDE5868eRfD
	woB07xeV52CPPozM7wFv8igwj0C4L+B8MHiDGKEjUiVzlyv5rPutQ3z7G2xGug1aEKHe3h
	jjb/lTI3cC8Xedkm9vTaVit9ULsZh4s=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Kxl43ES4M3mUlcBtX_trxQ-1; Sun, 24 Nov 2024 19:53:17 -0500
X-MC-Unique: Kxl43ES4M3mUlcBtX_trxQ-1
X-Mimecast-MFC-AGG-ID: Kxl43ES4M3mUlcBtX_trxQ
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7250b38fa07so326489b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 16:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732495996; x=1733100796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYCrh/uGGFSMSiT9SxGgZt0ghT6J1XSTHnQBI60venY=;
        b=I0McV9AKSGIxnH/EK1mFXualirIuXW1tiqITuyfuhcgac8ULDopDEyh0Jt8w5VPtSE
         N5b/6t7Hm4GBUSwxuZMx3/rvlAcwVKqgQ0FCiT6lhtfHjcl7BTuRXeYkr8eUJeOVWCyy
         Tr7jk7O6BPRSHcLS+1iwBVvAC3zqf7F03y/ABv/f/CMNFQLnCBa/z6LAPNVmgLX/mOCN
         bg1xKXiQ/r0iPc0Wn5n/9sNpKEGaOyQeViAcHvlISaRdHX4PbO6jV54wsYLLUrJmiEe6
         1aOCVj4+uqM6PAlIqOFdw3birNvyajVo84JzMEqwS+NvwMnbgHXbrqoQ1/mCyj3DrEgi
         91wg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+ITy/eE7HgkCMNVaULGPhrhi9XVRtGbRs9GQCdEDXMSMBYmwtzVEZ3u0CZe/G5en2XEQ4TnCe3yJjKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0RWovsQAQ8DVN9aUJ/vQqG60dj8+0LGVA4JfL4RNxCQitBbDH
	s/ISXGumEDFz3tM7rC2WjBOvpOuQHzmklld99HSTFt2PmrcZj/pHdW42gXN2xJPtAZM25DtFOXZ
	0lM+yWApR6VffsPUTzjmj/YFcU1yCLJOyadhbverP6uh1wbO0e4CVa4OfYecjU27XYoWF6g==
X-Gm-Gg: ASbGncuAWhD4jUqAb4LZ1lojGmHEpNxyFmsXZQpqw6bzCUXsauKhUgQp/W+iLSCuHHN
	vronGxURxLSSXiEP8A1xYXLT3xDp+tCSW8rY/jSjHUem12W8WO+xH8Bi6IDNcdIMeiyY7OLKZc+
	CmCqyBl3zcguo6nlgYKsuB+y9of5G1sXXAd3llEkIxIwl1NuOzxVFVmneSpBec4liNgEnzp44Fr
	eVpVW2fa7LRBVQ3r45V8e7w9dppqCbKaLdfGPE9c0Y3OpOiLIc=
X-Received: by 2002:a17:902:dad1:b0:20c:b052:7e14 with SMTP id d9443c01a7336-2129f28eca5mr115297585ad.50.1732495996306;
        Sun, 24 Nov 2024 16:53:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAh+2ElGAo++jlH3jK1mILWLPx5UAnw782BdEH0pmmssykaMkDOYS40gPooRfs1G0LDoOczQ==
X-Received: by 2002:a17:902:dad1:b0:20c:b052:7e14 with SMTP id d9443c01a7336-2129f28eca5mr115297435ad.50.1732495996002;
        Sun, 24 Nov 2024 16:53:16 -0800 (PST)
Received: from [10.72.112.30] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba27dfsm52456895ad.111.2024.11.24.16.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 16:53:15 -0800 (PST)
Message-ID: <b52a83ea-6e74-4bf4-b634-8d77e369e873@redhat.com>
Date: Mon, 25 Nov 2024 08:53:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs/ceph/mds_client: fix cred leak in
 ceph_mds_check_access()
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241123072121.1897163-1-max.kellermann@ionos.com>
 <20241123072121.1897163-2-max.kellermann@ionos.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20241123072121.1897163-2-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/23/24 15:21, Max Kellermann wrote:
> get_current_cred() increments the reference counter, but the
> put_cred() call was missing.
>
> Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   fs/ceph/mds_client.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index e8a5994de8b6..35d83c8c2874 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5742,6 +5742,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>   
>   		err = ceph_mds_auth_match(mdsc, s, cred, tpath);
>   		if (err < 0) {
> +			put_cred(cred);
>   			return err;
>   		} else if (err > 0) {
>   			/* always follow the last auth caps' permision */
> @@ -5757,6 +5758,8 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>   		}
>   	}
>   
> +	put_cred(cred);
> +
>   	doutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
>   	      rw_perms_s);
>   	if (root_squash_perms && rw_perms_s == NULL) {

Good catch.

Reviewed-by: Xiubo Li <xiubli@redhat.com>



