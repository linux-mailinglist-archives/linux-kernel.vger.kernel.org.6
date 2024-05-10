Return-Path: <linux-kernel+bounces-176231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF068C2BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429181F28FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B413413BAD0;
	Fri, 10 May 2024 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G9n/uCfg"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225F13B590
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376333; cv=none; b=n6HnDtx/xr71H/rZ16wHX4uZfbb2B3L5hV0jdvAkBshfrLkhq4u6Vj93muES94UzfDJAWOaFni/spkHUGsDhKjYO4BEKI8qEEL0Nr84hJ2ldQMmXvBmkVZ3RYBL1M4LqmjRnfp79gEIaHSoODqCQr6g1UCvo/Nq6TUGNH3Me1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376333; c=relaxed/simple;
	bh=pKK8FmPjaKeVmC/x9esCm6cF6BXhvjrK1358Io/3/iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcUyobIVtkZDpm6hq3d15ApGpFs3hDqRz7hu5BeLh4vunyAQbe/X7gjw/9crDkrVGKSEF2kHi+vmq7b+r+LRPmqn/dy4pOKmPKgD21cmASXLd0wVFcZr7nuj/hdbxQsfiep75EGi/Ju+hKuZJFXJ1/m4OtmT7EKv23CH06NGO90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G9n/uCfg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecd9a81966so25645875ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715376330; x=1715981130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbHwqyrBSxlaInOgJHXkpBV851gT6eWfUw4RtCMLqkQ=;
        b=G9n/uCfgON6ywj/zfp1Ci/0I71/3JmcoDhvTP2CXKj+T2adelSnjxVu2IAoVuypos6
         Via86B9ib8j/WgX2MeVHL13F00Dpf6FRFUpVHbr6o21r6aEb7ER8xEjqyUn0a4+ABW3x
         fHTIWKuMfjCA6gcGXqhWL+xNHl5+nIJOEfP6ZrmMAwQ7+7RrG4L98S1OqkrsKpcDaQtD
         /ey7IkoIWXJzLASvaVVu51+z6kC2T1dMPm1wOBWApBVDWhLrHBNdMS2x9ejuo7bJL/nV
         n2Tpg/rbQjXhoR0/l8DOcIEVhGs7xygxm1AYa4npJ0WtiVJ/kpwqxdzkeACKlgZ9x1lE
         aupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376330; x=1715981130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbHwqyrBSxlaInOgJHXkpBV851gT6eWfUw4RtCMLqkQ=;
        b=hqcn/IVtmRjhcB3+Y1QziEojCTyvkrCZWIjh3BvelX89f8GZNQVJOlqdTUvjR8Qi8Y
         2F3ayei1ORF02uDBin8onX+xtEDZqh/SAVoG+Mp2zTJVbV3soQ5rl0M+umWnlIylEBpZ
         sgGLxHCql0RX0qobLY9EnzhyJg8fqlJY6Kyt2ZNoFkyyIxJypcwyfj5kN4Q7SivwuzdV
         OR8qUYpK4D9W8LBDpm+c0SXDjQfDChYIDrVc7d9n7Jm0ph0TWbDpGYLzWWoA6p07F2xY
         hATYszh9yGuQhLN4bWSyD+jVVxG/s6+yGKYpsNCywUXYKYGHcErJk7pozC9Wpz3kLLkh
         2mhg==
X-Forwarded-Encrypted: i=1; AJvYcCVezrpA3zOKQcEcI82UTXHyaeo+ZAu9g4cdlu+9wtx1jcGbB03rABaJQfHi7wg1WS22rm0DQhZ1mX7Yfzh1gqIFDKm9XcVchl+tlK3z
X-Gm-Message-State: AOJu0YxMOOSIpbn6dmt3EGdSzY391xnF3VYskOJxL2cV+lasXN8QWLsl
	0VHXrcs4KKJ4qKdFmKv8QWOudyUJkDVmEyMipUHZuDI2PQkHRgdYUTCpJhba8f0=
X-Google-Smtp-Source: AGHT+IEW69BEVO8myOChhepwVIMyAvXTkksrs6sLcKMonG9mCSm10McFQyRA5n6lZJBf+YbxIyRNZA==
X-Received: by 2002:a17:903:2443:b0:1ec:b6e2:da8f with SMTP id d9443c01a7336-1eefa03a440mr105945135ad.12.1715376330278;
        Fri, 10 May 2024 14:25:30 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:629e:3f2:f321:6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30fddsm36780655ad.136.2024.05.10.14.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 14:25:29 -0700 (PDT)
Date: Fri, 10 May 2024 14:25:26 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 06/17] riscv: Add vendor extensions to /proc/cpuinfo
Message-ID: <Zj6QxisrBZSWq7ax@ghost>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-6-cb7624e65d82@rivosinc.com>
 <20240507-divisive-swoop-c2737a2d9a9f@spud>
 <20240510-childcare-outlook-d18e3cc5ccb3@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-childcare-outlook-d18e3cc5ccb3@spud>

On Fri, May 10, 2024 at 09:50:32PM +0100, Conor Dooley wrote:
> On Tue, May 07, 2024 at 06:03:19PM +0100, Conor Dooley wrote:
> > On Fri, May 03, 2024 at 11:18:21AM -0700, Charlie Jenkins wrote:
> > > All of the supported vendor extensions that have been listed in
> > > riscv_isa_vendor_ext_list can be exported through /proc/cpuinfo.
> > > 
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > 
> > This seems fine, thanks for updating this interface :)
> > 
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Hmm, actually the automation on patchwork is complaining a bunch about
> the series, but I think that's mostly false positives except for this
> patch. The nommu defconfigs are prob the easiest way to reproduce this:
>   /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:41:55: error: 'struct riscv_isa_vendor_ext_data_list' has no member named 'vendor_bitmap'
>   /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:42:60: error: 'struct riscv_isa_vendor_ext_data_list' has no member named 'per_hart_vendor_bitmap'; did you mean 'per_hart_isa_bitmap'?
>   /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:43:60: error: 'struct riscv_isa_vendor_ext_data_list' has no member named 'bitmap_size'
> 
> Cheers,
> Conor.

The false negatives always throw me off. The errors are also offset by
one patch. This was actually introduced in the following patch "riscv:
Introduce vendor variants of extension helpers" because I accidentally
fixed this issue in the patch "riscv: cpufeature: Extract common
elements from extension checking" instead of the one it was introduced
in.

- Charlie


