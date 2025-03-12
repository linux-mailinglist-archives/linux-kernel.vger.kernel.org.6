Return-Path: <linux-kernel+bounces-558626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0531A5E8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A109B18988CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52E1F3D53;
	Wed, 12 Mar 2025 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aagWl5ht"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C261F2B90
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823499; cv=none; b=R6zodF03b0rqXyEf8G82f98x56eAZhDIZ8KBt5lRArLZI/+KOHFuOHTfgcL9ueFkhiim/VwuemtAKgK2nMLjbtzwonVxLboE5NuUFmH8c1/KvHfL1uCyXmzpXZJpO4+4nMbKFoxoqVGk9zM4f0EqHVx/OrHJifPIrO7QNCNzTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823499; c=relaxed/simple;
	bh=y6im2FC9RnrBK0DsITVVl0clIoDEu4fT57zPgo7oKQI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=QP/YJ7zAj1uUHbJ4JQuYqpi7q/OGCbHkVaDGadZMv6QtKB+VWrez5igaq+4cYGljwJ1w0G4rqEKPrR8IQ3fgUvGFbwsgLShkNkrF6CndVSVOwdw+Peo+2ek40SBSeUzuJu/Hx1wUrlqdnuQ2uOO0QkQScU7qdlEVPf6ADifiaIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aagWl5ht; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c56321b22cso45023685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823495; x=1742428295; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEHvEcO4NOg0YRDF2fNEp3c9gsS6yXYNEicVD7ca+jg=;
        b=aagWl5htvm96U1T2VDK+wTQWnB3Os1O1B4Smq1jlsN18q5uwQA1ye/O7YN9OFTgSYL
         Q+5F76wxKqehkXX2JLKFrrPcUFOEhyaS/xp+ARN/5ANK6NAe5KtqkkNhq0cS275kr5ET
         cfFb/pGJ4yCTm/8OFF3b9Cd2GdS+CrDaiHpmQ3ktrtByR2ZIC238a6tZgpeBAY2MXROo
         gKhuRVk+lCXBzwjypUwZFPWGreAN41yWzjA10hNffGY3/YxPC2nqDvyaqR/rqn7xWX3J
         Arc/43oUVhEoAcDOOEOwE12DI2UXwFlbJ+UnfSruPN8xj1jekQUB7+5h0PJB+yskVL58
         Uv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823495; x=1742428295;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qEHvEcO4NOg0YRDF2fNEp3c9gsS6yXYNEicVD7ca+jg=;
        b=RMVqrJlltmQwh1oVijCGoFGDHx2C6ssaMa410wlfKRTC7zWAPUJG2wssGb1PAwHiKQ
         3XeyiP8y/s6wJka6YlyMo4eCXdUp4zUr54ta8kR5lJ791+l35f4V0OUYnydLhMnTEWna
         2F0lrgKiNBbKXX0Ef07Bk6rKaZgv/HKqjrUqUcJADx6tUxTVwoekCnoPw74qTcSKO1sM
         6e5RJmBN+8aiUxoHqq9ba7pulOxOpYo5n3ThVXJivqtdMF25KjlcJQCwVRyRTEp4TDft
         yTJxIShgE1vgNmk3m0WH+kLQfY5lX/O92j7dGoS7mr2NfrtO5kVKiMYSEndLkxOyIhV9
         6J+g==
X-Forwarded-Encrypted: i=1; AJvYcCXZUuWsfK3CHDwAR7hPCkPaS6qheWnpbEvLMaWCphFEcJ05dyPPkAiNr1b5mUlziE2i5tZ+8SOiNgIY09Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YziRlRD1EIm9cWMnfhvZq0N4EoLeqQNZhjXjKZ1cwPE+RIVhKXb
	S06Reb9qzi9/MQV4bNyqZC6mO92pWkYeVHGrssgnzuIj+GEYIoMIuaO6RB6J1A==
