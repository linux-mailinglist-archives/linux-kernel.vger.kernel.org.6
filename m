Return-Path: <linux-kernel+bounces-424655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DF19DB790
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72ECB1634C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D90E19DF77;
	Thu, 28 Nov 2024 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UR9H+rPB"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37647192D77
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796910; cv=none; b=iKqg8OeC9AHWq1IytrpVNL7lB4XoVsJ5cYZX+snsUWMnUveGcbg9Zh0gqengWWFpipIkBvasycPMxp7wVd/p9K5gOLnuvmBElJWgHPgVmt00YnFDB2YmPPWRqERZRGbrZy8emC27iGAMU39PIz79BFmJ4gnIX2Q26qvdfHUAp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796910; c=relaxed/simple;
	bh=MOT2fR8awT9bMTqFJViZ1GmaBnBHbdhxmtDeJixFVwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srMQFXcp1oRSXabGlNM668T7x3TCth1tyjaT/UbGxPmekCMAnRWGCwimFmMq1DkrEZP8Ve0+ztb9nZiMBnZFPlsZYCWxlp9Isjsoc1mLAGPiAqDjPsmgJVk82F0w0u2lYyVEXHfiKHFQOetJ8S0c5VL5qDjaCs4AsgYiHFl+1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UR9H+rPB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df1e0641fso843144e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732796906; x=1733401706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOT2fR8awT9bMTqFJViZ1GmaBnBHbdhxmtDeJixFVwA=;
        b=UR9H+rPBh6ko11f0iuF0UYGbvVhOnxCUEDXWk6AbUJdZygdVCMzWHMn/cCKFy2vCiv
         P+p6qdsSBN9QQ49bS5mR1ERfrPqSNkCSYFGRY3V9EtK9/07cLo0v4W3FIxgt10SK5H5m
         fctJndO6IuOscqbXJs73egxSYMl0AtribQPg7/+pS23ZNKwhh/b6bo+dv61lnw20AbFQ
         TF2R6IsQ9AFxuf+wNUwdMafcJwC2wSI9+5zgkHQ9mAn2mA0ScKNAeOjiLCdhmVitNijl
         Q0KlwH9VKP9m4WJ4GJoL/RmT9bMiKeVTdbJOg/pMpVzeVxPeGSYwT+UzxhWkZTK32NYU
         Kk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796906; x=1733401706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOT2fR8awT9bMTqFJViZ1GmaBnBHbdhxmtDeJixFVwA=;
        b=A9Udw60NOnkQsLdERNxXWJWIkQ9/6QECXkS6kG4scjvwHHOkkWzn9iVp3QSsA69U5u
         OcxOd6MLIn04ycZylCVTKL580K8Hu/lpEL75LFDhB+GqQhwCTsFf/GxVupVsiyliLt4b
         0DmVJ93qp1UWVCf2JvYAWdW2HaibBjSVAhBXGd+TyfBefhrJgV3yemd/4iUcrLMgcGfI
         QXJQLwv+CXtGxAZvuKYZBWj56eKNaoBMCbrWaw06xHBSl0EVymvbv9HcIvXWfQhgWhoy
         tslX6PbIH6im5NRHScmOe+NZ+XYzdd4hFuSBGq5UVh40rq/UTPwnd08eQ3+HM2af/FSK
         fEHw==
X-Forwarded-Encrypted: i=1; AJvYcCXTf7fgT42oLIEivTR8n7m69959rdfqg5FK1DUzYwLJW25omGtZE4KoBSBDI7NtqcbnZHm617WTJIiiObY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEAnYwtCEgE2Nfe9yp4yG2AFKMNZwn9CFp41x20i//OHrUKjY
	mVb6hdPb9+JzyJ15UPNE8vuEoa9vdhJR0YWLtkbFZbobr/bNnLvduYWQzFVTADuNv43Gd+PiPJy
	Eg5FjfDvNZQFZ8BmoJ1WEjZ8k5GhiQBkyUgyuln3AP54sGBVeNfZCyg==
X-Gm-Gg: ASbGnctThrrbsqiaCmjAu3IQ1j8U2Fvb/VP4c0zoCpyb8Homz2a1J8O8uhSShzdftDB
	21Y/FytjJaJHUC8REqWOSO7UjhqAyEZX/VmBoJjYjpJmNeGnrxNyusa1IZRwv
X-Google-Smtp-Source: AGHT+IEdrLtj9NaXXUfCeQxVjlSafuVoPdRfD2yexlIaCJux0eAYLUG/36jd9cMhQ1bPlx07fZHGswpMMleKK6+/fH0=
X-Received: by 2002:a05:6512:3119:b0:53d:f1cb:6266 with SMTP id
 2adb3069b0e04-53df1cb62e3mr2782497e87.28.1732796906369; Thu, 28 Nov 2024
 04:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com> <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
In-Reply-To: <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Nov 2024 13:28:15 +0100
Message-ID: <CAKPOu+-Xa37qO1oQQtmLbZ34-KHckMmOumpf9n4ewnHr6YyZoQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> Pages are freed in `ceph_osdc_put_request`, trying to release them
> this way will end badly.

I don't get it. If this ends badly, why does the other
ceph_release_page_vector() call after ceph_osdc_put_request() in that
function not end badly?

