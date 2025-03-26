Return-Path: <linux-kernel+bounces-576486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A6BA70FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC3C7A4C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B3149E00;
	Wed, 26 Mar 2025 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SiA3AGId"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5766615B54A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742962588; cv=none; b=e5Aw0f5BkyvoENyrABvHYjn97cUAVHYw47KNtdcEo82Q0MKwAS3y3nxyrVIwOrDrNe8IAV0hXNDjWQXv/SvhMddmXBNMiLU/LhWOE9waqLs4KROJJvdVk0KUosyUZ1TgClD/Bb0Fp4SyVoz9E3555OllvKikMvfCkS3BqWxZcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742962588; c=relaxed/simple;
	bh=b3T0lc8NDDkNuPDjnYtA5sSPkSNqY6j3pHq3/4T/aUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEJhcCcSmpeLzhMt668LBfTh7ori9vLhoVZLHK6upAlZ2GTba6qiScotgfmN+1eRqPt79ytb2yDTlpSvrDh/gy61MeqVsHaIAiH57AYa5zkg0mxCEiv7qYAs8p4z9s8GrUtB0U9VgtFVW6P+YA6c0IHAq2+1uxH3N9kOTSERACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SiA3AGId; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2260c91576aso107325025ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742962585; x=1743567385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AILLZeGov018ovsXda9kodqh4SjOH5TnCaDx9SjPjrk=;
        b=SiA3AGIdUz6JqUrFz9CwulBJBjYKAsmcmggzpqBUu2tEs+Nu4XHhdmjovedJoH2FaR
         XxWz8V5oxwdzqTc9Xr7h9hobSkvRIx3t9Zc4lgoR46m+tE2L17R0k9SsHxJL4blpHFEq
         IfSFWTgZitn0+xBWSsAOzmdlrsBCyQ7T80o9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742962585; x=1743567385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AILLZeGov018ovsXda9kodqh4SjOH5TnCaDx9SjPjrk=;
        b=W0+dIUhijnR/WVovcHLbCfxnGkWLUc1ac4AgrUgiO+vQhcY+DfXK+j+7lEPE9gfWak
         MBHQbYR7pDBc4X9rXUeqKzrd+EARYmYFlwCPeSPRbNE1BQ8QW18D2g4lDSaQRkh0yzxN
         0wE0j3Qd3XlbNcOm8utchBWEM4ft+9jNPPLQLiquXg1I/z0NOLU2FnjPGKC7dLcSwJcW
         pIgduRqVQvj2R8yd6OGyy8PRiEyaAYbV0daccrrPI528bKyW1VF/Xq2bn5FwBaFBg+Lr
         pimIzF6rsatuJ6d2oaKUDoh2dWhTXHUXmOWD4POKzkMLbQqGmJGbfHVZq51rBIBNeRbz
         FpnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0I+PpfKx6Epy/W9anjrAYKclmwZ2rXNvs5q4IpQVI9j7qlGj37xp/7BrHNfRmiI7Yc6EFI3gWnT6831k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwQf/PrfSEq51Z6lRRGv3+LafM8cQ4N06pAIYBMr+il+anH8m
	M3Y1jgEY9y1C/pkcu2IDRRCGXIXIZu77JBZV+Dti2kY4D0cGRs0tMtG5bQdjNw==
X-Gm-Gg: ASbGnctetJVTsDbQCF+TeyD4Y2cyplJkylDHHAnP4SprBaPPBuj+TnUlabg89iq2lbh
	cpqfzkEG5+8g7MXpH2RGUMlZInN2McHD6AMo7OAIpYxZVLYmTNQ/KpIHudLg/BW1rQZMkbQi2oZ
	nCi5+tqmOLdJwo+e/gUi1/s6RNmgHC7500/f9VT54zD2y9FMGIVV5GoHlRtvYhHoSRHQ5kEK4NK
	ihvEMAugibRA6eP7vYGKYoHehBu4PuaytiY50JG6DwXJmQQoCUvw5pTlVQKS9sJU94s+K0cjytU
	SIlYr0EuwDvveoW4R2/i22plaebMGmbtkXJNf8/51cgZvLauDA9CF793NDQ=
X-Google-Smtp-Source: AGHT+IEYD4I81caHizx4b3QwHmB36Sk1YdKjB4tHwyQyr2ZnnKdYtVGO8dghifNfsTi3mSOEzVl/sw==
X-Received: by 2002:a05:6a20:3d89:b0:1f5:535c:82dc with SMTP id adf61e73a8af0-1fe4330dcf3mr32728235637.42.1742962585550;
        Tue, 25 Mar 2025 21:16:25 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d343:29c5:4565:9d95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab633sm11527409b3a.18.2025.03.25.21.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 21:16:25 -0700 (PDT)
Date: Wed, 26 Mar 2025 13:16:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Richard Chang <richardycc@google.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: modernize writeback interface
Message-ID: <5l4pjqlgu4afndn3ysa7ynecjmvepkfjlh56ycm5jt5e4mioqm@dujakwaomhlk>
References: <20250325034210.3337080-1-senozhatsky@chromium.org>
 <Z-MlsM2Gmxdvl_1D@google.com>
 <CALC_0q8Mv_UWvFjo3HW_gRsG2N8P--R1OqDj7=2x_98XiRXy4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALC_0q8Mv_UWvFjo3HW_gRsG2N8P--R1OqDj7=2x_98XiRXy4w@mail.gmail.com>

Hi,

On (25/03/26 12:03), Richard Chang wrote:
> Hi Sergey,
> Since the input buffer length is only PAGE_SIZE long, can we reduce
> the duplicated "page_index_range=" strings?
> Eg:
> Turn
> echo page_index_range=100-200 \
>          page_index_range=500-700 > zram0/writeback
> To:
> echo page_index_range=100-200,500-700 > zram0/writeback

Do you expect to ever have so many ranges that PAGE_SIZE buffer
would be too small?  I didn't want to put a list parser into
the kernel, I wanted to keep arguments parsing as simple as
possible.  But if you really need to writeback that many pages
then I guess I can implement it as a list of ranges.

Alternatively:
We don't necessarily need to use page_index_range key, which is a
little long, but can use page_indices=/page_indexes= or just pages=?

