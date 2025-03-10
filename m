Return-Path: <linux-kernel+bounces-554570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F7AA59A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26293AA29D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF6A22B5AB;
	Mon, 10 Mar 2025 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF20pPEJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD422AE7C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620879; cv=none; b=EQvchybGHZFZAhHs2QmBCOWN10d7ACKDhgTT4dr/sUhm96GVJR/st7RAToriHZsETCVjAMXh7FFo1doJK/i2on0DNd+zEtcK4S1577qU5lOI6jq9J8HXW4UoT4mbgxEW2cO+E5qTNP5Eh3yclQJhX6xWmz4AsHR/tiG2EVu6iDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620879; c=relaxed/simple;
	bh=Uqakw+yourYNBUhuzuW/M3+f6rWLBJ6lFYCFBPMwCWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a415JA2LpsaDJ9xyqsRF0HdMmDLteh0NDQdF2Q3kP9cHbFUCvmSQ86BDOON88HpZ9+C8xHeehfmq6Ak4HDWPFdmA2HbWwhPbubXEjqJ89ovhp7NVgXnK/UPqwB5KULTpqjuc1C9uF7txx1ALG3NMj5oZrrzVwYs3ZqYGWd9ULjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF20pPEJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so4703335e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741620876; x=1742225676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2UW3DGFaIT/OlHaafnnTm7ntqZnQZLSZf8OhxhOmO4=;
        b=nF20pPEJpxGm1rtHDWUBxh5SW2+GPpDDhTh3CzEYLu5faPgnI6g9GfBaoDeyt/rYrb
         7LV+hxXOvzRuKYFHYwcLrZaSqQsxmr5KOqDoupl38X1reEi2V30815KTiwJp8uyyW+Kw
         WHYe/iE0kgdALFleubvPumak1hfg5t9gP4mCnAzeniV07Zp8ctmuPthhK2rDbAxbYqy7
         uYkJApJGr2ErLUFQgt1SgkVMvWYXcId1DehGfXEZqWWQ6b0RiVfsvwxOn6RYZHS+bK/5
         g749CP9VV8G0JJb63ah9JRRvBoMI4tYI4Qp/XsvXkNkFnJUSUsAASXduwH90d9av+SVc
         tDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741620876; x=1742225676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2UW3DGFaIT/OlHaafnnTm7ntqZnQZLSZf8OhxhOmO4=;
        b=EeMn/FVtw0jn8UF6NZFBfOhZhYZolQiJUXpxJ6NqFq3Pa9McGvYnnZEzxvD9OkNdU1
         F6N8T+FewRweq59Y/bZV/Ve1+pCMxKjOSz3ijSVDKMZAX4neClK1Nj8incRCiJnnRX+T
         7h64yg0IrEckku0L+ZJtrJTAozT5eAn89fO9A3ARAbjH0zTW73qgNatimZrLmOvq3LkQ
         B6msHuzhtEJQqP7Myn11HXatOZdW7eQ9p+FB/N1qSk7Z41GN8UA4BWnV3aQ3YvgJLyT6
         btaLKzbtdvFYBIvgx8/jG1V/Jz59Fj1TOSMVv9i1aJSdqSOM8hWvLEfU/UFl6es5vSxC
         sDFw==
X-Forwarded-Encrypted: i=1; AJvYcCVEu41MvbFqaXTlgfY4inOA6j+014+pR5Iz2eRo3AIH+Q89Nxd7xg8zNasghxnfvZOaHTuHNQ24NZCVHJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhfVnTS3Xs+rTt6wSKSOiJ6DZBufa7NNXf485QvubqeUbnSE2D
	B26As4Fm2JnEWO7Jg9GCMhGf0gzdjJbJfpCDTk+ONXTZovsV3YNO
X-Gm-Gg: ASbGnctaoCHVdq7U8Mo3b27N4Y1DQUVtA1cziaDtOF70eMS7s68I/z/QYjxYNsxeExE
	JMeJd6KEFV0m/usILHdKfb6J5SyNwo13XlEwEC2yonkdEPydO1lD+3j9iz2c6s43umI5yc0hyiv
	Z8RA3fMLc46ZQiXLlfHX+h9oy3iKF+O+SFUP/5Tq9EU8UhSmRBjXi/lx/6espwv33+jldyhLlYl
	ep7juZAH1Yu3NOUgiIcPAZi54eTrwqtQLNQdy9SXPiwkhff5HeW5gkG/4RIJ+9E0AEtZIlC76Tw
	gnONKdqPzxP8yFNRCBzD5g3I5XO0dSHF0dg=
X-Google-Smtp-Source: AGHT+IFPB9H89htTJ8gi+6j6UdIu7tu/68Ca/noH/NXJTp/f9gbF0i/RpmkDIJCF+VEYSdvTCn1u9w==
X-Received: by 2002:a05:600c:3148:b0:43b:cd0d:9457 with SMTP id 5b1f17b1804b1-43c601d901dmr103550815e9.10.1741620875543;
        Mon, 10 Mar 2025 08:34:35 -0700 (PDT)
Received: from pc ([196.235.255.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce715731csm88286025e9.2.2025.03.10.08.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:34:34 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:19:09 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: amdkfd: Replace (un)register_chrdev() by
 (unregister/alloc)_chrdev_region()
Message-ID: <Z88C7ZzM88skw+qr@pc>
References: <20250305210809.218138-1-salah.triki@gmail.com>
 <a5b1d94e-30ee-411c-88f5-1e340068220c@amd.com>
 <Z8tEti/ZRbx5pt5M@pc>
 <b2068f4f-c832-4cd5-b9bb-e175217d7647@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2068f4f-c832-4cd5-b9bb-e175217d7647@amd.com>

> > register_chrdev() registers 256 minor numbers, calling it will result in
> > calling kmalloc_array(256, sizeof(struct probe), GFP_KERNEL) whereas
> > calling alloc_chrdev_region() with count parameter equals to 1, which is
> > the number of minor numbers requested, will result in calling
> > kmalloc_array(1, sizeof(stuct probe), GFP_KERNEL). 
> >

Is it worth replacing register_chrdev() by alloc_chrdev_region() for
this ? If so I will change the patch description.

Best Regards,
Salah Triki

