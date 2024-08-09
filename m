Return-Path: <linux-kernel+bounces-281142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E4794D389
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504841C2235F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0CB198A2B;
	Fri,  9 Aug 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kessrLd8"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22D194C62
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217700; cv=none; b=beXP21KO7LPIJNAAWtE/lRNZ2k/nw+QiPDiEa7Jx026imYGO56WcbJHABF4+uwdI3cZlznOrU3VrTkLY8HLE96njmXe9pTCEGjMiQOa7yxezAGyJ4pr3X8XvVSVRHosy3CG3UHd87Hr1TZp+TRbbJpzYehV017ANxDmfaTrMWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217700; c=relaxed/simple;
	bh=vU/48LIHdzatnXaFk6tIUtMI9cD5TMpV3hQrTpJeqbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+kiZe2QXScdLmzRdjYxxs8Y7PtKHceZgOGIDuLjlwC50xxh3StkQczeciLQokzDePBv/XDmOm4pUVjm9Zt29e+aqDtSVkoyPq/z4V00no8jonJfwsnv9ajEMnEf/oZ/Tchn7oInPU+2voe9PzWLDzaUMYxY2MT7TEMHw1mTxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kessrLd8; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39b37e5f8fdso1039045ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723217697; x=1723822497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oId9STgLfdIGQ+LhZbW6hxg3skZFfi+5Ez0mg+R4Joc=;
        b=kessrLd8YrFFikw1IFW7wJMou3wAUtuzxio2HpNQCwFgFea/Ulo4ujDqY6aAI9Z5/w
         h5T3UlZaPpYL/5EtkqTT4k/lUa4cYOVA/v10pvIPpHbQF++BMc/FxJSfy6Eu3JzDVmH+
         97xoI6ogorufHHA2pj6UEuo+8ADXQzBpDPHu0VPTVt7OxpldrzRi/FsIarXg5cjOMxhk
         LdKr4tzfgmzDhAo9Dc8KEbrasX20KtiIIsgRqJAzcq82wV9vUcGuRGhSamqdkhVnKyax
         vc73c54o0ZJwZ3qWSAVlGeit5G+AY46OT8EAiswK1FhkggzWDxViYpCXwb+8mHCuF5qV
         jj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217697; x=1723822497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oId9STgLfdIGQ+LhZbW6hxg3skZFfi+5Ez0mg+R4Joc=;
        b=UP9J99JbOE3bya3AjsbsnPDF6JfIozurbuGCI7xt1P7VyGZM4PRKXA9y7h/d+O3TqV
         0s/X6PaswVtZxz5iqbJUj0uh3jiVRWj/rjg6Q1WHwIY8QiUzgVFRRheMEsR4x35P0XRn
         w9FBAn1zmnTXy9oPocsKwcOuCClTnYooIp8bxzblpfe03QCFLFzCeFUch0eTqEBoR67z
         rehbp/WMOBhIuiAX1qsQLYbKTo4c4HwgVRgN55lWQ1omTrvbktborgHm8ml6VMou7hjA
         HPTiyR/RnKj8na15e6Il4HGG3GPpsfbu+g7vAbS2yXHnAsT5NGTswubMoEOO7FwldZnn
         49yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBN9uH4846dQF1TqNwQ28WfC9FTXrs0FQdQIgCFKValfcC2fadJUVrgzS08zkTU6PZqFAhfz/6G3oQFzKTqHkDIpvDjMQ/0taDQJqc
X-Gm-Message-State: AOJu0YzLbaLZvyX+LKf56fHytkIVn/nmoAFaTuQTTQuKFo/kNQpWS8qS
	/zP8ZdxAkNKv8yfRc9EU5Vy75K4b9SD2Pqpih5ekHTs/7Puh53HgWgcX/dKgQihy3HhM72dQZkK
	O
X-Google-Smtp-Source: AGHT+IFLRZmDl+ZxbjcJJ8qEWSq27UMzqEjFndcG5q43EFzp3g4B7kGjU8tgMo9TiYr31X2+hClk/A==
X-Received: by 2002:a05:6e02:1d0b:b0:39a:ef62:4eb2 with SMTP id e9e14a558f8ab-39b8134a5eamr16121925ab.4.1723217696883;
        Fri, 09 Aug 2024 08:34:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d69878d2sm4188811173.26.2024.08.09.08.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 08:34:56 -0700 (PDT)
Message-ID: <584a1774-0268-4b3c-9a78-0f00073b9d74@kernel.dk>
Date: Fri, 9 Aug 2024 09:34:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nbd: correct the maximum value for discard sectors
To: Wouter Verhelst <w@uter.be>, Josef Bacik <josef@toxicpanda.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 nbd@other.debian.org, linux-kernel@vger.kernel.org
References: <20240803130432.5952-1-w@uter.be>
 <20240808070604.179799-1-w@uter.be> <20240808070604.179799-3-w@uter.be>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240808070604.179799-3-w@uter.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/24 1:06 AM, Wouter Verhelst wrote:
> The version of the NBD protocol implemented by the kernel driver
> currently has a 32 bit field for length values. As the NBD protocol uses
> bytes as a unit of length, length values larger than 2^32 bytes cannot
> be expressed.
> 
> Update the max_hw_discard_sectors field to match that.
> 
> Signed-off-by: Wouter Verhelst <w@uter.be>
> Fixes: 268283244c0f018dec8bf4a9c69ce50684561f46

This isn't the correct way to have a fixes line.

In general, please don't nest next versions under the previous posting,
and it's strongly recommended to have a cover letter that includes that
changed from version N to N+1. Otherwise we have to guess... So please
include that when posting v4.

-- 
Jens Axboe


