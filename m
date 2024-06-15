Return-Path: <linux-kernel+bounces-215644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5386D90956C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D446C285947
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC56653A7;
	Sat, 15 Jun 2024 01:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JgmvwduU"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95051396
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416662; cv=none; b=MTqDM70UEH7lAaLbAHqVNdlE/KzwZciLCgiMMCfh1cpgblxOp5CuWhI1OgCQhhs5+0cDiTXslVBCaI0l/GyTnruCwWgEj4oU9lgeNnjnn9xg9/q3AIpiCNfYJ7JMChb6qQHtbo45ui9PdboXEJc6W0CgCpi0O0W1f2+LGxuX4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416662; c=relaxed/simple;
	bh=00qodF6QKX6kY5aVpmFn0IV6lZaTfbB/wM6JlDqCD6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS3kFhxpjdIZ0AULohVd5/HXJ2pPoCNLED1EVDsYHIKx4iZHaIpQIeMcNNBJDV2GLWkGYpeG9Bf84BHN9t5rA0R+FYYAlF14mlXWxaYmlmkR30EIt/EMPPLsP+IBNhd+dbKq6fqeLRYNF9kODfnXB36jweFgJPiiR30Vb0DyCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JgmvwduU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so2531690f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718416658; x=1719021458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABtmO3SynGCheUJoZZwiI9goLwucbtXdkggcFPq6bBg=;
        b=JgmvwduUaBJu8FuWyAm0SGwJVhw3fGy4fv5p6eqJn2Yeeu+F6J69jgowf7WtIICuNS
         oRFXy0lb/TYXHPEHToTRqG0g4W+9dLIi3sWtjINrotTcmut/a4fo88agCfp/IlXlqTuK
         eIgKp7Afe5byJUEZmNQ86hMP+IJEdP8+wkdxOst90RRKpe8bx2g7B1fQq4S8QdCimc7k
         ZhagDPSDPNtjzygQYNuUmi11Yaw+Q232WHl3HG8uuvl5T3WJwUpb/23PcPF4z+z14E8m
         6ehDnpcjgzD3y9moSLj2foxgyo8ko1+IIpw3ZdsJ2ovj2yhAt3D1QFiNp9kI0VtrbsXK
         M7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718416658; x=1719021458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABtmO3SynGCheUJoZZwiI9goLwucbtXdkggcFPq6bBg=;
        b=SuKXYZXaX5HBHBny/S4J0qBihuX43QH2FhlfIDFI7nXuevEBRCHEzSailcGKsqx8rU
         ZoALUJRZcfOOd0ep/sP4pw3kp0FTVv8t/0GiOYx3kjDWtIqk+q5SXgg5uGTBWs2zCrx+
         mjcc81sAuTIMPEoBd/VaQxCpNw5jm5lG/T3WI+30DOTsHfcwXMeBjGTFIZfEOQW9OuXN
         0Dk+4P8vypl+aNGB3HdNJHXwuJ0G8s27f58xw6eEXtDKYKAcn7G5fF7vy6Spx/IB8D+Q
         dLVxJJnscKRCqJOfLRjE5a2q+hpCADiBabBN6FKPmIqauCc2I0AtIcMO9pYr+oI2A6Ac
         N4gg==
X-Forwarded-Encrypted: i=1; AJvYcCUmiFSNaqpZ0N1Q+JB6o1EhpMbg3jrEA3J6CaT2uQjxpHd+ZFzeTXKlvLUQTUpGTrUbFp0I8JTI++T4JTOua5LUPivFMWw2LXENFuw8
X-Gm-Message-State: AOJu0YwLBFvgeSrAj2Y2uBhHkThkqISFSb0SibfTGMZkOBWHZVmd+3GK
	5XR0dOrNVRyvLE5w7ImIvPSDSBLXVV8X0BXH1/rIk1kOB+1505dJh3sfwv0kDEQ=
X-Google-Smtp-Source: AGHT+IGR4zVFkXOonICx/mvA5JDvyRAE9eCUTxvhR4wF1jq/1vyMqD+Yqv9ypAbz/FBNfZXmV1CISw==
X-Received: by 2002:a5d:6306:0:b0:35f:b45:97b4 with SMTP id ffacd0b85a97d-360718de6a1mr6772651f8f.20.1718416658187;
        Fri, 14 Jun 2024 18:57:38 -0700 (PDT)
Received: from u94a (2001-b011-fa04-32f9-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:32f9:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc967334sm3717206b3a.57.2024.06.14.18.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 18:57:37 -0700 (PDT)
Date: Sat, 15 Jun 2024 09:57:29 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, stable@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: stable-kernel-rules: remind reader about DCO
Message-ID: <x7nuehxxk3cn3ra46abw3y5jks2h4ikwzc6iv7cmxw7sexla37@efgriowgekfa>
References: <20240606064311.18678-1-shung-hsi.yu@suse.com>
 <20240606064311.18678-2-shung-hsi.yu@suse.com>
 <0f7d5012-99a3-485a-b500-1d79d69a64f9@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f7d5012-99a3-485a-b500-1d79d69a64f9@bp.renesas.com>

On Thu, Jun 06, 2024 at 09:21:39AM GMT, Paul Barker wrote:
> On 06/06/2024 07:43, Shung-Hsi Yu wrote:
> > When sending patch authored by someone else to stable, it is quite easy for
> > the sender to forget adding the Developer's Certification of Origin (DCO,
> > i.e. Signed-off-by). Mention DCO explicilty so senders are less likely to
> 
> s/explicilty/explicitly/
> 
> > forget to do so and cause another round-trip.
> > 
> > Add a label in submitting-patches.rst so we can directly link to the DCO
> > section.
> > 
> > Link: https://lore.kernel.org/stable/2024051500-underage-unfixed-5d28@gregkh/
> 
> Is "Link:" right here? I'd prefer to see something like "For example see
> ..." added to the first paragraph so it's explicit that this is a link
> to an example of this issue.

Thanks for the feedback. Yes that is better. Will clarify that, fix
typo, and slighly edit patch 1 as suggested.

Shung-Hsi

