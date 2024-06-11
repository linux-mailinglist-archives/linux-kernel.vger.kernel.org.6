Return-Path: <linux-kernel+bounces-209435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E180D903484
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD55B28A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC62172794;
	Tue, 11 Jun 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn2DLTKD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60396172BCB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092711; cv=none; b=Fcq8jqnHKtPi58Ystc/5LhFP+qaTdbg7VCzqpxgFZi0lPeOmYqM/TWfCC/kDonpzkscqLWEZ9lKiZtLgev0IR+UCOZtOYnbc1AGcCXlAHxaD/6vkvsWmAhQ4UXvNCDs648bnaUPRHR+eOpP7w1egrn7G4cAXWawPYSekmpa2gVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092711; c=relaxed/simple;
	bh=gS0WpvvHhLf09seWyadiHN5e32MV5Ce33T9yrsXhXkc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UaQHxBfR6+Z4pX3lV9zZswwsjctyHgA4bXGSFXjvxXxlX7D3jPFqfdIn/lheUnFM01W08VxJc7didRo7dEpnSoabkXrdBycrxr73nN0HHRRWd7Q+0Z1LKbOAy1+OvnEMJgTeoTh7uhrHA3/QpIzLJw0F6TZgVKXn3K4zEuziU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mn2DLTKD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718092708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NrOraijUloHUkTqzcAcD3m45+NUeaVcpXoEuUTNaX6w=;
	b=Mn2DLTKDIZ/VlaaHGN1/V5jKmfsbnPcNgephxDRUvMCmJ4ZTQk/XsLNJs38rclTMfyXsvf
	VY4S9c7VhsHSqzldb9UCJZuKw81eopbPfHRU6RuCJxaMFE5SSCid8nWCiveH33EIfMlssg
	eNozNwbsc9jicd2STNhbVHHW9ZSEFyg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-CgFE0y7EPVub0fbUD8BY5Q-1; Tue, 11 Jun 2024 03:58:24 -0400
X-MC-Unique: CgFE0y7EPVub0fbUD8BY5Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70498a5c19dso1673736b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092703; x=1718697503;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrOraijUloHUkTqzcAcD3m45+NUeaVcpXoEuUTNaX6w=;
        b=STZULkpJIl9dcR0EJEesiKyeFpUy95RdtNzHydSaCzTtVP7yuSLuJT8q59A/rutds6
         afq1qvzibEajb38oFAm4Gem8vGjLP0Qp6HUuLX+9Z9967wio8126zp68yWagpEyKlCpi
         /2WL9D3x8bwz9+fo3rlNZoTF50nueNSFjag1TrtXUamm7YSiYowE5+EvPemuSznju7h2
         WRLYJZbwFYmo2hjxYhy5L3fyKiwKSEy9pKKZH9YU4d7L/zwWGRoRH55slQwdxFQRv2H1
         qPqOQ3QV7nngICKvOr4TJrwdOTGkxSEJ5a+Ew7/NMZR2fTjxjC0ej3qYvfwijiayzG0L
         7jbw==
X-Gm-Message-State: AOJu0Yz1j9USRF8Unw0crLdFz48NXqzjrtYj8nfnv7jvaCK1Fb9ZS+BA
	NSNJnlN+iy0D8GtPxWcoIiTZTmeNXF2LdWfOi11CNUak0b74PdMkSZB89EFYR52EaPRs8FDp9WB
	1iSyIzh1s/fcnkKTrEJgxthT6n7IUtAQTz9YGih5iamZbb80n4Za3HOPynVXb1Q==
X-Received: by 2002:a05:6a00:9294:b0:704:23dc:647e with SMTP id d2e1a72fcca58-70423dc67d2mr9915554b3a.28.1718092703061;
        Tue, 11 Jun 2024 00:58:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo5s+uuhqZ2XnmWJlzV9GUM6cXkPJq6sDpLMLWl1I+yC9Au+Zd/qJiGdAMhYoBpGpvAS+Gxw==
X-Received: by 2002:a05:6a00:9294:b0:704:23dc:647e with SMTP id d2e1a72fcca58-70423dc67d2mr9915536b3a.28.1718092702501;
        Tue, 11 Jun 2024 00:58:22 -0700 (PDT)
Received: from [10.72.113.111] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70423a7f217sm5194729b3a.206.2024.06.11.00.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 00:58:22 -0700 (PDT)
Message-ID: <0d356231-d51f-4ca3-bcab-bb4c0150aa7d@redhat.com>
Date: Tue, 11 Jun 2024 15:58:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ceph/mds_client: use cap_wait_list only if debugfs is
 enabled
From: Xiubo Li <xiubli@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com,
 ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240606164157.3765143-1-max.kellermann@ionos.com>
 <a72e754a-3e72-491c-935c-ca5c1f21a8f7@redhat.com>
