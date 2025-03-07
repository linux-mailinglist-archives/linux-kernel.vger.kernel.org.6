Return-Path: <linux-kernel+bounces-551860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8666A5722D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E2A167A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45B42571DE;
	Fri,  7 Mar 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BVPPwIRW"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583A253330
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376317; cv=none; b=XBqSx9DwuO55NLmimHIwptW82oy2ZB+D0T2sGOLuh6BXEvXLDcd8K0iWYuwU7+UHdVzGvZvwqJkWKBS/yhq+0wqR5w99EzctNiboNIpCaU6/uLrYqEsBxfB7yX0eAQt2wAC+ycU3yqmnpM9K+oLjbfqHUcERi8LhLTjDhEmCNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376317; c=relaxed/simple;
	bh=1ZI28/lCSvGnh96hlD+BJ/dGZVhUIKQvcBo7eAC6zwM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lwxByaa5JK4P+jzaRhamTiw1MIvNvGwUVUtiOJ4CK5Gz83lx/3NAqTheqreHRVp0eFF/j+UCzdBYfZZ20ARfXqJgiI2HGBFquigzq8WNQelO36NTN5hLT93zFuWuCPEzuHPfWJv6+IkQajrrFTmOHMm7iN4Hf5jolO18JJx8mvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BVPPwIRW; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0a159ded2so244516385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 11:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741376314; x=1741981114; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5igKSTxPFTOS+xKkR9/4WsthgWnkE2Mlv3quJUlVtk=;
        b=BVPPwIRW2ghmQcoIDPZeU+9/lWwojSNIRbcZl1LY5JrFKSbIV2i0icUaDnI4Gs7E2C
         rEI9jd64zXzIX6LN0ryop9Ks6bH6Gl4GXPTZT5Dvql3vKTTDWUHQqJggV1DIkizxGPJM
         7sGcrs5x66PU9/XipCpN2r3MG1gxCAMoMd2OskVnMqWUBBvaIPp4rh3NLryD0Km9IVaI
         VGpLc9GSkokOIiJRrb75ThBIFN9I7oTTl6Fidhn/DSGaLZnQCZS6lpmPPrqXh0SmKXBE
         TtkUlHOzBVh1avqW9F+e59x1p1J6mIFxahDJlMVCt4C5HJL9llntIi/YKB4mbyMUk4o/
         4HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741376314; x=1741981114;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p5igKSTxPFTOS+xKkR9/4WsthgWnkE2Mlv3quJUlVtk=;
        b=IwlJo2cOVcwjEavVdjqW9Bz4lJ0HbhTaITmq2hvnL0uAy0xq6mR/sYJGgW+dgqDFY4
         fSAfVZfTeBvRDdAnsbPIb8BOZv1OsnMwPm8GUtXczcSlCvnUJSRnpwiVI7JSE74PFfCw
         GN/t3K2cGrTCsrobJnHSV8qZQKK9EWcmif1Vm/ipddzb7QMWunVpfDkla4HDtF8qZ4PW
         UeZ+LgeCHLO+QbxNnAGbF1h4pTxR/CWEU95JnXksu1TbDwc9Bvb116ZAu7D5+rhjWKdA
         jRx/Bge3vOShgDq4G08OULxayzXoI3cqa0MXXyp36jOdUEk/9eoBxeQPCyia17bjqoX7
         V7FA==
X-Forwarded-Encrypted: i=1; AJvYcCXLW8m8avFtq0NXj7sW99gnk5AIqxZ9AtiumlpR3Pinv3+o0709kNEIT/EF0iyl7rAURVJrqKpvX/tDETg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/N0kca2R5TNI46VbqPIM4GRDWpxK8j2UZFCHxIXsXjZKeMmOk
	6D6qWB3p3Xrjf4OenmtQQRTRCiUmrhC2mTDNRc4oOhbOTuVdHFMDzFM3uN85MQ==
X-Gm-Gg: ASbGncs4c9I3GXWlU0eUZ3dD1tSo+sAckFqUMD0cO2d6tU6lmjUyZPqntziW6Ef6pTx
	fuxaLjfH/OByfkjsQ99uIhwXKlHnq6QlD868Rhq2DJMNv0J9jiZNTWbLf82L5Pfs9XzHD0287wo
	0qc6pIPNaz4SH2EjxwTAGCfDXVI/e1NHC3SpTTGr7E/PatC9/c6SXDE3NYCruEQM9QLcXz+5Viv
	Eb9rF1Bb7FhWYAu6d/yErWnLhULtyPxoKZoIEC8jODGKxmxvWfI8BVu8sCqfzk/kdvmDzft3FKg
	FK1lJO0+eN2d2A06ieJn6xmYRLqYCqrjvaC5TmXW/gJXF+YgqXw7VGNU0g7OIov0P0DcSBjisrK
	8NB6I4nlKGwcaeQ==
X-Google-Smtp-Source: AGHT+IFkaMYQx1ylHwG/iz2um/dPEpd79CYsvVILlcJOk6aOGsNMrx8/W8JzuRmdiXyhUsZ9RsL0vQ==
X-Received: by 2002:a05:620a:8017:b0:7c3:c1b4:c8f5 with SMTP id af79cd13be357-7c4e168267fmr655768285a.15.1741376314157;
        Fri, 07 Mar 2025 11:38:34 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e538448fsm280105385a.63.2025.03.07.11.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:38:33 -0800 (PST)
Date: Fri, 07 Mar 2025 14:38:33 -0500
Message-ID: <aa05b93c973149a86385a6cb7f7c1138@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250307_1437/pstg-lib:20250307_1437/pstg-pwork:20250307_1437
From: Paul Moore <paul@paul-moore.com>
To: Tim Schumacher <tim.schumacher1@huawei.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Dominick Grift <dominick.grift@defensec.nl>
Cc: Tim Schumacher <tim.schumacher1@huawei.com>, Stephen Smalley <sds@tycho.nsa.gov>, <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selinux: Chain up tool resolving errors in  install_policy.sh
References: <20250307095645.326982-1-tim.schumacher1@huawei.com>
In-Reply-To: <20250307095645.326982-1-tim.schumacher1@huawei.com>

On Mar  7, 2025 Tim Schumacher <tim.schumacher1@huawei.com> wrote:
> 
> Subshell evaluations are not exempt from errexit, so if a command is
> not available, `which` will fail and exit the script as a whole.
> This causes the helpful error messages to not be printed if they are
> tacked on using a `$?` comparison.
> 
> Resolve the issue by using chains of logical operators, which are not
> subject to the effects of errexit.
> 
> Fixes: e37c1877ba5b1 ("scripts/selinux: modernize mdp")
> Signed-off-by: Tim Schumacher <tim.schumacher1@huawei.com>
> ---
>  scripts/selinux/install_policy.sh | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Nice catch, merged into selinux/dev, thanks!

--
paul-moore.com

