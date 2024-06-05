Return-Path: <linux-kernel+bounces-201973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899D8FC604
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA50B21EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F5849640;
	Wed,  5 Jun 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS4hrRpu"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485349634;
	Wed,  5 Jun 2024 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575476; cv=none; b=ftawZmBADdiBOi0QjBSdm3UBIWvhquVk5XvnjzdAkfKFjsmnyzWxtUduJWdcRR2uVDqCZ4hCuVifQdE8x0s5HQd8vjH45fJ9Fia3Jl9+jOUjahXIjPOWEw5qUXt8c/waFG4nA8eX8dGkbHjF+9eHuFAI19VEcbJixps4W94p3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575476; c=relaxed/simple;
	bh=1wdjcsi5xleRe7XanjwsWQ4TJLqfHy+eOuRnTIm772k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTWAXJHEUw1cJge6JvJBWzhLbZUEc2f5wfVRFueo18XVcKpTTzFRtt8WgySpqyBQNMTX0K57G/JZ27Ecw7LAiKSe2KzuHNbJfaIBYJYKC72Q+MlpHHTQTI4UoZYmpwMbjj/qbVmXmJ6M3WDlUn49PQPk13fjX1I9OdjAqD9fCDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS4hrRpu; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c1a4192d55so1535099a91.2;
        Wed, 05 Jun 2024 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717575474; x=1718180274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1wdjcsi5xleRe7XanjwsWQ4TJLqfHy+eOuRnTIm772k=;
        b=bS4hrRpuGAxAEw55xc4AmlOjSfjjpYdFeqpZ28b2NqM5WEPhuqArPU2Eyop0y/8oGI
         ILFthvtZgXM78/m3jBg/daXIeeI3w7J71uBj0TcVJouj9LEyRj8AuLTf/ZwgSTm8CV7r
         +ylNXufQnECZQsQ2C/v1p1++rSFsp+/TuL7D9HV7pKXTVHSNH860ZTOMrPRmNk4aTXo7
         9TQPwFe95U8GR1+JPwH6Ezb5wuRGJTAtXlliZOdIqDPuonr+zuURgshhcMkoSKZ9MGvk
         59iGkTWfuPuqaXZLZhaAwtMbZzz00DeEi/dy7b1B28ctnx6Uh4UcicDc1oLoESgodm6/
         GrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575474; x=1718180274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wdjcsi5xleRe7XanjwsWQ4TJLqfHy+eOuRnTIm772k=;
        b=hyowaw/3Uk/xhr00aUP3RKS4FN9PFsa6oE00+rACpbSg6kNa3tASoE77smOmZCXNX2
         XwkQtJtBQHIq5gjz3LDiSyQvMSLudhmGDccZ/1tUaov9vj5qKe6eYH7lDNbbPkZcNJtS
         q8CpO4y7u+CgQZ8MyOcBGCP748fewu9algpGMHDtwji0VHiwNPctlMKXrkcQlscMqTEC
         z0DNvlxBlpAeoi1MewhsO0LXWw+hPWZpkTJ0DPR6XFsgb5t5BRgktGYVa7GMbwZ18JM0
         CNGOsj1RhR1BZ4U+saLgDN8Y8Q9bOOiQnE/sgvzw+TWVTxYn9Gs/8RNDyguVvnb+LJFp
         Vq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHaWHvA+LCbCkRVhoidQmgnTQABlW2eaDq2C223p1MBjdQikJNj5LDrdRUmWWtJ3cnV++oM5IPxbLJmdbSAbhN3e6lGPaCD+bWG6BK7mGwIcHSh1RhoJFA3Ktn98QeRVCIclYz3KrBRNM=
X-Gm-Message-State: AOJu0Yy2s/H/BeNWF+Q9m0MPegS2KK13+lafT95AmL0feQYgFL5JGeiM
	i1bjUIoFjyJfTS1wzPyfHKICXumgba04vVaKh9hw55c+FWdrS46KUOf5zLW/KDBXXG+sr3+av++
	gbpWoopBnmwYdJH3qYpTwbn7eiII=
X-Google-Smtp-Source: AGHT+IF5rnwycoV3ChyFzp5X8uVGQNRRATu+t23uSYtVBEuKZlPG9wBAsfpHV+Aq+lH+0feC0OG1t1qZ7ZXypMaKk7Y=
X-Received: by 2002:a17:90a:c085:b0:2b8:f5f1:10d9 with SMTP id
 98e67ed59e1d1-2c27da22604mr2277848a91.0.1717575474188; Wed, 05 Jun 2024
 01:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604184752.697313-1-a1ba.omarov@gmail.com> <20240605101323.60d7abbc@booty>
In-Reply-To: <20240605101323.60d7abbc@booty>
From: Alibek Omarov <a1ba.omarov@gmail.com>
Date: Wed, 5 Jun 2024 11:17:42 +0300
Message-ID: <CAKyg=SV9HhMAU0cVDxvZjMx-KBc=2BTqgr1J4Wyx7z77vRTRhw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rockchip: i2s-tdm: Fix trcm mode by setting clock
 on right mclk
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> I cannot test right now, but it definitely looks correct.
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>

Thank you very much!

