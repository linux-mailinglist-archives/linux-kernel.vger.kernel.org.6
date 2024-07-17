Return-Path: <linux-kernel+bounces-255103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E7933C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EC4282FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BDE17F39B;
	Wed, 17 Jul 2024 11:15:27 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A872E64A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214927; cv=none; b=qt/3l0ANrv+r8cSUnEc+Dag7IyzFeL3gam67wZds+aYO0Yp03td81QzVSxctOsNj7Cqanx2571nbErW+1XSA45R63hOZqfFLDZDHloDdJUxMj7dRqQGML1QlzOTtn4vKLhxqCTTl+GiwMZMSjcBFOtPsSiHZZbNj4RTKSqzbcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214927; c=relaxed/simple;
	bh=G5wrRJdtY3srXR0DCXgj0dxICAEmp/C47cWByB8cBqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGUl2sRoGLnuw4Snw6o+X9Vjju3b8DMOn/UHN5cwBkKL//fx3HYxU3vYJX20r7CF4EdP62YCNeFFJy+Eas2rUwwKF4SI0MXskM6ywMw6lQ4OUIRgn7H373aaVJUAtbdXecfMbGjgaXwQfSS1phXMkOFH2/Gc+Qz8pSH4HqCzJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.143])
	by sina.com (10.185.250.23) with ESMTP
	id 6697A7C20000334E; Wed, 17 Jul 2024 19:15:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8710978913247
X-SMAIL-UIID: F489EBE2EA4B4915A4F0E50DDBABFABC-20240717-191516-1
From: Hillf Danton <hdanton@sina.com>
To: Bharata B Rao <bharata@amd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Yu Zhao <yuzhao@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Mel Gorman <mgorman@suse.de>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
Date: Wed, 17 Jul 2024 19:15:10 +0800
Message-Id: <20240717111510.1260-1-hdanton@sina.com>
In-Reply-To: <9a53c5cd-6215-4ebd-a17c-1706077a9e65@amd.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jul 2024 16:20:04 +0530 Bharata B Rao <bharata@amd.com>
> On 17-Jul-24 3:07 PM, Vlastimil Babka wrote:
> > 
> > It seems weird to me to see anything that would require ZONE_DMA allocation
> > on a modern system. Do you know where it comes from?
> 
> We measured the lruvec spinlock start, end and hold
> time(htime) using sched_clock(), along with a BUG() if the hold time was
> more than 10s. The below case shows that lruvec spin lock was held for ~25s.
>
What is more unusual could be observed perhaps with your hardware config but
with 386MiB RAM assigned to each node, the so called tight memory but not
extremely tight.

