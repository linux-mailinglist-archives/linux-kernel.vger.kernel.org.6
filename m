Return-Path: <linux-kernel+bounces-193933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC88D3438
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C31A1F216E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7617B427;
	Wed, 29 May 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S6VHkpof"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE317A936
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977569; cv=none; b=LWmFPksiLBnQXUGQMKW4nvXe6vlyHNY3ygRFD92fLHLgaYxuEty20VGSWeB7ocgSI3M0Gh9YU2jQh6eRGLeMxDg1we8nANlWlLBnR6EW3pTsnnnHYSVHVhimtNhUkMhCx2DHLQ32C+K/lYFyGAhE7N3J5N7Jf3qRat/49akTnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977569; c=relaxed/simple;
	bh=eWr057ec+gf7trR6PARl6ZZpSx5x9NSFPXXdi5AXD54=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujinXn6ucnaHJ5shlE/uzpPg2HSldQJ+iS+3c7b0Y+qCkm7YMky0AVoZK26N8Hd3lDX9n8F6vXH5JERZaN0XzShHQpQactmZMLAjDs1+q9E4ajDn/O+Ae6v7YnHl6JhCQWsznhJBUguZhTAwB0PFc8acahUxeT1aCKhKpCNhfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S6VHkpof; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52aea6067c8so554073e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716977565; x=1717582365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ctNrspieiQoHluKdsHIbyD9cWeGF6Jk4+Rj4NeYPNs=;
        b=S6VHkpof+SCKEZJqi1a0caA+AO1u7X/kYRND7jemLsvbNA7y+xEJb85r41SsHnwVZD
         hCbf2mECww2vDY470q0TBAzu2KVyioHLECUsHkxNztbNxT66gzapgxOcWayIdvR5Ze6K
         Mx3WKOvo3WsjeMCXoD9ZnHdX0fj3pKHWR6J0xR8xF/IIOLtu4h1Y3p5RddmVV1ZSsGdf
         YqTSZECKoVHMvImct5EUHVo+FggMzyBjHSLfPClM4MjWL0s/x3raRQnrk+h4fsBiw9km
         yEuSOaUsgkPiDaq8IR0rxsfj5JsxzTiS889WpNFduiFb/yQUwsDq7ovTby2ur25AgBKI
         12HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977565; x=1717582365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ctNrspieiQoHluKdsHIbyD9cWeGF6Jk4+Rj4NeYPNs=;
        b=udXkq4DJLQf3PGLn4vFVM1EtZi1xPEreG4fdaPymDKs1mwcFcrSJ+1gINPmfbq2eq7
         EmeQqjjlVpj6Q1ykbO467vqec7RH8afZapT2BEzASLOx2gEREwQgRT80YgTxO/I6ECIE
         3x/8WPsr4HM52fN7xFUhVcY7NTCFrSNI2vDgslR7tIE622UpZoQM0kOsX8Yt5gAAJCjH
         SZJrPO1rjbbWS+qDmGlFT1ltBzQfO5Rwqog3io1ceajh9ouah+j/rum0zTq5ty7mI5r0
         ibvDKi5NF+5vgWwqsm46Xn+NCGBWkWpgpgWrcG63wnKlixcoloYn+gFTvvAlKPPzqxcp
         YoiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1sozILzv825sKpqSLSrgFptE95IumbJw/SdsdHvloz+eQ2Vpy5TGHMksfi1fZ8wqGPAB7odHCnCYPPUJouf83dWwl1vllkdhORInw
X-Gm-Message-State: AOJu0YyV9y9wfX5YeC7Vi0K2V9UHyzG4kfLLRmmET3ahYQN/HHH2Cm2i
	5FEmHorah/OPgybR24mmMNd1mgmhqvsSORAMXFoN8Pa9H1llsFnHBGBn5/T/9go=
X-Google-Smtp-Source: AGHT+IGMk0vn/X5VQrBubZddEMNfpVeJx8QNyGLLnT5DYmMOhKzLD2kj/BeGWaaQiorP21ksgpDtOg==
X-Received: by 2002:ac2:5559:0:b0:524:6cb:586b with SMTP id 2adb3069b0e04-52a13a9392emr905202e87.23.1716977563098;
        Wed, 29 May 2024 03:12:43 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089b0410sm173580755e9.29.2024.05.29.03.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:12:42 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 12:12:40 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 15/16] powerpc/mm: Remove hugepd leftovers
Message-ID: <Zlb_mJ4GsJ76dV39@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <90a9c00eeb25305aa555fa5ac4f934dc2ba5ba14.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a9c00eeb25305aa555fa5ac4f934dc2ba5ba14.1716815901.git.christophe.leroy@csgroup.eu>

On Mon, May 27, 2024 at 03:30:13PM +0200, Christophe Leroy wrote:
> All targets have now opted out of CONFIG_ARCH_HAS_HUGEPD so
> remove left over code.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

