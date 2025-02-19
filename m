Return-Path: <linux-kernel+bounces-522721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 113E1A3CDC3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B811890A43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674CC25E479;
	Wed, 19 Feb 2025 23:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Uh5xP2O"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E91C1F13
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008862; cv=none; b=EswSpVZcsp1YaiTeBCMcxt1BkLrtBdgJ12jwWNjikbwSaMsiJp4woOKt16Kk+m+i6ekTlM4cyVmjfUjZB6Pf+GgT25Xspn0kwO9VI1SeU4e7thMNbgxgx8CYXrJSZ71hGtKdGIUtS9sVzZQEiEfeTBNj6R821n9kNI8gk/kG+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008862; c=relaxed/simple;
	bh=UwUuwdukqezMT4zNFsZB2G1bJ/KiWJbSnKOhjVLNBmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLKmat4fM1GnRq5tL8tmvtzeM6iFVoCTzIt/Q1gH8xFvX+Zz9jns7kSaVDky41OpXs78BelScu40QnFBmw75VK60+fma92FCOq/Eo7zFfEx2Uj1EHzMi5eU9+x18An+i1wC2FslhavKW2Z5Xh9orTZ9X5awfN/hwJUkDMUltdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Uh5xP2O; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22117c396baso37855ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740008860; x=1740613660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7EDgb9ixmcxW5HDhsD7poMpSDgYXVSUp8X6oXzf45dg=;
        b=3Uh5xP2OXM2kvwkDLr4Wq4JT+d3yAaz0Z9KwPBYizh+NFwyWcA2RfPPC1Zju4+KKtx
         CXCiQZSU9uhkf1ZG4KO4NiQlg6U8n/3EGYcpD0pUFI2V5vYjWEgwK9RYaGKfvd0iJ7JW
         H71r7lmdI9GodL4ehceXVxlSHGuPxExL7MTL1XPN506nG1OO7W2ivC8eobTSHj2cYEwy
         ylyBW/nvNONOuiI4FfWUWSzABAzeBpdN/s96fRnsdaLVfLwY1Bpbep6vCmKaaMBxRVZh
         TJAlxdm2iyuDhLaAx4VLlwN/2qQY99Fb8Mf6scmCRsW8qBXyVQap6imhaIVCEFc0R+B3
         BqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740008860; x=1740613660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EDgb9ixmcxW5HDhsD7poMpSDgYXVSUp8X6oXzf45dg=;
        b=Alw6OX9DR1b/6mpFgmN14YtZMAUFe2QLvXsULpWB45yzPNp/gFw0vDIHGYswCoCD6O
         SGNCGXh0iMyB9x9JVMWgctOQWjT6B2QZ9ZKusxuePi+R+kuU/tUpGmCdc6cxEi/riO7t
         1kcQnjDpHNxgoZfoAAGNYItAq9m+C8FH6xtOTbFHBagJNm8nYVvmUANIl/bQcNp3TTes
         FlNX3RUzL375+9GVWNGdVUpFr1fpmFk26kBk6jVrCniQj9DZRc3sMJ65/jKrpj81PbLP
         dawSjN6pUUEbBc+b3pxP+D4iY7oVj6/j1N7Ma1BkrQiaclimwlRk4d/BJibALw4ebJfe
         Ah/w==
X-Forwarded-Encrypted: i=1; AJvYcCWEf7OvLM455D/wBpX9KAuNcxB1q1QWb2acHZVkGWPjaUbsDEU3BIFwcJFSVCBN3rcgch7v4SZ6obdsDbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQIpwrUbYnCx7PwYnKrkRDU2xy7zpcGveyfaMVxHMVIm7o/Xb
	qewp/ownVX5wQ5zl4L/6KdhrOv2IeDplGwjAndNv25bX83KXGX0A7yk42RrGBg==
