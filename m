Return-Path: <linux-kernel+bounces-440878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE7F9EC5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC651882FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809AB1C5F1A;
	Wed, 11 Dec 2024 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTYtop9l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C41C5F18
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903006; cv=none; b=q1x+b6nNIykisNUj0rYKIY2M8mwW35zMc/IuLsUkGleYHnVlzRgnm4D3a8YsJMD4M2+njJHx9YPv4l/qCBvWxAkAd61UK9Q8TPCb4wBeQBQq2ufspVWYzBlRb9//+mLS4WfKVQo3Vl9p5WLjQl2NaOQHCVurO5u+SDdT2NbHbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903006; c=relaxed/simple;
	bh=nq9vLlfyJT1h9cuIxkC6ZcTalohPBluakfMPko4Cdvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzaWVuwDpEv8s2q486+MC7ScieU23inCX1ZEVGI+S/uEKq0Y3VxlRYVvmg2Hlo704thN93TuyazmR7Kvd7kajIpDNHa1DEORUnsnKi/KftrJDJcajY7Lc1C5fGpDuUGIVH3WxrizYzpok0eEXxi3+jStG6EwcbsX9I3TW9Y5lbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTYtop9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5756BC4CED2;
	Wed, 11 Dec 2024 07:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733903005;
	bh=nq9vLlfyJT1h9cuIxkC6ZcTalohPBluakfMPko4Cdvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTYtop9lXYuU45EEG1jfhL790oLku4pAlr3A2oumxCgYbMyFfTA6nLNOlLlZ4k/gW
	 NiqsKk6xOGT9uvAgNSucZ6SO5P5l9nLd5wTMSCsqyUzaUIesqj7+8FkHqB9+ctwj7H
	 vxzQ0dXlXafntQrbYHIKKnv8PDZUTUQX+Nq3g3EA+hvyxhLO4hTzemlEPn2Usff3xl
	 1HP9lkAi+ELB+zrilHwDHR9d2juLAt9Z8wRqvy6cfLgkMZMjNhPOLta326BvBdUEEv
	 hxXp/dkglplxchmdScM0roAGkEtB+FhEE7vRHrGOb6vz68kU7ZMqSpmOsb4+p68QHk
	 N2cSCRQBQhwLA==
Date: Tue, 10 Dec 2024 21:43:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] sched_ext: Implement scx_rq_clock_update/stale()
Message-ID: <Z1lCnEr25fOB8RWI@slm.duckdns.org>
References: <20241209061531.257531-1-changwoo@igalia.com>
 <20241209061531.257531-3-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209061531.257531-3-changwoo@igalia.com>

On Mon, Dec 09, 2024 at 03:15:27PM +0900, Changwoo Min wrote:
...
> +static inline void scx_rq_clock_stale(struct rq *rq)

Would scx_rq_clock_expire() or scx_rq_clock_invalidate() be a better name?
Also, I'd roll this patch into the next one.

Thanks.

-- 
tejun

