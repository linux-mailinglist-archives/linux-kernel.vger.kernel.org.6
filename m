Return-Path: <linux-kernel+bounces-417361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A69D5300
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48A8B27FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB6B1DFD99;
	Thu, 21 Nov 2024 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWbvyYAG"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70821DF727
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215212; cv=none; b=FYLdOb9VAqdtyYa1w9WVdG2IYp+cJ+1G5Eil8uLtTUrHBj/VnnLh8aYd3huGMTrdsClfWNpvtdjiP8NfbxDlKU8tOvyk8mWJ35bFnhmTGBzngq3oxYkagYv1U1ZqIArdJPTgXt2Z/lHi1dlQhjTuEZdeaXDJ64TFbVxjnJGT9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215212; c=relaxed/simple;
	bh=plEMvc7P/MFjBXYDffAegW699zfoyFWmjCZw0oGkoHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIjmvsw75xaBi7dpeYPXAOfYlmKSKqo2vWdLdtSyNvWJj1C04cc/l29yJMfK9tbIrvVxAePNhb780lCzEaHjr+gyvx0K4NDCSbtSVjxsPkS9fR7keU6/cjpO2vyDQmSh77QuBA5I3YeV0xMDs4pWFfePCTuO7KfLbD77XSIVIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hWbvyYAG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f53973fdso1145262e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732215208; x=1732820008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zCRGuGZv2890xlpdNfg21Swlbdi3hgEZQI8IQp1Kpk=;
        b=hWbvyYAG6UUvK0CfoALb7RDtdl9OYgdy8IAhmMU2DKBZWYVc9Ot4I4t7Pf1/MqASYC
         b17Ptkd3b0Hw8yv75dhT8+dxOG9eMdCkHtzebZX+pDLnMbteSYCj4GKzEmHIbe05GZ+2
         3ZjBltFIry8AjaHnZQmmT1Nh1rJxN5sBV7Y3Y5efPb1lEpWspy66d40l6nPjKGI6BF7D
         I/UlbfPNA+xUzqCwwINxUdlp7YppPC64bLESUhFOFj4p1HxpUmUGV52Z/FMSIuEtxVCK
         OpriDqLPFhDQYVSy6eHQkxzabXf9/zlTGgp8+cMPlNGmpFwuWbViCga17kBcoLvJXvbb
         RY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215208; x=1732820008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zCRGuGZv2890xlpdNfg21Swlbdi3hgEZQI8IQp1Kpk=;
        b=mT/JdCFqUvtObgxXe0kaoBY6RDMr5/72+hTiXvns5zsjsS8OKUZTEAEOkQ8IDZPCsq
         KDs5Bco+tjvIuZuK4N5856h99DFx3/7blgEExDZs1rrMkgfPunn9vSgoxXEFDuIKPEef
         mR9VNHWEevUqyzCQH2sNehAbiV4zK6IjZcFNtCbItsgm4+QTXqu7mYBCpXg86zFvfzco
         xtK8t7UTDr1D9fg9ykpVNtPUYs+Jef9hxSa4ARpEetRx5FTixkpltKbuY1BJe9DJFQYc
         OicXNozMIE9M3AfeTE2ZujPayC6ReIEvUhtxf/BhbOhAONERmfnVXFPOlJVxz2IrSkC5
         x2YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmXzkn+pitlRsnd3j1AAK1ui057JKT2txgNhY+XOpnlKwv+pO2bRiFsDGbc14wtGXn7FM0SlLz9byXupg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzODIykiP0M6VXuAOS78QeP1nVTsBBZFa7BXjxOlfoKZJ2+H8sw
	mrvQrGL+1MNA4kr3CXxlt5i157P2aYLKcimxCOt0G9z+kzBThd6oB2WhLftceL8=
X-Gm-Gg: ASbGncs1oTcCNgSLpYGbLm58D3GTwW6335qFwlhz/6EC5cfh8VGBTYepP6Bn/X4hVTz
	WkCcUuJoxNg2MYULruGdnpECUAwlrXOGybWX4VQ2chBvovCwqpXSI0H2HD+R1vLsRluouj+8Eo2
	llUXz3leTGPRJ29kUPYIg2K97IsS9lPwzKgx4C6UYGra+hcGKAkzDfjD8o+n+rbLcdDN+UYUUyG
	MwupV7bl6KAxFQk/4dYW1kmeozS+OfihMzv1NMUlh6wY3hH0+KSvj9FMddbzC7O2Vf9T9vY80sy
	Uie09eA+ynGix09h7HWX1NAQdRLPyw==
X-Google-Smtp-Source: AGHT+IEUh6/Eu8AqzBMD3b9KkeOtieIJEmsmTP9LQnKAK7x7PGeGdXj1GDsp9PgUDFkqb/NEkA6Ypg==
X-Received: by 2002:a05:6512:b23:b0:53d:c6f6:70b7 with SMTP id 2adb3069b0e04-53dd2acbc2bmr79294e87.13.1732215207879;
        Thu, 21 Nov 2024 10:53:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd244561dsm49540e87.44.2024.11.21.10.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:53:26 -0800 (PST)
Date: Thu, 21 Nov 2024 20:53:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, srinivas.kandagatla@linaro.org, 
	linux-arm-msm@vger.kernel.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v1 4/4] misc: fastrpc: Add debugfs support for fastrpc
