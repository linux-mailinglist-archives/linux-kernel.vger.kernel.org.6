Return-Path: <linux-kernel+bounces-277662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893D694A464
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433E62815D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1525A1CCB2A;
	Wed,  7 Aug 2024 09:34:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4B1C9DD1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023288; cv=none; b=ldFdYPQpBuaTkk4CsWIUrGiu1SQZE6DXf77C/NFPTgT7sdhGkbyStKUIyfqUs6bVnIal4J6XxKofYbERT9mKjeoa555d4/gcB+F9MPnwfJruqNk1JScH1zYbhGIbzEt/zYth/oWZ7hszvne5yQCINwkM7q5n6xtg3WPfNG8KExc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023288; c=relaxed/simple;
	bh=QaM457Vo8MRAqjQK4zcNBFVOASe58GTfQTmvnJjeBY4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRydQSKzXqcXWQbRH3YtMmR5jX0g4APSWmUgyBwIGwol/ErKlZx10cOtOhnYPs2F9XpF4TxxipC8IFSa93YcPv4UX0xxWq6XTy6b88FnEYB0UYfb5lGom+ew7BEQAFQm0bZs8QSU8V9JqYWXULhCU8Nll6TdavsuaAjFjM7Uwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wf4hM1YxKz6K9Hq;
	Wed,  7 Aug 2024 17:32:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C8B8E140A87;
	Wed,  7 Aug 2024 17:34:37 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 Aug
 2024 10:34:37 +0100
Date: Wed, 7 Aug 2024 10:34:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807103436.000013fc@Huawei.com>
In-Reply-To: <20240807094750.6414fb2f@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
	<20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
	<20240807094750.6414fb2f@foz.lan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 7 Aug 2024 09:47:50 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 6 Aug 2024 16:31:13 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > PS:
> > looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
> > and it is the total size of a error block for a error source.
> > 
> > However acpi_hest_ghes.rst (3) says it should be 4K,
> > am I mistaken?  
> 
> Maybe Jonathan knows better, but I guess the 1K was just some
> arbitrary limit to prevent a too big CPER. The 4K limit described
> at acpi_hest_ghes.rst could be just some limit to cope with
> the current bios implementation, but I didn't check myself how
> this is implemented there. 
> 
> I was unable to find any limit at the specs. Yet, if you look at:
> 
> https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section

I think both limits are just made up.  You can in theory log huge
error records.  Just not one does.

> 
> The processor Error Information Structure, starting at offset
> 40, can go up to 255*32, meaning an offset of 8200, which is
> bigger than 4K.
> 
> Going further, processor context can have up to 65535 (spec
> actually says 65536, but that sounds a typo, as the size is
> stored on an uint16_t), containing multiple register values
> there (the spec calls its length as "P").
> 
> So, the CPER record could, in theory, have:
> 	8200 + (65535 * P) + sizeof(vendor-specicific-info)
> 
> The CPER length is stored in Section Length record, which is
> uint32_t.
> 
> So, I'd say that the GHES record can theoretically be a lot
> bigger than 4K.	
Agreed - but I don't think we care for testing as long as it's
big enough for plausible records.   Unless you really want
to fuzz the limits?

Jonathan

> 
> Thanks,
> Mauro


