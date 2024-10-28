Return-Path: <linux-kernel+bounces-384388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2689B2975
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6B61C21A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663F1DA10C;
	Mon, 28 Oct 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LehP+hVh"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031DB190497;
	Mon, 28 Oct 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101098; cv=none; b=bwNxKFjLG1MXeJMLEDt9eEIMRwDj2Um483VSOwilR3q3BNpHnwCTzLwUdxE2uIr7kh6d9QHc4iS1MkDgBYH/DbDWB2CaEgNZ2a5CXO21J883jXXQa0bgx3LRUzQYSQsE0e7gJyOaVtOqg4uhWLUgs4SNBQs6WbQCAVK1abntTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101098; c=relaxed/simple;
	bh=mHL5eTsDx81dznD2XHpI6gh/TNkyu/7U/1ufhRQdCY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISPI+xLPFT2pbQFD+kvHTL85kV/1punrwfZ5gNwNDKj1t3ZhyLmSMf8X1JCyQBUia5FVahiDbtj53Aickh0yXdCuFjQOQnOj7NNw5YXPLFub8hUEhgbcYXyPG5IYRWp35DgoFYOCIcQh7BxF4p0ahlrLG3i7LKPTnKkVfiZZTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LehP+hVh; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20c9978a221so41484065ad.1;
        Mon, 28 Oct 2024 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730101096; x=1730705896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9Jn9b1SoHwPkzr1uX2+IeCKA6+vPqFBEeVSpXW1yoU=;
        b=LehP+hVhJOdiPhkrRrsw3i81B0f9NRfZnzM6PWAECPZWbbxdqpUmKIcvuW7pGisVMs
         tYJ6whtc4YQwsr4NBlm+DZCMktRtcE4GRQBz+QlhIBakKME61jVSxmx7HQvBFU56pcfH
         KigrM0q416oV7yd3pyjL1yAO9AL6xurb0cg+UqFAG0ikS+uzgTPAkUzzoHWdCzEEvWHA
         pmeZjEbac9FsjQ8xTUrRRB2QWtjBrurPFvyBFkqmiNCe/z7ffhmH34IhPTtsah0WT6HR
         c/xM9+2AM3OVu+OJc5Zfl+6HgfhIsADZyHI3swegVDWpMNzIZ9xGVM/v93ziTYkgeoKm
         wU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730101096; x=1730705896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9Jn9b1SoHwPkzr1uX2+IeCKA6+vPqFBEeVSpXW1yoU=;
        b=MHejow0njTq+FRqAqrcSpQsGKsotvt9g6yrNiE1tEpD9ch0mz3sNxsJ0SkPRg45CQl
         dQ1fGcBYR4m0BMj3SnFygSfkgtfXOcpJnxAl1ZzEXVard4CMhlDXHkI/YOHdYj2AvvuX
         Nl7Fun9jOW9HTswwuzV1MJBeWAq4lMccKvvDel7Qkisj0ZUbVcKfDhh4kvZOkxPQ3nix
         BNWC9yWROmPILBahS7u1kEhhwQ8/Rgp81Zv60eve7Emz/dmw/FdbpfPqz57Wjgt+xQt+
         VP8Jn/3RLqgAa/c0B2StgrrZPE9NypwZghEhNlwwRQKgnZ7/pIs7fsMB4YiTniPSkpLq
         8NQA==
X-Forwarded-Encrypted: i=1; AJvYcCUdvmzvbVbcxvvvJ5gKys5QkrpSRB/UqVNDN/Q6wDb61Z0H0tzY9VBFbMCFQ2K1rwU6r1nflTiegIk=@vger.kernel.org, AJvYcCXNejH/E6yrwIFbgCzw2F4mD2+uKgKO2euu74b8f2kSqk8h4HlPEpPleX0Pom1hpGehqH5vp/JQWbqNFVJX@vger.kernel.org
X-Gm-Message-State: AOJu0YxCiZKsN5m3qBlzkBsEMa7ANiC+fjRE0q6HHHh/HgT+JY4VKnTy
	JEOfpptNOxw43PxAN/jpUSjDkjIh99IWVOKGQ5Dr3u/fS2cohVM1
X-Google-Smtp-Source: AGHT+IGxSKQGIz43se9nrgtLUp6fdhXdXWR2R/qH8wtV35tb/u1Z+NxtbSi/ZhTn+RHZlGAYgj2KAw==
X-Received: by 2002:a17:903:2442:b0:20c:5cdd:a9e with SMTP id d9443c01a7336-210c6c02482mr75533615ad.28.1730101096090;
        Mon, 28 Oct 2024 00:38:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6bc6fsm44951945ad.63.2024.10.28.00.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:38:15 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: corbet@lwn.net
Cc: alexs@kernel.org,
	fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mudongliangabcd@gmail.com,
	qiu.yutan@zte.com.cn,
	seakeel@gmail.com,
	si.yanteng@linux.dev,
	tu.qiang35@zte.com.cn,
	wang.yaxin@zte.com.cn,
	xu.xin.sc@gmail.com,
	xu.xin16@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: [PATCH linux-next v8] Docs/zh_CN: Translate physical_memory.rst to Simplified Chinese
Date: Mon, 28 Oct 2024 07:38:11 +0000
Message-Id: <20241028073811.2980032-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87h68xw6nr.fsf@trenco.lwn.net>
References: <87h68xw6nr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> >> > From: Yaxin Wang <wang.yaxin@zte.com.cn>
> >> >
> >> > This patch translates the "physical_memory.rst" document into
> >> > Simplified Chinese to improve accessibility for Chinese-speaking
> >> > developers and users.
> >> >
> >> > The translation was done with attention to technical accuracy
> >> > and readability, ensuring that the document remains informative
> >> > and useful in its translated form.
> >> >
> >> > Update to commit 7332f9e45d2e("docs/mm: Physical Memory: Fix grammar")
> >> >
> >> > Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
> >> > Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> >> > Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> >> 
> >> One does not normally put a Reviewed-by tag on one's own patches, so now
> >> I am confused.  What is the role of you and Jiang Kung in the
> >> presentation of this patch?
> >> 
> >
> >  Let me explain that, it's because of our company email permission policy,
> >  The author of this patch, Yaxin, has no permission to send out the patch
> >  temporarily. So I'm just helping to send it on their behalf. and at the same time,
> >  I'm a just reviewer, not the owner of this patch.
> 
> If you handle the patch and send it onward, you need to add your own
> Signed-off-by tag stating your right to do so.
>
 Ok, I have resent once with adding Signed-off-by.
 https://lore.kernel.org/all/20241028135321916ZWK032bHhlbncjvmzDkZs@zte.com.cn/

 Thanks.

> Thanks,
> 
> jon

