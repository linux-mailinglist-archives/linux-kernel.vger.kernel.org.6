Return-Path: <linux-kernel+bounces-429800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF29E2526
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C683E2842BF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B421F75BC;
	Tue,  3 Dec 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMr2nK4m"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA71DE8A5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241447; cv=none; b=F9DWkpIWBlYHBFJfLcXgpesGO4PfdVo5VW1axH0k04W2afyPh0cS1l9jKCWcnVNV1xwQ+gkF0AgdZdHD6KEGgOlM22ENqR8XTQmf4m495u/X/HCOcO/jlb347FBS6mzTP6cJvroPr+tulrhCZ/t123UK/MCBKtMSlvzOX89bKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241447; c=relaxed/simple;
	bh=iPlCzvq7qA7SjQOv3uoOyKl2HPUxNOtMX+MKgm7tvBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1+XopXb6P4Pl5AooWpyaVA4ZAp+jzrxGX9DyE26meZYacVM01NHulzqiFBhUuRjIKfJD11t+VGI0YQ+ablG/ffp+ezCynWJItbwSDcMuXKatty+r/SkN+8+131wFLIUwoZiIzq/mel/00nVCwV7rkuTpLePmc5jS+Otwg2Hnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMr2nK4m; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa549d9dffdso914785266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733241444; x=1733846244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPlCzvq7qA7SjQOv3uoOyKl2HPUxNOtMX+MKgm7tvBA=;
        b=DMr2nK4mzNhQIfifcHhzobBX0LUpBWcSHjnf6wvTziszVaxzvjlAHqYSbDRTF5k/kd
         EWKvVY9VKoGdpeTJ+IT+3qatEYckc0HHpD9CBsIHKv2OMIgLSYXBeQpj4ZU3oWUe+VP7
         DhRqZWtgcWnfuzrNYW5mZ0ZjXkQzaN1O/hTaccM4S95Y5RH1E5pO0k81f9jgXshS8+xm
         S9MFXdIpSGX2VH3EM613acoSkRBzewBlXaRWKZHfU5Z6qBWFPXdudS0YX7dxEZPItGQy
         XFnONsj0GRWhl74uK21iztqHeZF2lXdKpIR9Vodf9MPgx3NC62N4URy4p8cmKmJn8ntp
         bfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733241444; x=1733846244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPlCzvq7qA7SjQOv3uoOyKl2HPUxNOtMX+MKgm7tvBA=;
        b=buXQZewgIsFDute0M9ELd5vCz3vJ3AM2azLZC7ZZFIWoBk/dE/xLXlVVassHRcY9/Q
         olhrYzMFkWR5gycnWC5K1SFMZtNMSl1nwo8fhHVhLXOwx5mihc6RMuOPqjIL/1SSMiBR
         qAOaMb1EilrQrE4JRbTk+iy8FuX03AbMU/j/FQDDTyf2Uc6Tdtz4knqQ7cAbWOFzebTr
         Ym13/f+b+5Lq21oKo1ihh8rsyUhV8TiqcTP81p4IK3RH1XTdiM9d1dXB3n9GKS5NtY5L
         +mO7uDPIlGRCEsJ8GbSYws7dlyDXLCTiJheHh/Gb0CJAaCIqiBEdQtNKqEp+UxS1JpV9
         cjow==
X-Forwarded-Encrypted: i=1; AJvYcCUBnZbzrKwLEHZz8JTs3KB0Ha4pmDczfCaGEXbew3jRvL/FDeLS6hWD9k0RPHZma6sbPUuMs/p+Hn/Bc4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUu2rGdlKAA0FNmMW5z1e6WRgdDv28hd1VWVbuGINWRT+HBQOu
	o9WxoA9yr9P4QE1VWqHEZL7nmG/wmR3pnj3psaywsVAakWJWwZYzUe7c8TlFpEK8qiaI+lD9L5x
	yd9EqgtqO41CmFn/DYEWidSUF+S7KzQ==
