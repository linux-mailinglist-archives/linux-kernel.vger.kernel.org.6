Return-Path: <linux-kernel+bounces-306944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD8E9645CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A1C288449
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A61AB505;
	Thu, 29 Aug 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JukeghlL"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F901A76A8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936842; cv=none; b=EcBM3dFxd9iTyXtn9d6/lV60Evy6ViSaw9s7VFTTFHeeGueldXBZJpGi7qMyZnpjbAd2U81Bch362+MlQBDJUM69xUe4Wd5IMYLQKjFylX1dHakwgnZscrb2p1SqWeOLVXgE/4y4BKxICprxzz3Gwd58vE7QSZW0EOtpG+aLhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936842; c=relaxed/simple;
	bh=vhpdpTfvOWpq4BkpAeiQWNqUpz5BcVonWLnhkaxRaQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqMLDOa53C0LJF2G+We/c9TFBdMOFFSYftNjsAUks2H2xEr6+MDglJa/xXmzfoA4+T3Q5rHhGmAoLPKQsMvOpW/DEnP5BmaOxk87yipwpEITs54qliHTeVi5WYft2UL1bHDEx072rLxknbIp37EWP5K2We/r61k0bYtNvGOi1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JukeghlL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5353d0b7463so1134712e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724936839; x=1725541639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0TbsUu6WIFtUI0I/cmrO4B5vqQGbNpEnL8oQNR8OvE=;
        b=JukeghlLBK/lzpMdmTmuX0QRHVNvXFFbvE1U9X4DdctwndIWNfKsPJ7RcRRXTm1fFQ
         9zSqUWJuIoiQTWXn69t1NvhjTYIEmq1LYIDAiObJuQRerDSCPXsoprl3E8i5G5UZSR4l
         pNkcrCCVehg+uobEn5JdIjRNz0c/vb5CAOcfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724936839; x=1725541639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0TbsUu6WIFtUI0I/cmrO4B5vqQGbNpEnL8oQNR8OvE=;
        b=hoHxTyIvKk+mjECn6fBzQwFnYQR+pt10QJTkR9r/EIVFWmXxWIcrJNNHdNTOrqZh7j
         JNJKlcD803bg8nZyAao5Xs50sTBw+Xg93WqnuXolSMdR+cn2vkO6GUM8X84D3x7A7mK2
         8MHzP0cTcKN09GQYZm8pbkLQqwynu69s3szRmfT4wtn9DuNFueD2mI+s7jlYrWGyc7x3
         etZ+KoNgL0UcbdzZhsiTLb+ytQzsjQZttS+ev3/dvQdPy3bdwfFlL1zEBlVJIjooCtev
         3jDiUYETP1h+4DNlvwkvoqhfC3Ti2gBavFYdxQrHMW8sj+9CZQFA5DJ4sFJ1kqk0/+UV
         mIEQ==
X-Gm-Message-State: AOJu0YwC9eOsqFIpQvg4+uxac6ks+JtkF6+bAHp2AX8+CSGm2gFAf9Xl
	JFL+B97thpu0Ih7r2KtqS9D2eni2BnnXesSXn3Fo0jIRReHy9/F/RKAk9AXRglWwhGQn2SeUPEa
	d3atqW6NF2KRfEn7tdbttYdZiPaLeQxmRJ+hTpQ==
X-Google-Smtp-Source: AGHT+IGSRqyXut7tytiqq+Fv/FSdxZOLBx6kvkri+Nl7nKT6LJzc0hkeK3IT0QDDU6jjqcTAQkTG+kIWkupBmiQV4tM=
X-Received: by 2002:a05:6512:4003:b0:533:4620:ebec with SMTP id
 2adb3069b0e04-5353e543459mr2692053e87.3.1724936838878; Thu, 29 Aug 2024
 06:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709111918.31233-1-hreitz@redhat.com> <CAJfpegv6T_5fFCEMcHWgLQy5xT8Dp-O5KVOXiKsh2Gd-AJHwcg@mail.gmail.com>
 <19017a78-b14a-4998-8ebb-f3ffdbfae5b8@redhat.com>
In-Reply-To: <19017a78-b14a-4998-8ebb-f3ffdbfae5b8@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 15:07:05 +0200
Message-ID: <CAJfpegs0Y3bmsw3jThaV+PboQEsWWoQYBLZwkqx9sLMAdqCa6Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	Miklos Szeredi <mszeredi@redhat.com>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 at 14:37, Hanna Czenczek <hreitz@redhat.com> wrote:

> I honestly have no idea how to go about it on a technical level,
> though.  Na=C3=AFvely, I think we=E2=80=99d need to split off the tail of
> fuse_fill_super_common() (everything starting from the
> fuse_get_root_inode() call) into a separate function, which in case of
> virtio-fs we=E2=80=99d call once we get the FUSE_INIT reply.  (For
> non-virtio-fs, we could just call it immediately after
> fuse_fill_super_common().)

Yes, except I'm not sure it needs to be split, that depends on whether
sending a request relies on any initialization in that function or
not.

> But we can=E2=80=99t return from fuse_fill_super() until that root node i=
s set
> up, can we?  If so, we=E2=80=98d need to await that FUSE_INIT reply in th=
at
> function.  Can we do that?

Sure, just need to send FUSE_INIT with fuse_simple_request() instead
of fuse_simple_background().

Thanks,
Miklos

