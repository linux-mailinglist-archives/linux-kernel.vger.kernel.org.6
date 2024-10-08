Return-Path: <linux-kernel+bounces-354436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED72F993D72
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223CC1C22E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A034CF5;
	Tue,  8 Oct 2024 03:23:39 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFADD1E49E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357818; cv=none; b=seooTG1vPmwQ7J2ybdMwapYqmwN9ndcCMGAeorHSrW/Lfw3zX/mM5u9uzu9uzUToiApBttxX5kJQ0Ng1oK4mPvIj2MnzCX2bnCPFsYttLWf5dsIAixQbJPj79uwQ5qp1CgU5kcZxHPboZRZZHNZ+lGNNjNwm8SbKfFcEvG/WB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357818; c=relaxed/simple;
	bh=cmhypwK+KaMcTil948zxZjf08BLDox6dIfNYQts+Gqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTwZvQ1WzE3hybvoAO8FLszOZwbhZjtMjb54bU9RRYRk1J/Mwy4sC/U1X9K9kfc3UUf6oJV0CJsD14qVT7xV/tdM65FD9RwX9Q3BuFRdASh6xHNEt0Lih8aJZnOAxk9VQPLgN7KMod0SlImNucZbdn6Oet/vkNPMBSfUyhKxvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4983N12F048816;
	Tue, 8 Oct 2024 11:23:01 +0800 (+08)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 47288200472F;
	Tue,  8 Oct 2024 11:29:20 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 8 Oct 2024 11:22:19 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <akpm@linux-foundation.org>
CC: <jiaoxupo@h3c.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shaohaojize@126.com>, <zhang.zhansheng@h3c.com>,
        <zhang.zhengming@h3c.com>, zhangchun <zhang.chuna@h3c.com>
Subject: [PATCH v3] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock.?=
Date: Tue, 8 Oct 2024 11:23:57 +0800
Message-ID: <1728357837-26345-1-git-send-email-zhang.chuna@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 4983N12F048816

Very sorry to disturb! Just a friendly ping! This deadlock bug needs to fixed!
If any additional info needs, please contact me. Long for your reply!

-- 
1.8.3.1


