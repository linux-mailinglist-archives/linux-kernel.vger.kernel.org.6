Return-Path: <linux-kernel+bounces-255782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA3934515
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7EF281683
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319F59167;
	Wed, 17 Jul 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qp5NDi5y"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B294481DA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721259698; cv=none; b=D8pzWaQ1tNhvh2pQ6uH/wK/UZMUQQWcZy+aQz2ZTdeaAUkFfbs1DiKpp1hA7+2dwBT4CWO5zPqE4keehz0BLnPHE2xsks1TP32z5+wCPHKFeAl4f4QpOdGY7oBa1tSwHyRQ747ieyR6DJGk5qCTTYgu59qr8w/rF9nIfvU+Y+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721259698; c=relaxed/simple;
	bh=OePmnBNxXcqQ8hkL4Opt+Ze5aDkg/NsMFsvb1a/5MZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVVMHlj5Hsi21RKeynk1PaowTFpFssS3qkq/Wbx45as28/ZoqGTNdMZLB11uGlL7xjdDAj73IBRSGQZxJRRPn3n573s1DuXKUhthrCQ+q7jNVJdYfkO2Qx7tBoYvEWvy22vceib0xbf+FJ3F6erA4hPAkbhNEoa/Wj4jfNyOaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qp5NDi5y; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-65cd720cee2so1877597b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721259696; x=1721864496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OePmnBNxXcqQ8hkL4Opt+Ze5aDkg/NsMFsvb1a/5MZw=;
        b=qp5NDi5y2zIOcH9AXZL8LA0LDxn1mI6Wn8o/aUOnjeivzxkcY1/8jWtS6avr/mNea2
         zivbb+OnlVWx3ga+G3eqXpY4ek7V97mCB62hFJ70u5RohGikDlITZQMTa6Pe1JGV5bfi
         NB/MXt7HNT7zHyvJziQ4ttJEcc8wbMxD5oePo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721259696; x=1721864496;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OePmnBNxXcqQ8hkL4Opt+Ze5aDkg/NsMFsvb1a/5MZw=;
        b=nw54vecnVaZaknWYAeIJRTg4h0kkqg0gLjWb3jCMWGCbd3dz+xm+ccrp8A887v9FgO
         twjJvkofG2NBvXXcEH9qB4lIlm7RGG4u7/sjuSxYLr/Ksf56C4OgDZpQZo8l6XAKjk2C
         R2RpKAYnMgoMb4IRJdx//QVPALj5r9Rz+ud8RX/e6qnFsJg5Qsyb3brOSHT+K4baF8n1
         Y4ktC2vM1WeTrgImiDZtO41z5Fs2zBnZ/iyaBf7dW5gwGOqoY+QCk40KIiUC7vLjk4+r
         UzeQrlj4abETuqXfcfmiqjEd5xVbqBBMcePOT/VKKJLD8iKlpFz/+7yFDDeap/OLk2Hj
         Pkqw==
X-Forwarded-Encrypted: i=1; AJvYcCUh0xF1Qd2ExlWrp9Trv2/VuiGO/Ig3SuPzP8PzOw2PAHUcCd7ZLgCggXezHLnDnHsIwkATJxSIEiOjUKzejsXfYYtlmBN162I6JBGy
X-Gm-Message-State: AOJu0YxE0HbialY8B6PcVHHeUYpyY2IgtZoB+VHRQfI4iJLGKGIPW7Q/
	6yiKRVG5dgRwUNc9juCGikmVXfV6DhpPHw2G2YZ0M/U0ACwpAbbuOEDVGFYQPiETyK5cWL8HL7E
	I7zw=
X-Google-Smtp-Source: AGHT+IG06EEyyEmG++GQzdMvsD/Q2ymdzca3Nl7yHImDDfUblOJ5Ej+W6vy3FASnQs2XXt0uDqmTAQ==
X-Received: by 2002:a05:690c:2712:b0:64b:a3f0:5eee with SMTP id 00721157ae682-66601dc3816mr11547417b3.17.1721259696404;
        Wed, 17 Jul 2024 16:41:36 -0700 (PDT)
Received: from LQ3V64L9R2 ([2600:381:1f09:7c46:a087:d053:b69a:b5a9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-666043b97f0sm1152897b3.142.2024.07.17.16.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 16:41:35 -0700 (PDT)
Date: Wed, 17 Jul 2024 16:41:32 -0700
From: Joe Damato <jdamato@fastly.com>
To: James Tucker <jftucker@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: uapi: add TCPI_OPT_NODELAY to tcp_info
Message-ID: <ZphWrG0H3TR0vg7R@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	James Tucker <jftucker@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240717-nagle-tcpinfo-v1-1-83e149ef9953@gmail.com>
 <ZphI8Z89iLe3ksVP@LQ3V64L9R2>
 <ZphJyabJV2wDrKzi@LQ3V64L9R2>
 <CABGa_T9HJdFiO8gSn72_YP6rp3t+RhSEtYXtgqxp2GUzQJiBmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGa_T9HJdFiO8gSn72_YP6rp3t+RhSEtYXtgqxp2GUzQJiBmg@mail.gmail.com>

On Wed, Jul 17, 2024 at 03:53:07PM -0700, James Tucker wrote:
> I'm using b4, as gmail SMTP is not suitable. b4 crashed after sending the
> email, failing to create it's own tracking metadata.

Not sure what you mean exactly, but I presume this is why you are
top posting? In the future, please reply in line.

> Should I create a new thread in two weeks with the updates you suggest?

Yes - or you can create an RFC in the meantime to get feedback from
others.

