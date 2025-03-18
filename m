Return-Path: <linux-kernel+bounces-566764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC5BA67C37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F4E19C39ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6001D7E4F;
	Tue, 18 Mar 2025 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKQRQQg8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763701EEE6;
	Tue, 18 Mar 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323591; cv=none; b=e0KmQM11+si+yE5M2VUVtlmN2QulCkwsTBVnvqaPehX7SIsYkC3yWyyu+LdaSDJbulGKz1bmkMAWvIdvkPQ4jVsNJlzhZipDzlSZRaySCOb2DRC7G36DoMXSwXimBM0JGgRrELdLvWGRzapc2RwV86BrQOlfRbzOU2T1Cr3I/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323591; c=relaxed/simple;
	bh=OUo86uRFRtyW3/AAxFiBxKbaGqtYCCCLYvayflqXL60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qc061WwrLmFqFGfqlbsKPwnAtR1LFp+oHiqrfA+Vf/DbrpRcs7p1yscIUeYGxfqjBqVwqFLuVxRTeI2gC6RWguq2EIXSswBSItf+/goellvOEkXP0r5XUm12h2u84MPCahGp4cjo/9EmU9gTb7uSMbhEBOzWEu9KAyrFrAvkH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKQRQQg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3251C4CEDD;
	Tue, 18 Mar 2025 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742323591;
	bh=OUo86uRFRtyW3/AAxFiBxKbaGqtYCCCLYvayflqXL60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKQRQQg8fx6nXLn/mJwen+jttU+X0E+/orDek8IZi4pSkpOfVkc3r6Nzpx5moGiU5
	 sqofG9IGevrhvlmx3gkuicr+o5a3IeHfbzii5Q96UeE9MxLmd0VOQIvw9AYZbs0/tq
	 7SnFfrO/VT4wbK2rHRB7sp10U4y3shuJjsLNR7nortZOu9t0AYmXVufIktshA3CJet
	 JrPHp/T+mSJPa0ZncS/rdbOWk96C/vvZ1jk9vwl0BYL9V8HqAnjoeZyjqXSFov/mRb
	 2YM19xYMokv62zdbSZqXYl6mkemaPS15NBqvFwl9CAhDseXTtQzmF11t9GPe7Ez8HT
	 rncq7kj+0JI7Q==
From: SeongJae Park <sj@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 2/2] Docs/mm/damon/design: document active DAMOS filter type
Date: Tue, 18 Mar 2025 11:46:28 -0700
Message-Id: <20250318184628.35362-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318183029.2062917-3-nphamcs@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 18 Mar 2025 11:30:29 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> Document availability and meaning of "active" DAMOS filter type on
> design document.  Since introduction of the type requires no additional
> user ABI, usage and ABI document need no update.

Thank you for keeping the document updated for this nice new feature!

> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ


> ---
>  Documentation/mm/damon/design.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index aae3a691ee69..f12d33749329 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -656,6 +656,8 @@ Below ``type`` of filters are currently supported.
>  - Operations layer handled, supported by only ``paddr`` operations set.
>      - anon
>          - Applied to pages that containing data that not stored in files.
> +    - active
> +        - Applied to active pages.
>      - memcg
>          - Applied to pages that belonging to a given cgroup.
>      - young
> -- 
> 2.47.1

