Return-Path: <linux-kernel+bounces-316232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2570B96CCE0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D802F283FF8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D913D53F;
	Thu,  5 Sep 2024 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s4FqGviu"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27277113
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505106; cv=none; b=WLN8lWtKKyA7CA+l2fAEBeA43jkI6wlD40ltOK7SUp4xyHzAXX2o0BZo8JIUX6pzYH1CjHpZgjKKn2w/J8SlO9IQcvP4maFV2l7GIcsta7+hksG5FaCTx//TFsZVSSVbW+OIWRsvo8H23hDAbi+vsynvazmrlMSwg9fzrJapDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505106; c=relaxed/simple;
	bh=0vcnJvpd/gY/DR/ExUFwhFp+YngaXKdK9YOU7JWWiOk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=g5DClIDeHgZVQgCxOeJqn/lcW6qUhMzsf+jo+jubGi7Ir/tIUV7KjE5jiN4jxPOb21B/ZHbabN8czJrwo6DjNgcj5KXY08eF47hZ0GVeqlrxcytzZ4SFvO1Tmg2Ssv1e6YJCBW2UkRvHzuWg9/TabHdcZ61PEPavZKP/9La7SNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s4FqGviu; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725505101; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=0vcnJvpd/gY/DR/ExUFwhFp+YngaXKdK9YOU7JWWiOk=;
	b=s4FqGviu5qEcv10minKnDOu8yx+g6ACpNTozFlGk7Rux4dR14jyOoWcxyIeLRdF40wFWSAbbR1iQY336696X+KVWtmAx4cQBeqYvVKFp+6adFe5Z4FGff9LZn1amqHn5qfmUu6HybG41cwNmb6Mx0qXJNHYMtcnJJEe/9+J66EM=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEJYt6K_1725505100)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 10:58:20 +0800
Message-ID: <80045cd0-338d-43c5-bea7-378504032006@linux.alibaba.com>
Date: Thu, 5 Sep 2024 10:58:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [syzbot] [erofs?] INFO: task hung in z_erofs_runqueue
To: syzbot <syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <0000000000006d2b8f06204e76f8@google.com>
In-Reply-To: <0000000000006d2b8f06204e76f8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

