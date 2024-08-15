Return-Path: <linux-kernel+bounces-287818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F9F952CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6910E285AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2771A7072;
	Thu, 15 Aug 2024 10:41:20 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B471A256C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718480; cv=none; b=HPE3jurnvAE0X8yI9PuN9IxaB0qoE/RFdCeCoffJ9oBFHIN6Rjv8kIxDCPCqAwCZfBrKLCsEJl43ddTayBU8sn78VsXiLoGsz0EKZSj8AOWOuA6pKg6YnpPV1XkXPW4kugZOs6bMr4N+jFb8L6Mtcxs71X0urMUcK5wVwKGJfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718480; c=relaxed/simple;
	bh=qXoa31UOI/ScyxIxnQ8eIYh103YErjefJAiSWIIZWgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NpnfjSho27BJSuih4GiFTpH8QfpacDInc+LBHi24HktHlrUlbovZH6IRuyl6DE6b8htPkBvAayIz1hPmqkg0eOHtSZ1mpUUnH6w6foempA5x+wICocHRCEXnPaLgwfyvwvpvrdV3dMvoBQqV8646kl9gLXz7D7Fa32Oio1vqP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 06FFDA9E69;
	Thu, 15 Aug 2024 19:41:10 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K6y3jmnz_U8p; Thu, 15 Aug 2024 19:41:09 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id CEDDBA9E65;
	Thu, 15 Aug 2024 19:41:09 +0900 (JST)
From: takakura@valinux.co.jp
To: pmladek@suse.com,
	john.ogness@linutronix.de
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	feng.tang@intel.com,
	j.granados@samsung.com,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	nishimura@valinux.co.jp,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	stephen.s.brennan@oracle.com,
	taka@valinux.co.jp,
	takakura@valinux.co.jp,
	ubizjak@gmail.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 1/2] Allow cpu backtraces to be written into ringbuffer during panic
Date: Thu, 15 Aug 2024 19:41:08 +0900
Message-Id: <20240815104108.48576-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZrtkMciiYhUK8Fs4@pathway.suse.cz>
References: <ZrtkMciiYhUK8Fs4@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr and John,

On Tue 2024-08-13 13:48, Petr Mladek wrote:
>On Mon 2024-08-12 16:27:03, takakura@valinux.co.jp wrote:
>> From: Ryo Takakura <takakura@valinux.co.jp>
>> 
>> commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
>> to ringbuffer") disabled non-panic CPUs to further write messages to
>> ringbuffer after panicked.
>> 
>> Since the commit, non-panicked CPU's are not allowed to write to
>> ring buffer after panicked and CPU backtrace which is triggered
>> after panicked to sample non-panicked CPUs' backtrace no longer
>> serves its function as it has nothing to print.
>> 
>> Fix the issue by allowing non-panicked CPUs to write into ringbuffer
>> while CPU backtrace is in flight.
>> 
>> Fixes: 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer")
>> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
>JFYI, I have pushed this patch into printk/linux.git, branch for-6.11-fixup.
>I am going to create pull request after it spends at least one or two
>days in linux-next.

Thanks!!

>The 2nd patch is more complicated. It depends on another patchset
>integrating con->write_atomic() callback. 
>
>Best Regards,
>Petr

Sincerely,
Ryo Takakura

