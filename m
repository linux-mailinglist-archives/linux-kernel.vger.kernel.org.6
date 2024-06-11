Return-Path: <linux-kernel+bounces-209173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7423902E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A001C22084
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CD6BA5E;
	Tue, 11 Jun 2024 02:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/AGzViK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929733D8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071934; cv=none; b=RnUL3vR2atTX5j7QOJu/t7kqoZ3xJHd5YvKmCp2poLXvSIPhS6HmM2BZ+Fnv1Mcuj4SzbsJV5DpRpnZBtgVA9DPQ1qPgZH7j9y2v7s3WJjePkf+vPlnsdhKPJhsKVn4DQ0bZbdA3qgtaWtf9F7QEzhqUgwSFZTCmYGUHVzWDxdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071934; c=relaxed/simple;
	bh=6xP1ei76jr5aHAJqlhhcWItU2AXyK4KV8+AWVUgjv+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QK02aYxz/kRhJiABFGNQbLSbVTtVT7QggA8HY3OI37ugT8kLJZl8sx+16pydA0z8d7ZZ/T1izH3FMAnGRmRzAuFB9zglhgsuljfscDYl7EiWIEIRknsXlvGp46VWRODBEI9MXoZPZ/MeZoMIZ0n4UH5kSUuM5GGizZ4XSPTfh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/AGzViK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718071931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl1gGO4UgKTAEFs1CZF/0wGX2Tf6+LMOtr2l88VGC+Q=;
	b=J/AGzViKK2rqqivt1Gj1TUFGyadTksiNXYii3+u4xg0Li/aLLttmi1SqvY5PGpy1CLDSNr
	uoIANqrX3Ju/uL2SaR4mYs2dq81JO1bWtJXq9e77IGuUwhO0tspeAvltFXw5t2MYs1bAzQ
	tOi0k1nq42E3RYkQficUOY8sHRuyLKk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-qpqaSwZ9N4S0SXqrw_1BPw-1; Mon, 10 Jun 2024 22:12:06 -0400
X-MC-Unique: qpqaSwZ9N4S0SXqrw_1BPw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2bf5bb2a414so4783441a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718071926; x=1718676726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl1gGO4UgKTAEFs1CZF/0wGX2Tf6+LMOtr2l88VGC+Q=;
        b=OqDhNprzmcsNDtj+Ocv3Xul0o85oZMa3fp4FWwahEX2/zuonL2FkXsjNiFyA/DMHWx
         yagJ2lRjWUHB53dm9pZj5pqwmFQ+o7+RZC69sVibOgyA91UNpRrzCkQ87G69k6bPoYB+
         FtL1Zq5Xq/NLgjx8mohizCRTYSV8e91dZCcCjgKveHHXes3YAW8mkdnPmIXNCGFpgGlL
         o2chaGezvENu7YZLiN71AeGujVZQ7GY3mBvlgl5bmAmeXqTkfuuEtzinIbIv9DFzH8ad
         +cdMNXUWgAZzfqlnBlgGc9j8XzVd/2x7QbhI75Z3CwRxUNubL2IY5olVS4mk0hqV7QoW
         pXjA==
X-Gm-Message-State: AOJu0YzMmAl0/HDha614eaz0L3YMsJAw+Qd71WDqjOmIFb8J5Su3IzqL
	fpT8IvWPrKbH317Wyz5jNUioXsJ+oR1Dxmbbg6ENugWgLbdaUnx5kw9PDXso7wpXbG/XtePd4Uk
	1ZXlJY1FqgJDIAeMblAqweKv4px/r2JORpK4IMu56IITVdPdzvcSomKCmcZCEYQ==
X-Received: by 2002:a17:902:d2c8:b0:1f2:fc8b:ebfe with SMTP id d9443c01a7336-1f6d0389353mr119517825ad.48.1718071925837;
        Mon, 10 Jun 2024 19:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHdprNhnBBG8Q7R+GJT6+3TiYFLUc4wINGfuZT0vXuCOjJzIKH6fw+aACuUgHH/+RFZfCiNQ==
X-Received: by 2002:a17:902:d2c8:b0:1f2:fc8b:ebfe with SMTP id d9443c01a7336-1f6d0389353mr119517745ad.48.1718071925468;
        Mon, 10 Jun 2024 19:12:05 -0700 (PDT)
