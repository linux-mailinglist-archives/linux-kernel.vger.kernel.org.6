Return-Path: <linux-kernel+bounces-402908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907BF9C2E52
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 16:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9DD2823BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B23A1991D8;
	Sat,  9 Nov 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBTG9ZpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0BE233D7D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731167284; cv=none; b=PBbBgqDIYTRdt9JHPuHSoO5kHnZz1oeNNx83FmL/t9umTiBJrbOc0UQ7eCiyvX/9A4pazRyhBNzMEJVaLSL4bgbE/w8s4jH9tylSDuCvDeroFKGyY0P92qtc6KP2LDKU2ux2rKLu/Q+IKY0fN8VtJHzbo5qXSModHhzq0k/EnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731167284; c=relaxed/simple;
	bh=g1hrW8Uqu7CGSDB2Ds6Z6ZC82mP8I2WbhBZfW8c0jrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmLECsucrNWCEUZz5/xGYScnfNdu+auFAKEnYIW4vCrFcruIeDO5iEmWoIGbzxkjh4UJCD9foUayOwM4Uas1RxLerQLJW4rOR2wk+DhRRAKy+p8otkPT5YyFB9zj78xAdOmGYsJMbkondGi+vha//9XaZtu6RqLN7lnToMTP8LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBTG9ZpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9D2C4CECE;
	Sat,  9 Nov 2024 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731167284;
	bh=g1hrW8Uqu7CGSDB2Ds6Z6ZC82mP8I2WbhBZfW8c0jrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBTG9ZpVPshwZlSCii4lnIaP6NEqwYpb78G+OoSeAkqyz2NVDWfkn4ACTHevnE4eN
	 SKmqV42km6Z1lqNHJPXm6R8xTmWAQ8C9o/q/v7fytpF7neP0BLqc1c/CImrjvd4xtf
	 jTKuIrDxZzX0XSw+7px0EYhXVtuS43wukIJ+SrQHOpr9oqLq2gfrSCl2h2U8Sq76rO
	 N/VYWF7Wlh33QUUpMLUOl35HT7UpIK/sTKdzh/4RG651wX6oMqBWXbn9FGWdj+kYpA
	 4zZLWCfYl2YE3PgKGWI/NLrc0cbUYYHKKzRuHHYMZsh0cWmVA5XxEnTdz5LbWNiE9q
	 eIAQdnCPI0o/A==
Date: Sat, 9 Nov 2024 05:48:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: add a missing rcu_read_lock/unlock pair at
 scx_select_cpu_dfl()
Message-ID: <Zy-EMnJzWpS1K83R@slm.duckdns.org>
References: <20241109062905.204434-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109062905.204434-1-changwoo@igalia.com>

On Sat, Nov 09, 2024 at 03:29:05PM +0900, Changwoo Min wrote:
> When getting an LLC CPU mask in the default CPU selection policy,
> scx_select_cpu_dfl(), a pointer to the sched_domain is dereferenced
> using rcu_read_lock() without holding rcu_read_lock(). Such an unprotected
> dereference often causes the following warning and can cause an invalid
> memory access in the worst case.
> 
> Therefore, protect dereference of a sched_domain pointer using a pair
> of rcu_read_lock() and unlock().
...
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

