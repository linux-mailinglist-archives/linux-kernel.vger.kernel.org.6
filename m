Return-Path: <linux-kernel+bounces-363388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B636799C1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73FB1C2259E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA614E2DA;
	Mon, 14 Oct 2024 07:40:33 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2792414D2BB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891632; cv=none; b=lXGqNUDXsBiskMb3hFrzEMf9+U0RxIR2l74iUccnTg55JEZh8uVdFXu7ukqAhfQ7PxaioGm31yEkomVvkjOt+kWrVQPQhj2rWjl8XYwK7M7eUbOE0eLet4Z6q0/pnks7lewixFGRwWQt340rsO8fJbG5/71rPZBmWcWRR9//MMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891632; c=relaxed/simple;
	bh=KvmdjAft6NbNq+S2McV0JK/9GHe867QTJLhoCis/7Eo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cydFbxR2zqMlmkC4wgNKr3aRIpWLjn20UTbVHGymvwvBRcJXLbCVUAsmZ+u/71J2lEctCziSSVNajLNm4yAQntFQ07SWpgIOpEERJIAc9mrt11Qr8pd3zMyTL30k9zh17G1jB2MQ4vyoNnk+8ubwE5/Oy0Gg9PxFwvJY4Fc1iS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 49E7diIZ088565;
	Mon, 14 Oct 2024 15:39:44 +0800 (+08)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 9E23C2004C45;
	Mon, 14 Oct 2024 15:46:12 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Mon, 14 Oct 2024 15:39:45 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <akpm@linux-foundation.org>
CC: <jiaoxupo@h3c.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shaohaojize@126.com>, <zhang.zhansheng@h3c.com>,
        <zhang.zhengming@h3c.com>, zhangchun <zhang.chuna@h3c.com>
Subject: [PATCH v3] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock.?=
Date: Mon, 14 Oct 2024 15:41:33 +0800
Message-ID: <1728891693-41227-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1724083806-21956-1-git-send-email-zhang.chuna@h3c.com>
References: <1724083806-21956-1-git-send-email-zhang.chuna@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 49E7diIZ088565

Very sorry to disturb! Just a friendly ping! This deadlock bug is necessary to fix!
If any additional info needs, please contact me. Long for your reply!

-- 
1.8.3.1


