Return-Path: <linux-kernel+bounces-432557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1874A9E4CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A521881A37
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CCC1922D8;
	Thu,  5 Dec 2024 03:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jggbfd0c"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24797190674
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733371068; cv=none; b=VvlUvDfLDM8lgq6aNB6MjYZebYDJRNrC5wgNXiv+89GdicBvDMbSv1Nlh1lB9n0yE82vxNS5a15EWCpdMt85vKd4jioljVfT5yAE+N9CuZQMvKTElI+PvjwfLneB7EoMV0RoKmFdypt3fS9cQwi9UI1S8FXThbVaqS60RT+v8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733371068; c=relaxed/simple;
	bh=oLRGTb72ejWWk9aFimMv47FZezfMuWjGvZSLQZgea14=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lwA4YPVUEWCqhHtHaPO06M2RKRPgVXbE8ilN5au1reI4Ykjjc47dIBZP6kZ2hq3VUb7Nl1JZHEr34mI7N88TcNwqvaRlhDWwu8xWOYRVZEO/saJuaAZ+W5l2rKmTyt+H/u0f6CrlqYuxjUi8why7JHaFYk/DG2izrBnExaT4Lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jggbfd0c; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d8cf27d831so5012906d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 19:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733371066; x=1733975866; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Oti3qozRwoHqpzvb7K6NtyZNM2s4uzWDXR9kDcWgEw=;
        b=Jggbfd0cQuUh6xIIsTe6RnfBfUMDTh0AIjZGDttrdXvz6xYwOV4sKNaVCaKhWIp9BM
         63Uu0prQcIcBoZj6ZX3RAobxT58g4SlPeGAZ26l9hSeD4malPtj8xgQm6SVx6FwFjXNM
         sT/40cAnIH9GynQi7qQm2A0dKlyIhdSvCVQ0mYileeDByl4BuAJHYrcOcvYN4lB7HrU6
         YwGjIqRlh6LYJrBQexPjzWCCSj7l9IWFV1dn3zAp60OmMZt0oZuD0XinsZjqQYWpLVQ5
         S4y5Nf7q6nquSd8pcdW1CrvN0EPsem9ZbynOfHGHZ0rdMgFPTPRXNcCm+6DZKWCtAYKg
         CiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733371066; x=1733975866;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Oti3qozRwoHqpzvb7K6NtyZNM2s4uzWDXR9kDcWgEw=;
        b=CLVj30IMCyRQj1LbBYMb3exonxHs656f4YWoiN9aUOUXlmffhUPrBoMLSRxiPtIReF
         hxTEXlSFWeJG2Ih5Q3ANgmh/lGW3J+7LRgBvbB24dQ8LMpmzFNWc8Y1VjTgHA+KNZiFU
         mELWvmQb+RSfDyawk17OrAikur59MQI8ZqKmD+D5tBkioCi5d05xZuPPNwo3lt2y4ZSv
         fflTlbftav0AryX2g5aWrV6V/DVwmbrdf+XaUExr5JoYDFCfxJcJirgnH3IDzqWqNjPY
         o9wjMlxXd933L0lvBSTc8CeBW2rTMcOG1PRIOEI3bi5GRgzDoS+nl8WxslVEfuxh/7VL
         WE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXejCuYYjihpwhafW8wvHmgc75Hmn+NhNWcoEy5CPgXhh7TLzPuGnCi2K7Ny4gL1HdRcGKvm+yCrOqfpts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL24wmvkC1PXaO3u4CcSjtGBr3wvWftmS0gwkmJH6jz7vNfhey
	LyD1OdxR6JTr/w84vofqo/ZTKTwBA7a4+W+fvch0rHNUKjfQyygPrWnJIYfL/Q==
X-Gm-Gg: ASbGncshoT0DeH1TQdY08+bVLIqJ/6wvuCA/WjDTqita0rMy1dlvdE7nmAxhS95o4yq
	jnmUl/W3ICX+R/0kFZHf32So/w/n6QP1GMWxXC2j83qoeoXuRE8deee0FjcJ4TZrqXmrSmHWM+r
	7wNAtEFFzjFJXzmuzmifufXMhMv2HSeTbOF42ODB1aB4I+zOBLn9GH5cWALNXGsi3aWtxqkO3J4
	G/GbSE12GGziK3Tt756IXz84Yh9rL8Ig68uoyzcrYIx
