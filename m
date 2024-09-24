Return-Path: <linux-kernel+bounces-337573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8099984BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C24281D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9035132120;
	Tue, 24 Sep 2024 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I9tL5Akg"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430512CDAE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207586; cv=none; b=HMEYA5ReZ0vXedmPpQlpTEMdNJ1UYLv7E2aTwLbMXJlfG8bi4kr3NaxT4jMfOgDFwCyHzfaGLh9phJe79krRvtxXG9nFd6D4Cz4E+OPzWbdKzcGoPp1ncz5tNBaLCuTP1aKZm3emi4GY3J/IhZ3IOzgr1h7PWsoMz0iijMw098Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207586; c=relaxed/simple;
	bh=KT8rvM77L2IbGpejE79KBgEP4qmqCVvvennzSDIi2pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NE9Ked130DOeFbYw1l+c8dy/DxtG25QsmsDH2VeCn0mvFefvtqyBk2/rXXWuCCLVVXto81L4m6BWvTF+Fm1JtBYY3bpNACL2QYsG3QYTf4Pa16z6AH2MjFzuJrs8Mc7fm0z+FTwrJxk1puAcvLX9cKvC6JYZ0A7p9THneLv9Scg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I9tL5Akg; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so59656421fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727207582; x=1727812382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=947KiTDRASLjIeg3socCB022+DS5zCO6A8y2gr+pDQw=;
        b=I9tL5AkgWWoxq/Y3LL0QUeJRmIWpKBCVfJHLnkyQOogIQHUtQcrJCOM+DKvzsY0Qdr
         Ukd03jfVpT8/0G+nK20uIn76EIdv0+kXutJpOfVejlvejK9IhOrFkWGTLxPGnUJ7tPCt
         /zYzP2ilp7fz+YLzajUN9idpRyJ3cRaobSz/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727207582; x=1727812382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=947KiTDRASLjIeg3socCB022+DS5zCO6A8y2gr+pDQw=;
        b=QlO+bZQWn4i2t2jfAWZNVJTuZ5fY9hGJUpOolC3HFx7sag4UFybIoZkx6FPG4xylzX
         EtoBFSNPTxULi4bdgdRpFfIV0rMRgTsiym0b0ZRgbQt8F2b9WMkpbCbhA4INeQr0xlH1
         VfdPy21rPEnIGAjK6hFPlZ6oHVzgs0j+SUaIB1k2JQ+ENYxaOCbTJoDc1+J+wVakEvOF
         bzONJ1mS5WALYiY8D5VEdaBXm8ida8knf8QWUmmPSSkNDWP0jIbbMRa1/mIrOHzAGtuS
         ChyRSkokbXYh91js1pmu2xMwrLgx6Rdo+clCbYzXUrmyGSDC3P7G5CTJ2HbFbS6BhFFF
         Cdcw==
X-Forwarded-Encrypted: i=1; AJvYcCXqId0FIcJdYN02HDdu3xuYkfRJQca1r0/ecG3ZSqiYbUPJwMorbOJAvRUaOXus2QsyfD0PxSFaaXMaOSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNXXOEzf05MV38yB1nTYBETzMhuRqEKzLAerw/mZG9ZDZt2RYe
	h9XL/IVGfnbUotsVWSjE5ek1MvsGpdC86c4T3DhsW9WcE/nKBA2vKE9iY97yJrJs3iPJDdPh6O/
	kZ2YASA==
X-Google-Smtp-Source: AGHT+IHam32MCRzipDCpaH3V5Qfl6lnoYnP4+NuI56P1X/FgA8MCphGOzWblqKU1JeZX1TIaU5+4WQ==
X-Received: by 2002:a05:651c:1993:b0:2f7:5a95:3a11 with SMTP id 38308e7fff4ca-2f915fcc4f0mr3453641fa.6.1727207582347;
        Tue, 24 Sep 2024 12:53:02 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d283bcfdsm3180821fa.36.2024.09.24.12.52.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 12:53:01 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53655b9bbcdso7120312e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:52:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfx9ewtCoIaJcAds1dUFiIHCtatYEYGHhcIgF5pYvWZnmigzhM7MMXNE+EgoeIHkoLK0dnqmreBpe2TCU=@vger.kernel.org
X-Received: by 2002:a05:6512:b92:b0:535:674a:2c18 with SMTP id
 2adb3069b0e04-53877530ef6mr121416e87.32.1727207579451; Tue, 24 Sep 2024
 12:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924044741.3078097-1-andersson@kernel.org> <CAHk-=wieXpmx=+gEuhQSEEZLyQHFLDk5=59j0OtOF==mQdVjYA@mail.gmail.com>
In-Reply-To: <CAHk-=wieXpmx=+gEuhQSEEZLyQHFLDk5=59j0OtOF==mQdVjYA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 12:52:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMBWsDkuQvZYfLj=rvQDnN4rdseS-LkR_VwD+xzvjjiA@mail.gmail.com>
Message-ID: <CAHk-=wgMBWsDkuQvZYfLj=rvQDnN4rdseS-LkR_VwD+xzvjjiA@mail.gmail.com>
Subject: Re: [GIT PULL] remoteproc updates for v6.12
To: Bjorn Andersson <andersson@kernel.org>, Martyn Welch <martyn.welch@collabora.com>, 
	Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Beleswar Padhi <b-padhi@ti.com>, Zhang Zekun <zhangzekun11@huawei.com>, 
	Naina Mehta <quic_nainmeht@quicinc.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Tanmay Shah <tanmay.shah@amd.com>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	Udit Kumar <u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 12:31, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's in my tree now, but please fix asap.

Argh, now that I noticed it, I can no longer unsee it.

So I did this

-       depends on ARCH_K3 || COMPILE_TEST
+       depends on ARCH_OMAP2PLUS || ARCH_K3

to the TI_K3_M4_REMOTEPROC entry so that it wouldn't try to select
OMAP2PLUS_MBOX in conditions where it isn't valid.

                Linus

