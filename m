Return-Path: <linux-kernel+bounces-213958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B14907D06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C06EB26450
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2F7E578;
	Thu, 13 Jun 2024 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEtvOHCG"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3566E5ED
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718308699; cv=none; b=QWX65yMumzv9z76t837S1/+gw9IWWt2piAF74MSWdWTSAof3Awce56jzdTqHRt2HRcDew6Dgb/oA5ezv7tnJVHoOFBVWPVP5ptqR1kzVtbTDU3TuQ1iyNI6e/OIyyWufz87Bu3r13Gn0CR6JVj8MfgYg+WvJLTy6fbZLEd6oTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718308699; c=relaxed/simple;
	bh=Jxf4G1Cw44uD3kmRGCrTIT28JPe1a+FsUG1RBOkcXD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jtmkuax789V6MNkJ7qMCKqQAg3wbpmTZrNwEvKQ85pSS1cHkxEFr9EB9FTLvS36u/YjTj72vUn0xhtwB7hePSNZjDkFWpYqcNcBbMiEC+E3seCOnhNnWg/ugTU11rwweVoIHDJBVNemHza0ob+hnqmV3B1avmBk4gpZCr+ReKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEtvOHCG; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b97b5822d8so691244eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718308697; x=1718913497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gIoupV97+6nxLC7sqVzEqH827nnjncr+5XzDw/JAbos=;
        b=HEtvOHCGMId7VRXQZXAdXJMLl9hjYEUcsb04GwJqRHKkTcbDMtLoQGnm1JjINnquTX
         O0SELYuFRxhhr0TNC1a63n0jREaphwefqmsNUrm971fAnBxxxSjm67qi/cqDqCkF6vSp
         mA+6pKr+eihORc+hRD1XLEwsnA8n68kjAsTTNKN6LtVBlEJfthg7w1Th6Ya905cZZjwZ
         g8UDKi9Srj22ClhIDIhGsD+d8NYrLjmNBKs82MMkDuugpV3JaAKgaIu1KoKueSC8/I6c
         LEkZMYUUdIiAf0hSbrLdXzOE2X2ap2P9c+ZRBBqSiMBS62bogH+kRXrEbqoii2V/1MeN
         yAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718308697; x=1718913497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIoupV97+6nxLC7sqVzEqH827nnjncr+5XzDw/JAbos=;
        b=IarOT++o97RXrvoWTFDDvEUzBCSjfmxNkoyghZsIO+b0KCicb2IZmWYFWyYkW5eH3O
         ArLoaNEYxCLxf4eYbRR1iWIjmluf7j1Fa048FidkMZVkLGAd5/lx8Du9rIHoxwj3B0Sn
         eU+WdqyNHhdNpS/Tj41dshDrxe8URX/SXY/KIqBt+TND6oJG/UnUlkOt09ldPxnfN7kw
         SecQxzrP+pdHFWwP6JonGI462t0AH1xaqHXQHJkUfZ/Z6nAA7ek/24zsstmFCLTskPlb
         xMy3rrq+1IaKu52SHoEg26kc7pAFXF9nLuANSWr7rZ+9VFUP5zPrqOjpVy0gBThi8Rcq
         p3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKe7ymmXTLqTgvYFMIl9D94GF9ZkWlVXtq/OQOT0vnKO8uHX8H9bUx+lIbLALkwX/epwTmI5v93klm9ipcG8DGo1aBsNDgS+gLXUs+
X-Gm-Message-State: AOJu0YyBe1iOu/knJnw1wBsfnxCyoIcVhQvKNhvqJlXuLryZ41oOdKKp
	6VGdkoarsvUDEUvlvlfojY2NNmJm0cnvumPmnUl7wYR+is0Ilb0v2dXvAiRpVByQy8umGd1kG8s
	S0vCvVm/zAIQW4JigIo/W+2JTbog=
X-Google-Smtp-Source: AGHT+IEaDfvC8trFFIrTc3xuGkqGzTAeTKgYCAH89Q4Oqt4WDUyMpWYP7ZdsnvqScltazx1yVoWqZwtPX4Qvvi90t9s=
X-Received: by 2002:a05:6820:627:b0:5ba:71ce:f82c with SMTP id
 006d021491bc7-5bdadbbefb6mr778075eaf.3.1718308697236; Thu, 13 Jun 2024
 12:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718291024.git.engel.teddy@gmail.com> <ee01dbd2-fe83-46cf-9ceb-279a06ce9aad@gmail.com>
 <c0f2bca8-a7e6-4874-b5fc-98911a7c09d8@moroto.mountain>
In-Reply-To: <c0f2bca8-a7e6-4874-b5fc-98911a7c09d8@moroto.mountain>
From: Teddy Engel <engel.teddy@gmail.com>
Date: Thu, 13 Jun 2024 20:58:06 +0100
Message-ID: <CACP1t+tqj828NsSH85fKsm2QUPy5b9Nbk5RTb=hXg3MNS8CwGQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] staging: rtl8192e: Cleanup multiple issues
To: Dan Carpenter <dan.carpenter@linaro.org>, 
	Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 20:22, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Thu, Jun 13, 2024 at 09:05:03PM +0200, Philipp Hortmann wrote:
> > On 6/13/24 17:16, Teddy Engel wrote:
> > > Remove some unused constants, macros, and structs.
> > > Capitalize a constant.
> > >
> > > No specific patch order required.
> > >
> > > Teddy Engel (6):
> > >    staging: rtl8192e: Remove unused constant IC_VersionCut_E
> > >    staging: rtl8192e: Remove unused struct phy_ofdm_rx_status_rxsc
> > >    staging: rtl8192e: Remove unused constant WA_IOT_TH_VAL
> > >    staging: rtl8192e: Capitalize constant RegC38_TH
> > >    staging: rtl8192e: Remove unused macro dm_tx_bb_gain_idx_to_amplify
> > >    staging: rtl8192e: Remove unnecessary pre-declaration of struct
> > >      net_device
> > >
> > >   drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 8 --------
> > >   drivers/staging/rtl8192e/rtl8192e/rtl_cam.h    | 1 -
> > >   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 4 ++--
> > >   drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     | 6 +-----
> > >   drivers/staging/rtl8192e/rtl8192e/rtl_pci.h    | 1 -
> > >   5 files changed, 3 insertions(+), 17 deletions(-)
> > >
> >
> >
> > Hi Teddy,
> >
> > please combine patch 1 and 3 (Remove unused constant ...) . You can change
> > more than one item in a patch. But it has to be of the same kind.
> >
>
> Could you combine that with the earlier patch that deleted
> IC_VersionCut_C as well?  (Unless that has already been merged).
>
> regards,
> dan carpenter
>

I will, thanks Dan & Philip
Teddy

