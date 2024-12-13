Return-Path: <linux-kernel+bounces-445592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68E9F181B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA251636FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E34192D83;
	Fri, 13 Dec 2024 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dEOKJqTJ"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE535191F62
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734125741; cv=none; b=ZK1cfNOZnae9gcQ7R8i4AkfbcYcf89NxgryjdSyTysPwSPHDCgo1lTmXbIqLuK/keQsIeCkHT4eaSXHbLh5txdbOWELweACDOv94ii0t0QxAvglSGmXmBpoSfzZEq+GJeY3/fYdXVOvwpNRuzjU5BXgXv55kQHbiJKZRYsLsS98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734125741; c=relaxed/simple;
	bh=x3GHhDDz+w/e2kTp0CgeTu7Ox8Xxto17JSa17pTcRhE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=I9KjP2kUvOCe7BSDviOokQfydWjLxRyASSrnui01IFx7Y9t+JDO11cCWUsmpZlcM4jFzl2ZlNKD3xUiYtYOaVa779S7dyZFkJ1+ktU1pJGWzplbjGIZLUI1p/guUusZAV4NzdEPK3PGZ40HefnXKTYXt0ccuS09625lC7FDVoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dEOKJqTJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6f53c12adso142222885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734125737; x=1734730537; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFHmZqO8rwrFHWPgtsb6iToA/B4b/YAVHMgtPHT7prE=;
        b=dEOKJqTJ2bXaVkBjsAJwpnmXxrLrGGw5AJFRSPJ+wnJcPmO0Pjvj3DoI6mUQgAWzAQ
         IzoXyzo23IsUYdkHA2vIgcyrZWArGXMU/AzSnD/xwLxTDyYMpDvuDjqu5T7eIZm5+iLH
         1NFwxtObE5qsSaCPjECFgWxeVN1WZ4WxMUzvfhPwSzZYCIrD9iKWU+FjmLBMnbp8WxaQ
         r3urnAwldzpAF746ozEmWMTUW7xBS95pzFTC1755KXCsc30AlcRSuP9OzNqbCEbGvh6X
         ux8ZRaw5DVH0RVa3n/etlhjKY8kgg1OC4/Z1U6ltA41uQ48n6BURI8UJnIbmXRQaGGak
         7v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125737; x=1734730537;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HFHmZqO8rwrFHWPgtsb6iToA/B4b/YAVHMgtPHT7prE=;
        b=k8OB6zZzFUyIs9SlzazF7kULuCq32c/DQ7Bv7STtJwEGkmFWGXyZB6ZFvV2MJ/Nehe
         2l2XQZ3DziNomPQ5KG4Gh5Pngy/U/q9pHQX6GnQ+eUO8IVXn9A9IWcvzpcuPw/LLDRZ2
         9K7o7ozoLoWfmI++sg3FNIZ0MJWf6Jk/yv6noolDFyluyT7OhbHj0dRkW2VhVaFoBD5q
         9Bk4niy22oPj8pWEm2TDBQC6hsAAorYYEOd82LafeeOQ2pGM0+qtdqYozVCeQhkSqVvA
         vGipw7KmGEySSY6tUS/mz2ATvJ65k69zr0W37WeNqynrYeD4J70lnzEMu95T+2VHNKAC
         s+jA==
X-Forwarded-Encrypted: i=1; AJvYcCXtCgQa3ApUrkZZ8cyGW4hN0WXRaMq1diCTzFmPGj4tzzEIFpPgWeIy/SCc6fMJjGpBqsil9c4cvkwkVfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcbbAvtSODEPwZ1Xs+6OsFf/4U+VPqKWs0nJ+qMkSsQ7QG8iX4
	iF3YyHsAr4PUAOgc/c5n2z/fxZTuswihizWJcGVno6mS+KwH1oK+YtVDK+m9NA==
X-Gm-Gg: ASbGncsuxxNHTNotTBJjTE9caowJuSiRNen6vXj7W9VzxulxtmmwYBx6vplIqJi+41o
	SZ3MqEo5xEZBu+6SNjRgtIXmueWLPAT2gBXu28bxMFoGU+6KeY2LtnrpcT14a/KHOTfsPgs7t0p
	0CRNzfNO1zTGA6t/6+KHdgrWImxfa5MDmcqgMhflmOMhwpvsEIhtFdvRGHBvPqR8BTeY3X4epc7
	QjmR38MTHUGCCG05NO+a5EFTFRB22Vvb4jH3Eii94t+PhC5Poo=
X-Google-Smtp-Source: AGHT+IG+fLiThWzfd2vnNSoUStixEM3TTG2o3/E9Its8SqN9dsLcqFmi2iUwPpvSIVoZOiYVmfrKAA==
X-Received: by 2002:a05:620a:414a:b0:7b3:577b:6d9c with SMTP id af79cd13be357-7b6fbf42174mr600237685a.38.1734125737584;
        Fri, 13 Dec 2024 13:35:37 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048bbef7sm16364285a.90.2024.12.13.13.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:35:37 -0800 (PST)
Date: Fri, 13 Dec 2024 16:35:36 -0500
Message-ID: <dd43826c8fb600f967196c72958fc6e5@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241213_1548/pstg-lib:20241213_1547/pstg-pwork:20241213_1548
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Jacob Satterfield <jsatterfield.linux@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selinux: add support for xperms in conditional policies
References: <20241023152719.24118-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241023152719.24118-1-cgoettsche@seltendoof.de>

On Oct 23, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Add support for extended permission rules in conditional policies.
> Currently the kernel accepts such rules already, but evaluating a
> security decision will hit a BUG() in
> services_compute_xperms_decision().  Thus reject extended permission
> rules in conditional policies for current policy versions.
> 
> Add a new policy version for this feature.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>   rebased onto the netlink xperm patch
> ---
>  security/selinux/include/security.h |  3 ++-
>  security/selinux/ss/avtab.c         | 11 +++++++++--
>  security/selinux/ss/avtab.h         |  2 +-
>  security/selinux/ss/conditional.c   |  2 +-
>  security/selinux/ss/policydb.c      |  5 +++++
>  security/selinux/ss/services.c      | 12 ++++++++----
>  6 files changed, 26 insertions(+), 9 deletions(-)

Merged into selinux/dev, thanks for working on this and your patience!

--
paul-moore.com

