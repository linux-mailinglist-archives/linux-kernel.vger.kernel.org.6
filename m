Return-Path: <linux-kernel+bounces-542828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C7AA4CE35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8593B1884DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8368820E313;
	Mon,  3 Mar 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uJET+qCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CBC11CA9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040666; cv=none; b=is2RnXP1X13WSiNy2TZMIUVIRGaQwbqp48g4rgDSkHDSDDNfAdlcD2UjpaU6ELNihCquJQS2ZZkJMZAY6EgqZ7nKmkgAv8Uf3e/TWMpuhUGn2tKr3SchQRwjJRb/sOBZPrf0kq0+v9dUC/vrTbF8vTlI124lwj7Sw6FNz3WbzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040666; c=relaxed/simple;
	bh=LjffSd+DCum8VKta8PILZRkVkBRUymg7MTa7dkVOac4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Z/m7CmVtW582UrqdFnajen6fNQFk8ubzMrki7aok/7ofA2dTJRKk5qsvbMzsc617Z+ZxyD1iSEPHYq6gixyDLJlP+RlK7ubikfm3I76e3BiSiecWRoJRSOd67msXeTRqcg4VEi8HKN/RFG5K5KodQyPRrzBBJjNTvkaysbRnoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uJET+qCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1646FC4CED6;
	Mon,  3 Mar 2025 22:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741040666;
	bh=LjffSd+DCum8VKta8PILZRkVkBRUymg7MTa7dkVOac4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uJET+qCjsKaQJiqtmVeWYrWMhUkudkz4y0fcYTgo6tHdnyTFuF33tLhtmU/PyLdgx
	 p5YQ7XVcQ0SlcUycT8ZYqLfCrg+GkhFNcrYh1LRAUNkOTwuO8IJKptOrRQNsNY4bNT
	 YgVyU/lGKdn7FgLcwn/I2OGVqY6s+hWhekVKfVZQ=
Date: Mon, 3 Mar 2025 14:24:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: avoid clearing TIF_SIGPENDING in
 recalc_sigpending() if unset
Message-Id: <20250303142425.bf8668d1875aa47e0dadf6d6@linux-foundation.org>
In-Reply-To: <20250303134908.423242-1-mjguzik@gmail.com>
References: <20250303134908.423242-1-mjguzik@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Mar 2025 14:49:08 +0100 Mateusz Guzik <mjguzik@gmail.com> wrote:

> Clearing is an atomic op and the flag is not set most of the time.
> 
> When creating and destroying threads in the same process with the
> pthread family, the primary bottleneck is calls to sigprocmask which
> take the process-wide sighand lock.
> 
> Avoiding the atomic gives me a 2% bump in start/teardown rate at 24-core
> scale.
> 

Neat.  Perhaps add an unlikely() also?

--- a/kernel/signal.c~signal-avoid-clearing-tif_sigpending-in-recalc_sigpending-if-unset-fix
+++ a/kernel/signal.c
@@ -177,7 +177,7 @@ static bool recalc_sigpending_tsk(struct
 void recalc_sigpending(void)
 {
 	if (!recalc_sigpending_tsk(current) && !freezing(current)) {
-		if (test_thread_flag(TIF_SIGPENDING))
+		if (unlikely(test_thread_flag(TIF_SIGPENDING)))
 			clear_thread_flag(TIF_SIGPENDING);
 	}
 }
_


