Return-Path: <linux-kernel+bounces-208811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871C890297A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4CAEB21BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA5714D714;
	Mon, 10 Jun 2024 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bQmTiaT+"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7580B249F5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048719; cv=none; b=g0tyI9PbLI61pU8l9buddyWNaSBRPIwrWJYEo5DW1aKsKPO50kCS4EDk2PfSGpJdgT+A9yTbFnHITZuII4MIuKDZhbqC0vdjIKp8GTDbvL6DYsqD8/Pc9Pi1WhOUZhsCbFSdWOI5KajNI4pqSTEb0xRu77YFBsY4T2IJLPpfo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048719; c=relaxed/simple;
	bh=Z/ZEvaF3KFgjd5MHXYaihpPfsdEuF6zzQDTgLvT2DVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGukj9JLaEkWvkcfTXlKRAfLS6HLRKappF5EjN9rzxFuCC+8u3m1fTbKn/nGuv3TRC6A16ieiUJTEo741T3bUagsX1TRMtryioYbbsDhG6cCRsaZA/4sIE+QOtYTgeF8JbpXmYKDfjY4oQo52NJaQLjW5c7pDF+j+Rp1TWHWB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bQmTiaT+; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a0849f5a8so47800217b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718048717; x=1718653517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QccgVaZ6eaw5+73TGONP2Yr3cHHuW9AgdrXa1DTFCc=;
        b=bQmTiaT+Fy303zsMjIfnl2BXHTS1Yt8n2+jWmrQkhIpT6AUKnr4VE4/xPz3XeuBBQ+
         e9Q/moU0OA3Hcvb9YOi7p5KALsg71U3C2VTDw7L3DUuk+DMBkLAt3Kgf22hADwl3hyoA
         TrV6D7hw4xRXSAGGRBxAXMM/wmYTjDeSADnHgd+UFtPH3fVhbnO+BwojjFfWg9LtuIjF
         b20z2sa0Huy0EztsmQRp+JwmMP9FMwGnov9hMzxZtxyFLpF9kQQoqSei7JPxA1stXTow
         4/xVlpV2Td6ls3SLBo06xk8zxayHv76ktIAeKDo4jpKn7oMHvmfMavRMYZ5tDgAsCPr2
         RJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718048717; x=1718653517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QccgVaZ6eaw5+73TGONP2Yr3cHHuW9AgdrXa1DTFCc=;
        b=paoEsv0CVYuUCt8kFgcpDXMGbbrwfMjGhGkwxMkDKd6vhlr+cqeYp3b9lTPu/67cl8
         kGQAfCUdH3f9GY+STsz03wCWqonJjsvXOyC/Q1MhfU9SztT8a93O6rSbiYEHkZYpp+bj
         1Qo2vurnhJ4zLtrVV7qtZIiUA/SqSMEZ6HlbfXrZhyNbuaq3KvaM6EtcA9C4vRlG2Wox
         EpUE5r0EuicJ0MuoLsxCmQ+PWmWgsthoPherIpysXbs7YDtcASsUFzIoajsQj/xi129C
         043dvxnMivyz05ESOlmvVBRaiCaNw/nB/ii1zg3v8mI9zyeaA1QmoGZewdFYkSBhNp+U
         KGnw==
X-Forwarded-Encrypted: i=1; AJvYcCXkoAaZkiMAQxFD83qzpF9vmG/E4UyGwM7f5YaQ07LeO31yBpYYprtAkHhDlMUhqQ8OV+N8YDmPM4OaDOFqp3N1gKuG14zaDc78Md8z
X-Gm-Message-State: AOJu0YzSrsRROMXsxs7A4kA7HfoC996cK8lNm/ZHs/hlMVGNd0M0yDqF
	xCX+4rBvIz+vOAmfJNFwpD8HmYrAOO6m8wSgG8aj6pL1wfJylSD0AP0IHebxbOE=
X-Google-Smtp-Source: AGHT+IHdp71TBZDkU6MHnXPxQlf8tNmpMUWnxXvxRu0kVYRFV4YLnmqGJ7tZkX9hEXfE7phQHJR/pg==
X-Received: by 2002:a81:9244:0:b0:61b:3304:b724 with SMTP id 00721157ae682-62cd556db06mr101317927b3.10.1718048717521;
        Mon, 10 Jun 2024 12:45:17 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccace6dbbsm17292397b3.39.2024.06.10.12.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:45:17 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:45:15 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	JohnnesThumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 3/3] btrfs: split RAID stripes on deletion
Message-ID: <20240610194515.GC235772@perftesting>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-3-179c1eec08f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610-b4-rst-updates-v1-3-179c1eec08f2@kernel.org>

On Mon, Jun 10, 2024 at 10:40:27AM +0200, Johannes Thumshirn wrote:
> From: JohnnesThumshirn <johannes.thumshirn@wdc.com>
> 
> The current RAID stripe code assumes, that we will always remove a
> whole stripe entry.
> 
> But ff we're only removing a part of a RAID stripe we're hitting the
> ASSERT()ion checking for this condition.
> 
> Instead of assuming the complete deletion of a RAID stripe, split the
> stripe if we need to.
> 
> Signed-off-by: Johnnes Thumshirn <johannes.thumshirn@wdc.com>

I'd like a selftest for this helper, should be relatively straightforward to do,
just to test edgecases and such.  Thanks,

Josef

