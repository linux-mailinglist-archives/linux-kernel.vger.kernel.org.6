Return-Path: <linux-kernel+bounces-527096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868AAA40743
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB86919C78BD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79D207DF1;
	Sat, 22 Feb 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0URVesp"
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8F207A03;
	Sat, 22 Feb 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740218818; cv=none; b=J30UVyn6sHZKLsqV4ZbPpTNWNo3Mc+uS45IxECu8i0N6W2aRaNFQanbn6dV1FUnJTDOyNyLvk7qK+bEAR5+wsJLGAXp3SLDeA6Y8qGyOWGmuwk7q3/jjOz5wDdXrAUpCKiHedFkucCOVNY1y9BCWroLd7slJSBcL+I/qJwuBcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740218818; c=relaxed/simple;
	bh=Ye3lcByRydkI6MhU/hDwevnB+P5HmWXYAchOg7ap9jU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NjfEV+pNEueJvM7ibI9NpaORh/UpCMOUQaGbx3feTgjHY9rAQ2An/47KF31E3tnH1Ec2JK3/zhhGFdZSSB27Rr3hHnySyL3G2mjNvSZjJWnmsRFmu5xNMzrgNKeROqp36M75EbPkBWL4Er5KBLBs1ETccOkwD+3NqyAL1rSIP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0URVesp; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-6e65baef2edso24988276d6.2;
        Sat, 22 Feb 2025 02:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740218816; x=1740823616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ye3lcByRydkI6MhU/hDwevnB+P5HmWXYAchOg7ap9jU=;
        b=Z0URVespebTuyhasM/fpQIh6DOmoL3XacbZxietnsEem6dl9JXo84It8ki34R5vxhB
         YQyzQlrk10lT7NFflShVOzHK7g9MmLxZpDi/+YwuP932jiCPt7iNeBAr1DYV/awTRhDC
         2KEO2dIgZpVIH5uHqGL6vWT9XpqkjzfqfOwxEvjGxBfANMgparVCCzyicNa+/9hGTxoZ
         6Rt9pXH+OI4VtoaBAzoyg5CND+OZlgpCQQqHk5VjpK2O5QeIUxRkzivXIIIHVZS5o5qo
         ISjYydTUvVlIPD5SasHSCH0G4RFFFGqR1THXYGcOPVez9vZGIcSeMojAZieWh3nCacCE
         ZCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740218816; x=1740823616;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ye3lcByRydkI6MhU/hDwevnB+P5HmWXYAchOg7ap9jU=;
        b=SDSxB6ChoqqFZhsJm++lBImxUyT6NgMi2RbLolfX/WaGHp90cwxbcpgZ5KEJciActl
         m/jWD0chCg/ufzcRC+U0rFoXsLIH5x1N38e0ONmHyyAo5TTrWYJerbAFCY/5ra/5SlE0
         arLr/o935Iakbqo2vLjNX0wQse9Vydd6eNey1w0u9p04eyIVYyr6u9/sZ8Y9g1Sf33i1
         4FQc13h70h2NXrshpHWy0L+d/y9KEsiG48od/jnLgBOwFbYh+aO6xb8Gth+ZlNVYZgUK
         fgRDoWtp3ycYYbwrruciw3zR73sIuN2iMU0Pmudi29sMppgwtvyt4YEjz4cU52QPnL2T
         82AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKB5O9wQtIv65WRDB8npTRnGeNjeb4GBixLw5zB+WCP9hovHcRoj7uoO3EQgf4cihnzwjbPGCCTq2xdQA=@vger.kernel.org, AJvYcCW1JGXv0E8sY6EegUCCqLJvuCXtikVRyXsafgKMffXxrjjWOuuFQeSCtvZU19hpL3b8h/3qLo5SuVQYDJumFq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq0/Z22jyr4wGPcRPKDdyUAKyeVbL93HBmnu5CPbaYpNKIympt
	Ws6/Es3FNwWJ8w1Z9l2GMUm5F7WpABti5KfMw4MXLIr8rvtXr1GOdUGqf5Te1rJRJQ/3ahEmJDs
	H7TnzODVDfjgF1Buror9J/iyoYHQTrDpuS9U9Tytgeew=
X-Gm-Gg: ASbGncuRW02B8eB8ZGyAaO/Jhcv5EoUgnaAkoLwJRfGTp9hQQZlOpyCnMUkOYlOp95J
	eFUpL0pjpJasyTXF31z5aQAokXY39di0+YdDP8RnOt+Az+eDUkXc8lnQe6TFOSmFNRmjg84BjrR
	yuPgHjGCF6
X-Google-Smtp-Source: AGHT+IH02Q149aHdQepD/oWXJwQUocDgbC9g4NJXorOoPexq7v6Z6tci72orViVUo7+POtpXU3+avurlRJq6pu68x2E=
X-Received: by 2002:a05:6214:4009:b0:6e4:6f07:21a8 with SMTP id
 6a1803df08f44-6e6ae7c96f3mr77933706d6.9.1740218816155; Sat, 22 Feb 2025
 02:06:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ventura Jack <venturajack85@gmail.com>
Date: Sat, 22 Feb 2025 03:06:44 -0700
X-Gm-Features: AWEUYZnlJNy3plZj5-xeoqTD9CCS2zIkzS37rx2h8ySejSEw2Tn4Kkp_wxrwgfQ
Message-ID: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: torvalds@linux-foundation.org
Cc: airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, 
	ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>Gcc used to initialize it all, but as of gcc-15 it apparently says
>"Oh, the standard allows this crazy behavior, so we'll do it by
default".
>
>Yeah. People love to talk about "safe C", but compiler people have
>actively tried to make C unsafer for decades. The C standards
>committee has been complicit. I've ranted about the crazy C alias
>rules before.

Unsafe Rust actually has way stricter rules for aliasing than C. For
you and others who don't like C's aliasing, it may be best to avoid
unsafe Rust.

