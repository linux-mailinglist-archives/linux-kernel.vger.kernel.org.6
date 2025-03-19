Return-Path: <linux-kernel+bounces-567566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD5A687D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4963416EF71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F578253345;
	Wed, 19 Mar 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFaZWvAL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC22505C7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376089; cv=none; b=a807PSJxeDLGosmXloV30hbp06XwRVP15LJD9lqjzi/Dgxe6MTlpGFOHwZGBaj5Ro4+eq+McQpQG1BkwBri05d/glvxsCjNFJo2hL8zGM/7tytLe8YZ6EV3MhbF5UyquiLvJxq9fc4MFanOQG2xw9T/7lWZutsvX63oVA6rR/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376089; c=relaxed/simple;
	bh=hayqKUFA/zQJSjM3dzvjLdtKtJ8WDFXlSPyW2SDZhz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPeU5akbmGs8QLjpuCtoCNwKFNGLOC6ojZzoNtQudBYE2DTHhQyIbYuelhktx6sfEvKP+uOrHpMM/WWNpeDyoZ9+ENyWbtze2aB+E/YnlUT7UK8DLFqpEsqb4kROCPqqN2/WG1iF1hUsfHc5w7BSwzUqQrbMXfQUzjpslICTCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFaZWvAL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742376086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBldNCvr3M04fJOmB6HQlMjvE8qJv/8GrRmjEF3wfqc=;
	b=ZFaZWvALGZAqvCJ9cUKK+jQsa0KX6D/poQ+lTLyGJQt81RvaZ03hSzkc0B3J4/9o/I5UGX
	7xuLm3f7MZHZnv0qy4AN7n+c5dgWTyZtMDzjqdrEOi8at3SzBaxv5cvfH/wnvA69qPdlO9
	6KiLb4YLYZZAie2fegUMobC+61mTCbk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-uJGmzRFGOjGAo1hJatXvZQ-1; Wed, 19 Mar 2025 05:21:23 -0400
X-MC-Unique: uJGmzRFGOjGAo1hJatXvZQ-1
X-Mimecast-MFC-AGG-ID: uJGmzRFGOjGAo1hJatXvZQ_1742376082
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so26693525e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742376082; x=1742980882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBldNCvr3M04fJOmB6HQlMjvE8qJv/8GrRmjEF3wfqc=;
        b=CmAnwXJUeHUOBiIEM+GMc/ek0Sn7OmAyuHr++txdtW80qGoM1g3RIAFphbLh1DrBP1
         7uUAz3mIYmcGerHFEmD1sV4GWfh3hqO/R9gs9rhHewVD0oeRmdMsU9ppP9GXapFCa2/t
         55NNbDy4ARMJkKKldkWmeKAjTBt3r/G4fX1aKLJv8bZkHovGk0KkfQR4UwTotFzMSdgx
         ms3DUheac7KumfhEPIiXCH8LSiKPMgK/MQfyFLaQKyqT6hpbr6QRv61M3pXpi0a0Q6sS
         C798Uj0DVXRjibEeUUre5MsklkAGHzkUQLpLyI3o6l7Uwf0JLBLHo7upHC2n1f2jithD
         MYiA==
X-Forwarded-Encrypted: i=1; AJvYcCW6dp9MVyVzgya6vTkcByrSzI8pV9iyY1qxhBU4+gGjJeHmuYcuDpWtdd+3SCr08lbDgw9MpKvqqHg/SOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaeFJpCGXDWSKkw82qzek8CECy04EL99sGsvRWiMT9HGE6j/ld
	cWUZLmmBRGgjhbM41nLxO5tYzHBOO3P6vnxglXExHbWV4OscD+UNWoSo7PjfDQF4wsCFtUpayOu
	07ticzLPRBLo69+V7g8+bl5u7cZagxoRkHhrvlWnfDlRXX1PsF+igImEUC2ZrdQ==
X-Gm-Gg: ASbGncsMRkNWY8ymtVUQZmaAvMRJHLh8kN2KOlZBQ8waMTJBOye3KlFJM/VHGRXfx+M
	oeYudACqIVKAqQcj/wdcU5lhFpG+WWKtTn03VG/ktmUusDOmpXGHEd/eZYhevrV3Ju/WoaR8kEO
	HnSqLAIrIZQpObZ8vFG9bb54PgHzTGofzJtD5Bl7gTRk6IdUJLRVTlBVMz7/SEh3+AAcrRQHvKl
	p7LgcSpX2rRJcmgTFveiqG/ZQT7VKki7afG7XBHR9qDOA347cr9+ERxvOSFu2RJ17DPHVD8Iovg
	EfdBAjt2hA==
X-Received: by 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr15053185e9.3.1742376081589;
        Wed, 19 Mar 2025 02:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFTbAy+ec2vOHg58y5rxcFbvt1zKhjrhAbtgCtsF91K96gkFV7iO8cXVF5jgAUnN+dJQoKFQ==
X-Received: by 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr15052755e9.3.1742376081050;
        Wed, 19 Mar 2025 02:21:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f84f9bsm13000475e9.33.2025.03.19.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:21:20 -0700 (PDT)
Date: Wed, 19 Mar 2025 05:21:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] vsock/bpf: Handle races between sockmap
 update and connect() disconnecting
Message-ID: <20250319052106-mutt-send-email-mst@kernel.org>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>

On Mon, Mar 17, 2025 at 10:52:22AM +0100, Michal Luczaj wrote:
> Signal delivery during connect() may disconnect an already established
> socket. Problem is that such socket might have been placed in a sockmap
> before the connection was closed.
> 
> PATCH 1 ensures this race won't lead to an unconnected vsock staying in the
> sockmap. PATCH 2 selftests it. 
> 
> PATCH 3 fixes a related race. Note that selftest in PATCH 2 does test this
> code as well, but winning this race variant may take more than 2 seconds,
> so I'm not advertising it.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

vsock things:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v4:
> - Selftest: send signal to only our own process
> - Link to v3: https://lore.kernel.org/r/20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co
> 
> Changes in v3:
> - Selftest: drop unnecessary variable initialization and reorder the calls
> - Link to v2: https://lore.kernel.org/r/20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co
> 
> Changes in v2:
> - Handle one more path of tripping the warning
> - Add a selftest
> - Collect R-b [Stefano]
> - Link to v1: https://lore.kernel.org/r/20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co
> 
> ---
> Michal Luczaj (3):
>       vsock/bpf: Fix EINTR connect() racing sockmap update
>       selftest/bpf: Add test for AF_VSOCK connect() racing sockmap update
>       vsock/bpf: Fix bpf recvmsg() racing transport reassignment
> 
>  net/vmw_vsock/af_vsock.c                           | 10 ++-
>  net/vmw_vsock/vsock_bpf.c                          | 24 ++++--
>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 99 ++++++++++++++++++++++
>  3 files changed, 124 insertions(+), 9 deletions(-)
> ---
> base-commit: da9e8efe7ee10e8425dc356a9fc593502c8e3933
> change-id: 20250305-vsock-trans-signal-race-d62f7718d099
> 
> Best regards,
> -- 
> Michal Luczaj <mhal@rbox.co>


