Return-Path: <linux-kernel+bounces-296034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B445F95A4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5851C229D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065D1B3B0D;
	Wed, 21 Aug 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rdznu1Ui"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F14E14C5AE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264588; cv=none; b=MX5GXytP83H9EJNznChznVDBOlfAg+WtjPuYoRwepYwkTDCKBn1L89m2g3md/B5JlVeFuRPvq31ciKyJlQGfdq5md7gMnGPiCO8ldYC8I6t6bPfFTtK9DE0dy50LU0S4WtLR3ehk2v8QT4c7ST5JwpWIueABJDyRt2szkPs5uDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264588; c=relaxed/simple;
	bh=QUKGxRkk8/mkSrwuSlLsSbgUgk5OGBB2HN54PKBTREc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MymgiE7ankMpqbfqstCoWRJqJ79gwarfG/xIQceuCC7SpY7M1j3qDtBvkkapgPfWgJRJRPDoIfoU1zaBbQ+9/eQj3Fxqw1ByikGNkS4NEs5Q6XBTjjsTNIDrdmVC9J02sl/UUnE60JGsME09xHHj/299HtpiMn/9EUB8NeAx9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rdznu1Ui; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so4724a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724264586; x=1724869386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MhXaKx6yN6hoftmycyXZ+ElE9Hp5n6s8cfDPZOoBHM=;
        b=Rdznu1UiWBQXHII0d9VtNiEQTs0b55FaFqdDeQV7brfPBvlpXTRWMn7DnK3DrfxpRi
         +UYMvv4us+Bf1qMynRnjXzOta1Xv3Hzl2BvLTt0OXuNkyqyFLBKN6l2CPlP1tDinAz89
         N4JjbniCC351dDfieDjscF82G8/QbH6qe8ZOTnAHrnbaDi5Kci6VjTkS898ZWDkZyFeO
         /1KO6LW7SeuDyKMbjSN6tVUKsUPCRBelGaTzzVho90ZDQzCnZw+7VmiHD4snk3UdbA1D
         dj0t0WF8oBv7t3KfTYq7hwplHoQC1trD54Dobi1bAkFkv8pRrdrWscf8rZ1DQtOizuJZ
         0nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724264586; x=1724869386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MhXaKx6yN6hoftmycyXZ+ElE9Hp5n6s8cfDPZOoBHM=;
        b=Lw1GO7VkroFgUorHBTwBqTJAAZ2Ha/INBPve5+/G20D/RMm2QBkCdPF6ecT84bdoag
         PuDkuKfA6WwjN7Jt72LRNgm1WSVDyWglhb6xGvZ3NVOvyGBYNP35hoB6e/+gwsuokhrf
         6DXMbfaD0njQkSvhghm3LV06aQRWHZqiLxqc7jU7MasOGMI4r6/oD04szGQwe5+E63lo
         ZgstYYq7EN3+xrYRe59xIzlcmeG70akD5z6T7f9CCdhXZ9VcdTgdl2jdU0Jbd4dl+Gab
         kiNnHUDbSTMWIwFB/6mWlbTdXBqeDxLavoKM2/cGOxyY/d5KEVN3kUTHlxj66Trh90ar
         rtEA==
X-Forwarded-Encrypted: i=1; AJvYcCWoZah0uXmAXnfgV5QPXD2MlbA2ZuWhuH3yvFGHDEeX2HKOzgbTpIZ9uRL/rlH6e9e1XpMs1uUCplbIgdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0eIDku7OScVh21wVodQjnWf0eXO+KD3HwyC9DpztxdNM6MrH
	bnASJayUCNI+07bw8UapI/NPvM5+fzYKSt56WMmBnWBOjiZI33/gIDr5YJNARn8=
X-Google-Smtp-Source: AGHT+IFU6t+Mu6hID3xlC+1CO1fUMB8oA7lQ5D7nMlujTXX6yhTp0eJws1S2crYlDzU/oWrgudCx+Q==
X-Received: by 2002:a17:907:ea1:b0:a7a:a3db:c7b3 with SMTP id a640c23a62f3a-a866f2d7aaamr178974666b.19.1724264585535;
        Wed, 21 Aug 2024 11:23:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394716esm942312166b.146.2024.08.21.11.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:23:05 -0700 (PDT)
Date: Wed, 21 Aug 2024 21:23:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Abhishek Tamboli <abhishektamboli9@gmail.com>,
	gregkh@linuxfoundation.org, tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com, garyrookard@fastmail.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Replace strcpy with strscpy in
 rtl819x_translate_scan
Message-ID: <510b12b8-91d5-43ce-a191-9ee0a6c91460@stanley.mountain>
References: <20240820184216.45390-1-abhishektamboli9@gmail.com>
 <2348e646-e1da-4deb-ab55-c438a42e25b3@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2348e646-e1da-4deb-ab55-c438a42e25b3@wanadoo.fr>

On Tue, Aug 20, 2024 at 09:38:22PM +0200, Christophe JAILLET wrote:
>    - if a "mode" matches, do we need to iterate the whole rtllib_modes
> array? (have a look at wireless_mode)
> 

Can only one mode be set at a time?

regards,
dan carpenter


