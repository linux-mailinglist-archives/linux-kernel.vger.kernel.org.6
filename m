Return-Path: <linux-kernel+bounces-279222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DBC94BAAE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB86DB216B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFE718A6C2;
	Thu,  8 Aug 2024 10:17:16 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D01189F3B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112236; cv=none; b=dgNmFlAP9S9wZ4qg8WRRa7wu/oTACf58jo52EdP9eKXSkavKTikn9U7M8qlug3Zb4dsyEmDkYD4Rvt+B3jEBdQ34vdWlvKkJaI+CRyzAvOTJt9hTy6RUW5FuMgsAYT2Ubur082XzQJFdxrjUPcua+9Cu+aF6uT/e5Qw8tQ4HGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112236; c=relaxed/simple;
	bh=mWdqKxCsLta5p5RspL9O2oKInK6MskbQDynD2yF8FjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9/padb/rRzt1O27QUaVPkdCC+ePVcQ2Ku5dtqStF7tvxFiMreR8b1XtDV1PsV2MuYEvYXIgKxTI8WQq3E5Y7ExWRyh0iFYFJu5zbTeQrTUGybkg+mkHEdsllp0mQK8yN9Eu4JweVDd5OG6Q8g8NDM9YHjN9vv7vYr/3aUEaQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 478AGKgm056064;
	Thu, 8 Aug 2024 18:16:20 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 51CF4200473B;
	Thu,  8 Aug 2024 18:21:17 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Thu, 8 Aug 2024 18:16:23 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <zhang.chuna@h3c.com>
CC: <akpm@linux-foundation.org>, <jiaoxupo@h3c.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shaohaojize@126.com>, <zhang.zhansheng@h3c.com>,
        <zhang.zhengming@h3c.com>
Subject: [PATCH v3] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock.?=
Date: Thu, 8 Aug 2024 18:17:55 +0800
Message-ID: <1723112275-55784-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1722255188-4478-1-git-send-email-zhang.chuna@h3c.com>
References: <1722255188-4478-1-git-send-email-zhang.chuna@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 478AGKgm056064

Very sorry to disturb! Just a friendly ping!
-- 
1.8.3.1


