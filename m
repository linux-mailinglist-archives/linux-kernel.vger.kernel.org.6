Return-Path: <linux-kernel+bounces-435910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15FA9E7E7D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C1416C676
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626576025;
	Sat,  7 Dec 2024 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fo46We9z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8CD4A24
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733552088; cv=none; b=cMWCdu4WRR3QheSQkP31SIjyx6GelvXDJfYAQoe5ZJfqv1IfN18E5djV/P6sJNALMMAyaG0HynRuorYYk55r/wNsUquqCz0mtMRgD/IQbOeXqf6qMOtxNs40OHbZFyp1upV/MPJTPE9qLZpKxhJqsw7cMBKCYLICa/cF2DA/XW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733552088; c=relaxed/simple;
	bh=FR4jyYVvGAc/QK1Xv+schhqBTtRlolGYuXRzbKnnX1c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bbnzdUKuf+OXgtHtlN4KinhfUyaF9wNsYrYEZKhVcf5hJTUjqcYh/Gu0tpaZ9UNCo0B1K/alLi/ARLvJ1yZHIeG8fF4PmYRWBYfh5cohHManOCS/mxVgfMOtwWyFJJNsYeinFhfigpA6fmYsCW3pnrl5Shuv2+uGmx1pxUhWzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fo46We9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3AAC4CECD;
	Sat,  7 Dec 2024 06:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733552087;
	bh=FR4jyYVvGAc/QK1Xv+schhqBTtRlolGYuXRzbKnnX1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fo46We9zcOKYJ5ZyyFgLQkHdqkJZ2+uqkkvcCqqRLfaeDplZY6Qd1+CTu6hOCmIck
	 HDp8TfGzq2ACTP47vjooMiJJSDUk9puaZZWW034/K7AFWAOqYcrVaLOBH2jYNkth35
	 adR74FV6p73bFYQYB/JZM9jMDrGxAiqfJV7HE9xU=
Date: Fri, 6 Dec 2024 22:14:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
 <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
 <dave.hansen@linux.intel.com>, <chenfeiyang@loongson.cn>,
 <chenhuacai@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix subsection vmemmap_populate logic
Message-Id: <20241206221446.e5e8ea4ed85d0f2884216b82@linux-foundation.org>
In-Reply-To: <b2681eed-d4d5-43c9-90e0-3e706db3e201@quicinc.com>
References: <20241121071256.487220-1-quic_zhenhuah@quicinc.com>
	<eb4d6674-494a-4a84-bade-481b0c89eb93@quicinc.com>
	<b2681eed-d4d5-43c9-90e0-3e706db3e201@quicinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 17:13:39 +0800 Zhenhua Huang <quic_zhenhuah@quicinc.com> wrote:

> 
> 
> On 2024/11/28 15:26, Zhenhua Huang wrote:
> > 
> > 
> > On 2024/11/21 15:12, Zhenhua Huang wrote:
> >> To perform memory hotplug operations, the memmap (aka struct page) 
> >> will be
> >> updated. For arm64 with 4K page size, the typical granularity is 128M,
> >> which corresponds to a 2M memmap buffer.
> >> Commit 2045a3b8911b ("mm/sparse-vmemmap: generalise 
> >> vmemmap_populate_hugepages()")
> >> optimizes this 2M buffer to be mapped with PMD huge pages. However,
> >> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> >> which supports 2M subsection hotplug granularity, causes other issues
> >> (refer to the change log of patch #1). The logic is adjusted to populate
> >> with huge pages only if the hotplug address/size is section-aligned.
> > 
> > Could any expert please help review ?
> 
> Gentle reminder for review..
> 


MM developers work on the linux-mm mailing list, which was not cc'ed.

Please address Catalin's review comment
(https://lkml.kernel.org/r/Z1Mwo5OajFZQYlOg@arm.com) then resend a v2
series with the appropriate cc's.



