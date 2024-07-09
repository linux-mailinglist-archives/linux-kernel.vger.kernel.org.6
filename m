Return-Path: <linux-kernel+bounces-245581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94D692B497
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514C41F22A1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA015624B;
	Tue,  9 Jul 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FOp4W4pN"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64161137776
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519269; cv=none; b=sX6Tz4lDYwMqbsRwOTVlmevi3iLmtbZMyr0bwv3nCpCJi6+O/M6LPi28MW3f4Y6s7hsWKdPgnFpSsh+xp59edgHPbwhZ2HanS40kJ93WNJ+rrhQuDZPjOQXB9ixYZEbTxdpTpLEvsxk/Bx/sdkRnqdvW6zSA1uQZmUPTvZN6Ibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519269; c=relaxed/simple;
	bh=9ueNuiutMQdYjBBVy8y/1iLagBTJT4VLnrJ3yrSnyh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im/jhLAKThTnt2Ad/hmc+hfLbfQ+nu4FgmryrOZoz1qg7JE9bIz7rtKIbwI5Mc9nV4plnWsMH5B2GhT203ko7Bjs0b6OjkrUeK0DJts+PRoAwPK0eX3JVGKuvZHZpECeaABCXrvjct+kgcr7GORc5j0TAKa4qFrX/GIid2NsDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FOp4W4pN; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c661bcb9a0so1296163eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720519267; x=1721124067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6GqL4s/zuXrjlFTwp5KKRhkQcfRKfIo4KZZ76Fh4W0=;
        b=FOp4W4pNCbku8D4/48FIbhZxyuOaWcLTx8jsX73lkzQu7RZQYCPNVLPSOozHNG+erx
         xoWuvh9LtyTvnHFm0RHMibAOUAlSfqOa1oqk2wwyZ5uSX4CQNJdskWi42NG8wQGgXKM1
         WtPByeCmdq3hnzztU286o/QI7UJU0uOP4kAn5FVqkIvvw+iEq7YtFvSUY6z346BppSAX
         vzFbjf3kPyQ7AI7jemlKa40lUfJ+QDB5NfUTEmcvUEqdVPyhKxrrW0dcwm5JrfLdGEwZ
         TjY+aGb1cShwgSEeqUK2ZMzIo8VW5JczDeAlm1Ajwej70CTxp3ac7Gl/c+izhOjqNZbl
         J0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720519267; x=1721124067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6GqL4s/zuXrjlFTwp5KKRhkQcfRKfIo4KZZ76Fh4W0=;
        b=lST+5IUFn2XPotzYy1fyG5bxkO+GKHePrf0eBSH50SFwWU1FsGD6Ban44u5yY5kSEn
         wJrrlm0SdE+ZZnHF5to/Td3D/Mm745lDHjUNLhRkhoaikX5iZU3s36z65gioyoVqfU94
         dgs2d/6EvWYpYyt+K/Ug+DgsIkc0wPDOHX3gogpPUX+0AdsnWrFoQpenH+2yOkzHvZpv
         LKe7siUfEROaV2XeGlDfaosI3EsP73XPMGcOisWZJvUrKqmq+hOKoCd7E0q80E3lwNRN
         2EMI9VBmlO3jVL2mCsFk+N2iokBomjxRhHIYzuq1CaRxX3B2qOf/eMMT90BK6iPKI9GR
         bsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjdO1RLTKCWSb/9spA+lSxSxWYEbZRnwGfm/BVq4xBsoihjA2JkIMstVsZ3jW1gkY+UIU7iEMqljs4QgJpX4s2gPCrUAFBbceSUPj8
X-Gm-Message-State: AOJu0Yz2kMx2XrR9kH55yu9SnW+Z+R5bsNoYEWtsfkILWFQpmdAYJnO8
	0870Xni+MM11Imlxe4wmEOcA7BCb58Gy0XHfd1yXMJLorCD7xmkPLeXAZBFBUb4=
X-Google-Smtp-Source: AGHT+IERY7UIVBrMpT7+BBj6ED5PP+BktYSZv+kPxdgPSWPDwoYLpTkI5YLbdH8OsoiJfGDfZanlJw==
X-Received: by 2002:a05:6870:9727:b0:24c:b654:c17a with SMTP id 586e51a60fabf-25eaec07747mr1516360fac.45.1720519267437;
        Tue, 09 Jul 2024 03:01:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4389c175sm1440814b3a.12.2024.07.09.03.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:01:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sR7ei-009ZO2-1I;
	Tue, 09 Jul 2024 20:01:04 +1000
Date: Tue, 9 Jul 2024 20:01:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: chandan.babu@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: convert comma to semicolon
Message-ID: <Zo0KYMJkWYirUx1R@dread.disaster.area>
References: <20240709073632.1152995-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709073632.1152995-1-nichen@iscas.ac.cn>

On Tue, Jul 09, 2024 at 03:36:32PM +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.

Fixes: 8f4b980ee67f ("xfs: pass the attr value to put_listent when possible")

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  fs/xfs/xfs_attr_list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
> index 5c947e5ce8b8..7db386304875 100644
> --- a/fs/xfs/xfs_attr_list.c
> +++ b/fs/xfs/xfs_attr_list.c
> @@ -139,7 +139,7 @@ xfs_attr_shortform_list(
>  		sbp->name = sfe->nameval;
>  		sbp->namelen = sfe->namelen;
>  		/* These are bytes, and both on-disk, don't endian-flip */
> -		sbp->value = &sfe->nameval[sfe->namelen],
> +		sbp->value = &sfe->nameval[sfe->namelen];
>  		sbp->valuelen = sfe->valuelen;
>  		sbp->flags = sfe->flags;
>  		sbp->hash = xfs_attr_hashval(dp->i_mount, sfe->flags,

Looks good,

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

