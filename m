Return-Path: <linux-kernel+bounces-258085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8D6938347
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 04:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C740D1F214AF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 02:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD3A20E6;
	Sun, 21 Jul 2024 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNEvd74m"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9B17D2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721529596; cv=none; b=Prq9J0I2CSOplpy0+inaZIkryoViffr0gRv8E0Obo7DVuhaOIv1L/zaUNsVLfMZVYbEUUFJI1oaWObsLnEEH9jE4kjxuPJw44LOsJj3DsWqjPp4XjAKXbx7ZwgCcHJs8W2ibQLGuQA2xTL9Kv2J80nkFZeh+C38ypjyUwDJcT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721529596; c=relaxed/simple;
	bh=fh8z2AULcINUDvcFHWS/e7WktHIAQaXkIMEEqliuQXQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lbufdMMmiPtg2p0voAqNlzIjwCrJZfDxcCtNiiuiQ11eg6ZbXiRvB9V7RFSpaydR8cmqCIb/aZ2Df8NWYxfz7uPDETUOK4zH2ApEJ03vN/B99PBLtK4cgDhSjD6pKAHWdqljBUjkYKlo9HuHrp1KnjL1JfyY8RbcC1UbnfCvv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HNEvd74m; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd7509397bso208265ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 19:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721529594; x=1722134394; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKhYQTKZB+KGFwG7X607Dvbh44/YyIGRnOi+f/Ljx7c=;
        b=HNEvd74mxxgjkbyKDk6ULbHTVYTzl0hWwBGNi6IgTzpRUgi8KpNgH1+zOS09312XK6
         pbtUXoO06OK4DW7W8Fz2p462Qp32DaoQPQ3639y20Lf+BbdeX3PpldDc/Pm6opMFYS/H
         KMqko4By5RLdXoTkByNVFuNX3aZNtEnbfGcS6YYlsKmnKZEk1G6EfwRJfrYONzb2P9Ff
         Rzo9dnVbOg60hs56+3LimfDNHLSfC/icgiwi+aMRs2dZH3IaW4ozV1U5MSvPV/Y7wKGf
         KtukXhuFRZ3q7KBAHrnZeznm4I6Xx7vW+9KSUnT3OFDht2y059C5rN3o3/va+nnOj2/h
         GB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721529594; x=1722134394;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKhYQTKZB+KGFwG7X607Dvbh44/YyIGRnOi+f/Ljx7c=;
        b=QPq6ByalaHf3PpLhsD+Oi8DMX/IJGgc2YFNt48eEpP4V3tpmaRD9b0vARjmAzVUXRa
         detQewUB7mEGxlMunRJLLEas5RrIC13zyh7xJWTMTHF2gpfBGt/XDQa+EamqJuWFEhZp
         9W4L6+Kc8ZLbxnvQ3fXOy6KWyUrpvlxB4/2Fb21qj5sEL44kLQ/Rh0AfLbxg/iwOLnvx
         YapXnpEZEs0fUnNQXnhmuUMnbaWSRffEp1OpFcFC5bBwTkg9eBT1+yZWfMCVZu6ONSTD
         dCfAq358XvZlWPjOsoceZOENvh2ehtK9KXyYQgX9SVBpkUckDPTxU4mZ4OIS6636hjol
         cYWg==
X-Forwarded-Encrypted: i=1; AJvYcCUKZBfG3xi2W22dU7xevJ5gBV7ytl5FmT0l+9rZTFqshQak6kAUH7W0BWQqRUwnZUuwQRdG6JROA3je4H2sSM7DBfSp1JNnDgjEQI3j
X-Gm-Message-State: AOJu0YzZIub2U++4n4tUO6zsH2d8/9qf0K6ViwV5/7bSd9B6q1THkseg
	VLcs8qrpHaFtle0FORD6mLHSCLVrpJMk2EhG2RuYj9AAU7HKjOeV72XYb7+g2g==
X-Google-Smtp-Source: AGHT+IHKuuroDH+lIH+Y4aN8h5NmQDJjCinbxuGocRwWGYbok5fX/mvloo0y4GqthRw+d5nwlHRWKQ==
X-Received: by 2002:a17:903:2348:b0:1fb:b39:ce4c with SMTP id d9443c01a7336-1fd7961f3e3mr1796205ad.8.1721529593638;
        Sat, 20 Jul 2024 19:39:53 -0700 (PDT)
Received: from [2620:0:1008:15:d155:1bfe:11e4:98f4] ([2620:0:1008:15:d155:1bfe:11e4:98f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25ac71sm29087575ad.22.2024.07.20.19.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 19:39:53 -0700 (PDT)
Date: Sat, 20 Jul 2024 19:39:52 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: "Paul E. McKenney" <paulmck@kernel.org>, 
    Joel Fernandes <joel@joelfernandes.org>, 
    Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
    Christoph Lameter <cl@linux.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
    Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>, 
    "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] mm, slub: handle pending kfree_rcu() in
 kmem_cache_destroy()
In-Reply-To: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
Message-ID: <607f42cd-868b-28d0-8e94-819323557c09@google.com>
References: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Jul 2024, Vlastimil Babka wrote:

> First RFC, feel free to ignore for now if too busy with merge window.
> Also in git:
> https://git.kernel.org/vbabka/l/slab-kfree_rcu-destroy-v1r0
> 
> Based on slab/for-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-next
> 

Thanks Vlastimil, do you see value in testing of this series right now or 
should we wait for another series to be posted?

I'm happy to run this through testing on a few different architectures, 
but not sure if you have an update baking in the oven that would supersede 
it.

