Return-Path: <linux-kernel+bounces-176185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5188D8C2B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64761F2274A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97413B584;
	Fri, 10 May 2024 20:56:41 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A405026E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374601; cv=none; b=Iq2ndXbNWOLFJuGXyMgsu1Bz5zBINh8ACmDlrEHdgW9Ct/jh7495DYnGiFRaE7Hym2yrBX4NTzPY9wi2G6slL1+kIz8F/xV8xbGACN1QjjYYLX/F2xpwi879VDhzcbaWe4VJy/G66NtupCP3QfSl29PTzQQf1okD4O0ZnEjYN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374601; c=relaxed/simple;
	bh=20fdxSY8P35N+TeJAUwuuBhG3tuU9sbmRtigfWPk2lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okzxaYOKOLYlYwcQJ9JOf+w+WtR0j0+rY8cGXhimk/Hms/X5y1PsnMl9uSsrVB4Ry1nXoY4mbRavQYl/yKlTTpSDmj9UuYVKMg9NGtItnkfvWq5aj8hFGqTA27bQUGuoIpyFmIQJW6O1QFTogOnuJKaOwnDuK+ujR297ddMdfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1649635a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715374599; x=1715979399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zthGc8hxEM0lFVljuJipFQ+idxBW1ZeK/Tyg8rV+/A=;
        b=Rn9XkzTr15NvBQuj3MPhh1dQXUM9aYjuyVcxTJLEYCYJB4ZSPv0rUztGQGNPdAnbYa
         IPmdJvGlh0BYoZVI9pvupSnIMIuP0UAKg3RQ3OwuK60km/o2BTrGIx2q0psjOM3CVefu
         YOQAwKdW0WTvoVrRQ9BuPXrgiitmnZXwEBqcykOP9bf2mnapuVUYbEGwT26wPKnhVW/q
         KRARKVLjf8zBafdJGRk8KUJZvghpKvL7zQfGXUFbNhi4Y/yuR8c5JwmrrXILzrZxXiSC
         mG4mOyDqd2xCXmytetKrvPIgcQw5EgpQDXoDjSorhLN/DxcXXkbzPbxhndOZQfNXCTZw
         /Zkg==
X-Gm-Message-State: AOJu0YyYU0OateMAwC1t3x1kwUIjb/IR/++D1lipD1qSuM0C26S/fRMs
	qZnbhf5Ij0UO9ENzO2BEgbZjaVazDXQaRTMpJbms6S8Y5mgID5CUbPcCpa8wF//cYjTgqU5R85R
	2Z0PJ3BImxMOSENZsGBcck/3W4ty2fA==
X-Google-Smtp-Source: AGHT+IGZPcgnKlkCRXp0cKsRjdwNDdJ0vfA2onQRCuj6uyzzAYkTsEgA5KJGJd9bbTyA/uqjqYDPh/kevzOAiy01ix0=
X-Received: by 2002:a17:90a:9318:b0:2b6:24bf:6b19 with SMTP id
 98e67ed59e1d1-2b6ccd6b99fmr3618083a91.31.1715374599118; Fri, 10 May 2024
 13:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zj4x4g0avd6ZW8Jl@x1>
