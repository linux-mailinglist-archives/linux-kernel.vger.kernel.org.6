Return-Path: <linux-kernel+bounces-180214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94948C6B80
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34144B249E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0100E45014;
	Wed, 15 May 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG4m/p0r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7723032A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794368; cv=none; b=DciR8s1XBB2EtHWWM59O1bo9/8AIWAXDOaJ1lPkEnPytxvsrCTx8HejGGNVKRXbJEGDbuGkykV+MphqRpS1Ng07e2cS9I8DTdaiO/VecKUOp/ih6Yscdr2zaBlYHR+ccAQoteghte0VQr1mpFbeYbKinsNW1ilmZrfrMush4BC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794368; c=relaxed/simple;
	bh=kiBu9aDX7EL9QTt1G+6SJu1okG8LZwH7rPudLYo5UBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k0P9Peda4KiOJd3bR99SlgU4HwXLtA8Q5xFWs+Ps0KkiKJDM9qDDbJSamRHSlWBFXYe6mOU9VL/xMoDo7lDktq31j0T/3rtCButJANSyQMi6rXDhAMYlOnvf+hVnVq0GbAKWxwimMSQHVSh/AmFPy6Ho5nG5Tq6ufEyc4pyxeOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QG4m/p0r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715794366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K3zrJi+7L7SmSVpO4sJC/EifqPPPG8oHimbPsdQiY8I=;
	b=QG4m/p0rSw5KL7Zk7vTtoGkiT/YjVWX2YlpkPiyYtdtfF/txWVGhntCWNLvPX9T7hHCynX
	VIJzDU4pgaSJkZGxpDEZm4q962L0vKvU032+WcJ3gr3tDrwxndOuFO7muSy8fYxwtHtHkk
	XBoe5SWpyjRb8+E667GtFppshVUQcz4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-dRY6s8-qMZyw8X6nMuC-Vg-1; Wed, 15 May 2024 13:32:34 -0400
X-MC-Unique: dRY6s8-qMZyw8X6nMuC-Vg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-792ff352462so69698285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794354; x=1716399154;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3zrJi+7L7SmSVpO4sJC/EifqPPPG8oHimbPsdQiY8I=;
        b=nFd0hotZk2O0Mv5a79bRFvrInv9T5OnQNapsqkHnvu/dGnZYkB/EH6mx3bxbauDT1I
         0To++JA6UcU1OKSYsfb3VR3m+n2w3M550vgiCfGi6gaiWyCn/KpfdpcDGm578O/IBrKf
         LdZRBi99pVuaU6XyCnbsKb9FUOFhcwWXGl8dzIwuz4K0WRIudiWAc5r6uCgeNwsNCHKv
         CKmxQchvQpWhaYCNAR3zIzKD+oWxxSDm64ONN2B3p4IDVVSHcy2BvOHpHycDQN6L4Dge
         IFUmHEVndfn3epakZqZGbY2+jjbfaiBhQmgqi0xAav0lmvRGhBELt2nsRChuvywfJAkp
         mb+w==
X-Forwarded-Encrypted: i=1; AJvYcCUN8ap2rDgm09Il8yGe5Jtu8pN5DAU5bR8xVlUfcjp5LQpPqk3840OEarlzr1UucW9Uph0ttJXTYKkjuLaAPGg057qlB9/e/TAPhNK4
X-Gm-Message-State: AOJu0YzAXbI7mpHCmHsrUuCzLGELKmtjv4Tbju3jnHLhO9jaFqmR6c+t
	g7RQuC4Zb4l+InDD5Z3TW5YVyE1DyfxpediTtYFO49foMoYLjmWIK7+5wLGmckvbSVLEIKISJHL
	QjBfxLYOLueWOdmncxSGMIA0qF+MlfegeQGzWsU6Pi1ft2BObf3DbChcN/GRgsg==
X-Received: by 2002:a05:620a:4946:b0:790:e6bf:23c8 with SMTP id af79cd13be357-792c757421bmr1697142685a.15.1715794354095;
        Wed, 15 May 2024 10:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhuFXJCFrAqP1KpGavlBwSPWZKTHyKGVO9HIx7RJlDer6r8nEi85JyvPgFGo7LrS4jndsTSg==
X-Received: by 2002:a05:620a:4946:b0:790:e6bf:23c8 with SMTP id af79cd13be357-792c757421bmr1697139985a.15.1715794353706;
        Wed, 15 May 2024 10:32:33 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27f99dsm703976085a.37.2024.05.15.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:32:32 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/6] rcu: Remove several redundant memory barriers
In-Reply-To: <20240515125332.9306-1-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
Date: Wed, 15 May 2024 19:32:30 +0200
Message-ID: <xhsmhjzjvgevl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/05/24 14:53, Frederic Weisbecker wrote:
> Reviewing Valentin's patchset made me stare at some memory barriers
> on the way.

Sorry not sorry? :-)

> Here is some removal proposal. Some may be beneficial on
> runtime (fqs snapshot with potentially as many smp_mb() as the number
> of online CPUs for each GP). Some happen on more rare path. In any
> case they clarify code reviews so we don't stumble upon mysterious
> barriers.
>
> Thanks.
>
> Frederic Weisbecker (6):
>   rcu: Remove full ordering on second EQS snapshot
>   rcu: Remove superfluous full memory barrier upon first EQS snapshot
>   rcu/exp: Remove superfluous full memory barrier upon first EQS
>     snapshot
>   rcu: Remove full memory barrier on boot time eqs sanity check
>   rcu: Remove full memory barrier on RCU stall printout
>   rcu/exp: Remove redundant full memory barrier at the end of GP
>
>  .../Tree-RCU-Memory-Ordering.rst              |  6 +++---
>  kernel/rcu/tree.c                             | 21 +++++++------------
>  kernel/rcu/tree_exp.h                         | 16 +++++++++++---
>  kernel/rcu/tree_stall.h                       |  4 ++--
>  4 files changed, 26 insertions(+), 21 deletions(-)
>
> --
> 2.44.0


