Return-Path: <linux-kernel+bounces-322607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06173972B69
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799EA1F257ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7599C18756D;
	Tue, 10 Sep 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BhhXNrKZ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437B1862B8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955312; cv=none; b=HhaJ1wqgMOKdjExy0wJb/mTJX2NgtHEZwc4y3QgeE/UjcYvmZ9cnMKUiWmVOYcprt8YGWIg4cKt8N07nS8380lvaCF6lj/xU5zt4OLe3WEEwOel/FHScZnksna0cJG5wSNvmJf/y4Slc2DnbCiG0i+DxcVtUxehRRNsORXByEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955312; c=relaxed/simple;
	bh=fliTI4ku+2nc6L0W4Ad5abYeryIU2dtOv5FKC4kJkK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJWEFNyWYLoTSBmcsjJiqUEC1Q6mji86XRxD/gG6PM3hk2IutDGra/KuOSBWrvOeoiJ81NqhfvrFxrq8wDXSERlNZ58saJHfSm3/GJj3KFm1P0y7Gnj0zAKkRwRG0Wgmaq2AndR7f3Js1P8CZJIe1WjTOksKVyXfo5641LRRKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BhhXNrKZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32971cso692737a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725955309; x=1726560109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2HXx27vJakYic9aWVU4rnACS7qhR7kcJ+b+F6ySTEw=;
        b=BhhXNrKZKMyH5EYGWHxI7GcKp70lPmaUhfb6a9GN1k4FTbgK8Gbbj1fhXr/Y56oLh6
         au7L1tiVofZBQdVbA2EViHZig7w8DdFdwkvo/P8P9rZRHAGAyr9RKbd5k6tEFK+1uarI
         bUaTyBndq5SLuetqE3MD56Iy+jpF+JHLRYKXadc1DA0oJLl8b5RGVjRPkcxuDB7+5hq+
         txCn6huZpxJGoa48Og0y6IqN+DHrAQQ4uiJue8H/k2a6r81jdSyDHfk3OIvuHOForliB
         mcxKZBM3vr6JEsoH+kIzODeqg5FOW3ix3Cb0aYmtWgUK3IVt8PDwOY/nUMgcwwl104wY
         SlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725955309; x=1726560109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2HXx27vJakYic9aWVU4rnACS7qhR7kcJ+b+F6ySTEw=;
        b=PGuM61YYbs2H5b6GpLAy90b5V29a7XB3qEjFAiJjDDbBXMupFVR6+uloRTDgQF3J0d
         KIr2LA21sqwmTLlR8pXCpTMC59TjL1FiWEL+m9+Q1sLuVMmGqqkoTqiGWbl+IVTu3wcX
         7xLKbBc2rjQRrRbgsNna9zAf+NgKb3hUII11k/89VWMg6jN5uLttJJ7mGssTLngk/yvu
         KkxdgfwZyw6S6/sY7aI74jGx7JjvwQq0E/4eZK6m/cKKb4Y52QYI/qOUlD+7VHd1WgfW
         ne183iLp0tdqf/QZOL7mPtCaA9x8A6/5yAjYOQxfVtWWFvxbDSNbDfS0HzJoV8ysS6Y6
         qXxA==
X-Forwarded-Encrypted: i=1; AJvYcCVG7Yww+C5m6hwcDPRJmY3KALLvoNhzapNrjuyI6CTZE10335+lD+0z6S8SmJOpGrvueX6QO085uNFIM38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1rFBRA2eM315fnu5+kFPd9Jc3DPOFXbl84EMrZIlxFFY7CKg9
	sSs+0eC6xMTYYw/zTinLHZZ7y6Gndkxe3Leh8lHqU69VMSe+OraxfUpquExOqKA=
X-Google-Smtp-Source: AGHT+IHr3avMGlJNYFmUlmiQLM7eBFWFezrmyKcnEv8CK4mGzrZPx/NLsrObWoaM30sj+QoeSNwPww==
X-Received: by 2002:a05:6402:42cb:b0:5a3:a4d7:caf5 with SMTP id 4fb4d7f45d1cf-5c3dc7c9cc1mr7089291a12.36.1725955308754;
        Tue, 10 Sep 2024 01:01:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm3962515a12.51.2024.09.10.01.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:01:48 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:01:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: zhang warden <zhangwarden@gmail.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] livepatch: Add using attribute to klp_func for
 using function show
