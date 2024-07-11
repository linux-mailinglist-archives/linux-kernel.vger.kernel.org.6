Return-Path: <linux-kernel+bounces-249595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF3192EDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC659B20D74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093416D9C1;
	Thu, 11 Jul 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="MqCEzQVg"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E915ECCA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718713; cv=none; b=hDlE8n7N62FImLy3qo9mypO/TctrApjQH3PyqICGU3aSVenpghhS0iTSe8nsiMsW87xtAa546flPg91jyO8m2cDflNZeASYJ6jyTeGPRO2JTrJ2oPnfJ0a4hqfMCWLTbXVDjkKTIxQI+L0lc3fel+qpG/6GkUXtuUZ5obF3lfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718713; c=relaxed/simple;
	bh=VJt+nBLr/FGnSDlQNSFweDMrWyhwvKh50jth40/HlLQ=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUVZrVWcfstGmim4kD8MjxCG/fGhRlLdOSEZU07/wKZa5At0xx0RxRsjw/FVHhFGuIE8+Apua+XX3j2SXLFYRV1UtwIQJ6KcBI/W3K+2kD+op+URXXeL3gg7oBENI7gAXnXHEOCkSsEPDS4MTp8EL8qqdxzs9obk1Ojo2gNC/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=MqCEzQVg; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 0DB041E2566;
	Thu, 11 Jul 2024 19:25:07 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1720718707; bh=opUZKth04MCmXdZHYRgcCgzPDGwTyJQH2sR/7o05GAg=;
	h=Date:From:Cc:Subject:In-Reply-To:References:From;
	b=MqCEzQVgQcCxDeeCGwG1wAKtFq4UhG9vPLXz3CUrNFdt5fXGJ070oGtOsQ3HXMyx9
	 /bb54U8R3KNlx9YBvpY6c7X6RhRgmKTAxK32j38CojZjsSi7nL4jlVqDstm8dX7NkP
	 EDvUGZ+ssjmWgNrN81oyatA1yoRUJ9H3Bh5xommojTx1p8lZ+/uOCgb6VkJhCBhL9R
	 RbrFYCRgyQ9dmtHaaXhbMjrnFPa92azQ+aVL/tnhPtWfZwBXdifYca/g1UCb7O3anX
	 7iRGy8m0dOdWPz/NIOkGUG/7/mxktslFKf4N5pvck79FNk/DRiIr9IXrmXJcplOEW+
	 jV6cz5UHVL0Gw==
Date: Thu, 11 Jul 2024 19:25:06 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Petr Tesarik
 <ptesarik@suse.com>, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
Message-ID: <20240711192506.266cfbbe@meshulam.tesarici.cz>
In-Reply-To: <20240711103409.319673-1-petr.tesarik@suse.com>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Forgot to Cc Sourabh Jain.

On Thu, 11 Jul 2024 12:34:09 +0200
Petr Tesarik <petr.tesarik@suse.com> wrote:

> From: Petr Tesarik <ptesarik@suse.com>
> 
> There is no reason to restrict access to this attribute, as it merely
> reports whether crash elfcorehdr is automatically updated on CPU hot
> plug/unplug and/or online/offline events.
> 
> Note that since commit 79365026f8694 ("crash: add a new kexec flag for
> hotplug support"), this maps to the same flag which is world-accessible
> through /sys/devices/system/memory/crash_hotplug.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  drivers/base/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index c61ecb0c2ae2..73d69791d0d3 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -308,7 +308,7 @@ static ssize_t crash_hotplug_show(struct device *dev,
>  {
>  	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
>  }
> -static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
> +static DEVICE_ATTR_RO(crash_hotplug);
>  #endif
>  
>  static void cpu_device_release(struct device *dev)


