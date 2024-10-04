Return-Path: <linux-kernel+bounces-351397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A653991062
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572091C22E58
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD98A1DBB28;
	Fri,  4 Oct 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8AG33z9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0B1DD52B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072748; cv=none; b=D/jjEuw18S0tiWJTt5gACV1rq/Mjwq35nKfFuc6BhsSkxh1+sMuJDEss6mymixfmGYf+1sxHu55W2ou2YWEOqXxQcpbcfuya3HKujFio1oxJIZvR+YbUP+4JZ2De8eRZ7UUIpSI7E940Az41ac5M+JwRRWTOpSGvXQGZempaSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072748; c=relaxed/simple;
	bh=/t+JI7LJn7b8j0uy1UK3lHClhHJHM0PnBxFurgi2Eb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Imc8Q/yun8aCCCSwDpgwi6BuXrwFSwEagBvKs/J0LqDILyk4sbdGQd20YgjZRAxe0XiOjRIMCmgvRbBVXU5k916MKpeOk0oz0NtNUtAMvRja9AUBTTMsqcdbuXcu5sbfIACi0RKxsM98D7mAgcMWiQh3K1U5nkOKxjnUrUE/9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8AG33z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDB2C4CEC6;
	Fri,  4 Oct 2024 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728072747;
	bh=/t+JI7LJn7b8j0uy1UK3lHClhHJHM0PnBxFurgi2Eb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8AG33z9KhlCOXqPR86fYqh6orexquc7XC/1PaL08Rfj0Zvs1Rq/MxugMUGKfTESN
	 VqR4k7xPFcgONAMWGozAQfWuqTUNy1gpUPlIupqjTeQcMOvRB5SIw7pgz2cYaLaUIx
	 m+elXaV0zIlzNBC/SAgWmURFUZtkcj2cfsayQT9o3/aC00xv1uOLJuvJ0SMS8uCc/7
	 iiEb3jYiWwmAIOCnY/IDOufJRN7T39hRtNVpgJmDS+PShsc+P8Wo2dZXDofjh2JhEn
	 jVwKHFuPhqpm1zSZE0DediYcDpB6WLZObhmORyJH8DzV+Bd1YLMqL6HtHDNLcp8Hy1
	 CPe7/Q/P1wk7Q==
Date: Fri, 4 Oct 2024 10:12:26 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.comm, sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.12-fixes] sched_ext: scx_cgroup_exit()
 may be called without successful scx_cgroup_init()
Message-ID: <ZwBMKoANSjGzjAhp@slm.duckdns.org>
References: <Zv2uXn0bP-YDCkc_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv2uXn0bP-YDCkc_@slm.duckdns.org>

On Wed, Oct 02, 2024 at 10:34:38AM -1000, Tejun Heo wrote:
> 568894edbe48 ("sched_ext: Add scx_cgroup_enabled to gate cgroup operations
> and fix scx_tg_online()") assumed that scx_cgroup_exit() is only called
> after scx_cgroup_init() finished successfully. This isn't true.
> scx_cgroup_exit() can be called without scx_cgroup_init() being called at
> all or after scx_cgroup_init() failed in the middle.
> 
> As init state is tracked per cgroup, scx_cgroup_exit() can be used safely to
> clean up in all cases. Remove the incorrect WARN_ON_ONCE().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 568894edbe48 ("sched_ext: Add scx_cgroup_enabled to gate cgroup operations and fix scx_tg_online()")

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

