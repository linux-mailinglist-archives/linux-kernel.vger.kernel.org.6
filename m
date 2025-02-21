Return-Path: <linux-kernel+bounces-526677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E75A401EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D42E19C04CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F84253F11;
	Fri, 21 Feb 2025 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YmmD8SWc"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1E201110
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172540; cv=none; b=VLSoi8posebghonM4B9VwAMftRbRAL9nFB65rj13+esLweS3bYe267RtmNJC8IkdW2WOx7sRA27Jja/c5vbIdbzAW3nBM6vZ580nn85PH52ujN/JEqmdTr4qZjCfZygPsuPVhl8YiOV/LOJmj3FIxixAJahCrjfBqeRp5ZpX//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172540; c=relaxed/simple;
	bh=5RWvWfGb/6tM++brVT4P5h/GIgplYKYVaghjCdtVd1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beJ121VczN+/2Dt+Vd+ELRgXj9QflBG6jB0hg6gIQDVWaqNh/BG5uNEZI5ZPBLyDlpX3aVIcovsTTiXHh6hMnrE/t4pcUIDqx6j2J9gVBLagDXNuPtnUO1Rq0G+n7QE/dQ+8qm1VghryR9ZaVHjz/sl3ls7Y+4uPAyRGnb80LXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YmmD8SWc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7430e27b2so418883066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740172536; x=1740777336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LwDyl4qTU31EYFlp5dVtYKLArSitXPy3ISMIrVX8EG4=;
        b=YmmD8SWcjc3djRhOrA93tC/wqELfj9kxZDB7OgGaP/A8EXl3IYSzD4FKy019XA/mam
         7yBPS01COw94A63qkDn5YM1iaAHscFkjnn6ZxVUMz597cL6s2TzJuapcCB43GQOeYhTz
         PvyhnMEERpr+3URLG9Mq6taLSWFQcPpaq8SPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740172536; x=1740777336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwDyl4qTU31EYFlp5dVtYKLArSitXPy3ISMIrVX8EG4=;
        b=d527ct3XfRkUai8XNGSCH1p3+UMIUmexmQvHXbhacKB5XFw6Y1goQZAwQh8Yxi0H1o
         Sa1OVk2SaDI0enKDyWx4FzVySk2twmdUnYMw2E5BP/fwiAf7RKibuMp3CoGgXdf+QNf/
         rPNBqwudhSNLbbnARJf7Foo7x6al4BclwqvwbkIqU7/dJkhK8pmNykIKuuU38e9DOYEk
         BwSfLwnhDu7C3SC4kot7KJBAnrRdOjnSxWjCRAbEXEyQGb2qQzC5y6ePqHIpyiCHhmgA
         iAcEfnh7Hq8Oc/do9QRPsDFEtE2f7dzpcwsN8bNJSgt/tfXLDbvasRHiP7jTw7rDe0iW
         WZbA==
X-Forwarded-Encrypted: i=1; AJvYcCU/E1ZUgCCZ3cRfp06JnwyTuYMJReGSC0tNHkzKPRhU8zLj+KQg+FveP3et0Tk8SbDjHf/1gr2Fml0FXlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztiHj+g711JhB7MiKyELwe3vQvySwMo6K13zXrVBQBBckd+fpl
	KuagEPWId5SYmBzhoWwLJRQ6oMB/1NV5hKq+UH51I2Q28kTphpFwBIbNmhKRYNhMlU4NqRdxV41
	MLLU=
X-Gm-Gg: ASbGncuq3km0Wbq7dzHGo/hYf8tLszSqgO6+NTHLeSjwczBdYmLyRaqNDTVMpbaHqr0
	94RjYoJ4nm6Mdl3+urGsitA6eEoELah9gh7SRg3oJY9Pmh6p1x1PKaGYPkAhGmo+00gA+iSCRM1
	kE7SaMjJSQTqNGG8ObVSn9jKxWS2ISOnc6H2AtY8iWgJU7+nUrUogkbj/lozP+9OL9UQFqH701F
	Vvk+DgQ1j4+gQanq4lBrcFSWps/mQCT3jyymAdQudhVUVxvkFb70CysggM9sR2DRYYzNH9n8iLq
	ogAKyqr4xC+83g74tea0+jQHHfueUSDURsKQpMBvH9D6hks9XHAgUcazOroUtG4IIBMeXaI+cOj
	F
