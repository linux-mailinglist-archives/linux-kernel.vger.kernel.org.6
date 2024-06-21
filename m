Return-Path: <linux-kernel+bounces-224993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABFD9129B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B72DB24A94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF9757F8;
	Fri, 21 Jun 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOa7Hv5m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F920DF7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983995; cv=none; b=Jo7lzSjTs2I9GJLSDr6AUqWSVdLLjCPp6n5G01JSOOCAslGfGjzEw4ydH+CQwnfHpWekXRKh8ZcAN6SWc57nPSLOYUxNAQ+peuQEXN0aQHCHuphVDfmCfdV2EQbe5K0QHfMstjlrkiebp9FrMbKvH/VGBDJQzK8bGfQS0SxW/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983995; c=relaxed/simple;
	bh=cY9zUbFwVRSjnfTiVO85v6UotIoff4FS2+tMYQoolfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4j75/j3DHrqH9uLRMpM8wEOl8ZpCylq0ghXCFavDWkm7cxXhHbwle6lJsotKjI/Z4UlVy5Q/FxyTfQq8c3eZ7fmy2eVeKoxgF7yeCwVqNzDOZkpGol+W6Pkf9tssX63IfcYo1ci8C6i6PSy3YlJXTB5FJmXS8DG25ndC74Iifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOa7Hv5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7AAC2BBFC;
	Fri, 21 Jun 2024 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718983994;
	bh=cY9zUbFwVRSjnfTiVO85v6UotIoff4FS2+tMYQoolfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOa7Hv5mYVmrn4PEobDGYazCysPStxsTY1KXf3agRM7+wLgBLcB4hQr0hSTsD2513
	 LS7k5OTGrn68Tqoq25S3KfkFjtMNY49vVLcysAVhiI3/XprLEeW1o1y4MMOzSOpaSS
	 f2fzDjUEjb8YgJDPn491lM1BqK8HvW11xjpzkA2rgAQl60AB9Yhu6X/hwV8lFDnYbx
	 7fc3JQtubWUtDnPGjrldpjUdOCsYLUJ23DiHoNv+mTjHZvDRQtHAt74leR6PkkZfgy
	 8Mln2P6Rk7VpLB4UyiPjKEFRX6XBZgMbPHWTjvV4+WcpjJTzU3vj//eoVawtICTLjq
	 No69I+78DO8QA==
Date: Fri, 21 Jun 2024 17:33:11 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 08/51] posix-cpu-timers: Save interval only for armed
 timers
Message-ID: <ZnWdN2wBJ7pMKh5I@localhost.localdomain>
References: <20240610163452.591699700@linutronix.de>
 <20240610164025.971657046@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610164025.971657046@linutronix.de>

Le Mon, Jun 10, 2024 at 06:42:15PM +0200, Thomas Gleixner a écrit :
> There is no point to return the interval for timers which have been
> disarmed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

