Return-Path: <linux-kernel+bounces-530429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06846A4335B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F4D3AF8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7B13CFA6;
	Tue, 25 Feb 2025 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gg5wsJlL"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D45610D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740452555; cv=none; b=lZvDKgMYslumQVuURM8dDQJRPRwB5A2CY8EFhRLL5yIM44VZqTkgtAOO97fpjAQUU/dG8es05Wc7XF6pLBAnlV6lO4C+4stjmfSs4gJsvP5ZjORZ3Gscxin0jHYKPk9bVLC9EPVq6dDgDBMwbSHXRxDsv1R6SwFJvaK0FnNN10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740452555; c=relaxed/simple;
	bh=FU4TLM2MkO3S/lV0HkIT1xTCwvcyXAkDYFvO18orl/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7BJ9BaaWeC+NwmTlIgmiT/1aJv4YN2kAydfbKyoekNXpjUb25S4EvuqsJLkufdxNvCUQj30TYguXn8mZEJlYZR21BMkb4kurIORlMU3NZuhgkvHYERB/sbWgb1fi9kcHkEbgdPjN/eTcoOUAhTDFAkU+Fay9C2FUR9NJ9nk07c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gg5wsJlL; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e6621960eeso59167206d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740452552; x=1741057352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug8NwBfivrOgnYcA4EqL3bQC5MfA8YnwgBxaTB+IaEI=;
        b=gg5wsJlLyLnkSrmgR2Dm5PdeIs4qOjarqx1/Qpflnv/K/rGjBzycls2as+y13Jm2m/
         0PT46iSz2CUscBnunBmyjetKZXg0F6FrJ/ZFq1otDvh8c0x4ZpYn6OEYary67y3hgaMH
         aA5EFLPoc/k9ZLXFgpD1pY5TKgxINj6XdKVpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740452552; x=1741057352;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug8NwBfivrOgnYcA4EqL3bQC5MfA8YnwgBxaTB+IaEI=;
        b=XjvikKO94UBnb+HN7KDfij2fd7f4m5JtXuZkE64p3QsCmzuEWZ54k8F92WJaLcvMfP
         SgKXwnNVFDECsAc5BspbyZOqmkI3pInk+1NScdQmZTPL2R4x14xzw5NJP8Ncvpd4hFKJ
         wpJBWDK1CuAvYkqvPQzV2aU/6tkj5757A01sRpMHrrP111fD4L3G2ugH18LKe3z4AB26
         +fwKecylD3AhEemLhN0C3b1NxCjz3FvLa/X5vaWgRsUvdcOv94TxxFQeCQOeaEi9c5+8
         L1Jk2XI7qm2o3k84mhZB/scLI3RKnIIg9gujjHJRgc1/vtctVBOvm/HPPHeoA9rTydah
         b52A==
X-Forwarded-Encrypted: i=1; AJvYcCVlktvyeVSTIq9gyg7T7toOKOi4NH44nlxXIZUYjFCMskKOrBeD8n4YhH+/fUWcH11rte2tRDj99V7iFFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3CztvNkQx+sgFQ366TI21p+LqhP/b4UXy/xPUZM56jtYm+IT
	B8WUVMaDKqx0HwfxoOtPgXpbSq5fWUJ51nnMMc+Dji2GsqXLgwjXmCfeaDi1vzQ=
X-Gm-Gg: ASbGncuNkV6tSST2X+XDTaW0HpSoy5y50jL4hGcQYnTlt+ccZs7BKZGAWRBWcYuYE+D
	NZlPFzI1RR2p7M/6xmivFXB7rLg3khr33L0ArfPNgXoN7r+BeTiXTuxfpBZrrwpHxdRSfKtlNQJ
	nyji+H5DTKog9F8Pcjgmx2Djnd/svCIKVoNnUIydk6M0wwh3u9tIl0iiDYBy+6cGVWshM772R2v
	u/9vEfGW2Gu1tH74oHrEkLeHN8yKxsHGYodvglrOoTsVInIJYBx65ohjhbs+RRAiKYWUbYQdElp
	nfmpVZAvvK08WNS5bllOFqZBD9Sx6wvhoyYHLZZOorjdmO8mciqINlokQS2HurD3
X-Google-Smtp-Source: AGHT+IHYq9JPhIIdjZAYeUQu/47H4+RNY26Q6928CpBQmOq+nEFJEYNIOOGzrUX7fNR1H7FwmZWc7g==
X-Received: by 2002:a05:6214:1250:b0:6e2:3761:71b0 with SMTP id 6a1803df08f44-6e6ae72d99bmr235451876d6.5.1740452552663;
        Mon, 24 Feb 2025 19:02:32 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b19a3bbsm4540516d6.119.2025.02.24.19.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:02:31 -0800 (PST)
Date: Mon, 24 Feb 2025 22:02:28 -0500
From: Joe Damato <jdamato@fastly.com>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH v2 1/1] af_unix: Fix memory leak in unix_dgram_sendmsg()
Message-ID: <Z70yxC3uHE6R_KOu@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
References: <20250225021457.1824-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225021457.1824-1-ahuang12@lenovo.com>

On Tue, Feb 25, 2025 at 10:14:57AM +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> After running the 'sendmsg02' program of Linux Test Project (LTP),
> kmemleak reports the following memory leak:
> 
>   # cat /sys/kernel/debug/kmemleak
>   unreferenced object 0xffff888243866800 (size 2048):
>     comm "sendmsg02", pid 67, jiffies 4294903166
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 5e 00 00 00 00 00 00 00  ........^.......
>       01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>     backtrace (crc 7e96a3f2):
>       kmemleak_alloc+0x56/0x90
>       kmem_cache_alloc_noprof+0x209/0x450
>       sk_prot_alloc.constprop.0+0x60/0x160
>       sk_alloc+0x32/0xc0
>       unix_create1+0x67/0x2b0
>       unix_create+0x47/0xa0
>       __sock_create+0x12e/0x200
>       __sys_socket+0x6d/0x100
>       __x64_sys_socket+0x1b/0x30
>       x64_sys_call+0x7e1/0x2140
>       do_syscall_64+0x54/0x110
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Commit 689c398885cc ("af_unix: Defer sock_put() to clean up path in
> unix_dgram_sendmsg().") defers sock_put() in the error handling path.
> However, it fails to account for the condition 'msg->msg_namelen != 0',
> resulting in a memory leak when the code jumps to the 'lookup' label.
> 
> Fix issue by calling sock_put() if 'msg->msg_namelen != 0' is met.
> 
> Fixes: 689c398885cc ("af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().")
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
> Changelog v2:
>  - Per Kuniyuki's suggestion: Remove 'else' statement

FYI according to netdev rules you should wait at least 24 hours
between repostings:

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

That said:

Acked-by: Joe Damato <jdamato@fastly.com>

