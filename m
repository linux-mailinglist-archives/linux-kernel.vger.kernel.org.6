Return-Path: <linux-kernel+bounces-353829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E9993355
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2801F1F23C80
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC6F1DB371;
	Mon,  7 Oct 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="dj+8jTQO"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F31714D7
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318842; cv=none; b=dYp+f5jWzGvrkvT3O4prFVj6kedv1fAfh6fVBXKVEMZlVLYvO8bh7dVhy20LghochE9ivu/o48ySe4mdZCIqdnADh1Rz0z4jRKaMPM1D90L1pxL0L6drIP5Q6fZqL/KDCBNh7FjXSoj+NZ5x9IO2OxnDnxAFQlKCC0KDW8JZOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318842; c=relaxed/simple;
	bh=DdutLgm7LnJZUydsu87UTwymGUlWI6mMAxVG/ZJc31s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gviPbsM8WF55vo0Fam8So3wpKo1fIIfxpzv2+4AxHAltHA3v0cGlKv4z3IEMX9vNqOxWax3b+58odpRxXnYTMkMlDvP+M4QUL6wIf01W+Q1Q9ZUkZP4Cy3Qla2RVjucuE7RdvW5nyJ5fo7ZVwDYnY2LiPhkv1qLDtC+RZQTh3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=dj+8jTQO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e0c3e85c5so570411b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728318838; x=1728923638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZWM6QTmBe9B09ML2vqXCSoB0/AzhE/+M2NioGDzKy8=;
        b=dj+8jTQOYb5U/boZEpygD2rjOq762FeMoC5lNAYzq2H1PjmRkGDAtNJlEYsguS2uuO
         +kqUahIk57P1e2C7T8zJis73pxFkA5CnbtB12EV4/QCa+AgLixnORGQrsIEDkZRDtnTo
         r+PxO+HHm1mvvhgAOiteTosQ6aHXKK6EbrzJg+t0ASK0M1Yjy8WG48qyOWlfWIudvd2D
         rypHrkgZffx3ZGCZyOjjFhBdBFwA4Jqvz/IZF0uvMJzNQmbeYHm5He4xTd/aVsn54Nrk
         F4qNZuXWYGWdoS/d7bBTxLIv/IZbVStYGqo+4anCI3zMLpgjri1K/a7MnmWPdJM/pW4f
         +EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728318838; x=1728923638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZWM6QTmBe9B09ML2vqXCSoB0/AzhE/+M2NioGDzKy8=;
        b=tL1T++dQoyWu3mWoQg6cosUtfTyncpp8m+PLt3aUiR71OIvlwBTe5fIak0AG/Ou1R8
         Tktjc3pVyZmiWpNNPmWJY9t+ph9PZxQ2v4HjgsdWFYd/0ckDyJbkJer/uTaumdKSUC7m
         kfz69ZQI3GiaRr06GXO92to8O/xvE3WdbvEgtC5RMz0qN8dSc5+l6n69djIDvN8bWSeQ
         CR5/Pughi/eVXYQx+D9OeMmbDfxQgicTem4YYPzGpDVJUlDIeUpzzjBtKv40bJFtm3xI
         FaYKVITq+e0sycZPtv+uxPBsEsSR2RXusBtiBjS9pbhNp7cqgUz0ojYiYW3FgbJxlA8S
         +dvA==
X-Forwarded-Encrypted: i=1; AJvYcCUckMIZSGLP5YCJjxzP44BO+QK8dNaZZtYyu01OLySN/Sn4kfepJsP8SwJhkGMvA+mKirrV5CNBnGH4MWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFEMap8v/m3QU0kSB4hqgU2HHhu60G17gXxTJ8F/fooyZBjHS+
	wBjtR4JpIWcCMOrCo/zHOytwIFYjLp1lNgdSC4qd+DI6zhSmEOWMqmMjw3obxOY=
X-Google-Smtp-Source: AGHT+IEOn2aNJRc6PNcmA1E8hHomUDAvzvN8DoqLjg4IGSM4t5x9BXT+gVd7xFtvp6ibMbgO/sW9JA==
X-Received: by 2002:a05:6a00:1ad0:b0:717:8044:3169 with SMTP id d2e1a72fcca58-71de23b5f19mr17937448b3a.9.1728318837846;
        Mon, 07 Oct 2024 09:33:57 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4a1f4sm4590147b3a.113.2024.10.07.09.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:33:57 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:33:55 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pinctrl: th1520: Convert to thp->mutex to guarded
 mutex
Message-ID: <ZwQNc9/sO9lhUvmw@x1>
References: <20241005-th1520-pinctrl-fixes-v1-1-5c65dffa0d00@tenstorrent.com>
 <6b3d9f7a-c87b-4ef5-8571-77276f3896a1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b3d9f7a-c87b-4ef5-8571-77276f3896a1@stanley.mountain>

On Mon, Oct 07, 2024 at 06:41:36PM +0300, Dan Carpenter wrote:
> Hi Drew,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Drew-Fustini/pinctrl-th1520-Convert-to-thp-mutex-to-guarded-mutex/20241006-033647
> base:   2694868880705e8f6bb61b24b1b25adc42a4a217
> patch link:    https://lore.kernel.org/r/20241005-th1520-pinctrl-fixes-v1-1-5c65dffa0d00%40tenstorrent.com
> patch subject: [PATCH 1/2] pinctrl: th1520: Convert to thp->mutex to guarded mutex
> config: parisc-randconfig-r072-20241007 (https://download.01.org/0day-ci/archive/20241007/202410072108.uG2sVTN4-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 14.1.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410072108.uG2sVTN4-lkp@intel.com/
> 
> New smatch warnings:
> drivers/pinctrl/pinctrl-th1520.c:538 th1520_pinctrl_dt_node_to_map() error: uninitialized symbol 'child'.

It seems this is because the scoped iterator declares *child in the
macro and thus no separate declaration is needed:

#define for_each_available_child_of_node_scoped(parent, child) \
	for (struct device_node *child __free(device_node) =		\
	     of_get_next_available_child(parent, NULL);			\
	     child != NULL;						\
	     child = of_get_next_available_child(parent, child))

I'll fix in future revision.

> 
> Old smatch warnings:
> drivers/pinctrl/pinctrl-th1520.c:502 th1520_pinctrl_dt_node_to_map() warn: missing error code 'ret'

This has been fixed in the v2 series [1]

Thanks,
Drew

[1] https://lore.kernel.org/linux-riscv/20241006-th1520-pinctrl-fixes-v2-0-b1822ae3a6d7@tenstorrent.com/

