Return-Path: <linux-kernel+bounces-519981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C39A3A45A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D08C189237D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CEC270EA7;
	Tue, 18 Feb 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ICt233yL"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6D26FA71
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899803; cv=none; b=XMgQU+3uKfGpNZLbP3SdHMZtIwxiQUqIdFU8hgL0YGY3CDI/mfG3Mlf0Ytk5bYX4UAHEN3NkpLTxSKptpBIUXDDmRlZjkv0eit6IkZ5EAA+C56fLHKbpvtPKKeOQ8aeAR6lPqJbvN/vt0A33jDEPMGISjyXKLjmS0Gy5E7ZDePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899803; c=relaxed/simple;
	bh=JPepBJMSRAuLJ4M8oZdJ9/BBgMwNySHzUtLfR8bYIH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWb24WWhflQBCDUvLDcKiYOYAVihuXs02plMgSV4xd2VpVFUeGe/xixY2EG23HteIB3OY8a+dpxob/7JorVbDWb+B/NTep/QpYCviRzC/CgNL3fpZ/8UBjgt4tEQ3ZoVFcy9LlWgjWkbXJ+g4pDgQF1rrEGKTsNL1QxCG0ZG+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ICt233yL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fbfa7100b0so1398111a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739899801; x=1740504601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUt8o7+hB6Njb2oYjIlPOyCXaxcxvi9o7/BTnTuLLWw=;
        b=ICt233yLGb2YiKRo7yb4VlcpoVL99K6EG+9ATWylgcGqTSw1Oxwd8L7PWyJ/v4RkBE
         V930TQl0qSRcPhR3YiEUwDODUNyrhtUlVwD8LKJwkvQ/nYKrlITP2mLKile7uuW7GJPm
         yxcIvcMBlttktj/fCOqESOzYHTJdEf2dlE78YWIuzxWfBiWwvXVZnPjFtPQOUM8aGY6o
         V+lV3YEjNqGH2g2mz2OLA2uexMORM8JO1Xga4jzs+iqv0DDmJPHDM0LwI+FQSIOhErES
         w05R7tqS6SkpRO0DWQAb/l4BhMmjYbA/mlNd4yuauvWQfqZl2iQwsDYz21Kpk08Ov1T2
         rRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899801; x=1740504601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUt8o7+hB6Njb2oYjIlPOyCXaxcxvi9o7/BTnTuLLWw=;
        b=hK4OZy8ziqp7kVQArlzotZhGLCctCtzSQNkHUsBYzr04KzAY8SO9l67S26Efz91tNF
         ZM7jB18aJObHGw/UBGrhU/Ivp9QLb/EXhL9ElyU66yrD66wwy5YkwBiiVw6dBj/S06Nt
         UyEz16StrAR1Y3aCrfd30ukGUNEJtEGtmLGyiP0tEEzTW5YlN7bvUUWBTihttwayHIPb
         LRHTSox34eAn44VIYZK8+ne3nDHdJwaDk+tFqoHOweHRT/iiNzhBcRU92q0AtGCs0sgf
         NM1QtLxKlFXawG7Tzef/tgE9m0oUuvI2UA2Rz4CGBiSeRjJEZZrjD2WeRtePHQ4OBmHd
         0kng==
X-Forwarded-Encrypted: i=1; AJvYcCVrPYLW4379UWbbuX97gvIGCajLWA3z2qMsEqJrd9Cxq8YRoFacG/rrgJLMKzqmWDelrdx68OWPcH5TZkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYicM9YR4dq6dLXYUv6E5lBHfzRKV0lmcvVSn/VSqVC+cK+yKI
	083X1qelLKJV61FEidkvxk9d52FTv1qpHXti9shwfE7Bh+68lpCWsklabYoOZ2keRlIUku1vYkF
	WdTD+3ORr6bz19wZLr0S+TnDAjiQPQX9DaIDtPw==
X-Gm-Gg: ASbGncvUxf89EvX1Ki4mc1BBq+Iw2hnYOlE/408pENYeoI0V+nBjyKyKgzfFDXPcW5g
	okEPryiFVhBCBvg9mATpAQv7mDjVzGEthewf1yAi/qp1X4kjwHoFk9O9Yc5uuNIaqPKBbsG0=
X-Google-Smtp-Source: AGHT+IFeBNyWIAXh+EPk2eKwL5jW8rtVQKGRkR7rVYTeqSsk3nJIqHBXaNrLW/pvXwUtVLFmBHgNEHZDu2Oo9qOd5KI=
X-Received: by 2002:a17:90b:2fc3:b0:2ee:a558:b6bf with SMTP id
 98e67ed59e1d1-2fc4117c0cfmr8724982a91.8.1739899800674; Tue, 18 Feb 2025
 09:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212005119.3433005-1-csander@purestorage.com>
In-Reply-To: <20250212005119.3433005-1-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 18 Feb 2025 09:29:49 -0800
X-Gm-Features: AWEUYZklYvNbpjeqJ25078hNrYRuo6xnxQiEhKeQ9HuaQYI6Cy_rKvk9qRwhPsw
Message-ID: <CADUfDZo5CMo4cQeZCQ3z5vNFSJ_M_Ckeq=bj2rkA6-sq7ABSNw@mail.gmail.com>
Subject: Re: [PATCH] io_uring: use lockless_cq flag in io_req_complete_post()
To: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,
Gentle ping on this patch that Li Zetao reviewed last week. Do you
think the comment should be removed/reworded to match the new if
condition?

Thanks,
Caleb

On Tue, Feb 11, 2025 at 4:51=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> io_uring_create() computes ctx->lockless_cq as:
> ctx->task_complete || (ctx->flags & IORING_SETUP_IOPOLL)
>
> So use it to simplify that expression in io_req_complete_post().
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  io_uring/io_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index ec98a0ec6f34..0bd94599df81 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -897,11 +897,11 @@ static void io_req_complete_post(struct io_kiocb *r=
eq, unsigned issue_flags)
>
>         /*
>          * Handle special CQ sync cases via task_work. DEFER_TASKRUN requ=
ires
>          * the submitter task context, IOPOLL protects with uring_lock.
>          */
> -       if (ctx->task_complete || (ctx->flags & IORING_SETUP_IOPOLL)) {
> +       if (ctx->lockless_cq) {
>                 req->io_task_work.func =3D io_req_task_complete;
>                 io_req_task_work_add(req);
>                 return;
>         }
>
> --
> 2.45.2
>

