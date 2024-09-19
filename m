Return-Path: <linux-kernel+bounces-333477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B7B97C94F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5431C20CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2337019DF58;
	Thu, 19 Sep 2024 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3mQpnlR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114819D08C
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749409; cv=none; b=QR1QvzFIMwVpABzjSnmFMsta7NXVkrmEKAxjbGQHt9JgTdpMZzUUj8IhrBVOsBfKj6BD5q+6b+lFwlFpiy/e+g8QJ4FX+0+m7ofzTdnH9wQjtYfr/z02xMYvFm445AxDm4RwN1kWuxzV6Z8z/BRN/924346AFInEu25yAXT632A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749409; c=relaxed/simple;
	bh=I32E8pYQ0rfeWgsg9XefZezWxlj4OBRnTN/JIdQ4QSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O/szADHnnggjEmcltSI+KihbBOaM6OcBIBumP1FORGNR5tHIC/wE3ZuAOue7yj6Rm8DVWLu6it3/GQ0aZbtk9leVnaTUrNDQHO6y1ktwturvMl1WqvIAZ8+wNhIMdgCK/Z9BuMCye+Uzk748rlvUbLlxbr9ws0Mz7hOOk2UoJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3mQpnlR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a74f824f9so1492533276.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726749407; x=1727354207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzaj+6YGcmRSff/H/YAZ07htkUtQu64GS68v/+lW6g0=;
        b=E3mQpnlR4r3g/SvRk6Ys3g2WHVR9COJ6CByq3gsfrVSU9bFpjvwjoKdhhjsu4itczE
         wHedIVETzvsDatwkDzth3Sf2l6GvCn0K9L6V57R3yGyvkPEndI2i+CIAqvucO+HmmKrp
         9Zzi1sac42mgRB0wOb0Chy9/3/LD8nPEpcoKJGlPhlUWJOyCEBTPpJNxkIlezfaXW73F
         +h9Tg35CXUL74xszhE0X/u3H39lUIuoLkgnfzIpbuXMUQDPbS3Rte8YHkINjgCesQQJX
         2Mgc8/+5gH590HkTd9CwKLoTxH9pbePZ8n5MVAKKMFeJhluKn8Cj0RL7eW3axkpLhZep
         kZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726749407; x=1727354207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzaj+6YGcmRSff/H/YAZ07htkUtQu64GS68v/+lW6g0=;
        b=bFqXPRO0M7WAjkF9nk1dvQKlnaQvA0Ni0EVhHKR01FNjJoaQgCkLprgR0RF2saRZJ1
         uzBJ/pzaT3PCfoLP7Y96BG4okNLCdZ82np9baEfzhAb4pJmTOSDA50gaRER1IfBeq0eD
         uIKomkQvqzilIVev72B3I/igwVLwMFLfMj2KZZV5rR8BRLuPlcaWflT87a/ROfp9TBpn
         sZDa55eLhFFrbwr0+7KUsi7uNS2+KYS6rgDag48vcJrUUxB2Nn7lHGo5pNOSuBdfZ1mC
         lyQUS8smoO+4Xm3mXrfPRAahBkOzA+1FwiECRlc8QdOougtW9nsSEf/3GJuZQbvrxruZ
         obkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2C5wk4r2iJnn/hRqSvMERTAu9LFQqlcKKYVIG00YezwoIpZLDHB8Ge4MUWGgdtxfnCexYiuFvlST2wco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYOL1Bp6W/IZxk3qRMXlHp74y7/QyRYS732ocZ//35hzLjlcz
	KohPGskZ++244CTAT1DfIxh0VLpBMba0T4P+c1TtdBrKjZu8cCvUjHLXKdZjEVKYAGiwfAeCAu1
	7OFIHpg==
X-Google-Smtp-Source: AGHT+IEA40YdHj4gpye91yNHURgx0FJvF7H/BpoJ6+xQTdlg5edN+y+6vJInbKIAEeqzvlJ6CwAi3KfYWklw
X-Received: from bjg.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:415])
 (user=bgeffon job=sendgmr) by 2002:a25:d884:0:b0:e02:c06f:1db8 with SMTP id
 3f1490d57ef6-e1d9dba6fcamr31379276.4.1726749406694; Thu, 19 Sep 2024 05:36:46
 -0700 (PDT)
Date: Thu, 19 Sep 2024 08:36:35 -0400
In-Reply-To: <20240426-zupfen-jahrzehnt-5be786bcdf04@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240426-zupfen-jahrzehnt-5be786bcdf04@brauner>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240919123635.2472105-1-bgeffon@google.com>
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for ep_poll_callback
From: Brian Geffon <bgeffon@google.com>
To: brauner@kernel.org
Cc: bristot@redhat.com, bsegall@google.com, cmllamas@google.com, 
	dietmar.eggemann@arm.com, ebiggers@kernel.org, jack@suse.cz, 
	jing.xia@unisoc.com, juri.lelli@redhat.com, ke.wang@unisoc.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	xuewen.yan94@gmail.com, xuewen.yan@unisoc.com, 
	Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

We've also observed this issue on ChromeOS, it seems like it might long-standing epoll bug as it diverges from the behavior of poll. Any chance a maintainer can take a look?

Thanks
Brian

On Fri, Apr 26, 2024 at 04:05:48PM +0800, Xuewen Yan wrote:
> Now, the epoll only use wake_up() interface to wake up task.
> However, sometimes, there are epoll users which want to use
> the synchronous wakeup flag to hint the scheduler, such as
> Android binder driver.
> So add a wake_up_sync() define, and use the wake_up_sync()
> when the sync is true in ep_poll_callback().
> 
> Co-developed-by: Jing Xia <jing.xia@unisoc.com>
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  fs/eventpoll.c       | 5 ++++-
>  include/linux/wait.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 882b89edc52a..9b815e0a1ac5 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1336,7 +1336,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>  				break;
>  			}
>  		}
> -		wake_up(&ep->wq);
> +		if (sync)
> +			wake_up_sync(&ep->wq);
> +		else
> +			wake_up(&ep->wq);
>  	}
>  	if (waitqueue_active(&ep->poll_wait))
>  		pwake++;
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 8aa3372f21a0..2b322a9b88a2 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -221,6 +221,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
>  #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
>  #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
>  #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
> +#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
>  
>  #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
>  #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
> -- 
> 2.25.1
> 


