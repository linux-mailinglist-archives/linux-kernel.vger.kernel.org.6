Return-Path: <linux-kernel+bounces-296906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4C895B06E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7DEB26267
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE656176FC5;
	Thu, 22 Aug 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="d6UcsoVa"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACE1386D8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315494; cv=none; b=niUk6kM9zXBpuYwyTwZ9sTWqKQGwErVKpwWr7uA+ZJYweF1V++PzsBj7kzgbTDkoo/6t6ezj8EUMFpVPkEqcgCznFsgCSRd6zOeLI90Fj3eCcRu+P2dB3AZfdgvEXA7cB9uSuHVrMCjJfBFenGgZ2YfpCir3cyZNmBvd17n0rdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315494; c=relaxed/simple;
	bh=qfO68ABr8YmkVT3Xwko9ThKTkCQPRAKkOQzFlC/guPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4A54gMXW90IiRt3hlZCyf8rFORGx1E5ZlzVwt2/n1QZfw+S26f2zboxZHeIWwxHtGx8nznupxaIjI7ceDknr2yieW2mK2mqV6K8F8IAE/n1OmdSt3U4Ju99C94EB6S4Bbhjm5YymBt1sUkKGeL6o81RS5QO+j+9Rc6zkGMWhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=d6UcsoVa; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e164caa76e4so504215276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724315490; x=1724920290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qfO68ABr8YmkVT3Xwko9ThKTkCQPRAKkOQzFlC/guPA=;
        b=d6UcsoVagWmOg4gMtyyrnX4ashxi+QonesqW/lWQrZQaJ3U/jyzdz1puaNu0MvuPao
         AyPTazPWZRwDP+l2FDG/+7q9R1SOHQRb2cwfvKTvBjKOM6QpK96ZK3Ac6UDuBNc8lPMo
         AM66VnB3EjJu02kpOv5CHM0TZ594YJAD8O/XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315490; x=1724920290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfO68ABr8YmkVT3Xwko9ThKTkCQPRAKkOQzFlC/guPA=;
        b=OsTyuGZ36on2Xph9iFzK7vNSud3CxG/Zpa7idWQlkUEQ2U3ZStFskYrXHgE0ExVXgm
         Ee3S1YrAqNA/pP0cL9WLftecza/hfPwqeH25SMD0nTdXJS1sVo6STXkmm74gqm3gPhiZ
         lEQgw77Yyo/kcLaqHWVB9yYSsFhsjncj5TT6LyciM+kHYDWV1HQz1tVEd0WKgiimOr10
         m7J5ULwKDdGj3AgACpRsrfDnTWnl7bRkDQ3NmX6LaN9DmFyHPH5sRP87eXF0oIadspBU
         abAJKZnaM6FVGSSobZPK9UwRPMNFvUp5vxtq3a0l9SOg/hPKKyhIgOqnVJRVrFTRhBZ5
         WWLg==
X-Forwarded-Encrypted: i=1; AJvYcCUcOhDzYsiyvq0w81JAG5O7vuQMpqc0Q9sfrBL1e6U2ZLod3Kz+q/SB5nckA+XBSS0ddAU6gk+RIEtC/G0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl1kwFSTl6iuhG5UGtTt6rdOlzaWRjlxlvVnFTHzgkP60OgOu5
	sEtUU+UyiiRZ/+vGeqaz49t/BUEAhOqpGOxyEeybDNSzIBWP80IW0t6K7aLpBh4OGBXXtNb7sTM
	NiPd+nF3ZazIfHgvQrlxxqHe37q+xYrRCKMayQw==
X-Google-Smtp-Source: AGHT+IFF9x0kcV4O4K6ZspVN57UUPh5M6n3DoRW/LKTTDP4y3eH/KtTeC1NTvVIbWLwiW99ntfIxagBPmHeZAstrCBQ=
X-Received: by 2002:a05:6902:250f:b0:e13:c8e7:5bd4 with SMTP id
 3f1490d57ef6-e166640f1famr6031982276.22.1724315490296; Thu, 22 Aug 2024
 01:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com> <20240822012523.141846-8-vinicius.gomes@intel.com>
In-Reply-To: <20240822012523.141846-8-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 10:31:18 +0200
Message-ID: <CAJfpegs5+2DadbB6tfwLD+DAFzqfOTi7bZMxJCoj_r5Tu7jcfw@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] fs/backing-file: Convert to cred_guard()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Replace the override_creds_light()/revert_creds_light() pairs of
> operations to cred_guard().

I'd note here, that in some cases the revert will happen later than
previously, but (hopefully) you have verified that in these cases it
won't make a difference.

Thanks,
Miklos

