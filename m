Return-Path: <linux-kernel+bounces-417818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A2D9D5967
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51EAEB20EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51B166315;
	Fri, 22 Nov 2024 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MMrOLjp+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97AC22081
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256897; cv=none; b=RE+jt5nKX89vU3phEoY1kI82+kfjlmYd4rjT5u7cfN/5DQgKUWOouu1C4E6Pq2o5vL71z2eNkJ6wqqm/A76HHoJn/i6UBSV+C0Nzzk9fURFMNkhm7e02r3ON33eZUZo1OSMFJ2MVpyUY0NXa6dctGM4NmIi5SDt9Ntox491Mcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256897; c=relaxed/simple;
	bh=Q/+LLw2ezIByQzhzHZWlhwYMEgZWfRSX3uE58KddeyQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DYkJN0KZx34M3VM2wLzEyGBRDkD99noKK5VdvKAcO+5mZpPrJZUlf+qxPnD7Sk0GEFQtNLoNkav59Es6VgEbZ81WlKFc6yLUTIt9QyGVZyacw9l+eVoVZMPPdjiXob335VzImKD3YW/Fq23MUqWLuSKFKW1ar3+3x5uEFx6SjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MMrOLjp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7CFC4CECE;
	Fri, 22 Nov 2024 06:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732256897;
	bh=Q/+LLw2ezIByQzhzHZWlhwYMEgZWfRSX3uE58KddeyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MMrOLjp+6H6s9aB2GTXCpXJrrtvKEx7+S3j8mPsUTpnZaLl8ktld7Z32qdym2ASPx
	 frVQTMUDdwtE7ZKuC3I/KpYh/sCnRbRg9lIS0rJsGOj/dhEegWqJo/27SfdtDhPODg
	 MbiB4MchG/xAmGKIEGIk7P9JbTGMW1UHka/DNp3w=
Date: Thu, 21 Nov 2024 22:28:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jared Kangas <jkangas@redhat.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan: make report_lock a raw spinlock
Message-Id: <20241121222809.4b53e070a943e100bb6f7ba0@linux-foundation.org>
In-Reply-To: <20241119210234.1602529-1-jkangas@redhat.com>
References: <20241119210234.1602529-1-jkangas@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 13:02:34 -0800 Jared Kangas <jkangas@redhat.com> wrote:

> If PREEMPT_RT is enabled, report_lock is a sleeping spinlock and must
> not be locked when IRQs are disabled. However, KASAN reports may be
> triggered in such contexts. For example:
> 
>         char *s = kzalloc(1, GFP_KERNEL);
>         kfree(s);
>         local_irq_disable();
>         char c = *s;  /* KASAN report here leads to spin_lock() */
>         local_irq_enable();
> 
> Make report_spinlock a raw spinlock to prevent rescheduling when
> PREEMPT_RT is enabled.

So I assume we want this backported into 6.12.x?

If so, please help us identify a suitable Fixes: commit.



