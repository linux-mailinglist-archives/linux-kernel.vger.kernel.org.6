Return-Path: <linux-kernel+bounces-553722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D2A58E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3CA188E71C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB8B223333;
	Mon, 10 Mar 2025 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="AOgb0VxU"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74B2153D6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595167; cv=none; b=UJuCMaXdH/xP72Cfu/GZlzS8tqYmMSTwur6pYxgvLnO0qDcxUSC4up9tPo1G45OXO0PXMwW1W5GWrP4KI53O0mUBEymEoYo7Xe9e0lITGCf4hwLJ39JbBYXb3CiDcZiLhj5Iwk/7rOtGQtQIQHp14f35e0UpmNWpFh4iOruSeEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595167; c=relaxed/simple;
	bh=JMhMysvxhTJmANY6/f7WSTiGZj4aUAJ9AjB+9OF4+FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL7Jp3ruekqXx9MLolDIDRMdzb0GY2dq9dRF2Hpn0szydl8n6CzfyHKXd0/ppLsxEu6AmwoR3pG6la8vhm5aC8Nr3+ItG3cPK/4GczV7ijqNrqlCiES2/PfQ6jKunqJ4kQUW0Kbf02dSLb+eKtsdxqAoncc6Wc2DAuh7pyvdezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=AOgb0VxU; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e41e18137bso26304926d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1741595165; x=1742199965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t5e4kBY1ikFpBdgk4CnQxT+0uhR76oE9dg26e5s+zOg=;
        b=AOgb0VxUo25bSUFfY7JMlJAi2SFeGK5SU24z2Yvrg+argGZ0qb1oAt+Ruq1tsI/uHf
         lcqCazIFx9WP4VpMhng4lz6x33d3OM23olEfbmPzAwvw39mezE9iBy5kuv2deXRXpZtu
         IkzDcskwQmDArXxJZHX1KOW9Dd24keNWc0otnIqozvjq58xLJAgJTckNZoJuR9D7/Pm8
         /9gt6XeiQZCzXi8eVf/Ra0MtPQKHo9Vyv/ENts0YDHdWndhU05wxzSOlyo0zKEi90qtC
         Sr0JMEuYfOaQps+KFk1XXHRigQO7AnmjGbzCnMtrSAUwc7o3m+hxhcotYChfT3Cd9kBz
         nQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595165; x=1742199965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5e4kBY1ikFpBdgk4CnQxT+0uhR76oE9dg26e5s+zOg=;
        b=iYquSITPXkgJ+qJDto0c02yLaodBFZnwDROsBE730Z6K2UY7N739BTuO4rLaGhwgid
         xh+5ZZHtPauNxkzzocrUm+gbL7S502hngDDbHb3UMI+VrDN+djyUOUQgiXmm21dxtr9i
         1fjoCOi2N5Gm6RXXEgIhGSaKO97ZXo0USfBX8G+ko7plpO2gaRuIpVwjtjbailFeYIgd
         YplcV0gi5SQf04DCf/0EeUDAXf7RutJNU9EzAdrEme5hNTs/tL4e7sH2huDpijOUKENV
         YdqvA/hVs/sIT8ROVk3tQW4bu5fJWWhMfiMDtjCDmnirkRk7KkAiM5EmyVaprUh2yCWy
         83gg==
X-Forwarded-Encrypted: i=1; AJvYcCW29mP61dRI6ENRODZmcAhqlA3uf0hXU0DKG3nEpIvzjsRYFHwHc814Zy6XU8aysA9IHRRrHi41KYlHrkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgV3MbZYGITv5ANf3XqmNhvw2ScGdSOk2U7O+jOkEegPBoKV23
	hY3wigaLK8/OL1Rc1FSP8cU9cXbi3dF8KrJYUCOYgi/GqGctTVBj4dWAavj2VgefZe8b+CNgDT7
	UvNzeg/+sZlfKrQRkyfSqPwKxQfXB+YIomMilrw==
X-Gm-Gg: ASbGncuz+aZegHlyLoLJ5+U6xMeolo6kgLmW4ZpWmILfrgFSdK+gDfl0oqI1Mg59eQa
	4AKBtfa/8DBuNA9bWnDd7uVuHnhUfDszgpzwMJmVK/wS1dcY8UMYDXvo7PMoTJGE9KFcu8VBymd
	HmAABmPF3egYFFABi1HcNK3KBVYlc=
X-Google-Smtp-Source: AGHT+IHwCbs1bBUI4qtOj3Idg/5ljrsF6Xs2ey8hGqNBmB9oD9+HRItkIzKnXGZD/eafOnoTRIZ/ohsJgV7HsJjpfmY=
X-Received: by 2002:a05:6214:2622:b0:6e6:6506:af59 with SMTP id
 6a1803df08f44-6e9005ea3cemr192846276d6.15.1741595164782; Mon, 10 Mar 2025
 01:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228151217.563807-1-vignesh.raman@collabora.com>
In-Reply-To: <20250228151217.563807-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 10 Mar 2025 08:25:53 +0000
X-Gm-Features: AQ5f1JphmWdQucNXKj1iZZodcb3VwzpHOG7exv-uOZ7CsZrfAS5vAY-cxnWQ6j4
Message-ID: <CAPj87rOT36e3TwZwk8uGUNpSz0kGB_XUY2gbCvGYYy2Xguqv5A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/ci: use shallow clone to avoid timeouts
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, dmitry.baryshkov@linaro.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	valentine.burley@collabora.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Fri, 28 Feb 2025 at 15:12, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> The python-artifacts job has a timeout of 10 minutes, which causes
> build failures as it was unable to clone the repository within the
> specified limits. Set GIT_DEPTH to 50 to speed up cloning and avoid
> build failures due to timeouts when fetching the full repository.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>
> v2:
>   - Set GIT_DEPTH to 50 to allow the check-patch job to pass

This sounds a bit fragile to me. Perhaps we need to make the
check-patch job instead specifically detect that it is missing history
and unshallow the history a bit more?

Cheers,
Daniel

