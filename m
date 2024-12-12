Return-Path: <linux-kernel+bounces-443204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A569EE8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D8B166672
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C112153C3;
	Thu, 12 Dec 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C25E5S3P"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56184D02
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013717; cv=none; b=bHNpLh9WdMmi6/JGiB+nJZUaaQXEUwLA6inIrB2qrWFtFl/Q7htlOIL4zp0w9oG/9SJ5+6tJe6DvtZu5CiU/rUiBIU32c5LUCgqrku33chevJUua2F9+5Y9miZr7cL4qsQssfvqbYH+gdWOCbSI57xmSc4DZAA1i0OieJOAkjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013717; c=relaxed/simple;
	bh=NTvAln/IDG7xjORAFo53OF9UnbmAqt+wQ/HWM4jEFy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6f1Hl2ap8fNpgPU7cDcBluKtSzmF7DJzZBnBGRYE38rTfsSJNMrAzY3cNIEPFaFDpu6GiPbj1/nDzXd96oeKFM7YLY34en7OfQ9RGZp/hRY3nPWUOGk6w3xsYQygwmkk2lEXeWBwS3UG4mMi83UkeV19tl8rF/efLUUDzUSrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C25E5S3P; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844d67eb693so50215339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734013713; x=1734618513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfT3X0hae33k9lYMBuaLlSL6M/DETLFxdAGxRb+Okr8=;
        b=C25E5S3PzR4C7mwPPUfAZxsCKHc5fXivB2GfIzFbVq0cptfamjojE2GjTMu4/IOMQq
         8GP9lWSfpXAqc7sIkRGKED7OuxOk7QNmlwT4BGW2Yn01s8ChjKXpEn0WYqNAHnSuFhGm
         1gohqiwedMOgcKmtjHH9oMrSvldeujktTUsbdzMsQn9sC3ilE5X5pt1rpENNgjyjkodt
         dA1y4M0PEL18tkqrPRAA5YpSmCRPESRpjg+y1eUKY4bsAVECDqNtd+P2u47GdNv5V13p
         37GxWBv6rTPkRUKdH1cqsZx5j6pDAiYLBJvHzJGd4dc1GruQz2TtRHyz2J0q5mcLhQDX
         lJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734013713; x=1734618513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfT3X0hae33k9lYMBuaLlSL6M/DETLFxdAGxRb+Okr8=;
        b=kP5dZT+rZGiBD343rj84GMOmjOQkrDYeBdxIcTX9nZndhTKMtLiuXcKHP/8SME3g20
         Qi2QTFCXFjyE2Qu6qdqebVsT/UEiij/Re+UnzaGz+HTXev7AYrd8hRNZEQbySrNcaQMp
         +dbFUJDCRzBtm/hqhXyI4I8A6TdPn+JKWleFqM7goHmwtQJGbIuq4DcH5XbUEY4U947V
         7LQO2r9KRdvvn7oThKlVwZx2zitS2KiAzePZ0qa6am/EPabc9Uz3GVFZLDv8tudTYF9S
         3eXHu73s5LHAtG35LhZl03EK4e2k5s9qc6F4SHXCtA/gICWmiggkU+TZ8pjZdpjzGsPU
         glNw==
X-Forwarded-Encrypted: i=1; AJvYcCUlHOecvU7rwf05wQbtQYvq014gir1XKCl4S9ZbBlNcT66dezXkLpxltP/ZXNtnCiAjOd7CuAo32oAx5hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMI/fQc4NEUSO7ONmoxIe0S4U3uGvkWXtAXoNDskNn2pUl1HER
	pi94ZO7sei2Xis8IW8ITTdIUN/yoAoN8Pcr2j3P/KVBxxiPZSqQpbqvwDudOgQg=
X-Gm-Gg: ASbGncvVqmNc5+SCpC02/1jMgnGBFuUCXwKjf3+yK4XrOsA2S/LwMcQ1fypVNXxgmLv
	ut8e1R5D4rqPprW20H8n7+1d5EFSH1A1gj9aXoP5hGUmzyLqDdJyWAevJt2fd0biMAXpXZGMouN
	bZFbv0i5PFvtNO7+SfPqo1JJCkvkLVUy4lEbzCmew6BbHYdUE0DtmGvxSohm7nqjLxkOmZbvVoa
	q8LBWvMjzxysLlCLHTAuGtSDZ/mCfYCkeaoyfXaHPTVRym0yEWD
X-Google-Smtp-Source: AGHT+IEo716tZ/bf64k/pM3NNqQqr3GtHvW/buaqDLTjPaaZqAyM21XkFM8J+8Oq4OWE5W1X/+IKww==
X-Received: by 2002:a05:6602:6b06:b0:842:ef83:d3cf with SMTP id ca18e2360f4ac-844e56ac550mr38232639f.11.1734013713655;
        Thu, 12 Dec 2024 06:28:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844d3d47507sm65658939f.27.2024.12.12.06.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 06:28:32 -0800 (PST)
Message-ID: <f1f0be9c-b66c-4444-a63b-6bae05219944@kernel.dk>
Date: Thu, 12 Dec 2024 07:28:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deadlock in __wake_up_common_lock
To: chase xd <sl1589472800@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CADZouDRFJ9jtXHqkX-PTKeT=GxSwdMC42zEsAKR34psuG9tUMQ@mail.gmail.com>
 <1a779207-4fa8-4b8e-95d7-e0568791e6ac@kernel.dk>
 <CADZouDQEe6gZgobLOAR+oy1u+Xjc4js=KW164n0ha7Yv+gma=g@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADZouDQEe6gZgobLOAR+oy1u+Xjc4js=KW164n0ha7Yv+gma=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 4:46 AM, chase xd wrote:
> Hi, the same payload triggers another deadlock scene with the fix:

Looks like the same thing, are you sure you have the patch in that
kernel?

-- 
Jens Axboe


