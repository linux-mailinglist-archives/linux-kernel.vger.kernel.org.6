Return-Path: <linux-kernel+bounces-358712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F196F9982B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D011F21A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F51BCA0A;
	Thu, 10 Oct 2024 09:47:26 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE672AF18
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553646; cv=none; b=HTxj8aJstI43l9H10GuIzpWZZckV2OQuJgrfwljn4ppzNAgPa914vWF1jcnMTJO83wJxZte2te1MGS7oYXiiPiIEV6Spr2q2PVBAdLvSr+Pbo0Jm+zAP2DbXwISxYd4JSF6pY/kj7YIkKCXUbf8cqrfLshI4IDTuC7Ht42BhDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553646; c=relaxed/simple;
	bh=Za32LgXO4KETW3RlWS7RTk/2Y57maLYLm5UF/riXKn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAi6x2EHIiuUSz/5vvGhz2N6qgebLVe1cWGlr8wTb6RBB9ZqQTPvEO9WRQ9SNg8BbYwc1NBGcCZnTh7Misux0duRi/dEgSFOOnyXOlzdd6u8vFGnyuQNXc1IMykynnGSe/x4qjdgVqmJcuMeDEu2otKsm3TAUxTK2yUgJ7yZjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 6806EAA290;
	Thu, 10 Oct 2024 18:47:22 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 120juincZe4u; Thu, 10 Oct 2024 18:47:22 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 47569AA264;
	Thu, 10 Oct 2024 18:47:22 +0900 (JST)
From: takakura@valinux.co.jp
To: john.ogness@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	pmladek@suse.com,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	takakura@valinux.co.jp
Subject: Re: [PATCH] printk: Allow direct printing for PREEMPT_RT during panic
Date: Thu, 10 Oct 2024 18:47:22 +0900
Message-Id: <20241010094722.15194-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <847cagmjsx.fsf@jogness.linutronix.de>
References: <847cagmjsx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, John!

On 2024-10-10, john.ogness@linutronix.de wrote:
>On 2024-10-10, takakura@valinux.co.jp wrote:
>> If PREEMPT_RT was enabled, printing for legacy consoles are deferred
>> by default, including after printk_legacy_allow_panic_sync() during 
>> panic which allows direct printing afterwards in case of !PREEMPT_RT.
>> As a result, printing of messages during panic for PREEMPT_RT
>> is handled by the console_flush_on_panic() called at the end.
>
>This is on purpose because legacy consoles are not safe in many contexts
>under PREEMPT_RT. console_flush_on_panic() is used as a final "hope and
>pray" excercise even though it is not safe on PREEMPT_RT, which is why
>it is at the end of panic(). printk_legacy_allow_panic_sync() only
>exists for !PREEMPT_RT.
>
>> In case if kexec was loaded, console_flush_on_panic() will not be
>> called and starts booting into the second kernel without printing
>> the messages.
>
>If legacy printing is allowed before, the kexec may never happen because
>the unsafe legacy printers can hang the system.

Thanks for clarifying, I see that it was on purpose.

>> Allow direct printing for PREEMPT_RT during panic so that messages
>> before kexec gets printed.
>
>Sorry, NACK. This goes against everything we have worked for with the
>rework. The solution is to update your console drivers to NBCON.

Got it, I will look into it!

>John Ogness

Sincerely,
Ryo Takakura

