Return-Path: <linux-kernel+bounces-534714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7324AA46A37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F256C3ACB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B314D236A7A;
	Wed, 26 Feb 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QWtINTwO"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B89236A62
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596053; cv=none; b=NlsLkOj1KRF7awznBzRzMYAjMGHN81JhYgsFLja04F3E/MxBVPInjV8M24CB8sx/wPtJs7TYaZfldCcrQfAExlvvlaM1/yFOxyxcS02bSgizVctVauYb7L4tXRqJHGt5Carq9BKXCstdVEC8BeT7JD9k9a+z3LVrgRDuYH8oVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596053; c=relaxed/simple;
	bh=1qlr8GJL2BB9n4kNH3+Dz6Pj/CYC0DiifTzkrZhOxhg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=gIT41PsPMY12K5amDsdAHpuO+d8yiYDelmzkiQ2hQs4w7sBUYsdvQiJY4Y8GyHA5/WqhTvqjyc/8on4u4Ux3ZOjQ5qy9Dkw56JrYWEXOnUgBeHDcahSWahHQXsQnFV9TWz/ZAgFk75MkAnKXFng/UKoeR8QdMovkfxs3/to9hMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QWtINTwO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6df83fd01cbso1088556d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740596049; x=1741200849; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoab8tVH1emRrehVBE7lcewSYOeTGxv6we7fWwNFkB0=;
        b=QWtINTwOX3ikRRvkYBUyzqSZaAT8IHmL1vvxh4uDLCAHTSdnFv8gMcxEnt1KPlGuz/
         OhkYa+bSue/vGxbhfhQ7cNWbe700tMIWgJ8QO788KybP+j/5X7vItjEwttAjy0i6lWpk
         QzLdEzNSQ+hiPGlKjVnwzvKylSSOHaKF4ZAr96eqc54IRDDh4T/T6qWtjke7fR8pMQjN
         Br/pbRBgaXdGZpiQyNl2d1TKDK2/Q+5Mn9dVXDeBml/acE9RCzqJF5sbY7r7JeWAZhNo
         Hiofa9iJ3W7Dn7a77BLXqsUTiGc1ZeWuPsRBvoAE5iK4fGKSopShjvn3Y+xdRbaJu/LJ
         bA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596049; x=1741200849;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hoab8tVH1emRrehVBE7lcewSYOeTGxv6we7fWwNFkB0=;
        b=kDWRRW3a7hs8obWd/lwUAFCnATIFBu5BIzhA25/7oX9trKMop5HgAf0648b63KoDhv
         FQO3kHJFt1iLkZDBoo2VApG4n5u7/UlOcswL4ZrSKFZ+AUCEdF/vBOkS5C1e5MGTYo69
         cD9S3rxDqggcLH2/OIuGyFwQtyadO0dE46Okm6gspNMzoU1DUmO2dsLuSeGQEdAtq64V
         JC5mYwul/TSYdBQ5ntWJgoOwzpe1t5aWlQAq3pXeQv4MIKKi9neiVAswmSGpmz/ViwDK
         n+vPjMDIg5sEhwNbCh8lMfWp12fGSpSQw1uDeVFKXV4bTcd8WQ6Nt2yNeU5j27za/yVQ
         guew==
X-Forwarded-Encrypted: i=1; AJvYcCVC59PPQhBSAf+LKR5/70KuCSaHPJYrBLeISh2/yO8wuTV+k9JMoJDIaj/vXveY0N8fELZJbdwFOhvCQUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZ/pMm04H9ZElz5WjD8Nn8DCFEz/ox37c0OfWv+T9P/ysESor
	FCs4RM7MM7GR0rJySt60PrX163PgRd3/fYd66iFA+yNmRIVHU3BZVGH5qXzceIjFIAC2dFjqop4
	=
X-Gm-Gg: ASbGncuankBcwUAlRQkwwoYL0JJ91c7wyJot8QMHLKi3sjv8X+J+U91QRomnbibymeq
	f+0gZlI2QJUVhLn44lwUjLIhTNXrG7R2oRDDyAamWuJniSPSvo2Oz4rWTu1GfQzuhWtCmSAZESW
	btGwO1XXCBE3qyUPvCp5yx0QuF6CIpuMMpxcQuugO5s97XuIKARN8OMIAqzh5mmakVN4q/dsJDX
	cj8R1Q4U0zIvgOhHaTW4gmdtY9fVsESM/biGWR6JGRKVTMp6jxQbWs2mSlwCdXo5vbYv10e+ibF
	rWgw7FJPPG2YjvOmQxiVskcQ2BGY6WT/YLoBt2MH9QjKSypRzBb8ewfQ3Mp7U/BqQ/rWrUs=
X-Google-Smtp-Source: AGHT+IHY/gHo5RS8nzj65pSBp8fkAoqDG1AiuqhWo7HfbKQRXOpF245m1711zOR2hDgAKQKomzvLAA==
X-Received: by 2002:a05:6214:19ee:b0:6e6:6c7f:111a with SMTP id 6a1803df08f44-6e88690302emr53863356d6.40.1740596048790;
        Wed, 26 Feb 2025 10:54:08 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e87b15406csm25877106d6.70.2025.02.26.10.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:54:08 -0800 (PST)
Date: Wed, 26 Feb 2025 13:54:07 -0500
Message-ID: <8fdd1a7b0714532aa2498c52f0461386@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Casey Schaufler <casey@schaufler-ca.com>, GUO Zihua <guozihua@huawei.com>, Canfeng Guo <guocanfeng@uniontech.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH RFC] selinux: support wildcard network interface names
References: <20241217135517.534645-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241217135517.534645-1-cgoettsche@seltendoof.de>

On Dec 17, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Add support for wildcard matching of network interface names.  This is
> useful for auto-generated interfaces, for example podman creates network
> interfaces for containers with the naming scheme podman0, podman1,
> podman2, ...
> 
> Since the wildcard characters '?' and '*' should be very uncommon in
> network interface names, and thus if netifcon definitions, avoid
> introducing a new policy version or capability.
> 
> Netifcon definitions are compared against in the order given by the
> policy, so userspace tools should sort them in a reasonable order.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h | 2 +-
>  security/selinux/ss/services.c      | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

My apologies on the delay in responding, overall I think is a nice
improvement, but I would feel a lot better if we wrapped this with a
policy capability so that users/admins that did run into a problem
would have a way to work around this using policy.

--
paul-moore.com

