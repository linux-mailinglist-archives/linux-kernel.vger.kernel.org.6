Return-Path: <linux-kernel+bounces-535148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7582A46F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BE33AF476
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA2B2620EA;
	Wed, 26 Feb 2025 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f74K/K/a"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6172620D9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613310; cv=none; b=kdaUEAiJH+OT5fhbrI78N2iKWsLVCI6z/5EYJHUUscsg7i5x+3w9qUXns35EMsqC/lVGw53BNFVuGf5dvJk+T06OtIqq0C/mBndTa64ZXns6KWrHdKuNtLg/wDH19HmWgbsBKz7j0VwFfwZrP5XXRyCPDsBLtRAkVKNBtVg5hKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613310; c=relaxed/simple;
	bh=JQDAukDOA1SXdHWfiWnXuv4Qp+qpUTG+aOURb/RFTMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laJViOtxmUks7B82zw3/+KaNJHCHcngkrRss3E27up1JIRJmjGF47rLC3/J827B3KCG7+4JwaCDi8/uuPG87+nbSnStvBagwP6aHMT/eKR6P+8n/ezxgAT7QLAxkyxd7JeM5yoVhLzGD98Ere5TVdaeDzwWMgANXFpKzT9Fge4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f74K/K/a; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fb7d64908fso3715447b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740613307; x=1741218107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQDAukDOA1SXdHWfiWnXuv4Qp+qpUTG+aOURb/RFTMg=;
        b=f74K/K/afzWjWvWsdHxzN/jH61xJHHyuPbfUP001y7a/mX6nUiQ6DZSUR4rQzkAFCx
         uOFAYRBDM75LJJ3tEtVTkKT7Pfyamp4QYiJxQoBN7PAuBLpEFKsB4bsCIFSC+EyqITA4
         MSFowOZhYMXT6smdUYfJrBJNAGtzWPePtqkaV+TeW+JQV8A86bZ4NvxrgQQwmhygBwVc
         4AyCxHkuezll/ele/Euj7pr1pPIBuQgLCodPj+v2Il0IkiTCMNdfBwh8YYMXpiUuZsUg
         jNsMH1mqRG2FYKB9txR+/jBVrF4PiuwCG7NFcaxSBTrxjJCbTAetHKMw2dcEExoHNhUR
         hHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740613307; x=1741218107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQDAukDOA1SXdHWfiWnXuv4Qp+qpUTG+aOURb/RFTMg=;
        b=n50mgObZRx5AOmD/arMg5lIocR8uaK0IjaBr3L8Wx/L68o13piY1DySfGberwUoJDm
         bGjdZKnYvzgtlUPZKe+a5bNQ4gPaD3EcoBw5JxaoLypbB/qZIVevXuNQIdyD7ebH2WoR
         BQ9tYdRQCGyd6dXjBvcGjxvJKDf7ADxY27r+adlt5c1Vgtk820uExof+NU0QJBqrLfrX
         mEkIQ0e5vGIG7z/egHL4deRcjZEnyAsovs95dEoBoVsX7sKW9eru45lC6wJeSca2pY6+
         RRV0eNHStRO/2KJvOiEw0gJiOCXMwGnjKlj/jZa8Gxal4+ofRmmc5eUXxcNlFb2+xhJH
         8dTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF3kuA9+hnR32jxdZdF5p2V2IrSHeXJtxOs8ZrNN6xB8z+rGWWbYRwkvlcPcnv9hHIaHXjar71OgNLSHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZJQp5ctJGsk+mpcg0zAUxKU/UDZ7pMDYH0nv7xlxD/tZ+8LX
	yumLJL2f4w45OXMMo+nNaMk81Pa5AgtGpVx3tpqvJC1Bw49OEImoXDTUcoLlS/Hxra/Jg7OrpGd
	3TiDPmjBbtal5n/6ZJllpHCocv57DrMYGjsq2
X-Gm-Gg: ASbGncvAb9B8/W7fxMM3172HMiOr1YV5zJlECWJkmElPjg30EmkeGrdT1fcMUiMC1u1
	BFzahn7nhr+blQf12Rsir6/067GG+IZ08Cdm7WXyHMnar3RJl4IJLgFRjnwNDKUcX0IrCJ/ipCK
	5jWX4RbAo=
X-Google-Smtp-Source: AGHT+IGemVdA8vFM5APA46NT9uZdRK4EJWAEgmp2/eNiVxXqJ81TXGGCyav4i+lfYJLRLeB/U2Bp2pN4yp0P8tAT1hU=
X-Received: by 2002:a05:690c:38d:b0:6f6:b646:4f34 with SMTP id
 00721157ae682-6fd22074377mr57621747b3.30.1740613307514; Wed, 26 Feb 2025
 15:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131163059.1139617-11-mic@digikod.net> <7ed44e7b0e371302d29be95789cd1a57@paul-moore.com>
 <20250218.aePeer3oole2@digikod.net>
In-Reply-To: <20250218.aePeer3oole2@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Feb 2025 18:41:36 -0500
X-Gm-Features: AQ5f1JqWYmxLqpt22zS6kb-r4-IiD-XvgZ__5B9665k_Ga0PZ4Qv98lgbWnYyX4
Message-ID: <CAHC9VhSo7L8jw2pR9x6KmVCiqucGaRqkuj+RyQXOC6jnQBcQjA@mail.gmail.com>
Subject: Re: [PATCH v5 10/24] landlock: Add AUDIT_LANDLOCK_DOMAIN and log
 domain status
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:21=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Are there guidance about __GFP_NOWARN for audit or other subsystems?

Unfortunately I'm not aware of anything, and I too would be very
interested in learning if there was some solid guidance around the GFP
flags as the comment block in gfp_types.h is rather short.

--=20
paul-moore.com

