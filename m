Return-Path: <linux-kernel+bounces-354433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B45993D6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3B31F21095
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9838DE5;
	Tue,  8 Oct 2024 03:19:37 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086E525776
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357576; cv=none; b=XA9nrkD0jqBXDqjLq1zzx/+L7q7LWzKDqe7bZdUNHuKs1yvkjMCKWuuKAxNtBQsh2N5fK3jr8ckEEz/pENsddSPumgkTadr03ewiD5V6/nJJ01NvVLTJMOFbAw8f60+yH+2PJ4u+xWrCqQfFRwTBDp9c9CLSBf2Q54NGbCTmrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357576; c=relaxed/simple;
	bh=cmhypwK+KaMcTil948zxZjf08BLDox6dIfNYQts+Gqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5uE4etZu78GZzGlnmldRy1TaTg+/V+58cnzonfOO7U+glffU8NB+utty3ybTRK09fyZEXV6fUW0OibA7G92vAQhaftI5yM+frHFRyRTK+/A06mVn6KNSZX/ZVFhnG3YWM4AVeYNJusc5fv6n/6psX4etg2IM2DHqAie9GZdwSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4983IvrS034163;
	Tue, 8 Oct 2024 11:18:57 +0800 (+08)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 2AAE52004746;
	Tue,  8 Oct 2024 11:25:16 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 8 Oct 2024 11:18:56 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <zhang.chuna@h3c.com>
CC: <akpm@linux-foundation.org>, <jiaoxupo@h3c.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shaohaojize@126.com>, <zhang.zhansheng@h3c.com>,
        <zhang.zhengming@h3c.com>
Subject: [PATCH v3] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock.?=
Date: Tue, 8 Oct 2024 11:20:45 +0800
Message-ID: <1728357645-33639-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1724083806-21956-1-git-send-email-akpm@linux-foundation.org>
References: <1724083806-21956-1-git-send-email-akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 4983IvrS034163

Very sorry to disturb! Just a friendly ping! This deadlock bug needs to fixed!
If any additional info needs, please contact me. Long for your reply!

-- 
1.8.3.1


