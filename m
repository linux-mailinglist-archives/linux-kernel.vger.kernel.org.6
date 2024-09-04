Return-Path: <linux-kernel+bounces-313981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF46C96AD3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63835285D23
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AC6BA50;
	Wed,  4 Sep 2024 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bK86CJOs"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E22833E1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 00:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725409116; cv=none; b=S6dszQvxYY0j4WaUT5gP+l1eDcv5NqvENc+H7PRR5g0fPP4rlerRYqVJA8O5HZUysobuPyRWWP9jwYfBKb1WkwXu3mOSBU3yJLkocWR/Az2yMZ26+pyJhjOj0JmdTqKBnetYYjEz3IHxLzOzHSzzZsHL1wbOXHQuRpyUKYm+Zsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725409116; c=relaxed/simple;
	bh=maA3RP7pe/gagogwVKFOTv1GARftK5AmlMjSMUHlNrY=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=dcLh1rSJ4wj+oQLCi7q1saJ9uiD0+sbfFN+Fiu2w71ek20r8wmhll1NITH3C2CXgGLm6LvRkU6ZyEGNmG+rC4YmsckJKxVTtJvTn6qEau5F9FrXgi8FyyUUZIbYmrIENZKMjsW4tOczSd6EpT06viJzzaGkUyliNjCw0ZQGWpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bK86CJOs; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a80511d124so326558385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 17:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725409112; x=1726013912; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/KK8E8XbtZHqeNwUxxALukoNijMwJ9sVaaDZmXi1uzg=;
        b=bK86CJOsJx9L4Z4lI1HT/tIKOpxOZ9U5D7y2d3G5AV0HFopDN04oabx1TllvhQKG96
         sh3Qz2E7YDcPlTaIYwJouLBzvtwH+3Err2Q+YA9rEMQoiEkax9XMPijBI7KPPJQQzrWC
         KVo1CNmTWIngT5xjRuZ8B/U0ZzVgo5x8IVQRyHda3wib33P6oUi56LUf/ARCbdxI3zdr
         /EY0UlOSAJk4eqOOAHvYzSALX73OZ9rFsGH8NUVBb220bRVQsFqMWzYGhmRctMwpCGNk
         jiL9eF6aSV8tTT7La4YKoYSqK7nL50GBVtt5Ow7O7yA3QwKZQeXUXQ52mtCtCNAlA5IK
         tKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725409112; x=1726013912;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KK8E8XbtZHqeNwUxxALukoNijMwJ9sVaaDZmXi1uzg=;
        b=CrBAnoQ+DNAwtb+BX/TOvSeemHQ5o6TBhwUMndy8Ycwagj/fVdBWQEkRyBemrCUqib
         FT+dDYtuCxmYwbeicGSRwnCa+EL6PGUif2+TmyPuqKdscjOm5s55woUQ5AT/9dG6w2qO
         WTqN69yXUnlji3N5BfLv7DUxslUim89a90/yJuqLPlByMxV+6jq1x+wMxWPxSLlPDmY9
         63q/1Ol7Je6kWvudOnEv38OjVth/8q9g2RpEc2AwweeI/JTRaEOCBRoHXqzXziGnoZC1
         Omok4SVbBB8Y90ZGWcZ8m49CPq1nKB4hbBJ825Bt/r7zRtZjGeRyoqbRBmAum32WnpG/
         c49Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEBLsqg3hMsR9iQpJxPAt4n/I5xSMQTfn94vHoJfVLQ8uX8g9ACgscZ4fNAHK/M/R18R7gxYXkittZ5EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhf95lmLhL0WRDxu7wW1+2GOiK4wKMKx99gh1CHCZlj/9N22Xw
	3DOMZrZX6D8kwgVxS37MC2TJ4ZWcyZXYhIgMG8wQOSRrGHpUaIpOK2RFDnyrMg==
X-Google-Smtp-Source: AGHT+IEAkame932TPaYRLg/8YoKrklA6vbq95atOfnBpcjTQqvQyn+0TULJts+nXRQRSKukfQWgJYw==
X-Received: by 2002:a05:620a:1725:b0:7a1:c40d:7573 with SMTP id af79cd13be357-7a902f29e21mr1690059385a.49.1725409112544;
        Tue, 03 Sep 2024 17:18:32 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d36b11sm575401385a.74.2024.09.03.17.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:18:32 -0700 (PDT)
Date: Tue, 03 Sep 2024 20:18:31 -0400
Message-ID: <e7c67e345b136ba6c4ebc5a8debe9338@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, audit@vger.kernel.org
Subject: Re: [PATCH v2 5/13] LSM: Use lsmblob in security_ipc_getsecid
References: <20240830003411.16818-6-casey@schaufler-ca.com>
In-Reply-To: <20240830003411.16818-6-casey@schaufler-ca.com>

On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> There may be more than one LSM that provides IPC data for auditing.
> Change security_ipc_getsecid() to fill in a lsmblob structure instead
> of the u32 secid.  Change the name to security_ipc_getlsmblob() to
> reflect the change.  The audit data structure containing the secid
> will be updated later, so there is a bit of scaffolding here.

I think that last sentence needs to be updated based on the current
ordering in the patchset.

> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: audit@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: selinux@vger.kernel.org
> ---
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      | 18 +++++++++++++++---
>  kernel/auditsc.c              |  3 +--
>  security/security.c           | 14 +++++++-------
>  security/selinux/hooks.c      |  9 ++++++---
>  security/smack/smack_lsm.c    | 17 ++++++++++-------
>  6 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 3e5f6baa7b9f..c3ffc3f98343 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -253,8 +253,8 @@ LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
>  	 struct inode *inode)
>  LSM_HOOK(int, 0, userns_create, const struct cred *cred)
>  LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
> -LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
> -	 u32 *secid)
> +LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmblob, struct kern_ipc_perm *ipcp,
> +	 struct lsmblob *blob)
>  LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
>  LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
>  LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a0b23b6e8734..ebe8edaae953 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -290,6 +290,17 @@ static inline bool lsmblob_is_set(struct lsmblob *blob)
>  	return !!memcmp(blob, &empty, sizeof(*blob));
>  }
>  
> +/**
> + * lsmblob_init - initialize a lsmblob structure
> + * @blob: Pointer to the data to initialize
> + *
> + * Set all secid for all modules to the specified value.
> + */
> +static inline void lsmblob_init(struct lsmblob *blob)
> +{
> +	memset(blob, 0, sizeof(*blob));
> +}
> +
>  #ifdef CONFIG_SECURITY

Once again, I think we may want a !CONFIG_SECURITY variant too.

--
paul-moore.com

