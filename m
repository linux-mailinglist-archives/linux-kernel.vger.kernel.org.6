Return-Path: <linux-kernel+bounces-217773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3990B6B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D80B2F100
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C7516191E;
	Mon, 17 Jun 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RHwZULEW"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03753160883;
	Mon, 17 Jun 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635765; cv=none; b=ZStYUjI42rLc0B2jd5GbV6pNDxkoicfGX2W7xdEbuNqwR3ETB7ogm0T8gxcFmbf9IWnMybq8Wh4PCM6LS7Aw7wWIAOAXrSAmMy9u5Q4316U5FALYnG29tm8aKr5nlmrSZ5FIz3i0zHx1U3Bjv41NON7r1jis+VrKJJ8xXmusqfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635765; c=relaxed/simple;
	bh=Vx60TwCd5DvU3lW+N0yTg5OEPPielolK61OlocuXBGM=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=KpZ80ViyrUiqc+I9ViAX7TnvwKoDJlk3ecUBE+UtnNWy5IOfdvfTJGVUjSA5PyB7gAnkrysKGwV5fiGlhomfOUcZmKYbivPvdWr1cm/5NdgXSD8A5Qwtqh6yM1cmiBA9D39wB3P7FNT7Btp2u3oMlyVPw+cSA5AuQxzyFGB1TNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RHwZULEW; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H6pj0S020277;
	Mon, 17 Jun 2024 09:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=NU2i88E3x+E9mAi+Ds4+RUAASBPO7aAk4fdksz4mITk=; b=
	RHwZULEWMZIH6vSoc1uH36iciq/A3dwUd7xlIBHnqoUGU+mp6VpdFWyc0lPMqKZi
	qkJK8X0dOUq/9f8SujzWSlhFGsnZ1TGFIvJt0U6DHHjKhOV7Zbt47TrotFJ7701x
	oGMbebivDuc1GF+YTx2oeVyJ9FOHgqEuXzBi9BoTDi2P58DQNVS6JjN8Al76kOUG
	or9jmSk+235z6mX03jaqPmeQ/0pnxwJThsPK8pWs/R8Awf9QuOuCYlwhr6ihAYHQ
	COU8D9uTlfvxrRMac0tmV/vsPQv0efiFbpN689UuCYpnjKGKpFrQ/E5zkMZOv3fJ
	MxylHEGHeBZIVzIKy8IT4w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ys7cjsxjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:48:53 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 15:48:51 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 17 Jun 2024 15:48:51 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.31])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 593AC820248;
	Mon, 17 Jun 2024 14:48:51 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Richard Fitzgerald' <rf@opensource.cirrus.com>,
        'Mark Brown'
	<broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240617135338.82006-1-simont@opensource.cirrus.com> <917507e5-dc6c-4e18-a7e1-554625de604e@sirena.org.uk> <3451fcf6-ff33-4f72-83d1-945b026b925b@opensource.cirrus.com>
In-Reply-To: <3451fcf6-ff33-4f72-83d1-945b026b925b@opensource.cirrus.com>
Subject: RE: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ numbers
Date: Mon, 17 Jun 2024 15:48:51 +0100
Message-ID: <007b01dac0c5$7807ac30$68170490$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQLJlotUhHos9A3t9Z11wTi0/o5GmwIOUdMXAdn00ZqvzxnqoA==
X-Proofpoint-GUID: ImJAUvX1q-czcllldZxnSVyIKYNGOdFR
X-Proofpoint-ORIG-GUID: ImJAUvX1q-czcllldZxnSVyIKYNGOdFR
X-Proofpoint-Spam-Reason: safe

> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> Sent: Monday, June 17, 2024 3:34 PM
> On 17/06/2024 15:04, Mark Brown wrote:
> > On Mon, Jun 17, 2024 at 02:53:38PM +0100, Simon Trimmer wrote:
> >> IRQ lookup functions such as those in ACPI can return error values when
> >> an IRQ is not defined. The i2c core driver converts the error codes to
a
> >> value of 0 and the SPI bus driver passes them unaltered to client
device
> >> drivers.
> >>
> >> The cs35l56 driver should only accept positive non-zero values as IRQ
> >> numbers.
> >
> > Have all architectures removed 0 as a valid IRQ?
> 
>  From discussion threads we can find 0 might still used on x86 for a
> legacy device.
> But the conversations we can find on this don't seem to exclude passing
> a negative error number, just that 0 can normally be assumed invalid.
> 
> The kerneldoc for SPI says:
> 
>   * @irq: Negative, or the number passed to request_irq() to receive
>   *	interrupts from this device.

Yes and the threads of these lore links in these commits are rather feisty

ce753ad1549c platform: finally disallow IRQ0 in platform_get_irq() and its
ilk
a85a6c86c25b driver core: platform: Clarify that IRQ 0 is invalid



