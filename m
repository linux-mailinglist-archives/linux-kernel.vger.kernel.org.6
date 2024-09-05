Return-Path: <linux-kernel+bounces-316200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520C96CC86
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8B51F26340
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A13884D34;
	Thu,  5 Sep 2024 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T7mJ3rOo"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D0C2C6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502747; cv=none; b=Id+XbhcIy390i8dTjwbgRB/2JmrRJ8qpJACZb7Uw9lMdGVTY8RSKi7xIjwa7VopwkdrB//Z/x8+YjZ+MQmXfPt8SDJGzkRlVew4iIUiSh27ITcv3jW/geu6PEjb6ObKCYW/3LtBFvVVAIdQRSVCHmjZhl9i4QcXnR8HETwo9BtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502747; c=relaxed/simple;
	bh=oPdBIMXvvFilt1OICZGj5B5zP7g+Plj8dSvpCokCncU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gjxI5sohyh4QvlJTtA5Ny+Z+TwwBYXzi1tRF/5bpcwRtZ4Dy5+k4KHnc7R3GXEu4B/1m2RQFGklAb/61hAk8+Dy2ZVvfwQjOCD1qNCrCz8wZBGixxObWKQbs+/n7csUqvpSNbbArSrORr8jbkI5HrgBH9ExwtDs5MQXNNwLj/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T7mJ3rOo; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725502736; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oPdBIMXvvFilt1OICZGj5B5zP7g+Plj8dSvpCokCncU=;
	b=T7mJ3rOoNvuM6nEgYQibFTCy12vlgjP0YdofrKUY25bQ/wISM8I+1Ss1KWwBodnhKUDh49+hzSWiJ9l1BRzM0MJVZVI8f/Hpuvgq8kZjhiX6F32ekWhB8T8z9u+pQRKFNbMZyitKp2Y42q0sYRzoRzm7XYjIUggzhszF0NV0+G4=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEJRy.6_1725502735)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 10:18:56 +0800
Message-ID: <012b02d0-97ba-4d5a-86cc-2d3d36ed71b1@linux.alibaba.com>
Date: Thu, 5 Sep 2024 10:18:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] INFO: task hung in z_erofs_runqueue
To: syzbot <syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <0000000000006d2b8f06204e76f8@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0000000000006d2b8f06204e76f8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-next

