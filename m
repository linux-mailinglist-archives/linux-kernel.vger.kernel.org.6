Return-Path: <linux-kernel+bounces-211211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4F904E83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEC61C216B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE8F16D4C8;
	Wed, 12 Jun 2024 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m7M1JMks"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2B16D307
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182433; cv=none; b=Mam12GsRejRRSxGda0Xs6TsoXb08pSG6ir7hRmnCgUUrLFVFq5IyhN9jI0zkjSh7/eTNlDw10oQmEER9/mObNcCFGEUBvrEzjemavoiZ4GX3suntuM/IGhhAFp+NTTIvNCjWZf3itmTz9HIZJmfreU3UQMax5rg1yh74LNjtWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182433; c=relaxed/simple;
	bh=tkb5TXp35uMGhFX0bOi9/AXX3CAg0/55l8fdoR7W0aA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BdxVVehVu90d+C41qXXdjdDguLDSDX1f9P+SebQGFG6SPQdgEQv7V5ncaPGQtEY3oiYDghjYbTp0+WgO5ExQ3TpAYBqBvUjA0wSx3u21/hiRYm3H/7hFKPixmN4CV0b0AOFKhhytS8f1BAoqkFu7kba/3h6OlEZTPVhQScwUNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m7M1JMks; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: osalvador@suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718182427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkb5TXp35uMGhFX0bOi9/AXX3CAg0/55l8fdoR7W0aA=;
	b=m7M1JMksvokr1bofKdKf2BIM/5M5utHaSOr8niE0TgI76JF+tYn84j7lC3rpIiN55isHJR
	jL+Kcd/EWm0bCgAvlsPuMhj8o3LDqJpYEw10R1BuqpC+IMdirAifuNob4jJEqNQVcBAphG
	y/74Ol4AtjQHKBMBUBGOFopjkcyyvE8=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: vivek.kasireddy@intel.com
X-Envelope-To: syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] mm/hugetlb: Guard dequeue_hugetlb_folio_nodemask against
 NUMA_NO_NODE uses
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240612082936.10867-1-osalvador@suse.de>
Date: Wed, 12 Jun 2024 16:53:34 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5237BBD3-818B-4E06-A56A-80BE705EB024@linux.dev>
References: <20240612082936.10867-1-osalvador@suse.de>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On Jun 12, 2024, at 16:29, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> dequeue_hugetlb_folio_nodemask() expects a preferred node where to get =
the
> hugetlb page from.
> It does not expect, though, users to pass NUMA_NO_NODE, otherwise we =
will
> get trash when trying to get the zonelist from that node.
> All current users are careful enough to not pass NUMA_NO_NODE, but
> it opens the door for new users to get this wrong since it is not
> documented [0].
> Guard against this by getting the local nid if NUMA_NO_NODE was =
passed.
>=20
> [0] =
https://lore.kernel.org/linux-mm/0000000000004f12bb061a9acf07@google.com/
>=20
> Closes: =
https://lore.kernel.org/linux-mm/0000000000004f12bb061a9acf07@google.com/
> Reported-and-tested-by: =
syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.=

