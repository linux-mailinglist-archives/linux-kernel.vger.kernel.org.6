Return-Path: <linux-kernel+bounces-431826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A249E41D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5641624FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501A21C3BE0;
	Wed,  4 Dec 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GpY+XFKl"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C91C3BE2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332135; cv=none; b=Nm1Sf+SftLRBXj8LoQ4SCEk0AvsVZawe3ntmNtCVz2h0aG9bCXnE2bzC3hJqnHjO8plTftTI+75Pqt0JeEkyzYzGsD2QRpTk4Cp7mgjtu5BCXMvjIZiMAd6UVDsXYHSR/q5YTUMK7KgZejZt7wo/X6IilGsep2TTlVqBNHpKHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332135; c=relaxed/simple;
	bh=5gCPZVrrifqnSFAQWHbs+OifVGQuIbzw/66LkaDUaWg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CEH4D06vUQtJgZHfgFjpUxk2hwGGM6jGXxdbR0N+q5wSzqo0Ey6jFoKwHNAo9AsLbNju0+kwldLMdnAuoxYN1ybc1cVLz2rdcK4xs1+8Zf174megYoq7WmYRLkzXAEC8MKvw04O+lREN4lSYKH0Jer01uw9pJosi+DofQBjkslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GpY+XFKl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724e6c53fe2so34894b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733332134; x=1733936934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nili2EeXhBBnCR9E7SrWkjme6AdYdFkZANnDcpM0kP4=;
        b=GpY+XFKlZNrV3hUUZGDIaXqUfM4WonHUI5bCYdmZwWEDR8S62d8geDp6dIAqnw8XNF
         J0e0MDGPUh/D6JNSfxPrEEmuFQVObYTBM3SkN05xdpwmxdD/vh07vraA7RQkRGe8j5g+
         y786XWszefTJVdCHTW1K1ONTjPWTYdXR1akRogvlbQnOCNCNP81ah7cN/Tm/gDYtI+8J
         TRBNeIcOIJ4OpQgN6ldvsb6ZSyV8wVcvzizgmicXYvov3JiXNS3AEihrqsIfAuppPBbr
         PU6U2advuXR8TQPK1Qiy5lzlIJfgrR2XfVgmyY0EGCo5QXE3uLRznn86ezyJRyKKK+Cc
         1hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332134; x=1733936934;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nili2EeXhBBnCR9E7SrWkjme6AdYdFkZANnDcpM0kP4=;
        b=BMB0SNSzzatsfdo58DE5iqMqA4XPvaJLUF30czsrkenps2z/laiUeRH/5GeyHfw4ch
         CRwLZ36hC6cZqCCiQ6OWaMzEFQmB/TPwfvuJnIz6JRC9Z+W7txD93oi48DI7WUElMrCF
         joJHXqTNCom/xj13uHN2KvZbMWWr5GPPGaj5tvhwDjG6jIF4n/B6iwZrrQKvm0ZAnkel
         cCwZJ6Lwr7/7ex/P6hwlATeiIQfZnyLdvXulzW1AdS4dPaoISntcVq3JhWGGOwLTa/oO
         K8ccPYGGI2zBDeEnZGjTCVSYN4F1GobiWs2wdNNHbC4H+thAnIoWcemni6f7emviWO8L
         0srg==
X-Forwarded-Encrypted: i=1; AJvYcCUy16XneLpxDdAHHB7ua7cMKYUIcDZGf/IJuow+Cq1cyUc8IQULUHTqS8sRJC8rg6IvBuprMZRadnE6g3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV1R1HjvT0X1gHZFmTaV3mwxddO7SaY79QKlkWNU/trNrBt9lN
	VpaWa2s84YqQ0OZYpnJxJIRJVlJn4tGalLcz/8BTUMmoZ8VTr3MruE6WAwGmtpA=
X-Gm-Gg: ASbGncuJ0NvpmU9pkafNE847ABqdiRvbQcl0ZCFbkb4DDhzQm4RE3SmJeNzy3oyvxiP
	YUCrYm7Ekns1G5XS7L9bQNuSm+my4szosDvLe6kPLIWjstL8YJF9fk+QlJk7jdrmpY3NjAeFpPb
	SWFx9sa8JgWRj6Qlt088JMo0LSSZD8DsKv3TVkqGSAb1K0BYxgPDT2EWDcFsZS+iFO+DXu9TWQt
	J15Xj05O9LluV1cx3jwcAjhE8EW/00fA5fSz5uruyp9NBsCm3wmLcwMWg==
X-Google-Smtp-Source: AGHT+IE/dcKUbzDldznX90U6aZ3I9fPcXtLjv21sHTghzH/vPO7ZipqAKTafj4KlAoSHYtxs5LKwZg==
X-Received: by 2002:a05:6a00:3d52:b0:724:f1c7:dfbb with SMTP id d2e1a72fcca58-72587f00457mr7404358b3a.7.1733332133692;
        Wed, 04 Dec 2024 09:08:53 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254180fcb0sm12954875b3a.147.2024.12.04.09.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 09:08:53 -0800 (PST)
Message-ID: <61930195-ef48-4ce0-b1e1-f3a8a0a7fc30@kernel.dk>
Date: Wed, 4 Dec 2024 10:08:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [io-uring?] general protection fault in
 io_uring_show_fdinfo (2)
To: syzbot <syzbot+6cb1e1ecb22a749ef8e8@syzkaller.appspotmail.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67251dc5.050a0220.529b6.015d.GAE@google.com>
 <67255272.050a0220.35b515.017b.GAE@google.com>
Content-Language: en-US
In-Reply-To: <67255272.050a0220.35b515.017b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: io_uring/rsrc: get rid of the empty node and dummy_ubuf

-- 
Jens Axboe


