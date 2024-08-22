Return-Path: <linux-kernel+bounces-296896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3195B053
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B476B25060
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D246918132F;
	Thu, 22 Aug 2024 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SE4VuLCG"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8589179970
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315189; cv=none; b=pr3yeR412LuL7yeezW8J601crvlRP/AlMe5N6fiSjlX81xSBrF+HMUduWd0HhgAj8AxGv2CY98uC4RleCZT1q/ospdejptLWlvBztKjpd6Fg4LMO/SxRl9DjvWT/9m59/rdSivj5EkgndxWWnM5dnsVAuTnPiB1fSlYRIUJACWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315189; c=relaxed/simple;
	bh=uulRlCS5U/ZWFU+NiU8AQ4kmJJlakyTPxZ8IWIRFdfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ht2rHLcbyK0w9Z6v68FeXnLdLqx30RyV5VXq6/0O5ASwwVHKU5Mo0vjIB/jMl30y2Dwfy2/qPxW1WhNp4IAa99vfiElCCgCAhoScz8MGBSzjqEECS9hbb1FQ+wIlktPn1N5iLdom+X233VWPMUCb5aSkPlLHERACT5Jb6LQdZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=SE4VuLCG; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e13e11b23faso589679276.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724315187; x=1724919987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cwsQfABTNmfVMxMhs8Cv7JuAupm/w/QRfZU+NP8//FI=;
        b=SE4VuLCG3vYSGK3AFufI+ZdpgA+dyLdut48qYD0EnWNqq7Mx1TIbAbflb7urZAdt52
         AUkVAAfIZKOTHUOnRRUmFOvKXMdQll+dUyoRs8t+6wAfS4mNWhXCtr5xxCArzfi8VOeW
         xjeR3chfAYktnK7MiuDF2gk+Basw3UTJK6PN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315187; x=1724919987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwsQfABTNmfVMxMhs8Cv7JuAupm/w/QRfZU+NP8//FI=;
        b=fPeZ+ceLev42sNqFv/6419B4CJ0HT4j1ahtGnBwLPhHYOAEFan/YN9sriYxS0m7M9P
         PQHiWcsWbhEPKpkAWrJkXVx8Jcuwv4K29Jyru+B7n8H0FD84VcZtIB28gLqCm536ZEks
         e5SfNu6pFrMzjIJVlaPfrkXKfxME0K2zWVisaRB2529xSnzaV2RdEHyr6+ww6yx93RTk
         OFgznoEPLO1JBZDuMA7uOix5Ec3a4WmOQbu7QrssaiYrN4p9p14HWzvgX2IUKAeqMXUj
         jh1E5BObQFCBM67wkgnrXsm24YNEeP/fNN+QAH3eRXfG6PDTFUS8NkY31dDizTA4qVKC
         WGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUW91lSnuHU2nNnUU23XHL9Gmcb8yO/WcSn4vioq+vW+Ceqc/GNz/AzruxSyGE55M5X57zHodU3BAWHG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl64HUVwGvsK3HaNhxNiUCjSZZNhMtemm5/GNMZeEreEOYBcJ1
	vAnQkJgL4GUURMbXLxpxZtKRi2kQ/UAiQ0hf+I757f72Pi1jJaH3GJetowYWaU/6oUqiUd41ka7
	8Fv9wAdRQytecJqHwDSO6rHfcls66VVczCra2wQ==
X-Google-Smtp-Source: AGHT+IEGeV6ssKuZdYjsNaigszO4+1jA+aSMkpYZo0GKMQzwFCX6dopqvMlxWyEPuvgeOxSlwsVXnIdaylF3iUFAlg0=
X-Received: by 2002:a05:6902:1209:b0:e13:65c9:e994 with SMTP id
 3f1490d57ef6-e16664a4d7emr6455861276.41.1724315186841; Thu, 22 Aug 2024
 01:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com> <20240822012523.141846-6-vinicius.gomes@intel.com>
In-Reply-To: <20240822012523.141846-6-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 10:26:14 +0200
Message-ID: <CAJfpegtko6VtNpshGUzZixE0jqecwQR91xT=Q7W5sf6HPGVPeQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] overlayfs: Use ovl_override_creds_light()/revert_creds_light()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Convert to use ovl_override_creds_light()/revert_creds_light(), these
> functions assume that the critical section won't modify the usage
> counter of the credentials in question.
>
> In most overlayfs instances, the credentials lifetime is the duration

Why most instances?  AFAICS the creds have the same lifetime as the
overlayfs superblock.

Thanks,
Miklos

