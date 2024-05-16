Return-Path: <linux-kernel+bounces-180678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9998C71AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928781C20DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67982F3B;
	Thu, 16 May 2024 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/fVSDIr"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1D171AF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715841341; cv=none; b=s4gUnNL8KX0X0pvtOyaedhQCw7IUoGG0WCYaRTBjJaPQ2QxT5juFrTvandXvynVi1c6jE6MtDITcg5A83ZBXcp/YRU70PAPRKSqrmigb32ydZWpuBqY7zmdm980+beD0XoYjeXK4i3p0907WxeeVgmNcWOLTiNp7jAwoynFOjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715841341; c=relaxed/simple;
	bh=4qYPgB7w3VWHV5nxyHVEaF4494UUC1haBn1zRSaJ8Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcc2KtsFuIXdwZiaRSWkanphSK7fdPNnPlIRCP+9vpJzuzz0LNDNBXM3+RxSqKwvIF4uzjm9KDDGW+jr35r/hc9NoETIlqOGsEvHss8/pOBe38BkZnbDHoP4SZ7mP9dr3bsJsRNUC+R/fhoecUzzGaNdUB/LHgGoOf4yyCXgSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/fVSDIr; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-47f3e985a84so2702157137.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715841339; x=1716446139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bmfXEWdtGqKswH9Xu4JgGerg0k5E2Nij58vjYt+4SMk=;
        b=j/fVSDIr1fv4dg62OLMX+mJF4ZPwXWPZzWV7Vk3yARcSBOKcIAlee4CEWYwIPp+O0b
         14TLIHZdOw4+Dd0x1I8ZQJBbpesP4eKBn9jb4KuwJl2Mfn4Y6NQtg4zRH3gaNEhdvbVm
         dQT+qSUuB8zWjXbDpA4LrTpA6vq9C6hAMDgrNx+kYiAYznBeElgj/QHl18gkoiZmgc8B
         VI5fLUxRVmOfr6fVLVjka7F4RUwc2/o/thg1wwOA8vuBFxf+BKmPRWFeWQUkHqaX7jjB
         +3u34d8Zei5zLf80rKcNtLtVWvUsV0oo8GrSkr5kIoanozzuvGX5MGhWi/SWSryKT2D6
         BLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715841339; x=1716446139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmfXEWdtGqKswH9Xu4JgGerg0k5E2Nij58vjYt+4SMk=;
        b=Ja/A6KZ6kZfwAUlMCFgowRGDGY/VMX/vfMRPXii7Z9CtclcI97cVf78WtDveRfALC7
         wTQDjsgzKYQzDvyYSEGRDND5ekFZbbP/deVFtDo9gxahdEOTzB25rW3fO2jt5C/4aSCq
         YypUYQMELAtx/57Ld6yHVJY8zmLfxGQ8mw6mdeJx51T7ece68dRyloOhF43Rrd9Sa2ZG
         oxL7WQ8sicgPmpCwwxnddpmXLTM1H5VlpuVru1uplSmZ3xhNBjXSiBv+3Zld+kPMxEMz
         5K6M9X2c50hWDrWaJtF8nkctqFlUKphbuFPN4OI5xwptPkV/cNLfKF+0EiDG+XnVIoUe
         gsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNUXaC/zpC6mn5cFnd8Y8PrMd3amYjbakXPVnHKVMgdphO5DonwQs9XRCazdGoBhFDkJT0/hXP5dDHDLMwW8UDuiDrp6JjnrlAlJdy
X-Gm-Message-State: AOJu0YxNkF++jSCLbiopgskEXonUuVJC1W52HqQBGUxvX2LPMJYp+LCq
	Uxj7EPxW3IvK6KMAgb30QcGdVjwiwYViP2Lfy6c2f67bSF2XRd0fI8OpTcO97UasO+veeXuclie
	ji3BF1EI7C3JA5PhyAwsZ7ZL1NWHiPHl3m8et
X-Google-Smtp-Source: AGHT+IHlDQ/eBAofLlOUojbiT4Ni38v9AQ8HQ8GEW7AT/J3jdp0eY8vVJPIgTi6v40/0Xd25DHGwDvZXK48eXKzavgU=
X-Received: by 2002:a05:6102:a47:b0:47e:ee4b:5e83 with SMTP id
 ada2fe7eead31-48077e87f61mr19122474137.25.1715841338556; Wed, 15 May 2024
 23:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
 <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org> <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
 <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org> <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
 <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
 <dd251dba-0a63-4b57-a05b-bfa02615fae5@paulmck-laptop> <CANpmjNMqRUNUs1mZEhrOSyK0Hk+PdGOi+VAs22qYD+1zTkwfhg@mail.gmail.com>
 <75421237-4c5a-48bc-849e-87a216ee9d32@paulmck-laptop> <CANpmjNM-Cg12qCU3WoLeBboogLQVgn4znFerRwD3BVAFMc9BiQ@mail.gmail.com>
 <d9df8351-7cc2-4562-a8b5-440344bfeb91@paulmck-laptop>
In-Reply-To: <d9df8351-7cc2-4562-a8b5-440344bfeb91@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Thu, 16 May 2024 08:35:02 +0200
Message-ID: <CANpmjNO+WDF804s49VdCf2=3io5Uh=8ZbM_jiW5j1rcbcONbUA@mail.gmail.com>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
To: paulmck@kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 23:51, Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > And I just checked the current access-marking.txt to see where we
> > might add more, and found the section "ACCESS-DOCUMENTATION OPTIONS"
> > already exists. I think that section is perfectly reasonable as is,
> > and it does explicitly talk about ASSERT_EXCLUSIVE* macros.
> >
> > Did you want to add it more prominently at the top? If so, maybe a
> > brief forward-reference to that section might be helpful.
>
> How about like this?
>
> ------------------------------------------------------------------------
>
> The Linux kernel provides the following access-marking options:
>
> 1.      Plain C-language accesses (unmarked), for example, "a = b;"
>
> 2.      Data-race marking, for example, "data_race(a = b);"
>
> 3.      READ_ONCE(), for example, "a = READ_ONCE(b);"
>         The various forms of atomic_read() also fit in here.
>
> 4.      WRITE_ONCE(), for example, "WRITE_ONCE(a, b);"
>         The various forms of atomic_set() also fit in here.
>
> 5.      __data_racy, for example "int __data_racy a;"
>
> 6.      KCSAN's negative-marking assertions, ASSERT_EXCLUSIVE_ACCESS()
>         and ASSERT_EXCLUSIVE_WRITER(), are desccribed in the
>         "ACCESS-DOCUMENTATION OPTIONS" section below.

s/desccribed/described/

> ------------------------------------------------------------------------
>
> Would that work?

It works for me, if we agree that "negative marking" makes sense: if
the other markings indicate the access is happening concurrently with
others, a negative marking does the opposite.

Thanks,
-- Marco

