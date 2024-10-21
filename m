Return-Path: <linux-kernel+bounces-375295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66749A944C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57A11C22A87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5697020010C;
	Mon, 21 Oct 2024 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Kzfj3jpq"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891281FF5FE
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553993; cv=none; b=QI6OzJ2w4DENPAAQFpgrsXO9kCQGITdqVgZwu74bRFhXdTMD86fH3B/yUyhAf8riLG2mHRe6jFMjUTOefE4NHBu7UenqlXWcSxR2ZNABq5h4sfB08eGnHsdUhg+p0blFBcw1H6E+5AMtusIeM0u+2eHmTAZWvuHS+ViYJOQwt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553993; c=relaxed/simple;
	bh=q1QmvXn6GwPcneGjGwPv0xmS4RRUjRFacDa92Vsp7Kw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=eEgPQjn3KElr3H+lJAdRpo1ne0SHwTcngYJCrJqt3DR5VOHxFwrAmblmUXdq6WQ/7Uj+mPLckNdu/XVR1LbBHN7S46dRIV7soOXVKeACZmQD1j7p7NVUf5zbVNuScb20kIHzU2U06pEm8QikNXTibKSTCOILczNCx/BSkYz4MHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Kzfj3jpq; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b155cca097so329455085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729553990; x=1730158790; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7tHUckLE/MLiHUlkx0kAjj3yltxCb3kfPASiHLjhco=;
        b=Kzfj3jpq5Gs6Iyof3iA7rovfU2wLkd9Tl9jotb42aKAxDv1hEyEWdJFW3Yl2oB9wi4
         x+UYwFcHG5FTNw3OiuzdHqfFrDDlTTo9vkfe+S8/KQv2aAYcRkn9Ac+IULwekeeQhaYu
         VJQaLNUNKeDcAKFZFoIcHiHNd4ur112PjTRwcDC/+g+UXtBx5MK0x6IOtsmfONfbBxei
         4oqqOZ2g71XbJCpB1IH8cuBNPO+RGSMvCw8z0/V5b90L3YJ3/htlYjsS0P0+BNx+PjKU
         y+Rfo7VyX4lNQkeCqX0TcvolcjJWOtv7yrDRIdyHXCtek63tYyZPcPWkitTkHo2S/nUu
         zAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553990; x=1730158790;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X7tHUckLE/MLiHUlkx0kAjj3yltxCb3kfPASiHLjhco=;
        b=fYeFQ5avSaGkcW2qjdy1RY+2VHcLUAcOgGbGB6ywnow01H7rEGdXpNk4KYGer31QJc
         j1Xvx2d3v39vY5Qq84ec5eqblKZSQqypwO2AoDAHlirjB39yTDctSgz/i8jsc9yxWbNm
         4wnseA8AZsaHJzgPbQRXbvVV9AGgOwBwuUWtuaJAvyN/MeZXun17Zjc2ieF9fRW0uaGW
         6j7IwEmQLyKGPjKyKn4YPW8sqzpbLpEcgZd7eow99hSdbNFhIPD7WDifAuCci4ZmdO/d
         cmaqQ7hZqW3mGTcEisLFQyF0obZda2gzZMQc5PiTs+/thiKsFQN7rFBlYjGDp1kiALdP
         /I/w==
X-Forwarded-Encrypted: i=1; AJvYcCVU8Lb+XXvDk1eXPVrB/10O4TLg05/keNYLyJUDLKE1MWFSvs7V024kjyB+TtV2QfilFxqdbe92K/257rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmJcI48fFnn4rpOujRpPFjB7lrOxUz4essx/pGYiMIyIEpQ6r
	iJ4lqqGvyN+8Uj3puot9OvfLvHGAYzsSqIzGaDb+qO1zPRCWc1HcfH/yWMEZOw==
X-Google-Smtp-Source: AGHT+IHMuRe4JiqCCfpTVHmSm+FewrxBnBkGSC7Nzs4TDMNE+u2iWG54d8b/+ap0PMLoJ5C40bnP5Q==
X-Received: by 2002:a05:620a:1928:b0:7ac:e8bf:894a with SMTP id af79cd13be357-7b1755db38cmr237177885a.20.1729553990490;
        Mon, 21 Oct 2024 16:39:50 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1659c88f1sm226044385a.17.2024.10.21.16.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 16:39:50 -0700 (PDT)
Date: Mon, 21 Oct 2024 19:39:49 -0400
Message-ID: <b94aa34a25a19ea729faa1c8240ebf5b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241021_1626/pstg-lib:20241021_1624/pstg-pwork:20241021_1626
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 4/6] LSM: lsm_context in security_dentry_init_security
References: <20241014151450.73674-5-casey@schaufler-ca.com>
In-Reply-To: <20241014151450.73674-5-casey@schaufler-ca.com>

On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the (secctx,seclen) pointer pair with a single lsm_context
> pointer to allow return of the LSM identifier along with the context
> and context length. This allows security_release_secctx() to know how
> to release the context. Callers have been modified to use or save the
> returned data from the new structure.
> 
> Special care is taken in the NFS code, which uses the same data structure
> for its own copied labels as it does for the data which comes from
> security_dentry_init_security().  In the case of copied labels the data
> has to be freed, not released.
> 
> The scaffolding funtion lsmcontext_init() is no longer needed and is
> removed.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> ---
>  fs/ceph/super.h               |  3 +--
>  fs/ceph/xattr.c               | 16 ++++++----------
>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>  fs/nfs/dir.c                  |  2 +-
>  fs/nfs/inode.c                | 17 ++++++++++-------
>  fs/nfs/internal.h             |  8 +++++---
>  fs/nfs/nfs4proc.c             | 22 +++++++++-------------
>  fs/nfs/nfs4xdr.c              | 22 ++++++++++++----------
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/nfs4.h          |  8 ++++----
>  include/linux/nfs_fs.h        |  2 +-
>  include/linux/security.h      | 26 +++-----------------------
>  security/security.c           |  9 ++++-----
>  security/selinux/hooks.c      |  9 +++++----
>  14 files changed, 80 insertions(+), 101 deletions(-)

...

> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 039898d70954..47652d217d05 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -457,7 +457,7 @@ static inline void nfs4_label_free(struct nfs4_label *label)
>  {
>  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
>  	if (label) {
> -		kfree(label->label);
> +		kfree(label->lsmctx.context);

Shouldn't this be a call to security_release_secctx() instead of a raw
kfree()?

>  		kfree(label);
>  	}
>  #endif

--
paul-moore.com

