Return-Path: <linux-kernel+bounces-214181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0743690809D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9A3B213AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C2D1822DB;
	Fri, 14 Jun 2024 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Gw0dP4l8"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9C1A28C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718328518; cv=none; b=QRedBwIl9QiNNV1GLMlSDMZIHN87IatAw6YVqVfKrxQIg3oZDdDUUwOBwQejBv5e6hjC37VErZwPEXLIhOt4JXvI+So1gAfR9E0DJVOB9cTvk0MeND+3ZAmvbtD6IncSR+hyTgNEmfU4a5uxBXJIW4z3qnmG+GfJubB0iZF4YUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718328518; c=relaxed/simple;
	bh=kAy4QYm4P0wejOln0sjgpR597XHtlPQRJDoOhOcNk64=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B0DDR96sUvtmmldkoJ1yDtVgJsm1IO1WtP1b2KkTjC+f8IJwStNRdaijSrU0+GlHvKRyZayn5YqC6JKBTjdr4Zgiaw+2JQFMKNbl4ZWa5R9J77EKkRLysEVwbbDlNH4Lr/k94g6BW37uC5HF5KtC7UyIzNMB362rPujRya4GkMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Gw0dP4l8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-631702feb43so1435307b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718328514; x=1718933314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GIqw+lIrHlNp3Ja2na639L/jDhTu14FRyvhFXlStmiI=;
        b=Gw0dP4l8Nl0v/byNuQc38V7cIRCu8YPPR5D4nWR8VvySOBEP7UvcOtg2EHEHz+wG4a
         0D1HGnhuHnKEMBpMl02oP/NJ9Z3wDSq7oI4jPHQb2kF5lpvuYZ2qzEOWIro2GzGZdOes
         t4EsKzmpYoims1KFRPSQ3N5gZoiGsNN3whEeQtJwwEhdU5xOeqSvJlimPGawPQmg60QJ
         BpnZ3PI8skB9NhhXvDg+ETaFKe0G3KEfUwK+VoXkNzdLQ76IWg4VooAwfPwxMwZoD80Q
         qB1FACa1KBAYKXWhnlEplQ0LaZ9cLuH5hhzg8UvyyVy2Ex9PNqKyKNqT03mZNeIsZmSp
         Ibuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718328514; x=1718933314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIqw+lIrHlNp3Ja2na639L/jDhTu14FRyvhFXlStmiI=;
        b=BSKGaCbH1GwzdalzVe9ZMr/KTnIJDAGm9T9NM/VhDX4WHrqjdqDj+P3+Bd4TJ5CILn
         nnwLd1nV+jB2vU515IYOFc5MBHfHWagoWVV8mOOy4vYOGYqSJqjrxIU3lD3QHwufrWwR
         Ux2yohp7siTp+lOqB4Ulas7FSomhUbwQ1I9HALzdcel5PUHFOd+WJCTusFEBXWtiXtKL
         hIzDQwd8Fh73b4yWmV3TyDdS1JPaBNEl2yLcRwZu9Fgfz2VFjG0osMU5iLWrGDKQByHu
         /96Tg3vUFG3aeScez/FuZCnaE2Cr5nDqFTx1gDVuL3gojALqPz5QAmoebkXjI0e1iWrr
         6qXw==
X-Forwarded-Encrypted: i=1; AJvYcCXt+eL1KLDAELpGamD1swDOOdMllCJbefC9TIC83qsyuNWvbjuGuYEAb21iHkXvPMsYEEUFDSsNZfA6N8DEAbvRRJfNLQDO74twYscj
X-Gm-Message-State: AOJu0YyaRJb/FlLlp2UrmysOXCNBwSMDMScommdPAtMBQDxybKUurqie
	0yyvtcm+LBJcq0f9Ue6lB2WttV0cUIk4BvMpPMkT29STi1PlIl1y0sqOTaDMYOoiAkYEh5rewz9
	A
X-Google-Smtp-Source: AGHT+IHITEitzqsXprJFx4xSbyaEdkdTYCpN+vhffQWMpryu+R9ms/e5ru7TNT6qkEzhsp5v+kbFgQ==
X-Received: by 2002:a05:6a20:1584:b0:1af:cefe:dba3 with SMTP id adf61e73a8af0-1bae7b3d2c7mr1832253637.0.1718328493877;
        Thu, 13 Jun 2024 18:28:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f8575b119bsm20082135ad.27.2024.06.13.18.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 18:28:13 -0700 (PDT)
Message-ID: <6d0ab5f4-45d5-4e16-bd4d-ae14e29d5f32@kernel.dk>
Date: Thu, 13 Jun 2024 19:28:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_cqe_overflow
 (3)
To: syzbot <syzbot+e6616d0dc8ded5dc56d6@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000852fce061acaa456@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000852fce061acaa456@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/24 1:38 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12980e41980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
> dashboard link: https://syzkaller.appspot.com/bug?extid=e6616d0dc8ded5dc56d6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13526ca2980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144e5256980000

#syz test: git://git.kernel.dk/linux.git io_uring-6.10

-- 
Jens Axboe