X-Gm-Gg: ASbGnctqxoSI4yq+mp8CqaCJRRS4lhxhPf4XWJVaOI0IZVw9wr2OBJCLNY+rBX2621c
	LJtOcSLyCtaaAKS9s+Ee3oNKXtVczSRsnPdyr9ouZZWpQZrZ1a0ERdflVDBrKkXr0VtnpMo6v/D
	eusMdMqEMamFgZv2ZsWLU6+HgDfwjVqeRJP6vr8I4Kfz2jAc4TTZeYYmv+qeBRCDGVmK2le0cQI
	tASTUW3Jt4bXrJlzdtFD0+g4++F+WqPAenKSbf3smjo5VS2jG9ac6zV46ZYLsn5ocdzdUWqkAaj
	TXMajHyQ5Awz4z7AzQCCBK9bLEPrWZDzFX0SJLUi9HjHQqLURfnnIIJA2Ik=
X-Google-Smtp-Source: AGHT+IG0hr/jG6j1sf+wqHDPRpxr2FFnc0Et7UEElKQxjMSSSyeVPZKlgXTKJB1uWFrEjnPtBHR0Yg==
X-Received: by 2002:a17:902:d48e:b0:215:79b5:aa7e with SMTP id d9443c01a7336-2218ff9e8a0mr489615ad.13.1740008859704;
        Wed, 19 Feb 2025 15:47:39 -0800 (PST)
Received: from google.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2217eb0e503sm12269545ad.62.2025.02.19.15.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:47:38 -0800 (PST)
Date: Wed, 19 Feb 2025 23:47:34 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Akilesh Kailash <akailash@google.com>, kernel-team@android.com,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Milan Broz <gmazyland@gmail.com>, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dm-verity: do forward error correction on metadata
 I/O errors
Message-ID: <20250219234734.GA758416@google.com>
References: <920de20f-1d11-e6f6-e7ae-a774f5c210f0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <920de20f-1d11-e6f6-e7ae-a774f5c210f0@redhat.com>

On Mon, Feb 17, 2025 at 10:36:02PM +0100, Mikulas Patocka wrote:
> dm-verity: do forward error correction on metadata I/O errors
> 
> Do forward error correction if metadata I/O fails.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  drivers/md/dm-verity-target.c |   25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/md/dm-verity-target.c
> ===================================================================
> --- linux-2.6.orig/drivers/md/dm-verity-target.c	2025-02-10 16:24:56.000000000 +0100
> +++ linux-2.6/drivers/md/dm-verity-target.c	2025-02-17 16:47:37.000000000 +0100
> @@ -311,7 +311,7 @@ static int verity_verify_level(struct dm
>  
>  	if (static_branch_unlikely(&use_bh_wq_enabled) && io->in_bh) {
>  		data = dm_bufio_get(v->bufio, hash_block, &buf);
> -		if (data == NULL) {
> +		if (IS_ERR_OR_NULL(data)) {

Thanks for adding the check, makes this easier to follow.

>  			/*
>  			 * In tasklet and the hash was not in the bufio cache.
>  			 * Return early and resume execution from a work-queue
> @@ -324,8 +324,24 @@ static int verity_verify_level(struct dm
>  						&buf, bio->bi_ioprio);
>  	}
>  
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> +	if (IS_ERR(data)) {
> +		if (skip_unverified)
> +			return 1;
> +		r = PTR_ERR(data);
> +		data = dm_bufio_new(v->bufio, hash_block, &buf);
> +		if (IS_ERR(data))
> +			return r;
> +		if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_METADATA,
> +				      hash_block, data) == 0) {
> +			aux = dm_bufio_get_aux_data(buf);
> +			aux->hash_verified = 1;
> +			goto release_ok;
> +		} else {
> +			dm_bufio_release(buf);
> +			dm_bufio_forget(v->bufio, hash_block);
> +			return r;
> +		}
> +	}
>  
>  	aux = dm_bufio_get_aux_data(buf);
>  
> @@ -366,6 +382,7 @@ static int verity_verify_level(struct dm
>  		}
>  	}
>  
> +release_ok:
>  	data += offset;
>  	memcpy(want_digest, data, v->digest_size);
>  	r = 0;
> @@ -1761,7 +1778,7 @@ static struct target_type verity_target
>  	.name		= "verity",
>  /* Note: the LSMs depend on the singleton and immutable features */
>  	.features	= DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
> -	.version	= {1, 10, 0},
> +	.version	= {1, 11, 0},
>  	.module		= THIS_MODULE,
>  	.ctr		= verity_ctr,
>  	.dtr		= verity_dtr,

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

