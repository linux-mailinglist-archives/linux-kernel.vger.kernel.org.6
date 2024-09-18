Return-Path: <linux-kernel+bounces-332177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363F97B66D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 02:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5631B1C23308
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A70A4A23;
	Wed, 18 Sep 2024 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ+gguvq"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEC723CB
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726618853; cv=none; b=g7f8FQguZyANueKsH5b63izUMKkUbC8UNNM5v6ZJDcijSX8XX4DG+cqFQQbiyT9aoQL38O8Xp6uN/vAfCpySDx4RAwME45fwwA9aw9E/FO8SPXtUQf887Lucjx+4jiSMd5PiaSZwXpTjpHVCTP6Llzp0TfeYrML3jXvZ5rx4NBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726618853; c=relaxed/simple;
	bh=ywoOVRONUdJVX0JaMGy0S7pNuycGrSVTQddwU1Xi2hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adPdwuW0I95MWzWMj3bOlEIyMZcbybzIOVVZVGAS+qPQj5adZdnsig1il65R2LJU3NzcAkE8HrIWvnDA2GsCGzrRe5sd2ArzI8yRS8dnznqEdb93FQdsMpejg/xM04wVouSkDigpJOvI24+/I/+C3UigMPLZFnoSH03lkzjUFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ+gguvq; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e0379a8d96so1768440b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726618851; x=1727223651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqWiWz/3Q/QL5GdvcfeJQoC6itwwR8nh7kyhVsUqNbY=;
        b=mJ+gguvqT+0aIninMRa/pUOyfZTGwyhbmfYl8GYlo/LP+KCyhQmmvy5vbE4cQ13Jcm
         8y73wO2icz8lyqUGr1RfM3eeJK0lMnEbNSBCiW8u4rLQapLFMvGCc+q2X+gRLkBq9h/H
         WPbhRRyyG+hHfygqiW2v31G+0jrI+AuXWBcuoq4wocEplF30xugiUkPoi4GUt/MYaVH0
         mzLPdQHSwfDVdADatZlsQQXNMKpvsdqev616oa20OzMOT4XJqyA6b7dQf6yb4kt1qa52
         SHRIia2YQtShIS0dcKlADiPQAdGc6SDP8eo9qYdcO2H23YSlXvHZQsnErWF3RgktvypS
         oTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726618851; x=1727223651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqWiWz/3Q/QL5GdvcfeJQoC6itwwR8nh7kyhVsUqNbY=;
        b=J3XD8+HtwrR5hnywXs1Glu73dG+dM0FFbT01lpE3NwjpMnHQo+TirWsexnBkoPiWyt
         ZNRXVXXl5UHMgRZCabN0tHv2DEA8UVisspKFqijNhV0uhErV3PopuyVba2FGw42zbTxU
         FjONrqDliSF0NWwFv4q4pFe4dmF898d6dTT+XvarRraU144eEM+RrDJnpZhKleBI5I/F
         2Igs1SNcS+fDZFtVK2Lo6F5PTbP0YeWJa1C0f2txq6sKESi7DG2CPTR5hD0YWcLVN2SO
         zqUSeToBR75eMC6jdOzUU/quAQc9Wg9y1pXqOgyLwS5DYp+f9ozNjc7dLkqmcAdEQV9f
         pBMA==
X-Gm-Message-State: AOJu0Yx5UMhKwpz2ihrzCU3bGnTSrVE7C9z7gTpjTJE1w2nvav23q1M4
	Ef+tmAxoQTjKKNXNgDeYFr5miaC6rMUy5msJ4Kfcj5pHHOVbIxUM
X-Google-Smtp-Source: AGHT+IHU5iG9yyO7j+6a1zICs4U4cy/+cqrMCAnH11yBCKuqKS6+7NuNHCoH6dNhLI1L46BiFFtaIw==
X-Received: by 2002:a05:6808:2009:b0:3e0:4ecb:e90b with SMTP id 5614622812f47-3e07a0ed95cmr10499932b6e.1.1726618851372;
        Tue, 17 Sep 2024 17:20:51 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e166cfb847sm1719398b6e.22.2024.09.17.17.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 17:20:50 -0700 (PDT)
Message-ID: <751d4ba8-1e35-47a5-9a94-9873ff2619ae@gmail.com>
Date: Tue, 17 Sep 2024 19:20:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: fix async device shutdown hang
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>
References: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
 <2024091753-estate-legroom-5d62@gregkh>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <2024091753-estate-legroom-5d62@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/2024 3:42 PM, Greg Kroah-Hartman wrote:
> On Tue, Sep 17, 2024 at 03:15:17PM -0500, Stuart Hayes wrote:
>> Modify device_shutdown() so that supplier devices do not wait for
>> consumer devices to be shut down first when the devlink is sync state
>> only, since the consumer is not dependent on the supplier in this case.
>>
>> Without this change, a circular dependency could hang the system.
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> 
> What commit id does this fix?  Should it go to stable?
> 
> And what driver is causing this problem, is this a regression or for
> something new that just got added to the tree?
> 
> thanks,
> 
> greg k-h

This fixes commit 8064952c65045f05ee2671fe437770e50c151776, in
driver-core-next & linux-next... it's problem with code that was just
added to the tree (in drivers/base/core.c).  It is not in stable.

Apologies, I should have mentioned that from the start.

The issue was found using qemu... a pl061 device (supplier) and
gpio-keys device (consumer), from a qemu-generated device tree with
the aarch64 architecture.  I don't know why the devlink is in the
sync_state_only state in this case.  I didn't dig into that, because
I figured the shutdown code shouldn't hang regardless.

