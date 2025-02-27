Return-Path: <linux-kernel+bounces-536163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C9A47C41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9C116452D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E422B8CE;
	Thu, 27 Feb 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0xJdobA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB384226863
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655925; cv=none; b=VBxch6Z+yMMODSPlw+pSW/stPthREB+5z2CE6saTuc4Q5xa6fsrGBSypGoZhSW0H1zXwZLrC/tjMvQdYfZsprGHqHvwSchoDkyXpizmc21lgppc+XwmhftWq6T9N30xWkfYPRYYONw6exo0uw2Dz/yar2ocjcchJVTYCAsl3HAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655925; c=relaxed/simple;
	bh=4pQJjF/Q4Q3WBRwJ6HQNWdlWY6WeeaYy/8fF3m2MQs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAr1jQiHK4DKHyvx8f1oHG7OR/T+3ZskTFBVRyIwOcLlzCmEHVd57r5BLbmK2n8eweVZxygfWK/T8jYUI6ioV/rREeweOUREAG9fF+Jzwl/ATQI6xebkYCQ38wSMRZYYcajVWVISFisTThzhvIcwiDVXJH6gHYN7nYIEIp5zBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0xJdobA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EEAC4CEE4;
	Thu, 27 Feb 2025 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740655924;
	bh=4pQJjF/Q4Q3WBRwJ6HQNWdlWY6WeeaYy/8fF3m2MQs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b0xJdobA/gWddOf5S4ioanDDgZe0aVgoVbbx1BL7i1rGeCzvnUTTbp6HSFUxLFcz8
	 zjhUDNlnIAHpVBAJey2QdC9/aH3Hlc4LwvfeqAOQOavUbFwxgzlCupE6T7PduKk5N1
	 ysUy6opDNfIzKwL4cpFd7VBmS2JRh0Mov83pfW2FGn7DeuRVd7mu5tB+6BQVhstCbh
	 Q9qeWKYagE/DxGHsENEzU6kCfPaVc1HZtiGc3+m3Mh6JIDc41w18yasE7YZWNiAr2A
	 5s6S74eP3FvYEajG7jO69Di0B5+ooeKvNgeX6+aYDVNOwzjThv4LSC+woAFD9Yu8g6
	 aaiw2kKp1giuQ==
Date: Thu, 27 Feb 2025 12:31:59 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani
 Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/21] acpi/ghes: create an ancillary
 acpi_ghes_get_state() function
Message-ID: <20250227123159.46cf9b72@foz.lan>
In-Reply-To: <a84cb4567f087231991ce05980d2f331b772dab5.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<a84cb4567f087231991ce05980d2f331b772dab5.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 27 Feb 2025 12:03:40 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Instead of having a function to check if ACPI is enabled
> (acpi_ghes_present), change its logic to be more generic,
> returing a pointed to AcpiGhesState.
> 
> Such change allows cleanup the ghes GED state code, avoiding
> to read it multiple times, and simplifying the code.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by:  Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index c3a64adfe5ed..0135ac844bcf 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -608,7 +608,7 @@ AcpiGhesState *acpi_ghes_get_state(void)
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    if (!ags->hw_error_le) {
> +    if (!ags->hw_error_le && !ags->hest_addr_le) {
>          return NULL;
>      }
>      return ags;

Sorry, I moved most of the stuff on this patch to 
	[PATCH 04/21] acpi/ghes: Cleanup the code which gets ghes ged state

This hunk was a left over from it. I was meant to place this hunk
elsewhere but I ended forgetting while waiting for the rebase bisect
tests to pass.

 I'll move this hunk to
	[PATCH 06/21] acpi/ghes: add a firmware file with HEST address

for the next respin (and hopefully the final one).

Regards,
Mauro

