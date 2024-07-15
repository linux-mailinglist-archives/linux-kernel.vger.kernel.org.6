Return-Path: <linux-kernel+bounces-251989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1D930CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B28D1F212C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B94D613D;
	Mon, 15 Jul 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkCaHly+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07D2CAB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721010721; cv=none; b=pBz3z6GM7Skklkl+cZXKdUMcrwslVLZUxWWJ3zhBaivolA9sTDxCjdfyvwFFEM/ynX2KU8D/3ONvvBbdpVsWEb6mQnlWU0HYk/8FRUzzdJ2xYkFhYSCNoR3Oqr5wEb2R2qU0vGpaa885DP6YRFWQ1DMHDxEOEKTgVQVYBrYDhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721010721; c=relaxed/simple;
	bh=jnOm0UWKGCVA2ZOxXTFxnrXlHHcrHT2itOGyOeQT8XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1nlfjKGm3vmlq/RVQToLFcq+Yo4BFsPDW1tuwlDkXPDnV12eiovNV96NzFq4wi1c5roVE+fMeeS3+cR/5jel8psaIaYaCaIQWXYg+A0piQGttJKmngyPYqzHjWBFNqA109h6EhHXFH3ZM81H1VuDs30MCDTOdkz2dPQhGtFZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkCaHly+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721010718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnOm0UWKGCVA2ZOxXTFxnrXlHHcrHT2itOGyOeQT8XQ=;
	b=YkCaHly+6FcZlCvqAKqOlfoFIZFBOX6tv4gVNM+hIh+Z4aAbEsPTk6yOb/A3tFE4ubdAUm
	GFyVTD7LtQ9pDeB7hDT0Y/Idjuq7fVV8nA0P3o7DrBqT9qX2iTW8UtOlcF1cNkM82XI5fD
	zr/zbbn842/sokGeG5IROev9s3oPdV0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-VddNJHwnNuO_c18n1hemAg-1; Sun, 14 Jul 2024 22:31:57 -0400
X-MC-Unique: VddNJHwnNuO_c18n1hemAg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c95f737113so4185064a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 19:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721010716; x=1721615516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnOm0UWKGCVA2ZOxXTFxnrXlHHcrHT2itOGyOeQT8XQ=;
        b=sJ8Nqq36dT7JLhw5zIL+sRZq/sobfDOjbZlwGrrl3csE7bgsh9OHovFdknCrdmqnty
         IAlzr6hhzAD1YyiT90QxHBYnU3o67oo0UQmzf9WR35iu9ET4fiFx064JhTAHsrVT8eDW
         DTj/R/7wwWoheJa5tYB42jpEhFp2sXJbo4zO784HVGBVtrWmi51hhZ3VAlOouzlF9nS6
         CwMOTkgrOoIKoQI58sN5v9CqYfFqyo1ar8G8cJ1maZDTbFrGt3LNbz9bRoU8Dt20aINx
         oQQt0MIhCD4rVkXz6bVeGTMiFfEmR50xpI717TjnlARKPf+CeRgIR7D06viZgARZj6L/
         Jx6A==
X-Forwarded-Encrypted: i=1; AJvYcCXY5HLOlKUC1jQfr0usXHNZNzFp5nM+mKaPzHGZC0+rdHZ+YBpj91Npw/6D4HHf7ZmaOXIVRCPg8iVv83MVR+TqK3H/WPlT0ko4P6qE
X-Gm-Message-State: AOJu0YxMEdDqiwwcydTJa32pu0OTxKdGN60SNBAWfiURnsWFILkP4ZqA
	HrIvMr8bnswPkovJ0RZMs7RHdX8lgLCK8ESs3oUWepPLtif+cwou1z7SyNta/9ZQlUOzbmwjqil
	ZM0d6XTxKaQKC3CJvxOdsMBw/s1uUFRqW7nUl3FQpGyBC+p1JNTdn4U9t0My0p2IDhBLnq/FVXR
	Uc/K6qFUU+Ml0biq+IBHeGDPofDLpF5YiDlE18
X-Received: by 2002:a17:90a:d796:b0:2c9:75fe:d18c with SMTP id 98e67ed59e1d1-2ca35d86f43mr13938055a91.46.1721010716672;
        Sun, 14 Jul 2024 19:31:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL/z8uwuzjQl7CgsPLS13e/2gJz2vcQIvI3U6hogJmhxKgUDG7AL9z1TKJA+tQ5UBM5/OMww+Ori1wyw9Q0W8=
X-Received: by 2002:a17:90a:d796:b0:2c9:75fe:d18c with SMTP id
 98e67ed59e1d1-2ca35d86f43mr13938047a91.46.1721010716313; Sun, 14 Jul 2024
 19:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com> <1720790333-456232-5-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1720790333-456232-5-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 10:31:45 +0800
Message-ID: <CACGkMEucbri21SeE0q848O--yMVCtuT9ZMKUYgd6hLEqLGN7Tg@mail.gmail.com>
Subject: Re: [PATCH V2 4/7] vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Add the VHOST_BACKEND_F_NEW_OWNER backend capability, which indicates tha=
t
> VHOST_NEW_OWNER is supported.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Doesn't harm but should this be part of the previous patch?

Thanks


