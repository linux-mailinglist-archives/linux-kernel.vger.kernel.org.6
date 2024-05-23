Return-Path: <linux-kernel+bounces-187398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F187C8CD13A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927711F21C49
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785C144300;
	Thu, 23 May 2024 11:31:23 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4A13D293
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463883; cv=none; b=e94SrVmgBHFiUeKLQwiztPNvwnyW+ME0SrUGy8VmAQMT/wsjugz2qLoFqlsU4zf8hucURjvKyjfixQROBFAREiHYmrC1ZQab7LRiWigvqEhOFIhQ1o9yRjODogttTWFvj156bns7GZPslgb4hq0KgXFLJkFzDp/bzfrAfkutmL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463883; c=relaxed/simple;
	bh=nmX2kYBeqtVLSelimdPXKQDwxlk8oBAMzgJXaoBP15A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xk1TovyKW505FkuX8Y9gDbXJuXaxnhVlTkLhCc4DX7YxXq7ox7OK5zq5yW3lXy1IBbUYaEWaMFwh0suTn2J0WlUYhp8rQ5foZUUUiuqI35eye6StVSM6spcDz605hSamjgGo0C+r6niaLPD2sL8qKSWE1uXl8WI90GPTo7VY7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.155])
	by sina.com (10.75.12.45) with ESMTP
	id 664F28F900002574; Thu, 23 May 2024 19:31:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 91507531457636
X-SMAIL-UIID: D166617DAB7D4799AB52F0DDBD3CB121-20240523-193110-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+57cc2f20a84cb4346354@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] possible deadlock in uart_write (2)
Date: Thu, 23 May 2024 19:30:57 +0800
Message-Id: <20240523113057.2386-1-hdanton@sina.com>
In-Reply-To: <000000000000be49b106191916f0@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 May 2024 23:23:26 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    de7e71ef8bed mm: simplify and improve print_vma_addr() out..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140480ec980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  de7e71ef8bed

--- x/drivers/tty/serial/serial_core.c
+++ y/drivers/tty/serial/serial_core.c
@@ -622,8 +622,9 @@ static ssize_t uart_write(struct tty_str
 		return -EL3HLT;
 
 	port = uart_port_lock(state, flags);
-	if (WARN_ON_ONCE(!state->port.xmit_buf)) {
+	if (!state->port.xmit_buf) {
 		uart_port_unlock(port, flags);
+		WARN_ON_ONCE(1);
 		return 0;
 	}
 
--

