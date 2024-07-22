Return-Path: <linux-kernel+bounces-259374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5002F9394F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5B0284904
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C8C3770D;
	Mon, 22 Jul 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRayo9gE"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5827C23746
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681370; cv=none; b=TTWJullXqiwPtp4uU1cfxWu7vEWRoU3mS1oExc9F2VWp7o2I+m7fs9P+Q0i7NaQoEvzW2meq0Zt6B9abHFwmUj73MDl5xyytqCrVTv3BCt9tWvR0qJ6ELCA0JLV9dxsNEtoD4w2BpeKQb36JNVONENh1khR7a477jHwrWt5/h6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681370; c=relaxed/simple;
	bh=oWbinSVpvH96rA0dOFHzW9AiDM7yXEDd/ImQASJxt2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwlDlkp/8wDgqV3dyI4llDC1tdn2p3HlNriNESgezOzmzEtvJdT2Ne3SP3yl7L1i4N9iFK/YEc8vj1zrXhUTbRLUspT91j5wSMlGqftPHr+uZc2F2IvkqB2w7o3MfRZkoRbqE8qo+JYXh0+MptYDhrpXwmAM0jUNTQvoPTINtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRayo9gE; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-398b599593eso6985ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721681368; x=1722286168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09v1IY2nZsi5Z0EdEgLBJS4oAdkOFd/u7ggcxR6nmTY=;
        b=lRayo9gEZzOgbU3E8fU71u6eBzJJyQ2TMcDNrJ+Jvcr9kiqWX3j2pPt0LRNJRt0xaq
         E1Kwx7bsSPsbOwVze83T6lSkNLqL1ZClif+K4GJBsOl8iMifyEqA1eXM2V4U/5MDLKyA
         TutwaBe5fyrt4vjRjJCHzxofg+wuBrmnZDs+sW7IEBPM+VnBrbMZW6qJW/CpU60vSrD9
         2EGdrQ8/vxQCdE8310CkPdMKGftRDOb4l6errd/gQGPqTDW+p9p+POLXZZviYarJ78NF
         V/v60nSfVSBm70Zy1cATEUCvO2Rl8G5gaj9SlsAGjQonDU4tY0OOGboAY56NoL+manAI
         hBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721681368; x=1722286168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09v1IY2nZsi5Z0EdEgLBJS4oAdkOFd/u7ggcxR6nmTY=;
        b=shSZCXC+kgj6TwQ7abHuEhHWhOIf1s0WUhiogIhbifHYshqgrUzovqwDZ2aNt7RR9r
         DRTSU1RLGbAWgpDL1NmZ/9uvhG5NcfaCSKsW14LgcX5nl24KLiAaytUnCZhabgcHc/du
         XD8PRT5G30GoeQCJpfOqRP5FCpngCcAZ3hm9o+8bj8051XrTDNtGzcHm5V0dJguljzdX
         OmpetSNNoVWQWFtSoaodmeRRXeRifIUIhg4EhC7/XwId8PHIAD2xmeXH04HliKYuTUSh
         aER99glbzm4hR0mKO34RhD6WW3AzvnKzXbrSc0JNWpP0DCtX5IaV7VJ2jfNu5RHwrYab
         f18A==
X-Forwarded-Encrypted: i=1; AJvYcCXflkyeuwutfb4iQYYEv3q71lf3mKPb8bq4hEy5GPGURj7HoP9Vkq57B8P/uaRxOpa3PnRQhdSLb8hMZfx/m/kMdcMmuvnhh4iJ6Uqa
X-Gm-Message-State: AOJu0YwS7G34rCTPVN92udeYTSaGnWyFHxkfOjU2RUzkAKgcq/+/+1CD
	1/T3nIyLpydyjICUizBb/WukHI9LBw5cMi+A1aPro+zPT2a5QugFbDE/UGsoBMvJCsOemOFWxMN
	A5EXpsRrt8QFszVC9orPq9F5UxAmgHprN66FD
X-Google-Smtp-Source: AGHT+IE9e02aqAb1xlpxAiF+a1va6IYwxHFS6lF11BEgFQwdQhYbdE3iz1E+dlw5qFVwKjsUSfjMrRPQmCL4LHCgGnM=
X-Received: by 2002:a05:6e02:170f:b0:379:2baa:4510 with SMTP id
 e9e14a558f8ab-3994217028fmr7157135ab.23.1721681368219; Mon, 22 Jul 2024
 13:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722191858.123607-1-cachen@purestorage.com>
In-Reply-To: <20240722191858.123607-1-cachen@purestorage.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jul 2024 13:49:16 -0700
Message-ID: <CAP-5=fXrPR5gq4mz8WaOkBinfR0cAutxjysaynqGj-qUSwa2oA@mail.gmail.com>
Subject: Re: [PATCHv4] perf tool: fix dereferencing NULL al->maps
To: Casey Chen <cachen@purestorage.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 12:19=E2=80=AFPM Casey Chen <cachen@purestorage.com=
> wrote:
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

Thanks for doing this. Can:
Signed-off-by: Casey Chen <cachen@purestorage.com>

be assumed?
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

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

