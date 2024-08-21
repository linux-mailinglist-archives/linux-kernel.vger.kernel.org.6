Return-Path: <linux-kernel+bounces-295560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74C959E51
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A32824DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F32199FA3;
	Wed, 21 Aug 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DY9JGeAz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D0199934
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246018; cv=none; b=OHQjWoRw5+f4gW+rsVWKAZ46kkdjYuZbOllMfidVw/WZKfCOdayYWDvIKX5bxtwepd6ExAxzcykHzVYzC7Bu+H7cRHBmxj9VZ3TB1oqJ6dJJhlaqaNxoFzsN0FF5s9Gji3VOLpHNTL0TIZ5wj4OAMNOGxUIaS60nMAxbJhV5FNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246018; c=relaxed/simple;
	bh=VxdnQRQ9RoJiHroH7aL12ZENbeWU8OgMK4PjHewMYIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8k0m+QAnX6Oyx9iwyZ9oZB+6+8gJVQanVrmEgwzrPIlxn9DZ0UoNM4W6UzRioQ7XXX4J8EaHwYuJBRp6q822v7SeevyQCwjfuv0wqZyRv0znjPU70x/Zz+G5hDZSXQ/Gl+0Q2F6TY79UmZlt/9dSi4l7zsjTjPeJPxUk5P2LyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DY9JGeAz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724246016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxdnQRQ9RoJiHroH7aL12ZENbeWU8OgMK4PjHewMYIM=;
	b=DY9JGeAz9K87/d9DgzpkrWDycbq5Tn3K1G+LlQTmYiW0/xgOmirOYkM2lyq1fFRjLvo0Qt
	ZpDIDiDlznwaeuS0FkbalVBVu9edYXl0uL+cD9GCcdDzsIf2bJyrBaLQ5f3UUNqfVyqFVZ
	GsBzvMO/3zzRCLkjgzYQnAZXdYtlmx8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-pNaEmIPYMaG_qz3CyOjJTA-1; Wed, 21 Aug 2024 09:13:34 -0400
X-MC-Unique: pNaEmIPYMaG_qz3CyOjJTA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3f4dcbee9so7962471fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246013; x=1724850813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxdnQRQ9RoJiHroH7aL12ZENbeWU8OgMK4PjHewMYIM=;
        b=lxjI0u1Bhy57P3o4WaujnyKUyDau8O2AM4HaiXB9l2r+de8WMWsiObVZhRJbqislE6
         QnU17vMqIairQTOsUBWxIdfG8TYUtZSqDdCFst+CI4cQjGtzEddvO5hCXYDuYTLSw3yQ
         C/zusfX4+TtSl/qMUWShR3Cg3or1rmUbVCONcIWZNQEp7o02CUwK9Wzel7r9QzstfXdk
         vANfmvV9Xwpjj5p1WjPCAbgqe2MQR+eOrs7GmdRlpoZiXyoBNAoM/QLJ+njVenraGVhN
         BFtMzMKn99NDObxa91eb7cQCU+M8sZPr5SUWoJYIxCTZWSXP1n4XAXhQ3ENC5q7XkzTv
         ud2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNTdIXNDdDgxKIN7HyzpF+mu1nn3FVjFboPuNcJLUdWx95h6KL0FPbLpGVBn91gGjBACjAreXQt8s7cQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vJtnSW/J91DRe8028UqBGAUfCUAJtpt6L9wWfnNEUGXpmdr/
	xQvwTafOMsW3UvLd3tszdInKhyKg2dckyczO2XJquYCMj36avRIN3p0T2hx57xSNLJiYi/aUgQ9
	6YZCMsOu0x8zI/lcVh6PCZXo1GgfRz5p44G/fFPEcB5DggxYVjEAJJyZ1EYYl2s2gwE/YDJmoUE
	Nddf4yhE5a5mI01zLeBsgwJ9AJQxk+0e3sJ62X
X-Received: by 2002:a2e:e09:0:b0:2ee:88d8:e807 with SMTP id 38308e7fff4ca-2f3f88a6e99mr13197291fa.16.1724246013013;
        Wed, 21 Aug 2024 06:13:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbXz/zZNLpgYy914DPQE0G3jUIMMtBg2FW5l+r7EiJf3/VyOVgUXkDaaMO4gGanew6Bd0Rh41sjKlfIR/KxZc=
X-Received: by 2002:a2e:e09:0:b0:2ee:88d8:e807 with SMTP id
 38308e7fff4ca-2f3f88a6e99mr13196981fa.16.1724246012310; Wed, 21 Aug 2024
 06:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819183742.2263895-1-aahringo@redhat.com> <20240819183742.2263895-12-aahringo@redhat.com>
 <20240819151227.4d7f9e99@kernel.org>
In-Reply-To: <20240819151227.4d7f9e99@kernel.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 21 Aug 2024 09:13:21 -0400
Message-ID: <CAK-6q+hx8MNeZCc0T-sTPdMgXH=ZcpLVqc2-5+psMCoQ_W0FxA@mail.gmail.com>
Subject: Re: [PATCH dlm/next 11/12] dlm: add nldlm net-namespace aware UAPI
To: Jakub Kicinski <kuba@kernel.org>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, song@kernel.org, 
	yukuai3@huawei.com, agruenba@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	netdev@vger.kernel.org, vvidic@valentin-vidic.from.hr, heming.zhao@suse.com, 
	lucien.xin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakob,

On Mon, Aug 19, 2024 at 6:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 19 Aug 2024 14:37:41 -0400 Alexander Aring wrote:
> > Recent patches introduced support to separate DLM lockspaces on a per
> > net-namespace basis. Currently the file based configfs mechanism is use=
d
> > to configure parts of DLM. Due the lack of namespace awareness (and it'=
s
> > probably complicated to add support for this) in configfs we introduce =
a
> > socket based UAPI using "netlink". As the DLM subsystem offers now a
> > config layer it can simultaneously being used with configfs, just that
> > nldlm is net-namespace aware.
> >
> > Most of the current configfs functionality that is necessary to
> > configure DLM is being adapted for now. The nldlm netlink interface
> > offers also a multicast group for lockspace events NLDLM_MCGRP_EVENT.
> > This event group can be used as alternative to the already existing ude=
v
> > event behaviour just it only contains DLM related subsystem events.
> >
> > Attributes e.g. nodeid, port, IP addresses are expected from the user
> > space to fill those numbers as they appear on the wire. In case of DLM
> > fields it is using little endian byte order.
> >
> > The dumps are being designed to scale in future with high numbers of
> > members in a lockspace. E.g. dump members require an unique lockspace
> > identifier (currently only the name) and nldlm is using a netlink dump
> > behaviour to be prepared if all entries may not fit into one netlink
> > message.
>
> Did you consider using the YAML spec stuff to code gen the policies
> and make user space easier?
>

I will try to take a look into that and prepare a spec for PATCHv2. I
saw that there is a documentation about it at [0].

I did a kind of "prototype" libnldlm [1] to have easy access to the
netlink api but if there are more common ways to generate code to
easily access it, I am happy to give it a try.

Thanks.

- Alex

[0] https://docs.kernel.org/userspace-api/netlink/specs.html
[1] https://gitlab.com/netcoder/nldlm/


