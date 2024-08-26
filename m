Return-Path: <linux-kernel+bounces-302141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E6E95FA76
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C43D1F21C56
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CD0199EA6;
	Mon, 26 Aug 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="12NE4nTn"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665F77104
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703383; cv=none; b=mVd/ejzM0LaR5W457djTGEZwq4KCCoP3QPYy++TW+cNqmh960y4x5D2NwuBzVk8482h/DoyqD6xMAWyNs1QSuhEhvqS8PWxtYzknrb6YmPG7thxHsnd+KyI7a76lKl6j/zmwWxcorcsEJ1OgT9Vrc0dj2iTTaZV68HeBnDjIaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703383; c=relaxed/simple;
	bh=EZ2ygm6G/NnFoOPeqy7rnY7z/Xqu0xb4N0J1Un9eJso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+ORMsKfmScEvzUFSYBfJ5tM2gQFmumDXhs2NWJm9PXcyevHLrJ0WiqvaqSbbB+CF2K2RMjidr0hGc1f6cfIjnY3wVT7/FtXEXPTXcuhOPyjr0XWr0pKgJoPegKgYfhkzvRACrKPBTuaxt0YCy+Q+FAaA999fGY/IaFFcU+jAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=12NE4nTn; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f8f0198beso233123139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724703380; x=1725308180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSxs7jjouvW3KnBPno8bcr1cfW8lerR5JOU49camY7U=;
        b=12NE4nTnHWOhVwPaNdvdWQiU43XhQvYOE6/zNmSoEyrNrzm/CZUzihQ4TOwlJyIbVl
         wzfXYnUPSEwOzi+AD+Ff/kKqr0VCEykaSu0PC9XYyWBGq0ba7Km5yVsPxQrYofhfPb5v
         cmyMiqHtv1tbYKSPapFjC7GCcdrXO615IvrstfR1K0Hon4oAfZDmPLQaJ1eF5JxAwrko
         keCGIWDZ787hOelNdUQtCbIlbVb3+akeLP49N5up0KtH+8nmssKSKEWqncWFNIwaiG3D
         M/v0gjKAMW1XoXRaRdayYTQJoiuJ3mLs8lDYjPP9bXAT0oqrYmBPtuAYMDvdpy7uAxKE
         TPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724703380; x=1725308180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSxs7jjouvW3KnBPno8bcr1cfW8lerR5JOU49camY7U=;
        b=hHRHlKfrNhmE4DBtdf0mUef4wQcKXbC3mpnp96k2cReOv/LAWXD/TF7H9csmnWF+8w
         La3WkHJhAJNzebOqCTGEf9BTRedLhMZ5mM7C5ttlcYwbgLfgufOEL2SgWQYlZbPA6fgg
         P1M+B6xhHk9ACwPoLFHv9tkxHtoQD/tbn9CC/qciOqIyirQIlmKDxxw8Ua2TKn6JvJeu
         vN8jNwxPxvre9xgqqsukkzhm63vXaQ7qSf0/xatehCgB/KLSPysN0ofr3gBq1l6IA/2o
         mXGipTs4DzSQuYy+qDzQrMFqgcWzeeShvVG5TvhmuuzBkIIZQgeRGkPmV8FxQbUx9omZ
         Uy9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTO2kDksXwps9CFnl6ULqfh3TF2MElR6ep0B2o7eOC46ZGGrIAoM2Xwt0SNJZ54aS7WkiMvZbtKhuuRIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDl4CY4Iqqrn9KjYlvPFXP7BBUGEiNO74lIPt8J6OEQIfw6475
	VF5jOSXZoa29kSCnhXBFxtKfY6g9MBMej7f4GTYGNpXfcJPO+hz3BEddxw7kYGA=
X-Google-Smtp-Source: AGHT+IE09LM98Fww2mHxkcFOYXbtJ1LS1EZ1s93chVjvbv4O4wdv5u9HvkuJeWYYO4JVINgKmY7++w==
X-Received: by 2002:a05:6602:6305:b0:825:2c2c:bd7d with SMTP id ca18e2360f4ac-827881ae83dmr1235550639f.13.1724703379860;
        Mon, 26 Aug 2024 13:16:19 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f1f670sm2338418173.25.2024.08.26.13.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 13:16:19 -0700 (PDT)
Message-ID: <c698f351-5fdd-47c8-8450-54af72c7ad4c@kernel.dk>
Date: Mon, 26 Aug 2024 14:16:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] pktcdvd: Remove unnecessary debugfs_create_dir() error
 check in pkt_debugfs_dev_new()
To: Yang Ruibin <11162571@vivo.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240826062653.2137887-1-11162571@vivo.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240826062653.2137887-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/24 12:26 AM, Yang Ruibin wrote:
> Remove the debugfs_create_dir() error check.
> It's safe to pass in errors that it gives you.

Please make it:

Remove the debugfs_create_dir() error check. It's safe to pass in error
pointers to the debugfs API, hence the user isn't supposed to include
error checking of the return values.

Note both the rewording, and that commit messages should be formatted to
72-74 char line lengths, not tiny ones.

-- 
Jens Axboe


