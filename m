Return-Path: <linux-kernel+bounces-404288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B139C41F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0DE2875FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E31A1A707A;
	Mon, 11 Nov 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QdiEfuVK"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06981A4F2D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339208; cv=none; b=Km8zBWhAO77Wv4YJg5aRFDik8nKIek12OPY68Hwx5uRUZf+m20+lYR1r0OTaQNmXlAXY5hwYu/thyT4rtDkSQ1MFjUUgOU155rVQkmr9/7vuBaAsCsbH17RCWdtRsQCG5v0Tt3i045fo4HmaKwc59GNUYEEHWqJzn41+YBwLsiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339208; c=relaxed/simple;
	bh=mnmWnMJ1p65+ROrZL1pP1XarnnoqZCK4RycEKhUHhV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3CS6IpykWfSKYYwiQ4Lkp4oxtSxRPblo3TEtGlhh1G0UGcd0WnHizcEcyUK0SL/44+Stlw6bVEMsAqkH1WQutW0UyMALedotVx9Dn5LjV8heUQFlz3+/SJ40+4Jlr3JhtzpfA0uTEMKLZ+4yCAP1gwztMd45bdn/NWVZrsUppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QdiEfuVK; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ebc0dbc566so2079853eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731339206; x=1731944006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSaM3wD2yHDEqpYEy+uQ9GLYH+06AGIhh2KoDFmh1b4=;
        b=QdiEfuVKGKxKpBXrJa5QHvIlZ7YCNHXZK0JnS3hKYUCd51QyxI47HOWZ3vO0Ez/Y4m
         l8jQj7Z+OEwDTz8aD8CGYfENuT5mC1GcUOUSmCbrz9vh/6aQhuIHvTpUsdWua9DQIjNO
         zk+JtoLlbZATgaGjKlaEEsPXd7KiNAxJT5HzeSkFCeTG2O8/ddx+MPf0A+XvXY51myKs
         pszXsN7+eAUcp3fESi8jW9WHrwnxJvNoL9+nFzOC4obs0mpfzeK3i4dA/pMuwo6J+muc
         K7QZZL31LQTbq/SiMKGAerLssvxOoqqk4wcS+djfYXuY12fgQ64LtNTjS1FyaO231L0O
         VsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731339206; x=1731944006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSaM3wD2yHDEqpYEy+uQ9GLYH+06AGIhh2KoDFmh1b4=;
        b=QtKkLGsfSLtEliusAq5S+v1WRnMvnDCqSfzBQGAD2qnwmFYP5ZpZroxZnFhw9Jo0Pb
         tbLCLB5xtNJubLvwa1mdHYB2HS+s6hiHDJYxf3vlzBl2c+t5KTQmEa4HdI+Vnj6RL30N
         T8k2v1KvhB1xEIK3R5TDYCRiBJG3l3tD9rD4STGwz5y38SigbJPTqorDaI6lvah6bK+7
         hINmXfdhA072r7tUzHm+S3XAOKjJBulLwukCTafQB5cWTR6/1tB13qzKT/TWnNNvOY9D
         xuPtWlkIkfoGNUOYLecXmZUPjXIj7qRrvHeVpVfUqln4hGdrJeR+5+k8aHfMDI+hltHG
         gZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU910loFf+5lKGUddDdLQATprnlRiSik3fvMTn6/1ZJaxPtXt6V0xvJRwPDBhZxq41i45cPq155cmtPV8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSUsbpGOuP3MPeRBRnB8UT9t5c0WUlAKZit+kk/ZD/A4qpFuvB
	GU3BlNjXKWD+X1NigkU3bx3JBNoz1LGtRu1DNW0t+c3KLrIBBL74p2vIolYNdlA=
X-Google-Smtp-Source: AGHT+IGI9EjfZdnRZtFdgai/ir9v+B+TPb4TBp4lHo4tksL4P6xYiI/klVnCx6NqSUT0kiU02IEfUg==
X-Received: by 2002:a05:6820:1b08:b0:5ee:a5b:d172 with SMTP id 006d021491bc7-5ee57c530cdmr8504966eaf.5.1731339205969;
        Mon, 11 Nov 2024 07:33:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee49527772sm1970810eaf.22.2024.11.11.07.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:33:25 -0800 (PST)
Message-ID: <eadbda9d-9e24-44c0-b157-02989403e048@kernel.dk>
Date: Mon, 11 Nov 2024 08:33:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] xfs: flag as supporting FOP_UNCACHED
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-16-axboe@kernel.dk> <ZzIidGR2FDChtCAu@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzIidGR2FDChtCAu@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 8:27 AM, Christoph Hellwig wrote:
> On Sun, Nov 10, 2024 at 08:28:07AM -0700, Jens Axboe wrote:
>> Read side was already fully supported, for the write side all that's
>> needed now is calling generic_uncached_write() when uncached writes
>> have been submitted. With that, enable the use of RWF_UNCACHED with XFS
>> by flagging support with FOP_UNCACHED.
> 
> It also might make sense to default to RWF_UNCACHED for the direct to
> buffered I/O fallback for sub-block size writes to reflink files.

It very well may make sense, but that's probably something the fs folks
should add after the fact.

> Also for the next round you probably want to add the xfs and ext4
> lists.

Oh for sure, I deliberately didn't do the ext4/xfs folks just yet as I
want to iron out the main bits first. And hopefully get those sorted and
acked first, then move on to a separate xfs and ext4 set of patches. I
also did btrfs in the most recent version, but that'll be a separate
thing too. Just kept it as one big series for now with more limited
scope, so folks can actually test this if they want to, without needing
multiple series of patches.

-- 
Jens Axboe

