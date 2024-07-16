Return-Path: <linux-kernel+bounces-253829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B54193278D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9EC1C22BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5097019AD89;
	Tue, 16 Jul 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3yIrbZD"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394981990CF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136810; cv=none; b=k8aho0soPktgPvf0chFObVi7JGQPhlN8tRr1bc9Rmfq3e15E/LENHhTpQJE9W+XwVHMotnhUrys555QJg6xsuy1SDswNhVQ+D5jRX8Ix4e/vX98L4gozrnIpv1w5b05XltwReIxmIZsQubxGTf2VTRYEK85Aprup3npUeggctDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136810; c=relaxed/simple;
	bh=3ifhAK+wKZjxrm5xHO7gEG47OLYw9Ar/XOiTcjWJ/H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABiXguBrBkCqj7i60nB1Ib9t687I2Wzy5WYnokXuLS6RvNp4iJ2pdN+B5qJA/rGgn6pVfFwIlhhJzFDbo1HOwCNv2uvAF18L+2FEsdpJKF02DR1CeFB0yFMkqOvBHdo0NW58Lcy/Vc6S9ifJSam8VPhSJ91PJXHQLLyy90M9OB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3yIrbZD; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44e534a1fbeso280811cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721136808; x=1721741608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob7sez5ZcWf6Ala9z45pcOnpMuUA/8tRQrl/dXQmJ7M=;
        b=b3yIrbZDBB2hp673qFL+JAtsb11TE7TMoDkT/wjuHp79dht51Mv7Qx2f00ZOu6twGN
         jvIlvJor6OmQJn2JrXggHcEJGu9+0EOimdzAByvVgRL4Iyg2agYd/VpflFzzZT+ERibo
         XdCIYJrQoHbkWSEL4yQN+TmjwPN6t23yQVGHFeZv3FzmvMKO8yV2dlN8WXyd7J8FYqlk
         +Ak55Usd0eY/HA2dkwOfy+BAIpbwJiZ0f/Gg0kQ+FUb9Wbb02yyd91cAFaJFFu/jua0C
         zPDi3dbiw2VnELFwCICbHp0MzS6btkOrsxNYJbBEvfM9HkFLBkppj1VvwgLaWkEIiF4B
         0cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136808; x=1721741608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ob7sez5ZcWf6Ala9z45pcOnpMuUA/8tRQrl/dXQmJ7M=;
        b=uSsvrZ9Qdn6YAC5Tt1CuKdmE3jf8+1OnIjwaPeY8JZNHMJb2QG9k/p8VpFYBJbrCZZ
         k1+/fKqDMcwynMy3/TM9uvOkYNUebgFtLP7SEpsPTHZUD5TgnPhBzDCNNj+MN8G/8U9X
         0iN72KH9ACr1Pdowz9VDWJYfKTn4Qkw8CbNXtStqkK6hP5e1xeWR5koLJ9hIbe6hS4+1
         blXlCJ2lXyjPflnL1QuSz1rrB8jSYDRt+e4mqTLsjClhhGMYXqfhXjdL53AE0sX8L0lz
         b81oESNiVcO/2OcGci+nSphq3Obv4YSnhp+NCzI6CgVZDd9Vou/7UMAvZEulOfljEm8v
         U+OA==
X-Forwarded-Encrypted: i=1; AJvYcCUDzkL8ighBYMzetwp+RJw7FybigQMXzlAInGy+0iTeZuwTTiFqE8q/gXCwkUyceSYv10LIc+rK30kRYq4qcWQ39Owpu+KFWecd9apF
X-Gm-Message-State: AOJu0Yyy/sWI3GYHMffYPbm6VCii+hyRwQ0wHRRWe6OXx0OK+JuEfqAn
	0689C8h1gb5r4S3IigShuuRDabi3B4T9x2pF+rrIvAZqnrxGzSsY5JJX2av9QQeB8REkyZCoA7O
	6p60kxG1JVH60lNJhHsnLuEgZTPBKfujDbTCL
X-Google-Smtp-Source: AGHT+IFgY5uavdYYYKUEfwZ4LIzbj73bPrEesxfgb4pXqt9X3Nas5f4MQWGo/Qie0NUJyabxWv7e6TyyIfeeqrasJ0o=
X-Received: by 2002:a05:622a:4890:b0:43f:ff89:dfb9 with SMTP id
 d75a77b69052e-44f7a64d4dcmr3223261cf.6.1721136807556; Tue, 16 Jul 2024
 06:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716073405.968801-1-nichen@iscas.ac.cn>
In-Reply-To: <20240716073405.968801-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jul 2024 06:33:15 -0700
Message-ID: <CAP-5=fW8pVzHD+AN73Y1WLBSqf9LLHtnwBkuuZ2OLK9sCmv1ww@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	nabijaczleweli@nabijaczleweli.xyz, penberg@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:35=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Replace a comma between expression statements by a semicolon.
>
> Fixes: aca7a94d6a59 ("perf tools: Move UI bits to tools/perf/ui directory=
")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/ui/browsers/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index ea986430241e..fe991a81256b 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -985,7 +985,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struc=
t evsel *evsel,
>
>         browser.b.width =3D notes->src->widths.max_line_len;
>         browser.b.nr_entries =3D notes->src->nr_entries;
> -       browser.b.entries =3D &notes->src->source,
> +       browser.b.entries =3D &notes->src->source;
>         browser.b.width +=3D 18; /* Percentage */
>
>         if (annotate_opts.hide_src_code)
> --
> 2.25.1
>

