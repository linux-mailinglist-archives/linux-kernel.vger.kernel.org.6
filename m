Return-Path: <linux-kernel+bounces-540858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAA0A4B5DE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AAB16ADC6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 01:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760E13D8A4;
	Mon,  3 Mar 2025 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4D93uuD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100B2C181
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740966730; cv=none; b=lOf3O09NOF/xlNRBl5MErFMKIZYqfBWpeX+fEwbqx0S5H7fb+1JJX0PZ2VyZgkDRflMGptyRQ1J2k0urL4F6EjmZfv/2sRLWpD6KAXLf2TmF9RZu/zCmxK9pMsMmFiXlHahMrYZL4hWEYBhmBhTvIdr12m09sBZjJY/HbBE6Rso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740966730; c=relaxed/simple;
	bh=AHKoFn86YqfYu7Gg2wb7Ctx+iJACYkxthjbUS52haLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzGSYKN4xpz7cb0bCx/p6VEZFsqbVjBo8fk9hOCxGa2WuFlYxAdgMHjA6c4fPzZdoboALN0v/NSH8trR030n1Bha81PVGN7fBoQf0JBNLmlT2NcWrUtF36S0kwcB4E01wXqE2S68v3Gob8Sz80/U+CXmXYRbHVJdEAMSWVh4jw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4D93uuD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740966727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1yl5l9g7tT6vgWjZQbaAGhUwvcUn0WerlHiF2w1V+s=;
	b=c4D93uuDwW1mKDm+PY2Ax91e0egVPaphftRFluwlPwM3MZrt0rhNmVzaDVNzMsVYgiLBlO
	chOK+i8rlADgZK6V0sXVES4S8sARReTHtXGPTi5T9dYHmkuroN19pq2mY/jPg/vPecGFm7
	ExS/GO6RQYE6i3l76k9dh8eLAf5EXNw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-N64PRUnSOc6szdAmPXHY0Q-1; Sun,
 02 Mar 2025 20:52:04 -0500
X-MC-Unique: N64PRUnSOc6szdAmPXHY0Q-1
X-Mimecast-MFC-AGG-ID: N64PRUnSOc6szdAmPXHY0Q_1740966723
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 804D71954128;
	Mon,  3 Mar 2025 01:52:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34A02180035F;
	Mon,  3 Mar 2025 01:51:58 +0000 (UTC)
Date: Mon, 3 Mar 2025 09:51:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 1/5] Add a new optional ",cma" suffix to the
 crashkernel= command line option
Message-ID: <Z8ULOoFYpvxC6Ey3@MiWiFi-R3L-srv>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <Z7ddi3ShAoQR2FtM@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7ddi3ShAoQR2FtM@dwarf.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/20/25 at 05:51pm, Jiri Bohac wrote:
......snip...  
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index a620fb4b2116..e72a9c897694 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -172,17 +172,19 @@ static int __init parse_crashkernel_simple(char *cmdline,
>  
>  #define SUFFIX_HIGH 0
>  #define SUFFIX_LOW  1
> -#define SUFFIX_NULL 2
> +#define SUFFIX_CMA  2
> +#define SUFFIX_NULL 3
>  static __initdata char *suffix_tbl[] = {
> -	[SUFFIX_HIGH] = ",high",
> -	[SUFFIX_LOW]  = ",low",
> -	[SUFFIX_NULL] = NULL,
> +	[SUFFIX_HIGH]	= ",high",
> +	[SUFFIX_LOW]	= ",low",
> +	[SUFFIX_CMA]	= ",cma",
> +	[SUFFIX_NULL]	= NULL,
>  };

Seems the old style looks a little better.
......


