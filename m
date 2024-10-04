Return-Path: <linux-kernel+bounces-349975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3996798FE1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6A0282DAF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2313A868;
	Fri,  4 Oct 2024 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cg6g097k"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72323139D03
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028429; cv=none; b=PR0suRlBpwc20aXnbazbr2K+fnKPVmU4QUTPkdYoJI524Rwjsipck/y7wEzNofkiNG6GPxsp3wcxYUrqPnO2lth3aEwS55eonpGo8ovCm+gAgtkZGdErZCgWhv5XyLlnorF+U+oRGooVK7Ay418fsXatxy1bPFmakKC3lgMXUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028429; c=relaxed/simple;
	bh=mBPw/l43WqpBhYb5GYphiZJqwn9HXtWJeKHPO72ZMY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACTn5KVpaVi/i2x/zfidX6+2KzRes0JFiAA7jj1baPQq+ZruZdNgD4XOIMwtn2D8IpUItm81ipe19kv+oZ76y4l1Dowilt1NbLBNm+BbxRDjc4jNqPC3JfRVgkESvVaz7rf1HvbET+W6wbQM0GSHhU2O/Ntki9aEBe+t6durr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cg6g097k; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so1283705f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728028425; x=1728633225; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSd4XkWxEjHWSImRXS/OrAr6nrk5as84KbJ9s1v67IM=;
        b=Cg6g097kKsEnUo7+xHUI7rFaXN15XgSDdegE5fC6nC1tZYn9IA1mAhQYdR0Sgzar96
         epY/yDuVnENeM5FYJrTCSYWvXm/PlrgxhJqboAkgb+bbO/eaqIy1xFAWUzy/myVLN2BR
         YO5PrBqJYvuZErVY6T+DPSxB/PynIQvpb866r67Grl2g7xsz3fqWUxbAW1Z7i1HtOfJv
         TBoX/pcpDnG4pWsBu6mdOCNzGoadPVs2MvfEiyeSMMwC90DYwHmQH5jkrbilZshRi5ra
         xxnd7usN08Ezj8TQqrDkeEHuqaymy6gi/ZLPHQT9M6xBq53JqgtzRfpwk+K4fi8f1GPB
         E6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728028425; x=1728633225;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSd4XkWxEjHWSImRXS/OrAr6nrk5as84KbJ9s1v67IM=;
        b=ZOj3o4CpRAoJIBNS+gBEyEzlkBFFE6PiM7mDrZBJOe/fPdIi2+MzIWkcLjq9spkK50
         NUaR/1l9aeUglQ1o1v6kPElJTLQiiLv6MKcK+oyYs2URRQQ5xBuAeyNroItnVm5iubBn
         7xHbJnlodur7f8nTHN/yxYttgffPRGnPKF43DQ2GSaxN4kB2Yn/AXsjUitHVDJgxtKpa
         Ka7W7axUb7llSwSqYzml3uzeYwPSGjYGYBc/fxrdBPZrhJQjByhkDXwDPtFACLMxXnI1
         MvRLkJsREwEyeiFzzPhMN1cpUUDgrBdlQPRfuqGik1FdJTOznmYFE5hoHNj+xTm2N2Kg
         USrg==
X-Forwarded-Encrypted: i=1; AJvYcCX1M9vYj3au1hU0KI83kY/9jRBCQE7odyHZxtJYJGth7NrLbs8WbInYlE+J1DMLTVoPua4l9W9sx6mSe9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8vpkJXOpTaX4iCuZXfBz8SYupWFr0X1LWXcjhy/I3/9ulG5N
	cUh1maydFeK3hC8M/7XG2kguVH6XMWeIG1AmBoNOhf8MSr0JfG7FN5ijV4hzv0w=
X-Google-Smtp-Source: AGHT+IFN79cyZs/XWOlRSuLPxg/RKO30DUk3/AcaruChZ5ovj1sCHyhqFglIvrqyefPzf37H3UJWfQ==
X-Received: by 2002:a05:6000:10a:b0:37c:c4f8:5e06 with SMTP id ffacd0b85a97d-37d0e6f26ffmr1079939f8f.20.1728028424395;
        Fri, 04 Oct 2024 00:53:44 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefafc76sm19158985ad.208.2024.10.04.00.53.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 00:53:43 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:53:40 +0800
From: joeyli <jlee@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] aoe: using wrappers instead of dev_hold/dev_put
 for tracking the references of net_device in aoeif
Message-ID: <20241004075340.GM3296@linux-l9pv.suse>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-3-jlee@suse.com>
 <2024100223-selection-thirsty-99b9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100223-selection-thirsty-99b9@gregkh>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Greg, 

On Wed, Oct 02, 2024 at 08:30:49AM +0200, Greg KH wrote:
> On Wed, Oct 02, 2024 at 12:06:16PM +0800, Chun-Yi Lee wrote:
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> 
> For obvious reasons, we can't take patches without any changelog
> comments, nor really review them either :(
>

I will merge the 'PATCH 2' with 'PATCH 1' in next version.

Thanks for your review!

Joey Lee

