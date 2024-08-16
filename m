Return-Path: <linux-kernel+bounces-288882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE4953FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78281B218D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525956BB4B;
	Fri, 16 Aug 2024 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="29V0ypQP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E84F20E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777855; cv=none; b=j6pzLLK8SRE1jeXmNlUG4hdebJoAg09pfwtGkGWQuLdveKYjqy4p7FdRLmP9VrQksR/BI2LZpmEvcBY6DOL19Ui2YYdNuZYPCNiP07cOZa8lW4CXVjwZUbRgnis96PZNPzZOTbFsGERKmfWcTvTNH7Fz2DJqvl8/wGzJ5+8Kv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777855; c=relaxed/simple;
	bh=pDkx8ngnUQRjIclWtfWHA39LO7XC/50Owe9Vmjxe8yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEXorpf29Wv/l5vz/cFwD3f5OrIEdbtL8hJegEv3kG8ejZYAF7jwnBXqMA5ljxVfYY3jf9ZYNha8Xtjc3qRlIDYnsyXAeYKiwcqpSJ3mWAizilinMEZDXemalACy0JUTueOdreHOXkrU8I6RjzBiJgdmjaXukl9vRTrmNlrVE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=29V0ypQP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201fed75b38so29135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 20:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723777853; x=1724382653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TksdukPAgZv3CISxfFNPNoWEfe+SnBkoBwJZG9NR5no=;
        b=29V0ypQPCK02vMOCwAzezmndAahVmclJuzQG1OmBOhVmjS8EBVVzfwYQf0RdHlgRvN
         H8a/8ruoukofjP4KKcpEF3uAGOsOw9rBUGav8O20xX7/7aMr1AbB6jn1S+q208UMCcYk
         27CCwjzweIKNvsyzX8KTgaIxH0f8uaCBtGZeAyeGESg+moO566xjbxaUkOXa7glYz7fE
         sreGy/cUPP15OVdQ6yGvergZ4jZ/46cSwcP8+BdMH+kEty5smDS/2zHCUmq9IosTnS2c
         vzVH0IpkZ2/JDfds8f6a8T559YPQ9VjXWHT6YqVf5wIL8NOrOWzo6SotO7Tpan9gKJos
         Tlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723777853; x=1724382653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TksdukPAgZv3CISxfFNPNoWEfe+SnBkoBwJZG9NR5no=;
        b=ax7VISsxGvWY5mzi9SXYf2Y21wSIQtHQxdAPMispNnSDfurlR2pcZ60JRDHBOY11lT
         91lBNbJM6EEFZ0Td32OCpZXBLnGadUIfakofJ0fBvJlmyJDDwHjjZyrAte37zkCUo8Np
         aRLWz2jEVzIemFaAGp1K15FvhFAJQrDmr3Usb6BKeehTZqRkN3HycdqERJyLyrqpFnN2
         vD8p3CixUkegxkoAJz2atDEwB8qARVEeLdTTT6YJ/rptcFrfwWhC4qQFPJIghOeUqeJT
         ysas2heqKUP9VtndeCISOl7KesRIBaxznxTxW8xdf30o+q/4lZMyO4ozqlgdsSrbRp/X
         8spQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5YA/MOfolXJPvMEVQj9jnAPXpz1ajxwa1dvuffhzezrMBCshdB8kq+MSD0Y5Z3p/md24D41DIk0z1p7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAxxga1dUi7+0btg0MYTDtG/lMmVM8KhbFqDiBT5N2HpRPmFG
	nxw8A55D80rMOReVRq0he+vg/8qmMY5ehXp5NIi+l6Nxkly/AHHfJPIBBemLOfTlpTKGm8CMZip
	EvP7d3X4dZEC6RQHEa7gf68r7vU2iNH04Bhpq
X-Google-Smtp-Source: AGHT+IGZLeBKv3CMMAwWol2fV8fxptjq88r8Yrtm01DrODCf8SauDZd7ISG+PN303isiBbUK4suCZa1K107RgC107lI=
X-Received: by 2002:a17:902:e5d0:b0:1eb:3f4f:6f02 with SMTP id
 d9443c01a7336-2020600ae4dmr794735ad.12.1723777852732; Thu, 15 Aug 2024
 20:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815142212.3834625-1-matt@readmodwrite.com>
