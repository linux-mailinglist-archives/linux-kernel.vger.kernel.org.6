Return-Path: <linux-kernel+bounces-562822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1569A6335D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 03:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4183B14A4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C0839ACC;
	Sun, 16 Mar 2025 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGSuo9jL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35619376
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742092607; cv=none; b=RX7fko3apj4rDd/pxjpWvvDca52s4hYk9Bcmts08JNG3URj7lMmXN1MykBViH4HAxTHCgN7RMNMZrY9PgHATLRNuR/IX+9EItHgzqE7PpGwYulz9NwivitAwgiSb8yw63VB+09MUr79d/tRG5H4Q4KATrlUXXnZccynnkny3ofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742092607; c=relaxed/simple;
	bh=rgsohwfd76T3iZ6/taL0SEHla+2AjE/cv/Q5/d2KtRg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cOaE8LNgSkoNeEsQgoQ5Z7CA3tmXYa0bAP4V65zNBsA/p4MGh0QQgEDYRyGdKCqI3Pw6sPXrLHEIigrE5Tzw7Z0JT7ZG7b2gSafVFWCnWiJb61104yz53Yxi2FgXicXa01MKO3nHS0zExxNcp+zSklR7dwZwEvG43Qa89NYjbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGSuo9jL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EA4C4CEE5;
	Sun, 16 Mar 2025 02:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742092605;
	bh=rgsohwfd76T3iZ6/taL0SEHla+2AjE/cv/Q5/d2KtRg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EGSuo9jLl8CKjvcyN6/wLezqmR2YfvsbvYWCqZQ0IWtOxDczGQjQP3BMOUo/C7UgL
	 dJEowcCVYoNuDvPWSN/8Xjx/0uYKpa8zQKIUl4WXs9/kOybnCISHH3KUzdemv8XUjm
	 YHM1w4Jw2aisBJRewkLN01F3+iTZx+6+kIQ140/hGy0sVAmj48iC392d+h4BMHlkjL
	 wIA/1NyatH0OdJSfMMkSH26t3abiQ7Bp229MCxPz8DHagihNw0xDFfFd4KhcG4QN03
	 wgtFLMXDSgP2rc5N23TgJoqrCLeFt8d/HJn9J/QmSXNgGb5j6+JnDA0b5HPDwxGde8
	 3ClILjaLY5bxg==
Message-ID: <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
Date: Sun, 16 Mar 2025 10:36:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/10 11:29, Hongzhen Luo wrote:
> There's no need to enumerate each type.  No logic changes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Looks good to me, feel free to add:

Reviewed-by: Chao Yu <chao@kernel.org>

And one minor comment below.

> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 689437e99a5a..d278ebd60281 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -265,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   		if (err)
>   			return err;
>   
> -		switch (m->type) {
> -		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
> +		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> +			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> +				  m->type, lcn, vi->nid);
> +			DBG_BUGON(1);
> +			return -EOPNOTSUPP;
 > +		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {>   			lookback_distance = m->delta[0];
>   			if (!lookback_distance)
> -				goto err_bogus;
> +				break;
>   			continue;
> -		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> -		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> -		case Z_EROFS_LCLUSTER_TYPE_HEAD2:
> +		} else {
>   			m->headtype = m->type;
>   			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>   			return 0;
> -		default:
> -			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> -				  m->type, lcn, vi->nid);
> -			DBG_BUGON(1);
> -			return -EOPNOTSUPP;

Should return EFSCORRUPTED here? is m->type >= Z_EROFS_LCLUSTER_TYPE_MAX a possible
case?

Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
then we can treat m->type as reliable variable later.

	advise = le16_to_cpu(di->di_advise);
	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
		...
		DBG_BUGON(1);
		return -EFSCORRUPTED;
	}

Thanks,

>   		}
>   	}
> -err_bogus:
>   	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
>   		  lookback_distance, m->lcn, vi->nid);
>   	DBG_BUGON(1);
> @@ -329,35 +325,28 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   	DBG_BUGON(lcn == initial_lcn &&
>   		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
>   
> -	switch (m->type) {
> -	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> -	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
> +	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> +		if (m->delta[0] != 1) {
> +			erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> +			DBG_BUGON(1);
> +			return -EFSCORRUPTED;
> +		}
> +		if (m->compressedblks)
> +			goto out;
> +	} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
>   		/*
>   		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
>   		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
>   		 */
>   		m->compressedblks = 1;
> -		break;
> -	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
> -		if (m->delta[0] != 1)
> -			goto err_bonus_cblkcnt;
> -		if (m->compressedblks)
> -			break;
> -		fallthrough;
> -	default:
> -		erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn,
> -			  vi->nid);
> -		DBG_BUGON(1);
> -		return -EFSCORRUPTED;
> +		goto out;
>   	}
> +	erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> +	DBG_BUGON(1);
> +	return -EFSCORRUPTED;
>   out:
>   	m->map->m_plen = erofs_pos(sb, m->compressedblks);
>   	return 0;
> -err_bonus_cblkcnt:
> -	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> -	DBG_BUGON(1);
> -	return -EFSCORRUPTED;
>   }
>   
>   static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
> @@ -386,9 +375,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>   				m->delta[1] = 1;
>   				DBG_BUGON(1);
>   			}
> -		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
> -			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
> -			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
> +		} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
>   			if (lcn != headlcn)
>   				break;	/* ends at the next HEAD lcluster */
>   			m->delta[1] = 1;
> @@ -452,8 +439,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>   		}
>   		/* m.lcn should be >= 1 if endoff < m.clusterofs */
>   		if (!m.lcn) {
> -			erofs_err(inode->i_sb,
> -				  "invalid logical cluster 0 at nid %llu",
> +			erofs_err(inode->i_sb, "invalid logical cluster 0 at nid %llu",
>   				  vi->nid);
>   			err = -EFSCORRUPTED;
>   			goto unmap_out;
> @@ -469,8 +455,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>   			goto unmap_out;
>   		break;
>   	default:
> -		erofs_err(inode->i_sb,
> -			  "unknown type %u @ offset %llu of nid %llu",
> +		erofs_err(inode->i_sb, "unknown type %u @ offset %llu of nid %llu",
>   			  m.type, ofs, vi->nid);
>   		err = -EOPNOTSUPP;
>   		goto unmap_out;


