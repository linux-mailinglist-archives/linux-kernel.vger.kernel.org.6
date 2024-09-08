Return-Path: <linux-kernel+bounces-320323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98399708DB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969BE281D61
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142A22746D;
	Sun,  8 Sep 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RSeJHGM4"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41976132111
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725814993; cv=none; b=mHECIv8vW5K28J08spIW2IQ1gzPK2mFP1fPhxJ5+EKfit9nmvNe4s/F907o8JkHqzmhRkyEPRioMEvcRt9z0t9XOcuo9mhdvQDVvf+9O1+LdoldfVY5EeQhX6586X2zuV7Y7RonNf3fn3IU4+KxvsTmVhBVpjSjlSh+Kc54bBTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725814993; c=relaxed/simple;
	bh=M6hOX6d67g/sHrbUEKNZOlyXGlA5MldEKz/S1CCvNOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EY5waUmbNiqC6KRjuUyWr/V5FRVMKGvHL+Gg1vYoc8d6/tLsgQduxzo85tm+yGoR4ORdZd/oxF+8b2MhF4oEsZNKzTwLfRgEZHKDQv+uObQjyLxkaNMTSlfpH6LIuNSzpiSf4Uwmp8A2lPHScTs3s3XtUp4UX5+NfT8oszkMEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RSeJHGM4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-717849c0dcaso3170377b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725814990; x=1726419790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfYf9qgMs/s/Cf29/MVQd3LQ6tknsxRcEwEDS7AwwRE=;
        b=RSeJHGM4VQttQCzEtYoOZ+PxnycBpCobU63tLfQZ6tDDj9Fju0LAWJaoXIR8mG0f0k
         xqYCcrAMiWuetW5hPtUJNdJTLaZ9OJFsZwiYN933cEkVQdFdW4Ho8kin7i2F5Mzpk7BQ
         zvpJbvtMIVQughZqU+bo+cjCAuZJC7eUiqQT9e6LcfYhmj5CC7JcRHR4sCoLyxSQ3Aav
         HhjWcyja5/wKBA9fFlSkltoazPXaINk5Qserl3EQfA8ee54WyvM+KDR3V1lIqnRWfXZ8
         We9TEaPprF6jWLRE/xjDqNEFq1lz1NbtYwjs0WMUQyqy9k3b5VJnh+BSqmSG4xSVzWDe
         67oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725814990; x=1726419790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfYf9qgMs/s/Cf29/MVQd3LQ6tknsxRcEwEDS7AwwRE=;
        b=H5qhRHITHF5+wn/X3mOBdwvn45paE4eAJUJRsUOF4xkbUk82j7z4IqgC9h6McW/UsP
         srQbaQnN0nsQ6WzjZbZmvLdYtAbai1y/DA6sTjyfGUAuP0puG0XaUoOCN/tQcPqOHhmv
         Vd2PIzzL/iOmdr9lmdlMf71j+tEWvbLtQI4UWGxevdSxx/ix+Ow90daHMoE9JaMMYxOS
         25iMHnCtxY0FLSI535Tnowoc+jSlS851utx8AvgdRNyI8o4EkQY+ndRsf24hwV5LmlCV
         iEtl4FjBtvYP5Axl9oVrWVMRYRKh6tNmPbFUAXIaauWemjP4o67MNnDJdyzZCFpHb3wD
         rz+A==
X-Forwarded-Encrypted: i=1; AJvYcCX7IYZz353y+rH8sKzrv+ORWozdXLmZeNcF4WA2/J9FL7XzcMRNgpUyKVr6AlKfpGkWrPUt8lmx4V/qQQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHxD/Yv6FxQStMoGWyCUqcDvVBba9S/9/zZjyXpuuV8VYgUs2+
	9zAKdTBxegVaLF7YQA5f4XW2F7Zd0Wz9kdDb9EYLvO3fBTYoqVZ4b59EqT4jQkM=
X-Google-Smtp-Source: AGHT+IEboSXi6Gg5AQgJ6R2dG81rS4lvAyKMHkl5m3fSbPs9p/sQnX3Y4+or6QEHsu48LyxGweVUzQ==
X-Received: by 2002:a05:6a00:a29:b0:717:85d4:939c with SMTP id d2e1a72fcca58-718d5f52c04mr12201175b3a.23.1725814990529;
        Sun, 08 Sep 2024 10:03:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c1f15sm2240605b3a.76.2024.09.08.10.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 10:03:09 -0700 (PDT)
Message-ID: <fa31473a-39ab-4605-9966-90800ddd84a9@kernel.dk>
Date: Sun, 8 Sep 2024 11:03:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block and io_uring: typo fixes
To: CPestka <constantin.pestka@c-pestka.de>
Cc: asml.silence@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20240908164723.36468-1-constantin.pestka@c-pestka.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240908164723.36468-1-constantin.pestka@c-pestka.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

1) Don't combine patches for separate trees into one patch
2) Both cancellation and cancelation are correct spellings, io_uring has
used the latter since the start.

-- 
Jens Axboe


