Return-Path: <linux-kernel+bounces-262579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF82893C8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996CF1F22A29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800AF5FEE6;
	Thu, 25 Jul 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eL6p79dk"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3784207D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936679; cv=none; b=GyqFgNUykxS712ifOCcuvGPNrNTcbWg/tv8K3MJvpGnxe03kekoOzAtHIx1EoRxRTBP7Ce/5ab3EPvQ11ZE0+3Pn5ZRYWzby0Bdra0EGKeRfSNOB9Bokdn572Msld1tjVczoHJpuPqCZSLDqRqruAS/h43C8YEcCsVbGJIdliKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936679; c=relaxed/simple;
	bh=aBqBls9wVV0blKbvPQzDI5DoagTO6aoeGuyhrOnXOOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtNv2c4w0dC9QmuOUvqKjaW7XjmjVhF65Ja0xTXhCWVyFkxDVGpNXuwFzP7uZbs+WPP2uaaD8fgZgWO8sv3S+hfakbl/dO8snBJhu2c1UqiNel/3FKOCdrdqxCg+Rc3nnVJnlGaWuUZ10GNrjDdBBp/pgW1a8Beszmu16PJQpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eL6p79dk; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f6bd3a7bbdso571051e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721936677; x=1722541477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4iUXopDP6Wh0plwE1SwD0Ncn0XN49Aez3fic2VDamk=;
        b=eL6p79dkGS4oNdnj+W7SWTYnXx2HnR3v+MtM5sLfbmsk6x0JTn3ue2B8oEo90t+wbe
         sEtZTfrzrU34Khx6doG4TEPGjFC0vq9d3QE44yMI7KdG8tmWvBpwxgnZTDpZBsZ8Vzad
         WfR7NKjI6h8dVaMo9qRYO9WgiNeGKb+UXAgYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721936677; x=1722541477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4iUXopDP6Wh0plwE1SwD0Ncn0XN49Aez3fic2VDamk=;
        b=tcx1owrfu/KDSUhFZT6JdTHyCmPGm1tXx9gPa8393j78wXd5u53ipc2N1svCEGpwL5
         lC5bSGmFWMAUV9JsH/lvbmCgUBMmBmtUj8j+PX5o58mcP9s6HD7jexZoYUTIv+ck5UbX
         vNF37tbB8vumLzaKAyCUpQbRy5D8nJiAXqUtSPn/Q0g7hM/nqS0KL4mU6jhcUyEymyiZ
         m/HXHewpsGdOGh14EYX4ro52FP1EnkVEfpNkvzXzjfSqYM77gLy4c9SPG1Uqd9mJtXIV
         hdtV4OJ1ZxiTu1TJ4rIrX0vEjdG4+z/iSQFpoWjX/iBJi5U8+LOZBgS9qs50ZFbxCIib
         4VbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+W54/Jqc3h/5HnmZL82fJ9ATNaxOrQL2jrYF7qfdSHCjuqkVL8EVj+4sknix4KcpOBzP0qBpn4dHbB5onvsgl9cHnLSQcFBFzLslN
X-Gm-Message-State: AOJu0YzrcS68NyJ5tlIUOJ6fcfS0YMT/UmNxSyPwu252gR5L5VRAk1FG
	DnoM8G8cMV0cX2SGkqaLVyACF5oNKMHDWx8eFqRbVrFEgcGTd7wB6S5PUZR7aLk4bE0M7MCG5eZ
	zVb8=
X-Google-Smtp-Source: AGHT+IGmGJBkLnfZwxv13FopcC3X3+B72wpoiCLwRvh19sE+gIZD5mLT5YbKEng7Ptnf1h4la5geZw==
X-Received: by 2002:a05:6122:411a:b0:4f5:2960:6ca6 with SMTP id 71dfb90a1353d-4f6ca2a1831mr3922441e0c.2.1721936676906;
        Thu, 25 Jul 2024 12:44:36 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f6c86c687bsm291048e0c.30.2024.07.25.12.44.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 12:44:36 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f6b7250d6dso507989e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:44:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+vksqmoyOGCnfz3Iqet0i0O1no1GEciPPX4cgxiJkNaTxlleUNXHuyguMcX3x4aiNO5bHlTEnZZbkuhtKEm2oigcMJy7HC7X78m48
X-Received: by 2002:a05:6102:292c:b0:493:dee7:9b8e with SMTP id
 ada2fe7eead31-493dee79daamr2651186137.7.1721936676300; Thu, 25 Jul 2024
 12:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNATbZgv6JNzSXznOm47oNUXku430-taoK4iE1G0YcBy4Lw@mail.gmail.com>
 <CAHk-=wiF3yeWehcvqY-4X7WNb8n4yw_5t0H1CpEpKi7JMjaMfw@mail.gmail.com> <CAK7LNARi5S0u3DD6fhtm8KTT-Cmd5xyaYsOsM+FmT69mOcdfwQ@mail.gmail.com>
In-Reply-To: <CAK7LNARi5S0u3DD6fhtm8KTT-Cmd5xyaYsOsM+FmT69mOcdfwQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 12:44:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcLs_7SW14k6O2dM6F_C_KYgrgvL6yHW6w=H-a+o1Hcw@mail.gmail.com>
Message-ID: <CAHk-=wgcLs_7SW14k6O2dM6F_C_KYgrgvL6yHW6w=H-a+o1Hcw@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.11-rc1
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 12:30, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I deduplicated the code in a slightly different way.

Thanks, looks fine (from just a quick look at the patch),

           Linus

