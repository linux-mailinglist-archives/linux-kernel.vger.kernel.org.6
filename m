Return-Path: <linux-kernel+bounces-177476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8678C3F51
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C411F21CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675D14AD20;
	Mon, 13 May 2024 10:54:41 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169C114A614
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597681; cv=none; b=Ji6Dk3MlTRvOewKReZtYe0RLPFW+zFiLV0WZ5RPx1AuUYtWL/ysI/5INis9YlwWW3a//SHTX6/fSEBM/BAcGgFiW14LW59BFrv7CFgfRFnWw77VLLVPodnq5YA/EdMcSfsCU2Lfu7hc8RjapPzErLXb7BHKo+s463cI9+l+HI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597681; c=relaxed/simple;
	bh=5oSpI+yEDAjstmktVw/EAv6DAdZsnilJtyVy9s9eXPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFs2vyH37+17LdTRu/gnC7+NRG3ovRJDwJTUIfAXhVy0730FKjiLmqfK/XiDqwMcMmrDQXg3hSS4UREdp75oEmWZz/iSUbyD717WT927/4YNllEwuvzMnv4uX47ZdD7zsH9/zJfeV4FbviQBxj5ykTVVY3AjbT05Th5YDxmo5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.17])
	by sina.com (172.16.235.25) with ESMTP
	id 6641F15E0000393B; Mon, 13 May 2024 18:54:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 45323634210360
X-SMAIL-UIID: 106C01B471954D5E8661512F8CB6D411-20240513-185425-1
From: Hillf Danton <hdanton@sina.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
Date: Mon, 13 May 2024 18:54:13 +0800
Message-Id: <20240513105413.2951-1-hdanton@sina.com>
In-Reply-To: <CAEkJfYPO8OK=JCFphuZvqzqCWpUjPiTVoHma3CY0gLo+rdLKNw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 May 2024 10:38:34 +0800 Sam Sun <samsun1006219@gmail.com>
> Dear developers and maintainers,
> 
> We encountered a task hung in function blk_mq_get_tag. It was tested
> against the latest upstream kernel which was compiled by clang 14.

BTW make it clear if repro is available and if you could test patches
in reply.

Thanks for your report. See if the below low-hang pear is sweet, I
mean see if it could survive your repro.

--- x/block/blk-mq-tag.c
+++ y/block/blk-mq-tag.c
@@ -180,8 +180,10 @@ unsigned int blk_mq_get_tag(struct blk_m
 		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
 
 		tag = __blk_mq_get_tag(data, bt);
-		if (tag != BLK_MQ_NO_TAG)
+		if (tag != BLK_MQ_NO_TAG) {
+			sbitmap_finish_wait(bt, ws, &wait);
 			break;
+		}
 
 		bt_prev = bt;
 		io_schedule();
@@ -208,8 +210,6 @@ unsigned int blk_mq_get_tag(struct blk_m
 		ws = bt_wait_ptr(bt, data->hctx);
 	} while (1);
 
-	sbitmap_finish_wait(bt, ws, &wait);
-
 found_tag:
 	/*
 	 * Give up this allocation if the hctx is inactive.  The caller will
--

