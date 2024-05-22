Return-Path: <linux-kernel+bounces-186474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4338CC4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F873B21F66
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52556773;
	Wed, 22 May 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XHF/wrZ4"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0221E517
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394107; cv=none; b=jbrRyQS+YBvMF6vtfP7PdYDvuofewMRLB1eg3ZfMK/iANMH9iKb60eQAmlXlojIjN0zc5mEhpcSQQEmV5hg9c9EThCQ/IasFxLTqnwhrWQSRGYJ3fYXPyay5EooOkT9bER7niNLBuoMGz9V5vVMIb9AEyuMylcxGUcf2xWMiTMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394107; c=relaxed/simple;
	bh=yf2T1NRUeRDA4sbzbywAhB4cFczq2ILeF6v0legvArI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDqW+lnmk1JllYCkvlHKvCVVgqQAuAbfe16vgapoAln8+IkNncRnA7toygxlMiLnefjr/9hWKxJbxUZ28IXyEMxaU9ljEvu3LYbJaaZNYpWno1WMSQ2/zoDTBWqzPt8dyq1xIzreXeogVo7QnMeNRtw01IalfbGJ4CiPb7NCbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XHF/wrZ4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so8229767e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716394103; x=1716998903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEeqNZMxqfKYuQmEXCXsoXwHfU4Me5x6oZXofMLyGCs=;
        b=XHF/wrZ45GxeZL8Jp5Ev8EbiBZ5wAZ3zSboBqpoFkr99zLq10V4cR8SYptLaZhC9or
         3QhVd2jAIk+Y4EnOHDCKber4EpjVqhgvU+YMRdjV0iXm9+iCs2EoU/60RrUs/O2QPazW
         8w6JhvfaPqvL2GZDPsggZYpLspwILzFm22K8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716394103; x=1716998903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEeqNZMxqfKYuQmEXCXsoXwHfU4Me5x6oZXofMLyGCs=;
        b=mzNkMD6mvkk8pIBYbWfm1GJHt+2sXTyixw7YHtKleSl0dw/8GsbQiLCfxe08utGc0a
         MpVkyZH12/yZum6Mm6zOwpXCHlFjik0fuP0grxvdnGXYxze/18Nov34jvKEIWt/nUy/7
         qdX0szGQcHJWJQ5BYJ3GSzSJIp85kSl989w/BG0z47+COWLCH8ihI0u4oM90aIeiFMGc
         gNnCFZhHn6n0YJqdtewYdIHwpFfVbil2mbHJMjV7GQqFJDTYg7FRWb8Ua2bwWEBAY+AI
         vyvYhSZFwLEb1EVCczrbKpyF+BtBnzGhzFhBYJQSiXou8pZN2tvVgq2gYLwEgvnrzsqL
         Oezw==
X-Forwarded-Encrypted: i=1; AJvYcCWh8A53UlJ53h/SoRUNmcUksV74f/cxpv7mBR7V2TYcQ1LDTZYcInTbP0RU1dLRG6I/Che4qAKWiFAolqn+J3GDCAX9jVU1uhOY5B2E
X-Gm-Message-State: AOJu0YyRHr6Q4TcMFxaBUQzpq9NOIYUa+KyZIfKo72J7vEl6sfpGrVFk
	zVyvwKe8dxfI/1kxKr8kK7uU+K7s0CepVQxfd7tiUQz63avKWbsbThve8KZXUAPI+gNRUnR86Up
	/TKhsZw==
X-Google-Smtp-Source: AGHT+IHCIVzfl4tEsUhUfNNAAqySRm70vWlAOJWYNmIcv0AaW33bQI2KtQSDS9Nsq3BZGn83ICQHwQ==
X-Received: by 2002:ac2:4c33:0:b0:523:8d05:1610 with SMTP id 2adb3069b0e04-526bdd47da5mr1200516e87.20.1716394103061;
        Wed, 22 May 2024 09:08:23 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-523ba138259sm2341885e87.269.2024.05.22.09.08.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 09:08:22 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so8229735e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:08:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKoEcZTDyvkNfT0skSRSZNBxyffi8mprJUptJPluUF8qZ6Lco5H+Bbf7DwJvtxvL+uou++tAKbL2cgOJ4kzS2QK2v/lsSsHwIUJzze
X-Received: by 2002:a17:906:d101:b0:a5a:423:a69f with SMTP id
 a640c23a62f3a-a622806b4c9mr166102266b.9.1716393621105; Wed, 22 May 2024
 09:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515091727.22034-1-laoar.shao@gmail.com> <202405221518.ecea2810-oliver.sang@intel.com>
In-Reply-To: <202405221518.ecea2810-oliver.sang@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 May 2024 09:00:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2jGRLWhT1-Od3A74Cr4cSM9H+UhOD46b3_-mAfyf1gw@mail.gmail.com>
Message-ID: <CAHk-=wg2jGRLWhT1-Od3A74Cr4cSM9H+UhOD46b3_-mAfyf1gw@mail.gmail.com>
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
To: kernel test robot <oliver.sang@intel.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Waiman Long <longman@redhat.com>, Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 May 2024 at 01:12, kernel test robot <oliver.sang@intel.com> wrote:
>
> kernel test robot noticed a 6.7% improvement of stress-ng.touch.ops_per_sec on:
>
> commit: 3681ce364442ce2ec7c7fbe90ad0aca651db475b ("[PATCH] vfs: Delete the associated dentry when deleting a file")

Ok, since everything else is at least tentatively in the noise, and
the only hard numbers we have are the ones from Yafang's Elasticsearch
load and this - both of which say that this is a good patch - I
decided to just apply this ASAP just to get more testing.

I just wanted to note very explicitly that this is very much
tentative: this will be reverted very aggressively if somebody reports
some other real-world load performance issues, and we'll have to look
at other solutions. But I just don't think we'll get much more actual
testing of this without just saying "let's try it".

Also, I ended up removing the part of the patch that stopped clearing
the DCACHE_CANT_MOUNT bit. I think it's right, but it's really
unrelated to the actual problem at hand, and there are other cleanups
- like the unnecessary dget/dput pair - in this path that could also
be looked at.

Anyway, let's see if somebody notices any issues with this. And I
think we should look at the "shrink dentries" case anyway for other
reasons, since it's easy to create a ton of negative dentries with
just lots of lookups (rather than lots of unlinking of existing
files).

Of course, if you do billions of lookups of different files that do
not exist in the same directory, I suspect you just have yourself to
blame, so the "lots of negative lookups" load doesn't sound
particularly realistic.

TLDR; I applied it for testing because we're in the merge window and
there's no reason not to try.

                 Linus

