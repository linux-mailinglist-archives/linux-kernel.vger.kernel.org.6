Return-Path: <linux-kernel+bounces-253507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D99932240
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199FE2816C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4AE195B3B;
	Tue, 16 Jul 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BuXW/mJ2"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE941A8E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119906; cv=none; b=qVJS0TkhiZckOhD2gl2CmcLdzBlAO8QKOLFVv12k8xGzaA/5+D8W2/LZHbbVfGb9RqDJv9osjqIhjM9Y0vyshNPYvBT1ZfIFSvKIpPGFt0RVdb/2IUNp+1NN+pPApCrh92FG9ac564oi2dSPCrAUOj8YmOJV5Oy9bnX0lsXCcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119906; c=relaxed/simple;
	bh=gklqEpVrs+TZShP9WfTzy8DW0cD3vHWXH1OsfT2l4YI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OY+uliz3kv+rrzsbrnZmx/1JxIaL3Gq2B2cbO/8q+aJEYxtZDK5ApC9/Y/v2slGZvHCrI1180i3UEf/rHj2bfhOf0NQyLniKixJP8oBJyrX9ua/66RO//tHSuI0wPvD7QGDKgEVAFiiQzzA4mVEmN2tp7jP4JPA9rsQPFonedM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BuXW/mJ2; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12C1A240002;
	Tue, 16 Jul 2024 08:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721119897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXaYVi8PKUd4UGTeifDJUjRKE3ggu6+D+9ulPq2RYdo=;
	b=BuXW/mJ2pxR+kPWm7hqkpNl0J6Db6BcmNn+armiDlYn6BdJC37o5V1yA/BpXNtRtfg4eKS
	VZi8yOesX38v5w7Rfi485niCLIWp9oKdCh3VVxxzRo9yzybEqXQp7zPhdFdtT2RzpmDIqJ
	LFMq8ln+yMqOb1TR/x/P1n0oBoWJmXHSg6SnG5ZWQ+j3OE9XYEhSF99V0CFxgT18tuw07u
	v/fMiJ3H5y4mJvy/XtjP7UlCq43gg4UuiL0U7GMRLlIDkfoGWIw855EDmZoL7M9CTy1gq6
	oKujF58lFyu5vXCKJjbLmSAYWQ2Mj1KSMKylCrv1M+ucWVoQfcP//NDFlcsQxw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Ben Schneider <ben@bens.haus>, Andrew Lunn <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>, Linux Arm Kernel
 <linux-arm-kernel@lists.infradead.org>, Linux Kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
In-Reply-To: <O1XjBTq--3-9@bens.haus>
References: <20240603012804.122215-1-ben@bens.haus>
 <20240603012804.122215-2-ben@bens.haus>
 <20240605194422.klxtxgyljrrllkzy@pali>
 <dce98e50-6b50-4d4e-abe2-8419a675d25e@lunn.ch> <O1XjBTq--3-9@bens.haus>
Date: Tue, 16 Jul 2024 10:51:36 +0200
Message-ID: <87ed7tlnxj.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Hello Ben,

> Jun 5, 2024, 16:44 by andrew@lunn.ch:
>
>> On Wed, Jun 05, 2024 at 09:44:22PM +0200, Pali Roh=C3=A1r wrote:
>>
>>> So, go ahead with this change with my
>>>
>>> Reviewed-by: Pali Roh=C3=A1r <pali@kernel.org>
>>>
>>
>> I defer to your knowledge in this matter.
>>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>
>>  Andrew
>>
>
> Hi all, just checking in to see if there are any outstanding
> concerns/issues outstanding with this patch? I am happy to report
> several more weeks of stability on two A3720 devices. Thanks!
>

You received two "reviewed-by" approvals, and Marek Beh=C3=BAn, who wrote t=
he
patch removing the 1.2GHz limitation, did not object. Therefore, from my
point of view, there is no problem merging your change.

As the original author of this driver, you can add my "Acked-by" to your
patch if it can help:

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Gregory


> Ben

