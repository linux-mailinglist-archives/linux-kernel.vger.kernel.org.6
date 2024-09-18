Return-Path: <linux-kernel+bounces-332945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894C897C129
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A8E1C20F69
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D61CA69E;
	Wed, 18 Sep 2024 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiHp7lZG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F013A244
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726693687; cv=none; b=naC3qxCOh/MdilimS09gT7GvxWeqbjeyOq+YIwz8EavJj9yNeTSq9GoCIKhJFZezNIe/7ZgcB3LQgbh5utKwlxPiluGabBkWReGpUjyaAoQRBUHRYmz5IzQ2sL3Y1IA1eFSzYYGbJsUlqgi91WAkc3B6OVCEbRWKqHBkbrQ2dg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726693687; c=relaxed/simple;
	bh=wBM1ofSGNndQ096F+gd6jV81rsbzNDDn5M19SAETclk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZD4iXzAAT9k0tieG4+BIiAUGDVvX+5/bII5pkIEdWYBd4iZRW/1Zka1epV4pwpEa6j7j/YU/kg2GzTzSzbvcKKSgDruTz254L6C4tzY2WmaqVlwKnWQXGcaphjlgkVIKtsAZew+6uCW7Avv1d6BRFnK/CfQ2m2aBZQXexh+52UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiHp7lZG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726693684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBM1ofSGNndQ096F+gd6jV81rsbzNDDn5M19SAETclk=;
	b=UiHp7lZGbS7fpziVOHLL5zV9N0NqFsf3bff65229knDwA3Rz6xPF1YG5sEtBbGKpClIlkJ
	iBHDezbdffHeTT/X8GwAq8F3OEP6FTcGq0uQqg5hXD/A73ggQoW89CaBxfksrTXm/w4fBW
	+BeYcdJ0R4HH4WadFfuV3C7M0AMUXp4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-3AoH1m-nPVij8chmhMlPww-1; Wed, 18 Sep 2024 17:08:03 -0400
X-MC-Unique: 3AoH1m-nPVij8chmhMlPww-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa4678394so43246339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726693682; x=1727298482;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBM1ofSGNndQ096F+gd6jV81rsbzNDDn5M19SAETclk=;
        b=pa1egdUHR+Yz0+vqKfoEfWalZFlPHnjLEAtw9zj3OxC36GVfwwdFByaQKAJx5sxWes
         alQjulsfxaq3TEnhCibXfxs6pCDCLOiTvLxSBvX+iH4hy9m6YEY1lpgUWj067oG57S20
         qZb+ClzUDjFm8ly9ci8w6+UeQTfI1NMmaOqb4aLQbMJDGgYKbTzAiX63Yc+Hy5wR3d4V
         3fvAhh794b9ZQiryg7tdgcDEdi8ohnYPAodV15vFbIdWdH76uYBS167BCKyQ+MhSv4S4
         ApLkY36qCS2F0atZP4TJAq4vuWaGV+GLQYyitlg1TBVslDEBCVVUEDYK7lKPLafxsmy5
         TZ3g==
X-Gm-Message-State: AOJu0Yzhyd/TCrzI9g4jCSYODrmPDbqjz39QC/+Cc6BnP81NAF1lOgQg
	C3bQgaZukoftKpQZimrb642/UosBk/kCUADm4J/HIEc/OoQxOp0YaUl1qDj1STZKCIpYx7aWTg+
	zp2FSEQbQqMd3MTGYMgHPkBQcVjMXlYTAAuok7V6z5TTH8nKDm/hP9q3uDIaVFw==
X-Received: by 2002:a05:6602:6413:b0:82a:1f14:997f with SMTP id ca18e2360f4ac-82d1f8bbde6mr2516110239f.4.1726693682481;
        Wed, 18 Sep 2024 14:08:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkUVfTAp5Wr13Jqwkm/X1NBX5DOzVnNokAqP7pwBgUyqOhY9E7PXC6BFmhUymoXthcPBuzwg==
X-Received: by 2002:a05:6602:6413:b0:82a:1f14:997f with SMTP id ca18e2360f4ac-82d1f8bbde6mr2516106839f.4.1726693682141;
        Wed, 18 Sep 2024 14:08:02 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:2613:173:a68a:fce8? ([2600:6c64:4e7f:603b:2613:173:a68a:fce8])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d4926954asm281046539f.9.2024.09.18.14.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 14:07:59 -0700 (PDT)
Message-ID: <1b5cc9421cfd8dced181335b426646aef2f7309a.camel@redhat.com>
Subject: Re: [PATCH] driver core: fix async device shutdown hang
From: Laurence Oberman <loberman@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stuart hayes
	 <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Martin Belanger <Martin.Belanger@dell.com>, Oliver O'Halloran
 <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,  Keith Busch
 <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>, David Jeffery
 <djeffery@redhat.com>,  Jeremy Allison <jallison@ciq.com>, Jens Axboe
 <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, linux-nvme@lists.infradead.org, Nathan Chancellor
 <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>
Date: Wed, 18 Sep 2024 17:07:57 -0400
In-Reply-To: <2024091838-keenly-scrabble-8cce@gregkh>
References: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
	 <2024091753-estate-legroom-5d62@gregkh>
	 <751d4ba8-1e35-47a5-9a94-9873ff2619ae@gmail.com>
	 <2024091838-keenly-scrabble-8cce@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-18 at 08:12 +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 17, 2024 at 07:20:41PM -0500, stuart hayes wrote:
> >=20
> >=20
> > On 9/17/2024 3:42 PM, Greg Kroah-Hartman wrote:
> > > On Tue, Sep 17, 2024 at 03:15:17PM -0500, Stuart Hayes wrote:
> > > > Modify device_shutdown() so that supplier devices do not wait
> > > > for
> > > > consumer devices to be shut down first when the devlink is sync
> > > > state
> > > > only, since the consumer is not dependent on the supplier in
> > > > this case.
> > > >=20
> > > > Without this change, a circular dependency could hang the
> > > > system.
> > > >=20
> > > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > >=20
> > > What commit id does this fix?=C2=A0 Should it go to stable?
> > >=20
> > > And what driver is causing this problem, is this a regression or
> > > for
> > > something new that just got added to the tree?
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > This fixes commit 8064952c65045f05ee2671fe437770e50c151776, in
> > driver-core-next & linux-next... it's problem with code that was
> > just
> > added to the tree (in drivers/base/core.c).=C2=A0 It is not in stable.
>=20
> Ah, that wasn't obvious, sorry.
>=20
> > Apologies, I should have mentioned that from the start.
>=20
> Can you resend this with a "Fixes:" tag in it so I can just take it
> that
> way and not have to edit it by hand?
>=20
> thanks,
>=20
> greg k-h
>=20

FYI=C2=A0
This patch plus the rest of the original Bundle has been tested=20
at Red Hat on a system with 24 nvme devices.=20
Improvement was almost 8 times faster to shutdown.

Tested-by: Laurence Oberman <loberman@redhat.com>


