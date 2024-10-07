Return-Path: <linux-kernel+bounces-353846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC699339C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE31C239DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B91DC75A;
	Mon,  7 Oct 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="ixZh1NFR"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4001DC737
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319073; cv=none; b=U6cYIBnDleq+F84brs8BOpByQgYPubUayGHK5uof3XzobmttRviX3HS+IANwp1G/u3n/4I7hT6+jiPYjLnGU31mXQ2iMqLmXFLbbfLxZuY3TVM++jNMs1+5NsLr9v+Np6zrd6RFH7T+4QiBDV75+WT2QLR7HBK2W69yy150/rxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319073; c=relaxed/simple;
	bh=0mzLrB2OomyLtoMgMpkUXKBQAaht79Vh1csmlF+3YCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6e46SyhcvNlaGCczajTelVUDlalD296CidQsW6PUal+UThQGHeF8lSEJlUUdoZXqLGkVBnGBoW2aGwIBNE3MrnsmLvn8+oKtuKwCBPChoj3XxgHIQ+V9cli4qtggp10kyjb/F3Pv44YcllgEnR1pHh+ep0tPZeg1/X9l7+RlL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=ixZh1NFR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a9a30a0490so452218385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1728319071; x=1728923871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W4CFFIJB0/w1KDKpJP7Na0Tu7Wo8uI2KSmr76xqMrKs=;
        b=ixZh1NFRp0ea8wKvo0Iw723PpYrfpp4mtK/OzwvBIh8Le09kGbxl7daPYLs2o8QFoS
         wSUWfXqMzptRJ01pUlxnUCUCv9s3FsAHV1NJ/i/saAe5+Lryqtc+1x+LJ8P1NVmrZ+sY
         dl5v8mB91IQH1826eVz8uywUfYs/39ZfktY7biGxOafcmXkl3ZR0pfWh007o8vWKA7zT
         sMRTkrPljOB0gifHCn1TH2yi3rYmwmPKz6NkUlMTi38nfw0v0LqaVW+H5OjFriY8X9Cj
         bRN3RnHPSTnTDcHqzNsNKUKQTCKHNaVLh291pN+hde75nmEh3pVp7wfG1HK58VAnRjoW
         Rrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319071; x=1728923871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4CFFIJB0/w1KDKpJP7Na0Tu7Wo8uI2KSmr76xqMrKs=;
        b=VXTFBmhYxnTMubbFNRzTbObuWjnj27ETGQtsKQB0TbAJweZQnfo+6OCsrRUPA0O7Kd
         L1rqzQuhjX4BNLsTKtCz4r+YUQVpJRSv5jvarJi9Up8yHSSVw4JmZ1YQVX2E6PXaWJLA
         vW+0L1b5cq0a1N6walzRNAAuqQfeMDY8ZeQ0OMeg/rHb1YHtFqIzIRy5CFIc5mLGE3Ji
         asF8gvOvYTux6+Djfplj9jnvjEOshZDG/d0NPqXeGX/sNBQXt/ourHWy6Lq8tvaR+EMr
         Ktv8n076i7886T5g3H87+3QfydrOsuUFM2gBbbBk+EfOI5gP5NCQAct5gln36K1Pg2oh
         1PDw==
X-Forwarded-Encrypted: i=1; AJvYcCW1/ii9yBKhjhRoqATPXfBgG3CXn0VugX9BvDpp+GjsR34rgG3nCPCaGggI3ElS4y0MQkqLVitByHxhr+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EFfhB9CZ9u9aeBgKjjHCL+2zqCPqa02XhijEn5Ph1OLhM+8W
	7btu7P3mX/GjUQlUrc0y3oi5slmNj9HLX6b9OC/FMqnAY5Buj5hOnobpKUq+XCMJS5Ujwr/NMTt
	utBRJc18982uYgMJPHrOFzvgOL8g+FmYFiKggMQ==
X-Google-Smtp-Source: AGHT+IFUEdp+6Zfk/3canOH8YLTeCDElWZbOWdFUC/AjiXkqb6tWoEUHRz5ImwY747H/eYo44KjaW8o6FN6Tmv1CB1Q=
X-Received: by 2002:a05:620a:1aa0:b0:7ac:b3bf:c30c with SMTP id
 af79cd13be357-7ae6f48ae1fmr1890545885a.45.1728319070658; Mon, 07 Oct 2024
 09:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004133126.2436930-1-vignesh.raman@collabora.com> <20241004133126.2436930-2-vignesh.raman@collabora.com>
In-Reply-To: <20241004133126.2436930-2-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 7 Oct 2024 12:37:39 -0400
Message-ID: <CAPj87rPGD8Pu_CSPXfRtsS_w8UYVJGR9CoLx7RAT69EUKefs3A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/ci: refactor software-driver stage jobs
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Fri, 4 Oct 2024 at 09:31, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> +.software-driver:
> +  stage: software-driver
> +  extends:
> +    - .test-gl
> +    - .test-rules
> +  timeout: "1h30m"
> +  tags:
> +    - kvm
> +  script:
> +    - ln -sf $CI_PROJECT_DIR/install /install
> +    - mv install/bzImage /lava-files/bzImage
> +    - mkdir -p /lib/modules
> +    - mkdir -p $CI_PROJECT_DIR/results
> +    - ln -sf $CI_PROJECT_DIR/results /results
> +    - install/crosvm-runner.sh install/igt_runner.sh

Instead of inlining this here, can we please move towards reusing more
of .gitlab-ci/common/init-stage[12].sh? If those files need to be
modified then that's totally fine, but I'd rather have something more
predictable, and fewer random pieces of shell in each job section.

