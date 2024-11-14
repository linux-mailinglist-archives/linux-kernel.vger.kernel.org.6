Return-Path: <linux-kernel+bounces-409897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4389C9306
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B0328452B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957431AB533;
	Thu, 14 Nov 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SNy2v0ay"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B11AA7B4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615225; cv=none; b=BP1kc+ClKZcRG6a79LxLCbFZaMt2wWJdgY/UtKsn+MzsmHVt0ulIVCcr/CDlc2SUsVuY3GgqHhPs3t+wrQ0ZlY/RfUPJbTU5IOI4KOWO++YS8GtEeyJbdmMPj30opdAM045Ez9WRdOYzXUS84Aqzu9KyDKrJSYs5I30t3NAdLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615225; c=relaxed/simple;
	bh=pCKYJj71wA06N6bc10/er2DhbontUDxAdn6wLTdlpc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB6fCqGRfKnWbtN0MpuIABF1PsITqpJxvSHgoDBJNqoiJZHlkcYw16qgv2rK/f2bWt32DDKg25a0/kKYIl9RByv3teoiGXXXXXAVtf9OLm/PukMOGnWdB3FmYA65owRYC++X8PF1rBZ8wE2DKbGOT9uDpKHyqSA3iP9DeYD3+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SNy2v0ay; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7240d93fffdso18161b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731615223; x=1732220023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otowYy7OdNtGuwhI4NBl1VzW4OrjPRlTRwbtUvhfdIc=;
        b=SNy2v0ay+qQNr+QEft0IoSuDfkbI9Ro6UGYl7V4xSaEgtWujQkMgpCTST9yN7HfpC3
         uHfOTW8WPizQ+ORXTj+sG2eVsr4rgKsDpGlYzkxAdCq6B6fanMnFJXEGgQ3gHoC6jW0B
         1ikXeGgWYjnI2p6VplHkGxJJYyW1StHGjuvtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615223; x=1732220023;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otowYy7OdNtGuwhI4NBl1VzW4OrjPRlTRwbtUvhfdIc=;
        b=PnEtcth9ZtH8aUt2iwyoJ0uAsa5LU0nNkhVJpeGbECWaxxw0BdobLI7XrwXhbx7rem
         tqi9fKrEnYiRvwgTwvnuuYAkkvtdTJGEyltLmUCBhc1vSO1l/JXQHXa7gmSeaVgKChQ9
         Zux0OXR8t5kF0iSOcx5wdSeHuHadbmXGFrbASYDRUqhX+j1GWBCEHu+zNPY/l+8JEKS5
         duQz5ZvvBIpMonRn3YLI7o685wSqNvRXLpkv8ymYC9lNdK9XE8rfTWvzVI6Ga+TaBqbL
         bYXfNYYjIZLv2TImtofUvojXS6DuOjTL1yk01y0yAlJHP18j9YS+nQmhzgNOc7ZfBJoL
         0jNg==
X-Forwarded-Encrypted: i=1; AJvYcCU0dz73GsNzIONkXjuNJC03gLzia3MVKVXBgc3gh7f6uIVqo68yemkRqCCWvjLxMLkJ786T+ad/4OrJM9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxriQ6BsRjbr5M0nptalHF614tgqQd4SBIGp62hQzmyGXsnow
	hzqhKA5KnvoMc3dfMGCn59RsXsVIwnsyvjBuxswSdy2k7QRtIV9wV3qWl/LUxzo=
X-Google-Smtp-Source: AGHT+IGzgiCgx6YZ4l4cVmh/B6atw7K/LtNrtk/3mukGWleTD3P6jRL/9E898TPH9UCk8E1KLkgQHg==
X-Received: by 2002:a05:6a00:23cb:b0:71e:4fe4:354d with SMTP id d2e1a72fcca58-72476cccb37mr184064b3a.18.1731615222806;
        Thu, 14 Nov 2024 12:13:42 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0baesm26423b3a.92.2024.11.14.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:13:42 -0800 (PST)
Date: Thu, 14 Nov 2024 12:13:39 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
Message-ID: <ZzZZ85ONoGd8fF7Y@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
References: <20241113021755.11125-1-jdamato@fastly.com>
 <20241113184735.28416e41@kernel.org>
 <ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
 <20241114113144.1d1cc139@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114113144.1d1cc139@kernel.org>

On Thu, Nov 14, 2024 at 11:31:44AM -0800, Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 22:29:50 -0800 Joe Damato wrote:
> > - Rebase patch 1 on net (it applies as is) and send it on its own
> > - Send patch 2 on its own against net-next
> 
> My bad, I thought patch 2 is also needed in net, but not in stable.

No problem; sorry for the noob confusing on my side. Hopefully, I
got it right for the v3.

