Return-Path: <linux-kernel+bounces-404965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ACA9C4B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903D51F22086
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC5D1F7559;
	Tue, 12 Nov 2024 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zm6djZlt"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DBA1F7082
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372233; cv=none; b=TUTWmBkst/7XXYb8H5CO+z6FAIwI/mchC+OqBMnFLQeMUGy7vsHXFXlV3mMYI/341tbLd7RvKiNLcrl46WFReTHTCNB3OSEY5A4sPSPV9CKI2RY45K0uTw9xusJ54aXKaA18BtxWGkDtY3Td+BvmcWl6LskwHUT7Z3JOdh+qm+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372233; c=relaxed/simple;
	bh=WkSU/tBNIYUKs60i2GiUngYBWA4z9oqkXCRpiVg+3go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CHXuArjB6JNXTZ+upJjhIJgZnEDxxJuqk9zVnb94mXh2FutLuAeC9jFSrYPUP/FAT0PcrIz4s0R7BH00DzBh5lUITbVUrqdJQNAMz8N9I87dLoRsu3KkgAU63tuqsT0QaeTgP5xMlMF1m0qFIHDYiAKY7SgWZeVkicHTg7Dew9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zm6djZlt; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460969c49f2so116461cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731372230; x=1731977030; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkSU/tBNIYUKs60i2GiUngYBWA4z9oqkXCRpiVg+3go=;
        b=Zm6djZltdbqdZQm/hD2VapHIJlHMNMMHPIL9i6/9Cm0Dav1gNMqXBwCNO4twa+ONf5
         jfDCqorbXGy7cGH8HGGuzCYnokrJXmmkSWQmR6yCiwdmfq1DGgo2k2XxOGcpawNFjE7m
         lC/QlcgKDL6+nt3ypnFZIw6t96OOjAFnAm02OCuoTpt9Pq1Z+ofwQLnt3hkKgZ8W2ATy
         jx+ZSvz7Hzc5JcKb5zSQSNluzj281RSPrUN21JNT0fNzDZZAD0TXzCRFGV+yHzUEjOB/
         bKjBiDCdcmH4/mlWbuYeWq6rSS9eG47Ds8913FHksSkTgclfPirnfpzXGsg9b6gIKJLd
         uEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731372230; x=1731977030;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkSU/tBNIYUKs60i2GiUngYBWA4z9oqkXCRpiVg+3go=;
        b=gUnzaO57dfnigkeW4DMTOfUUAMcNaUfUIKfqarsZeMgL89T109xhhpxZQ53ScsLq9H
         NHlpyv7IFrp6Y1t5sFpB/7RjseRucIxCX3/QbmbN2WqGk2mDwQ26Xl0juy2nsr0oJk3I
         1y3CwUiShVryTiWhTSFXygXXzvpFEbiIFo62L7U80AchLin9TtVtJjvdb2T86WkdKkgT
         x0VZvvDSO8EyeJIJtihf3WhR3bxibs57rdQjH1i0rQg685015a0JxMi3U99XcTzxXCbY
         TuR59sV4z+X4cuIeGwaXI///PAUO3vUBH0Sjw/yw0m1zkmkVbGMl8cI7TKONEbe0biWd
         ZEHA==
X-Forwarded-Encrypted: i=1; AJvYcCWhTmA2joWODa2b7a39NFdLIm/H6tiip+LgSehF1nHNrvjhxigN3reiOKujAKArXS54/mB3+NwUVNZ0tBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzydBJGx9BNS++LtlLBgPd+z7E2SQJo6rmiZ7qa7daEoBhOy+Dg
	vTb5QaTJvEVpNgx2/HWac7PstrmY7mVCOviKhCPnLakcyrsuaD7Ewn+N5aua7L4Es1FFF5IZY+0
	1NmNLTH2nof2LuebmsBCgOIcHy4n5arb9SPT3
X-Gm-Gg: ASbGncvDCaBguVJRi2gPssn8LvnOzM63ZPCLQzTJTaofvbmhkvX6oAPEgjFHkr8UXuq
	hN6cuxCQtuvLxK3AdAw2R0/COCWVqP6w=
X-Google-Smtp-Source: AGHT+IHlQdP7Az+GyVoqGQbcSMMswO2ZCHKXkTC0ByyHbf301TOfVlxGoievwlop3O5jjBXcmQ5V/kzomaPd3dtoMgc=
X-Received: by 2002:a05:622a:95:b0:461:6e0a:6a27 with SMTP id
 d75a77b69052e-4633f0ceaadmr1524551cf.20.1731372230031; Mon, 11 Nov 2024
 16:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111221839.w4rqqlvvkm42jdgm@offworld>
 <CAJuCfpGw1Nnh3nonDHv-UAeqTB=-3z1+hJk9Opy4X-6mbvdEhw@mail.gmail.com> <20241112000334.ppzn3fap5glivpxl@offworld>
In-Reply-To: <20241112000334.ppzn3fap5glivpxl@offworld>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Nov 2024 16:43:39 -0800
Message-ID: <CAJuCfpFGmxUUL2Wk5qdOsDzC1mX1t2wgbLwi7-giryR18c1CTg@mail.gmail.com>
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:03=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> On Mon, 11 Nov 2024, Suren Baghdasaryan wrote:
>
> >I'm not really trying to claim performance gains here. I just want to
> >make sure there are no regressions.
>
> You might also fine tune the atomics with acquire/release standard lockin=
g
> semantics, you will probably see better numbers in Android than what you
> currently have in patch 3 with full barriers - and not particularly risky
> as callers expect that behaviour already.

Ack. Will try that. Thanks!

>
> Thanks,
> Davidlohr

