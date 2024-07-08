Return-Path: <linux-kernel+bounces-244840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F34E592AA2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BE31F220CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BEE14D702;
	Mon,  8 Jul 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSTkVmkw"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D414A60C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468282; cv=none; b=JxK0DsNO49c4coQhhTknacs25vfahyRMiKxZzgV9oBfFJE6WffUCYqsZ68BMPy6K8CE5nWOtcd22Rm1k3TATDQfE4mfDatUaFuVFYoRNHt2dii54dK5sHES8KiQFF0Ocn4O5awBd1CTNaVkqiK1I8Wxn/08fYzsrxAqMX/4/9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468282; c=relaxed/simple;
	bh=8X9bK0XUzYMuIB1GdfKNqGafAd/FFfRUhMSqUretYa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHPnedzMrheetvQlktDciMAWwr6RsXbQWjXZdwIl0UTGzAhNVwy+lOX/P4+xwyr7q5gDMaYaDbFAVH9DQ0IMMwsTa+PZhLlIUWV58gmZCbYmLgM0hsVL1Rs+k2CIrtbLCMPVdxwUvFAmhvqNpEYmqDnrSS8h4iHpemzUov+9EQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cSTkVmkw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-71871d5e087so2999327a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720468280; x=1721073080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8X9bK0XUzYMuIB1GdfKNqGafAd/FFfRUhMSqUretYa8=;
        b=cSTkVmkwlqiPa7D43n2CxETa+xFYTAIlxsh5d47iyyxcHC02gQ6AtSUh/acBC7JabJ
         XNNesLhc6cLt8sGpIAfMYo8l9OqEiKNBSMbJE/fEGUmCIbg/VcI5b8a6Lb7cSvfHRQPD
         T3LTnG/jBz/MpDBWw9QbtEoZ+ZP70MVI1JtvCykNyYPxwL8g/ub42+4cv6vx7BHsk694
         pCZPwlKEOd48g6GlBCsz056T0o84zTPe8PjHweaw78Cu6xL6s3r1qvi3d+99hVN8JqLs
         EALZMJ4iYKA8wZ8sfJFpTm9IGKr8GiRsZ14ktmZPRrIDfyHKN1SVHzjAUPi7J/Md6avq
         Lrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720468280; x=1721073080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8X9bK0XUzYMuIB1GdfKNqGafAd/FFfRUhMSqUretYa8=;
        b=ZvRcHGHiUFopyrfbF+D7eQJekdVUxP3j0IlTw7DQkize0gncj0EwVVGlW+Iu1aLJf7
         yMUR6HrA6ZSJYvy7jJgVJZHgz9e6HXnvMx5pP8hCOZk11n1QUBVC+bdl8H/Zv47T+4Oh
         oivG2tA9pyRYeIW3LqOagNyktPbLOO5/SabHhcWDWQMj3r83T6HYxiDM9A0mFO35IBUz
         oFIgZ1Nf5IgRdNCMixJlRNoZpEC1V6xyF0qrwHdAw3/53SDewXnvj8pwYQFq2SgURKGK
         s+YLc3w1TUwMR3S/wOD2Mqy0Z1EukxYMw1IjlOTHydtjnNB5N0Usfe9NuMeJ+jQNSSAi
         c1xg==
X-Forwarded-Encrypted: i=1; AJvYcCX42Divgi54udROIyXHDWXh18o00kx0tBHUdJnObf08djw6Fds2eWmOmLxsN51TeFdpS3DruUBB/kwTE3/sAJAqd/gUihxXjVCNnzGY
X-Gm-Message-State: AOJu0Yyx6PTNiglce3k4EjRVCQTdIl59fVy8OVvN4F2ydXGSJs8l8HlQ
	20xZYbgBGWDR/iV3ABKAWObFDOzO4FHQ0cPHlC1qPKWPngXqPOJTouetZs/d/9wSlzA4QVuH1n9
	2bGkpjHbtK2ZA2h4HVjGaGf+6UPI9ylU3jBWbZw==
X-Google-Smtp-Source: AGHT+IGwK1fsuaerAwZ7Lfb5nwlt5kbLQoUQfH/PmZaRy3CJf5sSqawqyBE+y4GU5auXRGAihVauG7L4gNx6sxfnSF0=
X-Received: by 2002:a05:6a20:3d89:b0:1c0:e699:fa13 with SMTP id
 adf61e73a8af0-1c2984d8c30mr509029637.52.1720468280070; Mon, 08 Jul 2024
 12:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619031250.2936087-1-tj@kernel.org> <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org> <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org> <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
 <ZonzAdyd6zb2Sm06@slm.duckdns.org> <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>
 <Zowt7pVWFB-Of-me@slm.duckdns.org>
In-Reply-To: <Zowt7pVWFB-Of-me@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 8 Jul 2024 21:51:08 +0200
Message-ID: <CAKfTPtB=77c-RsJ23suNZVf7qByeGSjYQJbiEU4JpXU6DezNLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 20:20, Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Vincent.
>
> On Mon, Jul 08, 2024 at 08:37:06AM +0200, Vincent Guittot wrote:
> > I prefer to minimize (if not remove) sched_ext related calls in the
> > fair path so we can easily rework it if needed. And this will also
> > ensure that all fair task are cleanly removed when they are all
> > switched to sched_ext
>
> Unless we add a WARN_ON_ONCE, if it doesn't behave as expected, the end
> result will most likely be cpufreq sometimes picking a higher freq than
> requested, which won't be the easiest to notice. Would you be against adding
> WARN_ON_ONCE(scx_switched_all && !util) too?

A WARN_ON_ONCE to detect misbehavior would be ok

>
> Thanks.
>
> --
> tejun

