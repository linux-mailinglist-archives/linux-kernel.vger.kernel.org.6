Return-Path: <linux-kernel+bounces-386350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0E09B424E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3701C21735
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392E2010F2;
	Tue, 29 Oct 2024 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG1gIeL/"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA526200C8D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730182693; cv=none; b=W6SWI7HW3yMoS9itIW8jMeveQX4zy/wfgcJpfVPpY9r7uLaGERkmPNj5j9e6/uyce5ghxr7/NcE4rEqV0ecREoRx7ov9dbn7UroypaiC9yTCXSjj9Z9SPjbPiIYzNQ+ALLHw9fkMjYzSzkdGEQzTYAUZGfdR9Y4gYwQUGt2ZRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730182693; c=relaxed/simple;
	bh=UdI8tpwPnCym4G8x3MoPmeXJLHOe8ka7Ss+PUunnOUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3pej1/VBaCmuTifIds+4sDAPWIGXRixzc81vfbJ8TvhnFSFsfd2zoJr5q1dB+VwvfEYGdjqlrKdIQG3JxU19LX2f5JyEF+blvh43buOlCxUBAVGrIim/tpYjeLgN90mC923D5MPIKCwvSIcqgUXecgNheUC9sVU+GGE1ou7hvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG1gIeL/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so3603810a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730182691; x=1730787491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbH+MxlZZP0jfdF1t+NhFG6akIfHUreHIb4HeUjiq8Y=;
        b=jG1gIeL/3yg87kUkYfR8hm3yv+NJ0UOLEGOP8FZgpqGHC92ce8ltpqQ+Uk6r2VFtTY
         Lk5RY62QeDVpXhx2OnlN8Xh/92IG0R3PhfDRtPKSkkkCzWE05btyixsyiSzJ2wALSIl1
         YPYLNCap8YUpPqQab4SbKWPUXb7yNelpcBDKIo1Vta7V2bPHhFnU5FNab/IJyHVaf6VB
         a+dvJgDJ1xQIi+5UdR1tXT94u8a1Iv+v2j4N8x06hxmNnNgvwx8sj8bfF4+tQs3gC0ZZ
         QA1AdNR2F7H/Cvqrz4reBsjHtzvdyCWdc24UN9SqYlfpyyApv0RRElaYXQPY8ya8kZHq
         gPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730182691; x=1730787491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbH+MxlZZP0jfdF1t+NhFG6akIfHUreHIb4HeUjiq8Y=;
        b=U/0iG+/G6R4hn/GfGUoQgu/i2fy/+NmE0EHhElVPNQZdc3MgSz3TcTIo00z/syrSdY
         3RVywaMLMhsCQQl7pY24wHgKE0FmVZpZhACfqAFIkIaTK/NEAl8hayKqlgw67SuYzm54
         eGYaIEu+gV9nUfqwijzauJiQpQUj2qyGmIVulrGYHr1GHLLQUEFgkPPqwQvpSj1ICUr9
         0aCuIHh9lwlNsT7LFw35ERFjwuDdEgCZp8XuOjIqRwCUsE8/E72fR6n9sHDkJL/zb8pu
         UtPp5Ya5RMFdpjXocoiljok9ZWkhqNCGrMcqBNxX5ZldDxqQsymc+Fw2p/KoLyZt67ZE
         JvVg==
X-Forwarded-Encrypted: i=1; AJvYcCV7rhDfeQ3QhFlIswdiy29JmBfGcqyPQYvyfKksHLhABGJXeUd6bQdK248VPrljTm4u0DtADl5pQnzakJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUh36PUFdN1cu0LsrXrQkn4APGdlGGIbw9gh3hBAtuBAOR2oHU
	oWKoTdHBCSDamoD3VPKdo4sxCy9OcLoV8G1H7duDyevrruP+uUqij1E7I1sT0pqtEPuW/FErnH+
	Sn/J+w6eAZcSxXW1N8PTsnnaQVp8=
X-Google-Smtp-Source: AGHT+IEakR8+6KFEHZc1bHgt3VBR9Z5XpuWlN6ZYFkC6UU38ogv3Y7zZUo33OohAhhDzC6sTqSsezfL4MOPl/EAohnc=
X-Received: by 2002:a17:90b:315:b0:2e2:ba35:356c with SMTP id
 98e67ed59e1d1-2e8f11dceb8mr11682733a91.39.1730182691042; Mon, 28 Oct 2024
 23:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027045752.10530-1-gye976@gmail.com> <53slkiaabzxkr4npxjgc32igwnspzyohvswwhooc4nfzdjw547@q3nnf3wblgfd>
In-Reply-To: <53slkiaabzxkr4npxjgc32igwnspzyohvswwhooc4nfzdjw547@q3nnf3wblgfd>
From: gyeyoung <gye976@gmail.com>
Date: Tue, 29 Oct 2024 15:17:59 +0900
Message-ID: <CAKbEznsv9yH9vYSqhCi0gJt-oww3R5t0YWP_YtpTF-=CvgzWkw@mail.gmail.com>
Subject: Re: [PATCH] drm/xe: Fix build error for XE_IOCTL_DBG macro
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your review, I missed how && work.
I will revise a patch that print only when cond is true.

sincerely,
Gyeyoung baek

On Tue, Oct 29, 2024 at 4:47=E2=80=AFAM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> On Sun, Oct 27, 2024 at 01:57:52PM +0900, Gyeyoung Baek wrote:
> >In the previous code, there is build error.
> >if CONFIG_DRM_USE_DYNAMIC_DEBUG is set,
> >'drm_dbg' function is replaced with '__dynamic_func_call_cls',
> >which is replaced with a do while statement.
> >
> >The problem is that,
> >XE_IOCTL_DBG uses this function for conditional expression.
> >
> >so I fix the expression to be compatible with the do while statement,
> >by referring to "https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html=
".
> >
> >Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> >---
> > drivers/gpu/drm/xe/xe_macros.h | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/gpu/drm/xe/xe_macros.h b/drivers/gpu/drm/xe/xe_macr=
os.h
> >index daf56c846d03..58a9d1e33502 100644
> >--- a/drivers/gpu/drm/xe/xe_macros.h
> >+++ b/drivers/gpu/drm/xe/xe_macros.h
> >@@ -11,8 +11,8 @@
> > #define XE_WARN_ON WARN_ON
> >
> > #define XE_IOCTL_DBG(xe, cond) \
> >-      ((cond) && (drm_dbg(&(xe)->drm, \
> >-                          "Ioctl argument check failed at %s:%d: %s", \
> >-                          __FILE__, __LINE__, #cond), 1))
> >+      ({drm_dbg(&(xe)->drm, \
> >+              "Ioctl argument check failed at %s:%d: %s", \
> >+              __FILE__, __LINE__, #cond); (cond); })
>
> but this would print the debug message regardless of the cond being
> true. Previously this would enter the condition if cond && 1 (due to the
> comma operator use), but printing the message was shortcut when cond was
> false.
>
> It looks like keeping cond outside and the statement expr to cover only
> the call to drm_dbg would work.
>
> Lucas De Marchi
>
> > #endif
> >--
> >2.34.1
> >

