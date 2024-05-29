Return-Path: <linux-kernel+bounces-194179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E528D37FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A3C287A80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FAE17BAB;
	Wed, 29 May 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrnBRPJr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F403179BF
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990031; cv=none; b=C8RKWhsmLzRgBzTeKhrOIPWxwTjOUY1cDyK/mltTLIMhrZ1xoTGUgI2+IiptldFgqqyWOHa/h994IQaOKupMThCs/oAi94cuJdcZnXS/DaBAEnHDcn9IekFs1R6lo9IFm0anf8eO81Zwy9q4zCWy06At32h5ldntH6dN8Pet65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990031; c=relaxed/simple;
	bh=5Ez9jZH2PKtFGaFDWpF1OwKNiwRKcCs7djlHUD3uXEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Orw0Jg6ieqYA9PKSFECm/jK4BUVIKaN3fV8eXwUyiDKYj85Y0dOCoWaeh1eZn6OHNpmBtJEaBaGOY7R5YsPQJxSVWwxok2qL0C1RJ9+0Rf1Y0rgBluetOyIYHRAD+YgVT1tuZoFWGayQzREge5Z3pvVv+Dvq0aV755rn1L3Oq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrnBRPJr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716990028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ez9jZH2PKtFGaFDWpF1OwKNiwRKcCs7djlHUD3uXEk=;
	b=IrnBRPJrOM0XttJLrSlD16OTf8WXZWlguuaty5ST01oWTWZXdnAXah7SB6gcpeeOh9kswG
	L+UzlbFtggKgdvKRJP5d3xl1xCKvEUDyRZi0sH1MswViGdHpBPH+1RI0hxiCa1qpXUNrEA
	m3vQyY3yIytMMxmr1qLkMyO0n/OgTCk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Kh8HCMPBNhWikcNs1Wkdnw-1; Wed, 29 May 2024 09:40:26 -0400
X-MC-Unique: Kh8HCMPBNhWikcNs1Wkdnw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f4547311cbso16886885ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716990026; x=1717594826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ez9jZH2PKtFGaFDWpF1OwKNiwRKcCs7djlHUD3uXEk=;
        b=m2SYqfjC/I/ELNQo3KftrSjCUnIkIJvDvHjOl3fA5mkJfzaTDfaMCBdyW8ynj/yn4J
         rNbwswNI9cKwwG6Ekoc7mghdbNEWV/bJgHvOiW63tNdmgfSfB+F0tl3nV//He1kNKkhG
         IRtwe5GApD0wk8jJTVkQmv5hLBfVnoESGyk2Kng761tQPq8PV5iNmv9pgzBWDwMAbtbg
         3+2WIhtE/SgChpVRiaSbbu4T+zZhZMbmFYXMQJ5iGXt24+YtXqQN4xxTT9Cd6SXAZBP2
         EUhaM4TnS6elZjEcye3vtID5nUjtI5gSN/A6p3dXyvC3Grda/lDW8gCF1eWArWdSY6Uu
         qjkA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ65VhMKwgghyVPueE4I7OrnXlNd0aVHTK7Aa3WKDI+azi2EGFWGkbs/pjQ7JTUL9UKEBm3s/MntpVyQZDDSa31UhbkiRL/3P8G1Cq
X-Gm-Message-State: AOJu0YxY4ze38K9AsoJ3s/x/wi4QsqsUfH+Zs80i6Pe7tETbZ7Eoc2hC
	FpAUvSBH40mzxzH9Jq1hcp9oI5glWu6u8fmwJ8WJdXjIZKcLwei0sMeH5Up95LKdf5pz5Mox61M
	VKrzRUfUIQXXLRJYbmm6S4iKXFJkQrDc/LE4PZJ8liUClqRaMMX6ChpMAqEi62CW2LXYJbAY535
	jtQxWkQ4Fe+mMHtz9SZp2crxNXPduov1CS1CfI
X-Received: by 2002:a17:903:2348:b0:1f5:e635:21ec with SMTP id d9443c01a7336-1f5e6352748mr9142175ad.2.1716990025516;
        Wed, 29 May 2024 06:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0S5gXrV/GBghoh/ixew2azTNCZXBrjfD35PnRbeWfkCRz+K91GQKZf43KZEZzD7tyiTl1iRGus5zWGxQSZ2k=
X-Received: by 2002:a17:903:2348:b0:1f5:e635:21ec with SMTP id
 d9443c01a7336-1f5e6352748mr9142035ad.2.1716990025144; Wed, 29 May 2024
 06:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529142455.1c68e65a@canb.auug.org.au>
In-Reply-To: <20240529142455.1c68e65a@canb.auug.org.au>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 29 May 2024 15:40:13 +0200
Message-ID: <CAHc6FU7MrnksU9vDvdAvc_tv5knukGpnxXEpqidvdfWqDf1p5Q@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the gfs2 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Steven Whitehouse <swhiteho@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 6:34=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
> Hi all,
>
> After merging the gfs2 tree, today's linux-next build (htmldocs) produced
> these warnings:
>
> Documentation/filesystems/gfs2-glocks.rst:64: ERROR: Malformed table.

Fixed, thanks.

Could you please remove Bob Peterson <rpeterso@redhat.com> from the
recipients of these notifications as that address no longer exists?

Thanks,
Andreas


