Return-Path: <linux-kernel+bounces-317041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B8096D884
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949EA1F27602
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A119D062;
	Thu,  5 Sep 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nzmf0kDd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E527702
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539228; cv=none; b=oOEoL0vRM9xXn3zEUti1OocrHpoNkULpaMEXjWQZT5LCIQCZ+1R1clqD4A9eDW8U9ZZvTYG/ER5MdN2RCl2wMtOLE0WEGx0vaYp5mabfkhdIP2uGM2qPTQ/uJfTrd8XsVZgCo/jfnzdVN1BuR3A/+WyMLhsGidZdq3llkk/sicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539228; c=relaxed/simple;
	bh=4mdg1nwvT1DrwbjriC7JRd5dfHVgOWrIZPDcG2uv23A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaZoQnFIPBvw1S4YywFhcJsSl8hJaBpkICndJ8ildT3cqn7nmgMSD4dpzYJQf97CAyPw2jIyckRaNzW9qfT720Ksd03GNWd3cUtYNeU+gQeIdJXAFuDzCetkaIBbOIRfj8thEXvBFTAzHbbOGQGbclyUeQ9Aezg84gGsVcD63G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nzmf0kDd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725539226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqUob9eNFTZnnwWbmbAbUvBPblwA8G9XBXjHJfcmBuI=;
	b=Nzmf0kDd0Ry8FrW45nzbjZ1WTsT3Q2hu4MEs6Ot1xum7Ka/aFLXf8kG7npbHKM/vaKkz4k
	FLM3kzpg2qyNTzIFuHj/G4fENJZu9JYrUu3VZ1knLypWLk+tgllblf112AC4ooXiakI1KB
	5pJdukd8JV9oFVzhRyLmV9T+rJW95rw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-10UelAvDMISa7PMjzxN1_g-1; Thu, 05 Sep 2024 08:27:04 -0400
X-MC-Unique: 10UelAvDMISa7PMjzxN1_g-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-206b912491eso22582305ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539224; x=1726144024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqUob9eNFTZnnwWbmbAbUvBPblwA8G9XBXjHJfcmBuI=;
        b=Tf+dLg5ZZyGp7bnhTmVhvUf2YHPvjJM7t3HDdUoOe5rfpKi74fN6QBZktLWY5/kwQQ
         gmwbR/hlBV+FsumtmTVOBh5xsomFwE/d9GoHn3FNGNbFEv3R/m0iTv173UAZxkFHqHus
         Qrteiiqq1RpskUGnHElX13CTqOInEVQaNRQ5nOmfzT/3P5jjbRKjnmUboWICVe6TMICZ
         faPknmJ87hKRLLWSz/l0EDxcHbhzGOHZUn9EMwnR6eGlGrgwHlJObXEe7wL4u51gpLTv
         XuLc1AbLE3XktL6mfIS/vOmlmMd7shdHolO+lhNjgXF9qJNvvzkaXF3GU0/xGyexRq4R
         Gx9w==
X-Gm-Message-State: AOJu0Yw1H1HwkCE1KNmwcr7WCzTRzbEqdP247iXhJAPJAbIdwzSfXSN8
	t3YGS0nwU3gHXdku/LSe4RPhy1fUj/LAHhFy5R4FpT9QP7xUW12Q6IlRD87lsVMdRMAIzjcnosx
	nkjc/Eqoj4G70m0Jj3BTKZGx2jLHN34BkjIvJ32KCBmbxMO5NFixm1xZbAHm/QA==
X-Received: by 2002:a17:902:ccc7:b0:205:5284:e510 with SMTP id d9443c01a7336-206b7d00211mr97947765ad.1.1725539223763;
        Thu, 05 Sep 2024 05:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyv8jZJARZUzr0mKpTw3Brc1yRPzDO0MkILUdmrgbmnCoAYYaR38v5h7pWsys9yiKcuLAnJA==
X-Received: by 2002:a17:902:ccc7:b0:205:5284:e510 with SMTP id d9443c01a7336-206b7d00211mr97947395ad.1.1725539223323;
        Thu, 05 Sep 2024 05:27:03 -0700 (PDT)
Received: from [10.72.116.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea532d3sm27960075ad.191.2024.09.05.05.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 05:27:02 -0700 (PDT)
Message-ID: <4730b8a2-7328-4a36-865c-be8ae1e064b2@redhat.com>
Date: Thu, 5 Sep 2024 20:26:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ceph: Fix typo in the comment
To: Yan Zhen <yanzhen@vivo.com>, idryomov@gmail.com
Cc: linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240905113227.1230764-1-yanzhen@vivo.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240905113227.1230764-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yan Zhen,

Thanks for your patch.

Next time please to or cc ceph-devel@vger.kernel.org list, or the mails 
could be missed.

On 9/5/24 19:32, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
>
> replace 'tagert' with 'target' in the comment &
> replace 'vaild' with 'valid' in the comment &
> replace 'carefull' with 'careful' in the comment &
> replace 'trsaverse' with 'traverse' in the comment.
>
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>   fs/ceph/caps.c       | 2 +-
>   fs/ceph/dir.c        | 2 +-
>   fs/ceph/inode.c      | 2 +-
>   fs/ceph/mds_client.c | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 6561a6cd9..4aaaa26de 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -4150,7 +4150,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>   		ceph_remove_cap(mdsc, cap, false);
>   		goto out_unlock;
>   	} else if (tsession) {
> -		/* add placeholder for the export tagert */
> +		/* add placeholder for the export target */
>   		int flag = (cap == ci->i_auth_cap) ? CEPH_CAP_FLAG_AUTH : 0;
>   		tcap = new_cap;
>   		ceph_add_cap(inode, tsession, t_cap_id, issued, 0,
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 18c72b305..e23f8a40f 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -2059,7 +2059,7 @@ static int ceph_d_delete(const struct dentry *dentry)
>   		return 0;
>   	if (ceph_snap(d_inode(dentry)) != CEPH_NOSNAP)
>   		return 0;
> -	/* vaild lease? */
> +	/* valid lease? */
>   	di = ceph_dentry(dentry);
>   	if (di) {
>   		if (__dentry_lease_is_valid(di))
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 4a8eec462..315ef02f9 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1779,7 +1779,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
>   		if (err < 0)
>   			goto done;
>   	} else if (rinfo->head->is_dentry && req->r_dentry) {
> -		/* parent inode is not locked, be carefull */
> +		/* parent inode is not locked, be careful */
>   		struct ceph_vino *ptvino = NULL;
>   		dvino.ino = le64_to_cpu(rinfo->diri.in->ino);
>   		dvino.snap = le64_to_cpu(rinfo->diri.in->snapid);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 276e34ab3..1a1e71f20 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4910,7 +4910,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
>   	} else {
>   		recon_state.msg_version = 2;
>   	}
> -	/* trsaverse this session's caps */
> +	/* traverse this session's caps */
>   	err = ceph_iterate_session_caps(session, reconnect_caps_cb, &recon_state);
>   
>   	spin_lock(&session->s_cap_lock);

LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>



