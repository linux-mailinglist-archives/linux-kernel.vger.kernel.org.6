Return-Path: <linux-kernel+bounces-291315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0A9560CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C19A1F222B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B241D554;
	Mon, 19 Aug 2024 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPNp7855"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA91B7E4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724030223; cv=none; b=bOsCHlYaLxWU+G80DwLjF7gcGxGZ7xsUMHl2bg/RlXzlkMKxW/cCh4Q/w++Ofifun+l+7RLqn7g8SU2RzpV3Ejy91xUo002ydOpwHRSqwdjFYIhRQQebYzsGMR7HcEzrpY91w0TS+2gYsfUKpNXJr62OKujwd+b5AYFlLpcswnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724030223; c=relaxed/simple;
	bh=tp/Xpdn1oemCOIemM7zlCWHNVyPm8ld8A4jJVsyxICU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiVsnSMpJZkvZv5y8z+SsgsTjgmMXuU6TjN87kBWNjJCWhTJLpVhFDcE07R9HdBFNYZid3nUSvHgi8LqW4w4hRiYb+JMFMHDLoUgaUok2wuxtaCyPRJAlpgtuFq8S6VYtfnR272kthTMGWP7BI69IH4jBKk4EJHNtpWJ64sWxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPNp7855; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724030219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6JHQznnoP2B1M81XzspAZrHfEQzedoU2DAU6mxzvA0=;
	b=MPNp7855NgBnYJdmMjTLdO/g8JZ+oGXAbfmt0D5lbYPxacK+20M2DWoWb6MmdC3CpGAIxs
	sjZD44Gfij134qXVd4qx3Dh4PvdlRSL8G0OtIP/enj4O3BmZikGz0Rgvdb2HJtwqQd97VE
	ugLGkAfvF4w7RWsIwbwpbpJu1E5yx2U=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-_bqZdxPuNU6MCcCuZ8cFBw-1; Sun, 18 Aug 2024 21:16:58 -0400
X-MC-Unique: _bqZdxPuNU6MCcCuZ8cFBw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2701a253946so3987298fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 18:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724030217; x=1724635017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6JHQznnoP2B1M81XzspAZrHfEQzedoU2DAU6mxzvA0=;
        b=L/sAUHTctGdI6edGh5k8FcElC9+dN1dQHgQ6b/Qsxpe9mdX0Tzkr/7K/h/9pCUOtdR
         TjOt9k+59bumaSQOW4r45M7vo2XOBJbkRsKqF+2eeK8vZ+KTIJsaCM+zCEvRIsqel/jI
         9xxcEsYEtpaT98EvwTSicVqv6wtfxt3Dw721OsBqrS2C2gy5RPHm6QKlaYYPYXtGR6tu
         3fndz+IrmC2/BVBw/OWyJL0ogFQnOJ7wAAijyOrGZz7bE9TBQ6lAfcn4QRoL9qUchI5c
         biV+LLOUlgyJedlbUTiodHLlig4iaj1hDFaQXkxn/BTC3DqV7bWBzpsgPg1r1rwBzfx7
         U1LA==
X-Forwarded-Encrypted: i=1; AJvYcCWch22Yvm/EP0YtWXpkY6EfO/HaNAwMUcA4es33sLd2sSUJn2ZwTtbXUsJ54qlauzw3Gkr96ML+uqUvlUZJCTTQ/cUdmIq9G9k/CFP0
X-Gm-Message-State: AOJu0YysEvDeNRwKCrrENESTRZpWBC5JRiKSdpUQcVat9c0bH4syHcfT
	YZBlZXy0CvbsgqBTyzm2A9jtdZUDSHkzyuskCucA4FlyUdQbi5ZmicwdyQ32DFpobcw+Ekk86Pj
	1pLhYWdz6AmVs8SEPtAyQpDcl8EcWSd00IJOGyTlm98X/LRIEAmqmV8cFmjiMDg==
X-Received: by 2002:a05:6870:d287:b0:267:e2b2:ec52 with SMTP id 586e51a60fabf-2701c575da2mr11080119fac.49.1724030217406;
        Sun, 18 Aug 2024 18:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNijeH38JzYRoylQE2EDaHQsya4pFknB7VNjzjMz3uv9RcA0uMNAhd+JhGjC4VTEGgrfD3sw==
X-Received: by 2002:a05:6870:d287:b0:267:e2b2:ec52 with SMTP id 586e51a60fabf-2701c575da2mr11080105fac.49.1724030216967;
        Sun, 18 Aug 2024 18:16:56 -0700 (PDT)
Received: from [10.72.116.30] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6de9sm5930734b3a.12.2024.08.18.18.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 18:16:56 -0700 (PDT)
Message-ID: <74549d76-1187-4ed6-9589-e5978ba513d0@redhat.com>
Date: Mon, 19 Aug 2024 09:16:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ceph: Remove unused declarations
To: Yue Haibing <yuehaibing@huawei.com>, idryomov@gmail.com,
 mchangir@redhat.com, jlayton@kernel.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240814033415.3800889-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240814033415.3800889-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/14/24 11:34, Yue Haibing wrote:
> These functions is never implemented and used.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>   fs/ceph/mds_client.h            | 3 ---
>   fs/ceph/super.h                 | 2 --
>   include/linux/ceph/osd_client.h | 2 --
>   3 files changed, 7 deletions(-)
>
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 9bcc7f181bfe..585ab5a6d87d 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -559,9 +559,6 @@ extern struct ceph_mds_session *
>   ceph_get_mds_session(struct ceph_mds_session *s);
>   extern void ceph_put_mds_session(struct ceph_mds_session *s);
>   
> -extern int ceph_send_msg_mds(struct ceph_mds_client *mdsc,
> -			     struct ceph_msg *msg, int mds);
> -
>   extern int ceph_mdsc_init(struct ceph_fs_client *fsc);
>   extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);
>   extern void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc);
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 6e817bf1337c..c88bf53f68e9 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1056,8 +1056,6 @@ extern int ceph_fill_trace(struct super_block *sb,
>   extern int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>   				    struct ceph_mds_session *session);
>   
> -extern int ceph_inode_holds_cap(struct inode *inode, int mask);
> -
>   extern bool ceph_inode_set_size(struct inode *inode, loff_t size);
>   extern void __ceph_do_pending_vmtruncate(struct inode *inode);
>   
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index f66f6aac74f6..d7941478158c 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -449,8 +449,6 @@ extern int ceph_osdc_init(struct ceph_osd_client *osdc,
>   extern void ceph_osdc_stop(struct ceph_osd_client *osdc);
>   extern void ceph_osdc_reopen_osds(struct ceph_osd_client *osdc);
>   
> -extern void ceph_osdc_handle_reply(struct ceph_osd_client *osdc,
> -				   struct ceph_msg *msg);
>   extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
>   				 struct ceph_msg *msg);
>   void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb);

Reviewed-by: Xiubo Li <xiubli@redhat.com>

Thanks!



