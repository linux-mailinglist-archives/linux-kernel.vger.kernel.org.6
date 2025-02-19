Return-Path: <linux-kernel+bounces-520665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F2CA3ACF1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A2B3AEB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B05849C;
	Wed, 19 Feb 2025 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nevgMhPm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A34A23;
	Wed, 19 Feb 2025 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739923723; cv=none; b=cfC83mEgRwEhYKmWas5WgPOIHQINkqQJvTD9Zpy4wVhSbP+g5ZF/6LRobMa8o+CS/7LYJXNDGLu/CMSdcO/P7cx6VgT3UrVtXnpD2lhqRwA/YJcl6VYoB7BUEnZ+dUlgBwdGuDRNSlOsSFTP5Q0Y3Q5JnzhebaQOdolbx4nQ/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739923723; c=relaxed/simple;
	bh=yEwLVxfjgxCsvIUwG0Nns7OEvptA/tamjhpAsrlueIU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sax2AHPjQDlhW2Km9BOOPOuRE3bb554TIgfdeuIgjgDbJ+Kxr19RaB4JU3YxJZl3V9Mrg5TnAS5Jh0sYs+p/bAi8ebdcOf+SYedGVDBK+2m1LjHNISFiAGKEjXH4GbAbWtcWP8p2Jv+YG/E58bNM6rx7kJFf3EPiQhdz28VHQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nevgMhPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28C0C4CEE2;
	Wed, 19 Feb 2025 00:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739923722;
	bh=yEwLVxfjgxCsvIUwG0Nns7OEvptA/tamjhpAsrlueIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nevgMhPmZfs35Lx75GBafIpWH/HozlYHwfXLhMOcdU/oeI7gsLup1xn1MdYv3ovkt
	 zCMLnT2FHCgaGErSWJuKgySdpAq3aq04pRj9HPcYsPosmH10IaYusE0AnXdXSrGkWQ
	 s2TVUOBlVqjywg61C4seFztePff2msU6iU9ZShtM=
Date: Tue, 18 Feb 2025 16:08:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/mincore: improve performance by adding an
 unlikely hint
Message-Id: <20250218160842.2fd9fd47b47704681cad1e5b@linux-foundation.org>
In-Reply-To: <cbb812ea-4585-4777-aaae-3dcdcd0bd8d9@gmail.com>
References: <20250217170934.457266-1-colin.i.king@gmail.com>
	<Z7N4tLUpRA1EKfDm@casper.infradead.org>
	<08e4a7fc-bd06-4c8c-96e2-84991c4ce891@gmail.com>
	<20250217191351.0003a6f07d017d80762fae41@linux-foundation.org>
	<cbb812ea-4585-4777-aaae-3dcdcd0bd8d9@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 14:16:20 +0000 "Colin King (gmail)" <colin.i.king@gmail.com> wrote:

> >> Improvement was from ~970 down to 963 ns, so small ~0.7% improvement.
> >>
> > 
> > It actually doesn't change the generated code:
> 
> I've compare the generated x86 object code using gcc 14.2.1 20240912 
> (Fedora 41) and 14.2.0 (Debian 14.2.0-17), 14.2.1 20250211 (Clear Linux) 
> and I get differences in the generated object code comparing old and 
> new, and the improvement on ClearLinux is more significant too because 
> it uses -O3. So I'm confident the change is generating improved object code.

I was using gcc-13.2.0.

Please resend, with a Matthew-friendly changelog?

