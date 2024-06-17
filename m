Return-Path: <linux-kernel+bounces-216601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A494C90A1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B82812C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4362917F4E4;
	Mon, 17 Jun 2024 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/QIDRBN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B117DE36
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588914; cv=none; b=sK1EWE9/WoD2RuBCYa/z7wsKULDUNZ3FU57IoiV5f+/J+ZOraXldmBLVpcKRrcjnXKa+5ijWtyj76FONZFbiyEXDywAg3LdQ3o2GvdYHmfeea3OyxXOiOXrju0VlWbt0BxRfQrgRlzHbLcv/we8yQMV4w0WDsOuU27h9Fbb/3eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588914; c=relaxed/simple;
	bh=qwH5sb3vw4u2639u+bU4F9qqkIWaZ2UhByObXQ3U8j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhYw5oykwxIQrCAt3nVzDyzsjTZGhqQetNgDja5C0ALNYBtwAoJteItbYqixFs9yADAcdQusuDTB34hoX/1Xj8dJgjouFVwPjz2Ypy8+B1P6f/f/J0YEnAK4mEVNsg9Kcgr5NL0TxhJ9XEfNOSzQ+Ufh/xlB6dGGNRhkLLAP4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/QIDRBN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718588911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwH5sb3vw4u2639u+bU4F9qqkIWaZ2UhByObXQ3U8j0=;
	b=V/QIDRBNsLx6I2WAzihOU+nyOUvWEbtteLLK8oSJMXop9jM7XI2oB6ehPApZgjtScOkPLp
	Z76YUhF7JrR+yxkyUPmnXJAR1NLl8V17nywr2RInsj5SxP66ZvHZK5cy7hwDfyQc6lJqoK
	c2Sm4kK/9Af5kRafQ2/9H2XuRpFhHQs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-18qsEl5pMpW-c_bBBahu-Q-1; Sun, 16 Jun 2024 21:48:30 -0400
X-MC-Unique: 18qsEl5pMpW-c_bBBahu-Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c2dfbc48easo4185885a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718588909; x=1719193709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwH5sb3vw4u2639u+bU4F9qqkIWaZ2UhByObXQ3U8j0=;
        b=Vn/hNt0ed7MWbF8qXOyhYCKzbrxEMitvA3p5d/lb34ngzU2t7/SBp9gFnFEr6T27ga
         Co+pm0c5haynQ0lSK5Sh9SkKnZTDAeDKk8lamJQ58eWZVtWJ4kaAQyJD1MY6eCVG9rfl
         Tht/9Fj+FDOeRnuFK9jPaMhsDb3wcen/QYnKVvTy+kjgflEkBTc9BSARHluBqGMj31Jg
         3W/gpa3AKJE85Adf7EO2HE9yrtD0CWJzQ7LgEcepBbv8IFXH2QhkbKDJvJWbjgebm6a+
         sjqFeEImLSXDrDvuegVgriwyfzHlGO7Ozxz1Xqz2Y7C9vO8Ec0z4a61NZ7PWNedau2gs
         snfA==
X-Forwarded-Encrypted: i=1; AJvYcCWLcypJ71hvl1XHDii6Avuihwbrb7iLOpdgQhArPZfvG842dUM2XoNbDmnHXntOyNoxsAjDVSU59ybbIpvsiA4TjPHOSi4K+UI04mAu
X-Gm-Message-State: AOJu0Yw0QMpybCWMtdGrjqjo66DaV2AFbE8l/7iwbe7SYe+gh9P8hal3
	fmrkHaUFs4BYrbL/CXquM2Jt45YnWcXej0d8Q2/A0fmAUgWM38CSwImRYAwnH5pFfVcLIDnNkQU
	uYDRGfpn8izbPliamLXGtcP29CxcUCGy4w4aW7zrgfqrcEI4VAL+Q6UFPV1fzSJUZOibNSStL2w
	qOencxVdZJxUfumvB5Wp5Xw7oYGBGpM5RvLjR6
X-Received: by 2002:a17:90b:803:b0:2c4:fc64:6b81 with SMTP id 98e67ed59e1d1-2c4fc646c13mr5027232a91.31.1718588909237;
        Sun, 16 Jun 2024 18:48:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj+RTz1EYy7hweDAE1ICq45L/lGIK63DQpX9VOBUb8HY2SxFjoa3c8mAZlpi5oGyIBYrcUXdO1Y9miqAIgA9g=
X-Received: by 2002:a17:90b:803:b0:2c4:fc64:6b81 with SMTP id
 98e67ed59e1d1-2c4fc646c13mr5027209a91.31.1718588908759; Sun, 16 Jun 2024
 18:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611053239.516996-1-lulu@redhat.com> <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
In-Reply-To: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:48:17 +0800
Message-ID: <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:30=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> Add new UAPI to support the mac address from vdpa tool
> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> MAC address from the vdpa tool and then set it to the device.
> >>
> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> >Why don't you use devlink?
>
> Fair question. Why does vdpa-specific uapi even exist? To have
> driver-specific uapi Does not make any sense to me :/

It came with devlink first actually, but switched to a dedicated uAPI.

Parav(cced) may explain more here.

Thanks
>


