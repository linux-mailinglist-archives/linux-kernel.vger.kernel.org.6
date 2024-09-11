Return-Path: <linux-kernel+bounces-325565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB661975B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38042B21C37
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B641BB68A;
	Wed, 11 Sep 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CKmeVMqU"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F71B5823
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085385; cv=none; b=NWL9kimF2yW9ybgKdqzxo3977OlWH648L5/4tRbw/97N0f1pgWZjXk3RSeTHPfWSdDGnf80jmiV7y8PeBLcx/LGtFWbDcltSW6pI5mlv+loYkeCpRb0XG1KSPSOdl8TXfdDjSLb7bNJYxNwhVo1IwD7OLVEr4qjeXkNQAckm0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085385; c=relaxed/simple;
	bh=b8lk9rqO700ZqY2AKqDTrzjArj04yVnmgpgLYY/86Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyzFqTq31vQ/LoRhGMg2DXjLM1HKjLpM+QBodtV36UaJRjnZ0pOyf6mbDeomGSSZw8U+y64iKPi1ovut/tvCrGBivx4HMEk3U4RCiZtDAzzZ3MIORZHAWbQtROeX6I9w0cIIlOcole2KAbNreEAlE3DmNK4v+om2Nt8Ln9I0jdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CKmeVMqU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6db67400db4so2731797b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726085382; x=1726690182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNhAe72EungrYlqh+1GPIStyQ7YkKqwFlhsi8LRyhqE=;
        b=CKmeVMqUUVbCcxrx/kHsaCvE+s8FNitWo4giGr2Llzdaoi3vWGQbY6ln5f04g+IyX2
         Jt8mYoSZQubqCxtYAQ4tBbdvuA/ytWSuBg6eQ8LFCQuhqqsjOh7H5R3FAatn1aWlCSmN
         5C0EWTY+OHg3gRiyugx5RYqNVktQrJ/6E0PkltvaGxm6tQEDruo4Vh+edSAK/nrZmX01
         oKHixkSwcw1ShoYY23jtGiquTWkdRxpaPCheRoZE95p/JdNN2F8OGaMyFR3Gke/RnevM
         PnEsCMPRe4H+WX+zLpNo59iOb+H7psUkZtCTWdXUOX4566ntPubpec/bDd2lKboWWBFA
         YotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085382; x=1726690182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNhAe72EungrYlqh+1GPIStyQ7YkKqwFlhsi8LRyhqE=;
        b=U5FVPQcxqku81LDfBLOONuEk+evEg+JQKMQ2HMuAI2pEvfEpCbzYXoonQXHnSBWC1L
         qqD3wo32OrctSMzwWyemedXozlKuwaVn7PImap1S+CVU7j5zSKLAjkr7uV7Me4I/5Yuw
         ZCeJ5Lw/AoYE/9kZhpKEMsuKzLVszXETJjhtHty3LiC75rd4ceOt1ICg5BxEuAV057Kz
         NXZnmn9VeATURO5IaFgjcl4lf1FeuK+/LTR31yQ/DEelw0vMUBKbsJLNSjBjRb3fDMX4
         jPc+pi7XZCRyAaaZ91be/ZegWVPSgr/7cBUwbjzvGpawMNa0u/7Vgg5wo5Fd6Ys8hbrX
         0PmA==
X-Forwarded-Encrypted: i=1; AJvYcCUtjZ4Gt21rwWWTT5002hXnovJjl5OlbBC56qUqVbxw9ldl5Tez2QLD0i55AxQNZMQSMUUbIp5zdNDOtHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPZTe2Tpf9hbLM52PtlBm23kKj8DK3U/pK1c81yHt1QQQuUXg
	7KnikENEcQgLvLMf0w34/KTd5ZQU+VYnNxI3HY1YF1NZ+W/G/SzoBFOPBmSRCKUg/yKIKPWa6eN
	ypfT8xXOPKbbtimgVdRsU8RnI3f0rj+tSSvgW
X-Google-Smtp-Source: AGHT+IFfNbOYziAqTZC1YVV8UGukieoNsQmEyOv11EiHfSW2LBeR/v0HfGZzwvd/ESuRNgdLqnDvQi3J1PzaH0JgtVQ=
X-Received: by 2002:a05:690c:4a02:b0:632:12b:8315 with SMTP id
 00721157ae682-6dbb6b246d7mr7550997b3.22.1726085382351; Wed, 11 Sep 2024
 13:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911142822.7c65e02e@canb.auug.org.au>
In-Reply-To: <20240911142822.7c65e02e@canb.auug.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Sep 2024 16:09:31 -0400
Message-ID: <CAHC9VhS2_UZ_9jL=A8WK_RwL8jPamnOqQ6ciUJmGT1J_6E5_Sw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the security tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 12:28=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the security tree got conflicts in:
>
>   include/linux/lsm_hooks.h
>   security/security.c
>
> between commit:
>
>   3346ada04cf5 ("bcachefs: do not use PF_MEMALLOC_NORECLAIM")
>
> from the mm-unstable branch of the mm tree and commit:
>
>   711f5c5ce6c2 ("lsm: cleanup lsm_hooks.h")
>
> from the security tree.
>
> I fixed it up (I used the latter version ofinclude/linux/lsm_hooks.h
> and see below) and can carry the fix as necessary. This is now fixed as
> far as linux-next is concerned, but any non trivial conflicts should be
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

Thanks Stephen.

> diff --cc security/security.c
> index 3581262da5ee,4564a0a1e4ef..000000000000
> --- a/security/security.c
> +++ b/security/security.c
> @@@ -660,7 -745,7 +745,7 @@@ static int lsm_file_alloc(struct file *
>    *
>    * Returns 0, or -ENOMEM if memory can't be allocated.
>    */
> - int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
>  -static int lsm_inode_alloc(struct inode *inode)
> ++static int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
>   {
>         if (!lsm_inode_cache) {
>                 inode->i_security =3D NULL;



--=20
paul-moore.com

