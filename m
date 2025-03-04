Return-Path: <linux-kernel+bounces-543741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EEBA4D93B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59408172314
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9A41FCF57;
	Tue,  4 Mar 2025 09:49:39 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C21FC0F9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081778; cv=none; b=Wk+kS/NbOpco9BTrjOAaYkbfl6gWKCTmTO/F180O0SUjyroSk/eMbsraYC18bqPpr6Ydm94KErKS9KJw9hT2ZJh4mA4og5FhJM6furHyLOlHrq3QarhvGmSjhoZtXJERGhTLwNtk7ETPQo07xYk50miuoseCoua+e1k5vm23rzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081778; c=relaxed/simple;
	bh=gfx1xrKRf1ejbzHzB5qS0vdi+BPXu+3ettzO76yT+Uc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPszoqVctElg7NJ7Yngyfrnj2Y8p92gEv7TDvrGp0Jp+LDohlxkeApmfc0CO9MzUIJQUpwxBCYxgrwom42cg+fnj8R/Z0aMe1TPAQNtzl3kPYeyGiGUA2riQAdW/Y75BZSS78f6VuHPXHG3CBrhZR9oJNdct+ZmtTSdN6R/lKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6W7F0Vl1z6D90N;
	Tue,  4 Mar 2025 17:47:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 01C8F140A08;
	Tue,  4 Mar 2025 17:49:33 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 10:49:24 +0100
Date: Tue, 4 Mar 2025 17:49:19 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Will Deacon <will@kernel.org>
CC: Yicong Yang <yangyicong@huawei.com>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH 4/9] drivers/perf: hisi: Use ACPI driver_data to
 retrieve SLLC PMU information
Message-ID: <20250304174919.00001e24@huawei.com>
In-Reply-To: <20250301064347.GB27700@willie-the-truck>
References: <20250218092000.41641-1-yangyicong@huawei.com>
	<20250218092000.41641-5-yangyicong@huawei.com>
	<20250301064347.GB27700@willie-the-truck>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 1 Mar 2025 06:43:49 +0000
Will Deacon <will@kernel.org> wrote:

> On Tue, Feb 18, 2025 at 05:19:55PM +0800, Yicong Yang wrote:
> > From: Junhao He <hejunhao3@huawei.com>
> > 
> > Make use of struct acpi_device_id::driver_data for version specific
> > information rather than judge the version register. This will help
> > to simplify the probe process and also a bit easier for extension.
> > 
> > Factor out SLLC register definition to struct hisi_sllc_pmu_regs.
> > No functional changes intended.
> > 
> > Signed-off-by: Junhao He <hejunhao3@huawei.com>
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 191 ++++++++++++------
> >  1 file changed, 125 insertions(+), 66 deletions(-)
> > 
> > diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> > index dbd079016fc4..c1fd60d397c3 100644
> > --- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> > +++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> > @@ -36,11 +36,14 @@
> >  #define SLLC_SRCID_NONE			0x0
> >  #define SLLC_TGTID_EN			BIT(5)
> >  #define SLLC_TGTID_NONE			0x0
> > -#define SLLC_TGTID_MIN_SHIFT		1
> > -#define SLLC_TGTID_MAX_SHIFT		12
> > -#define SLLC_SRCID_CMD_SHIFT		1
> > -#define SLLC_SRCID_MSK_SHIFT		12
> > +#define SLLC_TGTID_MIN_MSK		GENMASK(11, 1)
> > +#define SLLC_TGTID_MAX_MSK		GENMASK(22, 12)
> > +#define SLLC_SRCID_CMD_MSK		GENMASK(11, 1)
> > +#define SLLC_SRCID_MSK_MSK		GENMASK(22, 12)
> >  #define SLLC_NR_EVENTS			0x80
> > +#define SLLC_EVENT_CNTn(cnt0, n)	((cnt0) + (n) * 8)
> > +#define SLLC_FIRST_BIT(_mask)		(find_first_bit((const unsigned long *)&(_mask), 32))
> > +#define SLLC_FIELD_PREP(_mask, _val)	(_mask & (_val << SLLC_FIRST_BIT(_mask)))  
> 
> It's a bit of a shame to have to compute this dynamically given that th
> input mask is constant for a given device. Is it not possible to use the
> generic FIELD_PREP macro in per-device code and then just dispatch to
> that, instead of funneling everything through hisi_sllc_pmu_regs?
There is yet another ongoing discussion of handling non const
field cases:
https://lore.kernel.org/all/cover.1739540679.git.geert+renesas@glider.be/

Maybe that will resolve with a nicer solution but I doubt it.

Alternatively best plan may be a shift (and length) instead
of the neat solution of FIELD_PREP().

Jonathan

> 
> Will


