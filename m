Return-Path: <linux-kernel+bounces-287171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11090952438
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B971C210A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43A11C7B70;
	Wed, 14 Aug 2024 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OA7UOBV2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB21C3F0E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668468; cv=none; b=uSkkUkTO+XGqfm7BWhU6iIh5xldAk3NzY/GLF6LWW5tXeRDeTmkgJP6ylefCEFV67SkbeicxbP22+3cZrvQZUQ5zSYX89pe9FicVBuAKvZx8nkKpnK5D/IY7q0R5+XYGO1u6IvRSBTpBk1uWRywHRZ+p3zWq/w0XdJXFbaAtX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668468; c=relaxed/simple;
	bh=xAuqg4LG4M0fbnSo/GQcVfg4wjhYXdK6fQ96rx9RI40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVnm6jKem8arPbwCXSf3k9u82PgQ2bLFKkYAj8rroZyRdcvcbt36n31efurgkDRpKSaiEqRM/g15m40+UT4HUkzXLV0cwFN80ZtjwIWSJq77W5sV2HL8Mkb86FtHlqoMXbQvBDbkBiFQZp8a1vT4WstWy4AiPPUbdpBhWo7I+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OA7UOBV2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+6lTZVqxZijRPSjfEzQi+vwTAY7CwJ2b1e+TxM4Mrk=;
	b=OA7UOBV25OigDon4mYpG0PaGojzrCq8mEdXd7EhmqAdIGNWqQ0WOjVSJ5WKYa2xd+4DkOj
	yh3/4+NVQ0cwBHF7IVZ7T3K1UWkNIqYonSldUUw1oHl6+OAhB1F78XyzzSRAz9Cz+lrBQe
	nb4OX+LP9lh7bJQwf0ribAeigiLUuas=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-KHf7YhIvNjebrVdxeU-lPQ-1; Wed, 14 Aug 2024 16:47:42 -0400
X-MC-Unique: KHf7YhIvNjebrVdxeU-lPQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef205d48ebso1961851fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723668461; x=1724273261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+6lTZVqxZijRPSjfEzQi+vwTAY7CwJ2b1e+TxM4Mrk=;
        b=WouqrzcHEIOKqrhcetJtq9bJIS4JWBuyg0Um4dPEVHCa/84yhEjuVCtF+/hGWdFPZN
         4OoNz7Im1FRC/T89Yw6x4UFWP9B255T/rSzussTwIqYh4uZJBZiHkpCX8atCVYL8cGTn
         /GqMVyEABN9f2XxuiNzVekiFdagc+APxip++tZ5b3XFllvTUAjEunLZG8dsBy6LVbCIM
         A0wRCPOFOnzX5sbP3t8ZkKV/2KA77JOsvRb0TXuPy96HOSig20J+oCkZD7w8FkaGEXHD
         gv257dJQi9W8KBoi4fg3HZ9nFWskXYB/yV9N80Y8ejaW40x+HDA9NvQvnd70hFgUrbpe
         F+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWwLwZ4TN9JTUYLcOFXKfguiz3QnwaPhYi8JkmbGCglkgBjvfrjQZz+0NjV3A/mwFAHDMPHwKMRPOcDEUGX2coj7Wj6DcEh642goV32
X-Gm-Message-State: AOJu0Yx2eWUTPio74OBOVRuFU/+dtuFJ7R6kSJQS3rSDQrqmGl2moCp8
	RWDSXOuHrIqZ5cUudP2CiICKDhA6HduF4JpSyeMvL+QdkjNDi1hC8ayLjVBuwFEF19gu8OpH3kH
	/7NY28F+dY27yDuhD0OJAQOEKLK5mb1yYB0/y1A+ja7IR+5otT4hMe9Il06vEqExiKMgpiDLGRZ
	ETpV5vzomuknhhAOBwYbrWWKLQqlq1aDdUZSkE
X-Received: by 2002:a2e:9683:0:b0:2ef:2ce0:6ac with SMTP id 38308e7fff4ca-2f3aa1f1dd1mr24000341fa.22.1723668460827;
        Wed, 14 Aug 2024 13:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOJF6QT6rKh2U8kgEkPVDV5badXvR0hhWLGciNfUm778LjMDYtscMG23tmLAtY9tHBPsjoWq2/pM4uncBTUwk=
X-Received: by 2002:a2e:9683:0:b0:2ef:2ce0:6ac with SMTP id
 38308e7fff4ca-2f3aa1f1dd1mr24000091fa.22.1723668460232; Wed, 14 Aug 2024
 13:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814143414.1877505-1-aahringo@redhat.com> <20240814143414.1877505-10-aahringo@redhat.com>
 <2024081445-coffee-antiques-e9cc@gregkh>
In-Reply-To: <2024081445-coffee-antiques-e9cc@gregkh>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 14 Aug 2024 16:47:28 -0400
Message-ID: <CAK-6q+hN8ZRAHc7aS7C_RO4pEGN1t3eA_vDChsSgsQOcJEU4vg@mail.gmail.com>
Subject: Re: [RFC dlm/next 09/12] kobject: export generic helper ops
To: Greg KH <gregkh@linuxfoundation.org>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, song@kernel.org, 
	yukuai3@huawei.com, agruenba@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, rafael@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, lucien.xin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 14, 2024 at 11:06=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Aug 14, 2024 at 10:34:11AM -0400, Alexander Aring wrote:
> > This patch exports generic helpers like kset_release() and
> > kset_get_ownership() so users can use them in their own struct kobj_typ=
e
> > implementation instead of implementing their own functions that do the
> > same.
>
> Why is anyone needing these?  What raw kobjects require this type of
> stuff?
>

In this patch series I introduced kset_type_create_and_add() to have
the possibility to do the exact same what kset_create_and_add() is
doing, just setting a different "struct kobj_type", for the kset that
is created internally by kset_create_and_add(). I can't use
kset_create_and_add() as it always uses "kset_ktype", see [0].

I am doing that to have only a callback for ".child_ns_type" assigned
as it returns the "&net_ns_type_operations;" structure to tell
underneath everything is separated by net namespaces.
I don't want to change anything else so the "struct kobj_type" should
look like what kset_create_and_add() is doing. Therefore I am creating
the same structure as kset_create_and_add() is using, see [0]. The
"kobj_sysfs_ops" structure seems to be already accessible from
outside, just the two functions I am exporting in this patch are
missing. Or I implement it in the same way in the dlm/gfs2 codebase
(that is what nfs is currently doing, see [1]).

And then we are at the two users of those kobjects that are using
those functions, it's DLM and GFS2 as they used kset_create_and_add()
before and I just want to add the ".child_ns_type" callback. Other
users could be nfs [1] (for the release, get_ownership - I have no
idea).

thanks.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/lib/kobject.c?h=3Dv6.11-rc3#n937
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/nfs/sysfs.c?h=3Dv6.11-rc3#n23


