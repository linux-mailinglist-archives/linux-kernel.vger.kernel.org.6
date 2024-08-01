Return-Path: <linux-kernel+bounces-271589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AA7945067
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46161C23EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCCA1B3742;
	Thu,  1 Aug 2024 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2thyFqR8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282613D89B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529321; cv=none; b=qrp3yL8lcoVWSfbmEULO8ToxWTtCd4n8xjuLUZuUw+mL8AzZXeDABS4RWQm+Oy4vrKtvukuS/mkCFkSaR24/Q3G4Aht4CFmkGiNJxihgOLuwu20bp10bVpmd1c93d0M4+hfwpH1Ho79q9Xcbh68zEG1Tc/y0EF02jcBWNcQkOek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529321; c=relaxed/simple;
	bh=234uavgHIBFyCN/c3aq8AyX9eSQ+Tq3G5JptozUJhEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhRB4jsowtFePzSgTpmna2hZkZ36P/OLvIQ6s4Z322hVl8caVoK5CVkGXw7oEWAzviUUfPeadX0PIOw8eCBa7ipijbixTGTjXzrVSUKC5GUnm7giv8G4jXo6RLMCW8BJHggozI6cMGlltq6hcE8tABhf4fBtLJAHL6ynRovY1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2thyFqR8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7104f93a20eso1806520b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1722529319; x=1723134119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXAPbL+AnsZVkiuzy6vBy30+2S6eouEGeQuwM0uU4k0=;
        b=2thyFqR8nx/1pCgwzSKhD/U+pPjLtOq4FK0JpufGnb0w9wPEElLRt4vyZftIDUQf5t
         5NHQ2nNbw2BLb+rGJK3qPETKLJjvQd0e6lCiSTfgHCYjrUOITuj9EXZAuM/beJfnDcLZ
         GMdfO2tNynqZ+0ZR2ZloeyDPAQ9hzY6yxWuGVaNpNqtD1Bfo+0nSlJvGJPbKcPNekhgp
         Z0YU0ejf4H1E2L/7/JRg+5mS6IRo+rLGZUsC60BUcWb70pvd9xQz+7xkzZofB1BaHXm5
         cRPiESPTRN9fbIANv2cJLgd5b/im/JfNjCeGPaJ010670vYXbEqBmbFss4dOy4Z/mP9L
         fAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529319; x=1723134119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXAPbL+AnsZVkiuzy6vBy30+2S6eouEGeQuwM0uU4k0=;
        b=UcklCR4bpD1c4t64gRn/6H38uqV6CTi35RoX5BoVATICQbyI/ryFYveN9ait8IBTxS
         m3GLOxgSkbAjcI+wrQxmOGOmHahMb646E8cBwJMpj5yRZC0tEkoQaXSLBYAOkT9y1r77
         K8NPGqRg3dESwvmuim3A5yf8wb7ig+u6830rl5mBmiqLprS4XbJNrjXGvHm0v1iMLmjf
         ik6EM8Llckl518AQ0O+JMLkbw/tgt+7EOBAAsVOW4Vg1bvL9nYgVE/v0kYiv34/JgrAo
         VJoSoIxuJAE+4xGts2nmntqeJ73gAlFxQYHSlDT8/zEYd2O+Byxp//ApKvA2wO//cL/f
         JsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbx015Vj8cT+x6ZJxxY9PFdG9Oz2VRR3y2TghoI10p0repLDi++IqcwmiKmjBnWglOiL/K0XNGsf33ymaVeL71KA/nqBg0KplTY8S8
X-Gm-Message-State: AOJu0YzR9Q/GYQddA8fpsljP/lK+zyt0wWatdTtPGe8fVORoq2efZc3d
	7mnmJRWUyBW/qZJVWIx+25jFJe1vLoqLP4cPlKTaDvhYQqLgFJzkIdmnB0Wtf6I=
X-Google-Smtp-Source: AGHT+IGDF+njCgVG1PqRcQFFypdiRI9KB6NqMDbVC90mVeAOQyHBQunQ4jrU2o13qdOxvhaoggbzEA==
X-Received: by 2002:a05:6a00:91a6:b0:706:5cd9:655d with SMTP id d2e1a72fcca58-7106d04749fmr878998b3a.22.1722529318747;
        Thu, 01 Aug 2024 09:21:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec400e4sm21445b3a.62.2024.08.01.09.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:21:58 -0700 (PDT)
Date: Thu, 1 Aug 2024 09:21:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thevlad@fb.com, thepacketgeek@gmail.com,
 riel@surriel.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulmck@kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 6/6] net: netconsole: Defer netpoll cleanup to
 avoid lock release during list traversal
Message-ID: <20240801092156.2bb27a27@hermes.local>
In-Reply-To: <20240801161213.2707132-7-leitao@debian.org>
References: <20240801161213.2707132-1-leitao@debian.org>
	<20240801161213.2707132-7-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 09:12:03 -0700
Breno Leitao <leitao@debian.org> wrote:

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index eb9799edb95b..dd984ee4a564 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -37,6 +37,7 @@
>  #include <linux/configfs.h>
>  #include <linux/etherdevice.h>
>  #include <linux/utsname.h>
> +#include <linux/rtnetlink.h>
>  
>  MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");

Should the Maintainer part be removed from the AUTHOR string by now?

