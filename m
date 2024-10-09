Return-Path: <linux-kernel+bounces-357903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24175997797
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548F31C21BBF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C6C1E261C;
	Wed,  9 Oct 2024 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="heqPBuoF"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461A19006B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509765; cv=none; b=jLD0rvdWoI+0QRhRNto9kC/m/MG4jA7LYhhpInr+Nq3md9yRus6syRrudO7vp7oS06tFs4+RhTeTDVmG22MHxeXKLTYA5T2HPiKKCZl8XCDDkzkbpvtxdwHRFKJPABKDfh8s0qvfu2YAfKkNGnzP+LyBMSjxSiXx2uJmKa+32oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509765; c=relaxed/simple;
	bh=V+UM1KZqe0MyoAcGD+VdzdsIs5FGD13ixwV3wVKKATU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=folPVrTEb+ssASVXREI3SEpsmSEJpaWncUE00ZLvsGLcmoADv5ra6DW1f1O5Z9/p6zp70U7GWkt/XggJ27pcWwABEHpg6I1R8hyU8hArrM4Wv4oX+DuQYDVitNkZMB7DV/obuKo31DGtqlnL/mNjLvnCFusV2maDch4QPnyrq9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=heqPBuoF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e038f3835so281594b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728509762; x=1729114562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iq91ha5qoJGNUtqOzDNWyHHNeSPTI4MkpTmh1lIw4EM=;
        b=heqPBuoFaRrN0192RAWH7KceUaunfjTMhVkCwX9GLCflECErPUUiLpse8tgEoRy5bJ
         lkKnCpl9zHzqDYvv0hYGjmxBS+uw34KqLZqNLkmtGRLEY9KQetzQ2DBcyf52NuG/+AY1
         TR6601WE5SfKjGakvXXNIJa1r/bZJ2sjCYfwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728509762; x=1729114562;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iq91ha5qoJGNUtqOzDNWyHHNeSPTI4MkpTmh1lIw4EM=;
        b=HesP3FzYe5+Izh9qNAo2kLBmz2DO4uJX/CztUBgakZGCYHvtx2pfPmlezLOU6bpvGp
         l40pSzcsA5nkZWJBfb4RPjXUo67wUUwV9/wSXqX7EpsIad2VXqGCnSFCluW16IPyoBG3
         FTWofvyioMSgteQniyTZ1FAJV+I/WV5p4rKL+1J3XQ6tLsuAwlcux6FY/OTkaMe17CGe
         Ylle+51UAyDgTDU0QscR+jLLBdcwDG63W1mrobogpwDoT30TJDJSMWheeAdb/wEIIN9Y
         OoCZTsBYtZbbvof5QYluKlVWFRJ53hFEbIu1PXqHP3SfdM1kxDc2EReZ3IFGavKFxmup
         E9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYfInW1MWZnZP9r6lnUA1n7d0/e3z6T27hgubXyL7IorM+nV6sH9woAmLGY7dFWuwCFVkY7TXnfzdTGis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaExiN/+G5MA+vXzDiqLtSgM722+0Ux0/SlW9odJ/TT1n29H1w
	uib3LVtxtNs9FdW44h1u0lqTnzV06klcNb7ankm50GC6q8Zd9XIY/sW4jGDG80g=
X-Google-Smtp-Source: AGHT+IFGKmchD6PQPRJnQ/WVk5jcKczkOqSly9YXT2GW1/t8dXc0PBMeSq4cyZmlTpCF6bJuKDKSzw==
X-Received: by 2002:a05:6a21:4d8c:b0:1cf:6baf:61c0 with SMTP id adf61e73a8af0-1d8a3c490e1mr5443108637.44.1728509762443;
        Wed, 09 Oct 2024 14:36:02 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4663csm8241895b3a.106.2024.10.09.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:36:02 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:35:58 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
	horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
	christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
Message-ID: <Zwb3PvG_EjwqMT4v@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
	horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
	christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008022358.863393-1-shaojijie@huawei.com>
 <20241008022358.863393-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008022358.863393-8-shaojijie@huawei.com>

On Tue, Oct 08, 2024 at 10:23:55AM +0800, Jijie Shao wrote:
> Implement rx_poll function to read the rx descriptor after
> receiving the rx interrupt. Adjust the skb based on the
> descriptor to complete the reception of the packet.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

[...]

> +
> +static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
> +{

[...]

> +
> +	if (likely(packet_done < budget &&
> +		   napi_complete_done(napi, packet_done)))
> +		hbg_hw_irq_enable(priv, HBG_INT_MSK_RX_B, true);

I am not sure this is correct.

napi_complete_done might return false if napi_defer_hard_irqs is
being used [1].

In that case you'd probably want to avoid re-enabling IRQs even
though (packet_done < budget) is true.

[1]: https://lore.kernel.org/netdev/20200422161329.56026-1-edumazet@google.com/

