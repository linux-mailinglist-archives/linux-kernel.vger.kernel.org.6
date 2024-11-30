Return-Path: <linux-kernel+bounces-426162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2E69DEFB4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9858B212DE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25971514F8;
	Sat, 30 Nov 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="poM5nKun"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527EF126C05
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960302; cv=none; b=XgQ7d02SW0nRUk68hkV0536PWIn3BkEAwVxQpPjqvIdub9Icrt97P/cZ7646KfZaYrjstqCcENxDrNtPDNbJE4lqTVDQj9KrZo9u1ZqG8V9uEap/aducH6AR+JdxpibL1r9voP8zYrc91y7OvhRyzcBISRSI0y2wFseohYFVaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960302; c=relaxed/simple;
	bh=kKRrLUcexh83lOiUaUbKCKWvIfIwKmuP8E+WT04gVvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCkiakre0IuElFtuE8I6AIJ35UqQ83QKSSIa/gS4zIkW2PXBdTlSw4XV+ztxxrGL7Tz1ZZBoJ6Esx+T4UEzZcBKcfXikxiZaXF+0uTB8IkGdYAU51j4jgYr9kPPjtpXfJq2Xpq6OjkTipWZu8WYzGLkbHUyZjL+6UFwgy0ttvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=poM5nKun; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so467642366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732960299; x=1733565099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSWtHVu+8YCZ9NtKFC73H5G6nhNqj0VGkVJgF+ZsU5Q=;
        b=poM5nKunnz9gbQl/uFEsFoNQUGcmFNf+tMCbox5phAqSxGOp0Esyx5yk5b+2RU+3ZQ
         rYDqBTn7OPmAsCHhY8A8WHZlIF4FzAEzjmgk+tqBFMEozGzwjHEf7yIEEijcs9lU/K7z
         AmJ7q/p1SKB5IAGKMdUg2RYc/Q+5FzEfIdzig6TKAtzHlIBmpxJxE9GIEa7QRBmRyZal
         7A3GT3hBNqclzg1UvDZkQnLaRO9iHdm8ynotW5ViA0phlQkDEAJsWjG1nA3UFNbZnElu
         EiSRM5n2gI6Vi6DZ2kQ7+Qy3w6KY7B4L7ERtD1605Ad/3fJS/zTNscdZzI/vqa7KdYCw
         xm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960299; x=1733565099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSWtHVu+8YCZ9NtKFC73H5G6nhNqj0VGkVJgF+ZsU5Q=;
        b=bThsX4G2DdtdQoISGqOi+TwsNTMFk0fQxk7GKiDLN0P4wn2lIHpiYWUBUsVItKWNA9
         XoDWQkdgWA4n2gpraTC42Qu7DA3ssTNQYuDT4UTbr9Y0y7KcNJd5b8QtEc2zht3rGS3l
         h3MW8epznC/aL1zElMcB/oHxFjtzKI11bQImE3akF16TVSF4Gj48jdPLrQJXfLQaXqHj
         3R9i22d5py37eBP7pdnajFtHq9Njhe7/6eegFAKk+Ou2J8IlQ64BMxDSFeYLuMYGdVnp
         Rch1ui8nAbBTP8FmZcKGwpO5RtY9OUjHYakVr9zZVd2iPu9ufDkuYsv3bcyCcYfmMBkV
         mcMg==
X-Forwarded-Encrypted: i=1; AJvYcCXdXmlxh45sxspe/G9uTr+q6VO8ynv6roO5j7Qwgw040iELNWLoA6F46cnGbtVwUf1vHgxEoJEFyS0EloQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FITA9t+XeLA0TYFMawYZVLIZhRZWaNy1qHz/B1eVYZ036OIG
	3LYTPXR4EobIVsZqhZwkNyXuE7E70wzhMcBQhmK4JMeIGvPMlmsu5r9mBknKiT8=
X-Gm-Gg: ASbGncuYrb54jB945jlRgQy8SgCtiiI8H3VLEjR8ZVwYeotYsWb6oquDDJEP+Kqf/i/
	8aSTyewChYjDWqomIiqLk6QRp1NQIuj6QHdOkU7xX1MV7lWQVcRFMUiLtuKEF0wc11R7Rmjs4YO
	NIZC5h53/83zgFn0LbHshj2SuvB7uJEa4OIvKCgmKZ3L7zzAuDwX4DPtlMWjqEXON2vuT+yWd/i
	RTFe6dTzwwyH/MQTqNxxgDtrFtzDmiHtddwuF12lEPnu6ln/GLy7qX8z8jx39NcWNHNvxz1
X-Google-Smtp-Source: AGHT+IHl2HNKLt+8WbRAJWvgG5RXB2PtrE7G/WuljhCmVnYPMsQv3+LZlwwJFg4dwqVFPCttA5FCJA==
X-Received: by 2002:a17:906:9ca:b0:a9a:170d:67b2 with SMTP id a640c23a62f3a-aa5946dcdebmr1151991866b.29.1732960298564;
        Sat, 30 Nov 2024 01:51:38 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5999731d5sm262574966b.200.2024.11.30.01.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 01:51:38 -0800 (PST)
Date: Sat, 30 Nov 2024 12:51:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: Re: drivers/infiniband/hw/bnxt_re/qplib_fp.c:1090
 bnxt_qplib_create_qp() error: we previously assumed 'res->dattr' could be
 null (see line 985)
Message-ID: <cc4ebf9f-0441-4e7a-b979-3680a899c109@stanley.mountain>
References: <38c06486-6a1d-4129-839d-a68e29b21e40@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c06486-6a1d-4129-839d-a68e29b21e40@stanley.mountain>

Oops.  Sorry for the resend.

On Sat, Nov 30, 2024 at 12:26:41PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9f16d5e6f220661f73b36a4be1b21575651d8833
> commit: 07f830ae4913d0b986c8c0ff88a7d597948b9bd8 RDMA/bnxt_re: Adds MSN table capability for Gen P7 adapters
> date:   12 months ago
> config: x86_64-randconfig-161-20241122 (https://download.01.org/0day-ci/archive/20241125/202411250359.DWxho9P8-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202411250359.DWxho9P8-lkp@intel.com/
> 
> New smatch warnings:
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:1090 bnxt_qplib_create_qp() error: we previously assumed 'res->dattr' could be null (see line 985)
> 

regards,
dan carpenter


