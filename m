Return-Path: <linux-kernel+bounces-430348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3399E2FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D392833B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D201207A20;
	Tue,  3 Dec 2024 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXEexp1v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2F1DE2B2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268361; cv=none; b=FEB6lU5E2R13Bd2TPSwbbhfliGTCX+EzPXRtMskDLh4do72HyK6+dDu7njeXubuovthwVaB0uNVXPvZ+3G6Is1HGkcTxuh4eIqZOAkTgXL9ubstZ2+ZnPG2teQ+RpvgiopwTCSKVz/E5XbwFKrRdww4L6o+xlmUApprvtVHhj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268361; c=relaxed/simple;
	bh=lQC4MFHSoxiqvUeIaAQTkF6rwbvRRxw4WaSOdoeyhbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgGhV7emV1QmImFQpmL5rb0T+I0CtHmvNyM4yJj+lE28s46se5O1fvUmeEN9AqlhOeItWD9EFF+7NlUi6Wvv9PxDN5gYRRzrTb7wUru67nVrGcsAYRFlNO/7TGC+ykzVIXwWoJbH+JYXa7hHatNQx67tRcMw7nDJ6ZNVE1sMWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXEexp1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4304CC4CEDC;
	Tue,  3 Dec 2024 23:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733268361;
	bh=lQC4MFHSoxiqvUeIaAQTkF6rwbvRRxw4WaSOdoeyhbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXEexp1vF44/NLuw5FqnOm9oA9g8WH4sK/tH8WNbWHCw8lJhyAFdR3YPDVMBFWvBZ
	 +2gHsRpRfErjT7OLHgHRbgRYg5Ze52ceVrepuR8O9ZyAGRjNMv0NXuHtyfki1vd2uC
	 nOFzxdU5imfnyX5C5jMYSCXxgWVUJFNPw8b704XTk8xNJcnkO/Z5AIZAvBl0P3cKSz
	 p5n8jqYOeq5kNEVFsD0gdLtYmgN2MiNMTkEczm6OZAqu5Z/jb+WOy3moCMFfWDz75A
	 owfML29oiS5CzeRtEOnD2YYzmL4SOErd6kqK7mMgZ5o3quGA7h18/OGWFyEjtVaGzD
	 nyjlHzySEDUBQ==
Date: Tue, 3 Dec 2024 13:26:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] sched_ext: Manage the validity of scx_rq_clock
Message-ID: <Z0-TiGC5eUg4ZMWT@slm.duckdns.org>
References: <20241203142802.36305-1-changwoo@igalia.com>
 <20241203142802.36305-3-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203142802.36305-3-changwoo@igalia.com>

Hello,

On Tue, Dec 03, 2024 at 11:27:59PM +0900, Changwoo Min wrote:
> An rq clock becomes valid when it is updated using update_rq_clock()
> and invalidated when the rq is unlocked using rq_unpin_lock(). Also,
> after long-running operations -- ops.running() and ops.update_idle() --
> in a BPF scheduler, the sched_ext core invalidates the rq clock.

Hmm... why are ops.running() or ops.update_idle() special? ie. How does
sched_ext core determine what are long-running and what are not.

Thanks.

-- 
tejun