X-Google-Smtp-Source: AGHT+IGAp7PjUmk/VR/1VBF4183+GiKuLNf5VTWaV9f8n3WVUFhd3JpVP1ExDGsN4pUuqkfycNORuA==
X-Received: by 2002:a17:906:31cf:b0:ab6:ef33:402 with SMTP id a640c23a62f3a-abc0d9e4ef5mr417282166b.18.1740172535958;
        Fri, 21 Feb 2025 13:15:35 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c4407sm14348186a12.23.2025.02.21.13.15.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 13:15:34 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abadccdfe5aso440451466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:15:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXVdXwEeZVLISNCr17PT+MJZF5oO54Rq43nrGvvtDWgcB/q/IYRJlmxzOV27jo+MJCJ7c5a1xP0zelH3pI=@vger.kernel.org
X-Received: by 2002:a17:906:c148:b0:ab7:7cf7:9f7a with SMTP id
 a640c23a62f3a-abc0df592b6mr489239266b.53.1740172533587; Fri, 21 Feb 2025
 13:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tyHJiMrF8nxXe=mhn0i5N1v-7RHh2TZfoz8BoUBBnuxzw@mail.gmail.com>
In-Reply-To: <CAPM=9tyHJiMrF8nxXe=mhn0i5N1v-7RHh2TZfoz8BoUBBnuxzw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Feb 2025 13:15:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJYQwSMoor__B-8D71S8=Dn5BeAY6tOzSL4u3MEZrtcw@mail.gmail.com>
X-Gm-Features: AWEUYZnwpf68JgRFG_HmCCL32GS0Ch2KPkBiw_7IJ37MT9V30ylIZmtFeJqV1h8
Message-ID: <CAHk-=wiJYQwSMoor__B-8D71S8=Dn5BeAY6tOzSL4u3MEZrtcw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.14-rc4
To: Dave Airlie <airlied@gmail.com>
Cc: Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Side note: I think you do something while editing or
cutting-and-pasting that loses indentation.

I sometimes have to guess at what the intended grouping is.

In this case, notice the "More catalog fixes" entry for the msm driver.

I *think* it refers to all the following bullet points up until the
"Core/GPU" grouping, but that is literally nothing but an edumacated
guess.

So when you write (or copy) the description, can I ask you to not drop
indentation like this?

            Linus

On Fri, 21 Feb 2025 at 12:51, Dave Airlie <airlied@gmail.com> wrote:
>
> msm:
> - More catalog fixes:
> - to skip watchdog programming through top block if its not present
> - fix the setting of WB mask to ensure the WB input control is programmed
>   correctly through ping-pong
> - drop lm_pair for sm6150 as that chipset does not have any 3dmerge block
> - Fix the mode validation logic for DP/eDP to account for widebus (2ppc)
>   to allow high clock resolutions
> - Fix to disable dither during encoder disable as otherwise this was
>   causing kms_writeback failure due to resource sharing between
>   WB and DSI paths as DSI uses dither but WB does not
> - Fixes for virtual planes, namely to drop extraneous return and fix
>   uninitialized variables
> - Fix to avoid spill-over of DSC encoder block bits when programming
>   the bits-per-component
> - Fixes in the DSI PHY to protect against concurrent access of
>   PHY_CMN_CLK_CFG regs between clock and display drivers
> - Core/GPU:
> - Fix non-blocking fence wait incorrectly rounding up to 1 jiffy timeout
> - Only print GMU fw version once, instead of each time the GPU resumes

