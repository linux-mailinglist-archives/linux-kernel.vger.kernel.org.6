Return-Path: <linux-kernel+bounces-569951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C976EA6AA04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6905617A560
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE981E5B9F;
	Thu, 20 Mar 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="aOnq5Wpw"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D571E1308
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484909; cv=none; b=VGeBJ6cduFESAxV9m+qHSytQuf0LkZMgOWK2F3vfcqv7NRCwjv80DeZMMRxfNO2bycI6eBwVeylhiBU0VuTeuKb0GWOiw1LRM5MvOV6E4hISqC+QRMpGGgS1+iA1WuBvZZZA6jBdRwvdrG08wTEvNcnOouEWDNXnH2Rka1+2Ktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484909; c=relaxed/simple;
	bh=JE7TRJHgKZugbOb+fvx+jb6lPiNMeVF9wnCO2Egr894=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBOTR+t9pZ57z3rSsvulFHmEwSjaXBb2+9oq51DXlWbCAimFeU64UX9qPFgjTe8+20PHvHCBx6wjtceuZq2ELMVwF8bod7FzTTJJ9g5brZ1ee3tmurSHTBvx779L+4LN+aUVTkkNAX0J/sxcJEQGgt/FDKEK/Ub4mTjNO8R6Nbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=aOnq5Wpw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4768f90bf36so9489201cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742484906; x=1743089706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IKafdfY9ZWhVKC7KjhxqxesIH7gCbQGedUOZZuhyaVY=;
        b=aOnq5WpwW7qCVcdFKpKi3AHKDBExgpjRUKLQTQ0BzEdMbdYY1ugBjXpSj/qazi8yIs
         GwfHWbxzLSMMumISwDeg2tbpt4dwU2yotiw0UV83TAMOpbiVC4j2yyLfwy7XvpdkjgV/
         bH1ZkjYPIL1xRFXT2EiAsmGc3+EoTxecoYDmKdHvAgH9MBqem+G8U3FxqGdAUDmIaKNq
         WVYYFxYMLb6WdJG3Tu+h1cO/e/w+Wf57hlc8AHlIs6jgckGb2FNyxg1GDPCwGCL3B6Au
         m351kZCP0gUxmveYjdaWkr7jV5gz40Q9cI9MH0DslFDuiGICDWmQ7EWXij5uG4mecCUf
         CuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484906; x=1743089706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKafdfY9ZWhVKC7KjhxqxesIH7gCbQGedUOZZuhyaVY=;
        b=kX0VWgIc7N6Ks6AQon9MuQErrKCpK4mVHQbQApfxhpcrC4EJ1yV/ZbU6q822osvnVn
         nCPv2vuLxqYV4njQBXRHfoRjauC4t0AGl8i3CAdHyA2BZW/8vV4oqxRUf5UbkGLukbGe
         XCBNkCcsuFz2vUhECT1GYIPF0hX/oX1zHPZbnBdedm9IcdMIOboKSbb4aOVHvnHXsj1E
         wmXHEAOFnc0oiAtX8y5M6VDDE1t6m4efL19EotSPqirNP96tZxyubXmCSuuWFCqxVJ8b
         n0p3GKiW4VeWOP4ITmyCuuk1wwEXJp8Www3sEm7EGOOMKZAkj3VpMSeRCZsw8HSVWWTz
         h4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdksQbk5nxD1qLBPC2RtW19MM5ySwKKqfI6gQFwUuGXfklKQZe5J54zq8wyBW+7oag9RPV/8KDMe/lmew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWBCdSn/ZjmJ7+4Dz7YMEbcjP7B6aPiOra0YIvVf+X/hS07uT
	kSc4ojCpETP05HJgHrLQuBqDjmOlCm7yItjODe1TN75nZ9N6zNlMGfO8FCgfEi0yzufzyXBW0SM
	uCNnXOgs5Du54s1vYXMwEWOT+0RUWWAKhrw6kPA==
X-Gm-Gg: ASbGncsP0XIwQ1ws9beKEsG4YOQcIeskCYPeDjlOySUsdL9PYc7fW5k8uzi4M+3RqED
	ZnJxz9V48e2AEHxJOZ5jYDENOHyjQkBmH6nXqmu2SK0FtszTz8b5dReaybPACDsfJZEV1+2nz9V
	zIY+CF6U3hs6kR2XXL8SW+FII=
X-Google-Smtp-Source: AGHT+IG23zWMPcn01aREq7x/0tvXcHrTZ0TQmBtFI8pmoBe8ztNU5sWQOWjuGUrVzDIlMW9fQ4VgnR1HuRZz41Vr2us=
X-Received: by 2002:a05:622a:5a95:b0:476:6189:4f40 with SMTP id
 d75a77b69052e-477083fa813mr116439551cf.45.1742484906584; Thu, 20 Mar 2025
 08:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com> <2025032015-urgency-partake-9dc1@gregkh>
In-Reply-To: <2025032015-urgency-partake-9dc1@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 20 Mar 2025 11:34:29 -0400
X-Gm-Features: AQ5f1JpJmSgK_4q12OaIr3YC3SPbsDRr7KPaQPliJnG6M1-RyT2N3BASX8hSa6o
Message-ID: <CA+CK2bD2tfMXT7BDHs7p0NzPYJQLkATEXh6wUeP9P7HtY+e2iw@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Live Update Orchestrator
To: Greg KH <gregkh@linuxfoundation.org>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, jgowans@amazon.com, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > From: Pasha Tatashin <tatashin@google.com>
>
> Note, this does not match the author and signed-off-by on the actual
> patches themselves.  Please use your google.com email address to
> send/review/work on this.

This  was accidental, I meant to use pasha.tatashin@soleen.com here, I
use this e-mail for upstream work.