Message-ID: <Zt_86rOMJN4UFEk-@pathway.suse.cz>
References: <20240828022350.71456-1-zhangwarden@gmail.com>
 <20240828022350.71456-3-zhangwarden@gmail.com>
 <alpine.LSU.2.21.2409051215140.8559@pobox.suse.cz>
 <ZtsqLiJPy5e70Ows@pathway.suse.cz>
 <B250EB77-AFB0-4D32-BA4E-3B96976F8A82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B250EB77-AFB0-4D32-BA4E-3B96976F8A82@gmail.com>

On Sun 2024-09-08 10:51:14, zhang warden wrote:
> 
> Hi, Petr
> > 
> > The 1st patch adds the pointer to struct klp_ops into struct
> > klp_func. We might check the state a similar way as klp_ftrace_handler().
> > 
> > I had something like this in mind when I suggested to move the pointer:
> > 
> > static ssize_t using_show(struct kobject *kobj,
> > struct kobj_attribute *attr, char *buf)
> > {
> > struct klp_func *func, *using_func;
> > struct klp_ops *ops;
> > int using;
> > 
> > func = container_of(kobj, struct klp_func, kobj);
> > 
> > rcu_read_lock();
> > 
> > if (func->transition) {
> > using = -1;
> > goto out;
> > }
> > 
> > # FIXME: This requires releasing struct klp_ops via call_rcu()

This would require adding "struct rcu_head" into "struct klp_ops",
like:

struct klp_ops {
	struct list_head func_stack;
	struct ftrace_ops fops;
	struct rcu_head rcu;
};

and then freeing the structure using kfree_rcu():

diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 90408500e5a3..f096dd9390d2 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -149,7 +149,7 @@ static void klp_unpatch_func(struct klp_func *func)
 
 		list_del_rcu(&func->stack_node);
 		list_del(&ops->node);
-		kfree(ops);
+		kfree_rcu(ops, rcu);
 	} else {
 		list_del_rcu(&func->stack_node);
 	}
@@ -223,7 +223,7 @@ static int klp_patch_func(struct klp_func *func)
 err:
 	list_del_rcu(&func->stack_node);
 	list_del(&ops->node);
-	kfree(ops);
+	kfree_rcu(ops, rcu);
 	return ret;
 }

With this the function should be safe against accessing an invalid
pointer.

> > ops = func->ops;
> > if (!ops) {
> > using = 0;
> > goto out;
> > }
> > 
> > using_func = list_first_or_null_rcu(&ops->func_stack,
> > struct klp_func, stack_node);
> > if (func == using_func)
> > using = 1;
> > else
> > using = 0;
> > 
> > out:
> > rcu_read_unlock();
> > 
> > return sysfs_emit(buf, "%d\n", func->using);
> > }

But the function is still not correct according the order of reading.
A more correct solution would be something like:

static ssize_t using_show(struct kobject *kobj,
				struct kobj_attribute *attr, char *buf)
{
	struct klp_func *func, *using_func;
	struct klp_ops *ops;
	int using;

	func = container_of(kobj, struct klp_func, kobj);

	rcu_read_lock();

	/* This livepatch is used when the function is on top of the stack. */
	ops = func->ops;
	if (ops) {
		using_func = list_first_or_null_rcu(&ops->func_stack,
						struct klp_func, stack_node);
		if (func == using_func)
			using = 1;
		else
			using = 0;
	}

	/*
	 * The function stack gives the right information only when there
	 * is no transition in progress.
	 *
	 * Make sure that we see the updated ops->func_stack when
	 * func->transition is cleared. This matches with:
	 *
	 * The write barrier in  __klp_enable_patch() between
	 * klp_init_transition() and klp_patch_object().
	 *
	 * The write barrier in  __klp_disable_patch() between
	 * klp_init_transition() and klp_start_transition().
	 *
	 * The write barrier in klp_complete_transition()
	 * between klp_unpatch_objects() and func->transition = false.
	 */
	smp_rmb();

	if (func->transition)
		using = -1;

	rcu_read_unlock();

	return sysfs_emit(buf, "%d\n", func->using);
}

Now, the question is whether we want to maintain such a barrier. Any
lockless access and barrier adds a maintenance burden.

You might try to put the above into a patch see what others tell
about it.

Best Regards,
Petr

