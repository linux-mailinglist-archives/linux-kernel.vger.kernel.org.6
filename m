Return-Path: <linux-kernel+bounces-380976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740C59AF875
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E3F1C21B11
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC318DF69;
	Fri, 25 Oct 2024 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p8dvhtoc"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F518D64D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828018; cv=none; b=H5oQVDbDCIFfVmibAO+81TKVJ2q9Zq4r3+KLla81ZakJ7p00xReID/tx5WuBgiFsQ+M72pRG6n0bXL5/CfV3xRiVD+v0FLbRovpKbSp3T1g9L2BBYZU8QuD2V+BMRn0fxQoy6irFKGAr8jCirOABhpTeTudzkYqKRk5H7h9Ma0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828018; c=relaxed/simple;
	bh=QJlh0cP76ZqZak+VHqIXFOO1KS98ORU8bZ4itrnwT30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzSmG5sic9GD0hP0BTS6LaQtMKDnr6QzlRdd2Aju//xD/ak1dEhz4CZkRAqP2Li01dTT06npVEXMY9qeCwqi+K8yhZ9DQpTiefS1ZBM9eeEQ6hHOBsDfBJ145s79SR7KHBILkyLTPaw+Oz2jz69dM9+z2AZ0YNSOwCyJDDOTifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p8dvhtoc; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729828006; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zrU5pvf8Ccmt/8aWbf428dLHkAkvKhXVcjKOe29osiI=;
	b=p8dvhtocz8QcbzRzRY49/NQZAP5VDVYkyv/c+JhtVv3jkk5kraEC/ArZgMfKNH23KVX+8NKgbSGBh17Ko+CU1IhwxeaJ5jR0R3jgi6+xlIq0gMvwwJxsTJ+0QiOcEEkd2JfX6FT+h/V1hzLuV+3OTLxxkrAAYCyDeQKWWVz4mTs=
Received: from 30.74.144.130(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHr0gmx_1729827688 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 11:41:29 +0800
Message-ID: <01423085-1622-41ed-a882-64291f3e97ab@linux.alibaba.com>
Date: Fri, 25 Oct 2024 11:41:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fallback to page size splice if large folio
 has poisoned subpages
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 wangkefeng.wang@huawei.com, shy828301@gmail.com, dhowells@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <fd3893f318493a3720dc1a4b1c33f0f692ddf125.1729825743.git.baolin.wang@linux.alibaba.com>
 <ZxsRCyBSO-C27Uzn@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZxsRCyBSO-C27Uzn@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/25 11:31, Matthew Wilcox wrote:
> On Fri, Oct 25, 2024 at 11:26:39AM +0800, Baolin Wang wrote:
>> The tmpfs has already supported the PMD-sized large folios, and splice()
>> can not read any subpages if the large folio has a poisoned subpage,
>> which is not good as we discussed in previous mail[1].
> 
> folios do not have subpages.  folios have pages.  do not use the term
> "subpage" anywhere.  ever.

OK. This is my previous habit of naming it. Will change 'subpages' to 
'pages' for folios.

