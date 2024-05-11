Return-Path: <linux-kernel+bounces-176777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A3B8C34BB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305D41C209DD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161683FB0F;
	Sat, 11 May 2024 23:34:32 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391C1CAA5
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715470471; cv=none; b=U54YMXxymIzh4RhNbENUspLGHWT2iQmAZsCYPWQQLrXBXhG0qaPJyg5pMf/t8x3O7QxEA+7iMYtEQILfsNAWkW6VujD2uC8QRSEGEBYWQIQcyv7KYbBOTij/HPQsIoweKNrlWNHRR82lNsF3WIBvbe5eafJq1p+LMPBIKQ5B6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715470471; c=relaxed/simple;
	bh=yG3QvXIBxLaiZvKf2nykW9fnavoQe0jaouFl5e8ukZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PPX3N5k/6k5ZECVnOx3j4OsS/K8c5nSgWMCh0LlpFWy46Fo6VypP52TW0colcXAYen6pg8D5RstVckfm62G//5Hy5oFj5fLkdF9gsnpxUHfJsheEo1Bk87AQF3phw7mnTM9B8CR95ujD+IUUOEStLEFtRggMdw8ez8kFLgdwyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.25])
	by sina.com (10.75.12.45) with ESMTP
	id 6640007500001EDC; Sat, 12 May 2024 07:34:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 22319631457846
X-SMAIL-UIID: CCAE3AD48149438794BBB3613593D6F3-20240512-073416-1
From: Hillf Danton <hdanton@sina.com>
To: lee bruce <xrivendell7@gmail.com>
Cc: syzbot+68619f9e9e69accd8e0a@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Edward Adam Davis <eadavis@qq.com>,
	clf700383@gmail.com,
	michael.christie@oracle.com,
	mst@redhat.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in kill_orphaned_pgrp (2)
Date: Sun, 12 May 2024 07:34:04 +0800
Message-Id: <20240511233404.2764-1-hdanton@sina.com>
In-Reply-To: <CABOYnLy5WHJBjk33pzr12w5e7CDGb43LhQ5zQow0on4pCYusjw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 May 2024 22:45:06 +0800 lee bruce <xrivendell7@gmail.com>
> Hello, I found a reproducer for this bug.
> 
Thanks for your report.

> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: lingfei cheng <clf700383@gmail.com>
> 
> I use the same kernel as syzbot instance
> Kernel Commit: upstream dccb07f2914cdab2ac3a5b6c98406f765acab803
> Kernel Config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D6d14c12b661fb43
> with KASAN enabled
> 
> Since the same title bug is triggered in
> https://syzkaller.appspot.com/bug?id=3D70492b96ff47ff70cfc433be100586119310670b.
> I make a simple RCA.
> In the old-syzbot instance the bug still trigger the title "KASAN:
> slab-use-after-free Read in kill_orphaned_pgrp=E2=80=9D and in the lastest
> syzbot the bug report as
> 
> TITLE: WARNING in signal_wake_up_state
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 8591 at kernel/signal.c:762
> signal_wake_up_state+0xf8/0x130 kernel/signal.c:762
> Modules linked in:
> CPU: 3 PID: 8591 Comm: file0 Not tainted 6.9.0-rc7-00012-gdccb07f2914c #6

Could you reproduce it in the next tree, because of d558664602d3 ("vhost_task:
Handle SIGKILL by flushing work and exiting") adding reaction to signal?

