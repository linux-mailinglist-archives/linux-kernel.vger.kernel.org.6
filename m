Return-Path: <linux-kernel+bounces-545297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F351A4ECBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253008E1284
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A529283CA7;
	Tue,  4 Mar 2025 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDDzcUpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D32836A4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111560; cv=none; b=BWs8rfgD7lIVtZeKt20P0GKp5Me+PouWUCJwTqXUf8TDhaAx/S8h7klyop3hvhoToSgK3tsK9HwCXwNxATpTDjwSqfcf987eZn73dUwsHrqpjDU13PzkhKusw68zDsGWQqYRkvEvm3bH7uv+07B2fUf90qOqHv0GHsXwC6ZnxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111560; c=relaxed/simple;
	bh=cFeXbRVRgvK9P2F2afV4D53G+9cqNa/+vBZ/bpIWHjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5N3esl4KhQSfTVu0XxXl7bJNFJm0WzkU7AGeJaNcbKT2shRUgVjCAkEvr/U+9E4IrqvF0yERabwJUzmB5sDNFg5Kdw2pRHC7PW2yYl2Nnm/WaEkpw3aOnQwU/J+86luBUpME7/MeYiPO9lJgj24fFZOKLHZH4RWccZuxN8k/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDDzcUpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31355C4CEE5;
	Tue,  4 Mar 2025 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741111560;
	bh=cFeXbRVRgvK9P2F2afV4D53G+9cqNa/+vBZ/bpIWHjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDDzcUpMVjhaziGZj4WGuoj0lRaItqiH45SZ29ALt16p505CzoDsRip4nwoQ+7kSt
	 wVSB8w/ub0LXm4jXNvt8iCh+KYuZ876hhw7TsvyKn1H71/xjsAiaXIJRq+Ty96tDO6
	 V37YnPV0Y+gZeAyKaVLNXFvTovi0CGQcjvQ98HaUMxepczd0jYyEOSHUSdhBGfn6o+
	 GUIffsyk+fYJQlz3QL3v9bcczwJURVVVjQ6Dyr/8OqJaQabnmiK2cPNe2knN8XYjYm
	 VwHiQIrwzzD2QBUFH4ZpaHxT5EA3j9/iczXsz50N1JqS1+/yz5YReXrGTwQWQZSz/V
	 /JStCw/PlPj9w==
Date: Tue, 4 Mar 2025 08:05:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sched_ext: Change the event type from u64 to s64
Message-ID: <Z8dBByVpoqeTZ5Ev@slm.duckdns.org>
References: <20250304104900.154618-1-changwoo@igalia.com>
 <20250304104900.154618-2-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304104900.154618-2-changwoo@igalia.com>

On Tue, Mar 04, 2025 at 07:48:59PM +0900, Changwoo Min wrote:
> The event count could be negative in the future,
> so change the event type from u64 to s64.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Applied to sched_ext/for-6.15.

Thanks.

-- 
tejun

