Return-Path: <linux-kernel+bounces-559350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A3A5F293
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D257A1761E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA9266567;
	Thu, 13 Mar 2025 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fgiHPmX5"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760441EF09A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865971; cv=none; b=OxSJ73Kpoo2EN+SBBl7fAV7tkauYYBmsCFlaJcCUX1+Qy5xBZ8vy5dC5MlMC+jV87nOSJV08K98bPJn3AP3LSB38MkT1cgljZV9nONkDVB6mxPyWLLoGJqwQP59Ce69HOzV69RywcYHy0knG1iGGuH9gd/DIRBgASk5TjJaubw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865971; c=relaxed/simple;
	bh=h/uGZ3X8jPhgOe/0uLH0jVZbUD3rnwbCquLnxR8exxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpjjT7YzU3Qmou/x45CIjCAWnkRJZ4KwofLFX9BTBkegrZFPwr6DEqXu6UWAkw2JSv5Yx4+73JSjLD7y/Frc7SZcnUSFVwuxTGvkEMBPgdiVDmNxaL6lbmFAAYNpWgp8LM6uUW8r2WX1fdT0ZYTgNBUG9F6GJILn7XyjJesUdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fgiHPmX5; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-474f0c1e1c6so11276791cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1741865968; x=1742470768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XLRDNwNQbW48d2euIipoZOCFakmNuPY383cXvSDOrxg=;
        b=fgiHPmX5gEgvFwaZ8E6i7JKbGPWVOkDc57ryuyJsFxUWtFqTVCSgcvJZKygUQ80dly
         gGILEloeA5jBRnK0XCyWVlkuIC58rN8KFandWjySZub6RvS1QzLET34e2dZLRFHctFxT
         2qrYCoXoMLX1JL+DZVw+XvlgMOhAopDK0SboI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741865968; x=1742470768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLRDNwNQbW48d2euIipoZOCFakmNuPY383cXvSDOrxg=;
        b=jfK/8MQc/ye3Yh3Xno66ig7HoW7VWEyd21rRa6xuSP8oVuWjUlhp7sa3hwtat8/3/N
         DOy4qeOZ3cEVL8kxuibnWY2VIAdxDP9jD5mEs0GnQGciPk6YAJdzA6DSIqJRl30Rdpy0
         tjy1baANweVxDvbWLVRaYH35ykUYhoQwRcECZq7qVVgTMwu208vUybgCL7x64Iqr6O0U
         6Rdu1Pot/YDBL5/EwWSSVUAQMA0nggQsSiN35540O/n8WWq7Er12TMd5ACF4+N1LQC23
         IqwjfwoJ/TCKnI75IMOaUL+wh7mivhTmMF960fhTkrh5S8YhENx8fK3+NpiuWiMBLTuL
         51UA==
X-Forwarded-Encrypted: i=1; AJvYcCVm4Mkrm+6TTjUx28cUfexYcBarvPkZ0+tGhMaBRvGfqr9vx1ArxPW84Ldak1GTGfGBnhbjCMUX/lZNVbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ZWKWAIFzyoRvlKipxHm/wu5UYM8z6K2K5PTk/Aq2QzdnYK6F
	lo2rJn/hmzsX2oOHZeUZdFgxl+Ta1LCsAnrE/2ntLKJ1cXPXVtXPt+n+lcHp2zbAjpIaC/RcQQK
	baEAZBOtd7s2sKTI+5slbUJOM/gTp87qRV6RNZ1q5maezD/WqW3o=
X-Gm-Gg: ASbGncuGwDYaUEObeOZvh9IdRV6d64QInNiUP3MMgk3bDzkUgNDDMpHXeJYP1uCTciH
	i0tmJe8HUOGau1+T2jW8n8jaG1JUptYJwNLjKDgiVppvediwAcCNkqiq/J1OvYl2eJkJ6GXUhX2
	00l0f6agSS5kVBmPBbIIM/nYeRYJ7nRRvs2EQk
X-Google-Smtp-Source: AGHT+IF/EM5J6cxTIv0NAHRBT204SHkF/k4vjEVRlzzRN+2TcwPcn3MHb41CCfnn/CDcYa8BMon0Pdo+swCXQOQUPzI=
X-Received: by 2002:a05:622a:5e8b:b0:476:6215:eaf7 with SMTP id
 d75a77b69052e-47662161001mr306295521cf.19.1741865968385; Thu, 13 Mar 2025
 04:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226091451.11899-1-luis@igalia.com> <87msdwrh72.fsf@igalia.com>
 <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
 <87v7sfzux8.fsf@igalia.com> <CAJfpegvxp6Ah3Br9XUmnz_E5KwfOTC44JTa_Sjt0WGt8cAZKEg@mail.gmail.com>
 <875xkdfa0d.fsf@igalia.com>
In-Reply-To: <875xkdfa0d.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Mar 2025 12:39:17 +0100
X-Gm-Features: AQ5f1JrG8qLz6DdlXmet9cKQDSDF_equrPXj5qxgrQyO6hddB5NyJqxHAw2KSfM
Message-ID: <CAJfpegtDBR4RMMOotxQC3d-pa38xNNB7ajfHrnpi_oQ0XWcTkA@mail.gmail.com>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation behaviour
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Dave Chinner <david@fromorbit.com>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 12:25, Luis Henriques <luis@igalia.com> wrote:

> Hmmm... And would you like this to be done in fuse?  Or do you expect this
> to me a more generic mechanism in dcache, available for other filesystems
> as well?

I don't know if this would be useful for anything else, so initially
fuse specific.

An list sorted by expiry time (implemented with an rbtree) would work,
I think.

Thanks,
Miklos

