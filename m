Return-Path: <linux-kernel+bounces-391414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817339B8660
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3215C1F2258F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01EB1F4FA6;
	Thu, 31 Oct 2024 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GU2KDx1d"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39DA1D1E61
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415232; cv=none; b=GsGbwo4jaGNymAf7tnq/lCsmHqNBrh5ZmMWhqQ5ULlS0OY699SEe1iWzat880eh90XA5ev2+BpI4V17LYcQM0l+iLCwPYxr9NzQlpmAt1ITKb0ehvya8rwYt8PEwZTPx80EhDbDQdKzr3yrhrABpfdfAQ9BQbVWlWRJ7C8qBar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415232; c=relaxed/simple;
	bh=pHBg4ejpLx5lEeUtxj625TCmYLloW71G3t7gl4zIiNc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=hfKFp+CPNDhJ4NiO+MJdfK2lffAyTEkWESBg/faKBiPNN3R+qFc97B6D9SwrF33K5IFAdQgNJMKroffrYQlTdPrFM+vzch/uOVbyxCMyeDM+siYobZU+ulXn1zW3BeQePVG5L8RDEWotQaHFt0Rv/5JO/XzqIOwvKWrNqAYvdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GU2KDx1d; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4609e784352so9353951cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730415221; x=1731020021; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udTVBIR/QeqJ5ZiBMjmwgfafaCOXQDv85YKhtLP6cZI=;
        b=GU2KDx1d5dARQcuOS0sW00oJIoutfiKIOAAIaJwXL1C263gPow7ZkE1eSKpnTNKkO1
         R86yd5vTKtDC+79sdTvo+X8wXcbCpcmDGOLg14r/TgWtElaoJVl4gA+fetLAyI8j+Kb9
         j5f2EnbTnhcHN77GwJQd4cE4D/NjekIDjc+R2BcljHCpT1Rs6mCkeuTeeI3ZpPtoJmIx
         2yZU7cbY6/eVACESD0PGuLD5d6Pnn9/HiFiF30jmBl1CYEhrk/BX7x0pStMuQQoC/1k7
         fezmZZO6rZ00vp+NSDdo1XIhstpWomKyodHeAVwh7nTXEWEDLRZQmJpmuVCqp02HTU0M
         WOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415221; x=1731020021;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=udTVBIR/QeqJ5ZiBMjmwgfafaCOXQDv85YKhtLP6cZI=;
        b=BOZmGUeQzqHRTryDe00MM/5xmQ/grjS7EL4Gd+j+N+T+KdNsHAe7E+r1UCPeelJzgT
         Ok6FsPv+V0IlhgdftOoHMB50CeGTYHPsGK7MerbPvxRuHga5INkZyAy72qtmFt8QTzrT
         xM8C5bOy+w/vWkTMd+hClT2OSQcmpANFD274E1DnQwlWnqqP8tq+Rs3EKrhyF7PunfqZ
         Gmv4JB5IK6418q199i8lMUUOoGk5QnLqnMWtofCKtdQWoHKujkd88W5jyK9a+jJp52gi
         p+hJ5JOsx/fiKQ6FUAZwou1lFQejaZUkwYmUJtwXTdN3/9hdKrOu/Shs3sd7tGro51kP
         TbwA==
X-Forwarded-Encrypted: i=1; AJvYcCWSi9dW1gZX3DYBKZKIpu7TAKFPGAqUFVwDvZu58DUd8CAf/TKDj1zJfzQd3+oq5g++aLdEgj2wDJFnWi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfEcDGd731iBCQXnEhZrusoDox/gQrTVRCv8Zz3Er5tBQOhS3T
	oN+5fAu7puwovDzvmGYkQJv3Z6BnfEIjYSPaF52e9s2SL2hT33lDQxG8RXGaow==
X-Google-Smtp-Source: AGHT+IG4RK7zrIqYSfQlaLi2Jn/fcR7Wi85MclzKEW7ddmJvzAaqeYWrXlsvLQLcYYERuWLiK1/Vvg==
X-Received: by 2002:a05:622a:188c:b0:460:e7f5:1bf with SMTP id d75a77b69052e-461717c4602mr103322611cf.51.1730415221615;
        Thu, 31 Oct 2024 15:53:41 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad1a12b4sm12324511cf.82.2024.10.31.15.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:53:41 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:53:40 -0400
Message-ID: <6c1de7c79141034433d6eab515bcef43@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241031_1534/pstg-lib:20241031_1459/pstg-pwork:20241031_1534
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
References: <20241023212158.18718-5-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-5-casey@schaufler-ca.com>

On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the (secctx,seclen) pointer pair with a single lsm_context
> pointer to allow return of the LSM identifier along with the context
> and context length. This allows security_release_secctx() to know how
> to release the context. Callers have been modified to use or save the
> returned data from the new structure.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> ---
>  fs/ceph/super.h               |  3 +--
>  fs/ceph/xattr.c               | 16 ++++++----------
>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      | 26 +++-----------------------
>  security/security.c           |  9 ++++-----
>  security/selinux/hooks.c      |  9 +++++----
>  8 files changed, 50 insertions(+), 70 deletions(-)

See my note on patch 1/5, merging into lsm/dev.

--
paul-moore.com

