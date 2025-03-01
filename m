Return-Path: <linux-kernel+bounces-539658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165BA4A6F8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C923AA45B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE712B73;
	Sat,  1 Mar 2025 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gpv7V+AI"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D846A134BD
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788768; cv=none; b=rfN2t0NBUa1BMRs33Wg4ywN6xmMSrVy7yUz9OW3nf1doLBkT58+11JZICcJl62EplRIdl9NWEUgq/0pFOUwbDBkjMKlTkpQRwPC5pwSiBmTOk1BxSRp8miOLqc/fqB5O9YDHkrYr1eQmxX3pAx7YmWZsT+JjTAuZE1Ze9jaTAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788768; c=relaxed/simple;
	bh=jt+YgGSiFXOrJ2kMp5YlfSPDZmSqABt1Sm51ooGPve4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2vP2NaWnYGF3FcPU2KwrBuwaYqLHtLtGcHuqLQDl4TYulPK549lEI3zQzauSOAdvmgxOjzhBEHwrawyoqXOS+ECWhomKNG1goqwcHkdpcKun2FRIuA2Cvr3mLK1uyIH5Kl6To+EB06qMTmfCHufU25PIOVKa+NgPRq8m5GlgpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gpv7V+AI; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c24ae82de4so260695285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740788766; x=1741393566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MtjatnVjNgixbPBCXKK66vO3DHibToClD747DlzON4=;
        b=gpv7V+AIvU6HPQK/fWhrX9SypMpDstpd6Ga5Dge/1xDOpsTBmteK6W5UmEiu64Ob03
         qLblIWyexxvbqX9E5t126afmtuaEw3piR7Dlg81JINouWlTB+UsXubzFKIBi7uLDeZ/g
         VE+yTWEYQi+abKsSZJaTARDKtV8MXd4LOMuw/BA1quw07K9luLwUe9UQpANKm6rF0kAL
         26U1JQeLEQIPrlZU2n7U7cSSIlAY1pkz+ZLy/QrVFUID4/qp1czyWJvEztL9KGLZnNgA
         WLHF2RMGC0BD7e+UnvMA+19a63JE1AKnJd/kfEbA3F3M0VdajsmXaw41DpwKHUjglIgW
         6N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788766; x=1741393566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MtjatnVjNgixbPBCXKK66vO3DHibToClD747DlzON4=;
        b=F4GrfRCYXKkcuz9p3hkI7NtVKzjWD0lLoK+wTP/e5C9h5uoc+A26qWOSR1WPXjk6nI
         PVHeMQW6ve0uY6NlGFUKqpfjGXGL/Z9Z59rFyrNQjDoExbmdSuZmKFyzP2Z+osEbUPZa
         ugq0BTqoOGxE7czpmFPZLTeQWvFAGWBjiN4DFZIxnNTH88+w9kPAjT/yjkUCz1L8bMQR
         sMwp9WK+TG8faTRKZh7p7gBnk96qlwhJuNlALsg6cY/4odzvE5ar5sPvBYsWASaCsQ/O
         ZB1XaB6DzpwjK++K2ie4hskdUSVWBNBgqzTVqvhIOtMPt25Ui76xuWLezEbv7ErrwPog
         KLWg==
X-Forwarded-Encrypted: i=1; AJvYcCXb6osyHOic/h+dbFwFjJLUrBJSUX3IZbrJYdvRGvP1ITdwhFhbrwQ04vrgPEkuS1wVf3Evebb+NjnxiB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOugGuj5m3YzxYJfdehC9eCn08wiWZlyXT5mpy2R6p96vhYqkX
	2+KQvAzfiIf7FZ5Q1Pyj9djfZ/pflDHPE6ueQaxH27i1oWJm2vQjbLbhfIwO1Js=
X-Gm-Gg: ASbGncum37RUmvuGryILWT1WwXdVSQuD+FJ+Mxkg5byDaNzB5HYQPrg76FFUmQbY/aM
	K5i92HNekIogeVCP4vvYoUit+CwY2mICR/KbWa/6msfhfz9IeOK3nIBb0fYwhCq1y7EWinK8U5B
	ONhy75RK3FSr66gkfuiIqKetid8HDg54dPRXOcbs2wHFTfRKw0DNzbpNSljrl5F5PjY9dmVb2Ab
	oa+Cn2If6mdMgQuhHSGZIZVXLhaC1Trjw11u8ucqzrOezTh+ZdEeksZl1T0ZpQsjTvYcTRUSetY
	MHtW072Q/7l1kE0Y+kY1QwLSwJPkboGlxXs2Wo66CoX1Wh05+PZut0ef+fK1kTadsNkWG0ZS/1S
	Jm1ic4xd1KQQjrFHamA==
X-Google-Smtp-Source: AGHT+IEyduZmKmDeBUENZfmGzGgg3DhASjWA/ktGwI0e/xDC6fTyc7s+TOl/wjMJMYfdyHxWvUKlYA==
X-Received: by 2002:a05:620a:394e:b0:7c0:b7ca:7102 with SMTP id af79cd13be357-7c39c64d2cemr801166085a.38.1740788765786;
        Fri, 28 Feb 2025 16:26:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89765377csm27572316d6.45.2025.02.28.16.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:26:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1toAg8-00000000VLR-0rfV;
	Fri, 28 Feb 2025 20:26:04 -0400
Date: Fri, 28 Feb 2025 20:26:04 -0400
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
Subject: Re: [Patch rdma-next] RDMA/mana_ib: handle net event for pointing to
 the current netdev
Message-ID: <20250301002604.GN5011@ziepe.ca>
References: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>

On Fri, Feb 28, 2025 at 02:41:59PM -0800, longli@linuxonhyperv.com wrote:
> +	struct mana_ib_dev *dev = container_of(this, struct mana_ib_dev, nb);
> +	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
> +	struct gdma_context *gc = dev->gdma_dev->gdma_context;
> +	struct mana_context *mc = gc->mana.driver_data;
> +	struct net_device *ndev;
> +
> +	if (event_dev != mc->ports[0])
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_CHANGEUPPER:
> +		rcu_read_lock();
> +		ndev = mana_get_primary_netdev_rcu(mc, 0);
> +		rcu_read_unlock();

That locking sure looks weird/wrong.

Jason

