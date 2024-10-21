Return-Path: <linux-kernel+bounces-375159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E2D9A91B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC6B283113
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A41E2309;
	Mon, 21 Oct 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CpnQpSrB"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD01FEFCF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544404; cv=none; b=TrFmOIAixglTN2p+mkjPli9F3P8mj3XCA2EUwphnMTsZTVW+p4hY8hhh5TEgeaCZW2ONCliahHWgBwmYDkvc860FZa1v97238abKUUU/HF+EdEq6vN6xMU5tzyIMBP1rzB+Gb+ZbbZK9bsKkW7gaozertXVcYuUFRMTr1bZsr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544404; c=relaxed/simple;
	bh=eRTGi9a6Sv3vu+lXJcenWIWVMpv6YjjepcvbeHQpmB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMDgumnHjocbzIa0N0vwkN0ilAMvE6RUVwpDGqMWlbXoET62/KqL1ynmnxvwRaGfoeNHRbBPz+7fhoJKyUs+7yGYx0GKOktgllEgMamoXUwq+RU04Zh53m+MyjiZN15G/RiUX5F5Hlt7lv0owoDFaKOzjsxYzVKYqqIT2b8QO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CpnQpSrB; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7181885ac34so1947134a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1729544401; x=1730149201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/JhqoMr3xoBLhKxrDtRkiy+pRopPWWzIczRczK9VzE=;
        b=CpnQpSrBZvj39oY1kRX9EVpwFRQKRBKD7Y8i+OJ0Bju0YcDyrdY1YdM+zS9LOUhJ//
         WmwNNmaMXUh7BI1XPiR9vq94F0tfzPy+xpiJVF816xRGXWWFiaXDlWi8pD3IxPy6zbaN
         Hd/1SdqSU8NQ5rgM85dBDlW9QgPLKmKw6Mbaui5xY+3b2d9cGz9vonLgvZKARtwLgly5
         FDirP+EHjp9EAA85gwV7PLt6baP6YkbCOVODm0L2PJAKzHRRj+vXmq4X9UNkxntvber2
         HxB66bhiV961h/wHLviYDoKveVJDrAyImGPFPxwrJMZWVLSrp74xk2H4iLm+TCbDDIUL
         EmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729544401; x=1730149201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/JhqoMr3xoBLhKxrDtRkiy+pRopPWWzIczRczK9VzE=;
        b=eeGbnM7UxytJzvzsv8oO/yHpvloZp5AsXxHTC1bZQ6H1pePEgqw/UsQzws9RWTZT7b
         OJOIG6ryXIzcxwD5rE9vepuTmCH3bQVGq1orwlxj1MM02DJSBGEmRT+oOoB7e3tJ69JY
         Ult0Uxhv19AsjdE0VrHqjfHrfMWRN7T8EgB4FSpOWTus3alSVjfTZMuUxRwchtvTO9E2
         rjwlhwviplffj0rp3a2Dseh7poDDGsDvepOIoZOh6qQEQNmZmPJ0oSWflAMS7g3Ehq28
         5ls4qVMB5ZqW7rFBVHEichDrkMj8Gp6FP/noIbCJF/Qa5Jt/v2azB2PYJAK+5GobHJHP
         ng/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbHsV5Fa1VGt67RX5eCA7jvRqjrUTXcAIZtWFP55pNBtqCdZ0V0EuynDsLQJ0b/BGzXBF0e8TLg71yWRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSBbuzgao9vtxDHhc60y8jYigt6JpawIEpxXPUYvNgnJiOat9
	uiUJxpJQ3jEfr0Wcllyo5LrZLQSIa+yl9I39Qb0bStOELpI4UaKUIYxrUNDR//4=
X-Google-Smtp-Source: AGHT+IFpWmh1/AIk7Nn2cnPoq4vVfS0zH3srCfG0HQhaKxBCdKArJ0e8yR3KHsngErh/d7XH6wyH8w==
X-Received: by 2002:a05:6358:63a8:b0:1b8:6074:b53 with SMTP id e5c5f4694b2df-1c39df4e3d7mr490664555d.10.1729544401532;
        Mon, 21 Oct 2024 14:00:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a5c9bcsm212184385a.82.2024.10.21.14.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:00:00 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:59:59 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org, houtao1@huawei.com
Subject: Re: [PATCH] fuse: zero folio correctly in fuse_notify_store()
Message-ID: <20241021205959.GA2689703@perftesting>
References: <20241021125955.2443353-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021125955.2443353-1-houtao@huaweicloud.com>

On Mon, Oct 21, 2024 at 08:59:55PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The third argument of folio_zero_range() should be the length to be
> zeroed, not the total length. Fix it by using folio_zero_segment()
> instead in fuse_notify_store().
> 
> Reported-by: syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com
> Fixes: 5d9e1455630d ("fuse: convert fuse_notify_store to use folios")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Oops, that's my bad, thanks for fixing it Hou!

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

