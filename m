Return-Path: <linux-kernel+bounces-205542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8038FFD43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F38D1F21440
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0150F153565;
	Fri,  7 Jun 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bc/l3OYE"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C31B64E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745700; cv=none; b=OBmo66eX6sKHkcYg3t9hFnE4m2LpbIAbre0mrn2MUSSEYdyFqZarXFUpAq8jaaTHpw09THKKyFmAld+z3X7tkq9WQK4NgYD586xIooJezm5Kbw9V1IHvScSnQhBkYpTpZfcy//ZaZlB4ZuLWLIGE43YrML56sT/+Fb0tN3imH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745700; c=relaxed/simple;
	bh=DVWG9qFM30HDo5aJtCWa3lf5yd2di/TP/BqBIIr1kTc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg/f5gn66g0E4MfNcnntTc+cWJGS9SP2/M9PjlHub2HvFNrumT0qq0jlPloOK5Su5ZbN7oMuXnqjW/CALhNU20gVidwwtOHa71JYVCqyuyqNKMJpnrG1Y4KrZEWadKuJzZKvEEws5USQNMQVXiaDVdHFHqsvXTHQZQuklOc+44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bc/l3OYE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b992fd796so1889204e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717745696; x=1718350496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0hiqs37/YYfDkPbEWIHD+E1YcNVxWsv4TZUXhjiyX8=;
        b=Bc/l3OYEVA3tqPgjnayaXO/CQEsXk5wvX8y9pDmCg6vw/8F9k1kuhF3Q4KQVSrtijJ
         ZxS3bnHuOAm4ehWo/+NIwKtA4YW6oz/BQpo285cTBXgs0Jn3arsrysDhFejvwG32KzGp
         srcGhpgaFwBSQkgQsK28gRPeX13JMgLS58sUglP41buN5YLYBqbm9ioMQKmPckeDVKrF
         BYN8VbhhJmeyNf/yBeQXOWKsJZZSmOSg4Y6wrIKQXdbh9sRlw6bQxVTxi1JC2ixdH+5w
         XnDv/B4iimNv7K2KOtEzb9w4G8XTTudMrBpX65uO4BM5edQOn1ocKotNBKmHHRGlW+mc
         aNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717745696; x=1718350496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0hiqs37/YYfDkPbEWIHD+E1YcNVxWsv4TZUXhjiyX8=;
        b=PLSW9aec/Ca6dS4remUKuetixCbIO/yr1krig72PUsOMZ4RXMH0AQ2qlDtacDGl4ts
         0FuOvOl5ydFPgyoEUIS27wSYUKoFk/LBLugtEysSGA5STvyt1633jFDVD8LdgKAjcR4/
         guCOG6n+pDGH1BCklL1FFjn576y6mRchfgeZ64Sbdw/6IC+bNy4VY6Z5m7oynseuvFnY
         /1NI3DfuNcvp384Fh8uAy2ttR/h3mWo5+1pDJSHoHUjahO+LkvhR8s6jpXKw85fDdWse
         gK0PXfNMPLdJcDYcgriJhzO3uf6VLyvcWgv6v8/ky6o0/qade+lNQD08ac0f/ftSIuQr
         YBZA==
X-Forwarded-Encrypted: i=1; AJvYcCU4o/ZZPK5Z2gXXwDUIgTLR+Un0GA/gwk5nN8qb5Al9UxblyjOl+sR/TMi7eIKybnVlaNP1x8ePiX8KPIYbYkp/rRaBTkTyy8+2/Mfb
X-Gm-Message-State: AOJu0YyP+1CRkO03VsAuy+5aDIGWDjGhftX/e90ommHWRgf8geIsgN3c
	zmv7rfwtl9qVp9EyJv1dvigQHAz001pidMRgnrPVuIRET7HsdueumlmI6dvOfoQ=
X-Google-Smtp-Source: AGHT+IETPBZvvper/s0wnn4VSTIAEUU1vgglXMpyNGhfA/TTDOotwLa9A093Rv3iH6oKFyhOBGAS1w==
X-Received: by 2002:a05:6512:690:b0:52a:f859:fe4 with SMTP id 2adb3069b0e04-52bb9f5d0d5mr1357170e87.7.1717745695875;
        Fri, 07 Jun 2024 00:34:55 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c364bcdsm43774355e9.19.2024.06.07.00.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 00:34:55 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Fri, 7 Jun 2024 09:34:53 +0200
To: Anastasia Belova <abelova@astralinux.ru>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] mm/memory_hotplug: prevent accessing by index=-1
Message-ID: <ZmK4HcX_mLwTW6hU@localhost.localdomain>
References: <01d90f6c-64a1-4d25-a760-0d8865f6de95@redhat.com>
 <20240606080659.18525-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606080659.18525-1-abelova@astralinux.ru>

On Thu, Jun 06, 2024 at 11:06:59AM +0300, Anastasia Belova wrote:
> nid may be equal to NUMA_NO_NODE=-1. Prevent accessing node_data
> array by invalid index with check for nid.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online policy")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks! 

-- 
Oscar Salvador
SUSE Labs

