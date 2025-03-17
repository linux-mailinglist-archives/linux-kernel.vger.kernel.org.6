Return-Path: <linux-kernel+bounces-564507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BC5A6565D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A30178C90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588324DFF8;
	Mon, 17 Mar 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZbCAX+1"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289824A065
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226299; cv=none; b=RN84p3vs9wo7S86/15tzxjqEKNGL87VI1LMk+cPnfoLQVju34J4swjyiwjpC82O4+KSh73w873mSAC6kif5UCZptyL6OlmAKiXVZm0/2eFJDlLFMmkp/MZBnGATHNEIPjU+SkmQKVLVn2cWSupXcwHig9ywtnVXiTIjtLB9Y+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226299; c=relaxed/simple;
	bh=B7c2Y4z7IK0bBAMEZDkwYzdnnQzcprBQKAjnqLj21q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpXisL5FyRJb2bQd+ka4EmWqILvbvWLS4aNvg7+zDqBlkpppfquitVq2+d5SMW7zLHo+eqB3YbBxg/px1AX1CYGhmu3PUXNUoEuLKWf5tVTOx+vw2fXXUtnSAmClbGm40lZ9emH01aEomH98LeSN/ti6gtqv9h7xSWmgmJquo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZbCAX+1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2242aca53efso28785ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742226297; x=1742831097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5OlWZyikCPnAOFdTXmrFoSKCph7ASBwIJqix8Eg/aE=;
        b=dZbCAX+1sLjbXQTIk9r0UdbgZYRaprOx0pfAcMLf1Ls7dZ3mU88gwgLywjE9lWHaOf
         bN5CfVG2u0Mglv5N33m/y0cq/ABBP9YvKNQKBcVF1ehdKkmJfwS7pMqWjZ9mD+B88dcg
         XsLXEe03ZIwE1EkYUJWfFspOzUGhI+868fI8ra8YchkMBywLEGp81SEQybi/58A181Sy
         qRQ61mqr9crNT2wJy3gc5NHrrnhTPCaQrcOskLWvlZoMWXI21yrQeUSNfcM2sF4t0vGu
         oXL31eT+9qkbDEC7rPEbicIkxQBY2nMoNME8KYorF4yrXepBqIRPiv6riEtRDCLp3gOP
         3mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226297; x=1742831097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5OlWZyikCPnAOFdTXmrFoSKCph7ASBwIJqix8Eg/aE=;
        b=gQAf5+Eat1pZp6gNEc1CXpATyo6Vblmg22CykgjGCnNogkATjbEa1d1kXXs4pn3857
         m4iSZxQLXVDR6BFyL+zBbo2fRaXAfeDCixuwTp7KSo/TVOXsqyFgG2OcQJ+PZgxaDi2x
         b4D6uEMWMB2X9e2a+KbYXWNU4AhElROkn9YmJWx1ZIoX6iZQrFHna02KdpFv9oulPzHE
         WgPNF2yKhoyPzc6MYrmxzVpTL1LcftcnqkJV+nXv2vyzxnF9yABgQDTFrTmwsCHvqTot
         7UCpQB6+MRhVmFh6LcbGI5dhvRipD4hxB95GvsRLFJjlVq+BuYTeRIPyl8DBiS/Xs+6n
         zovw==
X-Forwarded-Encrypted: i=1; AJvYcCWWm3M/7cDoaRB5qHzz4Am0BJ3kHC3EdmzAP9iLUntUFIpmBdRfhu3G0uhPJhQ1MsTc8DIppA7o9aaBXC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6c2v22vQuYRdfVkN+vWhnwl9e69tIzMYUliOZoMSVDd01LosZ
	yFo0vSXFjGNi+WR7+eHubR+5oC4e3RGYQH/Egl98oYPkub46q1yWvAikSQ8N1djbjW8VoGSb79u
	BILuyfkQMovYw/9OlBZeAXSR1n64iAVVOCrsh
X-Gm-Gg: ASbGncsRzlkaK7V9qJ9uyNlFkLtzygXlrgvdEI9pEftaxTJz7t1azCLxtE7lOt8Bwhb
	N76VPGF+yj5BlA08yyvSJDAWwY67/vmpXa6FgCUjc7iYO99W/jF3BQhLOlyIwMGqssH0ogeYha9
	zo4Q7lfbflT4CSPOlvf+wginBIaLn0P5NBrWgNiNdjGhZlVFwXFXmyWr85M7ld3MwwJw==
X-Google-Smtp-Source: AGHT+IGb0tr+WMR0R2Hjk0TLnVrUU7IZXnn3I3kas5Z1APzQmiaDhx10WNGGrH2KC7JMGKhAtZ+1THBL+g9PhbnHb/Y=
X-Received: by 2002:a17:903:1ca:b0:21f:56e5:daee with SMTP id
 d9443c01a7336-225f3c14a1dmr4314055ad.6.1742226296645; Mon, 17 Mar 2025
 08:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314031013.94480-1-yangfeng59949@163.com>
In-Reply-To: <20250314031013.94480-1-yangfeng59949@163.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 08:44:45 -0700
X-Gm-Features: AQ5f1JqBFu4brBFu6Z-rnLiPVDfXVpZSM1gOcQjfzmMkaZh_omo7Liv21m0A-X0
Message-ID: <CAP-5=fUPz9R60Lay=k-0k5Q8C9AdStAMycOgsKqA5MJ_o7Ag3Q@mail.gmail.com>
Subject: Re: [PATCH] perf kwork: Remove unreachable judgments
To: Feng Yang <yangfeng59949@163.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 8:10=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> When s2[i] =3D '\0', if s1[i] !=3D '\0', it will be judged by ret,
> and if s1[i] =3D '\0', it will be judegd by !s1[i].
> So in reality, s2 [i] will never make a judgment

Sgtm. Out of curiosity, was this tripping a compiler warning? If so,
could you provide the details?

Thanks,
Ian

> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/perf/util/bpf_skel/kwork_trace.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/kwork_trace.bpf.c b/tools/perf/util=
/bpf_skel/kwork_trace.bpf.c
> index cbd79bc4b330..9ce9c8dddc4b 100644
> --- a/tools/perf/util/bpf_skel/kwork_trace.bpf.c
> +++ b/tools/perf/util/bpf_skel/kwork_trace.bpf.c
> @@ -80,7 +80,7 @@ static __always_inline int local_strncmp(const char *s1=
,
>
>         for (i =3D 0; i < sz; i++) {
>                 ret =3D (unsigned char)s1[i] - (unsigned char)s2[i];
> -               if (ret || !s1[i] || !s2[i])
> +               if (ret || !s1[i])
>                         break;
>         }
>
> --
> 2.43.0
>

