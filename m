Return-Path: <linux-kernel+bounces-180341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 519BB8C6D35
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5788BB22173
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40FE15B0E3;
	Wed, 15 May 2024 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gvdru9Nj"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81A3BBE2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715804707; cv=none; b=KsmzUePtWTHRKBO1I9k741iKStaz9DxqPQtddirFiHsJ3PueOrfyTOE77UN1hUc/zAfHEEK6NukzqIVhsjcd32qsYUKAeEdpDXrMhKJaFbqxzrAG6yQBdAHG+Rg5shg9StoblPv1gUv1yOTWqcM3zJzlI2ecRRPDi2ol643iJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715804707; c=relaxed/simple;
	bh=IhLnFTXGWkaL/oFQUDYh7+KwCG7YqYhsShYzsT/U710=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hz8l1X4foWHtZ8kyczDhDCkz35RA989krQ+rQzahY8GWGeWyq5x5Sc4uCkzHuVVa7TVHENOSNFxvIM1vw83qcv7yk8VtxUWIVai1aHviW8DUPqhEVvaBNPFws1yHi/WcuoBuROuFM7zdS/KRZY9xeDDKYREru0uR0LJcj5hVkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gvdru9Nj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so2215567a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715804704; x=1716409504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bgHQeFNA/cjSL1J53O73FIjj3ip3FyKYiQHTHBqHu9I=;
        b=Gvdru9NjWzRrRv4kpmME4PPfQ3z8uVGzVtKFQqfcfQKhVe+F1BsqkBAkaeTZ/g36tZ
         xUJoOvPXmDq8UB78ErnIH7LCiv1TNAn2UzrLac/sOvDh6wmMmjUAR87CT0FJEnOZ3MEf
         66eyhSajFOLT8bkMe61DcSR6Ah6gP2Yph+epo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715804704; x=1716409504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgHQeFNA/cjSL1J53O73FIjj3ip3FyKYiQHTHBqHu9I=;
        b=jY0NhvJpTghJFA6KSH2LKovVZ+HCKX26GfgoHytxsyvY8pTVCpDbb4mOnHVOZA1G5P
         h3eYLidvJ+eaM1fZ2kJTbY9FiCwk0qgwRm41Dc2Dp8lRVuovvLw9pjaMAH/00OqHXism
         SAidBXPMLlifjcvRrcXMiJiGjthfEfIUs7+yd2+bqHHlEoJysf8BRljN3ETdJk769c3d
         xYJi+ZE5crk7486OM6+NSBby4KzZIKtmnlvQLUTqOa61sCC/sWlrEhnaYuVgtseNp7pm
         NCeRYt8H65YGMRKqE/G8K1aMcdopDrvPME2akg+vIjRIeCiV0CI8F0OBfOykh+bDVDQG
         cPeg==
X-Forwarded-Encrypted: i=1; AJvYcCU4UuYZS80sGqvA+jtzqHvORO0c1iuv20YB121BBPOMDU39kj6v11FnkJkVRgttu4zDcNi7zk8KA0eeDTccQWh688j6D/5pgljRy6Ax
X-Gm-Message-State: AOJu0Yyj2OJHmtd7O3haRKXTYgg8UaYaaknhx+9220lSqzyJpHHRv1sc
	nxkNW5AW/HW0Z5sqbVrTv5e6zY+1om1zgD/k8aVTjoFTpl+IyeHxDCUmedBUtUt/40V4t3O3O34
	iJyk2eg==
X-Google-Smtp-Source: AGHT+IFAb8QWQDpGNhHhI6BTANbxMAGwLOfTovFCGst0zzk54dhbkh32DwWAe1oSQgcN3IZoD3gJXg==
X-Received: by 2002:a17:907:986a:b0:a59:ae39:bfba with SMTP id a640c23a62f3a-a5a2d5c8c60mr1165647866b.34.1715804703745;
        Wed, 15 May 2024 13:25:03 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cd6787e54sm117957666b.80.2024.05.15.13.25.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 13:25:03 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59b49162aeso210488366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:25:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/JxnImszryLqe4cXnko94Nxtk/+laypK96tOJwAKXW3ZEH3DbXDZeoJIeLH0Lnqukm4/Kni3ye4zEIaVdqjys4APpo1bk97AnUZx1
X-Received: by 2002:a17:906:d9d9:b0:a59:b807:330a with SMTP id
 a640c23a62f3a-a5a2d55e4b8mr1135010966b.32.1715804702993; Wed, 15 May 2024
 13:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com> <CAHk-=whTqHgXZ4Aj8dNO3Peg9Rf0sh2F7zGWRUOmBwfMDxgvbQ@mail.gmail.com>
In-Reply-To: <CAHk-=whTqHgXZ4Aj8dNO3Peg9Rf0sh2F7zGWRUOmBwfMDxgvbQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 13:24:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWJCcJRLBZ1xoAATFyvp6YKN+qzrePhxQbN1SFrno7pQ@mail.gmail.com>
Message-ID: <CAHk-=wgWJCcJRLBZ1xoAATFyvp6YKN+qzrePhxQbN1SFrno7pQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Dave Airlie <airlied@gmail.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 13:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I guess I'll try to revert the later commit that enables it for amdgpu
> (commit a68c7eaa7a8f) and see if it at least makes the horrendous
> messages go away.

I have to revert both

  a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
  e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour")

to make things build cleanly. Next step: see if it boots and fixes the
problem for me.

              Linus

