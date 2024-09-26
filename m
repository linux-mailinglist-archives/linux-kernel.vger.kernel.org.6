Return-Path: <linux-kernel+bounces-340428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F2987345
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5791C22654
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52D1714D9;
	Thu, 26 Sep 2024 12:09:15 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE0216DEDF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352555; cv=none; b=tXBHRtoRF8SFe/zYDv1fmAm7yqo6DQqGI1AmvWilyZ2bbY4M/rHD4kNUFVGYvi1i1BdZh3r6z1LQeXy+XQ4+iV3WOjgn+x+Y2864/jHjsQUaQgYVEDb8kEDYWK3XVN+kJ/ZlOnX0m+qgWa2ZgPXeUgOIWHgDwPDP8nrPOn0ggpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352555; c=relaxed/simple;
	bh=Y+NCjuqiiHimuCgBNQCCYkDtQs9asC7+ph3I9KV12zo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdqLH+0Q7jZZh1PscZIauATdo+b/jeuQk7DBaGLbEp6kBc3c0ehWmn89M6OnPrA5LlTjA1ne8bCTxUnV/v+BVW67kr6ffQuNO+o5GrwughJVZAURmmO2B9ts6/83nRTefXKvno62GqTFBORykFOcotV2RAd0KEASsBDwi++Wst0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDsnc3Rrhz6J6dn;
	Thu, 26 Sep 2024 20:08:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 881B7140C98;
	Thu, 26 Sep 2024 20:09:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 14:09:10 +0200
Date: Thu, 26 Sep 2024 13:09:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 12/15] acpi/ghes: don't crash QEMU if ghes GED is not
 found
Message-ID: <20240926130909.00006135@Huawei.com>
In-Reply-To: <dc61673f18e44b0c169762a084b77acb6a76c738.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<dc61673f18e44b0c169762a084b77acb6a76c738.1727236561.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 25 Sep 2024 06:04:17 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Instead, produce an error and continue working
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Make sense as defense in depth. Can we actually hit this for existing
systems, or is the injection stuff disabled if the ged isn't configured?

Jonathan

> ---
>  hw/acpi/ghes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 3af1cd16d4d7..209095f67e9a 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -418,7 +418,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>  
>      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>                                                         NULL));
> -    g_assert(acpi_ged_state);
> +    if (!acpi_ged_state) {
> +        error_setg(errp, "Can't find ACPI_GED object");
> +        return;
> +    }
>      ags = &acpi_ged_state->ghes_state;
>  
>      get_ghes_offsets(le64_to_cpu(ags->ghes_addr_le),


