Return-Path: <linux-kernel+bounces-432074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A71F79E4522
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62AFB470CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3EF1C3C10;
	Wed,  4 Dec 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VkZoTORc"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05C14287
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340825; cv=none; b=XyKF7lwRNyXwn9IVtUjmT1qLyCjVDt/7XP2zTpzN6MXxqXfrzA2Grk7DSXXQigTGyT3IsEZ49Pxfjbz2yKVmLknH83NQWcM0xhGj+D4WgZ/ca0/lW2OEkVrcTHzEDPk4iN3/L2rl1Qq/3Bv1OIvP7Zo3r6Bvy1ek9Bl5koD/dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340825; c=relaxed/simple;
	bh=b1Xpy6CD6aMD49xSm64SabOF+AaRJHNJEm1DcSmxM48=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biSqDP8F9ZFoFFgeiVqhGZYTE1hiLFjb9pu4pCfqZM9DWOVvP3Esk6ARb8rkjrkWMUnR7+HI0/Qry/vQAytJhEqBSMkzMCHYpIL2jAk4i7uY6t1PBkgYIhxBrQZcrdZn7JwN6sZGqBSOt6RRvuUTmVafHRJHmDMgRBbo3KMJ5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VkZoTORc; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so121060276.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733340823; x=1733945623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNJFJ6pRI65Hkx3S3msz6HnheriMpI4d7aUoNtf1ZHk=;
        b=VkZoTORcjOF/QO7o5Z/7eH11o2WV19FflQSxUGnrBjPp6cm9ifyJkM6OD1nF9LlbG2
         hEYp5cTQDP/ml/k/GHc7NFbVauLJgsfPFCKEHLFYCBxqUCIEZT5HYrRaa+XfwGKreIlT
         /kDm/2ydT93Tdo3JCdISCeGy0K3FeIqe7aEMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733340823; x=1733945623;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNJFJ6pRI65Hkx3S3msz6HnheriMpI4d7aUoNtf1ZHk=;
        b=Df/kjfmSO4SHZtfEh0WE9rE13E5SVGCvoKZWIGlto/RBzT7QKxY1NQDjhCwKlA8+gJ
         V1IQG/fCEyLfTdUpf3dynStkGN78uUQsw8WPbPPkCZ0cOqW/kZmLU1EHep7yb0idMyZw
         kKOTkuiLyIs62QUfgqSXwl+IU9aeu6I2JajbkN4dYhCmCU6VhxE/oltIFV4vgrNd/B5q
         soDmzECRh1mlfxKJAN8R61D2EjnDES2E3DyX2n+NLvFnqdV9aTyzp0ITXRyXGKPmhSTC
         lUtjqoUp2iTrqBPf97HDgHXAG2wlVXMeLWbrcsXMfLTi7zmkQoVSU5v8yEeQkhn9MWMW
         Y9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXCDIpVLQrwHtOtcxdovAwkjt6qN14I/63YnBJpjdZUkb2tmyWJHbsyD9TqFWz16p4W2TkvXdJVlFyc6I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTw/ejtulrGOiPU5wYHqKU9d1Y08b3Ttof1GAf1BmujjH8vzg
	QbQwO/TKk+7t95kVGi7HMDL8PkaPg4uKOI6m91Lni0fyn8Xn5WIyY5eop4MG3o02R1vJsGwwi2U
	BeNYiJX1S2W0PIdSBeuaEf2ax07anbtpidbIR
X-Gm-Gg: ASbGnctGNLMGdWlNe/mDuIIiv6uyzS1jqm4bc7SUaTgTXmY3SsX19Uu3RXp6RCzUz7S
	8yEyc8dGh+qBldyEgmYcmcN+YJUem3gpGYwhZ9CWeAA39VUzohbqlZvB9YXU=
X-Google-Smtp-Source: AGHT+IH3lQTfDvoVM5SgtnrmkWgM8tKtP2qmtpTk83iDRH4qhKbofq2v85Sk9lkW6T3GFBZuCLJYvwma2CMebDYV29Q=
X-Received: by 2002:a05:6902:726:b0:e39:8a36:5781 with SMTP id
 3f1490d57ef6-e39d39ee243mr6896832276.1.1733340823079; Wed, 04 Dec 2024
 11:33:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Dec 2024 14:33:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202412041839.pjv6awcS-lkp@intel.com>
References: <20241204000415.2404264-1-swboyd@chromium.org> <202412041839.pjv6awcS-lkp@intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 4 Dec 2024 14:33:42 -0500
Message-ID: <CAE-0n51ZnUnL9Ghc4VV=hH0ju+VNnq4HWj_xV5cOA-Q0B-Au5Q@mail.gmail.com>
Subject: Re: [PATCH] of: Hide of_default_bus_match_table[]
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting kernel test robot (2024-12-04 03:00:44)
> Hi Stephen,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on 40384c840ea1944d7c5a392e8975ed088ecf0b37]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Stephen-Boyd/of-Hide-of_default_bus_match_table/20241204-123701
> base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
> patch link:    https://lore.kernel.org/r/20241204000415.2404264-1-swboyd%40chromium.org
> patch subject: [PATCH] of: Hide of_default_bus_match_table[]
> config: sparc-allnoconfig (https://download.01.org/0day-ci/archive/20241204/202412041839.pjv6awcS-lkp@intel.com/config)
> compiler: sparc-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041839.pjv6awcS-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412041839.pjv6awcS-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/of/platform.c:27:34: warning: 'of_default_bus_match_table' defined but not used [-Wunused-const-variable=]
>       27 | static const struct of_device_id of_default_bus_match_table[] = {
>          |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~

I will move the array into the function that uses it then.

