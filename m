Return-Path: <linux-kernel+bounces-172220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342618BEEEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5CB1F24E94
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D9B75818;
	Tue,  7 May 2024 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhUx3oFc"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F7187326
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715117887; cv=none; b=CL5e1jt0PVFOKfBHopFozt0RL9VUqZY5AIPlY336XgSafhSmYf9TP/b/ImJ2yNE2z5ahko2rLRJjVrJINavwxPxKpxJPwHsr4ulvGt5QZvZ+8tu6uRU6jM0utZEtcFY80HjGhdVcXGKZRgnPLk7I9nfImq5csVhlQ90VIfn0R+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715117887; c=relaxed/simple;
	bh=AZFqcBuqYSo71H41eUUtSnMMr07VxouumttOzkTRRkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZMyZFnIPevrJJNFfE+IypzeIcDzOH09R4Stjph8dZe22uIFLiTUBuxO/GvOWTYdVJEiF/Up2N7ZTH9PRBQ9qBnz2a/aQcfoQ0AWT8wMsk0A9DHNyTiqXNitX/sCnNQerSGTLOuuGWvDDm9H0BF7qJ9jeIUAFYnnTm+kWG082Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhUx3oFc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de8b66d1726so187131276.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715117885; x=1715722685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6UHygWSZRhuWrzQrskSZNrlKbfdaZk57WEJ9KAhSxvQ=;
        b=lhUx3oFclofdYetCN69qMHHc65y11JtAfcHQmaVMmP3D9+0qfhYAfTE9ZZ/rKGMKnC
         FESxbtV8Yu0MBdpHLZ1ipGpq9DBdg7xGPxT8iaHoRXbelmtr192mEdbuL65duLnJoSGe
         g7nKNoDTb/mWQ8GH1rujVvQ2VDgNOfR3lvngI8D3vCj8QWxYtAsOjSTgpodGHFyn6xa7
         1sgeWZvaUenNQSFRes+jiiBJIgiJagBfHkmOREJb3Cd9v/jsNUeA8lJu31ffdRJ3U8zl
         jCSqp/h8EAmgbdx96KetKMY9YJaIMrT7iJn84dzHkq9dobcIwESa5KceqqA9oktiz7Ui
         aq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715117885; x=1715722685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UHygWSZRhuWrzQrskSZNrlKbfdaZk57WEJ9KAhSxvQ=;
        b=nJC5yO9yxaRZ6acD2K6MFxazkzQOePyVE1yLFKtIAbG9sCPHsCmwktmwXhDNjzvA1e
         rLUwxwsiymLadcknOxw/kl8aKTUhuHLipBoX+kiiagHUouMpKqAgeALks6prcGFilUwb
         KTiSZaJKJCab7XKeVJEEzZoTjfBnGMBYdAoHCpJS0Ac6izzYWUyrsrgBzre2d+OCQ9Dr
         SxAzl/UYIhn4Jmgz3d4ei2s9Jra8v9Xnyl9ofEimEVcKYWMAr0bizMsQ8bKLhJEdLrM8
         Yh4upKuGqZnDqbyjOv8EIsZ5nf3qt3nWiPhGf295PHm7i9bHvJSYJpet1TaRlpxc6jKS
         +D2g==
X-Gm-Message-State: AOJu0Yx0BqXWR21oF/HDIKibOWwxtv9W414JgmW8MAOVbJi1przEzBJl
	ebvJFOdCNMs1u0++0/NxIAlOUD9hVsjU+9nJxdaEx8SPqke/IJKtghfqBA==
X-Google-Smtp-Source: AGHT+IGUHmpYNFbdnZFYOXUKYb/tVQWbc7jXHdiS94Jm9UDvU1z9Y5VYeJgiiaJ2407HatDTQyyw1w==
X-Received: by 2002:a25:d094:0:b0:de6:d50:ea0f with SMTP id 3f1490d57ef6-debb95b0850mr948602276.2.1715117885195;
        Tue, 07 May 2024 14:38:05 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:5343:96f7:3e43:fa89])
        by smtp.gmail.com with ESMTPSA id h8-20020a5b02c8000000b00de7e97cd06esm2782956ybp.37.2024.05.07.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 14:38:04 -0700 (PDT)
Date: Tue, 7 May 2024 14:38:03 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] bitops: Reshuffle bitops.h and wordpart,h
Message-ID: <ZjqfOzO/L0031fgA@yury-ThinkPad>
References: <20240507200236.527688-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507200236.527688-1-andriy.shevchenko@linux.intel.com>

On Tue, May 07, 2024 at 11:01:30PM +0300, Andy Shevchenko wrote:
> Move word part related macros to the respective header.
> While at it, fix the inclusion mess in lib/usercopy.h.
> 
> Andy Shevchenko (2):
>   bitops: Move aligned_byte_mask() to wordpart.h
>   usercopy: Don't use "proxy" headers
> 
>  include/linux/bitops.h   | 7 -------
>  include/linux/wordpart.h | 7 +++++++
>  lib/usercopy.c           | 9 +++++++--
>  3 files changed, 14 insertions(+), 9 deletions(-)

Thanks, adding it in bitmap-for-next for testing.

