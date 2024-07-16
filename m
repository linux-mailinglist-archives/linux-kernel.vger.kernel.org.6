Return-Path: <linux-kernel+bounces-253255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2359931EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E249281882
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28A311723;
	Tue, 16 Jul 2024 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aYJjoFcd"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978D101CA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096252; cv=none; b=rSxp21M1CfIoYBuGaDDNxvK/FsYU5iVB4gQc2EZkciHDRqDcWVVJFHxM/axq44ScRXExryD25aE3WaHDr2cvXUIJ234D00eu521Nn7eFgV5IIGO1EJ68o5BvUtBrGFJhFS+JkfTTAMfwIQqoCF/GqaLeI75agEBI/F4U1AQL1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096252; c=relaxed/simple;
	bh=BBaTfLOz45gv5TSiEZbKjsh54MGUgFRkzmECknTKYSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dn5R5iotF5qYsTkK93hg/a9bjIxFL+rbiaCyczkqDq97S/ThTO6fJj6SZ/nmPY0OKi1zkLzATHzJcDF50va8mZkHDR03z1ew0tiFENfXRTOPzgN/z+Oce2uHNofT5E58idCUhRwr6bE3j34cDe3dXJ61S0oncHFlyxQb1eOk5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aYJjoFcd; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ed741fe46so1748854e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721096249; x=1721701049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OxmhwjjpGd8zVAlRCw8Rz5PC00uRnZ4KkvDhpfV+dDA=;
        b=aYJjoFcd3BHOdAgK91EDeumV4SxOuIfWCevdPTnEyNvF4p7AhYJkgVxYB2PW+DLxa4
         5Qkh1BVVl4yqBmDUirh/NRS3cd0iee5qOUxoyCLEBq3H3U90X/pUrSQvgcQnQk5UjECS
         qAiC6E2NGcOZfL5QYhylTko1fGMGPygNKh2G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721096249; x=1721701049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxmhwjjpGd8zVAlRCw8Rz5PC00uRnZ4KkvDhpfV+dDA=;
        b=moskwy4IlcHDLsr6w3YAfKBzKf2p2NfwN/iKmHoH7fLLgAy/K7jLUhHf8L3VaVg+kW
         c57HgIheTotT/hSTdEIcxngorGnmbIGDPd0piom4/twGDmx5/PCYH0wNrBLBrjBwBb8P
         noyjlallUgFrnUiJbvjjKhx26OLDp0/y00Fc2BIGd5OA1fBzIZwPvrx0x54cyjN9lwz2
         gz/DBdwVmuSrfD320+wklHHp3NiCd752ZQt1yIQ8DEh0Y3CPV2KHXAAV4r2iWwPWFONY
         SPNk1W1F6MDh2579w7mD15Xqb2VOVY3JSx+Tf+Zlg7j9KRfXDBq5PhTdKy7deL2R1D3a
         Lgsg==
X-Forwarded-Encrypted: i=1; AJvYcCU24MvFHw3vTm+/MHNzcCkSW3pb6kmPcrarX1QzJ86d4RHRkS5gvjPJMrBKSNMJ5cBKHFNssFP4/XGVkQ5zuFIoYmzDdjunYdHVgXFU
X-Gm-Message-State: AOJu0YwttyOzSjchHdTBeseFC96nFnjgQJ1jN9KXsxl/Ui5LZlKM7KuW
	+/YrF2UKLgI9iOIOMOaP1oRZm39t04aXQAKTb1BDnX9k7bp8aAFTQyMpbe+6BOJXBV+AoBR8GsC
	r9erZbg==
X-Google-Smtp-Source: AGHT+IGMRmK0O28UDbJxvk968FpetVhpU3tnIFI4nwwgHyHQQygfflIvc5HsuzCCts7TglyVnrbCVA==
X-Received: by 2002:a05:6512:3da1:b0:52c:d834:4f2d with SMTP id 2adb3069b0e04-52edf015c02mr418794e87.18.1721096248823;
        Mon, 15 Jul 2024 19:17:28 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24e1f7csm1036528e87.48.2024.07.15.19.17.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 19:17:28 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so65496711fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmap72B2E7822cRcrr73N6gJsPhdN1TBEXVdZTDdjb90P+s3JEkO2aqacCxJQf9Lqd9J0GMCqm9JRExXeeu73epLOA4Z3UZagSgs9X
X-Received: by 2002:a2e:9d86:0:b0:2ee:699b:466 with SMTP id
 38308e7fff4ca-2eef41dab4amr4022321fa.36.1721096248037; Mon, 15 Jul 2024
 19:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712091008.14815-1-brgl@bgdev.pl>
In-Reply-To: <20240712091008.14815-1-brgl@bgdev.pl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Jul 2024 19:17:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
Message-ID: <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
Subject: Re: [GIT PULL] power sequencing updates for v6.11-rc1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 02:13, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> This PR contains the core power sequencing framework, the first driver, PCI
> changes using the pwrseq library (blessed by Bjorn Helgaas) and some fixes
> that came later.

Hmm. Let's see how this all works out, but I already found an annoyance.

It first asks me about the new PCI power sequencing driver.

And then it asks me separately if I want the power sequencing support.

Now, either this should

 (a) not ask about the generic power sequencing support at all, and
just select if if a driver that is enabled needs it

OR

 (b) it should ask about power sequencing support and then if you say
"N", it should not ask about the drivers.

But asking *twice* is definitely not kosher.

            Linus