X-Gm-Gg: ASbGncs2cQZlPgVE+7XdaZgdgskvb3oQZ7jH5jm0HsqVdi8nz5bULHpp2rZUcvOW1VJ
	EIXeBy0WvY/aVAtYpSmENzBoRptQB
X-Google-Smtp-Source: AGHT+IEktfjPAdnGxP6AI0+aCF/E8iIwO2Lqz92yHebx5GuURUqRsvaBvH/X8RbQ7dENd6xTLTmSr5kwTWPgLTKuglc=
X-Received: by 2002:a17:906:328d:b0:aa5:d96:c57f with SMTP id
 a640c23a62f3a-aa5f7d199f4mr216720566b.20.1733241443902; Tue, 03 Dec 2024
 07:57:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202202058.3249628-1-fvdl@google.com> <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <CAPTztWbmkFisL7qnmAnre5hv=UD1E60P0hr_kXNyLoQFy9OoTA@mail.gmail.com>
 <Z070YE81kJ-OnSX8@tiehlicka> <d1f224fb-c0fb-47f9-bea8-3c33137be161@oracle.com>
In-Reply-To: <d1f224fb-c0fb-47f9-bea8-3c33137be161@oracle.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 3 Dec 2024 16:57:11 +0100
Message-ID: <CAGudoHGY_NEJe6Pp6rv91v8p--phSX32C5Pm55c6jpUAJFLKmA@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>, Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, Muchun Song <muchun.song@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:26=E2=80=AFPM Joao Martins <joao.m.martins@oracle.=
com> wrote:
>
> On 03/12/2024 12:06, Michal Hocko wrote:
> > If the startup latency is a real problem is there a way to workaround
> > that in the userspace by preallocating hugetlb pages ahead of time
> > before those VMs are launched and hand over already pre-allocated pages=
?
>
> It should be relatively simple to actually do this. Me and Mike had exper=
imented
> ourselves a couple years back but we never had the chance to send it over=
. IIRC
> if we:
>
> - add the PageZeroed tracking bit when a page is zeroed
> - clear it in the write (fixup/non-fixup) fault-path
>
> [somewhat similar to this series I suspect]
>
> Then what's left is to change the lookup of free hugetlb pages
> (dequeue_hugetlb_folio_node_exact() I think) to search first for non-zero=
ed
> pages. Provided we don't track its 'cleared' state, there's no UAPI chang=
e in
> behaviour. A daemon can just allocate/mmap+touch/etc them with read-only =
and
> free them back 'as zeroed' to implement a userspace scrubber. And in prin=
ciple
> existing apps should see no difference. The amount of changes is conseque=
ntly
> significantly smaller (or it looked as such in a quick PoC years back).
>
> Something extra on the top would perhaps be the ability so select a looku=
p
> heuristic such that we can pick the search method of
> non-zero-first/only-nonzero/zeroed pages behind ioctl() (or a better gene=
ric
> UAPI) to allow a scrubber to easily coexist with hugepage user (e.g. a VM=
M, etc)
> without too much of a dance.
>

Ye after the qemu prefaulting got pointed out I started thinking about
a userlevel daemon which would do the work proposed here.

Except I got stuck at a good way to do it. The mmap + load from the
area + munmap triple does work but also entails more overhead than
necessary, but I only have some handwaving how to not do it. :)

Suppose a daemon of the sort exists and there is a machine with 4 or
more NUMA domains to deal with. Further suppose it spawns at least one
thread per such domain and tasksets them accordingly.

Then perhaps an ioctl somewhere on hugetlbfs(?) could take a parameter
indicating how many pages to zero out (or even just accept one page).
This would avoid crap on munmap.

This would still need majority of the patch, but all the zeroing
policy would be taken out. Key point being that whatever specific
behavior one sees fit, they can implement it in userspace, preventing
future kernel patches to add more tweaks.
--=20
Mateusz Guzik <mjguzik gmail.com>

