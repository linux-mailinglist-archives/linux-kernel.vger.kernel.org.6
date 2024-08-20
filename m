Return-Path: <linux-kernel+bounces-293367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD6D957E52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8DC1C2379E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10070360;
	Tue, 20 Aug 2024 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ecli/CT9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613EB1E3CBB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135630; cv=none; b=tZJrF3vOzKhOtIGd93ZU/zVI68Lb4lvehFCli9NVzJ44UqVmzoykbjSog5itdHNf18m7zzQfyApuYeKF14Yf2bcf44+YR50uB0u95iF3CMWNc/6nb+ObsHRyYlTEt6z5gL1T/Dex/vX/7IqU93XiQm5azhGCp19CcbetfhWfTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135630; c=relaxed/simple;
	bh=s6oLVLudE3Hlrcb3NSM12n/aL0wm6duShgC7tYMwKjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMD+h6FstcsXFvUORvpszv88/5nNsL8aD/BW/e0EP6F829jmXi3pG4z5tGNfMIBvr3fa9QjZxJRpCYVFjQcyiEBmqVdFqbZXeI3mCGHCJwDQBKpazmFHydLwWaJSPb7Wz8EQVsg76IN4tVo/TsNv3NDWGHwHMqYJ7FPxrB1e48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ecli/CT9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724135627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxu/JaDhP8Y+hBmSZIP+97DXMICgK3G2N7aESVf67vs=;
	b=Ecli/CT9Eue15Yy7IQxrQVQaDbkZ0w1oIQ4qlliT/HL/cE8oGXmN1LFvpPN739haM7OLpO
	4Lq+Ru00MPSoM8dcSI7JCA9xc1J6c2rvwFX15IzZMOpXVNeDcMxrQSiY5d1N6rIwDPc8Dd
	fQdYP51HR5LnRyF1IzVDYMQThcDGaH0=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-TzEi2IN0OuqVLobzDGu2MQ-1; Tue, 20 Aug 2024 02:33:45 -0400
X-MC-Unique: TzEi2IN0OuqVLobzDGu2MQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-270183411aaso4033142fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724135624; x=1724740424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxu/JaDhP8Y+hBmSZIP+97DXMICgK3G2N7aESVf67vs=;
        b=b/G3bzqvpiGaoxRRSnN69kuLprj0+Z4V1pJojVx7zltmEF0XzskB879VAQXlXnrI9m
         P2jPJOX1OUccg7/yUSZ0b2mbNDwCbvKcdxIzXk+wSYOvwnJVS5zWnyD5+7cbUe3nFOB1
         JO+K5W4KR4X0R9RryYMhV9opnv8NThFxUJEMf8rX855LQ+GuiBU/advp4dS5LPg9A3y8
         LE/lEVYAhtgYaVc+hh0+e+sydOCI21Mdut6kZlQX2kca4g8rzQyDHsPj/taR4spj72P3
         Y+kv8Mpbq4HLbP/Op6Q02XJ8gD/DDBVzkjwn1dlrO89f0GK1MxUCrnBwHBCWIT5JnJk9
         PDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhHqkt+1R/HXfPKDDBLSj22JhEnAaDFTcbjtz1gKJHuv1WO2vQdERGw02XZayQsrjCgkSaxhe29iSgHpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTx4f5jwy41EyH0IbWtdWYhhBQ8/b44N9JLaa40S27/NB0dMnd
	tTGLhsO2k6U7EL41KbtdTU/4rrwW387xJ/RBanCvf2WuSnCPYREJNZU8Xo4B2V0d90/aW3mvRsk
	KUBiUFNkzdH7aJuzve0cVGXONi2X91EaHww5YhGXs4gjito/xkcB3mjN4i3OViw==
X-Received: by 2002:a05:6870:c18e:b0:261:1600:b1eb with SMTP id 586e51a60fabf-2701c5a0f1amr15718602fac.31.1724135624502;
        Mon, 19 Aug 2024 23:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8KkMFHadnq0O47HFRRH7mfcRoBRFl5n5bs0K+MpLyDgPkvJUq6Qf7YTL/Zl0oYygtgXFAZQ==
X-Received: by 2002:a05:6870:c18e:b0:261:1600:b1eb with SMTP id 586e51a60fabf-2701c5a0f1amr15718588fac.31.1724135624177;
        Mon, 19 Aug 2024 23:33:44 -0700 (PDT)
Received: from [10.72.116.30] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c691csm8591114a12.21.2024.08.19.23.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 23:33:43 -0700 (PDT)
Message-ID: <cb360270-caf1-4128-918a-59b1bb6ab2d3@redhat.com>
Date: Tue, 20 Aug 2024 14:33:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs, ceph: Partially revert "netfs: Replace PG_fscache
 by setting folio->private and marking dirty"
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Max Kellermann <max.kellermann@ionos.com>,
 Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <2181767.1723665003@warthog.procyon.org.uk>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <2181767.1723665003@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/15/24 03:50, David Howells wrote:
>      
> This partially reverts commit 2ff1e97587f4d398686f52c07afde3faf3da4e5c.
>
> In addition to reverting the removal of PG_private_2 wrangling from the
> buffered read code[1][2], the removal of the waits for PG_private_2 from
> netfs_release_folio() and netfs_invalidate_folio() need reverting too.
>
> It also adds a wait into ceph_evict_inode() to wait for netfs read and
> copy-to-cache ops to complete.
>
> Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private and marking dirty")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Max Kellermann <max.kellermann@ionos.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Xiubo Li <xiubli@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: ceph-devel@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e5ced7804cb9184c4a23f8054551240562a8eda [2]
> ---
>   fs/ceph/inode.c |    1 +
>   fs/netfs/misc.c |    7 +++++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 71cd70514efa..4a8eec46254b 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -695,6 +695,7 @@ void ceph_evict_inode(struct inode *inode)
>   
>   	percpu_counter_dec(&mdsc->metric.total_inodes);
>   
> +	netfs_wait_for_outstanding_io(inode);
>   	truncate_inode_pages_final(&inode->i_data);
>   	if (inode->i_state & I_PINNING_NETFS_WB)
>   		ceph_fscache_unuse_cookie(inode, true);
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 83e644bd518f..554a1a4615ad 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -101,6 +101,8 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
>   
>   	_enter("{%lx},%zx,%zx", folio->index, offset, length);
>   
> +	folio_wait_private_2(folio); /* [DEPRECATED] */
> +
>   	if (!folio_test_private(folio))
>   		return;
>   
> @@ -165,6 +167,11 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
>   
>   	if (folio_test_private(folio))
>   		return false;
> +	if (unlikely(folio_test_private_2(folio))) { /* [DEPRECATED] */
> +		if (current_is_kswapd() || !(gfp & __GFP_FS))
> +			return false;
> +		folio_wait_private_2(folio);
> +	}
>   	fscache_note_page_release(netfs_i_cookie(ctx));
>   	return true;
>   }
>
Tested it and worked fine.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Tested-by: Xiubo Li <xiubli@redhat.com>

Thanks



