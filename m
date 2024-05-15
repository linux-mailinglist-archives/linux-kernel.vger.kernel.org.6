Return-Path: <linux-kernel+bounces-180028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08DE8C6904
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C26428378E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FD115574D;
	Wed, 15 May 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbx7+7IS"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2778155723
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784653; cv=none; b=BxoBKcIOCUicEDeWZ8rYVGMhG+l3s9K12PSQH6+sggjFWh1mJHI0v44TXRxvpKdZkQ1Zo1gzqT4VI5yWq7Apw/zwHrs9abD7BgsPO6uGimIZSbC0laR/pHOfng6ZzXGIgf3Vm4uMebAb1MHgojyu7Vgkj/SzYKLSEA1shuDK+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784653; c=relaxed/simple;
	bh=5TCp5CXvuptPmYaBhT5jPeD5TXNBV/1+PLyuz7yUB3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuWkPgNSGa0PX9Ua/K1tQheCDDkSOZk+ZDl3u+1l2ugGqj2b6mcIYqGndWtSTNIHM/fF/3BK0CyITVbmNr8qi0/hTNS0RoKQoqqHyfgGarYd9q4lFo0YCM/FldA6UK1LAJ4/pcQnMFmwwznrWg/5uny5XG018qwoXk+4QyQnGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zbx7+7IS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so34201235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715784650; x=1716389450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm2oQckW7dl+Jy0xL0CP8kgBBxNAcYsRe32+op0a91g=;
        b=zbx7+7ISHCCqkG5AC7HaiHzS71Te2zaBV42OUjPY+ceSz5DlR3aljW28eUu26s/wPk
         KHGaig/Rns+tZjWhTmXWRMkCxoVu3iduVgLpiT9YxmJGyrLGCJESQ8ESQ03you9uuwsE
         hxRZMelNgjxZ6NbH9BvbjrC5Zlywz9P0VmzSTst62t0bJFxXBzXiUZen0RypWLwtUTqB
         mdN0+yUeEUEblHWb5QwFgs1Ep2AAYan2XKQmnida/kjxA3P8gbZVG0ZvFjLa7h0zcIl5
         uq9t3KsXbcisEjDA2zJ7o68MiE0VsbhV9DFlNHLDBEJo1n6GOT3OEBfi/kHknyABvNd6
         Qq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715784650; x=1716389450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm2oQckW7dl+Jy0xL0CP8kgBBxNAcYsRe32+op0a91g=;
        b=f1caeDmQ+FERVBhrjD7b2KsCKbA8/+tsAfMR8ZuR8aOqFBw+D8/bAGDrtSKpz8uHjv
         a8UMjfCIOjuVPe6y8LEAyCV/grkKwwZ6tGpkjD5FGqAmUuVJVu1cMwrGk1C2L4XbkWoo
         K2lf2fpgcVD/ZSwzV+8413GOyqpj+Cz6XWNvNmNQHdG3FOkL6d9yotAgGV2pnWdgW4x+
         ZxRT57iigqA8eROd8W/0Og/+AP7SDEac0C1srpv4wlh3NdzyHeQk+70qozvTxPg0davL
         qW0mnHu2mSk+8CyilXBVO2edW7JUL10d8sHGWPfQkLzayPPv36pn9qiahMnddGm8QDkG
         kPuw==
X-Forwarded-Encrypted: i=1; AJvYcCXINwjSSdDhWOwdr53dxf8bmJkYObasoeMhB6QhBDYC7e35tlUAWddpwQFAV3dfAIftsB9uE9oNf0e/x0TcR5lKHK9RAQIv9VZ5cbJj
X-Gm-Message-State: AOJu0YxTDfWY99vj6rSLMjHQC57TAoStFw1USS3jOxPuU2umtNqFx+6m
	ODvH3giAItqMvL3qAqk67wDa2cUmorqfORxyRnQwXdSxvUGeUE5kp7dFmMwYZjw=
X-Google-Smtp-Source: AGHT+IHc88s0jQf5xDyEKdeY62SQPNAtebdb3EiQmKtKM1DRT1aZC4sH7hbL/Wt0Qqg56kktMNhVNQ==
X-Received: by 2002:a05:600c:3502:b0:41f:d4e1:5abc with SMTP id 5b1f17b1804b1-41fea927ea9mr107194485e9.8.1715784649874;
        Wed, 15 May 2024 07:50:49 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff063d8cesm202702315e9.46.2024.05.15.07.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 07:50:49 -0700 (PDT)
Date: Wed, 15 May 2024 16:50:48 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: Fix error code in
 __virtnet_get_hw_stats()
Message-ID: <1682873e-eb14-48e4-9ac6-c0a69ea62959@suswa.mountain>
References: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
 <20240512115645-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512115645-mutt-send-email-mst@kernel.org>

On Sun, May 12, 2024 at 12:01:55PM -0400, Michael S. Tsirkin wrote:
> On Fri, May 10, 2024 at 03:50:45PM +0300, Dan Carpenter wrote:
> > The virtnet_send_command_reply() function returns true on success or
> > false on failure.  The "ok" variable is true/false depending on whether
> > it succeeds or not.  It's up to the caller to translate the true/false
> > into -EINVAL on failure or zero for success.
> > 
> > The bug is that __virtnet_get_hw_stats() returns false for both
> > errors and success.  It's not a bug, but it is confusing that the caller
> > virtnet_get_hw_stats() uses an "ok" variable to store negative error
> > codes.
> 
> The bug is ... It's not a bug ....
> 
> I think what you are trying to say is that the error isn't
> really handled anyway, except for printing a warning,
> so it's not a big deal.
> 
> Right?
> 

No, I'm sorry, that was confusing.  The change to __virtnet_get_hw_stats()
is a bugfix but the change to virtnet_get_hw_stats() was not a bugfix.
I viewed this all as really one thing, because it's cleaning up the
error codes which happens to fix a bug.  It seems very related.  At the
same time, I can also see how people would disagree.

I'm traveling until May 23.  I can resend this.  Probably as two patches
for simpler review.

regards,
dan carpenter
 

