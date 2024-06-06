Return-Path: <linux-kernel+bounces-203453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDA18FDB78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4E31F243B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41148BE8;
	Thu,  6 Jun 2024 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdbQVg3H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A304A31
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633787; cv=none; b=o5bL5BBAPUzRgsa08LN696cIMqT0kCZqISMrNSkhxxjKZXkOkHSDtJ9jwelQztpuHFwLtGvO+i7fV3q8tQTBO2JfUYCRnXaskwYz6JcTJ62wPcNY9b02vBLwpk6lor7lvLq/Bs9ed8s3kP6GmjwtCh/6RmPKZRgHrrHEMQxocNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633787; c=relaxed/simple;
	bh=9HRvxSNghce3RawNOIoiA49EDrjj1qS2aiw36T1Dl6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmNQrWv2DnDl0qktkQHi6SyU6y5faPnCpQoMSTaJeMQjr3rKAHMtb3XWs0VQ3Nen3jo1eyWkYJjRi/FitAshjH1HyUS7Roz7LEcB9gvpi7zAvGBEKyiferIlAGquuRsT350RQl74BdoHbIW68PQoay+4RG6O+n9HfVpY0HHGSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdbQVg3H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717633784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dy8RecKrsbrtUZOaJeeQUMzmYXMFk/2qfZzulio2MDA=;
	b=KdbQVg3Hrz6Onwmsh4jjC/V7cRuHedWJASTxbR1lCNAeLPmVa+DfRU2Pwcyt6/41TorH/j
	Nw9lJxqCO5dQ/PxfPfUmKa0J6GIuZfebS0xUIAq6PGfHIQSzAAiV3uw8spRzGrGWIurbY9
	Nc+U24TjtpHlEzQp/CMJbE9x86cBijU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-aD77jYaUOdqdi65uKXePEw-1; Wed, 05 Jun 2024 20:29:43 -0400
X-MC-Unique: aD77jYaUOdqdi65uKXePEw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7027585df9bso310512b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 17:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717633782; x=1718238582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy8RecKrsbrtUZOaJeeQUMzmYXMFk/2qfZzulio2MDA=;
        b=NvckkPSMQAx8dJzilYSyBBsyN8liepO2nuS2pm74C59A8zzPqyOmCC66SSZCK4W3L4
         pg/vc4vQSX+EWK1ViDtASqLb5xEWIoNDX+IofIp4MqwHk44yoTyqkFEbNcD1J91dZk17
         Q4e2Pnh5WUplBCEub0/vb7/WdAbvnvWYjfzJ6aJffDQvPCEdOxCfsLA/yWWVS8PLeTkD
         jpJf6ubPxp6iu7+REwjphrJRPuv9FmunO2aHi2mXExEZi+jcYnwXvUJZI329QsTPSfSq
         J/2zownVDOn/UCSmVVd/oQkpB6XT8KiG/oaXUTsS0qcAwI6sKNWiSeV78BJFBOKPXbX0
         GI5g==
X-Forwarded-Encrypted: i=1; AJvYcCXs86RbqA2falGHGX7uf7jmmEzDtVDUsB1oVs+RVMYt2Codb3qe8LEviNzbhvh30gJ7UKJ5st4rgv2+Jx0mT5a0VP1RcbrLldrj20MG
X-Gm-Message-State: AOJu0Yy1LS5EQjPlkfx5lQGrBQV353mnWcZDQHf5UVKwAHZNADCSOQ4V
	OZ5+EB2Ej8eve3JN2VnhFvQMbz7DDKhx59OnXzEBN5HsAFM+lLtCfmOw1G5OwHz2PyuR/t0GsML
	0BYA1nJZikhKJULxWEXrAM4sMQS1r8r5C/+aN9Oc/5TADZAWNA/uWRyMYg3SnJG7SedMQO+QDm2
	kCfSCwrNJ50dHMXlZULADi+FVzocj8r5ytv987
X-Received: by 2002:a05:6a20:a115:b0:1af:cecb:b64a with SMTP id adf61e73a8af0-1b2b6e3cbb9mr4760213637.9.1717633782169;
        Wed, 05 Jun 2024 17:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7dGT7LxJOjRZPml9gySlcFgSTsjNhhTPaTCsUhl4sJVsTFgjndYkpOFes4/KelIU21rBjWXq5/ZqgSpluWnc=
X-Received: by 2002:a05:6a20:a115:b0:1af:cecb:b64a with SMTP id
 adf61e73a8af0-1b2b6e3cbb9mr4760203637.9.1717633781731; Wed, 05 Jun 2024
 17:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605135245.14921-1-cuitao@kylinos.cn>
In-Reply-To: <20240605135245.14921-1-cuitao@kylinos.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 08:29:30 +0800
Message-ID: <CACGkMEvB4MoGqqOLvNyY8css8kq56-D5J2M4VZCM1AfGCojiRw@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio: Use the __GFP_ZERO flag of kmalloc to
 complete the memory initialization.
To: cuitao <cuitao@kylinos.cn>
Cc: mst@redhat.com, virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:56=E2=80=AFPM cuitao <cuitao@kylinos.cn> wrote:
>
> Use the __GFP_ZERO flag of kmalloc to initialize memory while allocating =
it,
> without the need for an additional memset call.
>
> Signed-off-by: cuitao <cuitao@kylinos.cn>
> ---
>  tools/virtio/linux/kernel.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 6702008f7f5c..9e401fb7c215 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -66,10 +66,7 @@ static inline void *kmalloc_array(unsigned n, size_t s=
, gfp_t gfp)
>
>  static inline void *kzalloc(size_t s, gfp_t gfp)
>  {
> -       void *p =3D kmalloc(s, gfp);
> -
> -       memset(p, 0, s);
> -       return p;
> +       return kmalloc(s, gfp | __GFP_ZERO);
>  }
>
>  static inline void *alloc_pages_exact(size_t s, gfp_t gfp)
> --
> 2.25.1
>

Does this really work?

extern void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
static inline void *kmalloc(size_t s, gfp_t gfp)
{
  if (__kmalloc_fake)
                return __kmalloc_fake;
        return malloc(s);
}

Thanks


