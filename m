Return-Path: <linux-kernel+bounces-339635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F1098683E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB2C1C2154D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA19150994;
	Wed, 25 Sep 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJSmt1Q4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A122AE6C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299228; cv=none; b=t1q6nGh3qg77TsjlDu6liFkAVjNfaqnsK1iu3qS87R35Xgx4xsFTHVT94CgZXEdc4qhSobsW6NxvJ6LYoSi6/KnZkaW7yHFA2uTvWiP+RUPRqiWV8VdFKOirKdxZqAzQtKoyZqDPSbjQlaHRAlLThSd7RtJGQXxXTZ3pUvfjtO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299228; c=relaxed/simple;
	bh=Qhca8aXwASzA52qlSc2EwlB3ylWt+AImaIw3ntnxQ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z11Ow0Mp4K0iWyL8dS6emLiBLUgfcTfYT1hnPyc3QuMlvh9FG963n1Foa8ZMMHIPfatpuGGz3B7Xk+h6HvQdwqpLusWxyhwCG0qS+9j9vfn+dJZ1EO7Zboj9Tpo3QvFiPNuIk2j5EY1Xc8ihSCyY/p5CEXM7eYbKg+NS30KS/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UJSmt1Q4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-535be093a43so374148e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727299225; x=1727904025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5ikqskVacaiYlGqYTtdMd9WM+WdS9gWd86sHASES6xw=;
        b=UJSmt1Q43yXu4muKO9wHe7eLj4RdK/7t1a6cirVa8BHFcxa22ls8tBzJPZqlBd+MM2
         TbZc1cED52ZyuBCtGcF/vYFrEWe8juw2aYZOhKJtGlOeHm74EmnnhXOhfBo8QKNx9MZL
         rsTTNS0ugdnlzGRWWVMLV5hSy83VRJaunFaDB0XfVUvtDh2qSryxQjNfcOguVPmd+Mrb
         PRedmdQZvsqCuBGmL1Q7VMB6Rt8L/DaG/xsFw6M4Zi8lBDcHLoNaYDQkmXO9qTquxNa+
         uWGjgWdj25eumFfpGLwttijCtZOPR8PJOmc78g9SvHmqNFRre5ONr4+dx5Raq/wXUZjW
         LgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727299225; x=1727904025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ikqskVacaiYlGqYTtdMd9WM+WdS9gWd86sHASES6xw=;
        b=b2kbd3o3EJYPnvSWiXw/My3mOVj23IV0VZY+bS56HZdP2CKBdus3AL7nq6g+GgBTsM
         ddeVXN8I108bIgdyarPkKhlgBkJl87oRQ5nqKEz463iLqOkro1ClsH5TO3QPXE6oLSNj
         UuKSsIYz9cvp/500obeG9g7lKGsHu4kg/z4j4QS7okON/bkCYnHgQify50QuDpUgq1/t
         NoNAqIzn4mLA7E+dsM2kf1AKdPCnMq8zfIoNSseEW9gMbOBgTRH3Jdeg4/dsDVt+0utW
         h/YKz0tI6AOVVFPELv5AfFflwreC7bDRP1kcMWwzqGM6tkRLCAwqbzE3xsbDBHbIsLvO
         YgxA==
X-Forwarded-Encrypted: i=1; AJvYcCXeMjBJz9ugcgnIqRZCkKQp0ysd81ivD88+D5LbC13jMx9oj+l2DXeOv3eKVMjLywX/tgyZTFmCYCeKBic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Yz/7XxN5CJhm51hwXjy+1U+1m+o/PDTgz2/WwUMykXTBarIE
	cqa4j/TYLVsLdggUkNrUx+TfuX5UvMfKH97BI3PMj6HUcUhf3a9HpqGEKguutdU=
X-Google-Smtp-Source: AGHT+IFIwZzp5H6Akje3OgBbwgOTHgQxfddQGj0pEjO8YqbK94y5DOh3cQpldsUfZpC4ahcgtm8E8Q==
X-Received: by 2002:a05:6512:3083:b0:530:ea60:7e07 with SMTP id 2adb3069b0e04-53877568f5cmr2200879e87.58.1727299225256;
        Wed, 25 Sep 2024 14:20:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a864d56fsm616189e87.250.2024.09.25.14.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:20:24 -0700 (PDT)
Date: Thu, 26 Sep 2024 00:20:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, jthies@google.com, 
	pmalani@chromium.org, akuchynski@google.com, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] platform/chrome: cros_ec_typec: Thunderbolt support
Message-ID: <pl6xv55ohx3jprgc67umftjrwzlvass75d2pqzzdnktvt3njxh@gbujd5qf3tpz>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.7.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>
 <gqceveqpbvmiv3mg5cs3k3qd4rr6fpb3xksvxvdhkugr52paoj@olks6bqjc436>
 <CANFp7mX0=9qHb8_UotKjDo8rGemA7L+NGp3J+qSzBg_9Pp2CTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mX0=9qHb8_UotKjDo8rGemA7L+NGp3J+qSzBg_9Pp2CTw@mail.gmail.com>

On Wed, Sep 25, 2024 at 11:42:46AM GMT, Abhishek Pandit-Subedi wrote:
> On Wed, Sep 25, 2024 at 10:13 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, Sep 25, 2024 at 09:25:08AM GMT, Abhishek Pandit-Subedi wrote:
> > > Add support for entering and exiting Thunderbolt alt-mode using AP
> > > driven alt-mode.
> > >
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > ---
> > >
> > >  drivers/platform/chrome/Makefile              |   1 +
> > >  drivers/platform/chrome/cros_ec_typec.c       |  29 +--
> > >  drivers/platform/chrome/cros_typec_altmode.h  |  14 ++
> > >  .../platform/chrome/cros_typec_thunderbolt.c  | 184 ++++++++++++++++++
> > >  4 files changed, 216 insertions(+), 12 deletions(-)
> > >  create mode 100644 drivers/platform/chrome/cros_typec_thunderbolt.c
> >
> > This patch looks like nearly exact 1:1 copy of the previous one. Please
> > merge both altmode implementations in the same way as tcpm.c does.
> 
> It's easier for tcpm.c to have a merged implementation because it
> simply forwards VDMs to the internal state machine to handle without
> doing anything with them. Our implementation is closer to
> ucsi/displayport.c which needs to maintain an internal state machine
> for DP and TBT VDMs and respond differently.
> 
> I can merge the two but I'd like to understand intent (reduce code
> duplication? reduce the number of files?). As it is, keeping the files
> separate makes it easier to understand how each alt-mode operates in
> my opinion.

Separate common code and AltMode-specific code. This way we reduce a
risk of errors fixed in only one of two drivers and at the same time the
driver clearly separates common vs specific code paths (e.g. VDM
handling is mode-specific, while the rest of the code is common).

> 
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

