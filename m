Return-Path: <linux-kernel+bounces-233544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B091091B91D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF6D1F23919
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DA4143886;
	Fri, 28 Jun 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdDm/kEO"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20EC148
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561395; cv=none; b=CJ3cTBXBT2JkPwF2CkzNNRz5QiDnBMYkKE7MHZ6zqmV1MJNDZVNsfya59EsCTPY0w16GX+fc455HV7nebog2edM2ngSHL+Jk6TGGuICSbF2Sthqpr8f6vOuGUKc0ehUkcrHnR1cIFKEqp5AUWhPhq5Ugk/S0nQAIbGtJJ2kO7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561395; c=relaxed/simple;
	bh=u23OpZ48kMSTraKkzumtcJpQ4pj8bIyJg5UzBJRJg6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2mdx7P3H6x+b/zONt++R7si5eBCnqVCpWJan9D8i2KKeNtpQwVez8fi7HV0VzM6PWwx2UiizPj+QOlzs6Bj31Fmf6V8Ri9mgTLNTSURFeqm9sx/Zs4bfvLa+qk13ttHOF7rzNvT5ARx9ePp2P0SJiVYDXVK8ssPVPe3nNPtwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CdDm/kEO; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b501a4344bso1423776d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719561393; x=1720166193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eq4WAeAv7a05RSJOZ/FC8KCB2QrYL2z/HLtuN/Zoho=;
        b=CdDm/kEOANR2itvaAv8jHvqQssAo8b0wE4wl54so5YtpfBFBTjylJiDy8U7Z6Qu2v/
         eEnTTaVvu7vltVaLm+ErzgVI2RdqIWWXVojdHLfLITfUDOVaPjLt9rN8P75ZG6kbTMvT
         Nuq1RYh4dZ8iNERJl075BtHAwZ7zjcFVw7gFCCDcH12G6UsnJaqMSrDalNnhbRt4Z5Ex
         UMaIsp23sTWnKMd6uckXTPcmv3VSYEPiBjWxOnZrJz8t9xJsgFpIHRqE1hoMagP+/UyC
         eU5aH9eEe7s0qDuspEBabQEKIvEynl2EwcPqektu1ECHNUkFdRXR7x0RnakRHh383TbT
         7lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561393; x=1720166193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eq4WAeAv7a05RSJOZ/FC8KCB2QrYL2z/HLtuN/Zoho=;
        b=WfKIwdGjVDdMT50SXngkUOOjBC4gixZ+GK+UqxfQoD67HtcihhVRmBxJKZUTjOG46b
         e52jtuxYyTv0Zc7GpbLUK3lrF358Uhs9UqJPjYdmOiOktgmUJA32qx6WtJD3V9i3kVsc
         5rIAc9sPWzeG3YOpaB0dZnN5kXuFh73sS6Im09JEDZaydHQ0pBWTEyXsEfMhMkdq7X6I
         M1/qb2t2NIyfpGaYYOTNV10AE1klhNz6yle8GsJJrH05Sk0z8HzPX2cRRiqoQJZPKorv
         GqiRF4w+kBmFG9OgWJx822sgt4gz8PNgC4XyHpYWs1EDt9+RPpIs21PljvK0OgGyxU4e
         gVtg==
X-Forwarded-Encrypted: i=1; AJvYcCUqROmOuwEm/EtbLArHf9sCCNV9H7iXN69UuASi6RmO+N8VrNjvRoEcxgf/wcnKDkGnnzZdOG1mELIqR8lGyqT+j4lw14Zqp0pTaUGx
X-Gm-Message-State: AOJu0YwcU9l8Q89M71CRHDxE90XfiQH/wA+iaLz/y5n+w4gJ+wFYKfUz
	1SSt5AZEyexLA2EbEksW05iy9kXWe3Mh8uZ1K9TCYTfIUPjGDXxb3nCTSGotOjSEPfRDpLEV3WR
	QdHHNQSqVKEsZHUccx7T9d5Ylo3Skc8vfu8j3
X-Google-Smtp-Source: AGHT+IFVaspC0FarMFaL9Wo6buyD9kCBK/3ssts15EAQDX9SSws8PK1MqMZHzxtxAH0mARnWuT6BfN57cSr60XtGLAo=
X-Received: by 2002:a05:6214:509d:b0:6b0:7485:719c with SMTP id
 6a1803df08f44-6b59a04ea34mr34155586d6.2.1719561392494; Fri, 28 Jun 2024
 00:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627145754.27333-1-iii@linux.ibm.com> <20240627145754.27333-2-iii@linux.ibm.com>
In-Reply-To: <20240627145754.27333-2-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 28 Jun 2024 09:55:52 +0200
Message-ID: <CAG_fn=Ucr+=Wq=h=qnK7iq+DqBom7eQEjQ06+YUabvO8jXq6xA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kmsan: add missing __user tags
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 5:14=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> sparse complains that __user pointers are being passed to functions
> that expect non-__user ones.  In all cases, these functions are in fact
> working with user pointers, only the tag is missing. Add it.

Thanks!

>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406272033.KejtfLkw-lkp@i=
ntel.com/
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

