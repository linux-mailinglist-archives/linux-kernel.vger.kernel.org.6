Return-Path: <linux-kernel+bounces-549038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1626A54C6D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BC7189525B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B620E6E8;
	Thu,  6 Mar 2025 13:42:07 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7DC20E334;
	Thu,  6 Mar 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268527; cv=none; b=HrooQCLDxGmHd/bPD+NjwNTbHN+Yb11Y+AB7Vrdc30bN5NM2nAGctOXnPcr/SFbpF8uN1V1xOS0iDOLBUn0ysQtIRjKoWCHfoi0R3D0nR8W2sTvG4S5j+05xBtC4wxVMXPe1oZsG7WdxBSXvCrnt+UzdDkkQbG1rvIq3bjt+P/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268527; c=relaxed/simple;
	bh=imLI8eolIWmY/Aa/YeqtMKANsToH4klHQWyerVyvnYY=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=lqfFkvD6oxClHlRDu9SaqA7TSGu+BLaV2tjxKKe/DT0zoybJHF5bCbRb6NjFhvYRId9Pz7ARn9BOfOZYOwE8zWiMDvWHqggLwILeliMxVALjtkDwpL6mHjL/6r5Vt0RsZiEZqjSjzdht7RG6uoPDawvp7suvOTkmP3Xd4QXSQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z7rC66XHbz1R6DF;
	Thu,  6 Mar 2025 21:40:18 +0800 (CST)
Received: from kwepemd100020.china.huawei.com (unknown [7.221.188.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 75D111A0188;
	Thu,  6 Mar 2025 21:41:57 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by kwepemd100020.china.huawei.com
 (7.221.188.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Mar
 2025 21:41:56 +0800
Message-ID: <0af1c796-aa08-4284-ae6b-470fa75799b5@huawei.com>
Date: Thu, 6 Mar 2025 21:41:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Greg KH <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <linux-cve-announce@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "youbowen (A)" <youbowen2@huawei.com>
From: "zhangjianhua (E)" <chris.zjh@huawei.com>
Subject: Re: CVE-2022-49623: powerpc/xive/spapr: correct bitmap allocation
 size
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100020.china.huawei.com (7.221.188.213)

Hi Greg，

The commit message of this patch show that it occurs out-of-bounds of 
xibm->bitmap，the reason is that the allocated object can be smaller than 
sizeof(long) while bits is small.

However, it is incorrect.  The kzalloc interface allocates memory in the 
unit of byte while bitmap_zalloc does based on the number of bits after 
rounded up, the space allocated by the kzalloc is not less than that 
allocated by the bitmap_zalloc. Therefore, replacing the kzalloc with 
the bitmap_zalloc does not solve the problem. In fact, the problem of 
out-of-bounds access does not exist. For instance the xibm->count is 
3，kzalloc and bitmap_zalloc both return 8 bytes，it's enough for all 
bitmap. Although using the kzalloc wastes some memory, it does not 
create any real problems.

Maybe this CVE should be rejected?


Jianhua Zhang

Best regards.


