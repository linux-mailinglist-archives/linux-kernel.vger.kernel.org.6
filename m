Return-Path: <linux-kernel+bounces-427941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF0B9E08D1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6122BA10E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE413632B;
	Mon,  2 Dec 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDIPDATL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B524EB50
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154904; cv=none; b=f39cctNcjCDF4vytBt559va0nkQ6IVjcG3gcS4XnPjvT1NDXe32xkNQEU+HDN4xm2XoZixck5RskNIBZ7M2ME8xJn444pOIUuTfPXMM5sENvfif3JBXLYBad4PPiNajxBpN8iT+nkleUXcgFNC6n6ZrMIZ7gBrMwAL57ZUTYHbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154904; c=relaxed/simple;
	bh=adL+2LkQ/+XNO8hCMwqPkqXMk3kCQCPZ/eITVwvvJb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWlrR0Pg4QLCGTKIR3XWPBv52RdYLDvRodDPQJki2GncoRRMa2QGS+IA5m0wEfwOOj5JQQxwcfIR77VkfnxA7iyL/M2PBxhxQM3w3d7Bq1C2CmTqqL/ydQYrMcb3mHabTJEplwYGLNePz8YzIlYi78SHavrwE31ps4XmZg3Ml7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDIPDATL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733154901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMGz26Pd93vereCLJasLGT8lvdI6LqnhcQp8tpVjo7A=;
	b=eDIPDATLly/sn2wCjq7JcEXjFcUvLXMWc+Gdrbr1uzWOmmO4nI0B/ifsXiTwlUQYv3eLly
	+KbfcvJHLgBhWyco3JZQIIGvqOSSQPk0/VxRH1yfgMtZW6ttFAPRT5GDTvhTXLaA5imusm
	REHuzEdS7DLqpLhM/yrM3qLAqjxk7Y4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-GXYRNArGNumEasYJdjeW2A-1; Mon, 02 Dec 2024 10:55:00 -0500
X-MC-Unique: GXYRNArGNumEasYJdjeW2A-1
X-Mimecast-MFC-AGG-ID: GXYRNArGNumEasYJdjeW2A
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d883c2024dso41379756d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154899; x=1733759699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMGz26Pd93vereCLJasLGT8lvdI6LqnhcQp8tpVjo7A=;
        b=hAe1jt8XoLJbfb5uR8FJkniGTz6dvH9+gfD65bkPTwTDH+ntMPKJwlkT1n9m298/iq
         lRk4Upb7yaFkdiue6WL7uis1QvuOoUu6z23zJTbtIE3cDsa8vINUu6WFTyh9y0ycU5P6
         Wgs6U17/JmsC4BqVsUpcv4MwjLMcVmL4jNrXMpQ2UmfA5UJwAEbXCVJj/lBxh+T3cRdt
         Q3upDmKedZjVo7GotnTLvd4R0KNahDVP7ySOUfyc1QHXDdjKM5t5qgrYfSV3JVAeOMxM
         jzGodKoZOStm6JM0MmSVI600ExLZIzxxQ480ykT3f+68RTJba+DK6aOuZnasAyxRHMor
         cUgg==
X-Forwarded-Encrypted: i=1; AJvYcCWFyPi3vg/Mi9naIOptoqGFy7ktdbr2A/5zVb/KUt+znFgQ9gupub2EoWjp706swVtN6YWDm8BIaIGEdiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HJhJK/QNkF77LBooKBKGndJauVZq5PRm9Bn2VBMPUHLgdE7W
	OMm57zQgJjld9hni/KF8gOubts1x9RyrOr43istf6pksA0MgiP7NamAU7MLVV9Xwz3CR4ofd+2i
	ztzKj1igHnulSPIi4V1iRLRrT/IaWwCdD5MbQCJPn6TqfNKrjXDeBfcPF7nZwmfvqXMgDGmo5
X-Gm-Gg: ASbGncsva5HDeHbnxiqigsoWqERh05c6b6aVb8Wc5Ktk7NjAJr+Hjo/ew9t39wpXEjE
	dmt579qnxH8tght22UKcpJM+kEFogKqMFf1PlAMLl4YanLzeshuYrREpODFEMp+Q7waDdMpXT5D
	xlunmwK+Iw8jKrbn8Y4VshsJp+ci0ERBXIchGIZ9zBp3HYsVVMKVz3y/pzRmoEb+Yy2VgWu6zHT
	LQFt8h2AiEs9+GRHsox+0NBaz2k/STHRENojoPC2muHGZWJnMdcsOCqZfnTCX/RFht+D3F7zYiW
	HSbYTOBBExanXB4xP9BgKVNIzg==
X-Received: by 2002:a05:6214:dc7:b0:6d8:88c2:af5f with SMTP id 6a1803df08f44-6d888c2b26amr293838706d6.1.1733154899429;
        Mon, 02 Dec 2024 07:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoviEDi9BXOJucZNgaChi7PR0dT2tjGFWFCa8hO2q8Ph+R9/XOCu9E7Ze6AFBWJMiaAnRaBQ==
X-Received: by 2002:a05:6214:dc7:b0:6d8:88c2:af5f with SMTP id 6a1803df08f44-6d888c2b26amr293837866d6.1.1733154898907;
        Mon, 02 Dec 2024 07:54:58 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d88b9e6a69sm35208006d6.60.2024.12.02.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:54:58 -0800 (PST)
Date: Mon, 2 Dec 2024 16:54:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v6 0/3] vsock/test: fix wrong setsockopt() parameters
Message-ID: <cskeunqjcpywlrkldqw44jpwrrkear46symgk2kucpljsx243h@m7pb7cwvu3yz>
References: <20241113143557.1000843-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241113143557.1000843-1-kshk@linux.ibm.com>

On Wed, Nov 13, 2024 at 08:35:54AM -0600, Konstantin Shkolnyy wrote:
>Parameters were created using wrong C types, which caused them to be of
>wrong size on some architectures, causing problems.
>
>The problem with SO_RCVLOWAT was found on s390 (big endian), while x86-64
>didn't show it. After the fix, all tests pass on s390.
>Then Stefano Garzarella pointed out that SO_VM_SOCKETS_* calls might have
>a similar problem, which turned out to be true, hence, the second patch.
>
>Changes for v6:
>- rework the patch #3 to avoid creating a new file for new functions,
>and exclude vsock_perf from calling the new functions.
>- add "Reviewed-by:" to the patch #2.
>Changes for v5:
>- in the patch #2 replace the introduced uint64_t with unsigned long long
>to match documentation
>- add a patch #3 that verifies every setsockopt() call.
>Changes for v4:
>- add "Reviewed-by:" to the first patch, and add a second patch fixing
>SO_VM_SOCKETS_* calls, which depends on the first one (hence, it's now
>a patch series.)
>Changes for v3:
>- fix the same problem in vsock_perf and update commit message
>Changes for v2:
>- add "Fixes:" lines to the commit message
>
>Konstantin Shkolnyy (3):
>  vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
>  vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
>  vsock/test: verify socket options after setting them

Sorry, this series is marked as "Not applicable" [1] since we forgot to 
target a netdev tree (net/net-next) that we usually use for vsock tests.

Please can you send a v7 (carrying my R-b) targeting the net tree?

You need to rebase on top of net tree and use the "net" tag (e.g.  
[PATCH net]), more details here:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
Let me know if you need more help with that.

Thanks,
Stefano

[1] 
https://patchwork.kernel.org/project/netdevbpf/list/?series=909319&archive=both&state=*


