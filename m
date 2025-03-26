Return-Path: <linux-kernel+bounces-576440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C5BA70F48
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CFF3B15C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647B1553A3;
	Wed, 26 Mar 2025 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qP53ehZI"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98572AD0B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742958339; cv=none; b=I5vhbfAoullsWP2hRnbud+i9/DvJU690IuQcdDQ3hTTv3nlota9c+s2HgTkwwY1uRtM2mmiqb8aj7SznBV8gYMm4+I9/dmncfixeqNATbZPhAN+Tx3Zo0otvVdOTQbbF/Fo56v33hfQtFT99oKpaulmwXHtYxO2IxKsQOwrfA18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742958339; c=relaxed/simple;
	bh=qfGnk00UTOdb61IzlVzGgmA66I6VQrXLdaqCi2aoOCY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 References; b=isSUPczZSRwE0bg71jg+SbI8DFKqejXqQpAfU86YzHByHqVjNYcqMjclK6Bl558GNitIGbwssDX+NugkAohLZeQopy+mRsGo719ED66FTpMSz1NR5nzkwOdYkfiYutcVR3xp5dUARi4ZXbUnjkenKuCBvum71aWgyc+/uxGzPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qP53ehZI; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250326030528epoutp014af5e1c1eb454640f9105a1ed2bd6373~wO1136jLo0058400584epoutp01J
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:05:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250326030528epoutp014af5e1c1eb454640f9105a1ed2bd6373~wO1136jLo0058400584epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742958328;
	bh=APX04n6zsBcZDPnUWxv6THU0pMXZKE/D5YD7JYCCQVI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=qP53ehZIxWlfTXPNDH38RehB1sDBAtmWBAo32hi1lrRfvlMNZsK/4Ey7GdTvV2qoy
	 bvZlnrcg6LXbPwQYQS8rEau3DxdNJihvb9+C+3/MR9xth0VVqW45IRN6T4JyVlngUx
	 SgyZ/Z6HuK2iIxpJum4zcaXPoFy+DFHIYKBgsj74=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20250326030527epcas2p40aac1642b2d63ef7259a640dab131c27~wO11UlYdD2380523805epcas2p41;
	Wed, 26 Mar 2025 03:05:27 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.70]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZMs9M3Rxjz3hhTF; Wed, 26 Mar
	2025 03:05:27 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.4B.10159.7FE63E76; Wed, 26 Mar 2025 12:05:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250326030527epcas2p33aa30e62cc8a00c9e151c35bee71dac5~wO10kw-tQ2478824788epcas2p3J;
	Wed, 26 Mar 2025 03:05:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250326030527epsmtrp21470307e987050dbbd6f01da71e0cb4d~wO10j7IhP2137921379epsmtrp2N;
	Wed, 26 Mar 2025 03:05:27 +0000 (GMT)
X-AuditID: b6c32a46-9fefd700000027af-be-67e36ef7555e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.A9.07818.6FE63E76; Wed, 26 Mar 2025 12:05:26 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250326030526epsmtip1712fe9d09419ae4beb4a6df3daf60071~wO10Xpbnm1729317293epsmtip1C;
	Wed, 26 Mar 2025 03:05:26 +0000 (GMT)
Date: Wed, 26 Mar 2025 12:09:37 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Saravana Kannan <saravanak@google.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, youngmin.nam@samsung.com, hajun.sung@samsung.com,
	d7271.choe@samsung.com, joonki.min@samsung.com
Subject: [GICv3 ITS]S2IDLE framework does not invoke syscore_ops in GICv3
 ITS driver
