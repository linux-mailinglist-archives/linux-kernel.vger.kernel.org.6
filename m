Return-Path: <linux-kernel+bounces-383012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296AE9B1629
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46481F21254
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AF9187321;
	Sat, 26 Oct 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICpyKq3u"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1447217F3F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729929589; cv=none; b=ecG2Pvzipm1HRt7/MMQrxHKzeRlNV1VASSl1KBUdF6x2gnCXhjit7g8jcpMVDuLTGXIvnG7cYaFzk6hsS6FZJi+tyMwMbXCs0ugpp1n3z3zzIAljEGAPqNHC5XVOWPA6Z2g3RPXDKugkwQ0uXZ643xGZVtHbF7uJtvpt2XUp8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729929589; c=relaxed/simple;
	bh=l8pNPNTgHX8mNhvIRLXroOtc5qc2gMbkwVAxepR0bkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP4F/74oov4UbsHCd9CrNjzVA8BPjTvGu3WKVl/KmCiTTzBiTyiBUaT+Qt5ZJpJ0VlVjyGImtwnYrttbpp3LB5cXHDoBmqqqX6S49lDBhr4DDTK5zPLNhpaZXXpwZLhpnytobSW+/yZoQ1biq+5+ryxoe8FRgf45rGVFWWHKLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICpyKq3u; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so1846974b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729929587; x=1730534387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbaKrFhcnQb7RukIJwDGiJhkFvHtc6dweIpzQ07MgGI=;
        b=ICpyKq3uDfwzpwygiaGU/EpY6SZNW82L2dkgH+LELUXbWT3gMxdtjd716rXV45WFhg
         b136Ce9E8zJphJ8Ju9NRvtiV3vH7JMSLssOhIN9Qi+9vOC5/XCiCAS/GT0fDDc9laH04
         RZRa7rLjlQ7B7VAcaR1IPhm7QWEnPbP8SJcc27x413J3apT/lDWvbn3Dy3YklrMzqXAN
         BETX53bFkEjUTXPyXDzpPxhdk8ENo+CPJ8O9nL+LC3cuQiNw1WFiOtuwKhWKcAugBxDy
         wD8mwfolRgcdbiFU03bu0pY3bIhAGjv0FKzOEdCLQbeItUJ92pA9KEmG7xKNCBAj8Kj0
         Nnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729929587; x=1730534387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbaKrFhcnQb7RukIJwDGiJhkFvHtc6dweIpzQ07MgGI=;
        b=t+Qfc95dPozK4NLoDqf1Vg2LnftLpsJbkYTggqRDsJu/+UMJB1ycLYijdl2gRQAScO
         PedhRms6cNxAQ6oPAupJ7kU2xD/ixI3A8qSIiWd0xWbqSaXCKhAx5+orif+Ubx9HtQOJ
         nH5Yo+tq0SgQVMiDaGmlnlQ/mY3Da4mEsWx7uujUaiW9InugLHL02D5sraDCopgEuvei
         B5BvIg9MgWfFCdWqOg/F7dJqbJt0fULiSaTbDncrcvf9E6FL7D0YaVY/eZbNAXqv5Lr/
         qL93VlccsByOG4disPrMtUZ8jFXEVxN+V8xiYjaeWcvNd9LkHN/H93KHpXB6n9l4cp3u
         nziw==
X-Forwarded-Encrypted: i=1; AJvYcCWTAvvspU53PPV8sV19KcR49e3Aur8eeCUpE07uWNSmkOoL3FML5QbpjdHMljKo3n3ChRZJRt3KdqOIcd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1tjohrW9jj7wJBYXCeR1orMYYsE4Gh8srMMONg9htXXsyu2AO
	rQxm5kA2vxajRChZuh40V7xp4jbghZk9dujxKCoKk9hEvMi8x789Lfk3uG+I
X-Google-Smtp-Source: AGHT+IGDp6fZt2IoTCsVxb5nAEKHF9XXJGg2zMtdzgC+M064lqUnqQzkBi35os5nK8pMYMKPa/ml9A==
X-Received: by 2002:a05:6a00:2e26:b0:71e:5573:8dcd with SMTP id d2e1a72fcca58-72062f1ed40mr3020826b3a.2.1729929586984;
        Sat, 26 Oct 2024 00:59:46 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921a94sm2265092b3a.8.2024.10.26.00.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 00:59:46 -0700 (PDT)
Date: Sat, 26 Oct 2024 20:59:40 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, kees@kernel.org,
	tiwei.btw@antgroup.com, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] um: Malloc just enough space for fitting pid file
Message-ID: <ZxyhbCw39rBzAvtg@mail.google.com>
References: <ZxxmLngMg3iNjOfK@mail.google.com>
 <cd892fb5436f1de0fa2ffc9c9ec229873227210f.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd892fb5436f1de0fa2ffc9c9ec229873227210f.camel@sipsolutions.net>

On Sat, Oct 26, 2024 at 09:44:53AM +0200, Johannes Berg wrote:

Hi!

> On Sat, 2024-10-26 at 16:46 +1300, Paulo Miguel Almeida wrote:
> > umid is already generated during make_umid_init __initcall so there is
> > no need to allocate UMID_LEN bytes to accommodate the max possible name
> > for the umid segment of the filepath
> > 
> > This patch replaces UMID_LEN occurences in which it's redundant
> 
> OK, I guess that's maybe all true, but can you say _why_ in the commit
> log?
> 
> johannes
> 

thanks for taking the time to review this patch. :-)

when I said that "umid is already generated during make_umid_init
__initcall", from my humble point of view, I was explaining the 'why'
using UMID_LEN for calculation buffer sizes was redundant. Then again,
once we know the size of char* umid, we can use strlen(umid) instead.

I'm happy to amend the commit message to a better one but I'm not
sure if I got 100% what I'm missing.

- Paulo

