Return-Path: <linux-kernel+bounces-416735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4589D4967
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8A41F220C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F981CBE83;
	Thu, 21 Nov 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6iC9y8D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1EA1C9ECE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179646; cv=none; b=putntYvwXzHQca2+265Jz/eODUjMoZeGDVISuGlpZk5c7gJlk1S9Fe36gkFeADlF08hAbcIPAVomvS3Am5dLDqtEw8Rl5zqE/vQ7kBQ0WiWgElv12ItOfD1D5sWekCs0bLhSm1gMpFOQVKI0AZjdOo+YXav17PmV7Q2Pbe3t8cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179646; c=relaxed/simple;
	bh=ZnCk/5g2TfMnFVnDiNYU9hF72gFeq8DTzd2S/HP3jYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjBrmoVKwhjbSEtxJOZzwC2qBXsnl6Zszc/FHGtlAka2OdFCfWGtHiEH1HB7CDoFDM08cCg8Gtp0b2QbWsZNbJF2EwR0cRMfYgF1dpzSKw1GcixYxQv5TlsmLKmFftZQidJpI2SYy7aXMO4fqx5Z8JYJ2av88z7GieMmugmVKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6iC9y8D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGDVNO6KuLT2CaTKYJTuRwWCpafnUpHauXNIMBPMRRY=;
	b=N6iC9y8DL9vLmI41pVLq3IPRQfEok+2PPNQgjKqhcVu+kvNcbs7o0VJqDeR+7joDH25TH0
	Ou4imSCohI1uHm+urTUHGcdkUMGKn5FIUTK+j4PKQqf5cUyiRH8H83kAsCQfy1KDvflky7
	NNGbE38rnc7Y37x/X1DJZnP8VmRpRTc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-rYDujQvrMx21gO4l0eUrmg-1; Thu, 21 Nov 2024 04:00:42 -0500
X-MC-Unique: rYDujQvrMx21gO4l0eUrmg-1
X-Mimecast-MFC-AGG-ID: rYDujQvrMx21gO4l0eUrmg
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d41138c0abso11399546d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179641; x=1732784441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGDVNO6KuLT2CaTKYJTuRwWCpafnUpHauXNIMBPMRRY=;
        b=ejEK4IZpdFcQlklmZNZDZq5gMiJL0WTGwgldZMYy27WFcwEWn/V8wFF0//9Mc5ZrBL
         BrAgrCiFJHNiEyQvAtXxD6N6LzBdDxQFAshBlL2GM/lifRQI4YdT0PLj7oAiAEZnwjnO
         KPSgQ1CGgYOPuB+wZsUIMCrKw7iBbwRRXnQ/wp4fbbOfIBB+iTCZjZnSMEt2vIqt+bZg
         aXYxq5OROP4iZececjkeecFukWGrL4Yqf0/tn/rjxhrvWGwmZTufSh8BGY468JPd7IOu
         nSy4fFkXVLqnACi/l/BHxcYng28zuswZAXplYfA8YdWkuANelCBw/ZqcPNxFQFx0JzkS
         7ViA==
X-Forwarded-Encrypted: i=1; AJvYcCVATbChyS2U/w8nQlPeLC5tgIDA4JtNxdYvbuwC8Ge3zPy8b/t1IZU+IgvRTOisUIM/msdvZYkWFwEd97w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhb4xkpCn+4PoNB8OMzsqpaCfaIBKRtSy2c9HrLxvl6I521XB
	aWpkMH5GqWHB2C7UYv+1hwBw6xWW6BC+wbnGUp+qrJQl6akqq8n07FcEkLd8I97GVbVVRneJygP
	RQ3MHvfb/G/4xPr8vtGXnafVStugjozTN4cu3F9wPnCQvHMxsTyAuqUkATF3nBQ==
X-Gm-Gg: ASbGncvycgKdDWnrH50Szws+DgRhojcPqraEIRE66MvuQtQ6BUNi8HcA4XXLzU39agD
	KjHuEYZsp55N0k80BVJxOHomazGnItupiK6/o39frYr5/Ysr//LC8PMTJbwZhIY1qk84/fy8ObM
	mzeHm9y3Mrl6DdcK8AOTLaUWhIYFHqnKHSOcR9FpGjaRVFjGNrz8GxVDxToeCaQ/LAtOinOauuy
	1rBqWC3kKP/bdkFnZ1a4Ang3Pr34yrWv27+a68kl4dlimG4on55eybF9YCS641tXuG+L8pP8Q==
X-Received: by 2002:a05:6214:b65:b0:6d1:74d4:4ba2 with SMTP id 6a1803df08f44-6d43778e4a0mr103045306d6.9.1732179641626;
        Thu, 21 Nov 2024 01:00:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdmy2H9pW5POPHqGGAxMcBpXXjXeyFHS9b0AAyNbf4MGFLMnDsHCORTEYORJXQ6zeWUALLNg==
X-Received: by 2002:a05:6214:b65:b0:6d1:74d4:4ba2 with SMTP id 6a1803df08f44-6d43778e4a0mr103044906d6.9.1732179641249;
        Thu, 21 Nov 2024 01:00:41 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812c8ffsm20484906d6.91.2024.11.21.01.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:00:40 -0800 (PST)
Message-ID: <22595a95-e4e9-4aeb-905c-ad928c5fad58@redhat.com>
Date: Thu, 21 Nov 2024 10:00:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/21] net:yt6801: Add Motorcomm yt6801 PCIe
 driver
To: Frank Sae <Frank.Sae@motor-comm.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com, hua.sun@motor-comm.com
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 11:56, Frank Sae wrote:
> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
> and adding yt6801 ethernet driver entry in MAINTAINERS file.
> 
> YT6801 integrates a YT8531S phy.

Please have a better read to the process documentation and specifically at:

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/maintainer-netdev.rst#L14

before your next submission.

Additionally:

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle





