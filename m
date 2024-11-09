Return-Path: <linux-kernel+bounces-402623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9C89C29C0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8801C21704
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA9A13AD32;
	Sat,  9 Nov 2024 03:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kG3rOCeo"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D161EEE9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731123772; cv=none; b=XQbQsNkcgdxa31ah0QqMgkWn0NEYioZnADZfMMmTlSlaVr9j0/U+hsmUwO9suG0G2LJnn7KgOUcX14m6+jy0Ej2tFT1I/XPnaaYcKT7BGThKxRIms8IdS608Qd/3xrNL7lV0f5OcNv7eOCOZa3MgqS1fY7WXc7B+r+Y7hLdicbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731123772; c=relaxed/simple;
	bh=TnLYUUAe5m4mJGKWF3Ks+yXV8GuaBXP+kwPVwPMqcl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq1u2P6MNBbfzOS2BQHGo67GMDPBBReNikb4//H2K1geP20JZcK80AWyS1dG6xrgOUX72XdITozRHUXcNDiUrf4MuArotrBFYGIHacNB7YRs4w0SEM/+jV2VC6iMA3Be6S4v6oXJefn9PMf4AJfx9oMfaxRNTFdqBDyVbgEkhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kG3rOCeo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-723db2798caso3146590b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 19:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731123770; x=1731728570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdHT0Kza3CJQHBdzRRdhldlmXePrvNdZW3mqXRSZUBo=;
        b=kG3rOCeo/MFbXpxEQuQHPU0HqFy3Xqf6eTYAUul79xtWw5Otucdf9Loc4pudPET4NA
         CHdY0HEpNT7MxPrmbtpI9Ou71Mea0kss5JrqbXYos1CyRaS+AtDqa6wKDh2FOGaXX9Pr
         i6d9IZgrBHv2YUGwnINc4m8YwySwGU2EkO3eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731123770; x=1731728570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdHT0Kza3CJQHBdzRRdhldlmXePrvNdZW3mqXRSZUBo=;
        b=R795O1+RvCmRUwzwre0Nt3guSnhQ5DjeISl+UCTcxhMBm+0IS0r9Fi9W+ZRkJoV543
         3Q3Y2XyATBAdi9iyTR/P0TB8vWNELorTtgwtYw9+ajWD70egkp+6FCopFYT1QJi1WNWH
         EVboadvPFG2uBxUOWDHQq2L77Xv++h4pkbgdmxB7QlnKNL7NnP/ejDyWM4u+LfRh3TyV
         LWYOEjXRxX2yZNprTtPzseazsurOIDNGTnhxdhG7pwLOH3mG8YPbn1yV4iB+wv42HN9Z
         ZRcLUf0GnVWTOEIrPxog9VG7FYxujdCHypswdDqmSe4DpUYhB7M7IYF1qHoHChzMddvs
         fUdg==
X-Forwarded-Encrypted: i=1; AJvYcCWIeUOanz5gjgyFTB02mzT89iS1/h1H7ZQqxwK4JTUroTu37muFEyzhYQVAYMPjjq7KdviPwedjWDGFAwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUB7hgRiZA+6IfU2WO/R6DRn9R3rDRG5hbl2yy7Nldywi4YZ7U
	STp2QVWA1NsVMQ4N3KZLawGkAF/G2m4Rn9Dkl9TcSkcVXUAA1a5rOshxoqtaEw==
X-Google-Smtp-Source: AGHT+IFefSzkZKlLX0+SyOQukIr8RmvGx/98AEYyIc/+Ddx6MorxDoHv3EhcEukWRAiJd10QU6GTHQ==
X-Received: by 2002:a05:6a00:139a:b0:71e:6ec9:fcda with SMTP id d2e1a72fcca58-7241337ff37mr6306541b3a.19.1731123770535;
        Fri, 08 Nov 2024 19:42:50 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:eeab:613e:a460:41fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078bfccfsm4666547b3a.82.2024.11.08.19.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 19:42:50 -0800 (PST)
Date: Sat, 9 Nov 2024 12:42:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: fix NULL pointer in comp_algorithm_show()
Message-ID: <20241109034246.GB549125@google.com>
References: <20241108100147.3776123-1-liushixin2@huawei.com>
 <20241109011249.GA549125@google.com>
 <d1f5f56e-536f-5ce0-471e-4d340378170a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f5f56e-536f-5ce0-471e-4d340378170a@huawei.com>

On (24/11/09 11:23), Liu Shixin wrote:
> >> Fixes: 7ac07a26dea7 ("zram: preparation for multi-zcomp support")
> > So I think this fixes something much older, probably around e46b8a030d76d
> > time (2014).
> 
> The NULL pointer is introduced when zram->compressor is changed to zram->comp_algs in
> 7ac07a26dea, where the former is an array of chars and the latter is an array of pointers.
> Before that, if we cat comp_algorithm int the time window, we will get a message with no
> algorithm selected like this:

Good point, you are right.

