Return-Path: <linux-kernel+bounces-378042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BDC9ACA93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595DB284F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869AC1ADFE2;
	Wed, 23 Oct 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dO+uRDE9"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565A1AB50C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687896; cv=none; b=QG+2tRrBIxEyejLYiKvr0sBcqUZrZc4yZzC8kZFs06wp6UEpTcAl7NIHfof7FmeFIY15DbWhCmfvChw1sadOzJG6NIN/c1WTpDNAA0gEY/S9pmk3BqLNP5ZQ4hmEMPuxlxMGb4weUKH7lc0HNN6ARWuvPowfr/N87PXJ/Nbx5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687896; c=relaxed/simple;
	bh=TovBOQATkiwwKIxO4H3TUcSLMe8jpyrG3L3TRxI6sN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j8KwtXSdd7/ip7jrJCjo8wq3w6udrfYovNbbj/OyQVwLbvufWvusQKXK03rhTGH8MgWJtLNr8ULC7zFW/rTNzDtXsRbDEPGMqo8afn7JWDe/mSlrwMR9idrrhxMxb0sT10dHac/Rq3RqEnPJ+tDEzzOseDCOEJi40S5qRTCYDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dO+uRDE9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso779328466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1729687892; x=1730292692; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TovBOQATkiwwKIxO4H3TUcSLMe8jpyrG3L3TRxI6sN0=;
        b=dO+uRDE9xNiDQO7H7Reu+TWtK++ZdJ2olE1jOGob5rlsM9Oh0zgo/BGHl8jMxySy/C
         juDOeV/zGF0bt1/lRkKTiTkprgy61FLAOezhxALpTM2fjuOXIznwwIo4xTBl8Icyj0L+
         qd0f7sOWe6tFsVrZO4P4uXOccxBfxeOyfQJQVw84QJuBs8+I8IvZIWJ4JPbalsIMsVX/
         tM2G4jCoDzilRK0Ysb2r29sCIcJhKLxbmT8BymHo708NLHOMxk1tSIcSGJ6m4zMAeCGS
         1AC0LbEp3iUevvCp8E6pBvaTSHv70y7Gc572BquLp50mBLydcAAXxjveMRok4vg0yBSy
         4EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729687892; x=1730292692;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TovBOQATkiwwKIxO4H3TUcSLMe8jpyrG3L3TRxI6sN0=;
        b=RQC8Z5xTIh+DJjhVo3aKGlAE0Ep4BIQXyBKLquM8z8znC+j4d78jhpLuRs6oyNzSFf
         HKLtcDqflxcFkQ5NtmMP2tVyZmYqh/uIdCkhcwCuZ6aNMs4NZvqGHihxnUeBOpakgBvk
         YBGWB7JBtL1wX/Qi4v5dZM5JvcWbbShaNfXK9amhmC6M9bSnlyY+hzVipxGGk5jT6i/s
         BKFekL+j0oCAe5w5kUTFq+1t23iFkqLgTTlC1NzXeen1s9o8XzdkjnDz86gbQwOolDLI
         D0Ij90a83wg+qtrxArZLsGGx8w+I8PwTYRcYrnuR8Rb+zLPZv3mMFcgVC/K6rVryyDsH
         R69A==
X-Forwarded-Encrypted: i=1; AJvYcCXCRsdxxpYI7Putk5ig9hYNSqYPZ0AywNeqMweZjBjqU5mmtjYDojayBNw+k/sCE57+v/Q4B8SisV8U3B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2BmV7dla3cazInHDknv1sf52vpHOXOj4dY2CgS8DuevvAMrk
	whotTAubqzUes5nIFkpHoQhnO04klARQos2qsRigDPMgDwF1hzvER0vERHBtj6Y=
X-Google-Smtp-Source: AGHT+IHrjgt4Dkx3BECaxc7v3qZRq6Rtql9zV1QQu5ZkLvd+JW8V+GyN3sCO1/kMf+Iws8Ie9m0gSA==
X-Received: by 2002:a17:907:7b85:b0:a99:7676:ceb7 with SMTP id a640c23a62f3a-a9abf86e15emr233239366b.26.1729687892600;
        Wed, 23 Oct 2024 05:51:32 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6597sm486590666b.14.2024.10.23.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:51:31 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Ruan Bonan <bonan.ruan@u.nus.edu>
Cc: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
  "davem@davemloft.net" <davem@davemloft.net>,  "edumazet@google.com"
 <edumazet@google.com>,  "kuba@kernel.org" <kuba@kernel.org>,
  "pabeni@redhat.com" <pabeni@redhat.com>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: [BUG] general protection fault in sock_map_link_update_prog -
 Reproducible with Syzkaller
In-Reply-To: <TYZPR06MB680739AC616DD61587BE380AD94C2@TYZPR06MB6807.apcprd06.prod.outlook.com>
	(Ruan Bonan's message of "Tue, 22 Oct 2024 02:36:23 +0000")
References: <TYZPR06MB680739AC616DD61587BE380AD94C2@TYZPR06MB6807.apcprd06.prod.outlook.com>
Date: Wed, 23 Oct 2024 14:51:30 +0200
Message-ID: <877c9z9e3x.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 22, 2024 at 02:36 AM GMT, Ruan Bonan wrote:
> I used Syzkaller and found that there is KASAN: null-ptr-deref (general protection fault in
> sock_map_link_update_prog) in net/core/sock_map.c in v6.12.0-rc2, which also causes a KASAN:
> slab-use-after-free at the same time. It looks like a concurrency bug in the BPF related subsystems. The
> reproducer is available, and I have reproduced this bug with it manually. Currently I can only reproduce this
> bug with root privilege.
>
> The detailed reports, config file, and reproducer program are attached in this e-mail. If you need further
> details, please let me know.

Thanks for the report. I was also able to reproduce the KASAN splat with
the attached repro locally and will investigate futher.

I have a small ask - please use plain text for mailing the list in the
future - https://useplaintext.email/

-jkbs

