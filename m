Return-Path: <linux-kernel+bounces-404266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2E59C41A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0701F23222
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F318A6C0;
	Mon, 11 Nov 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cq/FCo28"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD8142E77
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338089; cv=none; b=CgaybnjsixciVrIUftJyQ34OKD0kYcJ6PyJzImlbs1GApBxWxsEcWTVcyf82ACzZrG7ISJxCKSxjxdD3FkiRF2YtIHC/rD+v6VioEx59NKgbQtjA9Fb3YYUBUIXq3oftIVXGUQf5XLOtox+w39b1smeMJWhP7gXdHr3yR1ZaWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338089; c=relaxed/simple;
	bh=UnPcoZ/mS2Qlmy7QVtab8EhHtoLabZ0wivst5i5cF7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LELh7HY7jYGoiwkDsSxnWoNUmb37/fSn2C4WOCOql3uXr+KMYuOVc3nR+LM5mlruq8CLJ4mS0V0Zb0tIm3E4w7jR2WTxPJYAnNabcFXp3rmHLLVc4XghEf06d0O9DXlCo7EcUPHyDi8lGZFyjNboIhbrtSDu6kheyZZ+ouM2wlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cq/FCo28; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7183a3f3beaso2438014a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731338087; x=1731942887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rbb3ioDkWQUtkUEGcUOQSAFySHBMZKciKumQ+CVhPVU=;
        b=cq/FCo288GLIokrH2UmLTFR2uNGOJtF46wZ6nM6oiOPe0IcXhPboht4W66WUW4rDlr
         wlhL2rh1s0isHGSHsUWO7ZZ/L4WeyDzCohcwPrsV/2t067Osg0Tcm/YMEgEQW4xU6Lr2
         YpTYWpcer420gGK4a37rHkoTqh4idQ+J0SHyhMhuhbZyxuZ16yXz/pW+Dp/b7sg5Sg8Z
         cTOOfQwKl2/mu1GDVEOWeCOYTv/iVdmqMQNHxU5djBezgeS1n2RLEh5sgQqIZlXfiEoM
         sWLn3IDtZIKGKB4FmGool2wp8fQL8aO+TzBUi18wu2VIVg1oFdDFLu9hjx+iPwYeESa1
         F86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338087; x=1731942887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rbb3ioDkWQUtkUEGcUOQSAFySHBMZKciKumQ+CVhPVU=;
        b=DGMgYCD5SraLw87qH+3b3d6DksZ2TqKA2NaWUnQ/8KkVhECxx6mMUDIVWLVCPHFj6I
         TDKXoG0VJDDjS3jJzAYs8HXyU/r7DQjZ0rcg/4Kc/0/aI5CtQDZzK5zv5vIgbcSS+LMA
         5neHYsxg3EXk25v/qT2hppLiC5TESkQWK1vvwTqJAsQd5/3yzM0OuHjB2i2zzWPCknDH
         rdOf9IVsMg8oqHCBgTTgtIzhf0CvBN2vUf9OJegG0FTx04mKa4KfYW+T2dLypdHT3Wk6
         nBdKk37uM0BGBaV6WSZowIHXy4+Dk3Fo5hlIZTnPEpkCm3ny2uM6+dc24El94iI5F637
         UuoA==
X-Forwarded-Encrypted: i=1; AJvYcCVnmNvGsJi9mOzqgZqz6t0ccDpvketuGkgMBD518yiTii8Vuk79DrKHm4frrvaxoWv9Sy3tcDq6tpFTmJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoepjq4v33BORJmXTGwnbF/axrBum0D8IG5+B6H5wkVrfpDZ5L
	TT65qGahj7HYU9063gf/mGVHt0ge+NCJVkIn+LG27g1sI3hkxrstzAl/1Kf2aAs=
X-Google-Smtp-Source: AGHT+IEWftHGeRdWbnyVuxtSjbsVpJKzpmKgkCgPXFwdzBrutzyKUBQtoJjDqWRiqfn3hnNrOWo6eQ==
X-Received: by 2002:a05:6830:6109:b0:718:3b7:23e4 with SMTP id 46e09a7af769-71a1c28a6a4mr10720803a34.23.1731338086775;
        Mon, 11 Nov 2024 07:14:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a108e6f9fsm2251567a34.46.2024.11.11.07.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:14:45 -0800 (PST)
Message-ID: <e2a01b88-6cc5-43a0-bbd4-2a583231bf8c@kernel.dk>
Date: Mon, 11 Nov 2024 08:14:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the block tree with Linus' tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Breno Leitao <leitao@debian.org>, Keith Busch <kbusch@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>
References: <20241111141033.2485eb96@canb.auug.org.au>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241111141033.2485eb96@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/24 8:10 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   drivers/nvme/host/core.c
> 
> between commit:
> 
>   6d1c69945ce6 ("nvme/host: Fix RCU list traversal to use SRCU primitive")
> 
> from Linus' tree and commit:
> 
>   6b6f6c41c8ac ("nvme: core: switch to non_owner variant of start_freeze/unfreeze queue")
> 
> from the block tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks I sorted it out in my for-next branch merge now.

-- 
Jens Axboe


