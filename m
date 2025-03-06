Return-Path: <linux-kernel+bounces-548286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22701A542DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5443E3AEA05
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1DB1A01B9;
	Thu,  6 Mar 2025 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nB/HooUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3A17583
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243138; cv=none; b=gHkSux0aKJMsFsWb67VyjNXmJsaQFFFYv2vKegBLIkr5ZHJo87ds2BG2Mk4jivBN7gtmtNc/wqfSa+ksGJELV+NI/kCWWI62pFB3EfHIPUy+34H6EXq/sPrI179lynvIBK2nOuFbXYcClEMAx6pKWsZ8CjfQqV8XbGXb+9x0qnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243138; c=relaxed/simple;
	bh=PlpKZKn/KdWC3NfT/6WeCDc7fHykXga8zHfHhafMXrs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Du+tB3AviZVTK0r9gUl/6QGegsmzIfnJfqfP5EwVCOaLi/Jfg1VJMvNalrlKLK+IJ2MTiqR0V11UiUjZjODO7BN/5K7hho+h9p7XpQVF4r/KMEmGf25ziZEn02MsD0vXTefQOdIZ5sgva78j6EDc0b4XwS+eSArOdaFWUc9JPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nB/HooUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE21FC4CEE4;
	Thu,  6 Mar 2025 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741243137;
	bh=PlpKZKn/KdWC3NfT/6WeCDc7fHykXga8zHfHhafMXrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nB/HooUzZ+2R2690PKAiPLlhVvDVDT1BNHhhZNrzLsSUvcPyPg8XgfSrpuslliXZo
	 PjzDHycXNWMdWJB9ysa3vvxpOt+y9/47iosuhsfPuIwYNIutrRvgk3MhEqPxSMtDjs
	 wt3i5do6CPfak4onEGRuDB3zAiUzuxSTGAbysKtk=
Date: Wed, 5 Mar 2025 22:38:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ryan.roberts@arm.com, anshuman.khandual@arm.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, david@redhat.com, willy@infradead.org,
 hughd@google.com, ziy@nvidia.com
Subject: Re: [PATCH] mm/vma: Do not register private-anon mappings with
 khugepaged during mmap
Message-Id: <20250305223856.bc1a0c90339cf0d353e8be34@linux-foundation.org>
In-Reply-To: <20250306063037.16299-1-dev.jain@arm.com>
References: <20250306063037.16299-1-dev.jain@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Mar 2025 12:00:37 +0530 Dev Jain <dev.jain@arm.com> wrote:

> We already are registering private-anon VMAs with khugepaged during fault
> time, in do_huge_pmd_anonymous_page(). Commit "register suitable readonly
> file vmas for khugepaged" moved the khugepaged registration logic from
> shmem_mmap to the generic mmap path. Make this logic specific for non-anon
> mappings.

Please fully describe the userspace-visible effects of this bug.

> Fixes: 613bec092fe7 ("mm: mmap: register suitable readonly file vmas for khugepaged")
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Thanks, I'll add cc:stable.