X-Gm-Gg: ASbGncs6Qa2a9YZBlV6gX6hCid7yWMeVQG447Icsw3Z+A8k9Sa2RByY9Mz2w41yK9zF
	R1EjhylUcQfPDcf7F/cZDHAeU47dYFtSnbVhY2/pPdetdwVRe3GbaJyl1u/GjewFlKNhli186Kt
	M6LWjnkFXklq6MMshV839mE4hN4bxXWz0QPvIA/uCZysV9BVvJ1NKOboPFVnhSsvEjVsMStLTCu
	4jgYd8reS0RVI9bt2n0LaVWCc3lqaLgn5SDVdtHRJKVYGZxMhN8Z6uCDs1pYTGddV+VQeDN5nD+
	1lBwnspwozfiqlGbpY6QkiJLmD+p4M/M/C7VeagLnmNvQ9EjycFkFmmrYBVbT3zhxSFPKdAowMw
	5OrsqTZyliB540g==
X-Google-Smtp-Source: AGHT+IEW0E6G8sFUJZrXjgx8IgIO7dCL/me5AKtsty8GXdCJQbxSmByGBM0HaBvG1kOgomgjfgPzCw==
X-Received: by 2002:a05:620a:13d0:b0:7c0:add8:1759 with SMTP id af79cd13be357-7c5737b8c7dmr71231985a.18.1741823495217;
        Wed, 12 Mar 2025 16:51:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9d8b8sm18772585a.53.2025.03.12.16.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:34 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:34 -0400
Message-ID: <69ee16ce82a564e09b2060d46fa2be0d@paul-moore.com>
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
Subject: Re: [PATCH v2 2/6] Audit: Allow multiple records in an audit_buffer
References: <20250307183701.16970-3-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-3-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with
> a list of skb pointers. Add the audit_stamp information
> to the audit_buffer as there's no guarantee that there
> will be an audit_context containing the stamp associated
> with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added
> to the list. Functions are created to manage the skb list
> in the audit_buffer.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c | 111 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 89 insertions(+), 22 deletions(-)

This may need to be squashed with a later patch as I get
"defined but not used" warnings/errors for audit_buffer_aux_{new,end}().

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 2a567f667528..a4945f1c3ec0 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2412,26 +2471,14 @@ int audit_signal_info(int sig, struct task_struct *t)
>  }
>  
>  /**
> - * audit_log_end - end one audit record
> - * @ab: the audit_buffer
> - *
> - * We can not do a netlink send inside an irq context because it blocks (last
> - * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
> - * queue and a kthread is scheduled to remove them from the queue outside the
> - * irq context.  May be called in any context.
> + * __audit_log_end - enqueue one audit record
> + * @skb: the buffer to send
>   */
> -void audit_log_end(struct audit_buffer *ab)
> +static void __audit_log_end(struct sk_buff *skb)
>  {
> -	struct sk_buff *skb;
>  	struct nlmsghdr *nlh;
>  
> -	if (!ab)
> -		return;
> -
>  	if (audit_rate_check()) {
> -		skb = ab->skb;
> -		ab->skb = NULL;
> -
>  		/* setup the netlink header, see the comments in
>  		 * kauditd_send_multicast_skb() for length quirks */
>  		nlh = nlmsg_hdr(skb);
> @@ -2442,6 +2489,26 @@ void audit_log_end(struct audit_buffer *ab)
>  		wake_up_interruptible(&kauditd_wait);

We should probably move the kauditd thread wake into audit_log_end()
so we don't end up poking the scheduler multiple times.

>  	} else
>  		audit_log_lost("rate limit exceeded");
> +}
> +
> +/**
> + * audit_log_end - end one audit record
> + * @ab: the audit_buffer
> + *
> + * We can not do a netlink send inside an irq context because it blocks (last
> + * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
> + * queue and a kthread is scheduled to remove them from the queue outside the
> + * irq context.  May be called in any context.
> + */
> +void audit_log_end(struct audit_buffer *ab)
> +{
> +	struct sk_buff *skb;
> +
> +	if (!ab)
> +		return;
> +
> +	while ((skb = skb_dequeue(&ab->skb_list)))
> +		__audit_log_end(skb);

Put the kauditd thread wake here.

>  	audit_buffer_free(ab);
>  }
> -- 
> 2.47.0

--
paul-moore.com

