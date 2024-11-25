Return-Path: <linux-kernel+bounces-420539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15C9D7C23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 681F2B2203D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A69155747;
	Mon, 25 Nov 2024 07:50:07 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4D14A4FF;
	Mon, 25 Nov 2024 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521006; cv=none; b=cDaqh/hjtemfSWV123KsG7pvuwJqe0ZnUrKFzbzf5kCmwr7Un9AziNoK6qcGwCIB/HcxfknmfgP9bZubyB7xLUjqS4WxXl90ASTCe2eyDJ9J8zT7D2UQNrlgJwcbRL5BHcDbP1PylRpzkr8x/dNH70VcWvIAmDFxzKfZINf1RyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521006; c=relaxed/simple;
	bh=GqRI+se3AnpdebmovowtqAqGfFiXb+WpeiCfDnQfSa4=;
	h=To:CC:References:Subject:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=elc3IXQ8NnC34hQcZ5ZmyTrtmlXvu0FvRqNIi424nemxtaFLJe2B6WuiUfKtEMQFPM6Kl7k6wCkFHztS2PGzmc7Dza6v4fWReXoTxag+PuVrYtdGpqOMxQiMBHsxJ1MWXHMIKn8Ds+Ha5e3QXoRRvlkOfnt4eZSTdCOGR9Cmn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xxd8G3fF3zxWH9;
	Mon, 25 Nov 2024 15:47:10 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CFC1140121;
	Mon, 25 Nov 2024 15:49:55 +0800 (CST)
Received: from kwepemn500018.china.huawei.com (7.202.194.159) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 15:49:55 +0800
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemn500018.china.huawei.com (7.202.194.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 15:49:54 +0800
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <linux-cve-announce@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aha310510@gmail.com>, Hugh Dickins
	<hughd@google.com>
References: <2024110928-CVE-2024-50228-7a2a@gregkh>
Subject: Re: CVE-2024-50228: mm: shmem: fix data-race in shmem_getattr()
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <c51f4d84-1f38-b099-dbd0-a89d78400625@huawei.com>
Date: Mon, 25 Nov 2024 15:49:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024110928-CVE-2024-50228-7a2a@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn500018.china.huawei.com (7.202.194.159)

Hi Greg,
   Will this CVE be rejected in the future? This patch has introduced a 
problem and has been reverted:
https://lore.kernel.org/all/20241116233053.F1FBAC4CEC3@smtp.kernel.org/T/

