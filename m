Return-Path: <linux-kernel+bounces-293366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E17957E50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BC51F23D69
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E01DF682;
	Tue, 20 Aug 2024 06:33:22 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F81E3CBB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135601; cv=none; b=VkMWTuJP8UNfm/qaNDvb4Ne2OIXIqJMIpF5ETam7J1UK1r+ai1g3v9yZGCSngBzW5Rrf/mZc2bi7P7sjo60ZlBRm+tYcWmw6//hHAk9MWnyOXuqkCLsxNNg/5NXj68W2Cw2oJIj9ERzJ05Iz/7XZivTc3m7H2IsLJs+vRcpJedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135601; c=relaxed/simple;
	bh=AL3C8XZzMce+2z2GFVCMTNCO2czYakJ26s8aR889jaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnU9Y16SqGTawuZBNh+1/qgB3wJngtCjVIgOdYb6cPPRHBlFxdFgNa+zOCnfN5dQ9J8njFVZiQN1KxDEF+19h/Dyoqk8u6yF6pGLb7ONbI5TbbuwKtp+RQQFiR59mjYIl+A8UfJaz0uNKzmP+vlX1qA77cTdynznQx0Yb5GkJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 47K6Vg7J031506;
	Tue, 20 Aug 2024 14:31:42 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id BAEDC2004C4C;
	Tue, 20 Aug 2024 14:36:54 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 20 Aug 2024 14:31:44 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <willy@infradead.org>
CC: <akpm@linux-foundation.org>, <jiaoxupo@h3c.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shaohaojize@126.com>, <zhang.chuna@h3c.com>
Subject: [PATCH] use might_sleep check if kmap_high is called from atomic context
Date: Tue, 20 Aug 2024 14:33:20 +0800
Message-ID: <1724135600-42498-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <ZsQMgpZpx4oo_a9b@casper.infradead.org>
References: <ZsQMgpZpx4oo_a9b@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 47K6Vg7J031506

>On Tue, Aug 20, 2024 at 09:53:11AM +0800, zhangchun wrote:
>> kmap_high is defined as EXPORT_SYMBOL, and cannot be called from 
>> atomic context. Add might_sleep check is necessary.

>No.  Nobody should be calling kmap_high() directly.  There's already a
>might_sleep() in kmap().  No need to add one in kmap_high().

To avoid anyone calls kmap_high directly, add function description "Don't
use kmap_high directly, if necessary, please use kmap"
Signed-off-by: zhangchun <zhang.chuna@h3c.com>
-- 
1.8.3.1


