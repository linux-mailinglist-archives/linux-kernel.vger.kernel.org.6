Return-Path: <linux-kernel+bounces-314351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A86F96B22B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267CB1F23F76
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D1146013;
	Wed,  4 Sep 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPoiaQMS"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8E145FE4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432861; cv=none; b=kNYnEp8LpdQ1+qkVNI9L9lSJR3uwlG/BGH7Mho3cR3sEb0IReMDQXSVAUJAO3vuSCDMiUemr6GeeqaNlMWNCAmEFPZjUAqrSUsyvoG99323OvipJiRePBMVlyz0OeEPGKjvlGdJCJTNpTudGNLYsrw0IRqPRQoyVe4I93QVjt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432861; c=relaxed/simple;
	bh=3Ayq/F2KIWz1MP2Yx/M3mav/ngBIlKLWy/JGYbUoYJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YrK+cZ6SLBHHwOjZx/c/O3BoChoouRt2hV7vcYXqdfPVJOiCAUTFV43IR94NwISZQOMPkWuwuGo5m1uWddegyY77N8ac4BIUtZSx5iBDt9o/FAAtk8OFg9uWi4nYNlHEU+ksznnZnKFVXl/pyFBfrU2hZbhgaEk+j3SdyRYFEXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPoiaQMS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso339986b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 23:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725432860; x=1726037660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yb/TQxCcUmpmu8fvQZuCvdp6BbxHLd8SOuBHk2wJ5I=;
        b=gPoiaQMSWNmbm4SwytDnj7ENZFGPmPCLNhgCbWo2L7lfPdk5pV248c3YsLpZ5zyneL
         QVlL5xW1AOTTBj7fzki3N08rSXTQw7Lm7AUmhu0oa/GMXEt2yzNoEyvTluGlgurw/7jR
         D5L8H3KphmwZLCfIxGhu8EZkkCH2PaAe4Noh1TYGPOFJcfNgNlBk0hEElEBRRvZ6maiL
         pMsqkwvRgLt9Ep4071lXpYd+E7xjOeIspgC2FJG/ssPuyGh0rtTDVxiYkP3qWWcFJRTo
         D9ji4+62HNyUThlPgs+QEDrFfAmdIE3432M9PqCxNUhjgxVBM55sN7tKXmPKMzd2o9SS
         O1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725432860; x=1726037660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yb/TQxCcUmpmu8fvQZuCvdp6BbxHLd8SOuBHk2wJ5I=;
        b=CnCS7o61UKta6MXb1LfZIzVUcgohBmequu40w/0KBJJJfjI0FXYU8fkuwYrHMHY1eV
         3Vs0nXXnYNvJUXczidwRMJLaKGH6fvwBmSL62/LstfObnfrJHQfTgEV/Egr/dx1k4ObL
         zhYg8nKnZS3ZFdtEkge2MVH/YChFv3VqDYaEm8vTq4lCAQmLeVFdQ5e1QwBrD/oG9Idf
         caE9LMLEmC6sMGRPvA0N7Fh76XX0je13/FZn4pxld7+1iOva6NwtAoaYF0mKDm+t0FtR
         lkrRyOP4KWSbJstcxc0am/+52AOEhIT13/xnEaDn2mo/LihwllmD2x/Q6hQvNjAeSmFm
         gXog==
X-Forwarded-Encrypted: i=1; AJvYcCWn7MLUr3oy7JAQN+0GPZQoMOd7B8JenSvlTwTnHREApet5jbVeWUKBcp3+18eCbH/TX9AXUq9Ok96gTpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWSId8emFkRy1ovY5x1bjog9QY3BH5KxFGP3i4v3iH2QrBQPE
	zdj7i7DUIlI9sbI8yPPXn09IrMSAmQLFPEsD24X6L9Wb/Cji7gIs
X-Google-Smtp-Source: AGHT+IE1VlNh4g2nryUwcxgvOEeUzMloemr3a4LHWwmYxYZ+h9mPGpX1Mr5jXtH1qG/hEED81fZPNw==
X-Received: by 2002:a05:6a00:2291:b0:70e:98e2:c76e with SMTP id d2e1a72fcca58-7177a930f7emr1804014b3a.6.1725432859448;
        Tue, 03 Sep 2024 23:54:19 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778598ffasm932388b3a.167.2024.09.03.23.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 23:54:18 -0700 (PDT)
Message-ID: <0a10e61b-f0e6-4423-996c-7884c93af65f@gmail.com>
Date: Wed, 4 Sep 2024 14:54:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com,
 Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240902072136.578720-1-alexs@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240902072136.578720-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/24 3:21 PM, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
...

> 
> This patchset abstracts the memory descriptor used in zsmalloc by zswap/zram.
> The descriptor still overlays the struct page; nothing has changed
> in that regard. What this patchset accomplishes is the use of folios in
> to save some code size, and the introduction of a new concept, zpdesc. 
> This patchset is just an initial step; it does not bias the potential 
> changes to kmem_alloc or larger zspage modifications.
> 
...
> 
> Thanks a lot for comments and suggestion from Yosry, Yoo, Sergey, Willy
> and Vishal!
> 

This patchset could save 6.3% code size, and it's a nice abstract of zsmalloc
memory usage.
Is there any more comments, or mind to give a reviewed-by?

Thanks
Alex

