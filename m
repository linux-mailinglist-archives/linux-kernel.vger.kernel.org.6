Return-Path: <linux-kernel+bounces-360933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85399A17C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015F0B2525C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8E3216434;
	Fri, 11 Oct 2024 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2rXEZh+G"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255AA215F71
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642917; cv=none; b=DWaO7wpFA3Lsq2dFbaMj4fhB3xC15QjqrIoglCLBrxPfVY5syfaTsWVgfLHC0vhsVvxkiirwn/4Anuo8yRKDx5lEZNEfS/KEDeV6+PLzQWJALMl9eUWWc2WHaTaBerK2wFhxL2e3iCnHmTsmG/8jbpPp9HhZCHivM2NrAUm5gLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642917; c=relaxed/simple;
	bh=xTSQNzVx1mkE0HE6+lpI9qDDtqpAbAzz+W2S8DPkBOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdnIU1Qa90nsa02HuHyglfA6gmRmiIqRdqtjH/SCxWkXboh0IqOy65doAFywXo09Rqf//do19iFCfDPos3ZuZjkVAOjiycD+rtcPKMb6SPHBy8qMBleuSZpf1pTz6I6ELqOJEx6J0cgTu01VsfHQ/p7kBuZaJnmeZRe+Buq4qXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2rXEZh+G; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2facf48157dso20872261fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728642914; x=1729247714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NphLy95X1fXZbYyERmS8gtB29uHtd/dpodXz4Nr7PKY=;
        b=2rXEZh+GpojnEKgCI3neYw+pMMGYiNb0zGrOjQSrsTgxDOU+D46fb0yRmPuqAsxSiO
         5lxGuC7074Mn6xhgT0aZPJ/3k2leHl2VKD6EMmTXhky6O18S6vOUdMOofFG4amGjctky
         k3exywIsJo74b/Q8wh6ZFxPhLIW0XtctydqFQ93UFiqbUrqnwSnvaZJxqp5fbC9w/hut
         XIdOw38BliVUX0mzrb5+JW89VRs7FiCSsbxygvoWBSjXqhghxYy7V2O8MclWtayBvlbH
         qkCmnqzjsLhdwQ5OQp1IiN6ks9urARx1fUM3ksmI7uv5TK/bYSXpq7hwgBDUwtzQMmF8
         DXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642914; x=1729247714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NphLy95X1fXZbYyERmS8gtB29uHtd/dpodXz4Nr7PKY=;
        b=S3VwnNz7LWtu+FZIau0edIreaLhSSsp79/JxNQI0eNig3Q36TNk8B4gPjfh8vEvCew
         mE9V0G051DiiUO2RHzw12GivVLb98W5uwOKCnXSgHf90dpgzQ4bGKBI20qDdyQeS6PlS
         R5RXpWp5yNsR1Vn8wY7oSusGvIMmuZxR5CYsOdKBAWYCExzb6oKWoEwWKJ2d1p4iRTPv
         hsQqUAXcY5hXkuOmMyG38jhlGnukfHmhGkFHZgIGkngOft7pGGHtSCzgjS1ClVf2EUCt
         QjajlXwUY362xTkCJmaOoxgLs2fxa2c4IHNQ9sfYmVX7/ECYyIDA4Nd0LOmNXE0At34l
         3dhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIHvaVEP5G7ahWVA8fw6UwOTCg3Zq/w4TEkSP5aJTItoZgtRHpZ4TkbV3Oai0Fcz0YTt8VAEIOBuCeAK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8ExUr1jaCZuFW9gYmhFxpqL+3IupcfNyYUetqVFkyJOeA85r
	4ukbyLgMVQG4xbpDlj+HDqMaouNjObku51nPrRoaOOgfLZnvyaHICVaPUdHdecvVdyZuYQqabE3
	ci+QH5uOic11vXO5479zN5q3W9A2s4bewHunDIABKM6cwhEHnsg==
X-Google-Smtp-Source: AGHT+IH31irHrMq4hNzplUlYw533NPegcGVZHsYYk4pFGkC+l3DH+KSU9CCl1KEiQfpInqYhiUGHe1bfiGpVyoqSqjo=
X-Received: by 2002:a2e:b8c1:0:b0:2f7:90b8:644e with SMTP id
 38308e7fff4ca-2fb326ff6b6mr10778371fa.1.1728642914020; Fri, 11 Oct 2024
 03:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011095259.17345-1-niharchaithanya@gmail.com>
In-Reply-To: <20241011095259.17345-1-niharchaithanya@gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 11 Oct 2024 12:35:02 +0200
Message-ID: <CACT4Y+YpgVYNBNn7O9kzKzS=0kViRMAnAzi6xbk0ssJpz2WnkA@mail.gmail.com>
Subject: Re: [PATCH v2] mm:kasan: fix sparse warnings: Should it be static?
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: ryabinin.a.a@gmail.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 12:09, Nihar Chaithanya
<niharchaithanya@gmail.com> wrote:
>
> Sorry about that, thank you for the pointing it out, I understand now that
> compiler might optimize and remove the assignments in case of local
> variables where the global variables would be helpful, and making them as
> static would be correct approach.

It should be easy for the compiler to see all uses for a static var,
and in this case it's only assignments, so it becomes effectively
dead, and the compiler can remove the variable and all assignments.

Fighting the compiler in such cases when we want to preserve
non-observable behavior of the abstract C machine is hard.

"static volatile" may be a solution here. Does it help to remove the warnings?



> Add a fix making the global variables as static and doesn't trigger
> the sparse warnings:
> mm/kasan/kasan_test.c:36:6: warning: symbol 'kasan_ptr_result' was not declared. Should it be static?
> mm/kasan/kasan_test.c:37:5: warning: symbol 'kasan_int_result' was not declared. Should it be static?
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312261010.o0lRiI9b-lkp@intel.com/
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> ---
> v1 -> v2: Used the aproach of making global variables static to resolve the
> warnings instead of local declarations.
>
> Link to v1: https://lore.kernel.org/all/20241011033604.266084-1-niharchaithanya@gmail.com/
>
>  mm/kasan/kasan_test_c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..4803a2c4d8a1 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -45,8 +45,8 @@ static struct {
>   * Some tests use these global variables to store return values from function
>   * calls that could otherwise be eliminated by the compiler as dead code.
>   */
> -void *kasan_ptr_result;
> -int kasan_int_result;
> +static void *kasan_ptr_result;
> +static int kasan_int_result;
>
>  /* Probe for console output: obtains test_status lines of interest. */
>  static void probe_console(void *ignore, const char *buf, size_t len)
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20241011095259.17345-1-niharchaithanya%40gmail.com.

