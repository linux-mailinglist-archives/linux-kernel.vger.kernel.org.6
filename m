Return-Path: <linux-kernel+bounces-345403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81D98B5EB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B7B1F22480
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D581BD50A;
	Tue,  1 Oct 2024 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuWtBJo5"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F51BD009
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768499; cv=none; b=eoCYuu7icH+nayLxanZFRYf4DEf7zMdEEQSjOcZCvProkxcvbphGKKatMhxWqSl5unI5yAwpKfuV69YcnlbRVEVeN40DbDrsGOGXyFf+vsMHzUTFdU9bR6ZwVXbKkgUqp4GUBWZlI0d3pDLHciKLmYXtQOgaJQgyP3WDWGWOtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768499; c=relaxed/simple;
	bh=b0YzsZhvYXssxBMzqiFoT5LHPrufg6+4tnZIEdL5YLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEgzhYv/BVZdwTOZMQKP6CfZwaKVnJMtmRTmUuOwtkaKzYkxNNU4EFJUGG3Na2PVN/dqXyylmg2Hc3DUm/Xxp1SEXlf6hFjzCE/YUSz548AkmpOeTN5qN7RDTieny//Tr507Ka3ChfXWl66xov5Mupb1DMRU9yvXopeWgVrGbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuWtBJo5; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e1b6e8720dso2814916eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768497; x=1728373297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oHlEJnCwtC4GK/FLR1DihFu50Li6dMLU4mXd60RMGqA=;
        b=DuWtBJo5zvOXAXAT/zTRb47S9h9Gg3pL0u5xg9XPiHoosiatlv748E3i0IErzgtgE/
         04hA1X/hR7YV9n21mfmcK3BWMqKNESKjMf0wv2aVsZU34KXNzVRMh8NOwVyNCCigZAXv
         pB84zCLGVLWmjXyE9sBgJ5tUQJ/8gQkN4zRt/Afh/UmayG3MzCpKxeqYSM7jxViGBbOu
         P4mf6gUWbBamfMcmwUYAbCu4XALKb5Sy6PWB38ccC2p8RVhGd0uVbahOTEEOnSr1WvQr
         CjjEGFaui+DmJoDTp/PIeNjgG8Mr0waPfLncV9Y4Dwi/Q+hoIDSbN5yF2k+jb0eHd8ZP
         7n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768497; x=1728373297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHlEJnCwtC4GK/FLR1DihFu50Li6dMLU4mXd60RMGqA=;
        b=kZkpwFsA5fYpWLG8TLUQoGVmRfyHhZ9B9G6+5f00AW1UmvOMN0vnPszhmLTuNmTN/J
         GYnscp48zYDaQn4ZFpHi4rqBJ7/lCpWGVKaS1I4UU7P+t8TLeyP9r2p4EGcyWci+ZKfy
         cGQLeioTSYjrv/Pi6TfbV//XrrlO3YguxID5DdvBKXyuUvAMtEe+j47FUKs4tbL/9Yna
         XGX7h2Bqar3IQCsHoC/Z4/KcI/XxuWeJNUbk4xHqKZclOMR3QJm+6c6eBQWBglg+E/1Q
         L+iWWVUxf7MD5f0X6pQNcULdNvkE6ADH5EO1CFArpdLXfSdrpqKVpyMozt5tbfsjW0Q2
         n9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwohHmMxvqJ8DP9DAMNDS6xlhiVaUuXjGKgl8sANzRnxbHn5uLsqZ4eX+Pk8WSsEB8Md/sy3trFsGultk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBV+CSW8NSd/g3Mr/DbB7UF20ro5qOZIA/1Tz70eN8effjED6
	3xs1YlrlrfZlXhu1TuKO2EqQa7YM+GX6dCXVFgsxL6YHXNRrOcV0ShkxZePiDZ/j/ObXYSRKYca
	pvM1A/u5/8lvDcliOtXZKz9l78Ibw5m2kcCU=
X-Google-Smtp-Source: AGHT+IHtULieLwI/4SPEpV2EAh51zgTtQVq2eiZn2mnR0oWpvNiQi5cQqFGqhvDuXz6yt1UnDDzC0f1A/6EcRjj9PQQ=
X-Received: by 2002:a05:6870:3044:b0:27b:55e1:71e2 with SMTP id
 586e51a60fabf-28710ab1b40mr8144762fac.23.1727768496894; Tue, 01 Oct 2024
 00:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926075700.10122-1-shenlichuan@vivo.com>
In-Reply-To: <20240926075700.10122-1-shenlichuan@vivo.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 1 Oct 2024 09:41:25 +0200
Message-ID: <CAM9Jb+hCVEN_c1gLd8M0FUH+9i3vdmgCC4B-T7Lsy+XFejMsTw@mail.gmail.com>
Subject: Re: [PATCH v1] nvdimm: Correct some typos in comments
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	ira.weiny@intel.com, nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"

> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:
>
> -in the code comments:
> drivers/nvdimm/nd_virtio.c:100: repsonse ==> response
> drivers/nvdimm/pfn_devs.c:542: namepace ==> namespace
> drivers/nvdimm/pmem.c:319: reenable ==> re-enable
>
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>  drivers/nvdimm/nd_virtio.c | 2 +-
>  drivers/nvdimm/pfn_devs.c  | 2 +-
>  drivers/nvdimm/pmem.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index f55d60922b87..c3f07be4aa22 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -97,7 +97,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>                 dev_info(&vdev->dev, "failed to send command to virtio pmem device\n");
>                 err = -EIO;
>         } else {
> -               /* A host repsonse results in "host_ack" getting called */
> +               /* A host response results in "host_ack" getting called */
>                 wait_event(req_data->host_acked, req_data->done);
>                 err = le32_to_cpu(req_data->resp.ret);
>         }
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 586348125b61..cfdfe0eaa512 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -539,7 +539,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>
>         if (!nd_pfn->uuid) {
>                 /*
> -                * When probing a namepace via nd_pfn_probe() the uuid
> +                * When probing a namespace via nd_pfn_probe() the uuid
>                  * is NULL (see: nd_pfn_devinit()) we init settings from
>                  * pfn_sb
>                  */
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 210fb77f51ba..d81faa9d89c9 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -316,7 +316,7 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
>   * range, filesystem turns the normal pwrite to a dax_recovery_write.
>   *
>   * The recovery write consists of clearing media poison, clearing page
> - * HWPoison bit, reenable page-wide read-write permission, flush the
> + * HWPoison bit, re-enable page-wide read-write permission, flush the
>   * caches and finally write.  A competing pread thread will be held
>   * off during the recovery process since data read back might not be
>   * valid, and this is achieved by clearing the badblock records after
> --
> 2.17.1
>

