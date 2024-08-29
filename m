Return-Path: <linux-kernel+bounces-306380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB377963E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79C32817D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10D1547C7;
	Thu, 29 Aug 2024 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aqQsQk0p"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031A18A6A4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919363; cv=none; b=D1oJYc4hiZhcWqezyUSBpk4nVhdTr3slsvL9ar/ZAZGb4XXWYqfo5S3SeiAdF7yIdT0DJy+nHkoEk13QIsFjjj8sfvGebZcM9+boIinZMyGH9+poSSdiS2z8L7gkXI17JGzyk0+GoUM1uxYtoxrxP2yE4cf+NC3zI2uFtdEHq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919363; c=relaxed/simple;
	bh=hgfPFlygVsmSFU8MWVbrkM+wiYsy1kjSdCReS4KohoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dafwmh94AkFMOQTncJY8HjUnKGFx8dhFRWgH6MEzEF9cMHKar6vDMDud5DYURv82cXlmMPkySa6RWAj7TvecmCv/ckCxQFRxOppj7FmAoL2sHDMSZ+Vek3Z0lPUfy7NonFJd3LRqzp7jbV24TxDWCuRgWH1xbHgSkZUXluc5coc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=aqQsQk0p; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53345dcd377so484583e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724919360; x=1725524160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hgfPFlygVsmSFU8MWVbrkM+wiYsy1kjSdCReS4KohoQ=;
        b=aqQsQk0p9Nab8BUKB75HE+esk41HM5t2XSaJumkuHRagsJCuwC1wty3l2nZYo0RGQh
         EkdyWy1j5nbcuGWm3jIugjK3xce7gPlKBe4zootSVCLUN6RSNzx7J7bCL24lABWoAQ1j
         xc6y0iYsxE2UMMNRXMTSJfkr6O5vb9zTVu/L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724919360; x=1725524160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgfPFlygVsmSFU8MWVbrkM+wiYsy1kjSdCReS4KohoQ=;
        b=mACi8bFLWagtW7JssQVHvaJwRIyl+ofVLxlYp9RtAcOBHHVAUSNVzIdX1FwXSHByCH
         mEY2fiuGeR9LCIXVnWkgtT/YKWgBy8hVFh6jrNqqN1c2+L9teVmF1Xe4LL6AQ24W7msy
         UAka51bFdzzekH4GZnGL33eiIBXEo2JM7/b7/X0MaPjHGDCLcWeCGBnadcr/RosQoaXZ
         DHNFSSRlJcMoNe0u51E7vsMdUPlRsEAmO+DF+ZCUOzDcDCQ1bZv9Y9FHLn2yz7MR8C8S
         8iqoygjBsmuaBDLzpkzx7+lZqQyMSTeFuMLr1wqAcvoNq5Xv24GNUphiWUKgI4swXlZo
         q22A==
X-Forwarded-Encrypted: i=1; AJvYcCWQbWLLg/0cHRmqWlFXf+TlCV/h5i9Jg6ZJTvGSkMr0dgxddDTx/PrlaWRxN09G3Cj5qxk0isD3gL3RRUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxY24FGV+y3m4B0u9sDrlYOIdxku/4NXJIKTE7/Q12s+X8hCC
	VA1Z89RAh8kdgIKNElqgz1pFHIvFS99PzTwtVe0LZRZ+RdvPf3qEp9E+E6X9fo5/oEbRRa81bD4
	RkUFIn4yjWRFt/ax7c/SAXG9kau+9t4DVBW+9/g==
X-Google-Smtp-Source: AGHT+IGWS0LzVgGYASD5Jl73txQdZXI+e7fJCODjI9BM0dxAVFMbrbV6HBv0du/zkBXGadfSyri58PzSUbwtmzXp02k=
X-Received: by 2002:a05:6512:b06:b0:533:4b38:3983 with SMTP id
 2adb3069b0e04-5353e54d9bamr1037899e87.20.1724919360260; Thu, 29 Aug 2024
 01:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
 <20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegsttFdeZnahAFQS=jG_uaw6XMHFfw7WKgAhujLaNszcsw@mail.gmail.com> <CAEivzxc4=p63Wgp_i+J7YVw=LrKTt_HfC5fAL=vGT9AXjUgqaw@mail.gmail.com>
In-Reply-To: <CAEivzxc4=p63Wgp_i+J7YVw=LrKTt_HfC5fAL=vGT9AXjUgqaw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 10:15:48 +0200
Message-ID: <CAJfpegu2=ozU9LdceA+NP9gmaLFdx9TbhOAqAsN=1SNihu=PyA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 12:01, Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:

> I have also added Christian because he might be interested in
> accounting for struct super_block.

IMO doing it in the VFS as well makes much more sense than just the
fuse specific parts.

Thanks,
Miklos

