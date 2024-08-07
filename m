Return-Path: <linux-kernel+bounces-278589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2E194B23B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D94928131B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E439153573;
	Wed,  7 Aug 2024 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mcRL2ecq"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F521487C5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066490; cv=none; b=TquZqckRpemT/EYZOXOOqIUqvW81DdVbWe2CuedNAfwqy31rjc72EXlJ9j03liLrdAufqLS2p8x42SUHSICsa00P4x21nSBk7G/kxznbFMRYHgc04svzrUatOlky/1wS7Q9v7GjXIL01uuFC/uF77bSZyNO34ahYIWPmVYBiUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066490; c=relaxed/simple;
	bh=IfTmzCgemNzO1EeqL3QXq0dVMqNRi+5qQivEFOVJ1VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BF+2XLdJSFHyzzW94Dx/VIKa6BhAk2LyJsEzqLuAhDJ7vvFm0/rov5fD5mYiT9yhj83xf9QH64oChLcCpwIjZZEnJH4mxbnAywrMFb/UtWddr01OwIh6U1p9XH1RuUXNSho48X9tB+CLC/QeIueV9aUHvIZskFr6JpmyX5earFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mcRL2ecq; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-260f057aa9bso227523fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723066488; x=1723671288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfTmzCgemNzO1EeqL3QXq0dVMqNRi+5qQivEFOVJ1VA=;
        b=mcRL2ecq0/dMdPe3hEsVX7V6M5CgVFjU8cSQNOg8q0N4Ha/5rLaIFr3dw42g0QRa0N
         RTBhG6681NRFKpeF32jzoo+qiEUi7CWCGwCkTwIoo+/xbVM2/OZFd4WRYqozPWHwr+S2
         Oao5Zu03Z3fHHaJXM28134rS3lrayL8It7k1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066488; x=1723671288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfTmzCgemNzO1EeqL3QXq0dVMqNRi+5qQivEFOVJ1VA=;
        b=YazCEQOaMsOhoAsjNutAFoR/ARukJ20jaaCmj0/APVkxD7kJSRSsWhIhzgBm++qJLz
         9O+JFgLvbVQTu0oHKgaJSD0b47XFl9N9PRdxmWWtrOxhvG4sctAkL09JMYy7NsvYP124
         RCwCQ4sbdLILpTYjI7RSVBiBgdN/QlTWEXxwlavLnOpiTi/dRO8TDPnZmQxswchf/QPP
         rUL2akTp6H+H5vzkf9vAg68NBg3fnGS19HP96Qbwxt9JD7aRuscEDGaK4UwGSFhMWFnH
         PbzcTx6zJo2xBIXC0L9NGQ30sm7ofA6GB1SEoOzDpOBGVe41E6yqeRrUB5Aqm0txulLH
         aPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3XIrLuu8tjtBSOb66WEEbPVwGXJvAujOur6SWenAJwiejwlOV49gMRYCk5IgW09L85LseDdUELFft5aa6yZeuBRYAUuSm3XtAU3xW
X-Gm-Message-State: AOJu0YztkDdx+FOQsNzkZKvI4Dcy9swAleQUPrvbMm+GkVvcPCLwW5WZ
	AycOoq8y3AKNkDHbVjqwQSrFOdYTUbBz3YbVS5hjzt9tU9Pu+S8AAFGOaNFR8sGt7EjnuQGPtzt
	noh7c5R7YB1DSFY6YaCpEwvSvw5c6v50bpT9a
X-Google-Smtp-Source: AGHT+IG5ES7X4tgKDJv9g84tk9ALZ7Sp67s0jLTzG1Iz9nJGWu6UaYHks+HxXA4YIPNwg8kjSy39pOHEV1+hFz8rf/M=
X-Received: by 2002:a05:6870:3051:b0:25e:b732:a913 with SMTP id
 586e51a60fabf-2689175a388mr24548521fac.0.1723066488042; Wed, 07 Aug 2024
 14:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153544.2754247-1-jeffxu@chromium.org> <CAKbZUD2xDdbxOTvR3-P=636jvhG_JPO3h79tgB59dfPmv046hg@mail.gmail.com>
 <CALmYWFvDH=8U8wsaSjMrfCg1__S66SS-9Zo0f826XJDJT7hOSQ@mail.gmail.com> <CAKbZUD0JuEwfd2VnY_Kbv2Mr0g0KN2T2mYCLhPuS8j6PhbCNiQ@mail.gmail.com>
In-Reply-To: <CAKbZUD0JuEwfd2VnY_Kbv2Mr0g0KN2T2mYCLhPuS8j6PhbCNiQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 7 Aug 2024 14:34:36 -0700
Message-ID: <CABi2SkVX7nFwPDAQaYWn2Y33OnJRs8NJQv0oW-QJUcSYB8a6tQ@mail.gmail.com>
Subject: Re: [PATCH v1] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:20=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 7:03=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote:
> > Do you have any suggestions here ? I can think of two options to choose=
 from:
> >
> > 1> use 0xd0000000
> > 2> allocate a memory then free it, reuse the ptr.
>
> Personally I'd prefer 2, if you really want to keep the test. It's
> also a strategy used elsewhere (e.g mremap_dontunmap.c).
>
V2 is sent with 2.
Thanks for reporting this.

-Jeff