Message-ID: <cn7pqvhw4x4y7s5hbgzjpvyjnw4g6hoyepic4jai7x2fjdenxr@ikr4hkorbuwb>
References: <20241118084046.3201290-1-quic_ekangupt@quicinc.com>
 <20241118084046.3201290-5-quic_ekangupt@quicinc.com>
 <2024111804-doze-reflected-0feb@gregkh>
 <c3b285b0-33d1-4bfa-b8ab-6783ff5ed78d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b285b0-33d1-4bfa-b8ab-6783ff5ed78d@quicinc.com>

On Thu, Nov 21, 2024 at 12:12:17PM +0530, Ekansh Gupta wrote:
> 
> 
> On 11/18/2024 7:32 PM, Greg KH wrote:
> > On Mon, Nov 18, 2024 at 02:10:46PM +0530, Ekansh Gupta wrote:
> >> Add changes to support debugfs. The fastrpc directory will be
> >> created which will carry debugfs files for all fastrpc processes.
> >> The information of fastrpc user and channel contexts are getting
> >> captured as part of this change.
> >>
> >> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> >> ---
> >>  drivers/misc/fastrpc/Makefile        |   3 +-
> >>  drivers/misc/fastrpc/fastrpc_debug.c | 156 +++++++++++++++++++++++++++
> >>  drivers/misc/fastrpc/fastrpc_debug.h |  31 ++++++
> >>  drivers/misc/fastrpc/fastrpc_main.c  |  18 +++-
> >>  4 files changed, 205 insertions(+), 3 deletions(-)
> >>  create mode 100644 drivers/misc/fastrpc/fastrpc_debug.c
> >>  create mode 100644 drivers/misc/fastrpc/fastrpc_debug.h
> >>
> >> diff --git a/drivers/misc/fastrpc/Makefile b/drivers/misc/fastrpc/Makefile
> >> index 020d30789a80..4ff6b64166ae 100644
> >> --- a/drivers/misc/fastrpc/Makefile
> >> +++ b/drivers/misc/fastrpc/Makefile
> >> @@ -1,3 +1,4 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
> >> -fastrpc-objs	:= fastrpc_main.o
> >> \ No newline at end of file
> >> +fastrpc-objs	:= fastrpc_main.o \
> >> +		fastrpc_debug.o
> > Only build this file if debugfs is enabled.
> >
> > And again, "debug.c"?
> I'll add change to build this only if debugfs is enabled. Going forward I have plans to add
> few more debug specific changes, maybe then I'll need to change the build rules again.
> >
> >> diff --git a/drivers/misc/fastrpc/fastrpc_debug.c b/drivers/misc/fastrpc/fastrpc_debug.c
> >> new file mode 100644
> >> index 000000000000..cdb4fc6845a8
> >> --- /dev/null
> >> +++ b/drivers/misc/fastrpc/fastrpc_debug.c
> >> @@ -0,0 +1,156 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +// Copyright (c) 2024 Qualcomm Innovation Center.
> >> +
> >> +#include <linux/debugfs.h>
> >> +#include <linux/seq_file.h>
> >> +#include "fastrpc_shared.h"
> >> +#include "fastrpc_debug.h"
> >> +
> >> +#ifdef CONFIG_DEBUG_FS
> > Please put the #ifdef in the .h file, not in the .c file.
> Ack
> >
> >> +void fastrpc_create_user_debugfs(struct fastrpc_user *fl)
> >> +{
> >> +	char cur_comm[TASK_COMM_LEN];
> >> +	int domain_id, size;
> >> +	char *debugfs_buf;
> >> +	struct dentry *debugfs_dir = fl->cctx->debugfs_dir;
> >> +
> >> +	memcpy(cur_comm, current->comm, TASK_COMM_LEN);
> >> +	cur_comm[TASK_COMM_LEN-1] = '\0';
> >> +	if (debugfs_dir != NULL) {
> >> +		domain_id = fl->cctx->domain_id;
> >> +		size = snprintf(NULL, 0, "%.10s_%d_%d_%d", cur_comm,
> >> +				current->pid, fl->tgid, domain_id) + 1;
> >> +		debugfs_buf = kzalloc(size, GFP_KERNEL);
> >> +		if (debugfs_buf == NULL)
> >> +			return;
> >> +		/*
> >> +		 * Use HLOS process name, HLOS PID, fastrpc user TGID,
> >> +		 * domain_id in debugfs filename to create unique file name
> >> +		 */
> >> +		snprintf(debugfs_buf, size, "%.10s_%d_%d_%d",
> >> +			cur_comm, current->pid, fl->tgid, domain_id);
> >> +		fl->debugfs_file = debugfs_create_file(debugfs_buf, 0644,
> >> +				debugfs_dir, fl, &fastrpc_debugfs_fops);
> > Why are you saving the debugfs file?  What do you need to do with it
> > that you can't just delete the whole directory, or look up the name
> > again in the future when removing it?
> fl structure is specific to a process using fastrpc driver. The reason to save
> this debugfs file is to delete is when the process releases fastrpc device.
> If the file is not deleted, it might flood multiple files in debugfs directory.
> 
> As part of this change, only the file that is getting created by a process is
> getting removed when process is releasing device and I don't think we
> can clean up the whole directory at this point.

My 2c: it might be better to create a single file that conains
information for all the processes instead of that. Or use fdinfo data to
export process / FD information to userspace.


-- 
With best wishes
Dmitry

