Return-Path: <linux-kernel+bounces-570436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45316A6B04C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F5116EFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB8A2222DD;
	Thu, 20 Mar 2025 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5ZEHGzb"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477E220687
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508497; cv=none; b=Qgnteo6xAGKXvMGWWlq/XQZI2mp2b8wp4L6HLlOKSk3AzCmNU09can221i6XwKmcsnPMEle52bv9NR4ROU0A7tIz5wwBBjBRd9U5ZnC/sDhb/bR1+Ui0ryZxUn/iND6whAM62f5p/oiDTBo2E2Gj2AFl1HoE6/iuW35nOVpiHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508497; c=relaxed/simple;
	bh=LNJBkeztccnUGdSFNTCKHMpe1NBW3yewsHYARTHwKgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJQDKAQJvbDjJyCx5QLgZPxrRDd6zzIZp4ANWnCqd1Y3bYTkFKhRDpNVPllskjt+cMEzgl8aykMhGqgOsIViiQEsWsCn8STJQ+ASYMsIQbYDMGUk+N/3LFXwRTwjx+Zwk4bccxnFMwb5dJlDWhi9FhbX878vFguzFyWRb2JblBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5ZEHGzb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240aad70f2so89435ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742508495; x=1743113295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNJBkeztccnUGdSFNTCKHMpe1NBW3yewsHYARTHwKgw=;
        b=Z5ZEHGzbd1z78ljly8LB1Lrn7p6YfFw2N4ZCefKnVgUUUXGhCV/e5vpcwe59+c2MJt
         AOhSRONDRs489Ctg4Fn0O/EZpUQdy32tcu7vqJyY73vMnc3ecNGNrrIHemG5EqJVjWEg
         +Fqof9apMnHr48+Ov4AvT6bqACPkHsEfotWy1h0ECSGfVBo8C6+6CoN8dgCIh7M+shYZ
         FEWAniQP/Hecy6sQ1qbeuSjmDmOYrKfJaBDiYg5a0wddeQETI/d1BVri1/hUNHJofMWK
         aBrBuvugzZOT3b5m1FhqTAfmp/7NLiPUbltd9n18yCe6zY4xkVGTiNe/qJOV/OfxtuWI
         I4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742508495; x=1743113295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNJBkeztccnUGdSFNTCKHMpe1NBW3yewsHYARTHwKgw=;
        b=OP5AAF1d0MX536Ran4+NihXQ7GUm0qpwC4nHGVBBNYCeksgMVPOq/O3jKpEbe8J3Dx
         OJ/r5NAaX5hvYprDBzy3+x/yTr3MbJ5kbqYmzYXL0gEfW6w5NaNRjsWFmnKA/anlX52j
         fjr3siYvrqlITgZtVhZPOFXyWH5TPODUrw7kV2rSynDiUHZfNJBerQNUam50ZK/7pjUd
         H7R2ipAHNx6nnogWMqqfuYof/juTd1cC4fmzd3aI/dg+fpoiaAQXNumY8qpLVvHQJOEf
         MBNiyWyCt50mgXmN2F2WUD9s229HtwgIASuPDwaPcbh+JQe4IHqEXX8tY5TuIQQmEEgz
         uEtw==
X-Forwarded-Encrypted: i=1; AJvYcCXzAHhLt9V9L8YU9GT5Wqcr9q/mZL1UcehYSyJ/WW2/ZvCmKamKtdBjCapJ+4ySnjDyeNndn7zF93I7N7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfTvVMwLCmGiqAnnfpbWYFFWrEZINJlueFrbu4ORxwJXUpkBu
	WdlioislhraNNzTwDlZRy+N63wzvNLyokMVxBKMM/PWbERFWBmPQZj67KXsm0bzpMNn7vDygSK+
	B2pNUobO1NL5F8/tsD2/OspBqzpCGZHgQufjI
X-Gm-Gg: ASbGncuDnA6wsO3FKUXCdtFZd/Z6x0whbGSxkGJSo2jvWpoYZf4Jq10hIaCrJ4yBWfd
	klauhQGlRUXMY3Sr0A8AKOJ2ZDBmoOFw1NgJaWVrZH3rvI5V0bR9PKzsaIYoPscjJvuFIvyLPXe
	MMzbiN1DOpDQ5vL1nK25wTOiy/hS4WQS81SNZydG41Tf6MbCpj8L8MQJM=
X-Google-Smtp-Source: AGHT+IH9UD36zb4z/rqqyTMfzuudB/0Vms8vaWNVXQ8hF61k9eXPkEoYMXmUDWRQNJAA1D5y1EHBvFnB6gV+vW/t9Gg=
X-Received: by 2002:a17:903:228f:b0:224:38a:bd39 with SMTP id
 d9443c01a7336-22781d28abamr790055ad.20.1742508494214; Thu, 20 Mar 2025
 15:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320175951.1265274-1-irogers@google.com> <CAEf4BzYPx-shzhex4CvE=P7bYBudU5GVMK1fNq6Azz=sfBXK3g@mail.gmail.com>
In-Reply-To: <CAEf4BzYPx-shzhex4CvE=P7bYBudU5GVMK1fNq6Azz=sfBXK3g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 20 Mar 2025 15:08:02 -0700
X-Gm-Features: AQ5f1JpqEM2FRi5SeWGbxKXewfp4pp_nMVONie4nJ4pRZhM0d9CVaWiiLSJqKsc
Message-ID: <CAP-5=fVjeDzJOGsDeVxtc=DFLpNPCi3KW4-3VkZENTkT=G6ZGg@mail.gmail.com>
Subject: Re: [PATCH v1] libbpf: Add namespace for errstr making it libbpf_errstr
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 2:37=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 20, 2025 at 11:00=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > When statically linking symbols can be replaced with those from other
> > statically linked libraries depending on the link order and the hoped
> > for "multiple definition" error may not appear. To avoid conflicts it
> > is good practice to namespace symbols, this change renames errstr to
> > libbpf_errstr.
> >
> > Fixes: 1633a83bf993 ("libbpf: Introduce errstr() for stringifying errno=
")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > I feel like this patch shouldn't be strictly necessary, it turned out
> > for a use-case it was and people who know better than me say the
> > linker is working as intended. The conflicting errstr was from:
> > https://sourceforge.net/projects/linuxquota/
> > The fixes tag may not be strictly necessary.
> > ---
>
> sigh, I do like short errstr(). How about we avoid all this churn by
> naming the function libbpf_errstr() as you did, but then also
> defining:
>
> #define errstr(err) libbpf_errstr(err)
>
> and leaving all existing invocations as is
>
> ?

Works for me. I'll send a v2.

Thanks,
Ian

