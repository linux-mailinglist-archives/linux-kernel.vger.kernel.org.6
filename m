Return-Path: <linux-kernel+bounces-549778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E988A55730
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0002218999F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0BE274261;
	Thu,  6 Mar 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bFPn4Wui"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A69270EC9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290838; cv=none; b=WqxG2+5ytaJEn+gzzj/9gmkT4qNL3RLKLncIpgHK6raBG5VjAPhLnglrA9Hk2ryUOTeueZaff6mns/hDm25JoARiJzm/E0NxGWlgF4fHwYuOUNZjrgHd7KQDVUXVLKBN6oqZa291xWoJsmAZTrabGqGFraePo7xDKzKVfU1GUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290838; c=relaxed/simple;
	bh=iSKcr4EnKpiqI9Vm20mF226SY1sqzT7i4gJiswq5lWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYRdB/88BWnnpBpdV2XpkagCFAHZhwyQuMG6K7bE+UiHa+BhDaC68isfjGTFeEvg/HkPxd8xMreZ7gyAAnjrRkkDmW9/xdsOs993TRhEomo6Zpc2PgolCfXpu3KvR8WqOY5+abka7OmL43iK0t2gd6RNfWTv55p349BiBBWQEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bFPn4Wui; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c3b44dabe0so122418785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 11:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741290835; x=1741895635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvFqmpmbcQZU3HzVSLSr0IyMCuH53u7PNYguyBEwL0Q=;
        b=bFPn4WuihcX3QvOSuxxYYLccbEBmmFAuQln0piO0dO23rDExA7kmxWzpu1EUvB3aqz
         0oMLT8hO4LAyrsKXoerQFoNUj80ay/IhXSu+cQGPVzcYY4heb9jUudUQkRh3ZTdSOHy6
         YXo5fKHrCKYI+3xvNuxabBFl7S4dzSzzyK+nCzSIyv5RNSYTRH3Bkv6pCXMgTQYMDtAD
         qu5EU1IozfpUNKPTETkjvDYPymV/g/Rast9ir6RqBdAuwYQNWDh08E6h1uiw5FgQ68jT
         7lCmfXy7NN+wFy8Pi424vyCqw7blQEgK5T4JAAwyP+xaz6tb7vbcFeNRcPfgltfEE049
         KWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290835; x=1741895635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvFqmpmbcQZU3HzVSLSr0IyMCuH53u7PNYguyBEwL0Q=;
        b=eSXEGVB4t2Q47c8ZU2Hql/mrVcwDAKB4dFOe40GU+ICPzofC/tQrqinYkkCqBYV9EZ
         iuMnlHPIlewEXE9Lf66FJGwjntMAxnrxrEFy0HG8Tp6s8vlg9N9IoeuePmWVgk+fyELm
         P73JA41kCLDs4omUQAGSjTHA7jktvwnbkpQNOScjsz1OHJ7lQczhaZ449/cVpAWlKpKZ
         rCx9DmrUJkYipcQzsdHsLXKVrWaTSbjaqD+857CFcKrhAmEHtDCVUuRqjZWmeLh3ARgs
         6PzpWmLLv6Eb2z4RmdmJCImAnnnUxUtgNpNN9DZPA00ffY14xuPHPiFSabVMwrf8a7nj
         /gRw==
X-Forwarded-Encrypted: i=1; AJvYcCXlYhFWx/IP99U5uNQ/wb1UJ8Ni1hTDl/mUACMGWefF17J3Xv94gkWu44lJpRR7HU2e+XbYzFFGm4t5oAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybOiOquKtBjzSvUWn7rZXzOtbHmPkLrW1FrGXJ31bYBh+bSBk2
	AVL6dNGFAY+NVmovK1Dc72OfDzxevsPycHnS6ji0F6ThvtrZN0Plfi6aiKH19UQ=
X-Gm-Gg: ASbGncsvDvCCzt23xOt2PSBE6COS9+yPx8qRV/18qlnHXscvRCPhY5NlyW66jMRM2Su
	yuz026yEVKGeBJYkLIiVbhXhIDcyQNcz+TOahDnAsaSnRWd84WkpRrCZ7pVDi6QSEFTgP43LYce
	OE5/etgJuSQoqLEdtruvcUeIY8D1UbBVEw6SCeELnU2BUV25uWOijsu923QOc1X40d4wanG9ctQ
	JTVbSy3JVuWWqOLSUfbfYuSEoOi6C3H9OqqsR6UD4I5yWuHRx3FStQ5nw3YFdkr4CBdXTNUY7Vc
	m61z2lYXRUF4l0IMxrCfTtP12WaFG46VPmgxRtHrIzDqYjvYhS117JW3mJotPJQohwE9uJHsr6t
	z1TLrJHG3UglVAOcWTw==
X-Google-Smtp-Source: AGHT+IH5m1Jox8CfH4jOxkXbL+wqEn5oIztJ9Ikf3gVuh+SbDr69e2lOimMWgZyeibm6K/JApYccoQ==
X-Received: by 2002:ad4:5c8e:0:b0:6e8:fb44:5bda with SMTP id 6a1803df08f44-6e900609592mr5341976d6.19.1741290835448;
        Thu, 06 Mar 2025 11:53:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c514sm10606706d6.24.2025.03.06.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:53:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tqHI2-00000001fCB-20Yh;
	Thu, 06 Mar 2025 15:53:54 -0400
Date: Thu, 6 Mar 2025 15:53:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: longli@linuxonhyperv.com
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [patch rdma-next v5 2/2] RDMA/mana_ib: Handle net event for
 pointing to the current netdev
Message-ID: <20250306195354.GG354403@ziepe.ca>
References: <1741289079-18744-1-git-send-email-longli@linuxonhyperv.com>
 <1741289079-18744-2-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741289079-18744-2-git-send-email-longli@linuxonhyperv.com>

On Thu, Mar 06, 2025 at 11:24:39AM -0800, longli@linuxonhyperv.com wrote:
> +	switch (event) {
> +	case NETDEV_CHANGEUPPER:
> +		ndev = mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
> +		/*
> +		 * RDMA core will setup GID based on updated netdev.
> +		 * It's not possible to race with the core as rtnl lock is being
> +		 * held.
> +		 */
> +		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> +
> +		/* mana_get_primary_netdev() returns ndev with refcount held */
> +		netdev_put(ndev, &dev->dev_tracker);

? What is the point of a tracker in dev if it never lasts outside this
scope?

ib_device_set_netdev() already has a tracker built into it.

Jason

