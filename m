Return-Path: <linux-kernel+bounces-339886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E52986BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A5FB252E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6940D172BCC;
	Thu, 26 Sep 2024 04:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RmcdBckm"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D24120B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727325695; cv=none; b=Pnl413w5gvqjDX+/4gewVPzTF44IgVdHGWoh/8bt9ojJf7WRkvLISZh9FENtY8zuK/NOgP5e7FYrU5Jq5jtnBgkQ5mfKLIxw4Wwy7ay1U+Ss2ozZAlIg+kL8qHoSt2XRZam/6/gt8xG1bIDbzO6AnfNXNtSBYd607CPUAPdQ0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727325695; c=relaxed/simple;
	bh=tWHyjY9HXACvx+Bs69UkAw2f+LmrsvPg2gVTucv/eoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4zUX42Kvr7+cPUHMcy4EzQ8Rf9Xi7M4gbpkTD9LjJmw/IQTzN70VGpfIMWDDkKqRV0uSxuRGIb88viqDaL1MIrmweHCbCNZ2C3qnzD9gjTOLCotlgfbshtB8+OjL9JhMFxcg1jbuKSazGxgmGns2BjqtP4F3QycQLfiqpcvBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RmcdBckm; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718816be6cbso515962b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727325694; x=1727930494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/IK77nxbBZEPITpwoYAt/gwthd7nkAtPQWQqMMDw4Ls=;
        b=RmcdBckmPA2o+i1BJkyHIfl+b6bwMYscOe72t2pPEtKtmu6AwI5Te9v3cTQtBcN7nY
         FMv+l0FBzrP3gONQd35Zij7Xi3yybP4xJS2SsuVemqWZqEfMSL/ytb0cKfVVoznAkJ6H
         6b1pCDZbYxCxdjiYNpLXbIN2TgLANSgx3lD+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727325694; x=1727930494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IK77nxbBZEPITpwoYAt/gwthd7nkAtPQWQqMMDw4Ls=;
        b=sKQs12tLkQFj886zHLjnTx7Dp4LJ7kU0xgzTjKPE+Mdyt4f/2UrVipiQD67d2HVbdR
         +BasxYORUyPbqqtKiijoYfuKzim8khZxQXg0Cnyn2zwNfXs+ZaNp5+dZGpfRnmHi2omF
         in8H9nqt+fpfWfKq2607GVyJIHlWTRKRwJMM/KzHE+i+RR5ySOXusIuZBY/9tgFgUu57
         6mMViOvsEW44oTppHnMdj43k9VJcuxJSClIDAxeU3/L1Wvd2MW7i4Y4jh+sHJmBrmr21
         dOZ3U9KaiJveAq8h2zEMRj5hSkjn7NOaC1++ExzjFiRladEMrBdyI+Ulgzg9SD4e1/ca
         BGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtiVpv4zvbw3wRKQm970j6WXzFASoWYC4PO4Q/uLV+zKVi2ejolfBiMr+Kkz/AXkUolEyExxovwcVK6Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fR1/77+oGNzV2XIbMNwXU455mxYjvVTeEh+hY1V7EbVi4IRb
	jQq41l5wgJyACp8QNQERiIKSB7gRmO5xodZYUWGfKqXq6AVjufmR0NRzSV3Jiw==
X-Google-Smtp-Source: AGHT+IEOD9BvUk8bvWmM8arHd+awbM4tS4muPPp5om+HbilxjplSMNBHUU3yJEROXfLfGcQzr2phbw==
X-Received: by 2002:a05:6a00:8a81:b0:717:9754:4ade with SMTP id d2e1a72fcca58-71b0ac43ebamr4852805b3a.22.1727325693745;
        Wed, 25 Sep 2024 21:41:33 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1560:84f:e0c8:d5d6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c6b96sm3476773b3a.191.2024.09.25.21.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 21:41:33 -0700 (PDT)
Date: Thu, 26 Sep 2024 13:41:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk, p.raghav@samsung.com,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 0/5] Improve zram writeback performance
Message-ID: <20240926044129.GE11458@google.com>
References: <20230911133430.1824564-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911133430.1824564-1-kernel@pankajraghav.com>

On (23/09/11 15:34), Pankaj Raghav wrote:
> Batching reduces the time of writeback of 4G data to a nvme backing device
> from 68 secs to 15 secs (more than **4x improvement**).

I don't think anyone does that on practice.  Excessive writeback wears
out flash storage, so on practice no one writebacks gigabytes of data
all at once, but instead people put daily writeback limits and try to
be flash storage "friendly", which is especially important if your device
has to a lifespan of 7 or 10 years.  IOW usually writeback is put under
such constraints that writeback speed is hardly noticeable.  So I'm not
sure that the complexity that this patch introduces is justified, to be
honest.

