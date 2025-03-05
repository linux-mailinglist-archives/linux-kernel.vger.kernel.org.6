Return-Path: <linux-kernel+bounces-546265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E44A4F88C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D7C3A0627
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA911C6FE2;
	Wed,  5 Mar 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh+p1s49"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA81C7007
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162662; cv=none; b=hEV26+31fYi4ffb1D9/nzlxIyX+cFCO7n5BPN284+KWjLnO1xRSCikw6KtF3XOv4d1uEg8LKQIui9Pm7MD6pLYWfkUXSFIAOGiwxCKSS3n+kIMrq+DMYSJcW1/RACX5FmCWvTPoXIrsXf8cMqTMk/KQef4c/wJHVntx3FaXDDsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162662; c=relaxed/simple;
	bh=unUXlRhpi9sFgYovBXVYDRg89FpRhkYUYq8VvpQ6o9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5f9X7ZOneX9u+CvOpODpbJ+HqaboC/YguLVKaq793KXXXGo4aLr1rlr/eLTufRUXvLu+1Vyb2/ejVkOhXyVQ4mEdvs1UqWx7yI1RWjLG53LtI/nvoLdzWrMD5wRPvKArXIsNOygS6938O80Hbz9QuWVloy1chcEviIlcer6SSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh+p1s49; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f77b9e0a34so52094787b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741162659; x=1741767459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=unUXlRhpi9sFgYovBXVYDRg89FpRhkYUYq8VvpQ6o9I=;
        b=Gh+p1s49ZRrYIVuEnpegKxry0XUhAGlmxXdws22ATTr+tbC7xJPQtpVwxTF7l7Qddz
         AFnIfmWNJ7Cjz7YNp733i6Pv6HxIGSonYLWv32CgB7Y8B3UeOBXCy9TSUAW23HsEujEw
         WkruQ9laicibNEUn6KDTrXOmiltZuem5/IeP3uDbPWJMQ7Bnh2z+gWXqilZB+U2AfVPO
         fCYwIZkiAiE7WxASU1/nfqUOiw6d+6OgBvrxsbs4tJBQxp01h+FWE9sJv6nrXFy9MKug
         m0jmmnyOV6JwSWBV3UwI8LNb+0WAGet3DyBXGha/xqnOkvcACY/hCL+62Lssexz8A6iJ
         oyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162659; x=1741767459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unUXlRhpi9sFgYovBXVYDRg89FpRhkYUYq8VvpQ6o9I=;
        b=OK2q2J7ebixIIhNBysteKTRD7T98pOsvozXtzdz8xbMZFOqN9RpORo1yDLpa/W2vHZ
         Ft0AGk+W0OgwZWNSKK6IPTgmY9axnDTwluJs+anNVtnqDA2ELRTSaoki1s6ArZS7x6rb
         ZO5lNiNTwqfsvNfWBtXPMAfidD7K+UHxeilJxD2HPZoj8UHKSAqQoIKgtwyXeTbt5hTR
         Jfw2SFWDLWw00ynPpdvfp711SKSesT9zJWkmYFD80UNhdTYiJ2JGZxXIntz3I8HXOC/+
         azCeAvA0tv0QX8LsVvnyWiicpIVPzr1omDWU5N4qk91jeEAEDdMF0gFfhaGJBZ90EDgh
         CrxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEOnhqP5QhyWx/6xoBI3TblT1qU3z2AELnezLyC9ut6LlPiQDZXSAiiatFu9OCuJRMB1rtQEnlvFqdDSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6QXjnJyXNCOtghr+xmTj5iOv39vFHj/yB2km11vgwEmfN8C4
	xqhpd10HQ3d5lf5DnRibFz0bLXqjGN45jBjKDgS5cx8TRZvn5HkDn/omVBcJRUeUQraJzv0y1La
	V8qc3fItv9a+aXJ8eUuKguBZPGXs=
X-Gm-Gg: ASbGncuiSAInoc501MX1gMBq6AC5ZjI74pVt4ymahFoVD57RKiGdY1roi9c5H8zZCX+
	gnZcylj+JyyXaU/4Y0jVhtjIdJCfI8iMxwuREgKfPRYXgQZOLCtIajxpSqHnHPoLNnOKsUGJlwt
	HdKzwyF7VlThDo4u6xBldMFRtY4OA=
X-Google-Smtp-Source: AGHT+IFH8tbkdolKMFQTBXwdPnhgEhIHcppznLYb0q6wu6PUrmMI5mnzlfbW6CZYpCojAT11BsO0ndoY1bNLhWNtILw=
X-Received: by 2002:a05:690c:7307:b0:6fd:4670:80c6 with SMTP id
 00721157ae682-6fda30fa282mr29688317b3.37.1741162659401; Wed, 05 Mar 2025
 00:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305020546.96564-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20250305020546.96564-1-jiapeng.chong@linux.alibaba.com>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Wed, 5 Mar 2025 09:17:28 +0100
X-Gm-Features: AQ5f1JpOTyDvXY3v1-JU3GbIR7BXMVjAHB0DwpN4ZcbevKt7RS7qwVJSQh96pnE
Message-ID: <CAMT+MTRvuYGqfNEO-uHK7zcDWR1z=iMJ2kmK_-cQ+i3i1=7jaA@mail.gmail.com>
Subject: Re: [PATCH -next] drm: adp: Remove unnecessary print function dev_err()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: j@jannau.net, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 03:06, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The print function dev_err() is redundant because platform_get_irq_byname()
> already prints an error.

Acked-by: Sasha Finkelstein <fnkl.kernel@gmail.com>

