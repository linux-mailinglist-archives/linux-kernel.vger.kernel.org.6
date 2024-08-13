Return-Path: <linux-kernel+bounces-284811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A27950565
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246591C24544
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6319AD73;
	Tue, 13 Aug 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWsdDJGN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215419AA41
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553043; cv=none; b=rMi2HJwRy4LE70GXopl7dYHMHkpkvPJz3+VNiwtQgtBP4oaQASkRtXIgGzEmOcb8nytBit84hy69ib9e2vN2M2twIfG/EtdRLAGQo2HZQgyDG7FQToCjRdGYshpY/VXsj8sT5RNy/j4GIIXpSdSiKRMGZydTmek/QDq4Td9u3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553043; c=relaxed/simple;
	bh=DVH2EE06UdnKNbpLhbhK/EiV/GmqwraOnBqhVKgrANI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HJKP5+fW/VBd65EGpgwEjS1Go3lcdNDyjIAh/tQMpP4VRrt4dWsys08Mbtt1h0zM4t52BsLmW2pfkSSDpELaEDXx3Dtf2n23MhSoXEf5fubJ11yZ5iz9aciYCrmHb/M+PEhDIVSMojchvlPcqGfxLzJUMLIJ6eiALVESW3a3X08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWsdDJGN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723553040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UODp/A0p34/KbhVmFSnsyOhCvMyQjGRqt/Vobe8FUL4=;
	b=OWsdDJGNyPL4gqxyV2YrF3bJQuX4YHhQaFUPi176/EYmCiBnuNpfN+wtupk3vN5SQp4hXV
	V3cl6WK4BdroxfOyh82h+O85aToUq7oxcDPsVYXoHxsfNLkeKADZqD+1M8tolZ5A48AL7b
	Kpw5Qpv9am6e6jf3P/F3sYChGCt3oGE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-YbBKUwr1McSvbq9qQsn8og-1; Tue, 13 Aug 2024 08:43:59 -0400
X-MC-Unique: YbBKUwr1McSvbq9qQsn8og-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428fc34f41bso42027095e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723553038; x=1724157838;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UODp/A0p34/KbhVmFSnsyOhCvMyQjGRqt/Vobe8FUL4=;
        b=uQ/zEbxQ23wcePaFtAL9MfC4UJg0IXNt/pMu1Gd5qfTTxJPVPrYtAQzY4aLAFJkTvT
         30dxq1JqRDTUSHtQrlOorggPSQMunZB0uuXzirkyldGHY6nVy93kugVB7qdUH1LGbVY+
         CN3NmOwy3jAdht+hl8t+DjCBhGGNON59gP+O27pMtz6CK4yKmKEOP5Cad4PySlFzIwhp
         BMXFP9KdnxIeSdDUry4E46dSppujGhSYUBdBWw9/hsKAmmsAVQs5yptOpG8/dyJxioCk
         yITYQsjraJlgdSUPC6GC8A83RZz7YsAy3hm+frBi/wH/vxF/+AomqRDnWmxyuaWohbM5
         DnWw==
X-Forwarded-Encrypted: i=1; AJvYcCUCy6fCoTvOYMSahxQZMkz0yzrgVW30ec/eZ3akQATiRlQfyCjV05WPjLX0fxGkq9/uzaMoXWtKpqUTo+ZvTqKcjoxONhJpsanNChJU
X-Gm-Message-State: AOJu0Yz/Wr4evZ8Agno8f+nwKXTdeYuP3RaZzBcvjzDXt8inzYc5RmPF
	dWu68/EYZwBWBdXn9J/g8tVQU8W1rVjGGw8hTe83LA2C+PfyWQyQXkJW953escB65dKUjQXV5b3
	WCtIB6mCu5Z/c/PJa0gGipicGVqM/PGXWK97dXY/6YV2ta7H+U6Wav+Vo+AmEEQ==
X-Received: by 2002:a05:600c:35c9:b0:426:54c9:dfe5 with SMTP id 5b1f17b1804b1-429d480d056mr28245385e9.10.1723553038011;
        Tue, 13 Aug 2024 05:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9F75xOMaEz69+dHZ2BYX5iCMYoNvV/BBl9pFCa0k33fyTQY91z0glLn+az7JGkiCpYRhHEA==
X-Received: by 2002:a05:600c:35c9:b0:426:54c9:dfe5 with SMTP id 5b1f17b1804b1-429d480d056mr28245175e9.10.1723553037471;
        Tue, 13 Aug 2024 05:43:57 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb3csm10203279f8f.69.2024.08.13.05.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:43:57 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 19/24] sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
In-Reply-To: <20240727105030.514088302@infradead.org>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.514088302@infradead.org>
Date: Tue, 13 Aug 2024 14:43:56 +0200
Message-ID: <xhsmh7ccky4mr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 27/07/24 12:27, Peter Zijlstra wrote:
> Note that tasks that are kept on the runqueue to burn off negative
> lag, are not in fact runnable anymore, they'll get dequeued the moment
> they get picked.
>
> As such, don't count this time towards runnable.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c  |    2 ++
>  kernel/sched/sched.h |    6 ++++++
>  2 files changed, 8 insertions(+)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5388,6 +5388,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
>                       if (cfs_rq->next == se)
>                               cfs_rq->next = NULL;
>                       se->sched_delayed = 1;
> +			update_load_avg(cfs_rq, se, 0);

Shouldn't this be before setting ->sched_delayed? accumulate_sum() should
see the time delta as spent being runnable.

>                       return false;
>               }
>       }
> @@ -6814,6 +6815,7 @@ requeue_delayed_entity(struct sched_enti
>       }
>
>       se->sched_delayed = 0;
> +	update_load_avg(cfs_rq, se, 0);

Ditto on the ordering

>  }
>
>  /*
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -816,6 +816,9 @@ static inline void se_update_runnable(st
>
>  static inline long se_runnable(struct sched_entity *se)
>  {
> +	if (se->sched_delayed)
> +		return false;
> +

Per __update_load_avg_se(), delayed-dequeue entities are still ->on_rq, so
their load signal will increase. Do we want a similar helper for the @load
input of ___update_load_sum()?


>       if (entity_is_task(se))
>               return !!se->on_rq;
>       else
> @@ -830,6 +833,9 @@ static inline void se_update_runnable(st
>
>  static inline long se_runnable(struct sched_entity *se)
>  {
> +	if (se->sched_delayed)
> +		return false;
> +
>       return !!se->on_rq;
>  }
>


