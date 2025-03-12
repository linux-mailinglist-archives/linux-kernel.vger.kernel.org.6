Return-Path: <linux-kernel+bounces-558624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D3CA5E8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4012B3B2F04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734001F3B91;
	Wed, 12 Mar 2025 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EZ+8pCy1"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41B1F2365
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823498; cv=none; b=tBFQx1p4QveSqO/F3OqpIDFSRsxtPn8iCfmjHoN8xyvV1GHdL02+9ud+mFTaOLoR78XvoAe0AllMIDb8oqAfdWdJv/CuPwFREHwwbbma+yfNPe7RSTG3TTFsNlchCXLoGy/lZCL4ZlNTR2jJjst8izy99aXkxArMmQJNL+c0XX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823498; c=relaxed/simple;
	bh=nZppvXExe9z50boTqFggcjUjW+ehiSBBDdzzf3Mnh3I=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=FscAZn6txiWBy3mU6AgWCCw74bAzFdLBdWAw8SttBAAWeamdZ5Oc2feySNJ8IwLonCAf/ok+nhRRZ8nu4YOUeJCT1cAFtWOC3nBIJp7ZAnpJjefMsO+PE0Se7OK+raHBylIthfV2uO5brAUt7/GUpNnTbYL7uXeWmIcliF/851s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EZ+8pCy1; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso4147446d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823494; x=1742428294; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CW90axoo0o9jpPTk+/SEj4I5AijDX95SkVqF//3Gczg=;
        b=EZ+8pCy1b5Iv8gyVt3xRDvb6fknPtM29D7El+oqDFPB4nlAJdTHmzlgZkh+j+qcaRB
         ufXPokzwA3jOcyPOgJ6lRj/1FRB4O/U7V2SJyBLYKb7B1W772i+tNpFNThJGy3N3+af0
         utDAn8vAFyBooZrDMKhCd9AfaUxyCSIamTBv16Kdv1S/EMlW4dNpGQR47Xq8GYIjsZqb
         EtPLL+uSznx3rLfY6c49YpsPXp5XC13dnKXhidIXyRi7FXUZs81FZF1PRhXEiCiiRy2x
         PuTpWh3Fmrw55t+cZImN0KN865YapvUmZDmip+p7FVJ21KKka9e7P1l4Sze1kCyvDQZR
         NJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823494; x=1742428294;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CW90axoo0o9jpPTk+/SEj4I5AijDX95SkVqF//3Gczg=;
        b=L0mFUmxj6bqIe9sKrs+cCsgm5ZxoxCoOKVhQl526JBSxr83THAJZnKLHMPE8VqROYe
         sEG2K6hutCCW7fQfpxU3xgE6yhh2uyGbcCQI/5ueq+9D2n4eZoSODme24ziDwy+aw5a2
         s5SfI306aQn5TuEg9UtXqzDuvkrk74CFamYWkA+AiBBD7lIml48ja5ucUMvdTHJOTixV
         7WI5a5Rspo+Yv4DgcZgqfdYFfaTNd9MA9EZF/zTk5fejC19YOkbK0gnP7IwylEyl+Wkx
         Rl4qHbEU6V2L2j1LSuSFUj99LAGAeipWBIueDc/GRBLckbdA2PmKsfbcwIEL+SAk9WNU
         /wdA==
X-Forwarded-Encrypted: i=1; AJvYcCWM6a8QdtvBVpsiVJh9Za0LioHEweReThONAcqdjaLsnxGwmBvYOI3vgT2Nz+qi9hAuNTjaWG4DX2If2K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgdYYY1rvmUSp7aY/jzcqg7t4Cp7tMR092mYKq2x3bCMWw1n2P
	WCPKY65mlSMSO2zWgPH0My7CKw4L3cwlDT5LarAKge4VNdrdoJ7CTqjO/yrNgA==
X-Gm-Gg: ASbGncvEro5D/RwMSOxkB8BtVcft9dMjDoOpqsagPg13h01ULsBrBYuGUEXvXzHITUr
	wFg2fN2WgZZso0wOF6H7J3hj1vAcWi6exisfzf+FPmhSJYA2f9pUTEdJhr9vrjopykGC8wa3Juj
	Mf33dUf3u3Xgkybkd4+3zTWAH+vuJRPCXPQOmg2Mvjlq61JQFypQtDTGEuU29BYVxcJpXqb6TvM
	8Y9tlGn1OAqp8XFLbVhshNgbJqtp9FUsICKDJ4leIQ/hMNX84Szl/JIzLNSUtOBl/6GwJgn9qee
	wkE5b6v/uO6o6CWUefp4NzjqmxEUN4nZ02jkDOCsQzs3xT9NMDVqfK0/SzLAB4H+iwH3D8gVhBo
	Qt4GQbY7k0aKK7w==
X-Google-Smtp-Source: AGHT+IFSqTK2ilUcKx6zm2i0BV+o8XNbFHCnS5If+1fP0sLk3byjVxocCH06FxErBK2o3HRcOC9grQ==
X-Received: by 2002:ad4:5c8e:0:b0:6e8:fb44:5bda with SMTP id 6a1803df08f44-6e900609592mr404688736d6.19.1741823494123;
        Wed, 12 Mar 2025 16:51:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34c51fsm1722136d6.109.2025.03.12.16.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:33 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:33 -0400
Message-ID: <d3a295144441248d47fee124e30a008a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/6] Audit: Create audit_stamp structure
References: <20250307183701.16970-2-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-2-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 13 +++++++++----
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 25 deletions(-)

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 9c853cde9abe..2ec3a0d85447 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -994,10 +994,10 @@ static void audit_reset_context(struct audit_context *ctx)
>  	 */
>  
>  	ctx->current_state = ctx->state;
> -	ctx->serial = 0;
> +	ctx->stamp.serial = 0;
>  	ctx->major = 0;
>  	ctx->uring_op = 0;
> -	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
> +	ctx->stamp.ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
>  	memset(ctx->argv, 0, sizeof(ctx->argv));
>  	ctx->return_code = 0;
>  	ctx->prio = (ctx->state == AUDIT_STATE_RECORD ? ~0ULL : 0);

Since we are now combining the timestamp and serial number into a single
struct, let's move both clear/reset instructions together up to where
we currently reset ctx->serial.

--
paul-moore.com

