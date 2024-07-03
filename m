Return-Path: <linux-kernel+bounces-239374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2CF925DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257B51F2450E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D318F2EC;
	Wed,  3 Jul 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PT3aq5fO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8C17A5A5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005863; cv=none; b=kxX84IXakbVQvm0rnVs/G8qUlDoMs++0jFvmqvr57X/KAluluGyFmDun0cyvnHHCfhHlVAY9n9jCujvR02Ew626E3WRyd9lpyRtPEJ/EshA8WE9rpmNJlV2cLAhRtuO+eOvZTgdC2dq4A6K5xL/1/RkT/X9imaSeiJheUrECqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005863; c=relaxed/simple;
	bh=fifPAfpfl5kRL6Qh63a+Cpn/koZ33XzAVLiL6A9A27g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1s4cQZT/+k/3v7FkugBpIyYkDQNklZW+kLW+ftvfco0dVQN8jRzsr1AVnoqrl+9LS3YGx7WzDy38IIQWj6jExiJlIukOQBsxf8KBODtI/3ecQkyNL3wMs/fUOnAjUnM+KNzx4eoSDmCtKoc2vsGytLn1es9XEb+Es5SLATEjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PT3aq5fO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720005860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAx6z8ybWrEwqnsWBtSXMT7hJzeMqbo9bpTukbVaXq0=;
	b=PT3aq5fOJJpmRP9a2YF9pgPki74IWNu1OT1+jFFbT7oJggNLpFSMb26crbwWVMhp++b28b
	EtwhZYhR1PbS8q9TKjzXt4Cj13Y0GJmP6t24ygN4g3roP4Nkb+GfBKkDcygzKz+DthX923
	pG/tjtKm7omF8pAiUJhxVLM+Md5nayQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-sOVFyv-tP8-A3NRl9WGXyA-1; Wed,
 03 Jul 2024 07:24:17 -0400
X-MC-Unique: sOVFyv-tP8-A3NRl9WGXyA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC4611955F77;
	Wed,  3 Jul 2024 11:24:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF4BD1955F21;
	Wed,  3 Jul 2024 11:24:13 +0000 (UTC)
Date: Wed, 3 Jul 2024 19:24:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] crash: Remove duplicate included header
Message-ID: <ZoU02QtQZ46pmE9/@MiWiFi-R3L-srv>
References: <20240703093517.730559-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703093517.730559-2-thorsten.blum@toblux.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi,

On 07/03/24 at 11:35am, Thorsten Blum wrote:
> Remove duplicate included header file linux/kexec.h
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/crash_reserve.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks for catching this, while,

It has been fixed by below patch in next tree:

commit 5eb1911a8c63f0e10a5f746f52fcc3c9bbfbc710
Author: Wenchao Hao <haowenchao22@gmail.com>
Date:   Thu Jun 6 17:14:27 2024 +0800

    crash: remove header files which are included more than once

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5b2722a93a48..d3b4cd12bdd1 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -13,7 +13,6 @@
>  #include <linux/memory.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/memblock.h>
> -#include <linux/kexec.h>
>  #include <linux/kmemleak.h>
>  
>  #include <asm/page.h>
> -- 
> 2.45.2
> 


