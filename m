Return-Path: <linux-kernel+bounces-277597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC294A37F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C77B23392
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B771CB309;
	Wed,  7 Aug 2024 08:59:24 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519471CB303
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021164; cv=none; b=cb+EHbC0wGGrzIDJyKscbcCG5TWNb51rkLdTAUZQ/tjuCW11h0clOoTzBRGbqAQNwJJpSG+6p+eosAmKLb5Jm4vI8+LhFtukiB0Fp1DUGHxvC8koVxHmijgvFx49ydAUi1cDz91MST3/ANsOKV4mnq8zzGhhIu3WtQg7J+OHgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021164; c=relaxed/simple;
	bh=7LPQSm+yG94Ez2Qfwia3iyqvf19g6sm5ehW/W/NqBvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FiXokJ90c/yN9xg5nlBklDlwVAir5SHfuOAtkMdkGXqOzKiCp50DNl59FZK325ttfHj6AbV0QGekDi/wvX/Man1p4NJYsHZsCuRnfnFCfww2VAUoysKP9OzzPB0ujQq9ZCNTHRUyIZqTVERlcn9OUSq40tqEzo8zEzr++hRvlCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 3DBDBA9D00;
	Wed,  7 Aug 2024 17:59:20 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-IzNs6CvPnp; Wed,  7 Aug 2024 17:59:20 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 0CCE7A9B77;
	Wed,  7 Aug 2024 17:59:20 +0900 (JST)
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
Subject: Re: [PATCH v2 1/2] Handle flushing of CPU backtraces during panic
Date: Wed,  7 Aug 2024 17:59:19 +0900
Message-Id: <20240807085919.92798-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87v80f2hii.fsf@jogness.linutronix.de>
References: <87v80f2hii.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi John and Petr,

On 2024-08-05, John Ogness wrote:
>On 2024-08-03, takakura@valinux.co.jp wrote:
>> From: Ryo Takakura <takakura@valinux.co.jp>
>>
>> After panic, non-panicked CPU's has been unable to flush ringbuffer 
>> while they can still write into it. This can affect CPU backtrace 
>> triggered in panic only able to write into ringbuffer incapable of 
>> flushing them.
>
>Right now, they cannot write to it. If you apply your second patch
>before this one, then the above statement is true.
>
>Perhaps the ordering of the two patches should be reversed?

Yes, that is true. Thanks!
I'll send the patches in the reverse order for next version. 

>Either way, for the series:
>
>Reviewed-by: John Ogness <john.ogness@linutronix.de>

Sincerely,
Ryo Takakura

