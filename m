Return-Path: <linux-kernel+bounces-203466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E128FDBA3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B149BB21923
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C7F4EB;
	Thu,  6 Jun 2024 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gE0iGXVi"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA18BDF49
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635081; cv=none; b=Hq1Ne9S1jrTuyTf0ZGuCo/s0EH2MpfCV07EvqCSAigiAiHQp3r7T/FBpjz9cRVP4pXJGmB/ycd7vtAu+McpBrFdEM0xwm6y7Bb77SGgvoWPEzV6Jpg233QGfg+v3NRTEC+YDFlnW+zw6sJlpVGuwWtasAuBg0I8YsLNB9MyZj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635081; c=relaxed/simple;
	bh=GRqVKXcsJh/sEtGC6AlRPdUI8v4SOfb2fFYrbfnYbr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhJ2uGhG5tJm2XqGnij/BrvxizDWZg6A0rU3B9g1H+6j8K951b5F02iU7FRkTsSk4WpTYErmIXmKV+NQA2u/q6ae1QiT8nxsZJoJYcuKNNG5FPAp7zRjMdgVvl3Jxew92H8ecAYftJLvxjl6blFNX3pjd/WXazFUIT3FjT6xPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gE0iGXVi; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa7ab78ef2so528979276.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 17:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717635078; x=1718239878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+cCaO4GQQZF5arDTs75VRTDY7XKwvZ01IHsyj7Khdo=;
        b=gE0iGXVi06pe7FuR0QhaavH2O6oTriEmOVhdj9nmPi2LFrn1e7uyV7YsG0HFqo/q5w
         dOgtnz6n73PZdKTV0YJ/L+3/JdlVGwSa8vHCMfrNY5uhXbarraI0uNj7gGBeXeEWpgDd
         t4xGH8vO6rUKLBW2qaT9FxOrMKGzWXewS5QNgiCO2VAlCEq4vbnzE8C8pSlkJSwnZN7+
         2w72rZgrwJKfI0LOSR0T5gNcdopW707BI8o5Sws605q/ZzbJEznx5UFD1pA4GXVJtl2Y
         IFkXX+cyW9IdYpxOKBfuyI0yYfXzYzXQUsyPIyPZARBcuzGWT6G+FMZBiF8wzGtm1DKU
         HlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717635078; x=1718239878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+cCaO4GQQZF5arDTs75VRTDY7XKwvZ01IHsyj7Khdo=;
        b=PoRZN2YUv7ONcWWU4o3UkeHeK7/22cKslaMy9CpiL1VGXFYu4yJpn/XioYjg8xgNJC
         6hj4jc4r25susPWebFH6/4lOR0wfpYYzHaZurKCUPqc7c/Ln7JBbeleIp8VnymcfZpxf
         wzUFHkxNgzhNSjHOB+OAwa2SbAIMbTMETikzURUJJXeyAq2MGLQBllIgDUN2+hYchfv2
         7TvBJPE3EqzCiyHdzeyoJiWYJ6n3Y71dleBvi6gsSqZFlpuMjkOU5CnlJh1rvXRlbjkA
         wYx9DID9aTwdad83KsjULjf+eT+f5A1ADeD/0bPUPeIkSL8gazZEaG+paSbWmhWMko60
         TJJg==
X-Forwarded-Encrypted: i=1; AJvYcCUR5TgGAEjxHHUdL+Fmxegf02CkLUshdJFUM3H9/NvS/6zdN0sGtPt7ZLHG7mkQfmzO+w4Kz0i+oDV5ru73mwuUCWGt0AmHTC1BQSob
X-Gm-Message-State: AOJu0YyBbxBnWz5rJZsfS2SqkZoUWJI0T1oUm4KOnDr6BppOSwWi7mms
	37/MSlF2gGQ/D4rhYoIczkR6CDBKzOhsBuJiCFIJkvm6RCgG3FJtyG8nsDzJN4eQ/vKTEoJGw1x
	doPHjM0zlqi8hfNatFZClpeTwP1lkAXut71Ey
X-Google-Smtp-Source: AGHT+IEsn/LiMweS6R6p+zt8kRJUiTPyCnADdmFz9d/yv/LTm6IC2uClrAE9Un5+DNW2ZVH+y0uZPZJi/Z0fKwigOaM=
X-Received: by 2002:a05:6902:4c4:b0:dfa:e131:2a8e with SMTP id
 3f1490d57ef6-dfae1313607mr704141276.47.1717635078316; Wed, 05 Jun 2024
 17:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com> <20240531163217.1584450-2-Liam.Howlett@oracle.com>
In-Reply-To: <20240531163217.1584450-2-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 5 Jun 2024 17:51:05 -0700
Message-ID: <CAJuCfpHqDNGM=6+TX4xE-YY91fETSM+r70ZdgxUyw=9X+3qQCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm/mmap: Correctly position vma_iterator in __split_vma()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	sidhartha.kumar@oracle.com, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 9:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> The vma iterator may be left pointing to the newly created vma.  This
> happens when inserting the new vma at the end of the old vma
> (!new_below).
>
> The incorrect position in the vma iterator is not exposed currently
> since the vma iterator is repositioned in the munmap path and is not
> reused in any of the other paths.
>
> This has limited impact in the current code, but is required for future
> changes.
>
> Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 83b4682ec85c..31d464e6a656 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2442,6 +2442,9 @@ static int __split_vma(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
>         /* Success. */
>         if (new_below)
>                 vma_next(vmi);
> +       else
> +               vma_prev(vmi);
> +

IIUC the goal is to always point vmi to the old (original) vma? If so,
then change LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>         return 0;
>
>  out_free_mpol:
> --
> 2.43.0
>

