Return-Path: <linux-kernel+bounces-306964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC889964619
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54101B29BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F911AB51F;
	Thu, 29 Aug 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlsbY6AQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B1196C6C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937291; cv=none; b=kPyth8UdacYQX5w1XMpefrCl2LCwOKnfglrNIIrdbmnTETERlUsJJq5ieKh9Oh10mWnuON++nRQQFa+ou9BqiHU3buNbMyMew/ubC4KO/pn+06CCaUFiJA9r22cAY1LwkhlZR3soqWrrEzrwEpAp55RJ+KQdBebvKQEEytrrh2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937291; c=relaxed/simple;
	bh=Jm+pmtdf4qP9lPF5z1JGJhcaEsEtzSEatYaWyXpSPDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqsCPlhSR57nBoAUSLwlp0m9N84YJPI31SKz2TqMhrxYfugtRNwCk9hj/GYs5WNnX2Yo3srFg2ZTMzr+8tCowcGl1LLvSyNDTAp1AJAX8kgPzXn58d+mA+TIpKXdUhbKPrT/iIxEJz77OD6dRydo6V94jVskdW6zB4yb43sMKrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlsbY6AQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724937288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMkwOi4JjN6JJkWoqwgZkqx+R20QEZgxqkFxgjlzSuM=;
	b=TlsbY6AQF22oyqK6yRlm4Yj8WEJyKcB28J8ZDoPlgcmeSJQZSg6K7WPn8hbqLCkoqx35wD
	O6Lvi/yG4l8jebJvLBnPil0E80pfBxlEzR7WmfTVsLgbTrCvp2TB7GhoSxbLwwcr2taFBM
	l6+3deRgTc5khif1M7KEskYGpiUcb0g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-86uvlDFRNEqTMgQCkZjKKg-1; Thu, 29 Aug 2024 09:14:47 -0400
X-MC-Unique: 86uvlDFRNEqTMgQCkZjKKg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-45683a483e1so6982141cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937286; x=1725542086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMkwOi4JjN6JJkWoqwgZkqx+R20QEZgxqkFxgjlzSuM=;
        b=Ljm8grcNutcuZB044MUsZ7mrr4jxzLvMxdmEGZvUzzQZAiMrXxmq5nemJdDGQYXOyz
         Aq5NzMTjByuoZuz9WPKgfuonA3voJSN68qzdNWH/aYXZusrIpLq+Yrs+s0VlmvfErml4
         sYbynUK66jqr1dxdLcA4ORKUogDiiVqrCWi8hzA01e7QQN7VWmulTgpZF7UkI5zjEP2J
         nlZKZZfE9pIBuZ8HWc/JhoHc0o7T9DoEwCc/bH9EMEyqN0T2TS0FyKl1IZYnAq4N+CWS
         mSnUryPAvWimfnLL3swBZvI7GcagWTMN4K8D6rqbzmvOKqOu4nBGHlIzb8VFCWWUh6Ez
         CwFw==
X-Forwarded-Encrypted: i=1; AJvYcCUJn/CtbTAXqiYJPSPNrd7UQLSFZNNtgvFZtmmihkr3aa6w3qg+ujt8vIFjKmr+Few6L0ztpmecbAd24zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3ytD/AksdMQ1HvYFOnO7SQtIXxHh7zZHvD3JvwefPm9A0PCf
	9bY8ZZh1KjLEYqWLaDVpZEkNrfKAJ0SkSQ+9YUUe2Z7H84izDginDklSwBdFT2HJLF4HTHvpwry
	UNqcoZGzFUjid7opifmpE7Va+RuKBjS7Fizlkn41li9u3dnQH6/jpd7FxUzuqU+uy7TLJGw==
X-Received: by 2002:a05:622a:418f:b0:456:45cd:db71 with SMTP id d75a77b69052e-4567f592c65mr35525061cf.21.1724937286482;
        Thu, 29 Aug 2024 06:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFur2WCumVIV79Jh3TYo0EaOZHBpT13u9xP4uBg+9WfG5rJuXo7es8ZRNZVfgld+I/exrnwqg==
X-Received: by 2002:a05:622a:418f:b0:456:45cd:db71 with SMTP id d75a77b69052e-4567f592c65mr35524161cf.21.1724937286065;
        Thu, 29 Aug 2024 06:14:46 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682cb02casm4742421cf.42.2024.08.29.06.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:14:45 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:14:43 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Dmitry Dolenko <d.dolenko@metrotek.ru>
Cc: alexandre.torgue@foss.st.com, davem@davemloft.net, edumazet@google.com, 
	joabreu@synopsys.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	quic_abchauha@quicinc.com, quic_scheluve@quicinc.com, system@metrotek.ru
Subject: Re: [PATCH RFC/RFT net-next] net: stmmac: drop the ethtool begin()
 callback
Message-ID: <ibna42mzj4tk3kddnnzgosglumngupdwxnthkm7rkqrejbr5oy@7j4ey2gtl6zl>
References: <20240429-stmmac-no-ethtool-begin-v1-1-04c629c1c142@redhat.com>
 <20240828143541.254436-1-d.dolenko@metrotek.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828143541.254436-1-d.dolenko@metrotek.ru>

On Wed, Aug 28, 2024 at 05:35:41PM GMT, Dmitry Dolenko wrote:
> Are there any updates on this topic?
> 
> We are faced with the fact that we can not read or change settings of
> interface while it is down, and came up with the same solution for this
> problem.
> 
> I do not know if Reviewed-by and Tested-by are suitable for patch marked as
> RFC but I will post mine in case it is acceptable here.
> 
> Reviewed-by: Dmitry Dolenko <d.dolenko@metrotek.ru>
> Tested-by: Dmitry Dolenko <d.dolenko@metrotek.ru>
> 

In my opinion the tags are welcomed.

I had sort of forgotten about this until your reply, the use case I
had was only to try and force out another bug, so it slipped my mind.

Since both of us were bitten by this, and nobody has indicated it's a bad
idea otherwise, I'll rebase and send v2 with your tags to try and get
this merged.

Thanks,
Andrew


