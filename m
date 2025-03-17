Return-Path: <linux-kernel+bounces-565011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6339A65F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D6F189D782
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D301F4162;
	Mon, 17 Mar 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ENlSHbQM"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE71B4232
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242926; cv=none; b=DQAMnos5vFr6/qXTo14o386mwUJhbhf1pPbmP2McSsVZl7jfTrk9dWjI7od0YnL/e4DBlolwYFG5rjvGfNu8okDFYjc3vL+761zAhs110sJ+JrmzjuOnQm6MmHUJECgI+emeZeZG1Vt3MRVzjqdyTXRjtn3sE6bcHim+YXBcxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242926; c=relaxed/simple;
	bh=zceAdPhaSCTtexKuoLifqlAqvbet1WNBGfxs8S6cOUA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=GgNRCUWj4yH7MUQQ+AR/F2IcKWvQK4LqgLVKo8pYEsu5XX+QFIRK3l46ag/7S3bhZFcNYPO+Z6GQBXyjGU+fGRdqj7ILKV6MTCez1rGWmVsboBIT6+AMoFK9LStdeZpkqtkHZGVuHs1k4EfPvLyiJUx1pw58eLSFYIGosj9kiL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ENlSHbQM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476b89782c3so55778991cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742242924; x=1742847724; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3yVvtqTsXtaBa+O5aEAfJ2z57v1Ir49y6aZrwtTF5o=;
        b=ENlSHbQMmo4OQE/qtb6GwS6O/h2ftzbtyyBHsO5s/sJwGYcZz5KZV7VgQHBhpP+2zm
         rXxI7Wk9wl3Z3KczjmbpCMFbcqBHAjvVia1vULJwxTLlB+SaVn++N/7vcd3OZ4y23nXR
         DqM6ql+ouL7z2xwp6+gHswnLNF4QPJ8imaAUmlgFfaId0iWkPg3zdHIxyZqj9xy1NkNN
         hQgtSm2436a3EAteg/722MTAuVU4khEKGjJSRVn3gfKlSfsYdnogtYSEdca1BK1ZmyF4
         gjMAivZAtIs24AAjzfXQLgwpGLgbbxF+3OKzPPyB/FNivZBiDkne35AaZdbhEI26EAze
         chaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742242924; x=1742847724;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w3yVvtqTsXtaBa+O5aEAfJ2z57v1Ir49y6aZrwtTF5o=;
        b=PGdJ1SyUtzVMq3kblrN9/8rk+c58pQyQjLuwU2MHgEYDo2h69h/3ruFSuCVlX8PjOM
         MURR5MYqM+kO/IH86GrFlGMKeneDB25yjzKEdQZY5JYVUx/saA1IU2z6X8DwSbhVHMyI
         XCeFfToBBZsYQViJ1zy4sP9JCZ2ssywd45kvSlx4oakemoWm37Aru2Q/L8I5Q0Tq5rmw
         XkyIPvyopFQ0jUlCeHpV3QJpGeiqhLikJ8HmgHYXoknvH48fdRWUyMAY0TwbH9zgXdtL
         8563h2pdEwrbg25lbtY+Y6/2Vays065oWFARGfBbONjfgkpF3PAjbl+pwbh7MgSP5q4c
         qurQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoG0i2QmBKkCP8qzFkDI8TzIZ+o25Hw37GVDfaYPuyrHp1JEM3nJE9UnGABjyS+mzEfzxR9DosOORPFFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvjbeE7bsIexUi64cCpf2BYqTghNN/R8jKjCTuKjVEMc5vvmc
	lDN4KD6NWhbMrhP61OQySlExzdUJfEGbRsi26Yxf2S9EIvax+Ct0mD/UPQt/mA==
X-Gm-Gg: ASbGncuBhukrwEyd0cpQsr2OKQH2X43kXN0d4xmaBTJR+Uo2pl2DRuKqTkpowOENNcU
	dU+4Pqx2c+jNgCvGGH6KFEsiyoCE8vGLGhksg8zjLhqs2u6pbEfoieo19CwGUEYQUgc8TVCazk0
	6NTMUDePAWdsxKP4XuHvkjm81woadO+mUUH/vaaGxwavSlBolyF4wydgUsav5M9VuoXAk2jWz4u
	gX7jB/Mm2szdV/tlnm1iVL34yZ8k1+i6IZsnzi5q5PrgfL7KABo0HUp/QVDBkFNp3LV5iUwaccj
	Ytq66n2b5MT65gMBuqX9EzmFGOcgOGzkSqXHE12qFT+Mb+TWSp3aOGXHddb1uvWOTTP26fom2vg
	Y8yBP1xXSoJpBRrHGA0Rf2GKZ
X-Google-Smtp-Source: AGHT+IFqgRmBiB6XOIfe4MHqkwiowpZO3llF4b+bdu0iUKu4JEaIHtlLhk62/sn9MMeB8Sx4debo8A==
X-Received: by 2002:a05:622a:41ca:b0:472:5f9:1f78 with SMTP id d75a77b69052e-476c8130df3mr130149511cf.9.1742242924031;
        Mon, 17 Mar 2025 13:22:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb60a150sm58191861cf.7.2025.03.17.13.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:22:03 -0700 (PDT)
Date: Mon, 17 Mar 2025 16:22:03 -0400
Message-ID: <71ac186babee68dea38155b68d6a56e1@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250317_1618/pstg-lib:20250317_1551/pstg-pwork:20250317_1618
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, Mimi Zohar <zohar@linux.ibm.com>, GUO Zihua <guozihua@huawei.com>, Canfeng Guo <guocanfeng@uniontech.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: get netlabel_wildcard policycap from policy  instead of cache
References: <20250312080055.8950-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250312080055.8950-1-cgoettsche@seltendoof.de>

On Mar 12, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Retrieve the netlabel_wildcard policy capability in security_netif_sid()
> from the locked active policy instead of the cached value in
> selinux_state.
> 
> Fixes: 8af43b61c17e ("selinux: support wildcard network interface names")
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/services.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

As this is a fix for a commit in selinux/dev, I've gone ahead and merged
this into selinux/dev (with a /netlabel/netif/ tweak) to the commit
description.

Thanks everyone.

--
paul-moore.com

