Return-Path: <linux-kernel+bounces-551835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1EA571A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08BA168F32
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9B6241672;
	Fri,  7 Mar 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/iyNop9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909C24FC03
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375574; cv=none; b=SFsTCIAFYPhicYainyr418qJRs9wrdqGJy8AUv2uHfgss86VPuCJNFzI4PHd2AA9x/QWWhfEXjSwFGqtN2uiMQIeQNDpflYL+xa2K7sXnzDh2HCiVarqFEtejdz6VbX5rTvQh7qh6DI1E1CkSU0kg9E5F0PISvIEkW9A/nuxbbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375574; c=relaxed/simple;
	bh=hBnIu0Xlfo7PAR1hQ0M2YcXPWDMV5negmRDPIWnIu4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0UBx9DXP+dLz95WLkuZ1Lz76EUQ6BfXivcE79Guwf5dOCuR+61yTmqGzDjuramhEprblwVZFQYLeSq5fZo6kR4Bzb75SGCace3y+Vd3Tg1zdLn+Xlt1PA2/g6NIRXBdEcjPqWzerb7lbAPigbwz1Z7chY0axp1TxNwUjECdN/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/iyNop9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso208535e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 11:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741375570; x=1741980370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ8UaQWqIa3vda379287qYK3S3G2j1GfNXMaEtrdj64=;
        b=A/iyNop9QO7WFTuCz2wAxMiYRnn2jyPYL7ecqpOr22kJVQomU0Kr/5CGwnA8WEbDFv
         8DeUysugwrWCKrC/kg1vUQM1L9113FS+pK6zITXQ6QW1WrTk7y03Lp75MraTa1ycST2W
         8hdOIJqfBRAcbGjX+mfjns3O40hj05plD6TtCsFDZmze/+zfZ6cyutLCCXGEvnZqqsVB
         DsEMrQRc4KJM6bOU/mEYoUFR8NYmoqRUMErNLPcHJeQ7nuKt6ep2s93cL3dEUxlpN/S/
         mIKE3MWnWv0KHN5ne+ZH/EvLuJW823gXj87L+lf6D04gIPL7gyKq6WVbVWF1APAN4ejp
         yh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741375570; x=1741980370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJ8UaQWqIa3vda379287qYK3S3G2j1GfNXMaEtrdj64=;
        b=UPFrWvzEPIyMJ7ggQHA1p0r8buLzlNCBqDfY+v6AX1Ery5jDch3T+cdvUyaxjeGXJ9
         n+qxTX9JMYYtCDkrmYMeKyda+e7yUWpG7RA/dQLDWSlqzywnSs/JHaTinuGs9HzLTiBt
         U8kQT7DkNBNQOsSrdUijmDjKIfIRmxJw+zYkNflV0bhdrx5VcEdy7g7YvClg1foHOh1z
         8czYa9SJ1vERS/9wMtmpXr+V5WFlHYb+yFY0ssHhR35Kg6JOz7zG+51MUrK8dU7rIMEH
         gpYaL9LgzDjQgBujQhODa5ES/HWVKImxzzPxtbASKxuthDLHqgDRSXTNigpjaF2B8wT7
         qvKg==
X-Forwarded-Encrypted: i=1; AJvYcCWzu2uo/BYjnrPwUiiQXMBg2XyKei3A/VaD3NF1JxAPIRFt3seeG1FLyOPYzqj0BVfLFQdF+jontO/4Ktw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZNf+dINiV0YNDHTArruDfaBQHCfbMwpMSNkzgHJaHdEKJgru
	dEC+8bKx0Aa/6Vo5wnZcq0XjAPt4h0cGig/FfFzlTf/F4xLqpwE5
X-Gm-Gg: ASbGnctIVcWEKp8kpHV04Ibq+Tw/MMRuUnFt+sl3uF0Cuo8zJDPTBZWCyXJlJCNOOkS
	DrdrpHpAKc68Lg0ujA/OEU3lK8HLDJoiyGy0huuDpfXNtnstvqXhUkVhwg4k0xa7Y+TFulfaf6A
	sKG6x205s3jCnw7mzagsh3PYODkfTHY4xbtnYddPlbyyaUZSgZHACjWsc/WkUCDvOtxEZzp/vQe
	eO/bKQ09NXUMvwtTZnY7Anf+xyHouCclH6uThVUHVCLvQaEHG/ytzL5Eo21lyAnNRgh7+RK0dIY
	/MgjC7Fr79+oPwIU8lTj5gREWm1RtAbZyw==
X-Google-Smtp-Source: AGHT+IGwL2b8gc/gS7dCHf+RS4DYjwJuU8VHvq/jA1tVjXmfJEK90HGc3P8fz0r/SDEeDhURxhKXJQ==
X-Received: by 2002:a05:600c:4f82:b0:43b:ca31:fcfd with SMTP id 5b1f17b1804b1-43c601e18e1mr35674915e9.18.1741375570167;
        Fri, 07 Mar 2025 11:26:10 -0800 (PST)
Received: from pc ([165.51.44.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd9493a2sm59174315e9.39.2025.03.07.11.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:26:09 -0800 (PST)
Date: Fri, 7 Mar 2025 20:10:46 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: amdkfd: Replace (un)register_chrdev() by
 (unregister/alloc)_chrdev_region()
Message-ID: <Z8tEti/ZRbx5pt5M@pc>
References: <20250305210809.218138-1-salah.triki@gmail.com>
 <a5b1d94e-30ee-411c-88f5-1e340068220c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b1d94e-30ee-411c-88f5-1e340068220c@amd.com>

On Wed, Mar 05, 2025 at 07:18:33PM -0500, Felix Kuehling wrote:
> 
> On 2025-03-05 16:08, Salah Triki wrote:
> > Replace (un)register_chrdev() by (unregister/alloc)_chrdev_region() as
> > they are deprecated since kernel 2.6.
> 
> Where is that information coming from? I see __register_chrdev documented in
> the current kernel documentation. I see no indication that it's deprecated:
> https://docs.kernel.org/core-api/kernel-api.html#c.__register_chrdev
> 
In the book "Linux Device Drivers" 3ed of J. Corbet and al. (2005), it
is indicated that using register_chrdev() is the old way to register
char drivers, the new code should not use this interface, it should
instead use the cdev interface. 
> 
> >   alloc_chrdev_region() generates a
> > dev_t value, so replace the kfd_char_dev_major int variable by the
> > kfd_char_dev_id dev_t variable and drop the MKDEV() call. Initialize a
> > cdev structure and add it to the device driver model as register_chrdev()
> > used to do and since alloc_chrdev_region() does not do it. Drop the
> > iminor() call since alloc_chrdev_region() allocates only one minor number.
> > On error and in the module exit function, remove the cdev structure from
> > the device driver model as unregister_chrdev() used to do.
> 
> Sounds complicated. Your patch seems to open-code a bunch of details that
> are neatly hidden inside register_chrdev. Why would I want all that detail
> in my driver? I don't see an obvious advantage.
> 
register_chrdev() registers 256 minor numbers, calling it will result in
calling kmalloc_array(256, sizeof(struct probe), GFP_KERNEL) whereas
calling alloc_chrdev_region() with count parameter equals to 1, which is
the number of minor numbers requested, will result in calling
kmalloc_array(1, sizeof(stuct probe), GFP_KERNEL). 

Best Regards,
Salah Triki 

