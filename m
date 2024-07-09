Return-Path: <linux-kernel+bounces-246247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A5992BF8B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2D0B2195E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EECF19D896;
	Tue,  9 Jul 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="RcWFOJgf"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952319DF52
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541891; cv=none; b=RN8eRbXyyYr2iUAHBU7CIXbi/bW+lN79qDhV8c1HvRheM0UhptfOE2GMj/heuxGO8H8yNViSxqHBRZfI2vHwjQgvsHdCHcXG/rqqluUuDaSsOQhm8rsgjHn0vKw3HmEhuZ3KdEoXIbeA+1ZONdNqTY0QONI5FbxtQrNgbIff+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541891; c=relaxed/simple;
	bh=KRYihZR7H2DlQzSpWhmUqRWHFjakI5MdooYGS+5oC4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lBMQC7NoObkWsCs/rgnxwnQVj8/zq+I1S42ihcYBkj7+4fycfnm+3q+xuwEVotNuJTHmGobHjoiid+NIvx/QyivagyaoYwm1vdnOXfMmFpROlyuFSUg2y8Z+VFjQ1EgltTMGzVZqBFxDzGICsQpoGFuzmFxePRgjHQTcs8ofEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=RcWFOJgf; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B3B0E120007;
	Tue,  9 Jul 2024 19:18:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B3B0E120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720541882;
	bh=S9FkQhTEebRMp+SNphzeGH/wOFsrs5/J2sxtT3f3Sgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=RcWFOJgfxhwatsKX20my7xQ/BIyHtk2AbI1B9zErONAMxWytIhX7TLltD9DO4Cuda
	 UT9rNc2M+4jEEX+98Bj6zyhUJ0AHMI8lWCu3sx5v5EZv1ljXgjmjGqz9NtBqN01/Yb
	 Au4lnWLHxC+s7qO6jxSLLAlMK8aKBMGSOF/izNIPs0TrPR9eN0KOW925WOyX0NxO33
	 YLqOdQipLp7fqxQaWh0cxk67AQdh1Sgamj+DUBvSpsLnSTzF3gTDsoEifqch91w08r
	 r3wgIYp525j8Dm2QqpFWz4EhN4adDu1V9SJmBs4M4ONA5LIX2waUPKfJsPUcDv2dFk
	 lWya/1ZnZXKVw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Jul 2024 19:18:02 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jul 2024 19:18:01 +0300
Message-ID: <94ee7fda-68d8-4720-b95c-10783f2e51a5@salutedevices.com>
Date: Tue, 9 Jul 2024 19:18:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] initrd: use O_SYNC flag while opening /dev/ram for
 write
To: Christoph Hellwig <hch@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
References: <20240708200923.1824270-1-gnstark@salutedevices.com>
 <ZozSlCGyKCkj3uUl@infradead.org>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <ZozSlCGyKCkj3uUl@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186396 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 15:25:00 #25923573
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Christoph

Thanks for the review

On 7/9/24 09:03, Christoph Hellwig wrote:
> On Mon, Jul 08, 2024 at 11:09:23PM +0300, George Stark wrote:
>> initrd image is written to the /dev/ram block device using filp_open(),
>> kernel_write()
> 
> First question: why are you using the legacy initrd and not initramfs?

I was playing around with initrd to have ability to mount initrd fs from 
disk after switching to main root and use files from it. We can't mount 
initramfs image. In embedded system mounting vs extracting makes a 
difference due to resource limitations. In the end we dropped that idea
partly because of initrd is marked as deprecated.
But since it has been deprecated since 2020 and it's still there I 
thought may be it was used by someone so this patch was worth publishing.

If initrd really counts its last days then this patch can be thrown away.

> 
>> . After fput() /dev/ram is mounted and may fail due to not
>> all data is actually written to the device yet. The mount error remains
>> hidden due to MS_SILENT flag usage and mount_root_generic has retries.
>> So use O_SYNC flag to have all data written to /dev/ram before mounting.
> 
> O_SYNC is highly inefficient.  If you have a valid reason to care about
> a corner case in the hopefully soon to be remvoved legacy initrd code,
> the right way to do this is a single fdatasync after the writes have
> finished.

Ok.

-- 
Best regards
George

