Return-Path: <linux-kernel+bounces-407352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E29C6C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC53285B29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95761F891C;
	Wed, 13 Nov 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzWpCFJd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5802C1F9404
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492029; cv=none; b=T26D+tZ85vyb66X+HJgpKowC3vNzpTGktFTVq0Bh29jNBGqoYDRdgI7UNesKtMbcXKjETc83gNAt3lcxEwzVHGJFMBIjCxFOl+gMP4m33j05eDHIXvvfDrShjAnaLgP8YiI5YG2bk57sXYy/PbGzjtTr9F9OT+QyZBmUpQmwiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492029; c=relaxed/simple;
	bh=Ni6W1HtGN4SZqCW1+9JZsbLTCPyqZYZNV2yq9uO86Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpzw80VjM+ZHfSO2n4wUOKGl+/xDdJZd4s6N1Xgc5pWBfLm+M0Z7iQfJKqXRt/wlWxcaMjXVJ+kbNs+U+JstnzTuY1OmkJ9K0cDQ4iTzQfhUi/Ii99+doGqFpnaBsjIRYq9k5VNOjzROduY7SEDBzZvNB1bDMJYlx1lrRJ2GQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzWpCFJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9DCC4CECD;
	Wed, 13 Nov 2024 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731492026;
	bh=Ni6W1HtGN4SZqCW1+9JZsbLTCPyqZYZNV2yq9uO86Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzWpCFJdEfCE3NN7ccXy6shngZuUFEnycwGFdi9iTV4K8W6IkAjY8PacrlzxaXPYi
	 FDetG4+8ebGic9fmHbsPBVXPuN8cco60Q6brclFCMMhq9fwHWvZpS7XVyVGKwh6umg
	 EsFfw84hhy79NQyvSOoNScXzAkZTsn8NaBBHf2BEWzH8RJGWY0rMu4NT8HHj+0US7F
	 kCzTO00uIH70n3ozqoW8vvGOTm2XhBI0G/FeLe+lk3fRutZB1p56EAr8xca1L7Z/Cy
	 yKUzvOKBrVE0wurNhgbaH6qs/n0yxob4znGT5jHPvKh20c6ShihKKndwfE2OdSNu3i
	 A7XWbEkUTgx1A==
Date: Wed, 13 Nov 2024 11:00:21 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
	kernel-team@meta.com, hpa@zytor.com
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
Message-ID: <ZzR4tbZGX3U6yEiW@gmail.com>
References: <20241109003727.3958374-1-riel@surriel.com>
 <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Nov 08, 2024 at 07:27:47PM -0500, Rik van Riel wrote:
> > While profiling switch_mm_irqs_off with several workloads,
> > it appears there are two hot spots that probably don't need
> > to be there.
> 
> One of those three is causing the below here, zapping them from tip.

I've zapped the final two commits from tip:x86/mm that are the likely source of the 
regression.

Thanks,

	Ingo

