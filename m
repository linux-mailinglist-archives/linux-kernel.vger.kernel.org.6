Return-Path: <linux-kernel+bounces-181347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CB8C7ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FCB2832D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D214A4E2;
	Thu, 16 May 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="bVWGEHUt"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12C6FD5
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879049; cv=none; b=f1gRkLfSMkF58FtmY0HYx3Cga/gTZ7HaGuHlHyeYLjPtdfTCgeUNBlhsl3kXLKYVuSMo8srml7KpxoApjqv59Qhtt4D0kW43xNEnw26IexQOxIpo8DT+DvwUexjcm0ifle38OFHKpuUSY3TDaNL5Zc0N3D2OzDjCbGyaLY97G68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879049; c=relaxed/simple;
	bh=rsMQ/5885mYwARF3wRsSl+Yp5H4QymZh6RwQfRBmPtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulI2HLj6twpTsI7XALqGlIK0ScyXzJ4x8ecohFwQQDY02ZcQfBTRoBmqJTbpJ4JrU2NC/3fFUsp6nyjDlr0Pi6Cnn0emYKf6RSY2BVcnlCM2BklyKJqOZXXkHoLGWTglujjpDoBXWds7JXYFkLA2pyOt6BCIjb/X5vEWpTLAkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=bVWGEHUt; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7e1e06c9a10so63126139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1715879047; x=1716483847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5BcOlqeHdHkpg9rPGe9OSUX6goj8JCvPGkrhm+DPRCU=;
        b=bVWGEHUtWNqlQF+Q5/whad4eLxuxE0ZnETiVOIyDrHdZxBVJsUPmnuAGS1uXlAod6A
         0fA7i4O0jLaxLfz0CM72RXxu/2byT0Mv15ov9VS18wcGTYclUto7gozs98oTepv8cRdj
         9kRd0WhNzO9UL6QdzDS9ZkxDLArj91/iknwWMXXtc5r56P+Bn5HtDkNlIlv/QPpbubv0
         lGL7exD03Bdn7gshTQMktlZ+qFm1yqvny4c8YJsWw7h44JZMqhraJPcXmJQ4QKjpoo7f
         hepGVZZXfX0feGCWqBYw6OCynNfxDud3/b3/NNtUV7f0rAnM8C6DUjrdi5mJ6WEwRQpl
         GgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879047; x=1716483847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BcOlqeHdHkpg9rPGe9OSUX6goj8JCvPGkrhm+DPRCU=;
        b=YfslV5iR7xya/iklndX+s92++J0oCLtwUlQxHINjW3QzuCsZoBtxyaf164eFQPNLjc
         CnCmQaRDsFsfKQ2NGIDIUI72zmHCz7lKrnE+sYoVJy8JOU6xMYZUyJp/hf/iWXmW8gKl
         GsnZ1ASdB0WUw4S/EKP5LS23O2C+dMQJAK3+T+pNKL8kMsh3LbQdiylNXnoOABg6e3KB
         4cRJf7Bs8nA5B3qyjI21lEliB7mW0sESjJBmJap+XRyE1z8rSpwINOVSU9wG+msmfrFP
         Yu592LHk4xcNvW9KFyRK1Qh1c/vUpjsdc1yNEjN7cn0AQJekm/p9tWNm1DMmqA8teXdK
         LwZg==
X-Forwarded-Encrypted: i=1; AJvYcCXmqAwAT11A7kBxnmbMkv37lIg8E7FY08NiEBtBbBoGNQH70h+FViQK2+Bw1M+HZHAg31WiGMkOXGGa30g9KhfmIenaQxPpRNCXizER
X-Gm-Message-State: AOJu0Yzl1UfMswDjCEGKJOXEJi4HTteYfmxPHqBNlTnKEG12d7FunIcD
	abGUIC+cFUu9YH3jrNl1Bc0ANTf3NHx8FgibQ9DlFDCqGN7hlcBB+3H9wHrP7dmJ6OkC5hahYZd
	6IENR8DiEFwNfgaUVnqLEtpxjDQa0IGQMi0XI9w==
X-Google-Smtp-Source: AGHT+IE+z0zK6uASgcjSs7VlTlOFQlYBognlriBxa+PoojSvXe6oM8x+zp3anb917Is6/YXAALwPJdB81pS9MYSJMP0=
X-Received: by 2002:a5d:948e:0:b0:7d9:6351:4ef3 with SMTP id
 ca18e2360f4ac-7e1b51bb73amr1910166539f.5.1715879046543; Thu, 16 May 2024
 10:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219125350.4031370-1-patrick.rudolph@9elements.com>
 <ZkL2Sdf0NcqaZRZ4@surfacebook.localdomain> <CACRpkdbUye6RhbRNGn6sapARwVUyi5hKS-5VEVBr6ZR6W_KdQw@mail.gmail.com>
 <CALNFmy33wMHBcoU9ei0vVsn0gUM7-0jdkDDq_Loa3=mMWXiWcw@mail.gmail.com>
 <CACRpkdZhY_Yz2jHGXWO5_t8Qdey8me0Gytds7V64GYOFoEC2Dg@mail.gmail.com> <85577035-06b0-4059-8092-1b751c2a6b53@sirena.org.uk>
In-Reply-To: <85577035-06b0-4059-8092-1b751c2a6b53@sirena.org.uk>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 16 May 2024 19:03:54 +0200
Message-ID: <CALNFmy1ZRqHz6_DD_2qamm-iLQ51AOFQH=ahCWRN7SAk3pfZ_A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cy8c95x0: Cache muxed registers
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	naresh.solanki@9elements.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mark,
I tried to convert the cy8c95x0 driver to use the regmap ranges, but
had a few problems:
- I removed the regmap lock since the driver has it's own mutex to
protect all regmap accesses.
  That disabled the regmap debugfs, which wasn't obvious to me and
took some time to figure out.
- I verified that the regmap range works as expected, but the debugfs
showed that the regcache has invalid defaults.
  The defaults are read from HW using by setting "num_reg_defaults_raw".
  From what I understand regmap_raw_read() called by
regcache_hw_init() ignores the ranges
  and doesn't use the page selector at all. Since it's not using
paging the contents will be invalid.
  I had to apply the workaround in the config ".use_single_read =
true" to fix the cache init, but
  that might reduce performance when initializing the cache.

Is this a bug or a known limitation of the regcache?
It looks like none of the other drivers use num_reg_defaults_raw +
ranges at the same time.

Regards,
Patrick

