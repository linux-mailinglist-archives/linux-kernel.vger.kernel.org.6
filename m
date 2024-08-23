Return-Path: <linux-kernel+bounces-298936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C720595CDB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403D7B21EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA71865F5;
	Fri, 23 Aug 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Mxc/exIp"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D857185945
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419388; cv=none; b=cjlnVz7qrTOv1GHFoM/z0buoLVJY/PMRmX/AdDyYId3qttkCciuFk3SZv9zmybGe3qMrrQeqEyrWpIYj8jy7OSu5/h9+9qSyxaQgE5U0BuNFY3TNtB7hPdyXoz38OahtMRlfaGX12jKsAmfIC4MaB3MtEzSbkBs0yn1yWHG3CSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419388; c=relaxed/simple;
	bh=XM6HmEJxj6EyPKid3Kb3NOSJyXdKUdl0YZ/v//OzdLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+zuoCGhxJZH6NTt+fUgVKg9gkm9omUjjtEXqE/7yn14Rf86iCR/ncZRG1bvzxeTr2kJGG02y6rXRhapO6ztTCxe40FOKsiD5q5WIwKDxFILfYtRT8VJvNgHS98IEoxJyF0uebjJ7LpdmpfjYVoaodKZZ5CvkkulzZm5TDKV6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Mxc/exIp; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-81f94ce2272so71541639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724419384; x=1725024184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sQ4rHVCuaeEBgkCad1ajOipG0bmLn0/+w11Ce8vn/Q=;
        b=Mxc/exIpkdAhCGojxKI7DYtBYKi9pR24FooLfcCBqfiwmCCE+qhOZaPiKWpH5OSAlx
         qzlwg457zrosKpxwegmcEkPBFkXt4mmB2AvGd1HxUPn+lQazCXc5eLcYDO3jAZ48fMCJ
         qyXlys9AUKkoLhWc1KW9MvgqaqcPeJjuyKVGlyB6Sqojy4cV5JKk1OAex/ZK/9ipDRLc
         BnVaQgYZkL4C1yI3PsaHYEbFPn5pKBLNJGl32WsmXP61hBD76Uj/LTSyiituDgBvx6CI
         t9sGpZLHkg+rgzwj9Gcc9tQP7lEPocnBegM4Nxog3zhXLNBi5bP7Kk/oQvgfhmkB/JUI
         tPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419384; x=1725024184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sQ4rHVCuaeEBgkCad1ajOipG0bmLn0/+w11Ce8vn/Q=;
        b=Q7cv2uecE6qyrgn2yrov4BZRMNr7r2RvmaQb877RkWrU/XOYhHxPnZSB6WapjRHfLt
         c9YaxU32b6QLMgj7LrUNbKrjVAMCjPge/DYRMIKo7rm2Zw/+skk8kXJ6czKNsABZgEVl
         z7F1zohHq+LriWkB9cvgiJQP6AWdPio7C5seOgYFnl9neSLr1RvAQZHVrqpGew44C8hK
         jjJrqmMlQnTOgis9Vtwsm0fkdjdIhM/Up1IJt6xCifjSI3K5iVa12MCVb7WuBb3K3Q/W
         GSgnQ8sqfRAMm3RmjDewpkKO/TTTitOOp2jEjymhD+Bekam9EBTcCaF5Q0rTtqJA+h7i
         sYtA==
X-Forwarded-Encrypted: i=1; AJvYcCWXy7snRyTxqnoPYPo5LbCd9La59WcqbJ3ixKzNSZqLw9x04vBePuVlQxltp8WtfII6zc99vGmQifvKlL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQD9yd7sEjV9Vhh2O2zbVjJReBDL70kxc0sXLaYf5uRxiikQsz
	bXUVlStBDM/gDW79dX32uOfCvjWUa5ARHDt079TD8DNlsnhi4BYn/aGlems6R8Q=
X-Google-Smtp-Source: AGHT+IF7uzcrWaVhZ2hG2W38v2yp0g4ETQmvc/+nod5ukjF1aqg9oGSWxD6rxP/E2XtHC4UaaZMotw==
X-Received: by 2002:a05:6602:14cd:b0:7fa:56f0:ad87 with SMTP id ca18e2360f4ac-8278732f754mr287101339f.10.1724419383815;
        Fri, 23 Aug 2024 06:23:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8253d5cad72sm112166339f.30.2024.08.23.06.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 06:23:03 -0700 (PDT)
Message-ID: <1da3ce76-c55c-405a-a878-6633832bf541@kernel.dk>
Date: Fri, 23 Aug 2024 07:23:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drivers:block:Cancel debugfs_create_dir() check
To: Yang Ruibin <11162571@vivo.com>, linux-block@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240823112246.3905118-1-11162571@vivo.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240823112246.3905118-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/24 5:22 AM, Yang Ruibin wrote:
> No need to check debugfs_create_dir() return value.
> It's safe to pass in errors that debugfs_create_dir() gives you.

Subject line is still wrong, as has been mentioned before for your
posting. If in doubt, just run git log on a file and see what the
customary title prefix is for a given file.

-- 
Jens Axboe