Content-Language: en-US
In-Reply-To: <a72e754a-3e72-491c-935c-ca5c1f21a8f7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/11/24 10:11, Xiubo Li wrote:
>
> On 6/7/24 00:41, Max Kellermann wrote:
>> Only debugfs uses this list.  By omitting it, we save some memory and
>> reduce lock contention on `caps_list_lock`.
>>
>> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
>> ---
>>   fs/ceph/caps.c       | 6 ++++++
>>   fs/ceph/mds_client.c | 2 ++
>>   fs/ceph/mds_client.h | 6 ++++++
>>   3 files changed, 14 insertions(+)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index c4941ba245ac..772879aa26ee 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -3067,10 +3067,13 @@ int __ceph_get_caps(struct inode *inode, 
>> struct ceph_file_info *fi, int need,
>>                          flags, &_got);
>>           WARN_ON_ONCE(ret == -EAGAIN);
>>           if (!ret) {
>> +#ifdef CONFIG_DEBUG_FS
>>               struct ceph_mds_client *mdsc = fsc->mdsc;
>>               struct cap_wait cw;
>> +#endif
>>               DEFINE_WAIT_FUNC(wait, woken_wake_function);
>>   +#ifdef CONFIG_DEBUG_FS
>>               cw.ino = ceph_ino(inode);
>>               cw.tgid = current->tgid;
>>               cw.need = need;
>> @@ -3079,6 +3082,7 @@ int __ceph_get_caps(struct inode *inode, struct 
>> ceph_file_info *fi, int need,
>>               spin_lock(&mdsc->caps_list_lock);
>>               list_add(&cw.list, &mdsc->cap_wait_list);
>>               spin_unlock(&mdsc->caps_list_lock);
>> +#endif // CONFIG_DEBUG_FS
>>                 /* make sure used fmode not timeout */
>>               ceph_get_fmode(ci, flags, FMODE_WAIT_BIAS);
>> @@ -3097,9 +3101,11 @@ int __ceph_get_caps(struct inode *inode, 
>> struct ceph_file_info *fi, int need,
>>               remove_wait_queue(&ci->i_cap_wq, &wait);
>>               ceph_put_fmode(ci, flags, FMODE_WAIT_BIAS);
>>   +#ifdef CONFIG_DEBUG_FS
>>               spin_lock(&mdsc->caps_list_lock);
>>               list_del(&cw.list);
>>               spin_unlock(&mdsc->caps_list_lock);
>> +#endif
>>                 if (ret == -EAGAIN)
>>                   continue;
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index c2157f6e0c69..62238f3e6e19 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -5505,7 +5505,9 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>>       INIT_DELAYED_WORK(&mdsc->delayed_work, delayed_work);
>>       mdsc->last_renew_caps = jiffies;
>>       INIT_LIST_HEAD(&mdsc->cap_delay_list);
>> +#ifdef CONFIG_DEBUG_FS
>>       INIT_LIST_HEAD(&mdsc->cap_wait_list);
>> +#endif
>>       spin_lock_init(&mdsc->cap_delay_lock);
>>       INIT_LIST_HEAD(&mdsc->cap_unlink_delay_list);
>>       INIT_LIST_HEAD(&mdsc->snap_flush_list);
>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>> index cfa18cf915a0..13dd83f783ec 100644
>> --- a/fs/ceph/mds_client.h
>> +++ b/fs/ceph/mds_client.h
>> @@ -416,6 +416,8 @@ struct ceph_quotarealm_inode {
>>       struct inode *inode;
>>   };
>>   +#ifdef CONFIG_DEBUG_FS
>> +
>>   struct cap_wait {
>>       struct list_head    list;
>>       u64            ino;
>> @@ -424,6 +426,8 @@ struct cap_wait {
>>       int            want;
>>   };
>>   +#endif // CONFIG_DEBUG_FS
>> +
>>   enum {
>>       CEPH_MDSC_STOPPING_BEGIN = 1,
>>       CEPH_MDSC_STOPPING_FLUSHING = 2,
>> @@ -512,7 +516,9 @@ struct ceph_mds_client {
>>       spinlock_t    caps_list_lock;
>>       struct        list_head caps_list; /* unused (reserved or
>>                           unreserved) */
>> +#ifdef CONFIG_DEBUG_FS
>>       struct        list_head cap_wait_list;
>> +#endif
>>       int        caps_total_count;    /* total caps allocated */
>>       int        caps_use_count;      /* in use */
>>       int        caps_use_max;         /* max used caps */
> Reviewed-by: Xiubo Li <xiubli@redhat.com>

Applied to the 'testing' branch and renamed the title to "ceph: use 
cap_wait_list only if debugfs is enabled"

Thanks

- Xiubo



