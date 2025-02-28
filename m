Return-Path: <linux-kernel+bounces-538898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A6CA49E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAA73B83B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BED271284;
	Fri, 28 Feb 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cDqxIvV9"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065C26A1A9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759613; cv=none; b=Y1IrYP3UVdM0PUHyMDjZ7Rf5hppepD5cdxC2EAGiX/+r8id/MhC1A4IpD1iIkeO70QO5cORySGJJZL2cneN4YtLGnuU7oSUxya+Bihv3iY2IxYGdym/Lvrv1w6Pl65cIInPaMkuKOk4/rRYfsSgovH+HjC5C0SwpoYAuuWrlBpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759613; c=relaxed/simple;
	bh=h2gE6rUUyvcemVgUP1W4tCsojyay/YimUNqH0KvLJIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1MF7noVaJ24vkC9ukhUb2zp4SjcZpVj0Ec/ztNxGGEVmZKHR7JBUUfzIlzJOS7Ki//vHGkx+PvqzQ17GUfqaxopw6tTgjgvlK/RvJamwrY5dy1A0WIxK3ZFJQDatq6gv37Va3FBHfkBI/7yQoXFVTrcYtWv4TL2v1oBsEkFeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cDqxIvV9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so605167a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740759611; x=1741364411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgeRbDBZj/Kmr7MOY4QlYhLgpNtskrfBfuQ+fdrrXK4=;
        b=cDqxIvV9oFafs1O12JzqSvSnSyugQjC9Q4p62fkrwOI/2w+8Z1iN133/Lp+byJRWAD
         n8koxidpdvhj8dxZV6nrvKzfD8QAlcMLKeQORCbHpa87JHZuU7K4VwrQZn9uny0zJJKo
         3cQxK8SeaM4p+MSQpoOb+IIGzESbYU4JprIjl9b3JhcjnjPwl5Abm1BP3l/Q1+0dmYWU
         WlYeLjflXG1Gvzk1832VfpYMwdINxbqUTEJWFnf+83WFUI37ldGd7peC7Dru6O+D7LGs
         7Iafm2gBQb7dQxg4tbM74TX7ZleY7x3FUIstQLDHp5fgiagsE0phCwgy5FTKETniNEig
         MlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759611; x=1741364411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgeRbDBZj/Kmr7MOY4QlYhLgpNtskrfBfuQ+fdrrXK4=;
        b=kVaQLItOV+qx5fDFRcZlQEWFvzMW4CebjFqVMFOgvUrcDE1vDLfF5Ui9rpbSIk8+AI
         9jBQGu9kqMjca1dCDFwbod77LfPwcI45R/r23WQn9KfnWCdXyMZhV8ktVcJsmtXCFB3w
         HL6Qop4/30iR23/pKCUQZlxYbfGkGXrDFBYs+iCYxd+dbyoa6fWecf2sqdCZxOv9Alyc
         3Jwqeyy+EJ+kRaDbu7H00qcecP7Ig0ZZTRvXM1qux7jCE0qi8gcGzK9i3SYDRdpz2hDU
         ziuwqsNIU7SXQ+93xWQeKXAmK+gO9XfUshndIeJB3GahzQ5icKZly9l0Zjkpv1DRnR7k
         P4rA==
X-Forwarded-Encrypted: i=1; AJvYcCUWE6zyxyiXfu4n/WbvP9TCG7ncoI0f9eeJrZYdQxCBZPucDEorYgjCwlGfiE4tZ2cAjDFkDzUq2GR9PkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgrUvZs/kwRNuTtgnCBdcV4jeT26LDgBOQVkgtnpw4MZ9RxYG
	a9iiXPi7SIES01F7GCRNFDY/8JQYnt9IebNyRT+BUtEdW2EUFs1L7LOlEXYUbORIWElVb3sC4Br
	LRRMG/rSHSsps7hXs141166dszAmvBcATM7pcCw==
X-Gm-Gg: ASbGnctsIMZcuJRID8MTZyJa7UjpCujy0tbXVYB4SCFTQH0U2aiRft4sfq1Jwk841fz
	P6toenRsheZyG+LIV2QdZr7NdfM4Gev/+9fH5ZEHWGVJLcFj+7HNwbp1zW3nfAHVB3gtX+mga02
	qI/ePrFg==
X-Google-Smtp-Source: AGHT+IGrPFexLq2p08fvEV+7vi1y3CJa/f7XRnyFy9qcLiZdIYOI/25rvbAAY8P6RNV0DwhkcTgV3GIHP6AtdYEir/o=
X-Received: by 2002:a17:90b:1d02:b0:2fc:25b3:6a7b with SMTP id
 98e67ed59e1d1-2febabf856bmr2465912a91.6.1740759610894; Fri, 28 Feb 2025
 08:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
In-Reply-To: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 28 Feb 2025 08:19:58 -0800
X-Gm-Features: AQ5f1Jp0gEH4Qx2IhSi_EgMbX05yYyRpMAompI303gVwrEuEcTt5M__EGuq2aTo
Message-ID: <CADUfDZroCBhuJbc2jMsQAKhMZF9y3Ye5zowhusbUFqOdaA7PZQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: fix signedness bug in nvme_tcp_init_connection()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:39=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The kernel_recvmsg() function returns an int which could be either
> negative error codes or the number of bytes received.  The problem is
> that the condition:
>
>         if (ret < sizeof(*icresp)) {
>
> is type promoted to type unsigned long and negative values are treated
> as high positive values which is success, when they should be treated as
> failure.  Add a cast so to avoid the type promotion.

"so as to"?

>
> Fixes: 578539e09690 ("nvme-tcp: fix connect failure on receiving partial =
ICResp PDU")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Good catch, thanks for fixing this.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/nvme/host/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8a9131c95a3d..361b04ec5b5d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1495,7 +1495,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp=
_queue *queue)
>         msg.msg_flags =3D MSG_WAITALL;
>         ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
>                         iov.iov_len, msg.msg_flags);
> -       if (ret < sizeof(*icresp)) {
> +       if (ret < (int)sizeof(*icresp)) {
>                 pr_warn("queue %d: failed to receive icresp, error %d\n",
>                         nvme_tcp_queue_id(queue), ret);
>                 if (ret >=3D 0)
> --
> 2.47.2
>

