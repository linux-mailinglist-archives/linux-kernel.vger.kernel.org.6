Return-Path: <linux-kernel+bounces-534209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24A5A46426
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A097A7FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067FD222582;
	Wed, 26 Feb 2025 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="M8m6tuk8"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAE21D3FC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582578; cv=none; b=P6HHKIVotD7kJzzf4IodvPglmqT686g7TrDACayKCVtwOWjs7hfqhCkjWdcWK7sHdRqfxkoLaMy0dZUwkf14FGWwditgxnhLaEcuq/TOWttcu7AaNwGPb/AZovL5V3mmjFpDZnsAU3uPnwuv4sxujznMj+vACHb5LjnKRN3sZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582578; c=relaxed/simple;
	bh=ZrilHsSf4uozHG3QDObtiEewL5WQ28IzDxI5g784Khs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvjYih4ycNsoj4H/Cx8u/JMJ0ExzFuR1ePwLV4jMi/mSmZoZWEEl/EpTb/KMXptX/nXa3Wrt69GFwlhcy0XBjtnf/ZwIYk6w5O9KHJ7k9v3XLpos0b3bIVm4WVW27TYl9dHBq428RWdhSO6tJYItgCLLeP1sqVt3ZtsO2wlbx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=M8m6tuk8; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c09a30e14dso1114069485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1740582575; x=1741187375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrilHsSf4uozHG3QDObtiEewL5WQ28IzDxI5g784Khs=;
        b=M8m6tuk8fKyGZi7mPk2yPvvmui/c+R7JrQEDhWG3FtwGCMvXFdzmNkccG237o8p0bB
         CigEZ4G6PNT0NhP+pekVCOhIO6dgCF6hExYP2w/ITrZj2XrhPmdSK/5i6tMDyMHZXtTc
         ANHXF+hIdxHI4PM3hsUpDkFRx0oQZnsHzxeb020EkmaOR3kgJkriihYI0Dxvio3Gg9e7
         IfkEMBaSdXz+0dtujW0Na9qDliJun6GEVSsp8F+2Sfw6CojGXk+OY5fDCre6bbncWhsb
         qHHXeWLUUD0nPUscOXp06dKv831eZfTUZClplsjiTDkxmE+PAkrmA6cHqr3LKO/8RN7G
         DNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582575; x=1741187375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrilHsSf4uozHG3QDObtiEewL5WQ28IzDxI5g784Khs=;
        b=AH8qIx3iynFGHssd13QLdg6r0fqOMTjhmZA/irlpF8JVGDto32w/opOW4DcjsvS6+E
         VgxDruavqAEcT+Lavgn9Jn2GjTYQbM8ZK5Zx7x8SfmJqMwaDTld+o6KhkjH8bkHuUQTs
         jBeE4H4xO2JV5H0zkluxnrZb5uCnTGSZM46UwttwXbDygi3bMYmlJ+2tQWFpMkpjHChy
         beh302rqktTEY1S+2A0PNTCBzcSmYFNHw3ktGdoXVwdfumPwl6GtTkkMol1DFTaJxbOx
         udmd72XgerCWRsPoM2nxqUX+Yxc00sAbotvcV/eK7JL6ILKFKRtD9OFx6CnXOFFRDwh4
         uoSg==
X-Forwarded-Encrypted: i=1; AJvYcCVbUywk714/b+kMBXQtY9xKjo/xKLh2yrjDkj/SoKySPqV7XFq+glyNxJkz0bvH95yV2sfLik6JAUPj/wA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0T5XpFzt63eGjBIIk4hQuZ5DQMho3adCPTxYCjRGMULPvuws6
	JdOPZhsDKkk/xLXCwRs9Zb3B8wu6dLlEJ7Mm99muAy+0iEFqLebjbT2FB2zPLDjMKZRu05lcNTn
	V0myvfF2g6znhQ7I5ljcbX+lcLeIzEbxXXHjFnw==
X-Gm-Gg: ASbGnctqWVHe1y3GjKZdMz7bTgIxmyVHjU+xPimJ1ETO038sQ74TznwvEok/yW6Bkz9
	43BwOT8Dp03YuplnJwsipqSCPfb80yemH6vkDySL5BcdUE5j+lEMpT+i8zS9TbQu8srJ/EcvxR1
	GeUazG
X-Google-Smtp-Source: AGHT+IF/tg6cM8Vratykn7v7aPCgw8wtxyKpm/qbfk92lBpsgjX6Z9qRmt7KyODFfgOjzxshnTfEuqyZgNXJsi0PTAM=
X-Received: by 2002:a05:620a:458b:b0:7c0:bd67:7dd2 with SMTP id
 af79cd13be357-7c23c048738mr1144044385a.48.1740582575363; Wed, 26 Feb 2025
 07:09:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226-ci-python-timeout-v1-1-0a9092a3d6fb@linaro.org>
In-Reply-To: <20250226-ci-python-timeout-v1-1-0a9092a3d6fb@linaro.org>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 26 Feb 2025 15:09:23 +0000
X-Gm-Features: AWEUYZnbEiebiVjonXIF7OkUNZGFkCDHvC0BpPhmqST5ONMPQP479p20hC6Al-w
Message-ID: <CAPj87rOu-CSAvBmqrjp0oB8Y3yiTJJ5==i+OTHV=SO4CSEDLJA@mail.gmail.com>
Subject: Re: [PATCH] drm/ci: extend python-artifacts timeout
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Helen Koike <helen.koike@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Vignesh Raman <vignesh.raman@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 08:35, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> The job has a timeout of 10 minutes, which causes a build failures as it
> is even unable to clone the repo within the specified limits. Extend
> the job's timeout to 1 hour.

This is neither expected nor sensible. We should fix this some other way.