Received: from [10.72.116.2] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd778fc2sm89270965ad.119.2024.06.10.19.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 19:12:05 -0700 (PDT)
Message-ID: <a72e754a-3e72-491c-935c-ca5c1f21a8f7@redhat.com>
Date: Tue, 11 Jun 2024 10:11:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ceph/mds_client: use cap_wait_list only if debugfs is
 enabled
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com,
 ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240606164157.3765143-1-max.kellermann@ionos.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240606164157.3765143-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/7/24 00:41, Max Kellermann wrote:
> Only debugfs uses this list.  By omitting it, we save some memory and
> reduce lock contention on `caps_list_lock`.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   fs/ceph/caps.c       | 6 ++++++
>   fs/ceph/mds_client.c | 2 ++
>   fs/ceph/mds_client.h | 6 ++++++
>   3 files changed, 14 insertions(+)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index c4941ba245ac..772879aa26ee 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3067,10 +3067,13 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
>   				       flags, &_got);
>   		WARN_ON_ONCE(ret == -EAGAIN);
>   		if (!ret) {
> +#ifdef CONFIG_DEBUG_FS
>   			struct ceph_mds_client *mdsc = fsc->mdsc;
>   			struct cap_wait cw;
> +#endif
>   			DEFINE_WAIT_FUNC(wait, woken_wake_function);
>   
> +#ifdef CONFIG_DEBUG_FS
>   			cw.ino = ceph_ino(inode);
>   			cw.tgid = current->tgid;
>   			cw.need = need;
> @@ -3079,6 +3082,7 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
>   			spin_lock(&mdsc->caps_list_lock);
>   			list_add(&cw.list, &mdsc->cap_wait_list);
>   			spin_unlock(&mdsc->caps_list_lock);
> +#endif // CONFIG_DEBUG_FS
>   
>   			/* make sure used fmode not timeout */
>   			ceph_get_fmode(ci, flags, FMODE_WAIT_BIAS);
> @@ -3097,9 +3101,11 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
>   			remove_wait_queue(&ci->i_cap_wq, &wait);
>   			ceph_put_fmode(ci, flags, FMODE_WAIT_BIAS);
>   
> +#ifdef CONFIG_DEBUG_FS
>   			spin_lock(&mdsc->caps_list_lock);
>   			list_del(&cw.list);
>   			spin_unlock(&mdsc->caps_list_lock);
> +#endif
>   
>   			if (ret == -EAGAIN)
>   				continue;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index c2157f6e0c69..62238f3e6e19 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5505,7 +5505,9 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>   	INIT_DELAYED_WORK(&mdsc->delayed_work, delayed_work);
>   	mdsc->last_renew_caps = jiffies;
>   	INIT_LIST_HEAD(&mdsc->cap_delay_list);
> +#ifdef CONFIG_DEBUG_FS
>   	INIT_LIST_HEAD(&mdsc->cap_wait_list);
> +#endif
>   	spin_lock_init(&mdsc->cap_delay_lock);
>   	INIT_LIST_HEAD(&mdsc->cap_unlink_delay_list);
>   	INIT_LIST_HEAD(&mdsc->snap_flush_list);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index cfa18cf915a0..13dd83f783ec 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -416,6 +416,8 @@ struct ceph_quotarealm_inode {
>   	struct inode *inode;
>   };
>   
> +#ifdef CONFIG_DEBUG_FS
> +
>   struct cap_wait {
>   	struct list_head	list;
>   	u64			ino;
> @@ -424,6 +426,8 @@ struct cap_wait {
>   	int			want;
>   };
>   
> +#endif // CONFIG_DEBUG_FS
> +
>   enum {
>   	CEPH_MDSC_STOPPING_BEGIN = 1,
>   	CEPH_MDSC_STOPPING_FLUSHING = 2,
> @@ -512,7 +516,9 @@ struct ceph_mds_client {
>   	spinlock_t	caps_list_lock;
>   	struct		list_head caps_list; /* unused (reserved or
>   						unreserved) */
> +#ifdef CONFIG_DEBUG_FS
>   	struct		list_head cap_wait_list;
> +#endif
>   	int		caps_total_count;    /* total caps allocated */
>   	int		caps_use_count;      /* in use */
>   	int		caps_use_max;	     /* max used caps */
Reviewed-by: Xiubo Li <xiubli@redhat.com>


