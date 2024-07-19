Return-Path: <linux-kernel+bounces-257438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1992D937A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23701F224C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A098145FF5;
	Fri, 19 Jul 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HqXa6066"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA41459F7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403596; cv=none; b=mYdwvZ+4Hed/03VDMi5Sy1mYTKjNT6p7lwIxwu7U+VMGsjNcIf2kRYQMfIXV4BafSeV5omjWVO1hN/sC7pKapYWG7utdTMXpKwVmFDmQ0T0sUMFNadJzcMtR2WloUOQNNvogDZx5AIi+tUaLwXZSw2MAk1xjXJusjg2SuR5qq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403596; c=relaxed/simple;
	bh=IIaXFQKJGp42/A/dmLPrjhTC6nOpGBrYODeUe5ulqfQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GStfqIFysZLzM1YjsDOS2s+akRV65G45MZ9CZ3F3zIouLRNbO5sDFdnLcvEIzMbA5sOiTFDQDrFusn4SHMtfbMzZBCuHUUv5NVk02REm144dCjN5jovH0Cm8H40HVG8X0cWpkavvO9hHpcp4lzWdEffl6WeQ6zG5EXgIsC+OP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HqXa6066; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb80633dcfso201130a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721403594; x=1722008394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmjqiBmJBVEyMGIx8VEZyQ8Uzo0U1Uz6G0w5deMZhXg=;
        b=HqXa6066EoA/mWUPpr/ntMkZtIXmwMSxBC04erA7Kw9nwD31+lD10wCsRwSsNAcbOR
         U2t4RRkTnUE6W/2BllOXRbmSNaBZAcaK6Mfviletd0yWx8p+rcWPNbOic3Yk7M/mFAI6
         yWk7ZfE82k2PNmHlFqg3vqObAgSvEFy0wJI4E6nY7j9kugpnf7L9ad27Ks7FBWbxPzIv
         b6I+0MCU4N2Fol+XLFL4tDD0a5aH6VGmN60uEe+M8fyI5QUb2sfkrsmpr46Ly3RimpMa
         iny1TGdDbJsXuGmYB/CAqhfWeASdjutowRg/gH9zagW4cfvyoVyBUn613B6BtCoXG003
         XVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403594; x=1722008394;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmjqiBmJBVEyMGIx8VEZyQ8Uzo0U1Uz6G0w5deMZhXg=;
        b=p193KUQWkTR8QTzxrWwvF7OFJ5Di9D84XioGcuWUCaoDFUWYmj7o/iOz6oQ25+4/Gb
         9cfCoVg14fgZoHWelIe91DpcI3PAqkQH0d+FVVDobBAoQ1hVCgg3Hnd7ErUdORac2QQq
         s7G/N6uk0o7LSrHCDtNH9XpJaChwh9E/5WzJmJazel86CCsQjMz4+PlUQEY7vzxMu1zC
         54ciBH+rW+IpeSpfYu0GUbepFV+tZu+YxRV6joMDQWpQK5d/p30p1qoociZURWS3tQd/
         qnNxzHUpqqwGZqMGqUlw/U4kDK+rVRhwE3SZ2VSgpEL1B+e/JhZtg0OZ9mxYGrZjlpa6
         SX1A==
X-Forwarded-Encrypted: i=1; AJvYcCXmCui3I/9j8pyInonGe9/7SbmooBK4S7nPeqRm53JdKTZUKb5uUOTojs1s1w9g8OnzL68SJP9GddtZSpLtA/UuXaghmAdSNg3Ni0qZ
X-Gm-Message-State: AOJu0Yxh0pAqHVLSKuK5cB3uzmUF9Ng/66b8HEbFKPbZEx/FLNI29FR2
	Z1kVp1gVH8hPutaLLkFvITOoOM6cuQPcWoIS2W6tZJdjHLL+9lfxA+h2jH12JEU=
X-Google-Smtp-Source: AGHT+IFfdFIdvCQWYQsXxU7377pA+fday1SiLgfXjmmVtbpGtZn0yHIIPC0G5TMUvwt6xM8uW3a92g==
X-Received: by 2002:a05:6a21:10b:b0:1c0:f1cb:c4b0 with SMTP id adf61e73a8af0-1c42298cd9dmr242511637.6.1721403594600;
        Fri, 19 Jul 2024 08:39:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb773411basm2968003a91.30.2024.07.19.08.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:39:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Ming Lei <ming.lei@redhat.com>, 
 Omar Sandoval <osandov@fb.com>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Yang Yang <yang.yang@vivo.com>
In-Reply-To: <20240716082644.659566-1-yang.yang@vivo.com>
References: <20240716082644.659566-1-yang.yang@vivo.com>
Subject: Re: [PATCH v8] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Message-Id: <172140359332.12097.1558892281494577679.b4-ty@kernel.dk>
Date: Fri, 19 Jul 2024 09:39:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 16 Jul 2024 16:26:27 +0800, Yang Yang wrote:
> Configuration for sbq:
>   depth=64, wake_batch=6, shift=6, map_nr=1
> 
> 1. There are 64 requests in progress:
>   map->word = 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>   map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>   T1:                                       T2:
>   __blk_mq_get_tag                          .
>   __sbitmap_queue_get                       .
>   sbitmap_get                               .
>   sbitmap_find_bit                          .
>   sbitmap_find_bit_in_word                  .
>   __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>   sbitmap_deferred_clear                    __sbitmap_queue_get
>   /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>     if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>       return false;                         __sbitmap_get_word -> nr=-1
>     mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>     atomic_long_andnot()                    /* map->cleared=0 */
>                                               if (!(map->cleared))
>                                                 return false;
>                                      /*
>                                       * map->cleared is cleared by T1
>                                       * T2 fail to acquire the tag
>                                       */
> 
> [...]

Applied, thanks!

[1/1] sbitmap: fix io hung due to race on sbitmap_word::cleared
      commit: 72d04bdcf3f7d7e07d82f9757946f68802a7270a

Best regards,
-- 
Jens Axboe




