Return-Path: <linux-kernel+bounces-224167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DCF911DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94C9B25635
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403D16DECA;
	Fri, 21 Jun 2024 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsAgSmpU"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B984A3B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956857; cv=none; b=e6iWwnyjhwWylTWhSTz5BNNImZCNVgRAm3YNkIylxJqWW3vZixmDrSptN21RFZ4U3NyAgiRfbqc2HkSrqRu752UFDXPLAr+li8vWe9XLrcLKVBq79ydhFDv0E1fHFTZhPdjiDymm+7GI95SCjBm91waiQx/9s6HpUJxGSD8OFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956857; c=relaxed/simple;
	bh=17ZElb9x600FIgJ3uSEvYNzmBsGbPPjBGxIz7EagCMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBHKNQvTFBs0DfEtLgoswpsiU09ebfmYtxIOcYxKHYj7/hpwCnxCHRPC17pMwD8K729XwywfRceleZlZLgFmT59khJ0TD3itB6SGoTe8ZPLtS0iVEaTWzoi4Mtti6V36EF+dZuBNiI4paQKdZ4qD3WAfvwp590E5+lbvacKsImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsAgSmpU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c70c08d98fso1468883a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718956855; x=1719561655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A10uLI/mw5BPIFxNPTyi9eTFLYJc1j4b8EnpD6ygN/E=;
        b=RsAgSmpUQ0Oubt06rzF/RZLhNmX3iepaCeBeOuAbGhGNpKmqR3U6VM/wMbZL2pYPt0
         3uE2kiR/XCZ5X7YzjLd2mJrg0POUEMXZAiTcaLZMoUdimCX1Kk6eIHiVoMeatiq+e7J0
         E1/KzfsyrvZyXobbvizmPSwjRHOb0DWTKIZtevB4PWz8o8gI9UMCZ1APWRL5WS38zmHp
         gq58IvstsQ2cB8UePK2qRAcbJwgPeAcMhz9yIV3QFXKRUs3JhRAZLBL3FvkE5AUsffU4
         1sCeMWvljWL4pemQH7qJcICm6ahFZXf1zxP5pDAX8YNgpQ41DrgnVZYnJv5sjgmWO2X2
         2M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718956855; x=1719561655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A10uLI/mw5BPIFxNPTyi9eTFLYJc1j4b8EnpD6ygN/E=;
        b=tx3uguEl5g7N9tvbNx2W7pvkkb/obX3MdVupfv8+HKDGKdmQcv6Km2H4srtCVkqlca
         n6H3n9enxUujJSisyy9cj0Jh4G0roeyOHpcaLupeoRMKVWfwhLBL0nHOYsLSDx8pJQzA
         XQ+qaBEDJgMZ5a3iWoJL74FPnxtxjPoW6NcfFAt9ERWH4wiWv/8nudU1m9mFTad/b9hy
         0IYyHsluHWWjFP2d/B2ZSzGASN8iVTR3DCyAvrwKA4gbD0s3K60Xnv3gPlQi0JXBk7uT
         EPRL3skZUmTnxROJnBzghVaZ3L1ppy5epH7UU1Dc7BtWd94EtaNxuZddrhwjIvMeXafr
         cfrA==
X-Forwarded-Encrypted: i=1; AJvYcCXTLMe/5zBDO/Oo1adQqf6AqhomFlZkB4mjDVtXgcIqT6N45zWSVTG6+G+T6wNNFeNALXXgSK/VkCu4gtY6V8Jd2Yygf+fEE/PydwNG
X-Gm-Message-State: AOJu0Yyxv7VkyLAd1GtexKpzGy/l07pRZZu8q6fPGyNJPJL0oOIx1RPB
	ygYB8T4GAwWQGfcBLPeU32IXMFrGgCwXB2vNniNLVlGv2GtczBjuiMFw/loDTYQeTQO9E6uDETJ
	Q1MH3rgXefkEoDjU/xfcw2bokx1c=
X-Google-Smtp-Source: AGHT+IGc68H9WcHj8y15EEUf6zY/mIOxdH/h8ZT3XcHAgoC0HxXPonbeX3d4GDnX62zQsLJSuwIM6Rj8VwETKjhkIgU=
X-Received: by 2002:a17:90a:77c8:b0:2c4:e772:a864 with SMTP id
 98e67ed59e1d1-2c7b5dc9e68mr7896458a91.40.1718956855165; Fri, 21 Jun 2024
 01:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621062617.595007-1-yi.sun@unisoc.com> <20240621062617.595007-2-yi.sun@unisoc.com>
In-Reply-To: <20240621062617.595007-2-yi.sun@unisoc.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Fri, 21 Jun 2024 16:00:43 +0800
Message-ID: <CAJhGHyASBtZ6pE3hUB=qB7qv3CQ=OAwarxNaQ=iojcFznfORpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] workqueue: add io priority to work_struct
To: Yi Sun <yi.sun@unisoc.com>
Cc: sunyibuaa@gmail.com, tj@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
	ebiggers@google.com, kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, niuzhiguo84@gmail.com, 
	Hao_hao.Wang@unisoc.com, yunlongxing23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

On Fri, Jun 21, 2024 at 2:27=E2=80=AFPM Yi Sun <yi.sun@unisoc.com> wrote:

> index 4c38824f3ab4..d9969596bbc3 100644
> --- a/include/linux/workqueue_types.h
> +++ b/include/linux/workqueue_types.h
> @@ -17,6 +17,12 @@ struct work_struct {
>         atomic_long_t data;
>         struct list_head entry;
>         work_func_t func;
> +       /* If the work does submit_bio, io priority may be needed. */
> +       unsigned short ioprio;
> +       /* Record kworker's original io priority. */
> +       unsigned short ori_ioprio;
> +       /* Whether the work has set io priority? */
> +       long ioprio_flag;

I don't see any ioprio code being integrated into workqueue in your
patchset, from which what you need might be:

struct ioprio_work {
       /******* the work item to be scheduled *******/
       struct work_struct work;

       /******* the stuff need for ioprio ******/

       /* If the work does submit_bio, io priority may be needed. */
       unsigned short ioprio;
       /* Record kworker's original io priority. */
       unsigned short ori_ioprio;
       /* Whether the work has set io priority? */
       long ioprio_flag;
}

And if ioprio needs to be integrated into workqueue, it should be attribute=
s
added to the workqueue itself as in the struct workqueue_attrs.

Thanks
Lai

