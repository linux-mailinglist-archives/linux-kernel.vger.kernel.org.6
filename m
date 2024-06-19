Return-Path: <linux-kernel+bounces-221252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5CE90F0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D945F1F23CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89914EC4D;
	Wed, 19 Jun 2024 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJaiHwHp"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5624A14B96E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807874; cv=none; b=B32yfnOcUh41m5lZBIYpI0VPG3B3WjcizbX244CHOiCOLLUilQ21KFQa48d9WHhacHK2P0UA97M1b7ERpQCvqXnG8K+J/Lzjtg0KKEZH6W8UP5GnXVvEM2ExxLlNklcBBKS16E/D9vql8l1nV0RgKfAsx2e+U+0CXbSdfiE7Rys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807874; c=relaxed/simple;
	bh=xz8466KeS3kFFR0h/8XeCqzSrxi1hZ75OsH8Tv9FjPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4WtApZRf0WQrsnI57wQ4BBfhH8IMat+l1o4GgnSlU+wDvCE8ZPuzu82ZlLCCvtUzcqSCuqH5g7HzXXa4cns0CFZuinpkgjNyml3L8z3oFpmODM0c5/ILiEWGoPdz7DNB2Z3PrBlbydDDowt4mJ6zslNWNx2JfMYp+vL596d2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EJaiHwHp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so540580a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718807870; x=1719412670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mW6qIwgaMhv1Ukx6IUSceUqe9uJpeRHrbJHiEQy9EwE=;
        b=EJaiHwHprRqUXvGvwRBw5AcTvT/Qwd758d8F1zyOXd//VDqQphHziP4K96uf9N8337
         q3Un43RAtXDTkVE9XbcbNo3n2e2Y5ZsTExjxncHstu2VLXiYmKOe7adTi2iSBJMkSWgL
         VCuTLibikSimhZDssQQZCyV7XC9yFLPT1O2nkkPDY4FOg9rGGudFjwv17R7B32+FWC+h
         8tZLRqA31RohYeZzc3CKHmLX8rhqskC9t8IjQsXqJR/S3EKR756zKwx14J7fewvUQtx9
         ylJyCz7vk5PLewX4f+D28tNuj0qIJuXE6UAtjOUJcb3C68cZJCqYVZ3Vbb3gHYIZmaa5
         N7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807870; x=1719412670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mW6qIwgaMhv1Ukx6IUSceUqe9uJpeRHrbJHiEQy9EwE=;
        b=lvSOx5p1RLFXrTIO7YHq/Ev/tvO1cRbVN7A4HWgTV2ypwrEALfYX42ooGqFRsT11lU
         lsLfsOLD+X6SsuWMJGD1rTSH29m7F52r6rWxT2azroEh3YOM159D4SJIRZspPG9ht7lO
         WnFgSlQPQ5SjXSXSHk2+98bSgm6eC1N1E9XUe/jtD/IrGTuw4wdXMh5kBRz/BLcTq/Pz
         4PfEMtJCm+vG/obTC+PPeRdgvY1TeP+IkmQ1Jf7B6a+QcNbbZWFi24OOK66Ka0kOn58j
         1q+vGrSw4F2LeYQt6v7RBKz4u7DTSKfAudh9pByDaIkw4Lx8u4Xjm7rpcWVk1R3NZ5v6
         28AA==
X-Forwarded-Encrypted: i=1; AJvYcCVw+Yg8Fa2FT/a3Y8jMGlDsJUy6N6gycPBiU0c9UbHsiDWOj1CgIK8zl3ZdmFCDIg1ZBDUUbiixGOw35pzyY0ZYSfNSs5i+L0vd3idp
X-Gm-Message-State: AOJu0YxxcQIvd2MmZQJ46NrwF4LopdCdOIgpw13kCJkssNVuRZep2eRx
	VTIcb4UM5VHXgjKWGrqyUCwCf3Dx1251j6nsjoZtzFiUXZz6NxpTPHhhR3eNtzdjm1gXdMpbbh6
	3ze0gA1D4sOnl5NYjwn3yUYRFZ/ajCHZb/7I4Sg==
X-Google-Smtp-Source: AGHT+IHuis2PWxnbeePb9S0U1LQ2x2sGfOwuZsNdXB0g7qlMm761qcR5dMpoqfdYtNv6UIguJ9ZLskZKA13dNPaiPkc=
X-Received: by 2002:a50:d4da:0:b0:57c:b82e:884b with SMTP id
 4fb4d7f45d1cf-57d06ade10bmr1620556a12.19.1718807870558; Wed, 19 Jun 2024
 07:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606020213.49854-1-21cnbao@gmail.com> <ZmctTwAuzkObaXLi@google.com>
In-Reply-To: <ZmctTwAuzkObaXLi@google.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Wed, 19 Jun 2024 20:07:38 +0530
Message-ID: <CAO_48GE_YHFFjKBb6hhZQ4--3j3H3+AUTaPkZWfHTGgBa=b78Q@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/heaps: Correct the types of fd_flags and heap_flags
To: Carlos Llamas <cmllamas@google.com>
Cc: Barry Song <21cnbao@gmail.com>, linaro-mm-sig@lists.linaro.org, 
	linux-media@vger.kernel.org, Brian.Starkey@arm.com, 
	benjamin.gaignard@collabora.com, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, jstultz@google.com, 
	linux-kernel@vger.kernel.org, tjmercier@google.com, v-songbaohua@oppo.com, 
	hailong.liu@oppo.com
Content-Type: text/plain; charset="UTF-8"

Hi Barry,

On Mon, 10 Jun 2024 at 22:14, Carlos Llamas <cmllamas@google.com> wrote:
>
> On Thu, Jun 06, 2024 at 02:02:13PM +1200, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > dma_heap_allocation_data defines the UAPI as follows:
> >
> >  struct dma_heap_allocation_data {
> >         __u64 len;
> >         __u32 fd;
> >         __u32 fd_flags;
> >         __u64 heap_flags;
> >  };
> >
> > But dma heaps are casting both fd_flags and heap_flags into
> > unsigned long. This patch makes dma heaps - cma heap and
> > system heap have consistent types with UAPI.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Thanks for this cleanup; pushed to drm-misc-next.

> > ---
>
> Looks good to me, thanks!
>
> Reviewed-by: Carlos Llamas <cmllamas@google.com>


Best,
Sumit.

