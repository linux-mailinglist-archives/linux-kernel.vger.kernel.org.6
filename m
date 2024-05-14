Return-Path: <linux-kernel+bounces-178257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022E78C4B39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74789B22CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12785B653;
	Tue, 14 May 2024 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bzur57eW"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A3AD32
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715654315; cv=none; b=Jd7RF0Vvz1WtV+eF1ZdNzkhG0DQP4ALzc3pytCQHYZPeRTzGHAD0qm+umswHxqWIjWexrD7GuzP7xB/L3SxCkp4yC5RWt7pz5bwN/uUEjFXBYPWPn+4Q62o7RJm1h2RFAI9US9qNLrxiXmfzvtJrxVUD2QXqY9U7vQFzvodYIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715654315; c=relaxed/simple;
	bh=+/kjnNS42NLL3kGckammgIhVGDvPLX3e6wXmHg75qzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2A3T5E77nN8Zt9sDIBlpuqVlewbR7p4NBJMwhAtd/wvqiYPtvzMDLzoyeMaPUqTJcLyAm5JheRwT+6g6KwO6oBtW+3KvVFHxORy0aisufeFJQuGZpJCXSV83cQ9MxeNgalcHfkJbHv3cpl2HznpBixGFDrlBGLrCZqAnDy4qYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bzur57eW; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so59525961fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715654311; x=1716259111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g1lwNfaaJwPa8lZzRRPRd8svxoAyGNm2U5kEgmIG0UI=;
        b=Bzur57eW589geNiIgBzE1WznwiRl8kGLBCEtBsPy+U57aTwxnD4vWPJUFhhjik102o
         pVBVn4+vb3DCqD7+gOM4+UgYqgtV69lVKBT2F8mu2KxLYPPJiouFoLqd75vMwATLUj/I
         xNs/dBS5YcxLD102cIjsJJDdZCVDV34AMF4OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715654311; x=1716259111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1lwNfaaJwPa8lZzRRPRd8svxoAyGNm2U5kEgmIG0UI=;
        b=FTgCISl0A7NyqYaKddUdCpcjPwWGi0Bal+4yxnf6dCWjulmRQohRmSABd/E5Srylut
         suXOinqgNowI7pky7NdnpGtaphLkb0TDbWXKQ6QUjUcuz4K68HSjGTIY8RqEWkLYBKMb
         Vkq2ZjZnRlwdAlnWWHZSr9IVB2o8FoBRNjFT42jsRi5YreeQ6nnafSQFuCWu6nHbj9Uv
         E9iWsjczW1AibB/1rvo6/b9Ydg+0JchARKA+7+WcpnYxM2A1QL71pYaslnt271SUb5S0
         xfujRC+1SH8lX+jmKDLbrQNaG6OlHjU5r/vDx//hCVMPTGzqUv0XVADp2wYgZvVWhdfW
         PGIQ==
X-Gm-Message-State: AOJu0Yy72SOXOTZs2cvwx8jg+h5UKitkkKtNDeLQWvVysodFgYio6Mme
	uVs4YrlfQ8jVl23OYXJUr8ow0UZGv4utLNsyVTZW+dZWQD5Vi+DdgTaZ6SFWVLr6PMdxl7HqwtE
	SiglpCg==
X-Google-Smtp-Source: AGHT+IGoOkBJJk3USWdalUzIg737M0Uth3C1piVmQUXKPdCA3JGXhbSTIzhTb+u8bUiqENDxBQYhGw==
X-Received: by 2002:a2e:919a:0:b0:2e1:a726:3dfa with SMTP id 38308e7fff4ca-2e52038a910mr75090691fa.38.1715654311133;
        Mon, 13 May 2024 19:38:31 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0bbd57fsm15879961fa.22.2024.05.13.19.38.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 19:38:30 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52192578b95so5881308e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:38:30 -0700 (PDT)
X-Received: by 2002:a05:6512:1314:b0:51f:601f:cbae with SMTP id
 2adb3069b0e04-5220ff73602mr8403636e87.56.1715654309838; Mon, 13 May 2024
 19:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkHLrqO1HdfQb71Z@gmail.com>
In-Reply-To: <ZkHLrqO1HdfQb71Z@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 19:38:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAXOLja2AqBzPZE+k9DKX0wjBGKZT+m2DN_hariyA0Pw@mail.gmail.com>
Message-ID: <CAHk-=wiAXOLja2AqBzPZE+k9DKX0wjBGKZT+m2DN_hariyA0Pw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk change for v6.10
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, "the arch/x86 maintainers" <x86@kernel.org>, 
	"H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 01:13, Ingo Molnar <mingo@kernel.org> wrote:
>
> Enable shadow stacks for x32.
>
> While we normally don't do such feature-enabling on 32-bit
> kernels anymore, this change is small, straightforward & tested on
> upstream glibc.

Color me confused.

  "feature-enabling on 32-bit kernels"

This is not for 32-bit kernels, as far as I can tell. This is just the
x32 user mode for x86-64 kernels.

Or am I missing something?

I've pulled this, but does anybody actually use x32? I feel like it
was a failed experiment. No?

              Linus

