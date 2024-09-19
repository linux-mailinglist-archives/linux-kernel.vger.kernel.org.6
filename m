Return-Path: <linux-kernel+bounces-333225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D90897C59F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551DF284927
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B0194C6F;
	Thu, 19 Sep 2024 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NyCVHHTf"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F801957F8
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733581; cv=none; b=AEQPL90gkpRYL+n7EqVao4uyfi+rDMGLLwMwag9ZyCB4rbnM8epvFkIm1UUKJydAZEjOW61S/WilVyK3pRPYLoGgfXo299rZzhvCprptBdvbhw3VZeSBGx8Vrw0yD43A/L5cwZya1Sv8wC3JXBiBNdLYVoD0LZeJ77rAEB5GH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733581; c=relaxed/simple;
	bh=8++AqMweBbkmqDHX9rOihZ8bcW016Ktg1n2544cUB/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTLGoG29ZdfZL+JK88DPIU93OYz0Gj8fBc1KUwCuYUvIS5xEitBwa+q1EP21BfDMxiIa1qvNjgK1C7qIwhw+vf3CHiw72anO7bf3Xyn030Gsmr5aDVmKLYM0HOc0Mr8YhqNNIJNX3ui8kX/0td5h2w0F4OI48oI3Y4KGa9jNxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NyCVHHTf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a81bd549eso62215866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726733577; x=1727338377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KjKbo64eBMjHdfY2ACi/vcyd2Cv3t2sINOQkVbosqlo=;
        b=NyCVHHTft56VUe/fZHV2hoMe4PfwE4LoNAX2XPXWYUBtOIXu9dBUg3TQE922ZJq7BR
         hLgv+SYTev0aip5PumDMMO5n27zvTI6vlNxZ87o9esOWeEy+TZztrr+ZYsAdtdf/OWXQ
         jM71a3OUERNEaLSFmcrdioO9iuMxummzYZTvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733577; x=1727338377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjKbo64eBMjHdfY2ACi/vcyd2Cv3t2sINOQkVbosqlo=;
        b=AkHoaEh9N7hiEd9rbLZSQ9Yc0ZnmP2IKDqVKeTgeIiDJvQbaiCwVbgUGnu0cz5ZI9E
         oAaUJAsfKR72GiZ1BliRThBw00inHWplEjVshFwAqUuvy0WV6nlhEupRvDd8kPgXa/th
         mQEJNUmQjuWMABsR5p0bqjc4bbon5b0IgUaqqpRcxlQu9CpqKbjfMx2poK4cioCKy5KX
         +GXBYyW2HpUFjFM5KTsWcWPZu5LJhhMliHAtRa0O0lywp2gE3Ybzf5xDhBv8nwBd9n5B
         lADnjzJySwag8yxO9n/cZYiitxpaW8zF93yb4wxeZo2lgbJ2MlauWJ2giYngvildQZeD
         W0jw==
X-Forwarded-Encrypted: i=1; AJvYcCU/adfUw62JIWmDvo1oDRAeEnK5F0k8HZ5DrowSDxrP8g1cSfH6WY432iL+62WwttUPC7NEil8YPP36GFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2UL36DBKWcRoZnJIWjjAaKrBY/0c5fG+HdHWsBQvq3qYO9GMS
	rtj5O1jS9TTiuHHosU/4yFeAXh/tm8hhdgJtzkJ7lehTiXW+PK/7j2/HaOghU+OTkjX7gJ1iKX2
	zffU3wg==
X-Google-Smtp-Source: AGHT+IGkACDD9t14RtU1lAl8/g3mvvAeDnUiWnCRfdGmbNhDU2kaVuPiDuivIP/jFR3oqPHf7xYL6Q==
X-Received: by 2002:a17:907:f185:b0:a8a:85af:7ae8 with SMTP id a640c23a62f3a-a90294aac0emr2425361866b.11.1726733577448;
        Thu, 19 Sep 2024 01:12:57 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df579sm687360466b.164.2024.09.19.01.12.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:12:56 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso752889a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:12:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEYdSYMYr18eLKquAX8pwm/pFzjE1EL+MgJiIQSULpov54Ko81/6BvYvVCKbC+YIl2l8AhKMarGrC74EA=@vger.kernel.org
X-Received: by 2002:a17:906:478a:b0:a8a:8c04:ce9f with SMTP id
 a640c23a62f3a-a90296eabbemr2749579766b.52.1726733576020; Thu, 19 Sep 2024
 01:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9txujwc-GoV6qB1DpKjbDi-8uDcJLnJFSY4OBgPu=ZAVBw@mail.gmail.com>
In-Reply-To: <CAPM=9txujwc-GoV6qB1DpKjbDi-8uDcJLnJFSY4OBgPu=ZAVBw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 10:12:39 +0200
X-Gmail-Original-Message-ID: <CAHk-=wiehYLXmbf8eZ080n7LEeS9=O5kEpGKjeP-01dj0EAYbA@mail.gmail.com>
Message-ID: <CAHk-=wiehYLXmbf8eZ080n7LEeS9=O5kEpGKjeP-01dj0EAYbA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.12-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 09:48, Dave Airlie <airlied@gmail.com> wrote:
>
> There are some minor conflicts with your tree but none seemed too
> difficult to solve, let me know if there is any problems on your end.

Christ. One of them is due to you guys being horrible at merging.

Your tree had

    drm/xe/gt: Remove double include

which removed (surprise surprise) a double instance of

  #include <generated/xe_wa_oob.h>

but then in merge commit 4461e9e5c374 ("Merge v6.11-rc5 into
drm-next") it got added back in!

Please be more careful with your merges. You can't just look at the
file contents, you have to look at the actual history of it to see
what the *cause* of the conflict is.

                    Linus