Message-ID: <Z+Nv8U/4P3taDpUq@perf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmme73vMfpBjMPS1lc2zuR3aJp/yVm
	i6u73zFb7NguYrHp8TVWi8u75rBZ7JxzktWi69BfNovNm6YyWxxfG27RceQbs8XiA5/YHXg8
	tu3exuqxYFOpx6ZVnWwed67tYfN4d+4cu8fmJfUefVtWMXp83iQXwBGVbZORmpiSWqSQmpec
	n5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKqSQlliTilQKCCxuFhJ386m
	KL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj1fx1LAXTeCrezDjI
	2MC4lrOLkZNDQsBEYvrlX4xdjFwcQgI7GCUuzDzIApIQEvjEKLG0Qwoi8Y1R4s/J/+wwHcc3
	3maHSOwFSqxczAThPGSUOHhlDhNIFYuAqsTxj5NYQWw2AV2JbSf+MYLYIgLuEjcn9bCANDAL
	HGWS6J6xDCwhLBAmcfhpN1gDr4CyxKtzp9khbEGJkzOfgDVICLRySEw808sKcYeLxLd/K5gh
	bGGJV8e3QN0nJfH53V42CLtYouH+LWaI5hZGiVPXX0A1GEvMetYOtplZIEOi4+xNoKEcQHFl
	iSO3WCDCfBIdh/+yQ4R5JTrahCA61SR+TdnACGHLSOxeDHOCh0Tr1xYmSNjFSqxcd4l9AqPs
	LCQvzEKyDMLWkViw+xPbLKANzALSEsv/cUCYmhLrd+kvYGRdxSiWWlCcm55abFRgBI/V5Pzc
	TYzg5KrltoNxytsPeocYmTgYDzFKcDArifAeY32YLsSbklhZlVqUH19UmpNafIjRFBghE5ml
	RJPzgek9ryTe0MTSwMTMzNDcyNTAXEmct3pHS7qQQHpiSWp2ampBahFMHxMHp1QDE+dzufZl
	3hxXE3ftMjhntDBy+5rEykqG7uU5OfILc3uZfAu/1awSLN94hWlB+Y6rs58b5rwUfjQj6O+K
	CpHWs8ENOV8SkstfzO9c8euzTfjcE9vftEjk/Zlu6yi49mT2vcdCapHv0416GkqyNx5/05nM
	/j/JO3zBWd0LZXnyU6x3qEblGB7w+Xg5i3fyH8HWDzLxV3U8A/Q2rDVdYOF17wRTzqyje37f
	atN56mf4NN1k7asrr2tN7vv9KPwiXakltdNn9Ttb49vhR49kHv9/68tmEduM5+m/5bcePeuz
	PryJo9HEy8WMy7X+E4P/J7a2fM9jkdE7PEwm109atN/DYuNn/8Vv5k7KmRL6+svECCWW4oxE
	Qy3mouJEAIcdqNE3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnO63vMfpBu2PLCyu7Z3IbtG0/xKz
	xdXd75gtdmwXsdj0+BqrxeVdc9gsds45yWrRdegvm8XmTVOZLY6vDbfoOPKN2WLxgU/sDjwe
	23ZvY/VYsKnUY9OqTjaPO9f2sHm8O3eO3WPzknqPvi2rGD0+b5IL4IjisklJzcksSy3St0vg
	yjjRpllwjbPi4IdtbA2MbexdjJwcEgImEsc33gayuTiEBHYzSrTM3AmVkJG4vfIyK4QtLHG/
	5QiYLSRwn1Hi6FImEJtFQFXi+MdJYHE2AV2JbSf+MYLYIgLuEjcn9bCADGUWOMkk0b/uNViD
	sECYxIe9rWALeAWUJV6dOw1lC0qcnPmEBcRmFtCSuPHvJVA9B5AtLbH8H8cERr5ZSKpmIama
	hVC1gJF5FaNkakFxbnpusmGBYV5quV5xYm5xaV66XnJ+7iZGcARoaexgfPetSf8QIxMH4yFG
	CQ5mJRHeY6wP04V4UxIrq1KL8uOLSnNSiw8xSnOwKInzrjSMSBcSSE8sSc1OTS1ILYLJMnFw
	SjUwhf93uvWPO6J+7X9OUT5mtyYzDbsp87OUlKbIb+k7c7emsc6jcHnPdGOHyYV3G8rrvGp2
	FqZsXmSn0l/jOV3D/d72JMfcwpOF0YeMHeLKV7f7To4TLF2wj6d1ivW17ay79R7NXfxqucAC
	Aav8ZrsdO43ETlZPLFsT8vNe6LHdX4tWNK3/89zqxL1a6aend9qz9y/MneZ5817gtZvd0/3u
	hjxwPh0tc/bA8YMTLq/RX6cQMP2x44O1M7NW/BfPOmD14uETK/NUDYfHv+9Zub1w0d16N51D
	Qmujsf9d0Q96ov6/7xxOqDqtcUJDXKj9LYPklTud9rXx+7Lkwp0VnK93lTBL1XI+PuvAu6Tz
	fLCREktxRqKhFnNRcSIAup/NAO8CAAA=
X-CMS-MailID: 20250326030527epcas2p33aa30e62cc8a00c9e151c35bee71dac5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----ieZh69edyBxzv2Y5Ggo8207PwRbI2z7mQ5FWfU8PsFoZKj2n=_25c35_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250326030527epcas2p33aa30e62cc8a00c9e151c35bee71dac5
References: <CGME20250326030527epcas2p33aa30e62cc8a00c9e151c35bee71dac5@epcas2p3.samsung.com>

------ieZh69edyBxzv2Y5Ggo8207PwRbI2z7mQ5FWfU8PsFoZKj2n=_25c35_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi.

On our SoC, we are using S2IDLE instead of S2R as a system suspend mode.
However, when I try to enable ARM GICv3 ITS driver (drivers/irqchip/irq-gic-v3-its.c),
I noticed that there is no proper way to invoke suspend/resume callback,
because it only uses syscore_ops, which is not called in an s2idle scenario.
Please refer to the codes below.

<drivers/irqchip/irq-gic-v3-its.c>
5028 static struct syscore_ops its_syscore_ops = {
5029         .suspend = its_save_disable,
5030         .resume = its_restore_enable,
5031 };
...
5803         register_syscore_ops(&its_syscore_ops);

<kernel/power/suspend.c>
444         if (state == PM_SUSPEND_TO_IDLE) {
445                 s2idle_loop();
446                 goto Platform_wake;
447         }
448
449         error = pm_sleep_disable_secondary_cpus();
450         if (error || suspend_test(TEST_CPUS)) {
451                 log_suspend_abort_reason("Disabling non-boot cpus failed");
452                 goto Enable_cpus;
453         }
454
455         arch_suspend_disable_irqs();
456         BUG_ON(!irqs_disabled());
457
458         system_state = SYSTEM_SUSPEND;
459
460         error = syscore_suspend();

How should we handle this situation ?

------ieZh69edyBxzv2Y5Ggo8207PwRbI2z7mQ5FWfU8PsFoZKj2n=_25c35_
Content-Type: text/plain; charset="utf-8"


------ieZh69edyBxzv2Y5Ggo8207PwRbI2z7mQ5FWfU8PsFoZKj2n=_25c35_--

