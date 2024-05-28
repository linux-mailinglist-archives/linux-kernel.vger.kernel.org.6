Return-Path: <linux-kernel+bounces-193082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7708D269C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91A0B2943E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B317A933;
	Tue, 28 May 2024 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDFv+7qH"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165A76033;
	Tue, 28 May 2024 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929859; cv=none; b=MfkWa7LI9gjuht8myHiyWbg0rOpAW+c6ko2EIlyu4yDXofaCN4eHF/wHDhbnUHivJJlotBfELluxHIa8OFXuJCHKyGupjsdwpzihDk8Eva66m8j7E8nVDcpAS6NWhabszJPrT/HW4UHdigOw5p88XxLzXUNznDpq02CYaricRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929859; c=relaxed/simple;
	bh=ivfEB51V5RQtcXwdoSkKOwsDvxwkOeFQsSAmsFWKswY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+16BTEHcwve9W1KvT35Zkpb7pL6r9wndLlo3qDC4sp4ZPQ++rYlD2AAdxP2M6uR7ExY3roY4+L3I64I6LzM/0+5I1yanFOPRSUTCIv5kGtPULlKl7A520NBxT6RGEKIzkuEsa4BJXdLuI01Yx5WocETu67/7AdFz7HvN9L41es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDFv+7qH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43f87ba7d3eso6587561cf.0;
        Tue, 28 May 2024 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716929857; x=1717534657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNVzbgaDjGFb56BGv6sqmcfumRGJbiIuHpwPOS++Khk=;
        b=SDFv+7qHlSRYJQG1n/LwgS2Te7udR+w2xcAltBnjCsESG8npdVYuAcEkQTIjwIFSqu
         OZyweoagsKygTkI06PTPEEx3PgLlythjKx4Rty0mtnv3CLAIf9txbdFbNMt3gRh2c3tN
         ClQz1/xZ2Dao82OA4qhRTj/8hJGPPECfBv1koAmGhk67HXznj33KwjZtd4tbT4uRROVY
         OEbv55bnX105O2QSWVq6z0w3nwGhn8GFaRpvAwZyVB8/HLpnjwH1O0i2R1QrKUjGuqHH
         s0qfNEkiKdEfghq8g1KrD3cy8hmS7cgMKiJTDYfa9gfB/icyy0Jd72OHzKVT3Td97mse
         p6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929857; x=1717534657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNVzbgaDjGFb56BGv6sqmcfumRGJbiIuHpwPOS++Khk=;
        b=EfAzrrvv7d8oZpAC74cPTFPJwrvhbnrxApiyPV3rnx9yUGVh9TO779zwtmFn7qPtBD
         XBBthXKG0o+QjsJkWsRmzB7+n65HxdT15+6xesUn5f0Dee6ENrW7KCNmjXz2wfagRkV1
         qRWL1kBQEA7ZWEJAdYJT4B5uBjjSVbyqC/UabfA+4GjGnNk13Pg97+UEgqk+d2AoBTMW
         qm3WP7SwPnVEuYa7DpnIuHVImu6TX4gIbsSDOwFZqDHlj8Yaj9bLeOyqLWBRyeKwFd+I
         GfIzz1MN74QNipdbO9y8oGzUf6yh7/dfhX9Ugz6sw1vXtFgwjkepgxa7P8SInt0s5u93
         /BXg==
X-Forwarded-Encrypted: i=1; AJvYcCVC53OzOdyX+HnDVTFvi3kvzhWWweh3+4WjwFCe7UQEkDh2aM5u8ir9mFp9TE0jvb84nyFqpEcEbxjplce5O3HMnZLLtDO4ANqk04g2zR2cu4DikL01BUROzwQjjRSCoQFU8xrqyEoCz+fYVGtr
X-Gm-Message-State: AOJu0Yw19z5ZE0nYFLqFkgepIpuNCtUJW/jbzIluaO2Rxa+fwb/+IgbA
	QcE6Kn2D6aaXPcC787JK+Vyh8JGM9HdEE2ZauVbM5nFVieAEeCTl
X-Google-Smtp-Source: AGHT+IGcAQMHf+4v9rvLoc8FOG8VwWn00vA6mIkiy2I1OVfKzEtmFRla7gikOtMn0NcjxJqZViY0UQ==
X-Received: by 2002:ac8:5f94:0:b0:43c:5d51:9e84 with SMTP id d75a77b69052e-43fb0e8880fmr111297301cf.19.1716929856255;
        Tue, 28 May 2024 13:57:36 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fe0310886sm2018811cf.96.2024.05.28.13.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:57:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2E5331200066;
	Tue, 28 May 2024 16:57:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 28 May 2024 16:57:35 -0400
X-ME-Sender: <xms:P0VWZknGOCpzYS9tWqmv2CoPBp3NWoYIx7tl1-jL90RxEpOqKrvvcQ>
    <xme:P0VWZj0flF0vyJ77iWtDaX1aef4uv6Ag12-wI8_zXD43VSu3KrLX7fqPdyZBU4MrS
    xS9Q8Z0XLwnT8uXsw>
X-ME-Received: <xmr:P0VWZipzvpVNBUP9L3j3rOaC_pKBFhCEK7GOGYUTjMxz1Dqt2pOijqgV_49TNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeeg
    vddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:P0VWZgkxKrljk0CTLl7ZPPfR42zS81AQO3rGPmtkhjqSzm4BdFATgw>
    <xmx:P0VWZi27lP0oJZa1m21qHvWsCZcVEuCVHYcwCCE1JqM7GHWI3TVNYQ>
    <xmx:P0VWZnu84KycSJ6DGwQ6bqGXub1k0OdglFM3OV891-IHQuBJuYt_Yw>
    <xmx:P0VWZuVTCGOdHQDqGUXTkva_wRc5DJSZn-9W5fmnYHQvuyQp22wm-A>
    <xmx:P0VWZl1DuJvax9v5EaQuBDicNdcS1cKUwsfK4c0WOwN8V21tzGT_fu2Z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 16:57:34 -0400 (EDT)
Date: Tue, 28 May 2024 13:56:54 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] locking/ww_mutex/test: add MODULE_DESCRIPTION()
Message-ID: <ZlZFFuo7tmzK7Iy_@boqun-archlinux>
References: <20240528-md-test-ww_mutex-v2-1-a2a19e920b12@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-md-test-ww_mutex-v2-1-a2a19e920b12@quicinc.com>

On Tue, May 28, 2024 at 01:16:24PM -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - Moved the MODULE_DESCRIPTION() after MODULE_AUTHOR()

Thanks!

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun


> - Link to v1: https://lore.kernel.org/r/20240524-md-test-ww_mutex-v1-1-4fb8c106fe21@quicinc.com
> ---
>  kernel/locking/test-ww_mutex.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 78719e1ef1b1..10a5736a21c2 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -697,3 +697,4 @@ module_exit(test_ww_mutex_exit);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("API test facility for ww_mutexes");
> 
> ---
> base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
> change-id: 20240524-md-test-ww_mutex-c18c263bc483
> 

