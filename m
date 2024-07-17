Return-Path: <linux-kernel+bounces-255591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD3934293
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFE91F23321
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A6183070;
	Wed, 17 Jul 2024 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z0ChWC12"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED512EAF9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244353; cv=none; b=D89djCU8kHrVWwZrWBRPU2kjuP6kwx6HCrdq1xBOcgwkrpDDhH4LjL+45qPwqV/o1lStYBXN90UiG+KS3LRc0CL5eXbJ0Msoc6uggyCK8HZX0vTYU14gFCPHrJMoPzCCxwM5DkXrmDmE3jmhrYf3xhJlzMZGII584b45qgJZQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244353; c=relaxed/simple;
	bh=X5I1Jca5JWMI8M85d8SM7CW/rneWZxNjiPERP/alBrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGnJDCbAnr3oK38g3O6/ZtLgzNBzopYAxHQqcLGtwVobYMc3Lk4xCc4KHfIn0zYCK9Ps/Upve6Gw1vkYt29SN4OHvR8FQIvEuqtwvhjq1joSpKJ51VdHRNtHvXGQUrPcY47FjRxAzrmCJ1Zdgxe2soFeyfChj9PQ+IKNkTQ/FJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z0ChWC12; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea2ce7abaso30715e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721244349; x=1721849149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WYGugfNX65ySLvjWZV3rRRf/smmfI9uMFFwL3s80P2k=;
        b=Z0ChWC12ynOWcgU80LbZ51jPIuK0iIPVcusI3Bxfsl0G43sXWXyZWt8GNli05zHhoT
         ZkNg0TdRukmLFv07Okg+xQoh1dYYQEh53vz4p5R/0iOIx/SDoCUpbqbJtX7dKqInew1C
         HIdRKJ4JQ87OMt22uBoz08FIwIEABN6sErPvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721244349; x=1721849149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYGugfNX65ySLvjWZV3rRRf/smmfI9uMFFwL3s80P2k=;
        b=v2QBbgy6IFwMUd9X0LKHjHAH5YQeoXUg+M+qnm6ZlYuaoct9nJgpaKuYI58BKpnaTd
         JUydRTIvi9qTg/64lpubhibJk4hlBJfAUNmHCYphDHnIeWMD2isxh/2Qm2QJjVwzaYNc
         Nt1Vr5OgfagnbWyrHca0vs5vQZp9AeQlWMoLbqYFGznVCb5Sgr+pT41jAqWv99HLYW1W
         DQa2yvUzctHMmMn4hJKHPNnTe2kwrb6kbX10mFc9Iu9IPr+PLj+wKi/AQe+fP5cfOMAO
         LRibbD+4C54nxCNLbgRbEOQvht1aO5HANrbWIesSO4ofcNPSoy+thP+oNcdzFdTfeOSj
         ySbA==
X-Forwarded-Encrypted: i=1; AJvYcCWH7k0X52VNWB/5Q/3NunQsA+XlXssVUxsW21qFyxeScSjFsTpiln2xCijWua3a42E4aRY6gtYJUnq53PB4yeWsoEu2bFYPi1Alxi5K
X-Gm-Message-State: AOJu0YyV9vFgw+UR61gPJGh019QgmU4OGh/lsGE7ibvG9g/UTN9wE5Lp
	e7mNbQPudZrauvdcK/MSlo1GjjYlGG95mhClP3QfCWt3WNQnExhuQALo8tJdCYNGgT7U2yETx/o
	CA3vDMQ==
X-Google-Smtp-Source: AGHT+IETxwieFzrBF0VR54uJ02JOo4WAMEz5jKXP2+zxqZbSn5G6PEO+MsZQxcWrLrM02JZSN+Ps/w==
X-Received: by 2002:a05:6512:690:b0:52c:e086:7953 with SMTP id 2adb3069b0e04-52ee539c939mr2274683e87.4.1721244349121;
        Wed, 17 Jul 2024 12:25:49 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed2532732sm1557544e87.220.2024.07.17.12.25.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 12:25:48 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eedeca1c79so723181fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:25:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU54pUTt/jWYbKnZt6PNUp/hBYqLlHU0sChv2wuvHHW9ApeT3eY2mccHjWG2QEHZ1VG8/OvPjfSXvByMwqbxQbdj5wzWM3RioEkfdoD
X-Received: by 2002:a2e:9ed3:0:b0:2ee:87e9:319d with SMTP id
 38308e7fff4ca-2ef05d48368mr2478791fa.48.1721244346888; Wed, 17 Jul 2024
 12:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715174757.876203-1-agruenba@redhat.com>
In-Reply-To: <20240715174757.876203-1-agruenba@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 12:25:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi68M2mAY82Ss264_++2q2x1fumXnjK2Lxt5LZoDHbr9A@mail.gmail.com>
Message-ID: <CAHk-=wi68M2mAY82Ss264_++2q2x1fumXnjK2Lxt5LZoDHbr9A@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 10:48, Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-rc1-fixes

Btw, your key has expired, and neither a "gpg --refresh" nor looking
it up on kernel.org seems to find a new expiration date.

Please update the key somewhere, and use *long* expiration dates. This
kind of noise is pointless.

              Linus

