Return-Path: <linux-kernel+bounces-229912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6643D9175EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BC51C210F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40B91758D;
	Wed, 26 Jun 2024 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GW2NDDOd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9011184
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367096; cv=none; b=ts3GY5E+TnuRCv6oY4uvVQsyXkGiIuwvfT+UeJwScelNHGjhobPDJaTWFotnmfadcjOk/Sb/AYuvTSudoyzGSNQmW0dACjhCYgGuSkfGFJPJa5KRI3OtBaHwzwyEPctyPekSfsstogfnGQNrhi4oBazOzhstaUo2Dz1QZPZxdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367096; c=relaxed/simple;
	bh=zWTR1vyMVVMzJwH8R93Ew8aAOmNeGZMlUxUVANDOSQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/KhFGiLZ3EdvAX4yuKyWPw2Mfd50HzfkpK+XOW0/oraIq+tbnjddb1AN3QpYZ0px0/udLLQe7rdTeEJj/UJoXaMtCnqIxcjXQvABIqbBhX2hGyjo4YZzugDpJleklTU/d0QSsw9DxW4VIZJKckig72pFJhW6AhW+yleEZ1z7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GW2NDDOd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719367093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWTR1vyMVVMzJwH8R93Ew8aAOmNeGZMlUxUVANDOSQI=;
	b=GW2NDDOdsB+EwULYAcdW9rGmY1CyPuhkZ5atXGlii8LSvTxyQbY0XIWckjBTgitePIr0gG
	Hz3AC3/pm7X+sCmTyyZa5/nerNcnuhgluODEiG5TNAHratIQfr8/EWhd5OHp4kkph8CZXn
	WLaS0nozxiVSRxA4VlK232/NBDsImC8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-yQYiIzmVOPuwQFOLFpVDrQ-1; Tue, 25 Jun 2024 21:58:11 -0400
X-MC-Unique: yQYiIzmVOPuwQFOLFpVDrQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c7c3069f37so7750822a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719367090; x=1719971890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWTR1vyMVVMzJwH8R93Ew8aAOmNeGZMlUxUVANDOSQI=;
        b=jVuGu2JxaJn6j7URQ+7nE/C430yxKEjB2MxKLfvMRDqZZ6pIINXGcW4O9915i98x5T
         Qg4juuXn2baHX+ELsQzstxul0Z4H2H5hlTB5dXP5MKClvfpAC+0Afa5d5OFciwt+Hgrw
         opXwe2m/7j4HSOA6faQnj6mgKs/HMCtGP4oCBn3F1NKtg/wfEO2W+QraCc7zlQyfdsPg
         XznWjJhJS6WBbxGwrOFK+GaskIGbsU3GXQOYH1UhBVNFh3lUBNkWCDSnnJg1RWj0FYGr
         BkXEGgOXMfTKMCaqqPfYHcdBSiiTLTteMdxfxzlKwoDURNkVyo6tc7KAen0xycpykpQM
         glHA==
X-Forwarded-Encrypted: i=1; AJvYcCUsKjhdH0vjd7v9Qwoo5rhIq4sFpRWcfIa63VEBNktHjiT8fZhRdGXD4M6RB9FA1jolT5QbT0CdvYRyKbjRcQXHc/p3WaOPO9eIv0cw
X-Gm-Message-State: AOJu0YxCeI0fqp+CUVRdLterR4SFSxnpYz20fE0bsAIaR+lvKhD2AlS4
	Cw2UiE5u2WTFlSAI/HQ/gB0i2l8nPuWFuAgZ2hrkqAgiHsUITCCFn6rs3UNFYJ/laH+MhgnLhUL
	SV381Etvos7FKNdgw821h6llklHG1Lg+f7St9315DG+go3J4778POx2kdEsG62V8fqt5GfX4vlh
	xomGFEk5PxCH9yr6KBDfDEti/TvE9GoX2qT/Yf
X-Received: by 2002:a17:90b:1d87:b0:2bd:7e38:798e with SMTP id 98e67ed59e1d1-2c8612751c1mr7199499a91.28.1719367090325;
        Tue, 25 Jun 2024 18:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB6KboL7MhJ0JTwwWTxldeBEg5zl9FqhRziQpOhbKHYwMrQ+dftittxiaKI4yyaAOr7b7BfpkVUQ4MKdBxcOQ=
X-Received: by 2002:a17:90b:1d87:b0:2bd:7e38:798e with SMTP id
 98e67ed59e1d1-2c8612751c1mr7199483a91.28.1719367089803; Tue, 25 Jun 2024
 18:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625184043.10658-1-sahanb@bu.edu> <20240625154900-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625154900-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jun 2024 09:57:56 +0800
Message-ID: <CACGkMEvwAiQA6=TWExoioAaC+KFehBTo48L26g7eXwerUsOyKA@mail.gmail.com>
Subject: Re: [PATCH] virtio-pci: PCI extended capabilities for virtio
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sahanlb <sahanb@bu.edu>, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	drepper@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 6:50=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 02:39:37PM -0400, sahanlb wrote:
> > PCI legacy configuration space does not have sufficient space for a dev=
ice
> > that supports all kinds of virtio structures via PCI capabilities. This=
 is
> > especially true if one were to use virtio drivers with physical devices=
.
> > Link: https://par.nsf.gov/servlets/purl/10463939
> > A physical device may already have many capabilities in the legacy spac=
e.
> >
> > This patch adds support to place virtio capabilities in the PCI extende=
d
> > configuration space and makes the driver search both legacy and extende=
d
> > PCI configuration spaces.
> >
> > Add new argument to vp_modern_map_capability to indicate whether mappin=
g
> > a legacy or extended capability.
> > Add new function virtio_pci_find_ext_capability to walk extended
> > capabilities and find virtio capabilities.
> >
> > Modify vp_modern_probe to search both legacy and extended configuration
> > spaces.
> > If virtio_pci_find_capability fails to find common, isr, notify, or dev=
ice
> > virtio structures, call virtio_pci_find_ext_capability.
> >
> > Notify virtio structure can get mapped either in vp_modern_probe or in
> > vp_modern_map_vq_notify. Add new attribute 'notify_ecap' to
> > struct virtio_pci_modern_device to indicate whether the notify capabili=
ty
> > is in the extended congiguration structure.
> >
> > Add virtio extended capability structures to
> > "include/uapi/linux/virtio_pci.h".
> > Format for the extended structures derived from
> > Link: https://lore.kernel.org/all/20220112055755.41011-2-jasowang@redha=
t.com/
> >
> > This patch has been validated using an FPGA development board to implem=
ent
> > a virtio interface.
> >
> > Signed-off-by: sahanlb <sahanb@bu.edu>
>
>
> Thanks for the patch! As any UAPI change, this one has to also
> be accompanied by a spec patch documenting the capabilities.

Maybe start from one or my previous work like:

https://lists.oasis-open.org/archives/virtio-dev/202201/msg00013.html

Thanks


