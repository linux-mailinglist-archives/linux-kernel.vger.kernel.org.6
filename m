Return-Path: <linux-kernel+bounces-352313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E5991D63
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744961F21DE6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4111A1714C6;
	Sun,  6 Oct 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoUFVP9D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D32AD00
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728204800; cv=none; b=DnciLK7mmRvDu4uWUPUW2iREmaJJkLG2t7VfVcy7XpSCq+zHe8YijZvcQlBsguqAu11O6R239iAPQqB/svl2TcYS64R+n7t18vpncB+E5CyIE6pJ3I7ESQh4cUDgaEvYkzRDjWEjeyMsf76pfZhIiZwi6rEwzFl4sjlaWR1jnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728204800; c=relaxed/simple;
	bh=/2kG7far6V2fXoI/fHTF/tT/0KRJ0Hwr8/MaHXSfcNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r41j1Ydg+EedMXuxHZVFnUukh68YRexP2IZGknOt4TCm/7pz9OsE3Bq1a4V32colrZVvtrNt7nqRfltuojSNU3Y/Cw9qq6yrJoVG3CnjvlXgenCFtOk1LOl/S3kBQztxnqXHOuvkNEcH2Erge6C1N96yZUDuA2yZCswKdcY0AFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZoUFVP9D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728204798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pHj6OMuMnsa5+kbla/V2LZIR3F5CZcFmLCBZummd3Dw=;
	b=ZoUFVP9DtDEAzds21477K02POSN8PYff1gvXM/L8QSgPsAZNy+XMiNDS+9T1Sq8F5QcwJl
	SOx3eaEBc6nRJ7ddMPDgS1lkCDgVmSVETsxK/KBUndwe11otj2SZTBCzZTm6Of7il589kn
	zEQ/AOs30i8Zl+yucJ95Li7geGdcdvY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-sr50tzfuO82bwt5obBbRtA-1; Sun, 06 Oct 2024 04:53:16 -0400
X-MC-Unique: sr50tzfuO82bwt5obBbRtA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cc4345561so19946465e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 01:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728204795; x=1728809595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHj6OMuMnsa5+kbla/V2LZIR3F5CZcFmLCBZummd3Dw=;
        b=nl28TqI8iOlGppKF2bFylmnfc7mPtm++gA1y68r1XMMeEGHYdoF66eCk9pB9VO2rwd
         T7VljsC5t4MJVmnF5m7LA/qlIPjbKfmNXXHA+Y2ntJKMcuMgdB2pMUPvmoPvxD2gzzup
         hQlqQ8RPohDr1GJpzF9Uai1JV1VWbSR1my36ddXk+DfMSB/EI5Tv1JG06UkHoq5Zyosc
         llV5TThCri+CKtBZwPGj5fP0ZAx6ehOc4sUx616SVx+4RcbFAMIQoDxfRprJ25GaxlyV
         qvdMRS05g6j5Q80qM5YNVCtUgk0mNKzFgGBT6eCVKFdeJEiZvOci0rIHdKmIF1ragC84
         //dA==
X-Forwarded-Encrypted: i=1; AJvYcCWxMOLFcXhX4c/ubLDE3tkU8zmAvE2jgNrNdGmPn1NYsJjDNZI8a0i7smxDUEPX8eHkk0sZlbE07fBRZaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysgrASlssEH2TXqrtRbk3iTQNkNlurmtPBkCe/rskBdqxZS9xV
	+KdkN0FsW8hOobi/nATbYJxbe8UCrE41xhM9teDqnsnOR3l2dPG49A6WApjNfWqA4JtiqebZi8C
	loJEzk3iIhXQ7Jae2fPOOgJh6OOGa1F+YeLXM7RyRcuQbn4TSIaHrYwEbyZMnZw==
X-Received: by 2002:a05:600c:1ca5:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-42f85ab471cmr59426525e9.8.1728204795451;
        Sun, 06 Oct 2024 01:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJcw+Cphbjs+ue5EupQli+CCu7PMJTmakUCn91rJnbEToHavqoOxx7zeI6FY3Ptz1Foh7FcA==
X-Received: by 2002:a05:600c:1ca5:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-42f85ab471cmr59426285e9.8.1728204795044;
        Sun, 06 Oct 2024 01:53:15 -0700 (PDT)
Received: from debian (2a01cb058918ce00f941c1979dfd74a8.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:f941:c197:9dfd:74a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0a894sm59746175e9.8.2024.10.06.01.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 01:53:14 -0700 (PDT)
Date: Sun, 6 Oct 2024 10:53:12 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn,
	amcohen@nvidia.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/12] net: vxlan: use kfree_skb_reason() in
 vxlan_xmit()
Message-ID: <ZwJP+Jx5xHfWR2zN@debian>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
 <20241006065616.2563243-9-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006065616.2563243-9-dongml2@chinatelecom.cn>

On Sun, Oct 06, 2024 at 02:56:12PM +0800, Menglong Dong wrote:
> +	/** @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metatdata
> +	 * reached a device is in "eternal" mode.

Maybe 'a device which is in "external" mode.' instead?

> +	 */
> +	SKB_DROP_REASON_TUNNEL_TXINFO,
>  	/**
>  	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
>  	 * the MAC address of the local netdev.
> -- 
> 2.39.5
> 


