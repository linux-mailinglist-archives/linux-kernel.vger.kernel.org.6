Return-Path: <linux-kernel+bounces-412005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12569D023D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 07:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120A2B23D23
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EEA4962C;
	Sun, 17 Nov 2024 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVulAZPv"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447428F5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731825111; cv=none; b=ZCdLq4WwgHCcGzVE94tEze4CQY+AemllKmkJd1CPVd8/pjzzTAtmuLbAYqtAcNLbgr8bXHT7cQXhO0s841chBxQAtluKbVJMmS57P+eQng4+KIPwjvCZwXTyyGwbm7L0a+c1NPJkKXDTttjKGrfJqCCWEJ4KHGvYr1rOKpYFDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731825111; c=relaxed/simple;
	bh=yd2zwn0wlj+NbxenpRi9sMhG0mcKte7JQ3p9L9raCJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueEAf2GKdRyvVH4DkDN8XBQkBoXp35IYXdZpXL3ZVP+O4ysfww4mj+L/9cqzu/A6eGPldeRKwoA0Q8En7W8uWsqEASG3egfw9Pa3Xo5VxCHcGx3IYWzb6hMaS7I/13jJ4hQUqA6IflVbyJIDnZGeHN5iv6gyzd1smoQYXMUdJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVulAZPv; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d2d300718so305039e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 22:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731825109; x=1732429909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1KsO7fhbqBh+hX2RZRKwEK+dIR/PJ/dpnv1LOiA+CE=;
        b=FVulAZPvmImIALOBcYrIBXYnDHCjFqEfgOdysA9WqFPq9RqRuZqOvXSciUvbvwPJj9
         pipBjHPy5rn3Qi0IDDAIj+SlrPfFCtfdyqazOiichxmigyGODA/uFZMP4IR/rnkbef1A
         B9mDTxS6mB4vg/+d8nWk2oeHKyM+biDrExxG2lbSGOUK6d515EiHa7B7dlk8VAVVQgwW
         m/GrDVpv7bpxo0AmgrJD6I4Q41EH8+h8W18yxy0lorzc/0smzPISD9WecpjM9zYn/Orh
         QFyDBUpTMBju8BzbjVKEUMAS0WmdXlFOon86mPlPhtF/rqb3Qr2cU+iTcN4/DWVIw+oK
         qGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731825109; x=1732429909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1KsO7fhbqBh+hX2RZRKwEK+dIR/PJ/dpnv1LOiA+CE=;
        b=GI4NJ42P+8rf0enWvhnympNkugg3g/QH6dvTTf/8YxGE1EWpIJvGoMw/LxKtaKVRbL
         jBmezWvf1OQifU9CRlWek5+EpF9YUqgz/RH8J07I+FJpoK+zGbSp109xHsH5oNSWEqCM
         nHxyklt1K4ZJddXD069NLM+gvNFE5GP3Y4e2WracbxwHZfyE4L6Mqv/ejiDfzHRia93c
         jre3w1AwiZdDTtu3uLeckLeaWh8ujnD8mxfDhlWs1zYc6AuZls/W/mRcjQEIRPngFsu/
         iMG6GuyCJ3W/6zlsRzPr6nOPdCiUQn8UebG4eivvPCZonuBzFpnqnTEVS+hZFiyCtvsW
         sqDw==
X-Gm-Message-State: AOJu0YwBShaQCpG8klWlurZfyrhEv+koLjgIth0yOUUeC3UWtaVoNRSD
	iwzMcSYX8+XuTh8IPvlTMR7W7gAU5TGIaz9POsCy+PkElkMhMB6E+FZgVh6VCs0ec7DGcdC3Iom
	bJSIdYMHpJF6lCqYus7nKRdgnRXx5rFbqxUm2ow==
X-Google-Smtp-Source: AGHT+IE0wjqTMn8vWA+CUqA+H8uhTPOUX7xVAI/iXRb8BGy44kgJ/lwA3+K61804buL+g42069AriVPGWNBQWHsrA9g=
X-Received: by 2002:a05:6122:1696:b0:507:81f0:f952 with SMTP id
 71dfb90a1353d-51477f7c9e8mr6385384e0c.9.1731825109088; Sat, 16 Nov 2024
 22:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvVAvEBbFzhQQ_UBf+PYMojtN1O4qHKXngu33AT8HqEnA@mail.gmail.com>
 <61473df2-2ea2-4dc7-94a1-5e58ee02cd78@suse.cz>
In-Reply-To: <61473df2-2ea2-4dc7-94a1-5e58ee02cd78@suse.cz>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 17 Nov 2024 12:01:36 +0530
Message-ID: <CA+G9fYsLZeFtoA6-7CWpezAuCBMLq6jS-=XQMFKPHrypBP+KfA@mail.gmail.com>
Subject: Re: ltp-syscalls/ioctl04: sysfs: cannot create duplicate filename '/kernel/slab/:a-0000176'
To: Vlastimil Babka <vbabka@suse.cz>
Cc: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-ext4 <linux-ext4@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 02:25, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/16/24 17:50, Naresh Kamboju wrote:
> > The LTP syscalls ioctl04 and sequence test cases reported failures due
> > to following
> > reasons in the test log on the following environments on
> > sashal/linus-next.git tree.
> >  - qemu-x86_64
> >  - qemu-x86_64-compat
> >  - testing still in progress
> >
> > LTP test failed log:
> > ---------------
> > <4>[   70.931891] sysfs: cannot create duplicate filename
> > '/kernel/slab/:a-0000176'
> > ...
> > <0>[   70.969266] EXT4-fs: no memory for groupinfo slab cache
> > <3>[   70.970744] EXT4-fs (loop0): failed to initialize mballoc (-12)
> > <3>[   70.977680] EXT4-fs (loop0): mount failed
> > ioctl04.c:67: TFAIL: Mounting RO device RO failed: ENOMEM (12)
> >
> > First seen on commit sha id c12cd257292c0c29463aa305967e64fc31a514d8.
> >   Good: 7ff71d62bdc4828b0917c97eb6caebe5f4c07220
> >   Bad:  c12cd257292c0c29463aa305967e64fc31a514d8
> >   (not able to fetch these ^ commit ids now)
>
> The problem was in the slab tree not fs, sorry for the noise:
> https://lore.kernel.org/all/52be272d-009b-477b-9929-564f75208168%40suse.cz

The reported regressions have been fixed in latest commits on the
sashal/linus-next.git tree.

- Naresh

