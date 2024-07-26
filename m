Return-Path: <linux-kernel+bounces-263333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7193D46C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF9B1F25848
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A124D17C7A6;
	Fri, 26 Jul 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXn4RuL8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE61E4A4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001426; cv=none; b=twErPhr25rLQN7XCZJ1/m6aJmrFreAOS+O0TuBt8aDFrIbBbO19C7L5DoFWXlULIpcrWYO1bfRtEAEWQx+yLIfrPHz9uhYURW4EvbVst2iW++vGVpcvZZuZZYfdyTKXXc0p2s6ZdrvU9bfG/KR20aOLVi3ZH52FeE6WVBacsA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001426; c=relaxed/simple;
	bh=KAnhfb9PFIxJ4vH9zPK0dYM3U9/R6vZ926luCNslwv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0e7O5jT40oJf7p3xFN0fJFA5x7nVqci5vdDvHB0WTB84js2+ysAPkP/gz19MjRzhUR2BpuVKkVNqP0MD/ZZJreeFmZcc4iVy3NM8sY4kqV/9Osgnsa7RnroKzolu0bf+Q1R8/502sX+x3fGz1aJkrkM2OrUcOkRgs+4iUrKJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXn4RuL8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722001423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juNuYlyz4PhrIkvVaYyPMDb9Hy1qrKJjotj4l0qAgxk=;
	b=XXn4RuL8PxtGsGfCJR/hki6AIxvjgujCT5tLyFu+MoBlQdV1IohHdNYKbxbyb5k1MnVar/
	lXNzEsFpMJhD4g7hj3UGzvK7Q+23WkdzV+o4nPNGx9u/QWFYP0nFy9Cr7CH7bcd6OWx1vV
	KXX0FA0k2VdKDay00llKo9fnabSCbVo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-QzNlD-FKPIaUVtEot1x4Ow-1; Fri, 26 Jul 2024 09:43:42 -0400
X-MC-Unique: QzNlD-FKPIaUVtEot1x4Ow-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cd72aa5328so1035393a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722001421; x=1722606221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juNuYlyz4PhrIkvVaYyPMDb9Hy1qrKJjotj4l0qAgxk=;
        b=hpoIooocOMvbhXu+qCUib9ge11vrOWgKgDMhVrqGvAsVyzQVUf6n5ZeSMm+Qll915E
         HZJxFYAPyI5cJA7ZFCJw6qAh119kY6ROnS9TrygzM+KNhKTVnoaehQ9/CSDGgGNfBH2a
         mWOjTH0Hp8JPw2WJB+sZqRAjrpTI/I2DZykPq986izk+UmZ9b210RCaRS2Onn6iUwiB9
         Zx8//NR1xb09Fvfnz1a4uSZvXzr1OkB8FEgeotohwBhVaoEMT7DcX6PaHuFwYH63kSPC
         HhI62/mR9DUPlRFfcuw3pHGpwtDnA1d0h/u1TUC3iBsdDfY14xFWu5GtHMlDdu8SQ1uT
         wqBA==
X-Forwarded-Encrypted: i=1; AJvYcCW8GiQTyIHiI3u7Tprc85/Rcj7ICPNV+vJBg7TjlegcP2pNfY6wvAW0p0GutI3x99Ga4jhdH2ehGSEjGZn56uTGJVspiGWEt0A1BbbM
X-Gm-Message-State: AOJu0YyDLgemUhmhiAn5DmnJxDtutw22olH9WzmANwNpSPEe+jD1m8Dr
	jDD7J3c53wl6+GzQp41e3+3Xpb4H226ki6oHhqz1hrIKSCIcJbMvdDugWHB2/H6jN12Xntllptz
	z+qIW1qh66gx8fQu59aHExJP7s3I5+UVF63EnBENT6z+NpPYkI60g/AbMK2jC2ubT6n07A0WvBV
	W95ikpiOzbx+DODI+A5ZtBqitnAwv06fOlqTar
X-Received: by 2002:a17:90b:897:b0:2c9:6cf4:8453 with SMTP id 98e67ed59e1d1-2cf238eb4bdmr6520874a91.31.1722001421096;
        Fri, 26 Jul 2024 06:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHdO39nlrbhfiAjnIjdlLGQtuoRRW91HYiCfm8yhXVNZ/gNueBn2lqUJPAH84e5PpmuO2Q0iUqpiul6WbKRvE=
X-Received: by 2002:a17:90b:897:b0:2c9:6cf4:8453 with SMTP id
 98e67ed59e1d1-2cf238eb4bdmr6520847a91.31.1722001420691; Fri, 26 Jul 2024
 06:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702095401.16278-1-gongruiqi1@huawei.com> <9473d6eb-3f56-4c73-8e61-69111837c07b@huawei.com>
 <CAHC9VhR+tk4mwmaQ6u8SEnzg6zMF2krFHKVwxKx91GX1K=4A=g@mail.gmail.com> <0729db54-98cf-4006-91d0-0ebda4dbc251@huawei.com>
In-Reply-To: <0729db54-98cf-4006-91d0-0ebda4dbc251@huawei.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 26 Jul 2024 15:43:29 +0200
Message-ID: <CAFqZXNsN9M__Mo018L8m0txi60vm3Ui5HgHvJYQK__0hhhMULQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
To: Gong Ruiqi <gongruiqi1@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wang Weiyang <wangweiyang2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 2:34=E2=80=AFPM Gong Ruiqi <gongruiqi1@huawei.com> =
wrote:
>
>
> On 2024/07/18 0:17, Paul Moore wrote:
> > On Tue, Jul 16, 2024 at 10:19=E2=80=AFPM Gong Ruiqi <gongruiqi1@huawei.=
com> wrote:
> >>
> >> Ping.
> >
> > Dropping the LSM mailing list to cut down on the noise as it isn't a
> > relevant mailing list.
> >
> > Ondrej currently maintains the selinux-testsuite project so I'd prefer
> > to give him time to review/test/etc. the patch, but I see it has
> > already been a couple of weeks without response.  If Ondrej doesn't
> > get to this patch by the end of the Linux v6.11 merge window I'll take
> > a look then.
>
> Thanks for your help!
>
> >
> > Where (what distribution, version, etc.) did you see this problem?
>
> The problem occurred when I ran the testsuite on Fedora 40 with v6.6
> kernel, and it was the only failed testcase.

Sorry for the delay... For some reason the test passes for me even
with cgroup v2 only and without the patch (also when run from a
regular user account with sudo). Do you happen to know what
circumstances are needed for it to fail when the cgroup is not
switched?

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


