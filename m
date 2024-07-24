Return-Path: <linux-kernel+bounces-260498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA9593AA46
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AD0284563
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEE65672;
	Wed, 24 Jul 2024 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DZavSEjT"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F292595
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721782911; cv=none; b=uhWyJ1j2yHYW967DHmMd8uJYXzjo4wV4UL5O6Yn+toRmy+hzGhIQr0BXRyQH8vl3kWuA7vaA+aGO/fA/H0sMJ7R5ekiPJZwUsATiSG2mCxGoHbSIikwFoaTbEX0joj5W2a1ZpluUR69zzC/8XPRXQKNFWIRUlfKC1VmlsfnEofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721782911; c=relaxed/simple;
	bh=Zu25c00JsWlhrOfufasBRRsETcF9KBwlx9kR4Qh+au8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0W1FAmeQ0WFVFJ/KfW09sIMZPNTZZjYZQarBWYdhsbDgvtAXFz0rvQKg8cIspFhXP6I7gIPYLakbthn67ESF5MG0MqNGvGzcDent7a5J61IFECMg3S7kkH/b38oM7fA7y75KP+wPZnIAwyqAmaXmLxugiQD2Tema9hf2pNp+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DZavSEjT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd90c2fc68so11291735ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721782909; x=1722387709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz9IPzon27B+vtOKB1z6ZWSG6J+jwhqfPYpySzTzLO4=;
        b=DZavSEjThwa+kRv/EF+qeWvqInu7SPI5ZoRn5aGB5ev28dzgVSkXMl+w82FBgDNpxf
         6UXm4qpbX9155RYyPEdlImMseve3CX1nykP/AK6grmV3qn69hRG6csN2BoKsKqj4SaU1
         ENHlkp6zjtuQhtUWJ2oXcviR/JJwa5p1hodzBazUFqkLZKYYCX8xv1Cjx5gJhhiiPAlU
         5TRZChCvNHuxno4Qmu562meq3x2shJojY/SXQHHlxVkOD2rpZi1v0SThcpjH1Yac08HJ
         39DnqRhszAb949irILicS39wGeEnmIGWtDyVPKzA+mlZPhBJbBAfEYxO3SclDfjk/sX/
         EhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721782909; x=1722387709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz9IPzon27B+vtOKB1z6ZWSG6J+jwhqfPYpySzTzLO4=;
        b=plthvfNnL38uuLi0aeINA8wmEgd/aI0WKu5rheLeS/KT/fwgUS1Z+v8gBuPMk3upY+
         lFKAqf+xCcE2ydrKba0KB5tBYD+Y/diE368ITIs6/9eHyXL7OQUPtKzLHz+OiZA4EVnX
         U3S8yaQfRGfbNT6aO0Q/Em21v+K8TVjow+d9haF231wIvWouEms/Z957hakieZQgrriO
         M79s0Skd5zB6c5feIi73pneB5tqrFkfvE7q1/sniy++s0nMFR+IR4OpEPlijGLpciKei
         hTmVcqChLai9iQAXnALw6NRZ98vcVZybvQ2N8KF/3tvor1644H0BudxUcgQ6Q7q10vrb
         NvXw==
X-Forwarded-Encrypted: i=1; AJvYcCXE7nCqGXAD5TYQBXjqTm+r1SQgblMIADXy+CUgbeXB8TodRf5lT+jAGA/4XgtCJdWGhiV/KkZlvA5GfKRgd/mL/aLe2C0JKNqxhEe6
X-Gm-Message-State: AOJu0Yw5KFM7tX9wTX39V2l1vglcQpHchjog+ihGkVjzqu9Wrfuso7tk
	q7DxJBI6zpozC3wNoYVhyT9zuw8MOpO281h7fasenuEtJpE1bc2Hi3Stu6lDAw8MnwQFDG9vYKL
	mbtFaVrzGzK2Px+fcxGtRCsDX9CgJPe4Yx5ltbw==
X-Google-Smtp-Source: AGHT+IHMEm+FUBb+XmMeTLjEC9Gy4Tq8ayvSdZ2+NfD40y4A9YYx8rD8L/zxzkFcwWjC4lTJ6vFeYucdMH/L2gcxRZ0=
X-Received: by 2002:a17:90a:c17:b0:2cd:2c4d:9345 with SMTP id
 98e67ed59e1d1-2cdb5120b02mr798742a91.6.1721782909233; Tue, 23 Jul 2024
 18:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722211548.61455-1-cachen@purestorage.com>
In-Reply-To: <20240722211548.61455-1-cachen@purestorage.com>
From: Casey Chen <cachen@purestorage.com>
Date: Tue, 23 Jul 2024 18:01:38 -0700
Message-ID: <CALCePG0GtG4DQwzJ-QCJRScfxVg3Up6Xeemxh48qSf2VjxjebA@mail.gmail.com>
Subject: Re: [PATCHv5] perf tool: fix dereferencing NULL al->maps
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, irogers@google.com
Cc: yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ian / Namhyung,

Could you take a look at the latest diff PATCHv5 ?

Thanks,
Casey

On Mon, Jul 22, 2024 at 2:15=E2=80=AFPM Casey Chen <cachen@purestorage.com>=
 wrote:
>
> With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> thread__find_map() could return with al->maps being NULL.
>
> The path below could add a callchain_cursor_node with NULL ms.maps.
>
> add_callchain_ip()
>   thread__find_symbol(.., &al)
>     thread__find_map(.., &al)   // al->maps becomes NULL
>   ms.maps =3D maps__get(al.maps)
>   callchain_cursor_append(..., &ms, ...)
>     node->ms.maps =3D maps__get(ms->maps)
>
> Then the path below would dereference NULL maps and get segfault.
>
> fill_callchain_info()
>   maps__machine(node->ms.maps);
>
> Fix it by checking if maps is NULL in fill_callchain_info().
>
> Signed-off-by: Casey Chen <cachen@purestorage.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/callchain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 1730b852a947..6d075648d2cc 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1141,7 +1141,7 @@ int hist_entry__append_callchain(struct hist_entry =
*he, struct perf_sample *samp
>  int fill_callchain_info(struct addr_location *al, struct callchain_curso=
r_node *node,
>                         bool hide_unresolved)
>  {
> -       struct machine *machine =3D maps__machine(node->ms.maps);
> +       struct machine *machine =3D node->ms.maps ? maps__machine(node->m=
s.maps) : NULL;
>
>         maps__put(al->maps);
>         al->maps =3D maps__get(node->ms.maps);
> --
> 2.45.2
>

