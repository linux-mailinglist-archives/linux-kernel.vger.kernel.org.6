Return-Path: <linux-kernel+bounces-415878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C079D3D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371042827A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9D1A4F1B;
	Wed, 20 Nov 2024 14:25:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D403AD27
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112700; cv=none; b=o1y0yOACJsFvrFSgG7E7E5n1Yvz6YO77qa1CHX1OBcLnhQ3N/oq2QFNbL8O3tssn7Layd3/ZV6IlRdlI/htSYc7+xmIRA1G3ElIxl/F2g5497EAXv4rQnjmuuWlRADu6lSwKflHOmO3vrszlRxfOiPcj8uiM5GYSxQWykCVs6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112700; c=relaxed/simple;
	bh=Rdgxa+F86EkYm+G3sft1SGuwmE7n0VrEmvTwp74fS68=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Blj05W3ZylrDCLwSgVb011OscssUI8Q2iFDV01s52t3rCzo9y8ZFMDgmxJ4vvTIWwsdyg8O7RtDybezNu0GHUWayiErsjs8Rk+kiQ9h5u2HmGQyRYmiLf8aakSF0VgC7Y2fqGSx3/dOnXqOgzI4xowEBANUnCkSlGMf2z8y0WB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xtk7T0qzJz67mSm;
	Wed, 20 Nov 2024 22:21:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AD8B140AB8;
	Wed, 20 Nov 2024 22:24:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 20 Nov
 2024 15:24:56 +0100
Date: Wed, 20 Nov 2024 14:24:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 14/15] acpi/ghes: Change ghes fill logic to work with
 only one source
Message-ID: <20241120142454.000020f5@huawei.com>
In-Reply-To: <3cf3d0f0253faf8d2497175e8473431d8ef25810.1731406254.git.mchehab+huawei@kernel.org>
References: <cover.1731406254.git.mchehab+huawei@kernel.org>
	<3cf3d0f0253faf8d2497175e8473431d8ef25810.1731406254.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Nov 2024 11:14:58 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Extending to multiple sources require a BIOS pointer to the
> beginning of the HEST table, which in turn requires a backward-compatible
> code.
> 
> So, the current code supports only one source. Ensure that and simplify
> the code.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
One trivial comment.
Otherwise LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---

>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
>      uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
> -    uint64_t start_addr;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
> @@ -418,11 +416,8 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    start_addr = le64_to_cpu(ags->hw_error_le);
> -
> -    start_addr += source_id * sizeof(uint64_t);
> -
> -    get_ghes_offsets(start_addr, &cper_addr, &read_ack_register_addr);
> +    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
> +    get_ghes_offsets(le64_to_cpu(ags->hw_error_le), &cper_addr, &read_ack_register_addr);

Long line. I'd break it.

>  
>      cper_addr = le64_to_cpu(cper_addr);
>      if (!cper_addr) {


