Return-Path: <linux-kernel+bounces-447178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2719F2E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341C0162CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE136203D75;
	Mon, 16 Dec 2024 10:45:13 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032C203D4C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345913; cv=none; b=PQg9k/Z5Pm2c250WM4VfuSpbDsU5UGVE6W6iqhdEiT/kz6j5n9GoPMyrxmVxUnUW1pNBRB4Ud7Vu1bZh4ibP4ybhcQNUyHwWMm3rUhCVMQzv4vSXr8xXFxZ+YofT83NBlnBxXbWtAQuhvxlHdIyi4GDrN8ekT93D6TWZVE2bJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345913; c=relaxed/simple;
	bh=FiUPkIE/sDWZPVHArm16IayTrZ7JdqAK/P7UJ9pzxbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ENCm1gORHosRljN9gjAGBddHk65hl9IB9CaR1OJOJGkyXpgzLQb7PvCAOk+qtx7QTV+51s9q3yYQaCK2QPQv1KiwA96QzUuPp9pVyoM9BbLEkkdiUGoL+it/MuWofQUsVMqRM8xt+N2H2na5l/t3+rOLzpinZ7mdOJJjOUM8xcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4BGAj7vX060266;
	Mon, 16 Dec 2024 19:45:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4BGAj7ks060262
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 16 Dec 2024 19:45:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <57f7253d-a55e-420a-b1b1-f572a0ab13f2@I-love.SAKURA.ne.jp>
Date: Mon, 16 Dec 2024 19:45:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] tomoyo: don't emit warning in tomoyo_write_control()
To: syzbot <syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        takedakn@nttdata.co.jp, Leo Stone <leocstone@gmail.com>
References: <675f4ea7.050a0220.37aaf.0105.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <675f4ea7.050a0220.37aaf.0105.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting too large allocation warning at tomoyo_write_control(),
for one can write a very very long line without new line character. To fix
this warning, I use __GFP_NOWARN rather than checking for KMALLOC_MAX_SIZE,
for practically a valid line should be always shorter than 32KB where the
"too small to fail" memory-allocation rule applies.

One might try to write a valid line that is longer than 32KB, but such
request will likely fail with -ENOMEM. Therefore, I feel that separately
returning -EINVAL when a line is longer than KMALLOC_MAX_SIZE is redundant.
There is no need to distinguish over-32KB and over-KMALLOC_MAX_SIZE.

Reported-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7536f77535e5210a5c76
Reported-by: Leo Stone <leocstone@gmail.com>
Closes: https://lkml.kernel.org/r/20241216021459.178759-2-leocstone@gmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 5c7b059a332a..972664962e8f 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2665,7 +2665,7 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 		if (head->w.avail >= head->writebuf_size - 1) {
 			const int len = head->writebuf_size * 2;
-			char *cp = kzalloc(len, GFP_NOFS);
+			char *cp = kzalloc(len, GFP_NOFS | __GFP_NOWARN);
 
 			if (!cp) {
 				error = -ENOMEM;
-- 
2.43.5



