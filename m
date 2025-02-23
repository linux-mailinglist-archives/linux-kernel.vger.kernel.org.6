Return-Path: <linux-kernel+bounces-527782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C44A40F6C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF653B2CF9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEFF20AF64;
	Sun, 23 Feb 2025 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOAgIvY6"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C41FDA7A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740323993; cv=none; b=OTJJsvKZ0oabItTnkz5rVJaZxW9wtSVdDwMJI9KrUJJoTyk8OAcuO1FiEHkdbfG4XP1eJJ/MB6/smMTQM9iy6zo305KAeksFgoEszvyyjFBZnzFhF7B6c73VMDF7XvLMhlhj/Fewdk5WntjaiPO4i1fpSyTWbBKkR8SGpz8rcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740323993; c=relaxed/simple;
	bh=T/2xb7muvL55Dk7o59poGR1yUA8xbheTCRauo126IEQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nuvuvhCJqu584OzVp0OkGXsQr3yVMRjJSmIma6rsluGLhfQiHg4FzkdwXKQ9fxwSp1k+N2fKUY/O7K7pHGMNdFrnoVi5SStR8stCxv2nuMSEaiK03V/2+dLSe9rTo4ZjDNFGw8OEorggTn7Owq96xSukjoZqTrekzfMqjZHoqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOAgIvY6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2210305535bso120144045ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 07:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740323991; x=1740928791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovxXS/6Fh7CBfimDBUGP6a/bz+MG/2ipqKfqnHfFW1U=;
        b=OOAgIvY6Oubh3wbdSnoLehXz6d+U2U0gcgSZEszxDCn6GkGIUnDHbxGLxCYOsSJImu
         0ejljuAR4L3L/+snnvxlCvA9zjQksk1QRrsYo2tgMImy2ryZulVvhNJIgOWrG30PHFnH
         sb60wmXPPfWrjGhQchBGl1Pmu4juPOnYNRPAAW2Y3wwcwdoYi5uwWwSj++MzR09+y01v
         ITw+NEQ9pQKZW/+hBiG0GBufU2ljAz6MO1tRpi05xw1DgcCqUT8SqNOAoaRzRUDVj71W
         G9KOVrhOs+eAaXqUn6TQZ4ziDD44pqqgoSoJP8UIDEL3ubvE9wuq3OyTaW75H/CrKX5U
         H0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740323991; x=1740928791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovxXS/6Fh7CBfimDBUGP6a/bz+MG/2ipqKfqnHfFW1U=;
        b=YRDSOn/lxSZRe52ysiNzcHlLx+vq6111LoN1WAT7GT7l9n+Iw7j014WwOY8nABCfVm
         hHkvzx1eMEWGwYacgN2ss4Y+oNPiowdcjeANH+693nkUYttiwZkaDtwgyRCtz6EBJtJH
         q9PiFSiLHMb3d7SCpM06no3YDCM2A2oLg1p95kOoBD2AkIO2q599F0XR9OLjtiudTxLn
         sR6wVRmAopnO7KGtuSj9H5iagNpapOTgOnsKdkg1NiRYgswun5nz9lDa7YffBcQlB0KH
         kmB+oMzDdtMr1/QeDOg3g8Zqiatn7MkmTx85deY2flZIYM1MPxojblpVr1fzdh2moE8p
         fjfg==
X-Forwarded-Encrypted: i=1; AJvYcCUGT6dVexmK78wfkzf39AJIHuO5Xm48K6ypcPrpQBO9NrpcVcxFS74LQsumZOTpNrsmaPcCVmm/0iBmQ+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2zMWhBxmVGrJWu8yddze+xONzX+crlVklHeAinxxzOdohhNu
	s+HvW8Bg804zOSm8afqS0e4mzy/nYrn305UvDaTENqsFEBx/K63BkACVaDFXfDHEVi84bFDYZvG
	PauqfRzQi
X-Google-Smtp-Source: AGHT+IHKSrqSq31ICSQXXKKaZjDLG3cawrFG5g1v+7iLBFT2U5yOgUgrXrTyro+FOIcaeKsHyqZNWPF5+0Q6TA==
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:2fa:15aa:4d1e])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c94d:b0:216:3d72:1712 with SMTP id d9443c01a7336-221a118cc5emr167376045ad.48.1740323991538;
 Sun, 23 Feb 2025 07:19:51 -0800 (PST)
Date: Sun, 23 Feb 2025 07:19:49 -0800
In-Reply-To: <20250220170409.42cce424@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220170409.42cce424@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250223151949.1886080-1-krakauer@google.com>
Subject: [PATCH] selftests/net: deflake GRO tests and fix return value and output
From: Kevin Krakauer <krakauer@google.com>
To: kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	krakauer@google.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review! I'll split this up. Do you think it's better as two
patchsets -- one for stability/deflaking, one for return value and output
cleanup -- or as a single patchset with several commits?

> To be clear - are you running this over veth or a real device?

Over a veth.

>> Set the device's napi_defer_hard_irqs to 50 so that GRO is less likely
>> to immediately flush. This already happened in setup_loopback.sh, but
>> wasn't added to setup_veth.sh. This accounts for most of the reduction
>> in flakiness.
>
>That doesn't make intuitive sense to me. If we already defer flushes
>why do we need to also defer IRQs?

Yep, the behavior here is weird. I ran `gro.sh -t large` 1000 times with each of
the following setups (all inside strace to increase flakiness):

- gro_flush_timeout=1ms, napi_defer_hard_irqs=0  --> failed to GRO 29 times
- gro_flush_timeout=5ms, napi_defer_hard_irqs=0  --> failed to GRO 45 times
- gro_flush_timeout=50ms, napi_defer_hard_irqs=0 --> failed to GRO 35 times
- gro_flush_timeout=1ms, napi_defer_hard_irqs=1  --> failed to GRO 0 times
- gro_flush_timeout=1ms, napi_defer_hard_irqs=50 --> failed to GRO 0 times

napi_defer_hard_irqs is clearly having an effect. And deferring once is enough.
I believe that deferring IRQs prevents anything else from causing a GRO flush
before gro_flush_timeout expires. While waiting for the timeout to expire, an
incoming packet can cause napi_complete_done and thus napi_gro_flush to run.
Outgoing packets from the veth can also cause this: veth_xmit calls
__veth_xdp_flush, which only actually does anything when IRQs are enabled.

So napi_defer_hard_irqs=1 seems sufficient to allow the full gro_flush_timeout
to expire before flushing GRO.

