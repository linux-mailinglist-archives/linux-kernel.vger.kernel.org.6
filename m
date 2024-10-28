Return-Path: <linux-kernel+bounces-385256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5669B34A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343B22822A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549281DE2C1;
	Mon, 28 Oct 2024 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cq73vevG"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825D55E73
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128838; cv=none; b=V+ey/eHu/ykppB2QnLPkv38Fv+ZcSUonbw9aOmiA3aKgg1tghLEqLXSPG2/qBV8B5k9CpdT1m8DFqFf7yFJIwynVO/PxjLy1kmPgHVqiVcVgvQZQJPpHbkwfwY/ZZzVRpKKoGl1vX9rULiH3vtaRuAn1zODboW6kkBRW7muZMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128838; c=relaxed/simple;
	bh=9vOfV1nv3dJamdMcGcAvkjeuuuehU7scnrXHevP4JGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVlhzOEtatOrso+kJQ2W9G2l1VkLfOeZHwAw2C/nxRM5+KlEPuo+l74EhPWy+vhkKU5o/oTqCqvuzlgdJLX5tbc819nuUwV9UQe1ykPyH2QdpLpuIC/d2fDPShOcZ1QAg1FM15OgGe7q1kOJBfELtVKHC+8E+QkplV/WfFB4V4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cq73vevG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so5648476a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730128835; x=1730733635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A7Y1smH5iLgDTBZI8wqoHylFq2drR/RaP5ssz22jRY=;
        b=cq73vevGHyRwIo3onMOUSZCq/5fCVwCwI2Zmq0CVeeGcSLFkUdjS5Qazhx88arGFIh
         chMDQfnHa6zZAQP9XT3v0lG1nrh31OHKeQi/nqZz5ha0rycIj54kdb5NC7mL7Fn/qHCU
         TN+aaNfFPjvYE16QHs56zBOwg8zO/qP9YRt1OBkOygIxWt0ZERRLNrq5DIHGg2ZGceHj
         XAHyYElaU7xHbQnm15tzBL0VFiFBjK9E1o2zHlnqyREtVReJobRG3ubgJ1zW4nc4BoZp
         V0WWW1DBVwdh5d5SeYJtMm8w4JOjAXBLUqKvEgq9ntHQYZpKUPnfGMuRIEV/emBqD/Cm
         WCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128835; x=1730733635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A7Y1smH5iLgDTBZI8wqoHylFq2drR/RaP5ssz22jRY=;
        b=kB1ek5NOrZdxVNcV8GHgHRZXaEwYTtseh+2l/ETyvcXujHPK0swjXUsPxnDE/ulEFw
         z2uytT1vXNOwoqe35MEbiRFqHz8mhv9N8kVRGizG34HeU9R7y0kUMME3+++zKUGkJwWf
         v/Eo+orafsPy9xSo7oKu+GhFfJHAVSSx1Yk610CZ2UtEAyHKTOVc67tLA51BEtAH3Ipd
         +bKvZTb/1elFmhiuCXdmbERAKgoEH+ne8faJTx4bnxHrNe/cdha8pGNCNwrzK5S17sCe
         M5zQxhy+uFM/JIPiXtUqP+Lqfb6TeFuG/XPYK1jbeceFLJbbDtWj2Q8zEKzX2BJ9VXxl
         uwXg==
X-Forwarded-Encrypted: i=1; AJvYcCW8AxmtSUXzS7EobZXqDqACcnL7xR8ug/m46dW1asvH6QpH5pzTyD8LttWXFC2UiI6LpLpzzdsa1q7R5v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGD4ln6aI30LoyEBOgVa/QnZ5x1adq9xIsH3OTgdfR34hq6o9
	Ls7OJwMo8k6vhWHLUNQuGr5e6UF880YjeWU5zcARqsy4tJfkf7LfGylfIRtH0aIrWhYvGHWXh0i
	yh8KG5JI68iBQOQcwD6dk3k4y2Z/AMVIC/yKK
X-Google-Smtp-Source: AGHT+IGQlWvncSWyRjU0MqLvkzq7zgdmh8ci7LTfgESO71eUgRKbiRnKH3tfmeMsJw+1nj1dpvpgLjvAzpaqngtva14=
X-Received: by 2002:a05:6402:40d5:b0:5c9:4022:872d with SMTP id
 4fb4d7f45d1cf-5cbbfa66f3dmr7608343a12.32.1730128834716; Mon, 28 Oct 2024
 08:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028080515.3540779-1-ruanjinjie@huawei.com>
In-Reply-To: <20241028080515.3540779-1-ruanjinjie@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Oct 2024 16:20:20 +0100
Message-ID: <CANn89iJCshHRan=w_YMp7bEeBadOjNS7PU392q2K4qNTRtz=Ow@mail.gmail.com>
Subject: Re: [PATCH net] netlink: Fix off-by-one error in netlink_proto_init()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@amazon.com, a.kovaleva@yadro.com, lirongqing@baidu.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 9:05=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> In the error path of netlink_proto_init(), frees the already allocated
> bucket table for new hash tables in a loop, but the loop condition
> terminates when the index reaches zero, which fails to free the first
> bucket table at index zero.
>
> Check for >=3D 0 so that nl_table[0].hash is freed as well.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  net/netlink/af_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 0a9287fadb47..9601b85dda95 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2936,7 +2936,7 @@ static int __init netlink_proto_init(void)
>         for (i =3D 0; i < MAX_LINKS; i++) {
>                 if (rhashtable_init(&nl_table[i].hash,
>                                     &netlink_rhashtable_params) < 0) {
> -                       while (--i > 0)
> +                       while (--i >=3D 0)
>                                 rhashtable_destroy(&nl_table[i].hash);
>                         kfree(nl_table);
>                         goto panic;
> --

Note that the host is going to panic, many other pieces of memory are
left behind.

A Fixes: tag seems unnecessary.

