Return-Path: <linux-kernel+bounces-331343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3397AB87
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF2528B805
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4E73176;
	Tue, 17 Sep 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SwsPvLBk"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4663B1A2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555154; cv=none; b=QMp7P4GhdTA9bOAyzSamIg9JHWXFFuF+uQdMon4ky56CkH/kAVDNmWn0QuMABdnPUCStjN84qumPTPy+OyW1x+R/cDrCoiCIMLmBJtTxYoImNuWD0SB9Q+CXcRNUA7GDemlndyYLlCY6toNaNibORk7vMXkMo8YCRAwmQSakPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555154; c=relaxed/simple;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hodOmx25dimXFgBNlLckTgQt+Q5F3rDRRechbzf/OJE9JI7KnJKLx1JOJOI6IW3AeKYgeQEZ+/G8oX+d5Bga8jHupxBmrJA7W7jP/bZqg7nc/3gNdYcMS2yLAVNICu/LDhvXF5M86sHZSnzieytP+Xp9OE48Ylylq7/Y8MWKuqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SwsPvLBk; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726555143; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=SwsPvLBksbpbqux4HbXYEQp7Ove0cbkvp/pkYZKgHR0YhqbcYs0xRNGQ+PVdtBGpAPmOMxtjLXYzeQ5jkIlZKRW2f/O6Xv4gS1k6dWrsVEJp27ka216NPeOD+eTvSVUQ3y1hPfnrAhg1xzTsBNxxU6Y7v+XCFfXodQI3hrzZNmo=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFA9uEv_1726555141)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 14:39:03 +0800
Message-ID: <f58a6956-5029-4764-962c-ffc02602a755@linux.alibaba.com>
Date: Tue, 17 Sep 2024 14:39:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] [mm?] BUG: unable to handle kernel NULL pointer
 dereference in filemap_read_folio (3)
To: syzbot <syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <00000000000011bdde0622498ee3@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <00000000000011bdde0622498ee3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

