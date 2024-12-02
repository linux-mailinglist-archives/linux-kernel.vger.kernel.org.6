Return-Path: <linux-kernel+bounces-428461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF799E0EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC2BB29102
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A7E1DFDAF;
	Mon,  2 Dec 2024 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HywQGaoI"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5A1DF746
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177955; cv=none; b=qUXxkC5CRma3u21JFc25EAX80TaoAZOWXRP3eXfgN2+CBP4egPnbYJ5+ozArAISDCWyTWTNKcO8jJRXP+nYcnDFe7FcWGsjMhKZRLGexddlTuK6Kiy7L4xTC1EcTDeeH630/s4hIQROnWKpevSrB/FKUAaYHTfuKih/oCH7jRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177955; c=relaxed/simple;
	bh=Z+QVSMEEjK0LS8J5R+iauWqCDh5TBeNBLgUPvSj2HjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUzJJ/Rqu87K9GMZmeY084L3AJMUWLLrZmRr8Ca/sKqvOu9t1eawrskzg8jdkPp6UOJIkYtbOeKxoKLpCa1DXZ+481ugsupOcga2KJVeCdrDTMpfVEAInK62ahUsSIagqvT2A7hhpgM9DViFTKfRLYBS4sx5UToNxDmoLKiP/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HywQGaoI; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f1e573e65dso1431155eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 14:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733177952; x=1733782752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+QVSMEEjK0LS8J5R+iauWqCDh5TBeNBLgUPvSj2HjI=;
        b=HywQGaoIHK6l/tXk+KKB9lX0uI04IeJ7wf1BoHICrPxxN45dgvTpdek63DQa6VT1o9
         ynGrvRiurO0/lrD0OeXqXMnJvMxkLg8hiYU7uP9DDLKzj5m9RQlXlOe0aTewdkgSGVlw
         v9afg+/cCMPI4JvQ8whWOGPPeQ1F6obEZsC2O5U7i0EOFSUdrcQvaT51PFOV4CZTbcys
         ryC8JmsdOr93FgP6ghfobEz87k+j8QwqU7knUvWxCC3PHwTy4Qw+BQdgEN6whnZ+sBa/
         JJ5edTGbLdNnJniGvvNK2xHkxDUWmoZ7TYNWp+0SWBA/pIC+SJTtJvZ1LjcMt/0tTuMe
         zLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733177952; x=1733782752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+QVSMEEjK0LS8J5R+iauWqCDh5TBeNBLgUPvSj2HjI=;
        b=dYAHZU5+fsIaoiiJZ4gtUVO88av7hwPe+LoeOfhGQXoGkadbWgYxPEVGdEu1BOMAyD
         nnD5hX+WYV2edVYgNoNtype8zHBXqBkeof9ecVMbJ3i1HZnjGzFonX2m+OebViZiLFRm
         juY3rAEYyFNBFSvC3UAZbKHFefmuJZU6ZpHyG/fCp0q77C7eQPqXQWS+gH1B3q8yxtaA
         RDWwF4VF3jqbEgjGIUXbBzwASNTEARKXnxufMNJABKTaH7vMeg8/OJIbOegaS3pASYTA
         HOuGUA12bsif9YNSofX9PQEn7t/KqmiZ6oRnHI9jOZrbG+dq6fDU9X67Nk6ipPPUZWwA
         5osg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Qmay3ddmxfyv5r2HHLS7IU4WP+B8aiB4oFSdBj1/NgR9ITnCFMSn8c82idNTX+OH1dadfaqCbKCcPeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyWcx4W6+xrWPuVmXHYQVBQfrUd5hpkeoqlw2ROUuTQZiluLcR
	X1F7Awsr51T/520L42iWE0ivAXcDjUDeitT3I3kqo9rpDsES7iMGNa1Q2H8VjA/wqzuJY+1H35u
	hd+3FvX+hc3vPPrIDeWS3AwD3TMmXDV7K3fj3
X-Gm-Gg: ASbGncuHeIBUK+V9czJLOi+GiWdn9mVu+3wOW69MzaDQAc+kpZIURSvUzM6MNyEuB1t
	jQNkB8kNitWveggezqVkkaXcYb/PrCUCteVsEXjLAYWWd0LjGW2sa/oNejsJRLL0=
X-Google-Smtp-Source: AGHT+IHUkaZPBeQviSYOsKB5i76bMkpozzTjH1NAPFuZVu+s8XxFCSKVHa/VsFE7PH6FEgTXJq6cL6qNXKZrXsbZuhk=
X-Received: by 2002:a05:6358:d5a2:b0:1c6:7d9d:16c4 with SMTP id
 e5c5f4694b2df-1caeab9addcmr56797255d.19.1733177952383; Mon, 02 Dec 2024
 14:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130001423.1114965-1-surenb@google.com>
In-Reply-To: <20241130001423.1114965-1-surenb@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 2 Dec 2024 15:18:35 -0700
Message-ID: <CAOUHufZdJEidYts3ZY+=oSReWNVakVovUQsRpuxKH=ogNxqVHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] alloc_tag: fix module allocation tags populated area calculation
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	pasha.tatashin@soleen.com, rppt@kernel.org, souravpanda@google.com, 
	00107082@163.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 5:14=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> vm_module_tags_populate() calculation of the populated area assumes that
> area starts at a page boundary and therefore when new pages are allocatio=
n,
> the end of the area is page-aligned as well. If the start of the area is
> not page-aligned then allocating a page and incrementing the end of the
> area by PAGE_SIZE leads to an area at the end but within the area boundar=
y
> which is not populated. Accessing this are will lead to a kernel panic.
> Fix the calculation by down-aligning the start of the area and using that
> as the location allocated pages are mapped to.
>
> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as neede=
d")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202411132111.6a221562-lkp@intel.co=
m
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>

