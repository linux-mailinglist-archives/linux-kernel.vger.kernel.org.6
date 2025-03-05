Return-Path: <linux-kernel+bounces-547189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4023FA503FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661A33AC549
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BA62505CE;
	Wed,  5 Mar 2025 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Y2gqTApg"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD961230BC6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190301; cv=none; b=XBU3G5SE0QWPp5to765NIQl2OH5RskfzSiSCMx7vStwHPrGe9qOVuE7sVFyAy0ifLzu6amfATDH4KP1IsuuJYupP0wqM6Y5EKctAK64Kpfa7B+hmbe0z0h0NcsZCYLWeGc7zAf2L2kjAOfiZyIIKpfSAWiWOFyVp5ONVvU56jeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190301; c=relaxed/simple;
	bh=bYuWvTnxcH9cu35HRFKPtJkB8o67RKS5wYWWIeSxv70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLmKP2ZXjaZX/M2il1N2Gak92hQCWgPxSGv+8j2eFlY8+ciLBp3OgLRQnbFneMJ9YeXICeFS6UGICsj4M9riDoMBcDRBpmuVF3NoRqmLlkEsvCALIqH8T0vQLb7M9aY5PKZZBnlTCXBFJq0sBXo+M8jAq69YpWB1kwu8Stg+Wvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Y2gqTApg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fe9fd5e7f8so1971603a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741190299; x=1741795099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYMU1ONvumZN07XPBCtkjUrstfEAtCPPddr7Hfo9Atk=;
        b=Y2gqTApgoVu023lcE28ic24Z/iILnnSBvedaOlwJ+l4XsHdOMokBtTFXwUg7lFmMvO
         BwQM2Ors3A7bASOcF6yaOmn6M+1J0OYG1lMVm7untLeN0EwJFC2qhFjypaoxzXvlxgEi
         KqegLmZaTWnHmYMfwEOFmjAfFecqwcXbA5LBKvIfIz6A1FxDDV9TSt9l9eFXKSS1iLjE
         plJmFsB2LKf5QBQMDjkf1t0T1SCGd3ukHFu0ySIyJyK58F6DmpRv68TOD0sVw5KH/JFo
         hV/GYN9rZiLvnZThK3WRZEQ/QTm2K3JESfSjc41U24NGLI8a13bfJtoS0/HQ9gIyxhXQ
         Z7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190299; x=1741795099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYMU1ONvumZN07XPBCtkjUrstfEAtCPPddr7Hfo9Atk=;
        b=w/+Sc1cLRuO8Y9lXv/vyj+P/G9p6i7Jnrob/6j50cJqJ54Q9Cg6CpHvu6r7Uh6wPpf
         n8gYIhpQnoMCaNpoMbtC/n8uX4JcIs4PiVgjANtFKnzxsYOTIb9HhZFGb+sDcyzJMgDV
         xr8uzJ8C6dpEkupeUnNST7Dsf5tX0FYpWisg0CSTHk2QU2UhQIqGV6/yQc2Vexmoi6pF
         0uIBWWr543IshwvEx69p3VbC3nLX7HkKOS8UsPMFg7Awu8GBy3vQ82LWjCERGOsQOcnG
         Q4of1l5B/sZJxf2Pzw6qhSbxqtDNvOkJyPKdg+0kZCUsuGXKO7Sim8I1U3rQCj7w7whj
         +UpA==
X-Forwarded-Encrypted: i=1; AJvYcCXp2X5h003MGHWopmOk6LC0ONRwItyhidoq14BSlzLhzCVlR/i83oJY3UQ1i+ur5K1cBnzMXrFLUCA9pRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwfuRLNQkeMmqpE4F9hhVnDbzaPrYPqY3gscehptswdgxZyEC
	5PvY/9C9gBgu2lMKh2RE8rZTaS0ZBMQCVPw6f6C4c85M7tp16TCLhliGBq6q00tHR+tki5GfSRS
	ZzIeNSilQEfVtXTsHYODbtcbCV9eC3PqixziHUQ==
X-Gm-Gg: ASbGnctJIqd71cGsMrkiiAaZMhxpsLD3yMDIskKaJDDHCz6g6qk1ufv9i/8a5MCYSGl
	Y5uOTKRxNNGuWZegAdWvRWvXF+6R7js6lKBqDAamH35RPBlBPoO4lOURHiELofM8hZswardH3qD
	4SzbMDbefUlnoxqlQyx29xxxVrQzc=
X-Google-Smtp-Source: AGHT+IE039RKehIzWkPoz9Pwq8myqyy+FZsujwKtDDyBFn8FwGJVt10BuBtMIRgg7fWx3zw0WYibWGpIpl/Q2cToPds=
X-Received: by 2002:a17:90b:3848:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-2ff4e9041aamr1711334a91.4.1741190299046; Wed, 05 Mar 2025
 07:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3661d33-096a-45e3-8304-1123fd031527@stanley.mountain>
In-Reply-To: <d3661d33-096a-45e3-8304-1123fd031527@stanley.mountain>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 5 Mar 2025 07:58:07 -0800
X-Gm-Features: AQ5f1JpSLtbPYSGimhA0YnzX_t62kjsBmHrLeI4W_9M3JJL8fO_onDsebrkT6Ww
Message-ID: <CADUfDZphhneo1g7TSpCh4iNW_PjgyuM52Nm3mVQrG5PSzDUnnw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-tcp: fix signedness bug in nvme_tcp_init_connection()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 7:53=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The kernel_recvmsg() function returns an int which could be either
> negative error codes or the number of bytes received.  The problem is
> that the condition:
>
>         if (ret < sizeof(*icresp)) {
>
> is type promoted to type unsigned long and negative values are treated
> as high positive values which is success, when they should be treated as
> failure.  Handle invalid positive returns separately from negative
> error codes to avoid this problem.
>
> Fixes: 578539e09690 ("nvme-tcp: fix connect failure on receiving partial =
ICResp PDU")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> v2: Change the style.  Add the Reviewed-by tags.  (I will feel really bad
>     if I introduced a bug in between v1 and v2 and cause everyone
>     embarrassment with the R-b tags.)

Still looks good to me.
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>
>  drivers/nvme/host/tcp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8a9131c95a3d..b23ce31df97d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1495,11 +1495,11 @@ static int nvme_tcp_init_connection(struct nvme_t=
cp_queue *queue)
>         msg.msg_flags =3D MSG_WAITALL;
>         ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
>                         iov.iov_len, msg.msg_flags);
> -       if (ret < sizeof(*icresp)) {
> +       if (ret >=3D 0 && ret < sizeof(*icresp))
> +               ret =3D -ECONNRESET;
> +       if (ret < 0) {
>                 pr_warn("queue %d: failed to receive icresp, error %d\n",
>                         nvme_tcp_queue_id(queue), ret);

This log line is slightly less informative now if a partial PDU is
received, since it will log -ECONNRESET instead of the number of bytes
received before the connection was closed. But I think that's fine.

Best,
Caleb

> -               if (ret >=3D 0)
> -                       ret =3D -ECONNRESET;
>                 goto free_icresp;
>         }
>         ret =3D -ENOTCONN;
> --
> 2.47.2
>

