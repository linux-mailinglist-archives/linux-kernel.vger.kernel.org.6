Return-Path: <linux-kernel+bounces-250118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A19092F46F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF21281845
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763ADFC08;
	Fri, 12 Jul 2024 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9/M9j8v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C15ADDBE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720755355; cv=none; b=FCyKLdIz5FJR4Z7jlYEI5DyfwRvL+FzSRbiJaF+5LtrGmfTh9lvb14xnKNogWPDSA+Ne9xcSQvXruaduak0qrX9TZ8SLzuvEWOaphNzCIW/+OOrT53208flzs86Z0dGyUZIJbbdV3jvFpNATOQWVwlbJ5knzTKeGoMaCR++LghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720755355; c=relaxed/simple;
	bh=asqcc/DV1ydfjIVReNBt3MmE1PNlxZwsAwwC0xcyoqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM84hjtzn0yMaJAaZpF1LhyvfLa80KoUA/s+j7FArtFqidh9rWG9owqisgHIx9ISePJvOyxmtSXNOrHu2L7xdmfMoZ7osO+vUDOeL1i3bIT3KxaWgJTTFYTREcORWG7CcDXt1lWQ3budqKMTEP4oJwY8cyHRrw0PcXuPkFMr9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9/M9j8v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720755352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRr3QUNCpj/Aou9SrxNeZFSuT8KL7rq81lYCD8rqbec=;
	b=h9/M9j8vu/fvD5pCvNNTY3l3SMXMhbBQjzC0MtKv7mpdU/A3rSQoEo4U3RDvnyTw5ogko3
	zNDHYsGuqc4Wq1ZfwzDK7gcJWlLWj0EqFb4QDFb6u8QPrl/sDLZiwBVmmhPSs/hmM690aT
	DLfef8JnW6od3Rr8GLl8ylcQDUPX8e8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-WIx0JwRjMCGLVoXRXgf46w-1; Thu,
 11 Jul 2024 23:35:49 -0400
X-MC-Unique: WIx0JwRjMCGLVoXRXgf46w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51A2C1956080;
	Fri, 12 Jul 2024 03:35:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 394113000181;
	Fri, 12 Jul 2024 03:35:44 +0000 (UTC)
Date: Fri, 12 Jul 2024 11:35:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Petr Tesarik <petr.tesarik@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Petr Tesarik <petr@tesarici.cz>,
	Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
Message-ID: <ZpCkjN1iLsZTu4Ug@MiWiFi-R3L-srv>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711103409.319673-1-petr.tesarik@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/11/24 at 12:34pm, Petr Tesarik wrote:
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

Agree. I guess this was copied from codes related to 
crash_notes/crash_notes_size. While crash_notes/crash_notes_size are in
/sys/devices/system/cpu/cpuX/ which is next level. 

Acked-by: Baoquan He <bhe@redhat.com>


