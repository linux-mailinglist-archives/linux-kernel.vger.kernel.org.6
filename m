Return-Path: <linux-kernel+bounces-180373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69688C6DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134031C222E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7FE15B546;
	Wed, 15 May 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzckX8xk"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C915B544
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807672; cv=none; b=kwALLSukS5Zg/01r3ntq8PkmfjnlsfAy+zaalmu3uA/A4Q24aVT45a/mqLCKtVFH0xAKmc8Y6kTaXMUxxxclIdJ6tbTRc58gCipLaXRCC2nAgEFrnzWU6dNAfa+Bmjuy1Zy6UZ9jlyiEzxMzoSsDGx+VinJMnsyhC+dIOqBCWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807672; c=relaxed/simple;
	bh=KaRp03zPMicROwGMtQ24BK5CzqpLG2F6m7G378tiArU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJVYZl0BVbM6gLFTTs13qAhdldcm+QIzUl1lwGa3dvvlrgp6aYxtx59b191VoUDz2YUEJM+Bv3HLpejTxC7+9IupCfq9hK6hvyHcfnYcr5Yx+W+Qkb1PmRnzD92EXozgDMS3O526jO/KlmugeProTf7rUyygN1k1oELezf53UHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yzckX8xk; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36db863679bso91425ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715807669; x=1716412469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASfis+VjxPRoonpfr9uzosJOMgG1sBNuU5vYcng9bn8=;
        b=yzckX8xkL8Zki6q6lA03WU1eTmHEcdNNp9EJzOxq0ruAVkfW1KBaSLL0s4eP+3bMoH
         69qzgHkqqb6OJt+mpYFQmZLzvpvi8x9cg3veE2XEs+Mw54/09xMh1mvU8lXvitD0b89S
         MEkm/Culk27XWANSOYK7MC0cVyoC1TRBCMySoemH5hM0zaVNiPuwrVOaYo9hesajWBFJ
         Gd8moZKuFhjPVec4EDRlPHGXP2CMAomyVVVShR6eIKRo2HBbb7pm9n1z732PwfY5clvh
         DCvs0RK01hH/PykPj1VVHPRaSVXKm/4BLVsiB3cFjgQ2mJSCxJU5yWH78zuwkmYLOw/p
         0+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715807669; x=1716412469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASfis+VjxPRoonpfr9uzosJOMgG1sBNuU5vYcng9bn8=;
        b=rZ7Sj1b3HndGXwYnqi4nvMfi64EG3nTAiOaUAsiX9YXp+fcGwRh0UMfOJFyS1QJilR
         do8buBIGGfWmNSoLW0m+GS9Pg5OB78UL6JPn3KNA5qjdSY4m5OS+YeBowByTWVApl0yj
         yt1O1TZCFz+mYzvbumfe52ZtYf8fF+PuxG6o1dv55zhpLMMP54jZ5HY9O0sMksYzfilg
         agXfdW9ITRB5IU+9Shy+8g3bbPxC+8VJYDhIuJhuUJR2WlB9cAX4HlZVCnOvg9qAwr8K
         Wn7NRBX/sdqgm7diuSqOy6tecZTygPCZmqgGXeFK/WDXqjNHCNsz0F35Rn1c2UNIAOwH
         4Eow==
X-Forwarded-Encrypted: i=1; AJvYcCXDvvyohX+fI7aer9Ah9FPL6K7mfaS/e1DFPiKY7cUz3NgdOcDDoLBJjZBh7wfX5j3Towcq+VP52mCYFPfsRLyLk7a93vkibGscyEBQ
X-Gm-Message-State: AOJu0YzQRJNjbdosgd7XxW7160FTtvWrxUTJ1Zj0BxO/vmcCAZs5LYwF
	3/BrgDKTdVBpC4aSZ+OIBJetCDMnwQUbYAMcWESeNCdOMpt1nk+8wApimPCKP+kowwNszNSoqJa
	1TGDtFBeipxt9RBfXqgDF5Kf9S5cbIf3jE+Dc
X-Google-Smtp-Source: AGHT+IGrRZmlO1u+WsKnjcXi/EjMPXEXONMgggY4vksZMB23Kb/hjAKD9NLqszxPw7VV9kUKvixDW3AxzwgJfmVDrqk=
X-Received: by 2002:a92:de03:0:b0:36d:b340:330 with SMTP id
 e9e14a558f8ab-36db3400540mr4953095ab.26.1715807668933; Wed, 15 May 2024
 14:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515182750.489472-1-samasth.norway.ananda@oracle.com>
In-Reply-To: <20240515182750.489472-1-samasth.norway.ananda@oracle.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 May 2024 14:14:15 -0700
Message-ID: <CAP-5=fWBVwnhoeCtDTvHqZ6SGeOLAhD2GrshCRnwUvnNdyApQA@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf test pmu: Fix file Leak in test_format_dir_get
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: namhyung@kernel.org, acme@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 11:27=E2=80=AFAM Samasth Norway Ananda
<samasth.norway.ananda@oracle.com> wrote:
>
> File is opened inside the for loop. But if the 'if' condition is
> successful then 'break' statement will be reached, exiting the
> 'for' loop prior to reaching 'fclose'.
>
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
> Found this error through static analysis. This has only been compile
> tested.

Thanks Samasth, I agree with the fix however this code was recently
deleted and isn't in our next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/pmu.c?h=3Dperf-tools-next
the change that removed the code is:
https://lore.kernel.org/all/20240502213507.2339733-4-irogers@google.com/

Thanks,
Ian

> ---
>  tools/perf/tests/pmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index 8f18127d876a..f751e6cb6ac0 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -106,8 +106,10 @@ static char *test_format_dir_get(char *dir, size_t s=
z)
>                 if (!file)
>                         return NULL;
>
> -               if (1 !=3D fwrite(format->value, strlen(format->value), 1=
, file))
> +               if (1 !=3D fwrite(format->value, strlen(format->value), 1=
, file)) {
> +                       fclose(file);
>                         break;
> +               }
>
>                 fclose(file);
>         }
> --
> 2.43.0
>

