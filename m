Return-Path: <linux-kernel+bounces-431630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7394C9E3FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E533B3686C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5586F1F16B;
	Wed,  4 Dec 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3ChaW2Nl"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C823BB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329813; cv=none; b=iYlBDXgJVnZ+iJGx1jR0ncMNFOYqJXlFgJ8O5xU/rpqoghBSC7uOUYmb1i/oJLHmAj5GYr91w+mtWBsUz023x4FkvSZj7S8Y8JDrgudN/KMIJ0OsFtyaXmP8GQpnrkepa8wa85/iAjidh40lkY2qCSUkL3n+UBG0CLoCrqfWt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329813; c=relaxed/simple;
	bh=urV50fFEUHAz7GM7OFQy5uUFQN9WNAvDHF0Hycp7gek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RcaaObxDQKs2cbUWYyIXamGLFFgp2gMXxw7757fujnaFwvjvfvF2hLz8//Zb13LXnZbtTAiJaK3xszlWRbmT26oGix+R4UvayJm3w133rTuPl0MVdN7ZjyTxFPTBVytUKdSgXrhcAZGd0GllFsA/kntGzu3i51EJDI8sAMaJ5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3ChaW2Nl; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fbc1ca1046so6518667a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733329811; x=1733934611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2GY+PBovLSxAEtnaJXWzOG8+IlUvACJXHa/cfec7e4=;
        b=3ChaW2Nl9CBWAworIVpwAO/fK3rqhdbKiMYra/4db3lLCfVrOW/sRsvGgQVOQd9bi4
         j4eNs2yW9gFib8so8glHrhucNebBxjCntLXAYnoXue0Nookcns3+7e84trNTineqbT2j
         SUU3nhWmXUMJtKHwdA2QNCDCVrYLMhcc7HCJjL7WTBUTrgpoOtGp6El6n1xCPZ/OIVPW
         xTfT+cd7M/8yRK0Au5PBFyI7S2NdOl5SR9D3ndM02S1MOk47CuLqNwbZ5iNP9H2uu3+x
         tIqCDWKckXwiCRG/3lG7ykwrfDZd7h7Vd9pZqIs3f9Qg4jxgqG+3r01RN20jP1H3lq8I
         BkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733329811; x=1733934611;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2GY+PBovLSxAEtnaJXWzOG8+IlUvACJXHa/cfec7e4=;
        b=TNuAggHHaAGpj7FAjIPKfN2BKzS9E9FLlv7KHmdZyeEdIIj2VVP+kIwVbg22dI0guP
         QQlKQbwZ2llZscspohoovgZJ4NifTtc2t4kxg3qeIFIoWsLf2M6i+IIC1WKm8gmA1olD
         mpVb9Es33rdRjv00v/K+E2b9BRDq1/hXpGGdUKKz5MVTBq09NjJzlogPn5JMqJytA6a0
         BXKYzx1OF2943bdeuoYmn/+QvXzmXFx/Hp81sugnEGShH7qVeF75pSP0Fs/7NJePNox2
         VKfeJJ5ndtA0OkD5kK9RJuP4zZh/cfsKUDpCArqJN4AVdRspke4U3yGGlZ157qURSwTH
         F9og==
X-Forwarded-Encrypted: i=1; AJvYcCXJLjGGsuJVxIXcnQczHLIebiJSOtmY1Vzs+M1IswqTNQy1mzjbyghKbojXN/CARegBM0xrLu1N4Mk4mQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyImjcubQn53grOxG+0E8pz62pNXI3aFXjnCI4cjmDQXHnb15R+
	GSQwAwPOo9W9s4fRrOcDDyJE2XGb1AcjnRnqn4xk71qdkkZH2UdwzaT5HsAE0cDMl53S4vnpV7r
	O
X-Gm-Gg: ASbGnctw02qfkKeiN1Zb+TKrscY3KlnwKPGRZazs82INcYyHC4DohMPxw580MgrQ49C
	0sIC0D6aje0ev4JG2VYFp2pB+Kw0LD16ctQ2AeIGO4CPU1LK1h9FqJjXPFaR4c5ZOOAYanU8DyS
	hMJ9nH/uZbYnTB5U4yhPcY2COwJDKkbeaz+75Z3ui9+a1uJS/CtYAhQyrQ/rRAxzbESDO9F5LOk
	bHGHX1TS7vHebQILkfYEaxSfj1il0PJDAq4yi6uiIbwwMxqIfv1Qa7cPg==
X-Google-Smtp-Source: AGHT+IEfC5rJtR5hn5JJzshNrMRsGI4JAytGlAB4t9Cm7+Jzl3qzEVcKLAtbVHjx1MYWcxrU8TkD5g==
X-Received: by 2002:a17:90b:380c:b0:2ee:ab29:1482 with SMTP id 98e67ed59e1d1-2ef011ff673mr11676098a91.16.1733329811270;
        Wed, 04 Dec 2024 08:30:11 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700aa25sm1623877a91.16.2024.12.04.08.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:30:10 -0800 (PST)
Message-ID: <916e2d95-0715-4b63-a5b1-a4d586342368@kernel.dk>
Date: Wed, 4 Dec 2024 09:30:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: null-ptr-deref Write in
 sys_io_uring_register
To: syzbot <syzbot+092bbab7da235a02a03a@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67505f88.050a0220.17bd51.0069.GAE@google.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <67505f88.050a0220.17bd51.0069.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz set subsystems: mm

-- 
Jens Axboe

