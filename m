Return-Path: <linux-kernel+bounces-178177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6728C4A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E5C1C20DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC6F85649;
	Mon, 13 May 2024 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E+9qOxFo"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C185622
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642999; cv=none; b=dpZNLi93pNL3zAgRr+TVespzVM9GkLwzKTwfwwN0yzQC/SPOSTn/iTRYhfvXTfEL6M+GKa0uv5dLSF/d5WsjvHxR5sAx+ZWMeZZL+wIv+za//7nbW3xkVQ7Mok4HNWJMwsh9wAxeGiBZPmNjWhbp5E2+ty/6FNEQTe4IKLnGCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642999; c=relaxed/simple;
	bh=dH2Gh/VfvRAwRMCapomFJKaaLGs4S106axXfgAQnxwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcI7r6NOe3uGD5friYTZdz8/D7f2OTG1u51Tep0Mo2o3AaEyUy+9mq8AK0KAT5q7wy7kmPGVNKLJDBhtVXm6/vcd0vWEZIXUrMOBvZlJv5rlVrlxOSwZRZvjynpEs+6r3Na3URkrAzQw0IcmDQRDq/C0o/vM+I1R1jsmHSRT/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E+9qOxFo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso38312275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715642997; x=1716247797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1EiMHldIKpnCXznyOw68lbbiSInf8wRIhCrNgk+6Oc=;
        b=E+9qOxFob13JIPIC5cT6NMCA2B4ps+qDxxWCfilA7S4BosMJXZysKJQRzHPAhkm6kQ
         IsDZOw+qy9yXTRrE9gCQv/ZBP/HhNkIDrb+7ggPXTgHLZ+yZy8bOgp0eiXbo2ogJQbVI
         9utsRakgMwoYQhiHPW+GUEmHHs2GddTP48p1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715642997; x=1716247797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1EiMHldIKpnCXznyOw68lbbiSInf8wRIhCrNgk+6Oc=;
        b=cfGTFsSUj1tzhrQUoKAiXKly6D3GX1uhFg5+mKnkDc5qUeTqWwPCHmF8SWqu340KXp
         QESnZjmCdrI0jJt8D1Cwkt9ECzRPyWPKLlUrccVgOIY2ySAbC2GCcx3xJ8NZo2L4eWPN
         2rbkZX8K6HyIAotlZRjsatAcOOX8ehqNsJG2y8XTlyeueT1HBCIdSUN5Y0r1YFHSiaJK
         W/MuEWh/Yp5L5JHuWk4iGbZQ3DjM/Cehk5y5gUNO/4BtUuUBMe9gCLhdRCIB9/viHfrg
         oDqTM1ueNfclcovX0u+UIz4yWuYGkUu5dZRdO2nJmG6lMgIEEqr4qh9t7HyuNzgLlkNy
         v1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGMX+jYhv22WoK75oYrVPAFT26EqJ61CuhFkPt1JX0pIoRcGQYb/pju16PXXvCl/E5AmfpjwIWrwiKzau0w+KP4vsZdpvBnUctphqj
X-Gm-Message-State: AOJu0Yy9dfethSDQYx2m+iP5Gzo9brMDEYgNKEhlrDiJL6HEwAvVISwC
	rDihuqefStJ8MnoLcmDNuE9CSfRwfmoTkKW2/nVrAYFwQjx+ZKU4XTusWSDq+w==
X-Google-Smtp-Source: AGHT+IHqChMWCIwa2ur3c5lXZsd7v1cl+KVoR9q/GWMdtWIhwTCr3j8ecpny3TzA+YcBJyw2U0Qsdw==
X-Received: by 2002:a17:902:f60a:b0:1ea:a87f:bd2c with SMTP id d9443c01a7336-1ef4405a80cmr134147885ad.68.1715642996861;
        Mon, 13 May 2024 16:29:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30c09sm84557115ad.130.2024.05.13.16.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:29:56 -0700 (PDT)
Date: Mon, 13 May 2024 16:29:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <202405131629.9C315328C1@keescook>
References: <20240509-b4-sio-read_write-v2-1-018fc1e63392@google.com>
 <202405131251.6FD48B6A8@keescook>
 <q2qn5kgnfvfcnyfm7slx7tkmib5qftcgj2uufqd4o5vyctj6br@coauvkdhpjii>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q2qn5kgnfvfcnyfm7slx7tkmib5qftcgj2uufqd4o5vyctj6br@coauvkdhpjii>

On Mon, May 13, 2024 at 10:06:59PM +0000, Justin Stitt wrote:
> On Mon, May 13, 2024 at 01:01:57PM -0700, Kees Cook wrote:
> > On Thu, May 09, 2024 at 11:42:07PM +0000, Justin Stitt wrote:
> > >  fs/read_write.c  | 18 +++++++++++-------
> > >  fs/remap_range.c | 12 ++++++------
> > >  2 files changed, 17 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > index d4c036e82b6c..d116e6e3eb3d 100644
> > > --- a/fs/read_write.c
> > > +++ b/fs/read_write.c
> > > @@ -88,7 +88,7 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
> > >  {
> > >  	switch (whence) {
> > >  	case SEEK_END:
> > > -		offset += eof;
> > > +		offset = min(offset, maxsize - eof) + eof;
> > 
> > This seems effectively unchanged compared to v1?
> > 
> > https://lore.kernel.org/all/CAFhGd8qbUYXmgiFuLGQ7dWXFUtZacvT82wD4jSS-xNTvtzXKGQ@mail.gmail.com/
> > 
> 
> Right, please note the timestamps of Jan's review of v1 and when I sent
> v2. Essentially, I sent v2 before Jan's review of v1 and as such v2 does
> not fix the problem pointed out by Jan (the behavior of seek is
> technically different for VERY LARGE offsets).

Oh! Heh. I was tricked by versioning! ;)

-- 
Kees Cook

