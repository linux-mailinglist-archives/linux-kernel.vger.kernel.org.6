Return-Path: <linux-kernel+bounces-274355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C85B947720
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D3C1F2176F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5300814C5A1;
	Mon,  5 Aug 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bN0DA2vy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4C14AD10
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846252; cv=none; b=bwCEKPqXv1J9q4hTcYc1AGDpkbkTZ87kA2lUYGo+PrCQ4hrtUpCjl7njCxhVB7nsyC53I18D08bk1mOyHSo0kfChrsGsTAPFA9f3mbwS6M2GPAiVL+X+qSKkIcvX+R2so0OZsZJv91rkrqCJqTiI4whXEoIA0QuwwmH5o3AWqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846252; c=relaxed/simple;
	bh=MZC/JUb0Bd5ny5AOzMQmgwCXo1oUUPkAQl3rIxUYCGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzUJ/Z3KcLXAPn5g+lq3kMXjjaZqCi1Hmhvos2PIFonb3+0r204nld4mDaUYjfBV9tPHYLqwJl0qo7uB9T3Hg3iR5WBSroyFKTqoIWxlmTEImHgWBzD5fzK7c9qlsKTZ8TxJtSmjmeHjnZVGHUrgofiCDmxf07Cv5KXgMy2RLeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bN0DA2vy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722846249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZC/JUb0Bd5ny5AOzMQmgwCXo1oUUPkAQl3rIxUYCGA=;
	b=bN0DA2vy/umL/1s5x/nrMtqJjSmlcKWYnG4z96/HgmC/UFFKoJRQ2W4y58rBuw/cpTOOvQ
	0XuQB9B3KgLX4wylo+6fPUiS7R623zG/JUGyLg4pFnat+2WvwaoZZyMN7w0q6Hh461zih3
	R0VY6sO18FhSCoi9DtK5xW4vgFQaZHA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-EwabBB71OoWdrGTTjvaE5A-1; Mon, 05 Aug 2024 04:24:08 -0400
X-MC-Unique: EwabBB71OoWdrGTTjvaE5A-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb4d02f34cso10306967a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722846247; x=1723451047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZC/JUb0Bd5ny5AOzMQmgwCXo1oUUPkAQl3rIxUYCGA=;
        b=W7b3EMi28mRe+vjOmOrxA++GIcN0l6pZlbbIksM9c9UMi6IZZ/Rjauip0Ni1B5FMD5
         8XeizYrdmajKw2Aqz6XmJ5JLYQzKV6TCvidvg7n0ZNbABBBk0GAzHLBmGQHmGoSLVAVu
         Nq9nhQX9OaQFxbK7dbjtNkRbv2SeOxbpznQkfqr0Uhe7nRWDQWNY46tUUItWha2uc6f8
         RvrLbd9fq9idaks06hun02Dct7XsSRxaFQ3WHvnF+V68KYYiSig/UV9YnONG2O5ak6hk
         T0arxpgkxMhBcceMdGthjEWrTHyvnVBotI+oNaqAkQ+wBxeoJKv8om1Dvgr9OMfGS52y
         q4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXMxWdMzxNH+L4h8z0fcd1GMRmUIkv1GH8T/4QmvGONKO7bbuIyHVRTgvcVmjd3oHdqvaDeBxxVNmrmRpRPlVBNq+DSZBTa2dSrk+hO
X-Gm-Message-State: AOJu0YxRNuWUCB0Z0uTBKmf0rfn0QogZwoYvWS7eIE5SM/o7fQBxqqxm
	5icFk7NvGj1qSEnTcsB9KsooIE4iQrutreH6y9WLINd4EutcZAJjXHMjYBvRugDD1leYPvpzU54
	+hGZFjN50I6hhPRL0jQy+lmgKT7XaB/LLHJnyTgaeN76Q6Gvt6KPesXmFqjCUd/+GaTMb7hKA9v
	G3gaLKSuyT2XYiNV67MahIm4/N1riadPEgCaRB
X-Received: by 2002:a17:90a:7846:b0:2cf:c2df:67de with SMTP id 98e67ed59e1d1-2cff93c59f0mr9462394a91.9.1722846246918;
        Mon, 05 Aug 2024 01:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOSNr/tffEf9orQJMuzIpDgMZ45fJMrYavKup4rOkDBdZro389KPHkDEY8ZwIfz9x8bfEImYDLvFDJMKuW2qw=
X-Received: by 2002:a17:90a:7846:b0:2cf:c2df:67de with SMTP id
 98e67ed59e1d1-2cff93c59f0mr9462370a91.9.1722846246368; Mon, 05 Aug 2024
 01:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com>
In-Reply-To: <20240805082106.65847-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Aug 2024 16:23:54 +0800
Message-ID: <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: xieyongji@bytedance.com
Cc: maxime.coquelin@redhat.com, xuanzhuo@linux.alibaba.com, 
	jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> Barry said [1]:
>
> """
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> __GFP_NOFAIL without direct reclamation may just result in a busy
> loop within non-sleepable contexts.
> ""=E2=80=9C
>
> Unfortuantely, we do that under read lock. A possible way to fix that
> is to move the pages allocation out of the lock into the caller, but
> having to allocate a huge number of pages and auxiliary page array
> seems to be problematic as well per Tetsuon [2]:
>
> """
> You should implement proper error handling instead of using
> __GFP_NOFAIL if count can become large.
> """
>
> So I choose another way, which does not release kernel bounce pages
> when user tries to register usersapce bounce pages. Then we don't need
> to do allocation in the path which is not expected to be fail (e.g in
> the release). We pay this for more memory usage but further
> optimizations could be done on top.
>
> [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
>
> Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buff=
er")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

Note for YongJi:

I can only test it without usersapce bounce pages as neither DPDK nor
libvduse users use that. Would you want to review and have a test for
this?

Thanks


