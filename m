Return-Path: <linux-kernel+bounces-422963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1C29DA085
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0EBB23A90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D731BC20;
	Wed, 27 Nov 2024 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J+RhvD3J"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4EA8C07
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732673029; cv=none; b=tpHHlXF3j1tjfNA6SO/lIvtkhyhgBCmvn/baT95rhAlSVjCBvsRLnDO+RxTeLpGBpc4tRJ06iMLFQdEtza9Av3XFojuD+IGz+entOSnsMKhA+WyHI1UhGDbTYeAS4u5vx7Pz2Uc+tk2kqhQuS7xS+cmaZz/+A/pV5SqGEVPoQxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732673029; c=relaxed/simple;
	bh=wChJNgnYzcMtCDzPZ10Pu9wcJNKgLEuOvX6x66cMhvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAcuLJ4rU3IwlTTeNTzM7MIe4Ls3P+LMK/JK2L+g/1gb3r3wWwL5+uatMvrKEWJqbF5HCWt+qWqh83kfIuHpdQDByHzH85eMH7NQkEjzeJrMTmzhwsPeithmRnrr7/rHMfdrm7mWI5pJtqzZ4qfdJC4X9CZ552B4ojFZjr1QPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J+RhvD3J; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fbc1ca1046so5011161a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732673025; x=1733277825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgG9DBEACJ4jXE8eCHPkHJXxlu/6sH+zgOA50ZjDxpQ=;
        b=J+RhvD3JURbx1Mf2KrkgGJjED5xjn+/pe3Q9gR+I2I/INfN3ilsscLaC86lI1QmpSH
         HKeDW4CSznJsT20963E66jmUbkQIdB+X/GP+YZmaDv/NiWhdPkvIGxAb2URbi5wIwnBy
         beLXqhvNS2Dt2Xu7sKuCFlWuDi/nhqck1bdrj4V04KvpwIn/RCjd5dcEGy42g3a8FXf3
         zQtzsLGT+99bmXHZlBu83AfKmEg2dUjEas/PlNre4rt7rIMRoSSU6LxkUh3ki6/GOoEk
         ZqrcLnkR0wE5bicxJVslnkxi6b8i8f2lImF3ulnxtYqkLzL/ffK/PYV6/bwyK1H3HOfL
         xk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732673025; x=1733277825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgG9DBEACJ4jXE8eCHPkHJXxlu/6sH+zgOA50ZjDxpQ=;
        b=cvJdTRIdvsjzmB7oQkxPKpuJQk2pyqeYKAjKLH23ACkBAlB3O0Z2FGzKopbWOWN791
         jSL6SKheeU+gQIkegc8/Q9vOTgNmuD32ZR6i/OBToMMnuXNl/XmPDltIr9RYhZDMgIgJ
         CmJ8upnaSNqiXa+ib+uw57fsralzHfGsR8h0BA2kIpwOfILdSBs0MUceLpRRi7aAuTrr
         4HPAqc0QqTjM6DTQpPVUBdIismMpWEgasPg8jNqLXU2Rnqi6Y6w/hlR4RbCljMD6HLDJ
         ZqpgTE+rwiADTauYa/LV4XpNNyZVUTRXaTMwH3updmWAKvutveNrcjpl7qWn3mftDuaa
         WTbA==
X-Forwarded-Encrypted: i=1; AJvYcCUHylwiDgW6ybUUr9UcpAg6JnXkqGJv/htRj1Ye3zQdWWJfK+3vpmRVYlWqYQot109J8ifTrLLlz3Atoaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa7a5/Fnl55Y+wWdZfcanFocLb6wNoiRs1YREWYDrfIg2LOIPz
	hVYMzRZbwF6yRedvI8jcQ/kUZcx8v3gax7J6Q3G8sdiimJCOct6zSNDVeVpMp7s=
X-Gm-Gg: ASbGncspRHqZU9ugDi+j3EhbDrZ6OHY2l5Gy/eunJAJWC7gGd3bErnIBp6qPvCD//ug
	5q23naQ4VQP+EDTctMxTJW0VyVM+QBvyFIL7ADAjbSi5NaIR9iiscNJSV/MLpxg3zQ6Nrg4eCTM
	hqRvUrCoi/OMs1GzJlhjACGIrA5zDT4bIYbgihKAizoThGCQQV7fV6GAoGAqs9va/qKq0uD4tnq
	8sGI4c/2xS1hz1sLMgId9Drirc17d/PpktFuZajvXozAiY=
X-Google-Smtp-Source: AGHT+IH/s1qE54l01GT1SxPBRt+mFsHrg7IMP012Fq+ehYF84sKVoo+lh3zfChf531i0E25gNfJ8hA==
X-Received: by 2002:a05:6a20:7485:b0:1db:e536:974b with SMTP id adf61e73a8af0-1e0e0b5d863mr2527580637.34.1732673025302;
        Tue, 26 Nov 2024 18:03:45 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454b41sm9073408b3a.32.2024.11.26.18.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 18:03:44 -0800 (PST)
Message-ID: <2f55f798-389d-41d7-ae16-f98f354c4ac1@kernel.dk>
Date: Tue, 26 Nov 2024 19:03:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/29] cred: rework {override,revert}_creds()
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/24 7:09 AM, Christian Brauner wrote:
> For the v6.13 cycle we switched overlayfs to a variant of
> override_creds() that doesn't take an extra reference. To this end I
> suggested introducing {override,revert}_creds_light() which overlayfs
> could use.
> 
> This seems to work rather well. This series follow Linus advice and
> unifies the separate helpers and simply makes {override,revert}_creds()
> do what {override,revert}_creds_light() currently does. Caller's that
> really need the extra reference count can take it manually.

Nice cleanup, looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