In-Reply-To: <Zj4x4g0avd6ZW8Jl@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 10 May 2024 13:56:27 -0700
Message-ID: <CAM9d7ci6Y98hkiN1+=Q=YgLQLL-GN+pTxQ1JjqA+Q1EMEi52+g@mail.gmail.com>
Subject: Re: perf annotate --data-type segfault
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Fri, May 10, 2024 at 7:40=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> root@number:~# perf --debug type-profile annotate --data-type -i perf.dat=
a.perf-trace-bpf &> perf--debug.type-profile-annotate--data-type.perf-trace=
-bpf.output
> Segmentation fault (core dumped)
> root@number:~#
[SNIP]
> 0x00000000006c3fba in __zfree (ptr=3D0x0) at ../../lib/zalloc.c:13
> 13              free(*ptr);
> (gdb) bt
> #0  0x00000000006c3fba in __zfree (ptr=3D0x0) at ../../lib/zalloc.c:13
> #1  0x00000000006728b5 in delete_data_type_histograms (adt=3D0xd151f70) a=
t util/annotate-data.c:1829
> #2  0x0000000000672958 in annotated_data_type__tree_delete (root=3D0xe82e=
40) at util/annotate-data.c:1843
> #3  0x000000000055658e in dso__delete (dso=3D0xe82dd0) at util/dso.c:1487
> #4  0x000000000055673e in dso__put (dso=3D0xe82dd0) at util/dso.c:1523
> #5  0x000000000058289d in __dso__zput (dso=3D0x11fc500) at util/dso.h:644
> #6  0x0000000000583dc5 in map__exit (map=3D0x11fc4e0) at util/map.c:298
> #7  0x0000000000583e03 in map__delete (map=3D0x11fc4e0) at util/map.c:303
> #8  0x0000000000583e6c in map__put (map=3D0x11fc4e0) at util/map.c:310
> #9  0x00000000005854c3 in __map__zput (map=3D0x11fcdf0) at util/map.h:196
> #10 0x0000000000585e13 in maps__exit (maps=3D0x11fb740) at util/maps.c:23=
6
> #11 0x0000000000585f0e in maps__delete (maps=3D0x11fb740) at util/maps.c:=
258
> #12 0x0000000000585fcf in maps__put (maps=3D0x11fb740) at util/maps.c:275
> #13 0x0000000000597d2c in thread__delete (thread=3D0x11fb580) at util/thr=
ead.c:96
> #14 0x0000000000597fd6 in thread__put (thread=3D0x11fb580) at util/thread=
c:140
> #15 0x00000000005c4940 in __thread__zput (thread=3D0x25bb7c8) at util/thr=
ead.h:83
> #16 0x00000000005c8267 in hist_entry__delete (he=3D0x25bb720) at util/his=
t.c:1318
> #17 0x00000000005c5bc2 in hists__delete_entry (hists=3D0xe7f9f0, he=3D0x2=
5bb720) at util/hist.c:388
> #18 0x00000000005c5d10 in hists__delete_entries (hists=3D0xe7f9f0) at uti=
l/hist.c:416
> #19 0x00000000005cc62d in hists__delete_all_entries (hists=3D0xe7f9f0) at=
 util/hist.c:2872
> #20 0x00000000005cc6a7 in hists_evsel__exit (evsel=3D0xe7f780) at util/hi=
st.c:2884
> #21 0x000000000053378a in evsel__exit (evsel=3D0xe7f780) at util/evsel.c:=
1495
> #22 0x00000000005337cf in evsel__delete (evsel=3D0xe7f780) at util/evsel.=
c:1503
> #23 0x00000000005288af in evlist__purge (evlist=3D0xe7e410) at util/evlis=
t.c:163
> #24 0x00000000005289bc in evlist__delete (evlist=3D0xe7e410) at util/evli=
st.c:185
> #25 0x0000000000589c2d in perf_session__delete (session=3D0xe7daf0) at ut=
il/session.c:313
> #26 0x00000000004136cb in cmd_annotate (argc=3D0, argv=3D0x7fffffffe400) =
at builtin-annotate.c:936
> #27 0x0000000000507cf9 in run_builtin (p=3D0xe55fd8 <commands+408>, argc=
=3D4, argv=3D0x7fffffffe400) at perf.c:350
> #28 0x0000000000507f68 in handle_internal_command (argc=3D4, argv=3D0x7ff=
fffffe400) at perf.c:403
> #29 0x00000000005080b7 in run_argv (argcp=3D0x7fffffffe1dc, argv=3D0x7fff=
ffffe1d0) at perf.c:447
> #30 0x00000000005083ae in main (argc=3D4, argv=3D0x7fffffffe400) at perf.=
c:561
> (gdb)
>
> 1826    static void delete_data_type_histograms(struct annotated_data_typ=
e *adt)
> 1827    {
> 1828            for (int i =3D 0; i < adt->nr_histograms; i++)
> 1829                    zfree(&(adt->histograms[i]));
> 1830            zfree(&adt->histograms);
> 1831    }

I don't understand why it has a NULL histogram entry.
One possibility would be it get a failure in the allocation
or it's freed but the nr_histograms field is not updated.

I also found a problem related to the type annotation.
I'll send a patchset to address the issues soon.

Thanks,
Namhyung

