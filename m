Return-Path: <linux-kernel+bounces-396873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9559BD374
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5A61F20F02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04AB1D9A60;
	Tue,  5 Nov 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="I7zi7hNz"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9651D9A71
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828097; cv=none; b=b6Y1cIPczPRF/EPguMIdM2xJgVCcvqskosWayGRHGF/oNGLb/kMEdfza4OgqFgdSNwvYIMW6aPmXXmWfbOSW5IKcA82esIdRzKMy0IYaZNniBHyURzYF/YBQuzDCBkt3FNbkn+vJuhuOb75jlpTuo/Np35uNY929rdO2eyshVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828097; c=relaxed/simple;
	bh=QUJBA/PvSq+g5bGHrQF9BKgsZJva/eZtagz1QwrcLhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaGtIPyMSr+dZ736rtjJLjMyPyRf8kS8cSYXO++yY6pyrKiJplA48L5Uy5wRE4/s3chBhfchIar/l8VsPFPeuRtAKa11I4MzumA8C/rt2c4MiO0/sAkALOHhjaT1/NvPyw82cuw7UeJMBbFaAJSjzGhQF9bwYlisN6d9klMH6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=I7zi7hNz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso4029308a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1730828095; x=1731432895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SpVxQLLNLfLph3m6EIkv3r8u00CnaqvwEZ6ejt8Iwfo=;
        b=I7zi7hNzmSwjEdyituC7WADZnD3vF7O4WflxjWSwHwVkXO8GrIuP6yu3C2Z15ADm7O
         gcQw44g5MyIfxEONTPmDvL5lRC4XLvxCYy8E+oM5COekt7Znw9rVNBzWJcI0n7hksvUK
         li9b/WyR6a8TlMn+MZdbqX+uTpttu+g10tsUNIlDcFy72tb0PPi3p2z0Z0IcMVHWjYFn
         7a372j8snhOzyd8w/582hhC4QcxYlXLPXmofhIfdRNNv8w7HUi69YeXKxBwypP1Km8bR
         A+lxSwNZe9ETMuqXmj4Hr3YI/fXgYRkJklxjG7toQrz1JzS7+6KpArL8k1rv/I5p9Nq+
         V6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828095; x=1731432895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpVxQLLNLfLph3m6EIkv3r8u00CnaqvwEZ6ejt8Iwfo=;
        b=toLuRqZRaDeg0GOrE9rLkZ25QwfgZesZcGVs5LbL628o8uayrR0zR3xyeRZdSf5EjI
         K+h5854wMpNX9D8JJ6b6O19pH9xW2vfPE0i9a/mWA3rz+geo/JQXWGmApeoBDB37EMm9
         XVXnvGyPKry6kmNb+FkY9KtucJQ6W6hUhXR8svmi0lq+li7N3m0Lwhe37nHkkzLZy+IQ
         AVIy4Nlzl6snxjOrdHPwrFFGvcZJPZbsKSdGkEekSqX05PyCBrea5Hf+Dh7KwiwIYAsV
         2xwoVZaEw6+Ne2jcuUxxSOJbafGltUM7w8KNEhvc01unrWEAXCOHsVF2ozM1RvodjZqV
         HC5A==
X-Forwarded-Encrypted: i=1; AJvYcCU26RkhlotbIInqZ2nua7IdEYY7rXn34pgqMys4U833afcoa0o/LkFIjVFdoqlc70KsnNzef9+NFAvt48I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZxQK5A6NjU0T0FYofwvWfswnCc/IuNjQyFZ52j4bvee7X23O
	a7jOnrYjQy/L5Bj6vJ4q3msh5L1SLqUg1JKqYY0CSGB/dvC0Y2UYRVbtaL2v9WynqamK13eXBGB
	qZbuqS2RmE8UQwhL5Knj8MAUBvy/xKHOQ3bDVRg==
X-Google-Smtp-Source: AGHT+IH+bA1GiURFitv8kWYaSx/RW5cqeoyKLHZlSyIHFiiS2c0gxrHtSJy3vziWV/X5vWRNJ0DWzAshOtbMqV8BLE0=
X-Received: by 2002:a17:90b:3581:b0:2e0:7b2b:f6a with SMTP id
 98e67ed59e1d1-2e92ce710a9mr24650088a91.17.1730828095207; Tue, 05 Nov 2024
 09:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
 <20241104092220.2268805-2-naresh.solanki@9elements.com> <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
 <CABqG17j8RhFpNV+nJ=nLY8+uO_XXjbN55+Ce8op=6Dj5Z=_WOA@mail.gmail.com> <7d9657ff-1c4a-4167-982a-9f07e7b51f77@roeck-us.net>
In-Reply-To: <7d9657ff-1c4a-4167-982a-9f07e7b51f77@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 5 Nov 2024 23:04:44 +0530
Message-ID: <CABqG17i51TnPhAKKEAVYMXfqem9XWeNJuwzgLiYB81uCs0n91A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jdelvare@suse.com, sylv@sylv.io, linux-hwmon@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>, Patrick Rudolph <patrick.rudolph@9elements.com>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew, Guenter,

@Andrew Shall I resend this patch series along with dependent
dt-binding patches ?

On Tue, 5 Nov 2024 at 21:17, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/4/24 20:10, Naresh Solanki wrote:
> [ ... ]
>
> >>  From a spot check, the warnings seem legitimate. Did you send the right
> >> patches?
> > Just checked again. They are resolved. But I guess the dtbinding patch
> > for the above warning are merged in hwmon-next branch & not in dt/next
> >
>
> Did I apply some patches which should have been applied elsewhere ?
I think it should be fine.

Regards,
Naresh
>
> If so, please let me know, and I'll drop them.
>
> Guenter
>

