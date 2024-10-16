Return-Path: <linux-kernel+bounces-368052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4039A0AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69586B22B36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CCB206E96;
	Wed, 16 Oct 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgWxKPJ1"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91831494DA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083000; cv=none; b=mhPiQKX1/7yuxaSA1RYMOe5jQDXHPtrw4ZKL3qQjEaTdZ612gRoWo6d7xv+J0lBJrsDUrwAgntZJBaLn8PnrRca9HiXW8B/jLN/Mp5Moga++mi9ZHZdWEji7AKptQFnw2p3YiLQfrHFHKEWIEISvR9tEUz5TXjhlcmM27jFvfos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083000; c=relaxed/simple;
	bh=8KrfVMzR4HZBq0r4O4lrXKs1N36xXxex/E+Tj+FkITo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qi1VSx04AGtPz0RinOOH0lZwDX+a1lszUZ7ZuMlAx/7ofVHSTv4XgshAIfPOTgC68ukBO830KyxpFbUx7+5yMaKHYOx+objN+/u38OI2nqFTXk5JnG30w/ac/DVj7sySZWN1hVMGUWLpmUK04t7HSpDzN7puOBmXkrDEVCMTd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgWxKPJ1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so10908125e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729082997; x=1729687797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwGHiTybTT+PY14T21Xo2nguWPMWnszXygk/5cD3oEE=;
        b=kgWxKPJ1jO5hHUfYoVNedkac07Qkn1dzlm9sMQdn8cVAMc1mQ7GwdII8lAoiB2RNqW
         pOzRBu2U4cs+8OkHeel3EGgc8Khc4QgADH64ZKtlLFMBzluSv8QiA3bh0Uq1XzEtpw9X
         Dqs4ZkgFQGhuRJVXUa0mQ2MWnput1oUya6bDhV8tSNCQD6keoGGzw4vwA4P/jQdquxQb
         5v+pEpfUS9h5gAOSXkYmEowoRy0OKCWUjrvz0aOsX/6ZMhZKuTRXHP8nFrlWujHis8gD
         p37wUJo0VR35vJcVbAwm0Z6Cd0VEcoMpeMtoNPaG2XUFNphuSo6K84br1KChmZkx085E
         A9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082997; x=1729687797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwGHiTybTT+PY14T21Xo2nguWPMWnszXygk/5cD3oEE=;
        b=SwmbMz5pD1q2exC0Gd/blfQRL2/3oY5qKHHNtwlgeG2Fqhyw02fr3y7i4GnsEOUfx/
         YOpHFTOYoGboxmgePWDdalzmW/mDvXMSTMcwTG2jUKzQuExos+moAlF0sXdnO/Rg5fPH
         w8N7G+Y+K5wvstgHKX3tgjZ1RRigMKx/8WDu/WZoiZdXyrOQrvRTHPnAaS1h2jhssAA6
         k5fHfX341+DCq3Bw7CcGFqdg1XbVZEjIFftYueYNRA06NAgfHT/38KO8AYWlmvGD1Cfs
         qFJUmYSh9uA3cTIi67IWXzQVL6hCE040zevZ5QZyed+awwIyH7cZqNPGgT5j6jz/xvSz
         mWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVavRsftPzD3st5N6fpOlw310LIg6xkBW8GBegn53AZKwaHHhjgUifoBsn3iWZ/A3kGyOPMjqtnW7MUmQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoph1qkITzb+abaiiezM9XuYMlg9EsAgN5DauKztJ4s+ZUlkua
	xfVcjKmFTVx/6nGys5K83uYbsSc6ZzHCo3iKvIi7a4K33i2WhhK/
X-Google-Smtp-Source: AGHT+IHzm2MWkhXUwz3Xjr6o0izVZW34IIcoET6JDNtClQdSpXzYxggMPJL9h9aaLUN26dpvqgK3uw==
X-Received: by 2002:a05:600c:5117:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-4311dee59aamr182203335e9.16.1729082996762;
        Wed, 16 Oct 2024 05:49:56 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c5524sm48257745e9.44.2024.10.16.05.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:49:56 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:49:54 +0200
From: Dave Penkler <dpenkler@gmail.com>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gpib: Replace kmalloc/memset with kzalloc.
Message-ID: <Zw-2cszB8TisYXU3@egonzo>
References: <20241016103406.1618448-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016103406.1618448-1-roheetchavan@gmail.com>

On Wed, Oct 16, 2024 at 04:04:06PM +0530, Rohit Chavan wrote:
> This patch replaces kmalloc + memset with kzalloc in the GPIB driver.
> 
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
> Changes since v1:
>  - Merge similar patches in single one
>  - Make commit message concise
> ---
>  drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 3 +--
>  drivers/staging/gpib/cb7210/cb7210.c                 | 3 +--
>  drivers/staging/gpib/gpio/gpib_bitbang.c             | 3 +--
>  drivers/staging/gpib/hp_82335/hp82335.c              | 3 +--
>  drivers/staging/gpib/hp_82341/hp_82341.c             | 3 +--
>  drivers/staging/gpib/ines/ines_gpib.c                | 3 +--
>  drivers/staging/gpib/tnt4882/mite.c                  | 4 +---
>  drivers/staging/gpib/tnt4882/tnt4882_gpib.c          | 3 +--
>  8 files changed, 8 insertions(+), 17 deletions(-)
> 
Reviewed-by: Dave Penkler <dpenkler@gmail.com>

