Return-Path: <linux-kernel+bounces-518728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490BAA393D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A47A3B217E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D251B422A;
	Tue, 18 Feb 2025 07:33:47 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C337482
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864027; cv=none; b=PT1GDpjdOdhFNocRelu8rjNkoHxUFCC/Y+fMJSq3yoQGcUKHDwmUtsZvJ8PwpzLLIEaG105k6D/jqLjmY8xYfeOzETziIrBDTr08t4a0vBqEZIA9hs39MxImMatSSueDwPhAOwUlzpJRE+2pELZl3TvOYb/Rj2/KsBZHd6SkZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864027; c=relaxed/simple;
	bh=5pxr4VCSG7epmoiMbE56+oatsRe0HQLRB9PR9JrCePc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRiD9l3ivgMLzuvTXpPAfXzTWi0/yQdu3Tmtdo4yxjO9YzzNY0282KvNjQm1kpTSIsEU/hR25MsDHjaHWDAQYHsqq8ooxO4F8Qb+VopWZ5mwXKM/2hN8V+iTVMY582ZVI3ING/j3+SUKNPdJTCoMfwhU/A0gAlJwK1IweO5eh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 51I6T2Rq018298
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:29:02 +0800 (+08)
	(envelope-from zhang.chunA@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 51I6SMQK016431;
	Tue, 18 Feb 2025 14:28:22 +0800 (+08)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 80294200C249;
	Tue, 18 Feb 2025 14:30:02 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 18 Feb 2025 14:28:23 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <akpm@linux-foundation.org>
CC: <zhang.chuna@h3c.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <shaohaojize@126.com>, <zhang.zhansheng@h3c.com>
Subject: [PATCH v4] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock.?=
Date: Tue, 18 Feb 2025 14:30:52 +0800
Message-ID: <1739860252-57488-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1730387884-57777-1-git-send-email-zhang.chuna@h3c.com>
References: <1730387884-57777-1-git-send-email-zhang.chuna@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 51I6T2Rq018298

Very sorry to disturb! Just a friendly ping! Half a year has passed, this deadlock bug is 
necessary to fix! If any additional info needs, please contact. Long for your reply!

-- 
1.8.3.1


