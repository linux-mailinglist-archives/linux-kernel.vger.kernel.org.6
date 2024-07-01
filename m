Return-Path: <linux-kernel+bounces-236669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954D591E595
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51630281F69
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292AB16DEC7;
	Mon,  1 Jul 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N3eHAXGe"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FA16DEB4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852175; cv=none; b=ZjjLKefNltsRX0RlTLpn6hHhyiIMsw/2fZ1ejMySsUnMNWpKoDFCFPPIWpZscL9vW+IU/7i3oOHLY4tDbydLUhMJPfHES/eiWvFEz+CcMhHmGXNBgVu5aH1ai3SF3g1zv1blm85O/S/9z0BVn+NhgAjiv2coC1i5bxr9DXl4Qbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852175; c=relaxed/simple;
	bh=PZPszu38C9qjHBErM1SkImmwDbA/mBUiPyCRRw7EAeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq2HobPKjkJiJEQggVcs9WM74ZWt0fdut4HiXJ2gxGkovsZZJ6xCjQuvrDC+yMeVff0MaYxOan+MoIWdkSv7H/IYHckl1x/1EUqlPqaSLAMKSvx7DhJjHP4zj7NwHIvJMCCUu/jUmLxkfv1vEOlHHi/kajEGaxeZXDr5+NBDWw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N3eHAXGe; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WCX0F3MqjzlnNFn;
	Mon,  1 Jul 2024 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719852172; x=1722444173; bh=88w72/yhcBtkcYIHH4laK8V+
	I9JZOPcRykHIFahc//4=; b=N3eHAXGeds+g5rneafIf9NF7woZLwFdK7OPlk+La
	/MBRSNkV9Ge3K41tvXkkjyDrwsz+y9gxr4XGF/Jxsi2ArgxpslhKUmZiKCOzkkk5
	m7ArEUdPVYxJJ880MjGJQdA5cf6c35Z1hg3Dn1zyKEfFpKnq4XmcpUW/zL6h6MJu
	Sp7MxC9cKuv8v9FOjgl63dJKYBErOvTO7iBtwVe+/2dtkuOZvdgELdJiYsQyFE/q
	Z1eCmy22ft3PH2Z6G2bvu12ooc2rBdr5+SAUunzOb0QMCJXs2Jx3olBfDMwXwUpV
	vwy3YZmvOfFp+qiPxXU09viSSAV0ZG0f9c2ZZeODWyCBxQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id t5zoGWQ9OUPC; Mon,  1 Jul 2024 16:42:52 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WCX0C3tdrzlnNFk;
	Mon,  1 Jul 2024 16:42:51 +0000 (UTC)
Message-ID: <3302014f-6ee0-452a-a6a5-dea6fcc37542@acm.org>
Date: Mon, 1 Jul 2024 09:42:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/53] workqueue: Introduce the create*_workqueue2()
 macros
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Tejun Heo <tj@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-2-bvanassche@acm.org>
 <CAJhGHyCsypVP7VgsNKdQ=rn0hqiJOzSS9p_OGio6k-S2idaLtA@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJhGHyCsypVP7VgsNKdQ=rn0hqiJOzSS9p_OGio6k-S2idaLtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 6/30/24 7:51 PM, Lai Jiangshan wrote:
> On Mon, Jul 1, 2024 at 6:29=E2=80=AFAM Bart Van Assche <bvanassche@acm.=
org> wrote:
>=20
>> --- a/include/linux/workqueue.h
>> +++ b/include/linux/workqueue.h
>> @@ -525,11 +525,20 @@ alloc_workqueue(const char *fmt, unsigned int fl=
ags, int max_active, ...);
>>
>>   #define create_workqueue(name)                                      =
   \
>>          alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name)=
)
>> +#define create_workqueue2(fmt, args...) \
>> +       alloc_workqueue(fmt, __WQ_LEGACY | WQ_MEM_RECLAIM, 1, ##args)
>>   #define create_freezable_workqueue(name)                            =
   \
>>          alloc_workqueue("%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND=
 | \
>>                          WQ_MEM_RECLAIM, 1, (name))
>=20
> Is there any possible preprocessor hack to avoid the renaming of the fu=
nctions?

Thanks Lai for having taken a look. As one can see here the last patch=20
of this patch series renames create_workqueue2() back to=20
create_workqueue():=20
https://lore.kernel.org/linux-kernel/20240630222904.627462-1-bvanassche@a=
cm.org/

Bart.

