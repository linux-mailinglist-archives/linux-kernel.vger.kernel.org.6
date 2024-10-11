Return-Path: <linux-kernel+bounces-360778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2808B999F64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B029B287E12
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2B20B218;
	Fri, 11 Oct 2024 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HoUf0a9D"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D620A5E2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636919; cv=none; b=G0XqJ3N7tXfxa9zHsRCsxuclHs2djuqr37XHWQQ43TIz9mG3d0/gkZRkBGnb0pPEegBHuNCMglNb/0/JpfjBrc6CZRqj1jEc9FAiquui4ZA3o3Rov997F3ToIrgOy4qZzynwlBnnZ7wfzVAYieShLhyeQ7gHRVEjDRuniawQx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636919; c=relaxed/simple;
	bh=ZaZIZPL75FN7F2Xka8N1vKtFdsaNKv70SY2RDWflhuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgdYSDDv2byov3f6vcA0q9qeuRlCktu6aYJ0B7ZptRQHXl2SytBkDHrs6qACBmNOVhsrRf2+fkyCPWNicD/O7QlGqrP0U2CwuUDr01rswmC1CRw7b8GfuHy9fmg32uUZ1XY0B4tk0Y9Ql/osVocQTWT+Q5v7oWDCAjiwbLs/3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HoUf0a9D; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fac3f1287bso18438651fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728636915; x=1729241715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7wBNfh83lXnA+3o4O/+GyuwzB4d/XfOcAHO7ievXKU=;
        b=HoUf0a9Dtc7XjwAxoZ+UrNfBF/f2x6stKUf/9oej7GGTjfurylQd1Wt208e/pLhfr/
         oJOkbe8om3izCp8Ao2M8Xn1ELpXglGm3UPV4NiKcv1nvNEQcQHYAzK8lxsrrqnYcbNPo
         VoflyiMnmaTcvqVzm5WLebfwMvIaDqkTMslmOsD1nIq9/zaOpZXfQX6gds0bhM8QF2Zb
         CMjZoxcEhBZhBKQhaYdF/JH+xX1zk76Z1yHi/Cj9U7blijssbGByCQ5enHU2hXyI8cy4
         VaT/QXDmitXfR9tG3otxacoldvva5FU9L9GmnmDqKh6f3nloMFPMpwENmF1iFZNXQGFF
         W9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728636915; x=1729241715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7wBNfh83lXnA+3o4O/+GyuwzB4d/XfOcAHO7ievXKU=;
        b=LrIbYif7LGAiZ/MJB5N4+SyYeuiU0Ln2Agw66m+gXWTkRb+has2PH5Z87x33ahLjv2
         KOtEbmqooWww6Bk0ziYiupO2iCsQ2/h+W566Usjj4qXJg5rWN+UOEjMNRlQTtkFNhlu6
         A1BkUDpbs5pgiQ0+MEZu9ZFhlnJqUUHtiekFCnjMK2z8oiovhn+kncsiIXasvO4GLuEp
         irbKBo/JuYlfUH68lH2o1/Z7DTbqNGx0kkd4hUBW1QE7zCYmlkW//Nn78GaMykt0o03d
         Z1u+wu5wRJpl4wJd09J9QSeF/3SONLyTHOiNZFx6f1rOjBI2sJdl5my6usDHAYA1N/Q/
         8mKw==
X-Forwarded-Encrypted: i=1; AJvYcCWD7/vkLb4GgLapIWWfzMcEo9IGAt/W31lywyGj5CLGAKV07ONe+DffeSX6laFdlkmSG+3VFFlq26eTkfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtsF0ewdaL2O2SaTuNeVqs/9bzzXZwhV4a8BaTraQN7ZwxU6T
	K6gPkfmB1R6EkyVYHaORIiaKLfFQty9IZBVMKcmsogatWUyh4ptgrPS4S1Q1P9Y=
X-Google-Smtp-Source: AGHT+IH6smBqfgsJtAybZTxVKbMCj9FyiXCKYp1jarZHpl/dwusozZ/5eF82l5M+CGUTW/K/5X4FGQ==
X-Received: by 2002:a2e:a988:0:b0:2fa:cf82:a1b2 with SMTP id 38308e7fff4ca-2fb327b22demr9136071fa.31.1728636915325;
        Fri, 11 Oct 2024 01:55:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937118d39sm1700349a12.21.2024.10.11.01.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:55:15 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:55:13 +0200
From: Petr Mladek <pmladek@suse.com>
To: Wardenjohn <zhangwarden@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/1] livepatch: Add stack_order sysfs attribute
Message-ID: <Zwjn8YzCZFdoCDBB@pathway.suse.cz>
References: <20241008014856.3729-1-zhangwarden@gmail.com>
 <20241008014856.3729-2-zhangwarden@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008014856.3729-2-zhangwarden@gmail.com>

On Tue 2024-10-08 09:48:56, Wardenjohn wrote:
> Add "stack_order" sysfs attribute which holds the order in which a live
> patch module was loaded into the system. A user can then determine an
> active live patched version of a function.
> 
> cat /sys/kernel/livepatch/livepatch_1/stack_order -> 1
> 
> means that livepatch_1 is the first live patch applied
> 
> cat /sys/kernel/livepatch/livepatch_module/stack_order -> N
> 
> means that livepatch_module is the Nth live patch applied
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Suggested-by: Miroslav Benes <mbenes@suse.cz>
> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Wardenjohn <zhangwarden@gmail.com>

Looks and works fine:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I'll wait for the selftest before pushing this change.
    It would be nice to send both patches together in a single
    thread.