X-Google-Smtp-Source: AGHT+IFRejNpSwq8ad9CPlSgB0kK8N2HvIpjbURpmP7KEs6utN9/K2cNkEny1rpEWTrXQgButkPo/A==
X-Received: by 2002:a05:6214:21a8:b0:6d8:916b:1caa with SMTP id 6a1803df08f44-6d8c4656a3amr86825166d6.27.1733371066112;
        Wed, 04 Dec 2024 19:57:46 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6977b5sm2522186d6.43.2024.12.04.19.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 19:57:45 -0800 (PST)
Date: Wed, 04 Dec 2024 22:57:45 -0500
Message-ID: <0539f2c64df66fe4adab6ba9a1030ab1@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241204_1752/pstg-lib:20241204_1702/pstg-pwork:20241204_1752
From: Paul Moore <paul@paul-moore.com>
To: Yafang Shao <laoar.shao@gmail.com>, keescook@chromium.org
Cc: qiuxu.zhuo@intel.com, rostedt@goodmis.org, lkp@intel.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Yafang shao <laoar.shao@gmail.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] auditsc: Implement a workaround for a GCC bug triggered  by task comm changes
References: <20241205021100.86390-1-laoar.shao@gmail.com>
In-Reply-To: <20241205021100.86390-1-laoar.shao@gmail.com>

On Dec  4, 2024 Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> A build failure has been reported with the following details:
> 
>    In file included from include/linux/string.h:390,
>                     from include/linux/bitmap.h:13,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/smp.h:13,
>                     from include/linux/lockdep.h:14,
>                     from include/linux/spinlock.h:63,
>                     from include/linux/wait.h:9,
>                     from include/linux/wait_bit.h:8,
>                     from include/linux/fs.h:6,
>                     from kernel/auditsc.c:37:
>    In function 'sized_strscpy',
>        inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
> >> include/linux/fortify-string.h:293:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
>      293 |                 __write_overflow();
>          |                 ^~~~~~~~~~~~~~~~~~
>    In function 'sized_strscpy',
>        inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2759:3:
> >> include/linux/fortify-string.h:293:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
>      293 |                 __write_overflow();
>          |                 ^~~~~~~~~~~~~~~~~~
> 
> The issue appears to be a GCC bug, though the root cause remains
> unclear at this time. For now, let's implement a workaround.
> 
> A bug report has also been filed with GCC [0].
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117912 [0]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00ICVG-lkp@intel.com/
> Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20241128182435.57a1ea6f@gandalf.local.home/
> Reported-by: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Closes: https://lore.kernel.org/all/CY8PR11MB71348E568DBDA576F17DAFF389362@CY8PR11MB7134.namprd11.prod.outlook.com/
> Originally-by: Kees Cook <kees@kernel.org>
> Link: https://lore.kernel.org/linux-hardening/202410171059.C2C395030@keescook/
> Signed-off-by: Yafang shao <laoar.shao@gmail.com>
> Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Tested-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/auditsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> v1->2: Add the link of the GCC bug report

Thanks, it looks like the GCC devs have been able to reproduce the
problem, hopefully we'll have a proper fix soon.  Regardless, we need
to resolve this in the kernel *now* so I'm going to merge this into the
audit/stable-6.12 branch and I'll send it up to Linus after it clears
testing.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 279ba5c420a4..561d96affe9f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2728,8 +2728,8 @@ void __audit_ptrace(struct task_struct *t)
>  	context->target_auid = audit_get_loginuid(t);
>  	context->target_uid = task_uid(t);
>  	context->target_sessionid = audit_get_sessionid(t);
> -	security_task_getlsmprop_obj(t, &context->target_ref);
>  	strscpy(context->target_comm, t->comm);
> +	security_task_getlsmprop_obj(t, &context->target_ref);
>  }
>  
>  /**
> @@ -2755,8 +2755,8 @@ int audit_signal_info_syscall(struct task_struct *t)
>  		ctx->target_auid = audit_get_loginuid(t);
>  		ctx->target_uid = t_uid;
>  		ctx->target_sessionid = audit_get_sessionid(t);
> -		security_task_getlsmprop_obj(t, &ctx->target_ref);
>  		strscpy(ctx->target_comm, t->comm);
> +		security_task_getlsmprop_obj(t, &ctx->target_ref);
>  		return 0;
>  	}
>  
> -- 
> 2.43.5

--
paul-moore.com

