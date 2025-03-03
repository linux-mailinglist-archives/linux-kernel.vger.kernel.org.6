Return-Path: <linux-kernel+bounces-540867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4796EA4B5F6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA6016C058
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9C6146013;
	Mon,  3 Mar 2025 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYjKzPio"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52052A1CF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740967742; cv=none; b=MDHTacqcNp/anbFMKDJkW/L3sQq2o6oKKEAxi3K634aYRLd2PjHLq+qN7Mz4niwKkFn7Z0snRyFsGLDadBDFCjo9sG6P07f7HuD49NaTGo23n+JIgoMMgEBfr73SFZHEbwonzeZStxveWIWSLWWvyTBH03iHuEPs4uDwWrLlaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740967742; c=relaxed/simple;
	bh=nqgdUD96KZUSKWxGIwkl0+rF4vLAf+QrHgyKj9UAgZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIXJ8nqqW+fZ2+HZElwiZX3ijJtJo95eXcCvUVNln84V7TcaYfoXoTPPBboMJiLaY685CF0aySr7MZa7OuIMBSaAxIEL6yJ+fjhg9iXwCGommmujvLktlAJ+hx8kwn3g0L8mcY/wlswQad2+xtLbKBQTBJtMwMlxBGPSeV57qlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYjKzPio; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740967739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1cEbGwc6l9VNyk8uqeQErnSNAMsXtfPwdweqT8cO8i0=;
	b=JYjKzPioS2N8qdH3iubB41L7zuIqPwtDSdN8eNIgZWG5AnPnB7YhSmG1MByFPIfbci3zm+
	A6XJTgsVGLzkU5T9L9xQMQcXUzaJ9+j5w5k0Kv/zWzMHWyTP604T7Pj5bQlrswDdNuwD7/
	BxEpqxzcAI2o0J9ZvIG1bhWdZlqGb4c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-OBS1U2UDMGWtX0EnlUI9Lg-1; Sun,
 02 Mar 2025 21:08:46 -0500
X-MC-Unique: OBS1U2UDMGWtX0EnlUI9Lg-1
X-Mimecast-MFC-AGG-ID: OBS1U2UDMGWtX0EnlUI9Lg_1740967725
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88DBF1800268;
	Mon,  3 Mar 2025 02:08:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABE981800361;
	Mon,  3 Mar 2025 02:08:38 +0000 (UTC)
Date: Mon, 3 Mar 2025 10:08:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <Z8UPIYFqAgiH8s6R@MiWiFi-R3L-srv>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/20/25 at 05:48pm, Jiri Bohac wrote:
......snip... 
> ---
> Changes since v1:
> 
> The key concern raised in the v1 discussion was that pages in the
> CMA region may be pinned and used for a DMA transfer, potentially
> corrupting the new kernel's memory. When the cma suffix is used, kdump
> may be less reliable and the corruption hard to debug
> 
> This v2 series addresses this concern in two ways:
> 
> 1) Clearly stating the potential problem in the updated
> Documentation and setting the expectation (patch 3/5)
> 
> Documentation now explicitly states that:
> - the risk of kdump failure is increased
> - the CMA reservation is intended for users who can not or don't
>   want to sacrifice enough memory for a standard crashkernel reservation
>   and who prefer less reliable kdump to no kdump at all
> 
> This is consistent with the documentation of the
> crash_kexec_post_notifiers option, which can also increase the
> risk of kdump failure, yet may be the only way to use kdump on
> some systems. And just like the crash_kexec_post_notifiers
> option, the cma crashkernel suffix is completely optional:
> the series has zero effect when the suffix is not used.

Thanks for the effort to investigate and add clear note about the
potential risk in document. Except of the 1 second waiting for short
term pined page for DMA, the whole series looks good to me. Hope other
people can also give comment to evaluate the risk of waiting, I will
wait another week to add my personal ACK.

Thanks
Baoquan

> 
> 2) Giving DMA time to finish before booting the kdump kernel
>    (patch 4/5)
> 
> Pages can be pinned for long term use using the FOLL_LONGTERM
> flag. Then they are migrated outside the CMA region. Pinning
> without this flag shows that the intent of their user is to only
> use them for short-lived DMA transfers. 
> 
> Delay the boot of the kdump kernel when the CMA reservation is
> used, giving potential pending DMA transfers time to finish.
> 
> Other minor changes since v1:
> - updated for 6.14-rc2
> - moved #ifdefs and #defines to header files
> - added __always_unused in parse_crashkernel() to silence a false
>   unused variable warning
>  
> 
> -- 
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
> 
> 


