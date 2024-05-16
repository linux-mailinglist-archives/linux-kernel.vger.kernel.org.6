Return-Path: <linux-kernel+bounces-180520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C896B8C6F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1911F226FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C4EBB;
	Thu, 16 May 2024 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SeSkr/Gq"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE3631
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715819830; cv=none; b=oYdgVU3KBG2CQhARvo+kgpp4cNLZOAywoqZ1crtaub0Uz3w6bKv+ecftzsNQFsfUlnKGWo2SPHqtmltGdu6MlTzprPfkhykJSWO20TpUswY+tVdL903Gm0jtZLJRNnYyQo68O98rrVXZilyQauxzCMB56tXf38B0yxpU3DDzek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715819830; c=relaxed/simple;
	bh=jK8R1GL7NP9dqZttNW+vGplxdyia4ItObmSm7iSGOMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fh9T3DfP07FnEbyz4GWpfpWkZm0pnz9eyysKaJxP3H9WKhH4Riv3K8V0vBjtHNULxWXM4K5i5BryPboZdkZ/9Ev6eCstLoDTOTjnPdDnes1lATHX9nKzhGVnD5b9skJp8oMRgfkO6RpvyAncPhpt1y7uR7mjiKt5W8HQNgiB4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SeSkr/Gq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5210684cee6so232299e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715819826; x=1716424626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/dq08xG3j2ROuANEbUtzbsEjKB703nVhd+oCGHhdtsw=;
        b=SeSkr/GqqNv//s9l5GKVpHx21ijzcTT+cHx48YvOVZIck/OrXqtjZabfOuj7c5ATVQ
         ALAIhXTkI8s84ZEqHHOwItBnAgfQo+iohNqfDr62OHbPprwKYr1LINxDA6bVgOkbw3JJ
         XyNwLxWX2ROUNZoh+McYkcdOirUU31rkE5cLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715819826; x=1716424626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dq08xG3j2ROuANEbUtzbsEjKB703nVhd+oCGHhdtsw=;
        b=BAqJ+fzqmyxswwwr+KD/Z+vGGpX+OQnGGDQpf7ueKsTWbWkR8IUx66BUCuDyrEFUhr
         mL1s9rKYCUcyIBIh0wa+oM2NFG0YfjvCQw4Ll6cXMsgZPzKfatgwYix6sxQ4GDDEY5JL
         bA8eQX4pcN4SXgU1C2aCdliCDjZXwgCEC/O7umwfdlJ2j+Op3TPKKCV2Rhr2aT47APyr
         abhr3hf359+14s7C1n048JwhAuZpv0PmM/IzbdoNw72lOOlIrttk1bCLkNN0UKdIH082
         InvdZqETg2cWCtbFh1cMs4FFkSWaosr9IzKfGquH06Od2qt5QqnHCKrjsRxiKNPVrJ45
         p53g==
X-Gm-Message-State: AOJu0YwPEk2BPekMpXyBd7bL4F9X94X3E4W+BAUnjDcSp24X6ZaqMg1m
	VkyZ0aTQ/220q9SaTP8z3IimFhDzHSq8etHztamqSbRUvVLgWLVkQaPWMz31HxBtssvhjJtxv8I
	P5KT8oQ==
X-Google-Smtp-Source: AGHT+IFJlbyyOS5UeEY9JoVGGQ0xnclnMKBA4dMokEii6wL65jWt/MPkfUXgx9iaFCuMK9wEvli3Kw==
X-Received: by 2002:a05:6512:398a:b0:519:2a88:add6 with SMTP id 2adb3069b0e04-5220fe7999amr13316742e87.55.1715819826014;
        Wed, 15 May 2024 17:37:06 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad5cbsm2741115e87.1.2024.05.15.17.37.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 17:37:05 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5210684cee6so232280e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:37:05 -0700 (PDT)
X-Received: by 2002:ac2:4858:0:b0:51d:b2a:5f7d with SMTP id
 2adb3069b0e04-5220fe799b0mr10956775e87.48.1715819825101; Wed, 15 May 2024
 17:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org>
In-Reply-To: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 17:36:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTVMV2hBx6pQDBuG6sn75CtTfXrm8TF977fL9sqwnDFg@mail.gmail.com>
Message-ID: <CAHk-=wjTVMV2hBx6pQDBuG6sn75CtTfXrm8TF977fL9sqwnDFg@mail.gmail.com>
Subject: Re: [GIT PULL] workqueue: Changes for v6.10
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 15:26, Tejun Heo <tj@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10

Hmm.

You seem to have tagged your test-merge, not the actual commit you
*meant* to tag.

I guess it doesn't really matter, but it's ugly and brings in a random
merge commit with no commit message.

             Linus

