Return-Path: <linux-kernel+bounces-345936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48F98BD22
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683551C2319F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03DA1C3F1D;
	Tue,  1 Oct 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OB9HmBnj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086B1C3F15
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788397; cv=none; b=VgWu+r7hYxSecVbydpyK7FwulCl+O6N/Ag+EdevBxUzL6RUcBqa4ItIRk6z0IvYpFTH4tTNkGSFXE2WeTKqxtSg8od5PEG7f/2CV+Vk8CxD7hCBMvOuWCrDoNKXTchg/HHKmAtQCj2rJUPKH1FmW25z0WY4ZHWdDo9BB6Wjz+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788397; c=relaxed/simple;
	bh=UfrnhUQVyo2wO32SN5NdiKROG9kqZ27TtBQLwg/THz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqmSRYnUewwqh6blHyiewvSf95ac6SBHr1AbdDOnUp0vJn5UOhaCvpcid1O8vdW+PApXz0PGvSsYOVFGuwMq+ZBji2pS4F1cx9e9kVi5Zz+uUgFcS0gvhL2bPXB6aVw58d3Cw9lDac07AgzFwUk/HS8wkZe7ZzHHMdahhyE+vFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OB9HmBnj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727788394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTnDU1z73Rnbhrtpq9+SGsnBXv3PyIWuZLF800URvx4=;
	b=OB9HmBnjFx8zTuUHsLwKriKT2X7gA33uP6uBVWv87gqU9C8hsNi1QzI9j9sMz01Odtouzl
	mQTco16EPDZBaTdXPjc+GyM624FeUSxWHRPpFMtVhYr/D8LvJjizSOiHtqHF6XMC2iUKm4
	Ba7odaZXjSrrRmMMici7rkriwO3HgIU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-ojQUk-KmNpy977lAffUnuw-1; Tue, 01 Oct 2024 09:13:13 -0400
X-MC-Unique: ojQUk-KmNpy977lAffUnuw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb830ea86so36311605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788392; x=1728393192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTnDU1z73Rnbhrtpq9+SGsnBXv3PyIWuZLF800URvx4=;
        b=TdJrbpNoaVh3j3Cy4Qu/aI0eA4dmkjHbNDPj0Ckf2lFr7iVjlJKcMKc+T2NzIYCgFT
         mdP1uKU6c7gq1Qt3aNpPemHtLJbIRqmUTIafyk0ig2xOYUgQBjMZY6b/LV9TZGB7kF1l
         ILHEFIG5u2+FrSguDTTL4lCiiB5zc8ITYMz4E3K22VJEjmta8y1gORMW3D5o2BXD96/z
         npaozDPnlEOZ81mMBAvprro61uZmF7Oq8h6nDwnqNoP2S8dW6EVT9tEsVo0xw9gcCrFJ
         rKMSp5Y9VHZU+endokO6QMdDQTQwmdJLDk9McYQ3iRpJczPpXCD2iTYiwFgCY75zQX99
         f96A==
X-Forwarded-Encrypted: i=1; AJvYcCVy5EDxmyXRuPIH2z6GqeBl1iCxMcZsIYmNkH1Fd9Ij91tJVExLJatA2nG8xUMTQFzvBMPMYyvQabrjwRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOieGRKWx3WBaG7M8I/PdpqNDxx4fW6eSFnR2qFFvj+mZKzTVb
	FKcuVENC9PRBAigFknJMR1BDuk/bK/JFlwbq5rpaP5ZcT+HURiX/f7XZMS3dxxSAPNea6wWtr8g
	aWB7f7NhOHm5ujqZe4/U4yWLahmMjKdv9hHehijXLNkWldA96KkQ4BCq1nlgMiQ==
X-Received: by 2002:a05:600c:1c04:b0:42c:b9dd:93ee with SMTP id 5b1f17b1804b1-42f5849763amr112922325e9.34.1727788391961;
        Tue, 01 Oct 2024 06:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjWlB5VW/hUIu1yHmQgUpe0gbO0NGbAXuFYpqN1EaUiaOZRTPE0VVZwWGKTs7IiJ4sqC9Z4w==
X-Received: by 2002:a05:600c:1c04:b0:42c:b9dd:93ee with SMTP id 5b1f17b1804b1-42f5849763amr112922085e9.34.1727788391480;
        Tue, 01 Oct 2024 06:13:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55e:42b2:2c3a:bdd9:126e:d43a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec1c7sm132352525e9.27.2024.10.01.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:13:10 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:13:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wenyu Huang <huangwenyu1998@gmail.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: Re: [PATCH] virtio: Make vring_new_virtqueue support for packed
 vring
Message-ID: <20241001091259-mutt-send-email-mst@kernel.org>
References: <CACGkMEvieuDTp-DfhQ58EGbeFCvNmn4fUNmUdPHzex6pOetbdw@mail.gmail.com>
 <20241001093051.42703-1-huangwenyuu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001093051.42703-1-huangwenyuu@outlook.com>

On Tue, Oct 01, 2024 at 05:30:51PM +0800, Wenyu Huang wrote:
> It used for testing in tools/virtio/vringh_test.c. 
> If vring_new_virtqueue supports packed vring, we can add support for 
> packed vring to vringh and test it.

Pls say this in the commit log.


