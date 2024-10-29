Return-Path: <linux-kernel+bounces-386271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B657F9B415B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9431EB21B94
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C46B1FCF77;
	Tue, 29 Oct 2024 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fXruR6tf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5E14D6F9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173704; cv=none; b=qzhqt/de1fobed5D1VMwwzAaV406MyFRxFOChbNJXJSk4p/Fqob3oaYrSv/yjcbQCFoC3XbWHkSaYaWmtdnXlG6ADlC9GQ1zztEMUXpDdzQhDoVa9WCVQB/+7eIor3HZMKgmI6B/vYbAEV9+s2LpFuNdShx1fbtLANhGDLGeUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173704; c=relaxed/simple;
	bh=P1c4QLBW2FXpqpbk2AZCg4RI2lvuU/4+WSBF9NIOQdw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lyhnUUGP+dcA583Bg/vvZ34cVmAO+AzyWz2gHzNRg/V5ofT/mrGrq6oS44VLSOmDkhAP2F8PxfPL/e3Wspfy5lVdnl/Q+gHrObBmuTKy6Erp6sbcV6yzi6D9+TJO7PkEHF4gouH+AvIr16adGFRxxivXPg4G3t9ooPALaGRFz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fXruR6tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6AFC4CECD;
	Tue, 29 Oct 2024 03:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730173704;
	bh=P1c4QLBW2FXpqpbk2AZCg4RI2lvuU/4+WSBF9NIOQdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fXruR6tfjGO84qZIB+kBJCbctdvLzsxWe13D3HV3zk3KAoH9gaOS8LBTY8hQdjRi2
	 atPmDCGtsKDIU/LTHPi2M02zfsRtQjad4lsPp5xWcYbW3KVhV90FooBfvbqzRqKjNZ
	 yiPubL4sfTP4ksHN9JMU46/EJuqEaednnI3sjSmA=
Date: Mon, 28 Oct 2024 20:48:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, peterz@infradead.org,
 andrii@kernel.org, jannh@google.com, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, david@redhat.com,
 willy@infradead.org, brauner@kernel.org, oleg@redhat.com, arnd@arndb.de,
 richard.weiyang@gmail.com, zhangpeng.00@bytedance.com,
 linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: convert mm_lock_seq to a proper seqcount
Message-Id: <20241028204822.6638f330fad809381eafb49c@linux-foundation.org>
In-Reply-To: <CAEf4BzZvFFXByMS-eyFZzt7055MHexT2h0FfKfSN83x_jYTZEg@mail.gmail.com>
References: <20241024205231.1944747-1-surenb@google.com>
	<CAEf4BzZvFFXByMS-eyFZzt7055MHexT2h0FfKfSN83x_jYTZEg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 17:57:34 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> I got a notification that this patch set was applied to mm-unstable by
> Andrew. But I was wondering if Andrew and Peter would agree to move
> the patches into tip's perf/core branch, given this is a dependency of
> my pending uprobe series ([0]) and, as far as I'm aware, there is no
> urgent need for this API in mm tree(s).

OK by me.

