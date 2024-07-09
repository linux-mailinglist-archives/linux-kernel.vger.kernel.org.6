Return-Path: <linux-kernel+bounces-245317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C092B11F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49D1B211A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC8613BC30;
	Tue,  9 Jul 2024 07:32:36 +0000 (UTC)
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0E12D1ED
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510356; cv=none; b=KVvyGdJecRQyLjcH0S8esTInnd+WaQc0c6kSvTiGzGNgEWbkXWLv1jeZXjNVmTzKT6sIOIjBoeSxmv1F9xmIECEaSJFJgScML3KArPAJu16ib3ER750sBRudiyHOrdqjf2+R5ZsjDUhnnkhO8DZ56WW7fvUaWJJm7x/GJI08R2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510356; c=relaxed/simple;
	bh=OHhTp9SYcGiRgUUPFJuWXDnJplt3N46Qx57qTxu2c20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJCChAnCSy9To2V5V3Zn4csRWWF8u0xXug1LpSlAGfUSOkSdvK1srYJCg33nPtnEqFxr0AvyGmRkxNorEoai2Wsi5vOH06aeoTlQbW2V3JTOoJ1Hp34xucUHxMsyvHLzx887v/22x14d5wMhcnplCHbT1T7dDLA4gYdp8NzEZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 732C52055FA3;
	Tue,  9 Jul 2024 16:32:32 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-5) with ESMTPS id 4697WV7C152247
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 16:32:32 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-5) with ESMTPS id 4697WVcC883886
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 16:32:31 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4697WUbR883885;
	Tue, 9 Jul 2024 16:32:30 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: "Sungjong Seo" <sj1557.seo@samsung.com>
Cc: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fat: print s_dev via fat_msg
In-Reply-To: <000001dad1ca$6b61c720$42255560$@samsung.com> (Sungjong Seo's
	message of "Tue, 9 Jul 2024 15:37:07 +0900")
References: <CGME20240709041754epcas1p4ee6f7b1fd0dbf287e756b709aba321c8@epcas1p4.samsung.com>
	<20240709041734.3719513-1-sj1557.seo@samsung.com>
	<87frsjt9i2.fsf@mail.parknet.co.jp>
	<000001dad1ca$6b61c720$42255560$@samsung.com>
Date: Tue, 09 Jul 2024 16:32:30 +0900
Message-ID: <87bk37t3zl.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sungjong Seo" <sj1557.seo@samsung.com> writes:

>> Sungjong Seo <sj1557.seo@samsung.com> writes:
>> 
>> > To clarify MAJOR/MINOR number of a mounted device, fat_msg prints prefix
>> > that includes them.
>> 
>> Hm, why do we need the major/minor (why can't use sysfs to resolve if
>> need), and why do you care only fat?
>> Thanks.
> You're right, if you can access to sysfs on a system, this might not
> be useful. However, when analyzing problems based on logs, s_dev can be
> very helpful for identifying devices. This is because, in systems like
> Android, a filesystem gets mounted on a device node with a nickname
> like public:179,1.
>
> I think it would be really useful if applied to representative filesystems
> for removable storage devices such as fat and exfat. So I will send the
> similar PR to exfat as well.

So this is for the naming policy like android? And why don't you care
the other places (like vfs) that using ->s_id?

Because I dislike to use the inconsitent stuff, some logs are "sda3" and
some logs are "sda3[8:3]".

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

