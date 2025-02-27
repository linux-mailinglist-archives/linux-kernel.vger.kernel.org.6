Return-Path: <linux-kernel+bounces-535658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A69A475A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FD6166DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD252165F1;
	Thu, 27 Feb 2025 05:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wYkf3whD"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AFB2153C5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635907; cv=none; b=pNFS66oIZJZ3QQVkL0uB/9HanUaxb4jhwyzaO7i31Exo1xeNVBtbssq3PYr8yGQpyGT3pk44+mr0YPaBRrG9u13jrSFe9zvIs7cEuj8YWlIu7vHWKwPfjnw9emZ3GZEqL9aUD3MC0BAGgxveuPN905KFYXhjGarT5MjfaCKIeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635907; c=relaxed/simple;
	bh=U9Ko2CfUZgT3zHFGlYgdOTRrPtH1+klh5OcX47iEFGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG19c9mt94+MvWCJ66zGCVkwWx/sdLeLdQZGi/NFwYeYzpkEvVPcKBsZt0eZd6F3taF3/KjPIXqkT5M89aGhCbE7Qi6PYI98vxNHna3lVMxRsbOldQuk0/8dem21eZbkps1TgOWOq0/0icJ5dCqySWGy8W1Yre1KSYk+TN6XdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wYkf3whD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22342c56242so116155ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740635906; x=1741240706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ+4Hrzy1g8jVUQp2XV3I6mnhjf3pzaCYd6tUG9vrrU=;
        b=wYkf3whDSDacXsgv6n69Ns6HgxcwtjVLWoUqS7NTI7wEe0Um5JWeUssSbafsqRJc52
         JOr1u33otUCghTidYFWx/SuwJ+rmRRKTubSqAdclQM59yzCrMGzy6y02164pEz2XQqsE
         6CP2JAKM9vaNAItLsUFo2QrcjLKE4VIIYhHZLjkJ5+y1Ndf3v+OT56GYralxIz2hMZ/D
         rvXE5r2Q5OSQG1P2ueOAdnKHQ/s3c1+1iviNxm692wB2hSc45pYg5uwfzJz2xCJLAEpm
         Jf++31wUZRJyks8gUYJbjml7vvZv55ZEMpnHTSt12fLSBBuIbzJ3Jd3c4+C6rrRTrS7X
         B8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740635906; x=1741240706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ+4Hrzy1g8jVUQp2XV3I6mnhjf3pzaCYd6tUG9vrrU=;
        b=J0VSqGWtbfqa9VBvUMykgPdDARi+BfpTyfvI5G65vidNuxEl8+r4sWAUrVPrSSiggN
         io8T8BBOCyZoGBR4rlu7Y4nTI26/0tKjSuHWFBzrwQ8xXlDEr/dpMKVSQ88QIrM5u3v0
         UhvuVT4YVgL4sqX+uXcxKWIlPC7ipWwjOyKEu2UMWjdY69/64SHXxHH/tvS58Xv6w+H+
         LAibt3ijBj8l6yybnQ3Oz+oivmC3Jf9lqTE2rTa5+eOs3qT6u4cIaBuF8itnlyLeMoab
         bnGCfkUF33nu7BgSuqcU/DPfsq+WlJMTiL8+Qvqvg3e1Do6SY0fWrt4u0TnEDURz15bJ
         Uxpw==
X-Gm-Message-State: AOJu0Yx133opcXho2z95+8vAPGRq2hjLmc49F4eeNYz9kCBop6ptuq7E
	xdpVj1FijKds4J53S05bu64k7OtrQVbPjmz1RodnSUGXsnlKxpinXL86meZsaT9y/hrcG9vFeWL
	76jBeUVMttL/RWTZdssxcyrsOOwH8SrS1dSwR
X-Gm-Gg: ASbGncubfb78gy0ITuSkSVo1rfPM9ncN7qt57VC/DYpGWNe6MogQEcNcCR+C6yeD4o/
	jyOsuR5AUwZfUK7I+3+xJhBOSDFGq2jyPVZKSCOjd1Vlat/XtXMJPKmLf/276/LI66+rg4Aq/e5
	rKsjx+PCsL
X-Google-Smtp-Source: AGHT+IEnx+T2EUYhLV7nL60SOcHwmiEcQVNvKhtLADVhI0BTbEjofGbl24Xg7WDkyW8AGRZUt7Og/o9Yj7psZgpByqQ=
X-Received: by 2002:a17:903:2647:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-2234d3abb47mr1940025ad.0.1740635905615; Wed, 26 Feb 2025
 21:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227053738.788153-1-ctshao@google.com> <20250227053738.788153-2-ctshao@google.com>
In-Reply-To: <20250227053738.788153-2-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 21:58:14 -0800
X-Gm-Features: AQ5f1JqtUPNTMgd57t0SN-iYHsb7gP8rKfmuINbHUyod6nt66X-e0k-Ap31iJXc
Message-ID: <CAP-5=fWqa_yKDC5F6TBc0AFH1BG982Zu_rr+7=xAj1rqarUj-A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf record: Fix a asan runtime error in util/maps.c
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com, 
	dvyukov@google.com, ak@linux.intel.com, james.clark@linaro.org, 
	christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:39=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> If I build perf with asan and run Zstd test:
>
>   $ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g -fn=
o-omit-frame-pointer -fsanitize=3Dundefined"
>   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
>    83: Zstd perf.data compression/decompression:
>   ...
>   util/maps.c:1046:5: runtime error: null pointer passed as argument 2, w=
hich is declared to never be null
>   ...
>
> The issue was caused by `bsearch`. The patch adds a check to ensure
> argument 2 and 3 are not NULL and 0.
>
> Testing with the commands above confirms that the runtime error is
> resolved.
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/maps.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 09c9cc326c08..41a99e1f4b50 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -1042,10 +1042,13 @@ struct map *maps__find(struct maps *maps, u64 ip)
>         while (!done) {
>                 down_read(maps__lock(maps));
>                 if (maps__maps_by_address_sorted(maps)) {
> -                       struct map **mapp =3D
> -                               bsearch(&ip, maps__maps_by_address(maps),=
 maps__nr_maps(maps),
> -                                       sizeof(*mapp), map__addr_cmp);
> +                       struct map **mapp =3D NULL;
> +                       struct map **maps_by_address =3D maps__maps_by_ad=
dress(maps);
> +                       unsigned int nr_maps =3D maps__nr_maps(maps);
>
> +                       if (maps_by_address && nr_maps)
> +                               mapp =3D bsearch(&ip, maps_by_address, nr=
_maps, sizeof(*mapp),
> +                                              map__addr_cmp);
>                         if (mapp)
>                                 result =3D map__get(*mapp);
>                         done =3D true;
> --
> 2.48.1.658.g4767266eb4-goog
>

