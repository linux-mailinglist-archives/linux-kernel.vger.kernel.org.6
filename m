Return-Path: <linux-kernel+bounces-323704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C97974230
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B36B220B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE5F1A4B74;
	Tue, 10 Sep 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwgej9u6"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145EE176226
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993024; cv=none; b=exSGPN1aC9dvS3OK671iWSktqr26S7vnIP9c9Gu9ygI7xgrfuw4KZ1T9i13IyJbqSOq6SpB+rUb4WcctW1IdS6mTg658sfXob/gE3XQS9nCR6gWgHKVGPEolzlqy5pZXbYJaXce3Uxsjkhpi/81RjUREQu9zSy9E77WjGRvxvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993024; c=relaxed/simple;
	bh=g3w3Tso/v/0w2ygisx+WBduPcsMuiZqkxxm3w8elGhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMOc6AduJSvjDwN13UM1i/iBQ+58TiAndjxvSkaRJEqRP2ZbjE3OccCixYtwHwKptUoH3Ma0tTXmN2GUVbq0mnL+wJRg39ITgJZJYon6xnXwb2xugnPVfoF1Xwpuuzg7JA1COPdylwQbgYXcESWbT6s86SSTIVi9Gq8TqdwcwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwgej9u6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso570365566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725993021; x=1726597821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8v5Hd0GafvR7eRw+F0b/pQqT5Z7153+Dlo66ZdBXwCc=;
        b=fwgej9u6OEaSODOdjmtWHSy36aVJ7bx12nrjcs5c9nia1ycC1CV67feJHQ7FE54lBa
         Fa2cGwt2b5X9C8j78JWoNcbKu1UgzPX4YGOxlku+onfJFRp3vwLVhhlffTyk8aWCwzTf
         8gFHOelzODZFTR1QyS9kS4V45SKB8RBjySgjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993021; x=1726597821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8v5Hd0GafvR7eRw+F0b/pQqT5Z7153+Dlo66ZdBXwCc=;
        b=Fzb8n8IO1VkDi9Fd/uMt3J+XUub8rbEmQMtKJaQybLemGwaR9xB8X2n3OZCx6YFgdf
         Jc4ToBaCwjVJuBf7Ro4uBf7Zwap2IMKP+75SRsAg2Yk/SOU4MlQyPvtJfarl1XzSvxRC
         /1iUAYjt6ash8IOLdHfixLIlQZA/i41+ZuHZPB+jFQKwOwNqU+QHnDiK1O9j/j3+Z/VU
         obY8OgiURpNAZrs406I6qHfg9r8+Pwh11lIR9SQOkPsi4JOof2TeXhV4E0Gj0RAm2Rlx
         mSMEqR71DRadM1Hb2pptf/ljx3DoMhuspAG+C/chgEjQCfNafGTBZOJCgaJobuvnFgxF
         8j1g==
X-Forwarded-Encrypted: i=1; AJvYcCUvXMqnZPGG2isS13mFjN9XizlmzR4NimLTReg832rjjruRn7h6qAW4ZfejL91ma5EMoqPUE+FYIDXxVJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXE8Lolx6a9A/yH6LxjyskKCaRm7wj9qlhn3dZ3ZI5A3akeyFd
	b9Bkwnk31IJZl7hhv3o1sI7Bne9gvYk9iEGm27+CtUL9mMbKAtxWf/QOhxrdDCoSacgfk5jOSdG
	kCg8=
X-Google-Smtp-Source: AGHT+IGKHFl8y4Lhmq6cEC12FPkH1HbcomiKIgWaSwrezXmiVfvGTxWx89RrG3O7UwVRD3lDh2YD6g==
X-Received: by 2002:a17:907:7210:b0:a8a:3e73:3316 with SMTP id a640c23a62f3a-a8ffae0b8a4mr168169266b.65.1725993021163;
        Tue, 10 Sep 2024 11:30:21 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25951020sm512737166b.66.2024.09.10.11.30.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:30:19 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c26b5f1ea6so7321406a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:30:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4MyIqchn8WgQe5nX9j06dbFYdsrkY4NEgEmndTYwEeyrthbAFh65BY071f8yH590NFUHOrJ8++EoXaao=@vger.kernel.org
X-Received: by 2002:a05:6402:34c4:b0:5be:cdaf:1c09 with SMTP id
 4fb4d7f45d1cf-5c3dc7baef3mr12220681a12.28.1725993019011; Tue, 10 Sep 2024
 11:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org> <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
In-Reply-To: <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 10 Sep 2024 11:30:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO9kMbiKLcD3fY0Yt5PJSPD=9NVH0cs=xQFSk8dU9Z1Q@mail.gmail.com>
Message-ID: <CAHk-=wgO9kMbiKLcD3fY0Yt5PJSPD=9NVH0cs=xQFSk8dU9Z1Q@mail.gmail.com>
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Netdev <netdev@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-ide@vger.kernel.org, cassel@kernel.org, handan.babu@oracle.com, 
	djwong@kernel.org, Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 10:53, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
> af2814149883e2c1851866ea2afcd8eadc040f79 is the first bad commit

Just for fun - can you test moving the queue freezing *inside* the
mutex, ie something like

  --- a/block/blk-sysfs.c
  +++ b/block/blk-sysfs.c
  @@ -670,11 +670,11 @@ queue_attr_store(struct kobject *kobj, struct
attribute *attr,
          if (!entry->store)
                  return -EIO;

  -       blk_mq_freeze_queue(q);
          mutex_lock(&q->sysfs_lock);
  +       blk_mq_freeze_queue(q);
          res = entry->store(disk, page, length);
  -       mutex_unlock(&q->sysfs_lock);
          blk_mq_unfreeze_queue(q);
  +       mutex_unlock(&q->sysfs_lock);
          return res;
   }

(Just do it by hand, my patch is whitespace-damaged on purpose -
untested and not well thought through).

Because I'm wondering whether maybe some IO is done under the
sysfs_lock, and then you might have a deadlock?

              Linus

