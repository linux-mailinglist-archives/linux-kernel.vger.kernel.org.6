Return-Path: <linux-kernel+bounces-195855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744BC8D52E9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31651283E65
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFD774041;
	Thu, 30 May 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CJ2HtA/T"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F355880
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099816; cv=none; b=VyH5pItKGQ60cX8KcnhNhxNOoy9JC92oOL5v1zneRKX1p/cJUj/roU1iNKNbifw9q8vH5cH4b/Xn4rXwALilMsqlIgZVlbwkeXSZpwHScWTjYG6wt9sUcY2Nsk0EoUtNkHAqlKOFMxV+pK9hWRMsTZzWt5nVVJ3YUE1lBxXb/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099816; c=relaxed/simple;
	bh=1uhCyqyd6OfBJhLOomRnqKGxLhqaf3SVuyATwGnDEOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S3D3ieC5UnoYa9+5akaEdt5DhrZG3ugl66SpJ5yuo1bA7wwxD+iB04LXAbO/Iz+1CJtjonL92Gv/tJWsZH3uvYCGxavYaTgpdTWlEuolNoLPJRuxgTCWs9Rq+LKA8nC4fUdZA1r5HoLFHfkZ3MgYLUYesD5M3FR7WRj/uMTdJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CJ2HtA/T; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b97f09cde3so196208eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717099814; x=1717704614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zGOf4m18QTtHJvMQUoDQufLKLE25S3D0AAB4RUkeJfc=;
        b=CJ2HtA/TQbQLHoY6Q3Q2jSESKaN8LF7RG9OU5RJrawdojER2cxmfylj9Sgb/1tx+1E
         kQJq18HwPu15UOj72BE94UVY4NC7d+FMA5DJN3HEkLTLOzQN2bbK4sUM4TyVhgdgPZ2G
         koRe56afcmpSLjUmalD+HeuXlQMLQgxSmbuiZpiA/J2aY9j1Gf23er77EpU0o8dpeFVl
         cfmiNT2IsYZYUjHFg33fAC9pb/NcCBDz49d03j11rsbyn/srpCiVP8GeieBKhBDsMRVm
         WaYnNuiHgIkl7xbR9lg/hiaCaCzBBx8Jc5erOddawndf3pzNQP+qN4SvItUvqHYIb5P4
         KOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717099814; x=1717704614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGOf4m18QTtHJvMQUoDQufLKLE25S3D0AAB4RUkeJfc=;
        b=UnRO2bjSl08ollGTEMLzG38q6Dxdyraa9YGXhsY5/Ops72QfS2jdfeWmRC9DOgiioc
         Tj4aq2hyTt9ef0xbpI4uxa6sseIoKp+5RKFZBgeoOMPtwu3288c7XFJNaTXyoOVIPT6Y
         EKIVVquccAPfF8KvEKw35zch4HJX5LWE1gNgHtJw7eVLViTlMe0ocwFPUwt6x+LD+cLg
         ECUwy6JjQ4JrQjgVZ2pM9dszLRPVTH8DiX5uKduFIJ+p7BakPNa/tul9YGISknbizFM/
         laQ6kHnkaN2PdRe3NEwD81Ch7Rw6bHjgXB5zgod1xMcErqaPzRuyoAeNeCKVelj9RrL6
         fZWw==
X-Forwarded-Encrypted: i=1; AJvYcCVdyu9iweOAi6wADVyE+eEdq0+yPT0919vzToJfz9CGJHySU4gYSVN1Zy0M0SXmteolVcNLOHj1CuxwFRmTJNjI6H7jBBbjOXxGHCfZ
X-Gm-Message-State: AOJu0YzaScaUffJamK41xAWBQDnqPPgZlFEwH1JcND06Q+3wVAZCUK1X
	8LXN1FyC93QRaTU97hgtNthMQcSXSPR1pxyxNEQDl0RBHjZXxGVYIP9IqZuFdSuXrWdNnIvekT5
	f
X-Google-Smtp-Source: AGHT+IFxtfSha2bFV9Bllh6KjryMKTM6ysYjJaNmwUmfLWw/8WlLkOhLC3srNxELNjFhlNeK1I/WBA==
X-Received: by 2002:a05:6808:18a5:b0:3d1:d35b:8174 with SMTP id 5614622812f47-3d1dcca6715mr3424509b6e.2.1717099814399;
        Thu, 30 May 2024 13:10:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d1e1a4637esm74809b6e.36.2024.05.30.13.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 13:10:13 -0700 (PDT)
Message-ID: <ecb2472e-b505-42bf-8c02-66567d8c4277@kernel.dk>
Date: Thu, 30 May 2024 14:10:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_cqe_overflow
 (2)
To: syzbot <syzbot+97d8b31fbab9db1efe55@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000003870370618b861cc@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0000000000003870370618b861cc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz dup: [syzbot] [io-uring?] KMSAN: uninit-value in io_issue_sqe

-- 
Jens Axboe


