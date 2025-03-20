Return-Path: <linux-kernel+bounces-569388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C5A6A248
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7459169875
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008F219A8E;
	Thu, 20 Mar 2025 09:12:46 +0000 (UTC)
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4689215171
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461966; cv=none; b=dyCxfXc8rsiTdHDo3Toci1Dwr3zntkabv3tmABKU/ys+x4PcHwtJneb8hPhO81VshZEpcWvEI6kRA3UCZIZ/j84bRELnsG2Uw2Suceg2vSSi3Ki2/kSCjmvMrNiNtQ005ynfrVypxMdOCsRJBWokUDbLUIDGadYA7e8D5FG4Wpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461966; c=relaxed/simple;
	bh=JSl2k7C1dXpa216Hb1t2QVy/jPZ1Yxk5+MMJGgQqCwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcQdHEFQeY7LnGTfdGjlBBMVO7vw1rX9hAhkuOdOFRLtC2xRUWDGTOH+iQBjicwVznobQQ1IZgnwyok2iR/fND0zvRfJi0ZnlR5r28I35r0AwUOe1JdkkN9EnoTKBtDAsiT8wS+4wjy1dgzPgiPFke+QBPEJyeeyBuyqj7KWTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg02.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id D15781F45B;
	Thu, 20 Mar 2025 12:12:36 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu, 20 Mar 2025 12:12:35 +0300 (MSK)
Received: from [10.177.20.124] (unknown [10.177.20.124])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4ZJKbj6gJ6zkX0x;
	Thu, 20 Mar 2025 12:12:33 +0300 (MSK)
Message-ID: <ad70d906-8889-40d3-9af6-6a2be68faf77@astralinux.ru>
Date: Thu, 20 Mar 2025 12:12:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/zsmalloc: prevent integer overflow in obj_free
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20250313115147.47418-1-abelova@astralinux.ru>
 <w7ralg6gzp6kuqwulpczs7uv4htllt2rasuto5unoy7xasr5cv@2z6pd7syyj6q>
Content-Language: ru
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <w7ralg6gzp6kuqwulpczs7uv4htllt2rasuto5unoy7xasr5cv@2z6pd7syyj6q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191963 [Mar 20 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/03/20 06:25:00 #27805285
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1


On 3/13/25 5:42 PM, Sergey Senozhatsky wrote:
> On (25/03/13 14:51), Anastasia Belova wrote:
>> The result of multiplication of class_size and f_objidx
>> may not fit unsigned integer. Add explicit casting to
>> unsigned long to prevent integer overflow.
> I can't see how this can be possible.  Neither size_class nor
> object idx can take values to cause mul overflow.

object index may be up to OBJ_INDEX_MASK = ((_AC(1, UL) << 
OBJ_INDEX_BITS) - 1)
= ((_AC(1, UL) << PAGE_SHIFT) - 1)

class_size may be up to ZS_MAX_ALLOC_SIZE = PAGE_SIZE.

If address (and unsigned long) is 64-bit, the result of multiplication
won't fit 32-bit integer. Please correct me if I'm wrong.

Best regards,
Anastasia Belova

