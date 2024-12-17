Return-Path: <linux-kernel+bounces-448468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B063F9F407C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACC3161B09
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB043A1BA;
	Tue, 17 Dec 2024 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4HIfMWg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C1F9FE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402000; cv=none; b=BD8DPbbfP0zV//GkcLgmGj3rqEWa4feAAOzSD9jMyK1E5VVhSHjFFbUTMv4Y+uBtXAll3RsGJ4TL3h7slJY7PB77V+wVXuh7fH3FDsuGEMET1hBACEJ5C+wT3PAYKFghukufERgaUpwaCycIwp8R2rbN/Ak668+XtJLQoDBK4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402000; c=relaxed/simple;
	bh=5Ae9GrmZ1Zm5dg5PngnXgnGcYRGb2sPlzBmUBy75Xoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qM0dSU3ptbbIf1J5AqXWQXNbl/H7KC67aa09kPFz6JFDDCjNxyHFcqn3ucgsNxTNo18s2A3H6ePxn4Jgi/2FBjkXXakiRbigHsLNgpPxV4Wb5UqBZ57NYb0DfyJYvERmEqCuULJHCKXAUr1FXUqWg5wpV/oKMU8/sPZvNMKGuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4HIfMWg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734401997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ae9GrmZ1Zm5dg5PngnXgnGcYRGb2sPlzBmUBy75Xoc=;
	b=c4HIfMWgAHoo1nC6OhZwUViJNHsupXwUR5MFJIDHBwgRD/nrp5BQIBTrkqvLuDtOndqJii
	qc/qI+o/G7mwVt19xCxb4ovr8X2GQC44fZ+o1YU1Yndbnud7kwyQb5shwm6CQJSJAzgE05
	+7xiTtaMIYcmQ9imEMCmaeXhQ5e62no=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-bQK21G6FOfabd-yhIeEceQ-1; Mon, 16 Dec 2024 21:19:56 -0500
X-MC-Unique: bQK21G6FOfabd-yhIeEceQ-1
X-Mimecast-MFC-AGG-ID: bQK21G6FOfabd-yhIeEceQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee5616e986so7119350a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734401995; x=1735006795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ae9GrmZ1Zm5dg5PngnXgnGcYRGb2sPlzBmUBy75Xoc=;
        b=IGWsYqTYmfwoAnasBlzgZXb6UBjse5nXr+w5+oeJ3VKLCm0OlAfpBe1MOuvoTktN+4
         r3K5yrkBKkz/j+MAi3OUBKxPMcjN4o9qelKxV32qTH3Q9ycw7SjrN7d0aax3pLwPqrDB
         4mEe8UGUNAU2JCjLGM+qL/BivqoBtJJ8nUApfLbMnro2pg/pAArDi+R7AJO7QSoOCeSh
         TMfyx9IFPCBzjy/ST1BAkgEUA49OE5I2086etgtXbx3yYkCheB9g22REQ22TJhHeh+25
         oV0g0IEyQoSE8WzRvg5K1cHtyYswYvWIBqxzRP1Vvs/o4y0ksVgCC4DSw2/5cqGcW2MO
         Uvkg==
X-Forwarded-Encrypted: i=1; AJvYcCVvEqHY0aZWguRrZGSqK+LQhI1/ugmQ6mWged7Afh4Dt6ZyitD4IahDHqhuXQhL1oEtGhXFWU7PTq9RXCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+xKzbpK7OljCxLowuAoyNWuEycG2XDAPRD9Z+C3aNLzfI9tu
	hYCO8UJBN+DB2+xdh4J3EJ0p+0O0l1/WB6rHpTJ+Gx03VhX3Rj3P066QwMTTkYFfVak465HahnC
	v45ldCEc+nHhrqCUuIXg2NA3v8ONPeB+Jhj7Qx6PA0g3v/e1rimrwR/r4yFoOyJTWggY4mgq+lO
	/TUWqFlq/nEnAnyLybXXW6QabVyTlI2O4lMTZG
X-Gm-Gg: ASbGnctpjUT+Ynv8whZ2jHeFimBSvmSuBXgXqRK5S1B+x8oUfG5SAWSnP3Nq6i+v4Rg
	AOIOINRPs16SGsmlJTmRPA4LMLIQU1yfHKmDJBRY=
X-Received: by 2002:a17:90a:dfc8:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-2f28fc67364mr22185527a91.10.1734401995621;
        Mon, 16 Dec 2024 18:19:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKbSp41eH0dkhZ/iSROy/9EyV2a2K0VoSxmiPfeIXLS8zQx4thuhAEpQdj6jpTV2/IQTbIKRHVlKkxyeu6GeU=
X-Received: by 2002:a17:90a:dfc8:b0:2ee:9d49:3ae6 with SMTP id
 98e67ed59e1d1-2f28fc67364mr22185500a91.10.1734401995261; Mon, 16 Dec 2024
 18:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214070835.568818-1-sthotton@marvell.com> <20241214070835.568818-4-sthotton@marvell.com>
In-Reply-To: <20241214070835.568818-4-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Dec 2024 10:19:44 +0800
Message-ID: <CACGkMEvsTy-RJToryuKG+NL9cNGLNuc7EkDYminNx9FWTXCQOw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vdpa/octeon_ep: read vendor-specific PCI capability
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 3:12=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Added support to read the vendor-specific PCI capability to identify the
> type of device being emulated.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


