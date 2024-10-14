Return-Path: <linux-kernel+bounces-363304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 405E599C03C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC40BB209DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F231411DE;
	Mon, 14 Oct 2024 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF9yxFTA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666A1A270
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888456; cv=none; b=eB7UOlxdta1nEJ4M441tVTowTiOgvwE9YL1KOUzNYP64Jlwxh2RG7d4nKlTNF6NOg8pvG+SgB8c99ylahQDbcxS37kQqFPxIa5YniSNzZD7J92NpQUwy54k8A1Wr8dpVI/qrK0/IZG4IEQw7y9TGOb/w/LYktUp6aGmlmgI/N/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888456; c=relaxed/simple;
	bh=geiKVVWurTTMbaHNh5ddy9vS+rzka6UiYWfq7KT0eM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMrfPQlSVcV/o0sd8ktDERyVaKtVoNawr0v4uyUaPZyDKPOdP4XfUzN9wqdaT77az67z1ndVJgDto5QSL17hRCoS3JlDrMdfioFWKFtf7ybGLFn4Lo6g8RWtziWY9Si5TBhyq5F9NHoMh9gvVVOvtB5x0qvefcUdrJACjO/8hkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dF9yxFTA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728888453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0rlO66l0G1ddEG+NUukiH15fKO4cHxOJ0004NGjApZ0=;
	b=dF9yxFTA9awb1d8Mw8AsS+eTbd2I8d2qylgjwdvqerFEnONPfH7/FPsLspdSmThQBCJx7g
	jVevEkNSykgOTAdz5uU8n/fBKRkxsp8EbDq3ZyUFmosMW47YgdtRVEtzv09/9Jzv0WDixj
	Vxu0jvwQ3JBUkbFJkBDkGkhVWFCC1ug=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-oi-QYRToP_OeujFwoDf9gw-1; Mon, 14 Oct 2024 02:47:32 -0400
X-MC-Unique: oi-QYRToP_OeujFwoDf9gw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9959df649aso303001766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728888451; x=1729493251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rlO66l0G1ddEG+NUukiH15fKO4cHxOJ0004NGjApZ0=;
        b=P9JzMuYM2RVYCZ6FpUqVOqRpiBsv2X11W06w6Cl9dAtt7VQ2NmooWje5OkiZHLiGp3
         SlERlpCnA5y8AuNi8j9O7KReHcB5xHkP31Rx6d9/SZArCohSPxWRPFzH8S+6dlDT0TJD
         RMKvQjKj3QhVYws9pkR6ULawzflCahDlDb11+LsQefy5OxYVz/L5D2YKiO3exnPDY3Sj
         FRWJzoUGDleMwmy3gjr0AsBo5PPlc12idae25HnnvgtVPHqFijKZpOIMijRUUUEG0jwi
         TbCDlgVQkYi8PS1nDHxpeMCW6htUe34SNuWKZ54WJKlhabd2xCBUqsoxKJ5ufek80e1y
         Ru0g==
X-Forwarded-Encrypted: i=1; AJvYcCUh4C1Hyn8WCDOee3YTNOLRms6lnnCsATXmRRH4MKZuhvBqvvfAryuS7Xy+QECdlv4qrTldIHRDFB7f0WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8sE1DOLPs1/wwTI6eZFB5x34Q3GRV6wF83ibHcvOroQ4mm+y
	/64mYMqI0F0WeqhQIbJ43sobobROM7fU4vwgMumCq1iMMLvZZSXPvgtJw6jCfv0rLmUc3maeKHI
	VxyV33fwZMGKCf5pmtNcBhWs1tgRD7cFpcdw5RF6TT3j4jrTHoICRoVcBzmGKDSHwfwZbjYWbsj
	/2yFNCoBUrvCIr4+6+/KaM1lr58N4leIBTWoDT
X-Received: by 2002:a17:907:1b1c:b0:a99:7455:25f2 with SMTP id a640c23a62f3a-a99e3cdc18bmr665135966b.39.1728888450751;
        Sun, 13 Oct 2024 23:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeOnrOdNUEBMfyq1gIKua3lIPx5v7BSWHO1RcInq0vuWfRf2Nuq+JEPEGDfi3YGea2aOTX7QV0c3/vzxWlHi8=
X-Received: by 2002:a17:907:1b1c:b0:a99:7455:25f2 with SMTP id
 a640c23a62f3a-a99e3cdc18bmr665135066b.39.1728888450418; Sun, 13 Oct 2024
 23:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-2-lulu@redhat.com>
 <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
In-Reply-To: <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 14 Oct 2024 14:46:53 +0800
Message-ID: <CACLfguU2cmy0UG4Zru49wap0U+oX6Como3NZvBxQeKgY8kX9sA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 21:31, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
> >The vhost is now using vhost_task and working as a child of the owner thread.
> >While this makes sense from containerization POV, some old userspace is
> >confused, as previously vhost not
>
> not what?
>
> > and so was allowed to steal cpu resources
> >from outside the container. So we add the kthread API support back
>
> Sorry, but it's not clear the reason.
>
> I understand that we want to provide a way to bring back the previous
> behavior when we had kthreads, but why do we want that?
> Do you have examples where the new mechanism is causing problems?
>
> >
> >Add a new module parameter to allow userspace to select behaviour
> >between using kthread and task
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 9ac25d08f473..a4a0bc34f59b 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
> > module_param(max_iotlb_entries, int, 0444);
> > MODULE_PARM_DESC(max_iotlb_entries,
> >       "Maximum number of iotlb entries. (default: 2048)");
> >+bool enforce_inherit_owner = true;
>         ^
> This should be static:
>
> $ make -j6 O=build C=2 drivers/vhost/
> ...
>    CHECK   ../drivers/vhost/vhost.c
> ../drivers/vhost/vhost.c:45:6: warning: symbol 'enforce_inherit_owner'
> was not declared. Should it be static?
>
> >+module_param(enforce_inherit_owner, bool, 0444);
> >+MODULE_PARM_DESC(enforce_inherit_owner,
> >+               "enforce vhost use vhost_task(default: Y)");
>
> I would follow the style of the other 2 parameters:
>                   "Enforce vhost use vhost_task. (default: Y)"
>
> With a view to simplifying bisection, we added this parameter in this
> patch, but it does nothing, so IMHO we should only add it at the end of
> the series when we have all the code ready. Maybe you can just add
> `enforce_inherit_owner` here or in the first patch where you need it,
> but I'd expose it with module_param() only when we have all the pieces
> in place.
>
> About the param name, I'm not sure "enforce" is the right word, since
> IIUC the user can still change it using the ioctl. It would seem that
> set `enforce_inherit_owner` to true, it is always forced, but instead
> ioctl allows you to change it, right?
>
> Is it more of a default behavior?
> Something like `inherit_owner_default` ?
>
> Thanks,
> Stefano
>
thanks, Stefano, I will change this
thanks
cindy


