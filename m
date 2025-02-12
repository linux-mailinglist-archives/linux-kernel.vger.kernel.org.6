Return-Path: <linux-kernel+bounces-511628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD773A32D73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98093160D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2702F2586C6;
	Wed, 12 Feb 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Un9xLCGe"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29B210186
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381251; cv=none; b=b2d2VhaIfv26uhNwP+NGmXhryRmFkABaJoClaSzDHUW1moTdE+4JFEw5MeaT6NR8Og6oAvHWzgOEEP0d2chOeD/joKQeoHhuA8ZOR1kPdcIHOCfaRiUKgCNlCG5FYLPQAoDew/uXmTno593krXwY9iqMHejZ9rXrGOW7KH4syfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381251; c=relaxed/simple;
	bh=WsXNicR6jaNblz/mUCSZP8cRv1n93+uq/dm06XHfv0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mG+Arf92QdwzudfuHyFyxjrmzKP7vDrs+1IL0+PUTbNrbiVV5Q8qO7WP9HPGDiVKidFUH8E3ksdiG7BzUrNEhHD6Z/7uHc/rLaQnYIhHWQFky1B22VJPut+ISz74J53T/D2F63SD6Xcc4SrXsNG9tOG2FISMT/sDoKFaS05z5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Un9xLCGe; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e440e64249so227346d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739381247; x=1739986047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Smy8Ep/libgaUjooQcIAevVXF9JphJMkMPuXMpEKUoA=;
        b=Un9xLCGeGk4fjQ7rrIapXM7AwPTJlx0pWcUHKUkJVCXfvqDFSyiOUyir8IHkoqRyuc
         RUz2hVurCwSvt7AdqCWuWseEnVG3wN0HyeuRXdxrrXJulbz+NFR14Qt8IvT2NORqykbn
         WqGALU6YCKjasn+8J2m61XnRDKY+mGS9O89XNB3UqUVhnKizSXPPbYExfpylku7/qDj1
         MBYmHyqawsk4G9iSL/ze9+kwmVFqz4e6caln+V2XgU6/eSQY5tqv/AD+6kATXro5RlWg
         50iZbbmvOs0uz/j/QOebHMQy58X119ndFkVkJHcKsMSGENzRmRamXXNqy9Uk6aDYPHAH
         ZMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381247; x=1739986047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Smy8Ep/libgaUjooQcIAevVXF9JphJMkMPuXMpEKUoA=;
        b=S1dNWXnk42nhshSAkvUFjV6ecE3uatHLRhoGSJy81Qdq3y5RPxCoQKLYQw3+iLvcjG
         tLjz5cz/QL3+R7gkaJ4QMnTUo49F8Xq34n0Lvz9SM7bAElOVqynaI8HOhuRVVvpfkEu3
         10LBc+tpyVb9jWtppa9DHzyKSbOCiZGUp0kME0dTowyPs0rhjjpjmsNvxXIHdPHH0qj3
         loPyDx7p09tRxeDxRPkyXJ6ozvy4kN9bw7ktgaY84Ze8eC68oRtGa2l/CZKTGhNSPnKA
         r85J8y5U9b9HcK685XG33TI5b1ht4Gh5ojc60LbGmnZDViSWmMnNOE+VLZZFyz8NHsVb
         AtBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNdg7MttfQffZF/IhJz08FXOC3vsMvzZuCHlTOVuf7O+oc45luvxEDkw8KY/LITDdsjWKqijYAzRwfP60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0CfyBPqQJS+f4Luf8jlphMSYRh1UqK+1FstM/FSNr2mLn282p
	cmvPq0Kg27raEpPdmwXRd0kOjs6jWoV7KIrbXMe8yJRTA+IeseM23TeirRqeEZQ=
X-Gm-Gg: ASbGncu70RcHBT/Fuftp8uZ+Z/QZW3W/3s/iP49BL/TNT8xpAtTF3o2tOw2MIV3yQeH
	fZjKuHyl/T+mjB9uUFP2Pg561w4FDDDnRqgMjT7R6F+9gl6gq8Ej/dy5EV1jqR4fnSOqbC3YMPt
	j81EVZEilU3BN0xFr367C3tfsc2cEfjsLoAZaNqTQFRyIQBbF1NfaUKeNy3OzLmukinXnvnROio
	sCkp2aaJq4vpzyVMbiJtvXarW3iD+i30Ec6FwaHvGyyCpzyTiEwwkD/YNQ/1KW32zXRhYDQi/bn
	LUcAIzfltLX7O2wOkrxkJSI5dcZkhe4rrwrpu4rpIZAxazJhMjo0Vc7VQGiOi5NFHypq5kjPUQ=
	=
X-Google-Smtp-Source: AGHT+IFxLq/9chQgLM98IqnvfPjNIMr3SqvTbtBXTR+199INYC5w6TgCv988GbjKoOmNdHzhzqWKwA==
X-Received: by 2002:ad4:4348:0:b0:6e6:5bda:a47b with SMTP id 6a1803df08f44-6e65bdaa4e8mr6261416d6.9.1739381247418;
        Wed, 12 Feb 2025 09:27:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65b3df028sm2097176d6.117.2025.02.12.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:27:26 -0800 (PST)
Date: Wed, 12 Feb 2025 12:27:25 -0500
From: Gregory Price <gourry@gourry.net>
To: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hyeonggon.yoo@sk.com,
	ying.huang@linux.alibaba.com, rafael@kernel.org, lenb@kernel.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	honggyu.kim@sk.com, rakie.kim@sk.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
Message-ID: <Z6zZ_UqcY9MbyDL1@gourry-fedora-PF4VCD3F>
References: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>
 <Z6HGwq731v+VX1CP@localhost.localdomain>
 <Z6JAicm5VxE6HKnO@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6JAicm5VxE6HKnO@gourry-fedora-PF4VCD3F>

On Tue, Feb 04, 2025 at 11:30:01AM -0500, Gregory Price wrote:
> > > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > > index 80a3481c0470..cc94cba112dd 100644
> > > --- a/drivers/acpi/numa/hmat.c
> > > +++ b/drivers/acpi/numa/hmat.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/list_sort.h>
> > >  #include <linux/memregion.h>
> > >  #include <linux/memory.h>
> > > +#include <linux/mempolicy.h>
> > 
> > nit: is this #include directive necessary?
> 
> yes because hmat.c now calls
> 	mempolicy_set_node_perf(nid, coord))
> 

apologies, i missed that there were two of these, we'll drop this.

~Gregory

