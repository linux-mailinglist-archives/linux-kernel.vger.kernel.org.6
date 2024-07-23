Return-Path: <linux-kernel+bounces-259612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1B793998C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405301C21AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A1A13D60F;
	Tue, 23 Jul 2024 06:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="el2bMVTj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D113A241
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714572; cv=none; b=L9K8QDPloD+UaVIDvg3WypOU1A63HpE57lpEtClCDSVMZ8jBJbT53mOFzW396R/gH2NvJTdvN8CWaBFq0V17hJ5IZTilpavOhoxIN0Jn6HEcexEYeFuewRDZoDUxmn1363B6+xkrWI3MMKEcO4M4eULuH10TB0gPGndiVux5Cvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714572; c=relaxed/simple;
	bh=xY4Nr0ZV/G5xCs74taELZsVvfH8f1KeA8L+JBKvR6NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmZpAPAvbmrKzqxx8Y9Vhb1yY7SwrEjs0Wn80vnu3OGsZ//DzF6ueenSwoaOfbDsp17XYGs+W38WwUGjV/Gq2Vlaz/hijCX6lwHi7Nj5rqC9B7xIrpNw4JDgf7tzqdZSLofR3tnAYT3ZFMfPOkYoj8h+OsupaLKfOhCy2JPl9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=el2bMVTj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721714570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xY4Nr0ZV/G5xCs74taELZsVvfH8f1KeA8L+JBKvR6NY=;
	b=el2bMVTjB0AWHkcYI1a6p3KmYFaiUx+90JBctd9zXEebFb/BGlIgQqJfa34h/5jfsZianH
	8GKxpTF5BVnk0tTjXYFm/nP5tKKPCUc5txWf2Yt/ge6EZukywlB+D5C/DryyoALFDne22b
	EuwdCVIcqmICDA80bpNHBFR5WORmcVo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-RjuXIzZ8NeeyqLKtgctEqQ-1; Tue, 23 Jul 2024 02:02:47 -0400
X-MC-Unique: RjuXIzZ8NeeyqLKtgctEqQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb6f2b965dso5825556a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714566; x=1722319366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY4Nr0ZV/G5xCs74taELZsVvfH8f1KeA8L+JBKvR6NY=;
        b=GJq6ssB6YpfJ1OUlT5vWA3eer8ZWkQYV2msgbkfNKujn7YEtL2/m9XkqByrq0O90Vk
         kISftA2nMEPTTTplwx7AFoDdFbbNPU9QiUjBBGRCPaepMXcP9vFPZe677TcYACpyozfe
         BOsL9dKWeOdokeDcOAhbO5E1AnkquNWSh+vuWXmsjOpygZVegNrpPhZQGDrLzbHos+jw
         XnhuafTWuiVaYmJyJs59tt233V8h4Z4IdeydWglSudZmFyAmhgMoSV0REtSfdUNUP6mO
         /XYm0FC7NFrlxbS9ZjqLhFPx5N5JFRxFVk2yQRPil6txeEEFpU2bv3FQwbDiXBH4iQ5s
         cpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFpLVrQRIA5UjSdw8ULZfiJOatRovaOmByy4tXO6wJcLYdwvY1paiZH7CNnK3PoMybaiEZnVDF6hkJtoEm+AKuH2L2aXDmoLyJb4OM
X-Gm-Message-State: AOJu0YyvHJwa6+G4GVItHq694pzhLoa8uVyvGfmdySvranc3g0w1VbDm
	kLr00vICfEgPKP0riZ2gvlBaTMMttOnzZzYEBTKJSbWyeXX+tbaijfevAnwb+mSmZ9KEj9uMVdH
	27R3VF9LLSEuB/9ZBKTuTBcD+N63qmuVwmsCNucLd5/Fpuju06CJi3WMKrN3NDVyEn4gFmB2ZY0
	S4SmyfMK8w1icNkP0fW/RZOFLbmoevk1NjSPY2
X-Received: by 2002:a17:90a:784d:b0:2c8:6308:ad78 with SMTP id 98e67ed59e1d1-2cd274ade5emr7793411a91.34.1721714566596;
        Mon, 22 Jul 2024 23:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdUHj4K5SDJj0vjuTuGZn7pj0Rf4szKIkdJfWXa0Y2D9tnc4NJZo92YMqIKXjSmlcTOB369VIJKPiI+kROhlA=
X-Received: by 2002:a17:90a:784d:b0:2c8:6308:ad78 with SMTP id
 98e67ed59e1d1-2cd274ade5emr7793385a91.34.1721714566181; Mon, 22 Jul 2024
 23:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-4-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 14:02:33 +0800
Message-ID: <CACGkMEshJ+nKvoiY+P0Xg_A09D_jsEU690y08TY7jkpMLoWeyg@mail.gmail.com>
Subject: Re: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
>
> Tested in ConnectX-6 Dx device
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


