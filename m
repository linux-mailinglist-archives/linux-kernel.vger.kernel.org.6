Return-Path: <linux-kernel+bounces-279261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A99D94BB0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8012846AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353D618A955;
	Thu,  8 Aug 2024 10:31:27 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7D18A948
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113086; cv=none; b=hJAV2aFyIVrPtOdtkzlNLdDm2QMwGczMDsOp/81buwIXo7lKSG4VZ5Y6D9vEfEvu7yb7sVqVvdp/RinXfEedtDXwKxGP6eNxCKunvkzaiEbELbseaXYpUs6WVh/r6RogGeChJYSsavHMQXeIXzwPkPUVaiCCvTI6MqXZXe3ILw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113086; c=relaxed/simple;
	bh=mWdqKxCsLta5p5RspL9O2oKInK6MskbQDynD2yF8FjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLGl77TSs2nLz7FGQRW+wVU4XKRwAuUh2dCmFzeoyQ2EDSFCtl/kxqOEe1iVY1lH7nREMdgP7y55meh0vEx8/xvY0/sEQiblLMcSo7G0pj+LtUPGH7+FzACusFuKg/3xLgjiRfgOtH2N7AKlo6ESmUdS9znUHqVQVNCvzo4Jfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 478AUotP078542;
	Thu, 8 Aug 2024 18:30:50 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id B7E462004739;
	Thu,  8 Aug 2024 18:35:46 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Thu, 8 Aug 2024 18:30:52 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <akpm@linux-foundation.org>
CC: <jiaoxupo@h3c.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shaohaojize@126.com>, <zhang.chuna@h3c.com>,
        <zhang.zhansheng@h3c.com>, <zhang.zhengming@h3c.com>
Subject: [PATCH v3] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock.?=
Date: Thu, 8 Aug 2024 18:32:25 +0800
Message-ID: <1723113145-16349-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20240710103611.809895ff809df9ed411bfaa8@linux-foundation.org>
References: <20240710103611.809895ff809df9ed411bfaa8@linux-foundation.org>
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
X-MAIL:h3cspam02-ex.h3c.com 478AUotP078542

Very sorry to disturb! Just a friendly ping!
-- 
1.8.3.1


