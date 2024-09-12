Return-Path: <linux-kernel+bounces-326759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E1976C99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1AB1F2215C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D51BA87B;
	Thu, 12 Sep 2024 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jq0SPCQ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A615D5D9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152513; cv=none; b=cQHFoJ84lisuF+/daaZ5UdHIPAyL8Irz3zB8D4Wia3mxO+QaaD+mDo8tFrGxgJUBXRqIvHT0JsKhCQuN8o3UWdRtOWVmxQ685KYf07mH8IgQJLXiCXlXnlpMt4idGB4+aeODpWF9ATz5jxE710UqbiUwhlxFx1SbJ7whIMXyszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152513; c=relaxed/simple;
	bh=I9BquQXnctDUQmS7DDca+GWzDirl5XIj2/CUHw17JVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ur76I0iF8/Xk+6w5jBgXT4bxDK4H335W7/PhudG+pKmYATXj0HRgzh47wXtEi8mlDJYXaXbcnoxC0VK+M/1fAFBp+EvuHfKkYo670Murf7naYziL4Slad4rMjIpZwfnU5Kmk0yRw9zfVbJmxzk6jTK8cnTYn/yfDIgwonXIDOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jq0SPCQ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726152509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9BquQXnctDUQmS7DDca+GWzDirl5XIj2/CUHw17JVU=;
	b=Jq0SPCQ69o2gS/J8pcck5k+LJjKhrEOjhMR+uQTOWvkUM78817fXyZ1SQg1wfH5sjR2dr0
	DfJBTseZkRH4D76hfCdVTLjmfeGlRZy3b3RiDXOgEbXH+HVtEOHxWOnHJSPHnkzlVa+9UL
	wpMuG1dzHt9uU7vElOLVnaafeu7UWnM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-8Nx7mO6BM8e0D_le_YIxdg-1; Thu, 12 Sep 2024 10:48:25 -0400
X-MC-Unique: 8Nx7mO6BM8e0D_le_YIxdg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso9027655e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152503; x=1726757303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9BquQXnctDUQmS7DDca+GWzDirl5XIj2/CUHw17JVU=;
        b=FTdx3KKqxVg/OylVdak+NYFcHTvgUdxsv4JoBWHhcdYJxpmHNikPg6vjgv8Sk3q3VI
         Wgw55MEy3YNgEaSRxZk2KR/Vh2nZbhyagVIlhztkUiJt40h2e63NqtUYyKDO/aHEzjjz
         c6YfaQM6yNO3DAyMbrUmnyFQDD7azD5Uh2grCpCMOn4TKkDJ+O6TadjK6d37Yzn36GW1
         4tWOKm0FMvfjmHWHnzDcV15krELGc0HDnSXEHoj+4bkn0PNpHViKGCaepfQWjF9CIPfE
         /4wb2K14g2t+8hT3rV8SMkcUk6oQcuvWvd7D3nZjphqHHJxuJbCFIxovPCeeK1Yph6No
         G9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU1zJh79V45Pe4IM6g2rStwqI0B6CkLFJJF69osFUwRCgszgERZ63IKDsC5MH+CQrldJMUrYjiKO1FL6eU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1/+85+4FzI3BoabnSzGI0GOg0gsnCptt+HqSb/G0DY3SDoA5
	TpwnhTgm1jtV0CJES3U82dXpFGnQRadUUWfMK9xnTxPWAYzQ4ix9NtM46hK+mYVjBnpR6TEas6G
	VGvs5dvW6s3hLMAYruP1xiklmpIvn2n3R5nKjxtlOFydfslnHQNNjWmxlZxz3ddmakEuxW7GuGf
	AnCSMmLvWD8BPGFoKBNgmdCObRhJwOFBobrXov
X-Received: by 2002:a05:600c:1d14:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-42cdb5486fdmr31431365e9.15.1726152503208;
        Thu, 12 Sep 2024 07:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpLGl2xBFllVesJx6Z/wIIk8uIHfpyIB3c2nK7IUhZ36w6vosYUWk1abhfW4zozWs0K5LGLOIaGzqJfExBIMs=
X-Received: by 2002:a05:600c:1d14:b0:42c:a8cb:6a5a with SMTP id
 5b1f17b1804b1-42cdb5486fdmr31431095e9.15.1726152502670; Thu, 12 Sep 2024
 07:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-26-rick.p.edgecombe@intel.com> <05cf3e20-6508-48c3-9e4c-9f2a2a719012@redhat.com>
 <cd236026-0bc9-424c-8d49-6bdc9daf5743@intel.com> <CABgObfbyd-a_bD-3fKmF3jVgrTiCDa3SHmrmugRji8BB-vs5GA@mail.gmail.com>
 <df05e4fe-a50b-49a8-9ea0-2077cb061c44@intel.com>
In-Reply-To: <df05e4fe-a50b-49a8-9ea0-2077cb061c44@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Sep 2024 16:48:11 +0200
Message-ID: <CABgObfZ5ssWK=Beu7t+7RqyZGMiY2zbmAKPy_Sk0URDZ9zbhJA@mail.gmail.com>
Subject: Re: [PATCH 25/25] KVM: x86: Add CPUID bits missing from KVM_GET_SUPPORTED_CPUID
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com, kvm@vger.kernel.org, 
	kai.huang@intel.com, isaku.yamahata@gmail.com, tony.lindgren@linux.intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:45=E2=80=AFPM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
> > KVM is not going to have any checks, it's only going to pass the
> > CPUID to the TDX module and return an error if the check fails
> > in the TDX module.
>
> If so, new feature can be enabled for TDs out of KVM's control.
>
> Is it acceptable?

It's the same as for non-TDX VMs, I think it's acceptable.

Paolo


