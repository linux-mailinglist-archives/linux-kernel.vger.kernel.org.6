Return-Path: <linux-kernel+bounces-429186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 615209E18D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3D4B475A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59811E1034;
	Tue,  3 Dec 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Os4/fbpq"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA31E0DB2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219348; cv=none; b=OYBB4yrktpvByfr5BWNn5Hi7RrfWvc9VyX33+NZ7vcCI6pg/ngkb0Zntwwe2X6VA6F38VWcITi6Ajwa7fTFlcDlxwR7aEcaCLKIW+tnt4+nBtvEYADIikUoe4lU/JbGcswwi4HHxRPuGNlUFIU4lvAIJy2Ba2IsSGSMYsUYAtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219348; c=relaxed/simple;
	bh=66C7X0y5JSIvmxFiooKiDwrInLALIuU1cghHxsv7Mrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnTTbspctY444UMPSPTbc/cZnAn06l/NVyH3jtAbfYIWNy9T/T0xyCom3wamtI5J9Z99mA6ruy5ghFSbgOrWzjUL5Rg0oUfJ1gExfnIPIpxX6OLYcowJDHoODNI12bMXapGUIWsVBbWKm03La1jXNEUp9oE/Qkpf547o4LEn9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Os4/fbpq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so31384175e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733219344; x=1733824144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5m6hg1T/8NDguGzINl2AjokycuEBlMQVbW4nuTy6h4=;
        b=Os4/fbpq6FR4D2jx0XLq3ouYACEKaboZsV3uXhNT/xJhqFPFoyLunsdtORGF58ChM8
         MaJn26loszUFyLfcPYRkAIba5cWHzYOOPc9xWOVvSGpB64fr9Hmhcr3FjyVKFw91hL14
         hYvmmddyHfYzHLNWckwX8WS+WGINd1/4wEm55inotYVykwIFSIzHXhAwpvdY1WcV7P9Y
         Z6uqGPV4S3lBBFGAJ5ys3fhvq0ij6cpV4/FP3P3PaE4+Tq2BJXnJ5a5Vb5m8ujCyt+24
         FAfmipDS+n/qxQXyzd2/Pbu/T+AB6VIlCOSbavxepgTlStwtF77macYegLPA80Pr3QrG
         xWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219344; x=1733824144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5m6hg1T/8NDguGzINl2AjokycuEBlMQVbW4nuTy6h4=;
        b=ppK5Laa+L5xxkOr+Muvp79S5kBgZKVwOGdXkD4xM3v2ghy/cskKI4VMCHPfjnBFPHl
         XA6Dx+FZm0w0xgh+Hu9riE2PGwaOjxs1qVlyw7l6Urbm/kseiEiKYAvCeO9+G6ke4M9T
         qf3ysvKBHoByGmcmIgS75Aog8L2v31TRT0FGY85d9pyot9gMJpQdAhmg3Wh+mNuzYWgd
         L0hDFCEcQt1CLmxwHVETtRDrAKfDN2UmVxph7c8SvRTgi/uF7BTsgcRCDvDXMia4LkRW
         pZL37vmaKISVb/VjJ1BHc82evHuBwGP/96jZY35x4dYFoOwcbIsqhtSnJkaj9ueYHqyu
         6/bw==
X-Forwarded-Encrypted: i=1; AJvYcCVN9JPie5YNKvAVsVASd7dRKHlhzJL8KIxmTKGVOnQwr+n9/kKBKDOXyn2vo006YBohwohFQw2kyLJMIcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYUyltUGMHeCr0PvzwnO4ZkzvCiJGc6FfdBA3BNspeOVhU6oJY
	ncoiixUKKAqDoUi2oVplIrUvh3H1uwDl0yWzxLOR7F3p4PEHwlsWm6SR7GCUpFw=
X-Gm-Gg: ASbGncvSGhbbFqcFjbsLAuEWU0/apVTbgR515xbnSeQWPCspnO1TFjjbS9NDObOYAs5
	f5M4xgf7v4TrQ3jw8XhNT9dgjawqbJ56ZGUNfiBP60wCTWhF1TT/pKFNQ+qjETgm3J9UeOdnmwa
	pXeLHKj/Jg1KZoETPqo8AgBdAjeXxqZY74cBQwusCHCnZrgBQcNqfx0X56Ymt6t5sRZRqno88Lh
	2YkAyI1TmGkVi1+hmUbzwhJNgZGPf7zPiYe6FlKIByUlEsulCV88/E=
X-Google-Smtp-Source: AGHT+IGiq5MfIfBd9OA4L42VqbX8iZSuCB9pKeFGXwzXoQE5bTKyZlB+OEQ8WGkhd7IzIABfKHMT6w==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr189287195e9.8.1733219344634;
        Tue, 03 Dec 2024 01:49:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d04e7380sm15910995e9.0.2024.12.03.01.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:49:04 -0800 (PST)
Date: Tue, 3 Dec 2024 12:49:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <46a97b8a-042c-4903-817f-efe3be5afabc@stanley.mountain>
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
 <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
 <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
 <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>

On Tue, Dec 03, 2024 at 11:44:12AM +0200, Yevgeny Kliteynik wrote:
> On 03-Dec-24 11:39, Dan Carpenter wrote:
> > On Tue, Dec 03, 2024 at 10:32:13AM +0100, Mateusz Polchlopek wrote:
> > > 
> > > 
> > > On 11/30/2024 11:01 AM, Dan Carpenter wrote:
> > > > The dr_domain_add_vport_cap() function genereally returns NULL on error
> > > 
> > > Typo. Should be "generally"
> > > 
> > 
> > Sure.
> > 
> > > > but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> > > > retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> > > 
> > > Please remove unnecessary space.
> > > 
> > 
> > What are you talking about?
> 
> Oh, I see it :)
> Double space between "retry." and "The"

I'm old.  I'm still using fixed width fonts in my editor so I still use
the old school rules.

regards,
dan carpenter


