Return-Path: <linux-kernel+bounces-341717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523BF988419
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF440B20FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACF318BC32;
	Fri, 27 Sep 2024 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eeh1NZf5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAC18BC22
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439707; cv=none; b=KO662t/2NZinHyML93U/HxMjCBMG6FXKiLFSHTbGM5ar6mUin+sAvF6spv5hC8duXjbgSn+fk03nXyn7UndJYBdhkyvsVUjpttiNTp/RAuCYljIxDPZOW/x7VG851nkzTs+Pcfss5wiSRtOD7o0aGbCrp/qkK1F0qIqjHK0J+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439707; c=relaxed/simple;
	bh=K8DfSFMXy2vBJiSKMwY6YNC/wzgGVnKZZ8jqoXw2gMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfdGiHSsLZa5mDMoL2bI1S4pwia6gdyCf9q56aKMzAgeY4ykpbN7N6Yd1C4aO3PCnBNfAFNb6XDdMFvycouRqVLLFvaWsxkLjIivhl+apaTEKcC7u44DvY+b3q4VoyOLAnCcF7BJGRnG9nURzLERUAGGIXqqSdD6tWatN/fiG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eeh1NZf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD7AC4CEC4;
	Fri, 27 Sep 2024 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727439707;
	bh=K8DfSFMXy2vBJiSKMwY6YNC/wzgGVnKZZ8jqoXw2gMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eeh1NZf5IE0WW/zpOLul9D6E/xUlud8L6GCSQb+ciCZeIYgrJsJac7WbDKCP24Q/4
	 MMOULVAQUIZyAojHJ7yKGLLzGejJklyB+hJEAmL2eqxBxU9l+WND4YPnyZL4CjfqdI
	 7qHYtKky2EYaTzfqFqyrEnhT7Xm2IUOHRkPtoExUuZjtrZ70iTog+aMaWiCuuaGyY9
	 OpMDC/yJv2UxosMDTXW2R4ywUvM6ssdGZ5HEpSkobiTb2iMnlF2Gx6KBHnYGTqPZ4P
	 LymAqEAyXiGjoS8avEnndYUeHTZ8ktFkYEL25nM+rKANMB+RjUimAGXkahU3ExYFhn
	 PW/NCu0u16U9Q==
Date: Fri, 27 Sep 2024 14:21:44 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v4 01/27] signal: Confine POSIX_TIMERS properly
Message-ID: <ZvajWEiWoiNGJyFu@localhost.localdomain>
References: <20240927083900.989915582@linutronix.de>
 <20240927084816.951098399@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927084816.951098399@linutronix.de>

Le Fri, Sep 27, 2024 at 10:48:40AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Move the itimer rearming out of the signal code and consolidate all posix
> timer related functions in the signal code under one ifdef.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

