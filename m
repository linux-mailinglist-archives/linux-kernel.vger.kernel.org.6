Return-Path: <linux-kernel+bounces-432474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F659E4BBB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3B61881350
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD084E0A;
	Thu,  5 Dec 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elES94BW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059F2E403
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361645; cv=none; b=euY0+08p9HAxVxdIxnXhqOfhVP8fRweumtzBascXaY7ymwCE1Qz/yKuM2aw9Xc03iIH2v/oDJQuiHVRkk8Ee1zsL6ug2YidnoZ4Y64OUYwWHYeDfW4YJDXArHL+4A2sHbHqFcFIJ/DfCeuaq44HpLKqKuPziM3HqQb94meO/Qpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361645; c=relaxed/simple;
	bh=SgowjTQrYekcXyiahCj20togqQfF2xU1QX6ftSI5N/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9ka2rFo9/CnYZrjWD7ZulLMEQ+G99vW7Go+Ebf2vpOWRThM9c/ajwuTZC/b1oK1tL8CuVkYlkM2Dg36YduHwDoDnX7qo7d0ROjsgEh9SUNLxNPiqMwgyVjc4m18hOaLWhrHHkbKbEaL57H6UVqkOmV/4ERdDfX5mKpq3uRVFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elES94BW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733361643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4YbcbUu4DyS3JwmAn34bQrphZB0KAFMZkW6h21FvT0=;
	b=elES94BWc7nHiZKpbEILQ6z1QnwlGYX2wFzDBxH1SwZ2Ln5oBL602RqCj8JIk6RAR4DiJC
	eYn8CevrI2M4rYP2FUn5kizyUvZomHrjhUg2HNqKKhRTDBL0H88O9FWBj3OJEhC+EEGmRL
	NJGfvCyksG0yeS/m+GZVzlLq4L0vvpg=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-YwaglnImOFe3WuboJVRtdg-1; Wed, 04 Dec 2024 20:20:41 -0500
X-MC-Unique: YwaglnImOFe3WuboJVRtdg-1
X-Mimecast-MFC-AGG-ID: YwaglnImOFe3WuboJVRtdg
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4afbf607173so7636137.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 17:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733361641; x=1733966441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4YbcbUu4DyS3JwmAn34bQrphZB0KAFMZkW6h21FvT0=;
        b=UBtv7bl2IIEW9d+vyrfsThOAxIQpejrhwxo/0RnjFWMh/0Z1jl621S0lUHVhqbtZ0t
         Bi3vA7e99v8ZNWKZpCZVSkcPEBzFlz42cb0bbpmsj/GEKsyaH4ba/O2+8gvxbZ2W9RyG
         Ty7vfPxD3ZQ5D4rB9efPPK7rb8oRgjW/XguQbk8G+PVvEpMwyR3QrHcnNmyPu/nwwVhm
         +alzHa4soQbaWw2So1LY5/jyB2GAXt+Q+geRQB+h+fm8oNBkdKSk4ecuN4tPo2lfSgbJ
         bQ6qRsHzhsNvSPojxHsWHxRBGF1Zj5QiXBCYCipkm77um14b3ZZng8bE4F93xdJdsk2g
         nqgg==
X-Forwarded-Encrypted: i=1; AJvYcCUDb3klbK/NGlHdMHgPg+RXVFLEc+WlHsNAO3uKloNkDBcVawm3fhxqk8qPg94Mo8dHDQBu8RaDo1hMddM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynLP3/8cx78tag7QTMR9qVhLHr7CpE+ZR8l/BEeZZWRtmb3dYx
	yV6P5c+p1sDcPKK0ilb8sIaSZXeb1LI9CCFMvc8fSuUP3pfFoWxLgTe+Y3b8DCoO59UQUREvZih
	J1FJEI275J20Lx3Lxr3V6whxbFI4ns26yivzQchOOwqqTg2h4DkMeGKwwiAlgRSkJu32BY/ik/g
	WkXvfhtisaDNk8lsIxnMZDSbup611V0bAeOx1f
X-Gm-Gg: ASbGncvTPOkISNmUDw2AZm6BSuChMobnaIqZ2Ak7TW//mt6hVBIdSZEBg8NwsGqWOKR
	04rlaOfZJuuuxttD6+RTfRXlrQ/HnVyOg
X-Received: by 2002:a05:6102:32ca:b0:4af:5568:8f66 with SMTP id ada2fe7eead31-4af973c0ab2mr12081991137.27.1733361641283;
        Wed, 04 Dec 2024 17:20:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiegenlyEQWaMXSs4vqDqiWlLCU9rLscDG3ExVwTbd0zYuJWToUuNU/bX8vEGXFSmoVDfn4McVLiu08cmJjkM=
X-Received: by 2002:a05:6102:32ca:b0:4af:5568:8f66 with SMTP id
 ada2fe7eead31-4af973c0ab2mr12081985137.27.1733361641045; Wed, 04 Dec 2024
 17:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204150450.399005-1-colin.i.king@gmail.com>
In-Reply-To: <20241204150450.399005-1-colin.i.king@gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 5 Dec 2024 09:20:30 +0800
Message-ID: <CAFj5m9JLC9+ao1Bhp0HfdS=7K+iKuAnkrURCd+ajDbqaZ7MYHQ@mail.gmail.com>
Subject: Re: [PATCH][next] blktrace: remove redundant return at end of function
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:05=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> A recent change added return 0 before an existing return statement
> at the end of function blk_trace_setup. The final return is now
> redundant, so remove it.
>
> Fixes: 64d124798244 ("blktrace: move copy_[to|from]_user() out of ->debug=
fs_lock")
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  kernel/trace/blktrace.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 18c81e6aa496..3679a6d18934 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -639,8 +639,6 @@ int blk_trace_setup(struct request_queue *q, char *na=
me, dev_t dev,
>                 return -EFAULT;
>         }
>         return 0;
> -
> -       return ret;
>  }
>  EXPORT_SYMBOL_GPL(blk_trace_setup);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,


