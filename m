Return-Path: <linux-kernel+bounces-564287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFECA651F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75913A6FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694F52405E8;
	Mon, 17 Mar 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="fKVBbdN3"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCA23E34E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219831; cv=none; b=b1SU75fGvlmpJDMtkhqlP6wWyXVs8NzyLDTLSC8UuRsLsE8DcO4uis6ivWCP5+T6UcWEgqyzMihvMFrUhQ6tT+o7gE7A4D8n+aUfXr/bDVQii+XODV1YxSJD2rTjsjknoYNeWHwCWhPhIL2PCDW/SvzQJZQhjwtMK8S3ZSaDTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219831; c=relaxed/simple;
	bh=0/JBhcmr6RbYakMo+6DE8lgQPZhpL+1uoSnywA7R3cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmqXHOMActvbuGYrx3NvugA7gvP1o6Ih/NugTaELPTNugr2ZQpneAOhXoBmqVKBXTOY5edcSfi9wx99nLTxyboVbo25Gs5Okm/KZrAf8gFmYmdyQ9+YLu9X+GoEleOIhlx9/kVM/xHxogUPp9eeAget5Vox15U1wKSUtSYOfZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=fKVBbdN3; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85da539030eso148763939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742219828; x=1742824628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8SfYp7nbKw8yT4ZK7FK7ta60vIOnSkRlh8C+eZnMPUg=;
        b=fKVBbdN3cuvigvxP1zYXuYCTGnjRCfwERQAlbtT98ZJ5J6PyZREdmEyxSpEHH8Dax8
         X/8gP/b6PUUEwKERr4juhINSNzHD769FfL2VkgbuF7rtNRAkyUdYk+hA8uE5EXEuZFQB
         +AUz2C4EADEiv9NUAJQusO638Qbc1adxh0BHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742219828; x=1742824628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SfYp7nbKw8yT4ZK7FK7ta60vIOnSkRlh8C+eZnMPUg=;
        b=K9+/9o1NohYZltaQw9QutpXLsVehNHOj90slDa3F1Lwee2M5VJxIL3RJmkTNcmVLIK
         Vd75ie4PN+dO/Ny/OoWfzP4MbNOsU5oMV9EESDIrvJkMNmrMv1UcSIVdO60bKTlVTRu+
         Ff3JzKFbgK+KSZLkWVHKM9K5kGf2w+c0dmwOhdFMUiy/EPC55yLySm6nseD2AGUHjq/l
         y56E8JQ2FlmG4Ei841H6+DxZYNDQjwO2WViOel8YWc+KjeB8mJ92x1sRuqsCRdghvR5u
         l0e4n1dIFCpyqcrWaQPuLwA5aSrVru7/13w94hbcVspLfnQ+8+INM0TghY88Zvo9wJ+0
         HNaw==
X-Forwarded-Encrypted: i=1; AJvYcCVZHvc7TrG/AkPKB7PkkqUN1FfAI8xCLSaDrIX9A9rJCQgn087ChOBovUHl6WDLHWC81MPxLAtc2SI91hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0DjCZ7nvb0l16Be975W+Z4mGkkF61YpMltVgvVOL6MNce/l+
	TMrPsNiapimJE/gpeWj5oqjJbacDEpUUV1RmUspvyQuNDbpNq3OEZ15qQSsSaTk=
X-Gm-Gg: ASbGncuSvK6mVTdWjveZRW8b/r0C39RHATqnyVd9RmxEJ8KlztiPvQcwbrVKYiR2E0o
	vHhjrGH7++aPhtXNGBivvGQsI5CziA/gWrWgNUYJosqy8yI4EKdKF/+Q/AVkEfFpcSeIjwP9nY3
	YWMkYM2oc02OA00/P+CqBEsdAHIQrLHrTP0ymr1BvsaI2hQOgsmvjWN6b+XNgkBp1ftYzjs3FRl
	kh019FKFQ5VOwgFHy2eakpPYoMOAd4G+ZQJ+r2OAvD/Xf4+ZSV5A9y6fQMpMA2WpWkg/A0es+PJ
	8C8C1njGO6Rju8CzZOSr7MEgeMq9uUNyWC0e3HA5RnTV1mDs6XkMZ2vIEXifv3AMg6yyYgqriHR
	v
X-Google-Smtp-Source: AGHT+IHVUTBLBxTZC8HdLXhH7rWvOJoPaV2M14f1jVdqw63OUcUgLVqKDEC+//Li+SKHHS24f1zgCQ==
X-Received: by 2002:a5e:df42:0:b0:85b:3ae9:da01 with SMTP id ca18e2360f4ac-85db85a4420mr1487523439f.4.1742219828514;
        Mon, 17 Mar 2025 06:57:08 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637fb30dsm2273057173.90.2025.03.17.06.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:57:08 -0700 (PDT)
Date: Mon, 17 Mar 2025 22:56:48 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Mark Harmstone <maharmstone@meta.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
Subject: Re: [RFC PATCH v3 0/3] introduce io_uring_cmd_import_fixed_vec
Message-ID: <Z9gqILpSLiHJXDGK@sidongui-MacBookPro.local>
References: <20250315172319.16770-1-sidong.yang@furiosa.ai>
 <3c8fbd0d-b361-4da5-86e5-9ee3b909382b@gmail.com>
 <785d1da7-cf19-4f7b-a356-853e35992f82@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785d1da7-cf19-4f7b-a356-853e35992f82@meta.com>

On Mon, Mar 17, 2025 at 10:32:02AM +0000, Mark Harmstone wrote:
> On 16/3/25 07:22, Pavel Begunkov wrote:
> > > 
> > On 3/15/25 17:23, Sidong Yang wrote:
> >> This patche series introduce io_uring_cmd_import_vec. With this function,
> >> Multiple fixed buffer could be used in uring cmd. It's vectored version
> >> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> >> for new api for encoded read/write in btrfs by using uring cmd.
> >>
> >> There was approximately 10 percent of performance improvements through 
> >> benchmark.
> >> The benchmark code is in
> >> https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c
> >> ./main -l
> >> Elapsed time: 0.598997 seconds
> >> ./main -l -f
> >> Elapsed time: 0.540332 seconds
> > 
> > It's probably precise, but it's usually hard to judge about
> > performance from such short runs. Mark, do we have some benchmark
> > for the io_uring cmd?
> 
> Unfortunately not. My plan was to plug it in to btrfs-receive and to use 
> that as a benchmark, but it turned out that the limiting factor there 
> was the dentry locking.
> 
> Sidong, Pavel is right - your figures would be more useful if you ran it 
> 1,000 times or so.

Yes, it would be useful for large number of repetitions.

Thanks,
Sidong

> 
> Mark

