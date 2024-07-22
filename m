Return-Path: <linux-kernel+bounces-258998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A95938FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3065F1C21216
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3750416D32D;
	Mon, 22 Jul 2024 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzfTQGBP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF116938C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654337; cv=none; b=Q+xxP5pK7pnHYU/YL4G7jkF5stC10vVdu6RxabJSaFYJ1fDOKTP0kMgY8p+n8mfH9tXVJYmLFMs1SytZW3XQnqQSO1aPSEwuhH+7MaWhkYu7cVvjZHcy6H6i3/qFxVAIj0i1fZwYmeH48PCVM/+Fh6Z4ZTINDTys3K3ykyAdFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654337; c=relaxed/simple;
	bh=aKQylPPGV/2YWPrHnL/16+8EB6CzBmiRaNKBmXR7vEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVakuPZztEoFwLe2fFnYniGyC1TjXSR4u9gWs6x8a5VLxM1wXWG4S48tWd8qBddK/zla1DLWw9LdE/t4mvIWRYkerVnKV44PgMhlLjaAgHqii8ACtWf+KKjobsS3kU67nnDX2ZqfSAgKIf6jgSpM4+N5my4ZZlkDnAK3jE7c/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzfTQGBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB46CC116B1;
	Mon, 22 Jul 2024 13:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721654337;
	bh=aKQylPPGV/2YWPrHnL/16+8EB6CzBmiRaNKBmXR7vEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzfTQGBPGW+baBZGEmPjvM3qyywuCbM/bWs5GY4igo/XYPPg3mKMPZWwskaUbtBsB
	 nzv4fN3Dp57ysYBIvK9PO+rJ36HVdPxuJ3jFoV1iYupnE5jWFivG0S+3YPVnaDGfBi
	 LizxJMlYA1zW6i/uFngY9SwQiVMDMi5+77tYvwozYcgBqNNMQKprK0va6zXCWOMo3s
	 kLkxst3bg7AitQNrt5rwSiUcr60zUmMN5UssrjfKsqNlJpZmGrx91IqaSGYuYj1KOb
	 MO7MSmLAA7ugoyi/eb/vakywjMIiEb01cBZQH6RbxQztIMh+2a2JQdTa3dLleM8KcW
	 vtNHQYYzQ4Pdg==
Date: Mon, 22 Jul 2024 15:18:54 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: commit 7a5ee4aa61af causes warning on boot
Message-ID: <Zp5cPikQUTgQxcHS@localhost.localdomain>
References: <20240722123912.3602-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240722123912.3602-1-spasswolf@web.de>

Le Mon, Jul 22, 2024 at 02:39:11PM +0200, Bert Karwatzki a écrit :
> Since linux-next-20240722 the following warning is shown on boot which can
> be bisected to commit 7a5ee4aa61af:
> 
> [    T1] ------------[ cut here ]------------
> [    T1] WARNING: CPU: 0 PID: 1 at kernel/time/timer_migration.c:1742
> tmigr_cpu_prepare+0x469/0x540

Good catch, and here is a fix proposal (untested!):

https://lore.kernel.org/all/Zp5bpLJHlYsZinGj@localhost.localdomain/

