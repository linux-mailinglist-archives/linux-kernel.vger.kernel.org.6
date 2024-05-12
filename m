Return-Path: <linux-kernel+bounces-177040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C38C390C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 00:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4542815D1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 22:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC4654725;
	Sun, 12 May 2024 22:35:16 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D8125C1
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715553316; cv=none; b=S0B+vZyd5FCPBGCKDCMwgjB8cmcjSZhDzZ6nrLZmywYpki5oONNtBUv1kqcLmm5GfwWwOrpCHY57jQm8tdUi2WuwZ8VbC9wAyn3G9bRZipxPh9aZH8k2Mnk0mJ4LkOBh1sowzwPb/a0BsvT9RRsF4DzTCvogqcFUYtGrSQHfnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715553316; c=relaxed/simple;
	bh=+3PWNa5vu4v4ZDcYMOqNgYcDi6Pys7j6o48CUQaqlP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aE2CB8pbUC4Yb2UzOQ4tD63oIofwVgMAepu6ukbHmj2v5KWrd+VUpy2Jy+kqn0EfUEJhHJSYv+yyB2pP0g3+qCHlv0gW01uTFnO0hCfNHezU8SQIKghhbqJ49O5rVfoYVJyVHXlXaJ1DrGkQ3MlQtp0wqxAh6Y010SVBIL0Ih/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.17])
	by sina.com (10.75.12.45) with ESMTP
	id 6641441300003213; Sun, 13 May 2024 06:35:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 98230631457684
X-SMAIL-UIID: 3DA8D9B156A74F808910717F31B41ADF-20240513-063501-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in __fput (2)
Date: Mon, 13 May 2024 06:34:50 +0800
Message-Id: <20240512223450.2890-1-hdanton@sina.com>
In-Reply-To: <000000000000898d010616c1fd03@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Apr 2024 04:38:18 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    4d2008430ce8 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10923dfd180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

