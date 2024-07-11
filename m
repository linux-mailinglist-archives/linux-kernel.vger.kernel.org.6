Return-Path: <linux-kernel+bounces-248823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA36692E271
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6C31C211CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91408158D6F;
	Thu, 11 Jul 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxKOdkJu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966E155CA5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686698; cv=none; b=B2PGEAWOJA5FK9ZgBrgBagudusbllJOLX/uaLSm2o5rfP7iTVcYjiTEFW6dbPP4TGFuMZuwz+hxCW/xo47gyg0FS6DagbMtUHkdMAAHuolXMXocDOrOXH2LjYwzw6Rn2DXAOitF0ULNo4Nb3OoWy+fu+J23GsaXjN2+cL5a1T5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686698; c=relaxed/simple;
	bh=J309idn94l6LfM69hofwVk6z9S7VT1vK5PVzSR4ifFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiMy4PrWh1o0ppPOWpRPGfHW2EgunhfE4r9wunzEW2mFiMbt+J6oyyRSiTYpgiJsx8NQftIcADZ5ge0pl/X3Zz81Ah72Uv88MYrQ7FMM/OxmukuYV+iLcIGv4P7X1ioPZMRgXxx61EKtn+2caxKANUhOSCRIjQ78YzjUfkrOZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxKOdkJu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720686696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsavuo7VjN4IgYGRQOpxjo6n2SWYiH9JroTE1iXSFAY=;
	b=IxKOdkJuuRUvFke+nipPaPBht/9CuajOQiN0BoLQXmy1hlWpQaHDVNZXoNohzCeq6Q7Oi3
	DivqyyEUZME3313TD39bPHyfuQJhIbE8wPCRaIS7b6ULrWtd7edIjzcS8i377k+twBz/UK
	mPFfzVrUwMFuyUG0ImcbT4X+GrXO7rQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-XsPmoLVlOuO_US59wkgpIg-1; Thu, 11 Jul 2024 04:31:34 -0400
X-MC-Unique: XsPmoLVlOuO_US59wkgpIg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4256667ebf9so4522455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686693; x=1721291493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsavuo7VjN4IgYGRQOpxjo6n2SWYiH9JroTE1iXSFAY=;
        b=oN1TPsCAyPKTDd9T2pNNg401B+cPr3OBGlMf0EQRmxO3kH5myKylUfcvi19D+V2AFf
         dcxxxScZcj2c4IBbygWF0+QiP8IV0Yye6FonqELpH5NamCyRsld+9hCoDJC4C61dDSxR
         shScK0QVAglSVNZv19mFFqmJ/6yxoWTqTBkZqP950gWJFu2HBhoJfaDd9JLOX30mhIXI
         2dVwIYjtuJXGdCztmxFiPT9gH8JxvST4eqfHXGSVBfduF8YNtyDYAmmSSbeqf+p8vgnH
         GfGht2xmwm7Qb+t0vHaRdoWvMFit4MLvJdzaCzIgQspb1c02Yc7YOBdu/lm9xEZPZf3t
         /sjg==
X-Gm-Message-State: AOJu0YxbCyqa3CzhFdv2vHOI9sCICzbwDiSVZO08yMgMkoa5UVVm8z6G
	vVlsDE95QLnqoUWFfVMzI6gwTlSl8XPq41XAuST67/p/e390lxiuuTaXnygEIhMgzr0hRYsGLPZ
	qE38GtPFPiHUcYfXpY4YwJgTIPBc26y/v1OFgruEdRKJbFK2TmB7cJFwP+BqitA==
X-Received: by 2002:a05:600c:41d1:b0:426:5d37:67f0 with SMTP id 5b1f17b1804b1-426707cbd7amr47937325e9.13.1720686693632;
        Thu, 11 Jul 2024 01:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEsGmNWWpKzLdjjvHa8Oly0TKggOk/fmTsEbwHHsuebuNMp1P87hEdumnvEl9dAnc+GlyWXw==
X-Received: by 2002:a05:600c:41d1:b0:426:5d37:67f0 with SMTP id 5b1f17b1804b1-426707cbd7amr47937135e9.13.1720686693017;
        Thu, 11 Jul 2024 01:31:33 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d? (p200300cfd74b1cd51c4c0c09d73bc07d.dip0.t-ipconnect.de. [2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0613sm7165414f8f.88.2024.07.11.01.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:31:32 -0700 (PDT)
Message-ID: <8268c602-7852-4d5b-86de-54b0a38cf244@redhat.com>
Date: Thu, 11 Jul 2024 10:31:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 Miklos Szeredi <mszeredi@redhat.com>, German Maglione
 <gmaglione@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Vivek Goyal <vgoyal@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
 <20240710172828.GB542210@dynamic-pd01.res.v6.highway.a1.net>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240710172828.GB542210@dynamic-pd01.res.v6.highway.a1.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.07.24 19:28, Stefan Hajnoczi wrote:
> On Tue, Jul 09, 2024 at 01:19:16PM +0200, Hanna Czenczek wrote:
>> Hi,
>>
>> We want to be able to mount filesystems that just consist of one regular
>> file via virtio-fs, i.e. no root directory, just a file as the root
>> node.
>>
>> While that is possible via FUSE itself (through the 'rootmode' mount
>> option, which is automatically set by the fusermount help program to
>> match the mount point's inode mode), there is no virtio-fs option yet
>> that would allow changing the rootmode from S_IFDIR to S_IFREG.
>>
>> To do that, this series introduces a new 'file' mount option that does
>> precisely that.  Alternatively, we could provide the same 'rootmode'
>> option that FUSE has, but as laid out in patch 1's commit description,
>> that option is a bit cumbersome for virtio-fs (in a way that it is not
>> for FUSE), and its usefulness as a more general option is limited.
>>
>>
>> Hanna Czenczek (2):
>>    virtio-fs: Add 'file' mount option
>>    virtio-fs: Document 'file' mount option
>>
>>   fs/fuse/virtio_fs.c                    | 9 ++++++++-
>>   Documentation/filesystems/virtiofs.rst | 5 ++++-
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.45.1
>>
> Looks good to me. Maybe add the 'file' option to FUSE as well to keep
> them in sync (eventually rootmode could be exposed to virtiofs too, if
> necessary)?

I don’t think this option makes much sense for FUSE, like Josef has 
said; it would just duplicate a subset of 'rootmode', and because FUSE 
filesystems are rarely mounted by hand, I don’t think anyone would ever 
use it.

If it were important to keep them in sync, I’d rather have virtio-fs 
provide 'rootmode' instead.  Personally, I don’t think it’s that 
important, and I’d rather have a simple '-o file' instead of '-o 
rootmode=0100000' (hope I counted the 0s right) for a filesystem that is 
actually not rarely mounted by hand.

If we ever do find out that we want to support other root modes than 
S_IFREG and S_IFDIR, we will probably want 'rootmode' for virtio-fs, 
too, yes.  But I can’t see that right now.

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks!

Hanna


