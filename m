Return-Path: <linux-kernel+bounces-222589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A75B910435
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333541C2113A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD631ABCB5;
	Thu, 20 Jun 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="aXp0SCno"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E101AD499
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886616; cv=none; b=oDF5DIBPrZPRQJ7r2A5r5xyCXPl8ulVV47jVh22LvjTpRzFwbYj9z+u6drhpJswGUZgtvAFR/JSjWxEzoEttpif3PAwnGXQzJ3HJltbCMuGzSBmFD6Hqm3pBegYCwSPXDHQtiWNNivdO+EXsecRx3VaZXjh4W/iS+S68ojLh/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886616; c=relaxed/simple;
	bh=UpeE/DXkO/iG0fuoDqe54X/XOy1qooPFONL7bavexrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekrDCGeQIyAOF+AY7mXNd5PL/f6uwzNXj0M/L7D3MOltoZuvYO/+FpWMhCWyrnpxqr43v8iT78PBmGfTiB7pL6/wpYFajWjizPRw6bhWhGO9rvAp1oOXrspIReccJSzP7RKrn3bJ2flHB4cPM/Yh+MOGq2jfmefqvMK2eRQ5Dy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=aXp0SCno; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-70df213542bso589391a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718886613; x=1719491413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHMzHVKWhLHFRTFoXNvAkGLFcNNzxK81u0mLsBL7Zsw=;
        b=ZYBFAWZNumaLbvEgeSlWtnd2QzBuNDpvec6TE46rqqI7K+MiOufyVJE8QnDr8keLLS
         NMPYKiesnh8pRiWtv/P0wSjcE9svzWHxis9EkkTpUKht62wHPqQfRsdHLvlwyP7PmAu9
         u4Ncx2djo6C1Vu6lJWBjy2CANr1SvNEMa15KQew7cIJhI+glM0NylwmdoICGpkjIZRwJ
         RMhuYbhBQLY6OjABOQn+Qw+mGslnH9yI7iMK5ZDW/Yuwl3xm/NaAzFyzTkYvy/jnwJCX
         4Uyq4FTaGjPlqUdxRDEhZHiUFSP7lExLVrIXtdesI0JCk2V40wPGbN7XBV0hwThezi4K
         KurA==
X-Forwarded-Encrypted: i=1; AJvYcCUGaT/WFQZjAB/lpfqloE4NIT1r+pTOVGLSJENmK3PvvYfa6QxN6F3Yznj3U0B5T7LrCe36UFGxogFWBQSPulEV7wLqGyGnyCZ3U8eR
X-Gm-Message-State: AOJu0YyH9cJgtNCMgH4RLiIdK40f10X7oDHUVJkCB4C16TZ+lq8LzJk9
	Et71tAcKLWlozcOPIjJTzkhrYMy4mT18fLBGVX4NTt0lJOsSf1qe
X-Google-Smtp-Source: AGHT+IG2sObKQlJRXnm0zIOzZdnUzQkHNGXDXN4ljr7fpHYK1vVZLwAZQXoaLia921hIfW/T+oFYXA==
X-Received: by 2002:a05:6a20:3ca8:b0:1af:f8bd:1e4e with SMTP id adf61e73a8af0-1bcbb621263mr6188164637.62.1718886612218;
        Thu, 20 Jun 2024 05:30:12 -0700 (PDT)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ce93deafsm12346665ad.74.2024.06.20.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marliere.net; s=2024;
	t=1718886610; bh=UpeE/DXkO/iG0fuoDqe54X/XOy1qooPFONL7bavexrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXp0SCnogf1kctICBTqw7Z8wi6UuwmLy9v+eiQO0w9gmS8JLoACVhp0mBfR7v4iT5
	 bmEmeXw/RPFdoNoagxpXuY+dklCEBgsHq++DNTFYlEFnZEgzcTVRlP+J9TlhQ5PJ8s
	 KevqhZDdguQkINjtGu47lua2VPPVb2/EachWZQa6Dod4vUDuDb83t0nuDSRyzvV/18
	 ELp/w2Wp6wO+ewKae2r7fSouIbEJDRs1otLKuv937IRlgNR06ElV+eRW+gXkVlF+6M
	 AR1Z9s1pHpSPZcrp/jaDL8jjYfSj9rxnG2iXb7VLS35Jg3k7bQBwYucnbmS6nMNxiL
	 AxU2ybJSP1AiQ==
Date: Thu, 20 Jun 2024 09:30:01 -0300
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Amit Vadhavana <av2082000@gmail.com>
Cc: srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, rbmarliere@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] slimbus: Fix struct and documentation alignment in
 stream.c
Message-ID: <f64523f0-db39-4e3a-85a6-1a3cb07e2d08@marliere.net>
References: <20240616203231.43724-1-av2082000@gmail.com>
 <d6cd7441-53f2-4c88-a361-729e3abe81c1@marliere.net>
 <CAPMW_r+sPGF5=+=edLY81X+Cd4bMWKFJw3sDd0mzaZEM9b75BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMW_r+sPGF5=+=edLY81X+Cd4bMWKFJw3sDd0mzaZEM9b75BQ@mail.gmail.com>

Hi Amit,

On 19 Jun 24 23:28, Amit Vadhavana wrote:
> Hi Ricardo,
> 
> I have rebuilt it again, and there are no any warnings or errors.

Thanks for checking, FWIW:

Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>

BTW, I received this message plus another two empty ones. Please check
your settings. Also, make sure not to top-post [1].

Best regards,
-	Ricardo.


[1] https://en.wikipedia.org/wiki/Posting_style#Top-posting



> 
> Thanks
> Amit v