In-Reply-To: <20240815142212.3834625-1-matt@readmodwrite.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Aug 2024 20:10:40 -0700
Message-ID: <CAP-5=fU4Lv76Yv5HdhPZz4woZuZ-WMemEC3vGpKJgKhwqrE_rg@mail.gmail.com>
Subject: Re: [PATCH] perf hist: Update hist symbol when updating maps
To: Matt Fleming <matt@readmodwrite.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kernel-team@cloudflare.com, 
	Namhyung Kim <namhyung@kernel.org>, Yunzhao Li <yunzhao@cloudflare.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 7:22=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> AddressSanitizer found a use-after-free bug in the symbol code which
> manifested as perf top segfaulting.
>
>   =3D=3D1238389=3D=3DERROR: AddressSanitizer: heap-use-after-free on addr=
ess 0x60b00c48844b at pc 0x5650d8035961 bp 0x7f751aaecc90 sp 0x7f751aaecc80
>   READ of size 1 at 0x60b00c48844b thread T193
>       #0 0x5650d8035960 in _sort__sym_cmp util/sort.c:310
>       #1 0x5650d8043744 in hist_entry__cmp util/hist.c:1286
>       #2 0x5650d8043951 in hists__findnew_entry util/hist.c:614
>       #3 0x5650d804568f in __hists__add_entry util/hist.c:754
>       #4 0x5650d8045bf9 in hists__add_entry util/hist.c:772
>       #5 0x5650d8045df1 in iter_add_single_normal_entry util/hist.c:997
>       #6 0x5650d8043326 in hist_entry_iter__add util/hist.c:1242
>       #7 0x5650d7ceeefe in perf_event__process_sample /home/matt/src/linu=
x/tools/perf/builtin-top.c:845
>       #8 0x5650d7ceeefe in deliver_event /home/matt/src/linux/tools/perf/=
builtin-top.c:1208
>       #9 0x5650d7fdb51b in do_flush util/ordered-events.c:245
>       #10 0x5650d7fdb51b in __ordered_events__flush util/ordered-events.c=
:324
>       #11 0x5650d7ced743 in process_thread /home/matt/src/linux/tools/per=
f/builtin-top.c:1120
>       #12 0x7f757ef1f133 in start_thread nptl/pthread_create.c:442
>       #13 0x7f757ef9f7db in clone3 ../sysdeps/unix/sysv/linux/x86_64/clon=
e3.S:81
>
> When updating hist maps it's also necessary to update the hist symbol
> reference because the old one gets freed in map__put().
>
> While this bug was probably introduced with 5c24b67aae72 ("perf tools:
> Replace map->referenced & maps->removed_maps with map->refcnt"), the
> symbol objects were leaked until c087e9480cf3 ("perf machine: Fix
> refcount usage when processing PERF_RECORD_KSYMBOL") was merged so the
> bug was masked.
>
> Fixes: c087e9480cf3 ("perf machine: Fix refcount usage when processing PE=
RF_RECORD_KSYMBOL")
> Signed-off-by: Matt Fleming (Cloudflare) <matt@readmodwrite.com>
> Reported-by: Yunzhao Li <yunzhao@cloudflare.com>
> Cc: stable@vger.kernel.org # v5.13+
> ---
>  tools/perf/util/hist.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0f554febf9a1..0f9ce2ee2c31 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -639,6 +639,11 @@ static struct hist_entry *hists__findnew_entry(struc=
t hists *hists,
>                          * the history counter to increment.
>                          */
>                         if (he->ms.map !=3D entry->ms.map) {
> +                               if (he->ms.sym) {
> +                                       u64 addr =3D he->ms.sym->start;

nit: we normally put a newline between a variable and the first
non-variable line of code.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +                                       he->ms.sym =3D map__find_symbol(e=
ntry->ms.map, addr);
> +                               }
> +
>                                 map__put(he->ms.map);
>                                 he->ms.map =3D map__get(entry->ms.map);
>                         }
> --
> 2.34.1
>

