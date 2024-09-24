Return-Path: <linux-kernel+bounces-337622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75295984C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58C81C213DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46213B783;
	Tue, 24 Sep 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq7tnT5U"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67712C52E
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212096; cv=none; b=ry5Wvk3Ok/Og18YiJ1MCZ/zFm1rYa5DxSeJEVqcDSIIBTU3Sqj/kEv5CT7aWDdd0kbX3vD9j2NxaIFeXTf9oWvDLpSzLqeCVvKH4mX1Z6nz+YuH3vdEs4Ske6NPcTFDSwpCYzgw6zhRN0eRe4+53I71MqMnwAo0QbLbUaARbUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212096; c=relaxed/simple;
	bh=SSMnSNvjgL0HgXS96DbEez/+JL/Fq+TwXsk0eFSypFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NK6Qo2e3wAM/RhXwredL6VIjsgqvxx1Qn/ZJkpPgkO27PBAafWKkg7bgEOusLCdB5WpND8QbPCSrUrRbnm1gwEMOSUVVZkoYz16cS9E9cztXnlT7Qrewh6kS4AfN9f36Ru1Cs0Kqmw495VHxNrnYgSCUj+PNzexNR/0pZaWWud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq7tnT5U; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c34c2a7dc7so39969136d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727212094; x=1727816894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSMnSNvjgL0HgXS96DbEez/+JL/Fq+TwXsk0eFSypFU=;
        b=jq7tnT5UihH9LWQIZQBz4QDtm6kfBCT0QK+DqyOk7XtHZJ3DwFZROtI8y0zQo68gLs
         nUJiJ69phXVaeCk0LBvg5lb+eVPKDPfzF9NNPQ5EdkkdI30sCMHUx5HHywCQiJF1CpP2
         VxhHQj4p+lXgsLMfqlEYXelYN9TmO1e68rFEc8EgIoTPA3589AFa3tzqca0PCRMMpi1i
         6S5l3IC5SpmUxD1RFyN2lKCzo0mcWHOn5RzpAGLSV+N2moSc6pEx5YVlCDm4/8Sx+Qpg
         8HqoGsgEyN5TlJDg4NJGM+Myy+PfnEFOE9OE/7EfifCpfuo1qk7pFHcAXNpcmd0F702z
         UUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212094; x=1727816894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSMnSNvjgL0HgXS96DbEez/+JL/Fq+TwXsk0eFSypFU=;
        b=MM8s5eTaiAn0nSYStYbx/cSgWYwJsOEzAxRydvkss2uG6I4TwzUa+vsAWOnuuV0L0W
         eukvmAOH10dFdlZjFxYgJbhgH9H+vZisxV6ECHz30ISbrtSSLcyoLcYg4DVCgfcVZX/s
         +vTHi9EjAiFCp1hzR9Cd3EbAupR16XDXEqwmPQZRFC6ZaJHo2nfI//EKHtJcKlWKPPtd
         VWqN5QXb/7lkWQtlEu/cygycvxEtTCh4rtptdvFj5lkYtpmX2fGUunCdJD/1bI27nyhw
         NSexUARjpDcbJ7puP7B9VbwWTpM0HnUjvScB8GHnTBIhIC1vM92C1DiADQcYS3pNJfyZ
         9+Sg==
X-Gm-Message-State: AOJu0YyGxhU6RbjnjcwOZOnTEnBv44TcRAM+AjQlXJzgLl4QxKfjQ3CV
	RxULX5h/604zYtgprRkwRRro8o11y9rKTYgh7Ka+A2D1TtPQXEgvLSznETzzI0yaFUMGy79AiSf
	MB4k5ItlIwvVx40fGpiyfYBVHtkM=
X-Google-Smtp-Source: AGHT+IGCmA3qvUzok96RjQDT3EVBAau3Kny/vhALAySBV+fIqKJa/T0yPs6n3+jE90A8DTwCuoza26XdQx2gDjspogc=
X-Received: by 2002:a05:6214:451e:b0:6c5:a2ca:38b7 with SMTP id
 6a1803df08f44-6cb1ddb34bbmr5289676d6.27.1727212093984; Tue, 24 Sep 2024
 14:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAKEwX=Nw_ax0RRSaD9n3h1vqbu+5PEuur3RqXrMrYyvOPuzB3Q@mail.gmail.com>
 <SJ0PR11MB56785712C0EF98B7BE558720C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56785712C0EF98B7BE558720C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 14:08:03 -0700
Message-ID: <CAKEwX=MgpP_w6JFC5ahVN-erCWK2NDGSbxNdLxKg9P4yd01Unw@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 1:51=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> This is an excellent point. Thanks Nhat for catching this! I can see two
> options to solving this:
>
> Option 1: If zswap_mthp_enabled is "false", delete all stored offsets
> for the mTHP in zswap before exiting. This could race with writeback
> (either one or more subpages could be written back before zswap_store
> acquires the tree lock), however, I don't think it will cause data incons=
istencies.
> Any offsets for subpages not written back will be deleted from zswap,
> zswap_store() will return false, and the backing swap device's subsequent
> swapout will over-write the zswap write-back data. Could anything go wron=
g
> with this?

I think this should be safe, albeit a bit awkward.

At this point (zswap_store()), we should have the folio added to to
swap cache, and locked. All the associated swap entries will point to
this same (large) folio.

Any concurrent zswap writeback attempt, even on a tail page, should
get that folio when it calls __read_swap_cache_async(), and with
page_allocated =3D=3D false, and should short circuit.

So I don't think we will race with zswap_writeback().

Yosry, Chengming, Johannes, any thoughts?

>
> Option 2: Only provide a build config option,
> CONFIG_ZSWAP_STORE_THP_DEFAULT_ON, that cannot be dynamically changed.

This can be a last resort thing, if the above doesn't work. Not the
end of the world, but not ideal :)

>
> Would appreciate suggestions on these, and other potential solutions.
>
> Thanks,
> Kanchana

