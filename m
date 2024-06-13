Return-Path: <linux-kernel+bounces-212515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1CD90629B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5845EB22834
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789AF12CD8C;
	Thu, 13 Jun 2024 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OikrwlJB"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D1C2D6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718248657; cv=none; b=YVeawH9mnUDCxP3cz6z8f3EvZMwbWtMlefb+appu2bQmk7p6eU2hdVrJ1jFgeNEK/La4BQ+pVq7MTcjQVGHJPTMcFc+O3t8sC5AhjkhoD01RHbVia9OQJwdUmmw2h5wTrhHSSJAOiuOtyz/chnJKd2nWYgpC8Ol0WICspdCwDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718248657; c=relaxed/simple;
	bh=g5LKTBJbDXBBBsk+gNF4SkC4JuoCOrTdF+f1wcT0Qk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivOVxXD+tFwUfs0OpGAmes+VbYFzPvNVfx0KD3wdlZFjlXWxCCrLcKZoDhKTJA/qPyqo1oj4NDqwDTjSyH+onhypF9REtYzRXzP9Arej8aCGM7V3+yVbdLctj67Nxp6gpTM3FLpnW4lTos3Eex0r2yQyzET+MDPVraooHckbG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OikrwlJB; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-24cbb884377so280908fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718248655; x=1718853455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROLErHw7VUqD2WU2YKLH94ZD3LchcNJP5CBQl9Yi/1U=;
        b=OikrwlJB+Bcx6Xt8iuJnfrIvdh9jiF/PO5uc9FKCUHpdNdUZODd3dMSTwd1VTOKytV
         3Flb2/LZLSfbVMBfZLRNheCpG00TvzMSpIir89wEBc+HMf/1wxbXgD4Zb5143mTq5XvS
         ejVjpB4PGwu10Ozl5tTHv0gxvpAW5HasBTqUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718248655; x=1718853455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROLErHw7VUqD2WU2YKLH94ZD3LchcNJP5CBQl9Yi/1U=;
        b=nQ0Sf9ecBhLCDl/oZIBU5FD+fPoYWRG065PEgmNeN5luk9BIXCf8lTwVsBBDRc0FUJ
         AqTuCl3w8ldsFZIspeNvHffJFGX6SrSOZ1upnkVP4SaIRWW/G2wLkeeg88FbVUVeRNRF
         MhKcrTr8saKteOOuJon/YbgPyNxG9VRwvpQbjQETbkbxBy9dcMIfLKodiYcGqncDA7M+
         8DwXOGFJihipdNz51d9GrjePYw8ziSgt0kqUmUEVdWFLu1VRiDucv7Ci1lf8csYl3cnq
         m6uePTzmxZAWGP61XA0MHXpTg+PGqfhd2qS099S/ZRGyNzrz9dsnycTmFl9wMdsAP9IS
         NlzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUQa5p1aA4AA0TN0njs9HSOjNJAHu4xOvtT4tClEBy/RcFiKeqEbtnYutbtTgskwmFIbBNRVMFSLWzAZ0ftDdm/tFcYr+GvLbvHw2Q
X-Gm-Message-State: AOJu0YxQccbkXWb78RukDVWtB3t2RY6/3znL2e9g7tXpA4aAAkvViQGK
	9VDlQtz/ztoU7INqcpfv4Ncfdo5/6wmk2uMwT+685nxTWiEp1RYy1WgOX3sexQ==
X-Google-Smtp-Source: AGHT+IHs3itDhz3VWLaxjs7UbF6V8hUm2TAB9ES2x41XOkhO7+NJPCpnU1dGRrKgY/M6steDMbePjw==
X-Received: by 2002:a05:6870:71d6:b0:24f:d9de:3bf9 with SMTP id 586e51a60fabf-25514e667f3mr4251183fac.47.1718248655468;
        Wed, 12 Jun 2024 20:17:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:821f:fc92:6ed8:f817])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91e154sm311240b3a.44.2024.06.12.20.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:17:34 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:17:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: use copy_page for full page copy
Message-ID: <20240613031731.GB479513@google.com>
References: <20240613000422.1918-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613000422.1918-1-jszhang@kernel.org>

On (24/06/13 08:04), Jisheng Zhang wrote:
> commit 42e99bd975fd ("zram: optimize memory operations with
> clear_page()/copy_page()") optimize page copy/clean operations, but
> then commit d72e9a7a93e4 ("zram: do not use copy_page with non-page
> aligned address") removes the optimization because there's memory
> corruption at that time, the reason was well explained. But after
> commit 1f7319c74275 ("zram: partial IO refactoring"), partial IO uses
> alloc_page() instead of kmalloc to allocate a page, so we can bring
> back the optimization.
> 
> commit 80ba4caf8ba9 ("zram: use copy_page for full page copy") brings
> back partial optimization, missed one point in zram_write_page().
> optimize the full page copying in zram_write_page() with copy_page()

Is copy_page() really more optimal than memcpy(PAGE_SIZE)?

