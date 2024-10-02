Return-Path: <linux-kernel+bounces-348218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1B98E43E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C221F23549
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD8D215F75;
	Wed,  2 Oct 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="khij2IsM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830688F40
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901403; cv=none; b=HbPnwXgvF/UVTE2CfkdxQ1JeaSc7S1bYU1Aqr7C69YAMtuWDE0ASHWOhsC52tOoj0VltozUqIzpDFjb09fjgA405pPtNK6+atx9OsNP2dpp4AE+hsWQCUFl2AJG80+PACCYLg2H5nHSjlzcgpXNftr0V3VlBumUat99dAOBHmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901403; c=relaxed/simple;
	bh=7Q90UDF/UXJoMNqvwpZtCwy+y7YaVocRA82hXYI1X5s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eW0Rit04RRwRRM8vv/gnTv7xUT0rLOVYPi9CMJNveKdFPv0LjA9jR/wWXvgU5U0zyFLk66ihZFHZ44X8QAYhf2qWUaIbwxyI9C9o3LaLrywdXMzyJ4AxZgSp37VTvPtEU/AcaaESFdVNV2MtlNXfyL2BdDCyig4MpoP7fZXtlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=khij2IsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91288C4CEC2;
	Wed,  2 Oct 2024 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727901403;
	bh=7Q90UDF/UXJoMNqvwpZtCwy+y7YaVocRA82hXYI1X5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=khij2IsMKR9mnmH2fhhORaViyOTYM0kuKk77hNh5XjMssyDJy/H6rDp+tfJilWtLu
	 Kya2efhEJzmwT3T2pep0T6Ga8zGEtHwbkKAW2NCJ6tPMte3Ke47aYXBr5Mwj2WKETE
	 N3am6dME2bjQr8gCNRXYEN0lND7Fmfz44ikjH6NE=
Date: Wed, 2 Oct 2024 13:36:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
 wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v2] mm: swap: Call count_mthp_stat() outside ifdef
 CONFIG_TRANSPARENT_HUGEPAGE.
Message-Id: <20241002133642.9e9b82e53f2ff14f541d7864@linux-foundation.org>
In-Reply-To: <20241002195547.30617-1-kanchana.p.sridhar@intel.com>
References: <20241002195547.30617-1-kanchana.p.sridhar@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 12:55:47 -0700 Kanchana P Sridhar <kanchana.p.sridhar@intel.com> wrote:

> This patch moves the call to count_mthp_stat() in count_swpout_vm_event()
> and in shrink_folio_list() to be outside the
> "ifdef CONFIG_TRANSPARENT_HUGEPAGE"

This is very apparent from reading the patch.  Changelogs and code
comments should explain "why", and avoid explaining "what".

> based on changes made in commit
> 246d3aa3e531 ("mm: cleanup count_mthp_stat() definition").

And I don't think that explains the reasons for this change either.

So please resend with a changelog which fully explains the reasons for
making this alteration.


