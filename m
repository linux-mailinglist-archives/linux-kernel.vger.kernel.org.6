Return-Path: <linux-kernel+bounces-330562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAA697A034
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B21F22D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A8158520;
	Mon, 16 Sep 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECwUAGLA"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A70157495;
	Mon, 16 Sep 2024 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485947; cv=none; b=qBlQGaTSVUbEvJJlfj6jL9aQRq6y/hr8tnf/rYtsJiBXCKAl1WZ8cKs/rJuXmbzRVCmKXwMLwllN9aMU3+6JODka5zA/Wu0e5FbDC3zGZeKiOda8oqp7JTET6HoPxKUEj70whNEfZasI5G6kuLr0EAiow25/8SFF5SXtyUDzH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485947; c=relaxed/simple;
	bh=Jg423mwGXNJKSx+uvVzHPAwryRWZq9sVepn0uswME7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4UknYlFYvvhlO2IOJX7Q7Iu4RIgaFwOH1C3w6hHl7UW36cBeo/1Umi1A1AJOuPDYmnYZMdYs0m8ha2nNcMggW4EbnCHtZq0Ic1JaAiWwrgwE3nOciFfSAkTARk25BRYojK8ZyoRffYZFKU2M0nNwSBClXV1F3g89sNMtvNA8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECwUAGLA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374b9761eecso3548702f8f.2;
        Mon, 16 Sep 2024 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726485929; x=1727090729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGdarhuWk372yU46OMujXzMe51cIwvNwh9ENl2oBve0=;
        b=ECwUAGLAsKTbychsv/iO/Z5Iwcad8/khsROOahQzyl501lC6Y7ZTxGulWNZoO/KpF7
         38Iox4q2bLJZDbP0YbYpyFKk3yab0z98uAtHe1B1Ki+vrAzXW06OXjDOU46rrtH3n58t
         Oa/QkYz3B7uIJ7GNmqnD7gNbkWf9X3qfau1KJ/Ps3oYlBEJT223zHKKVPeu5Kz92cYLc
         mTybTRCOSshZHpBcJZ2zFt3r7TgZ6x2McjD9Bx8c5uX+hPLRjzFFF2lYGf0W3zpL4nDT
         Y/Syj97s4uTNtKK+nAOV4pDkY/5nhle6S6qj+oxQRHzd30eTClw66912UoXPQQnOmf07
         FYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726485929; x=1727090729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGdarhuWk372yU46OMujXzMe51cIwvNwh9ENl2oBve0=;
        b=NWlo6a35PFQiFC9QB6JzZZrFeklZcTFSpW3exmB9Lmy0e1BPCE1/9bU8+MLhR3YIxl
         sm0fJSowbStibEeIF4BJPLJwodJsbe3ARrluXE7aD6TEhqShjapKX6oVm4DDQCRgqIVz
         en023VkLQQsz7ES2FOq/rKHUvBoemmLFwpYupga5P3XpUG5aGngRuWXnLX467kREkBSJ
         +RQFzMS0dZHVFpPSJjfQqFHDWNTr0BcE/ExtQDD8tTl+P30nZvnZZzCi85Dp/aqb6sVh
         utqOAv+X4A3ZZDu2835CFLPLU5T8u9xlCKl1e0Zr9upkt5AXZPvVST++orUqiQ7XqiqD
         QdoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTkH0vickNofX/g7q0H2TzRtsz13vsPOUUdDEmTIDHmQon2sTqvZNROtlAzWf3YWlNeHWGTKJOPJFRraXa@vger.kernel.org, AJvYcCWLRrI+1Bn5mlXKwU6VsTOL04nQy6gC4kqhVtO0dTSQ3zqkAvzfHMCfVUW6KcWPjcabSh0kdaemNdyTs1br15g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymok3ET3En9vK+SkUeZYhPq4xSaQNcPt4qjvmwOXrHcLBxLdUw
	nTosYfy9PLpKFLo+fIM1aGgHhv93Lnb7QzAvsCxDM7BONtGjV2YX
X-Google-Smtp-Source: AGHT+IERYiVEgQ0g8zwBFA2shXp2w0/8MGWnZSEIObYVfBnxT16DBarjV9m0+t1M/1O9HWrZZeyVZg==
X-Received: by 2002:a5d:42c7:0:b0:373:54c:26a4 with SMTP id ffacd0b85a97d-378c2d5782bmr7669963f8f.54.1726485928241;
        Mon, 16 Sep 2024 04:25:28 -0700 (PDT)
Received: from void.void ([141.226.169.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78044dfsm6942863f8f.94.2024.09.16.04.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 04:25:27 -0700 (PDT)
Date: Mon, 16 Sep 2024 14:25:24 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] drm/i915: Fix typos
Message-ID: <ZugVpInvVElgJhym@void.void>
References: <20240915120155.101395-1-algonell@gmail.com>
 <gamwfgmreryzvy6fazduxs4z3sfjxck7xmsho4elpemcf7llpl@epzlqmudvrzx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gamwfgmreryzvy6fazduxs4z3sfjxck7xmsho4elpemcf7llpl@epzlqmudvrzx>

On Mon, Sep 16, 2024 at 12:15:32PM +0200, Andi Shyti wrote:
> Hi Andrew,
> 
> On Sun, Sep 15, 2024 at 03:01:55PM GMT, Andrew Kreimer wrote:
> > Fix typos in documentation.
> > 
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> 
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> 
> Because we are receiving lots of typos patches in this period,
> it's nice to have the context written in the subject, e.g., in
> this case, Fix "bellow" -> "below" typo.
> 

Noted.

> Don't worry, I will take care of it.
> 
> Thanks,
> Andi

Thank you!

