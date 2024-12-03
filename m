Return-Path: <linux-kernel+bounces-429395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C811F9E1B78
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88125284DFD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7241E47CA;
	Tue,  3 Dec 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c+fZm+EU"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAE1E47C4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227072; cv=none; b=YCHiSlSOaGuhasSQDvBWuqgWGGYvjvmqT2ljL8TBnF7zr5JAILYJ9ZCukcWQ6gBntRq7th9EZJ8BsIUJgejnf23/A9tAlehoscOf0d3Exox2ELZUDYB8CcqqAfTHQez60bhJu5BcIuHsco9/1OSI0pTTVARVeXcHAntQB3aW4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227072; c=relaxed/simple;
	bh=Q9+AiQ6s0aWeS6kzWsVPhOJmvynbGm/ye7+xXZgGDSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a99TA8rqxZ0o0wOSHam47ooPBgqefa4yuxcel7b+yK+DvBSJDHNJjbZetzM/HmKGk4osENOoXE2u+4jbeqY9qROl4fAoJZujC9w2+2OIfDr9bHObxYUUZGYzDyElC/n0qpI/HYTkbPStyiFiWgRI7UEpr2kIm6FpQRLkr5cHPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c+fZm+EU; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e396e33d47dso4783392276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733227070; x=1733831870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BbMpTWPQcQsU0HRaX/c6zM2bDkZbOjiVConTuGe+jZE=;
        b=c+fZm+EU/RrrAoTPD83ZHxZFQxF30ZORotoDDljCAlRv92VWJGoYrgX6pJ7lFAPl0U
         /Wx1EmEeOylVASJrEjYSgVqibv/G0iw2CMJApCmvmxM2AGI/z1EpC+urSvb/UkwuBU/6
         qGDys60o8ZCZVsit2MK+Nb9s4/cHUXCqraw4uL9CG/FgJ2MniMivtYkyO1Rrykvgzstn
         rJcXku1kYyRJOoN+jIq8Nblr2PRzruaJwXRreBnVnQ1e9nEsfnVIu7NRKHlDFSDZBlxx
         2ORzaeKw1+lOcH+Qola+3CXbdYMvGTdkxtVPCQqSE/HIMHq8+VThm8teCAH9z8J400Tr
         5Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733227070; x=1733831870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbMpTWPQcQsU0HRaX/c6zM2bDkZbOjiVConTuGe+jZE=;
        b=vMLE/AlTYehUTx7IBgWbpGYfHojv2PH8Gmh9K/78k/otOjE3xIq5MgSb+GQnk5eiTA
         0w/Ik6T6uaxCHfl5h8BvIX09qurikfL2Idj++40iXyhIc1hGoxjIM3pA+qWSJ1LOrSZa
         EYbPrlni8eEPn01Zfpj3UT8kIK7SakzVL3YASk002/qXK568Mido+DRwiYMJRnVZCUro
         wVzcAtBBv48i1teusJ2VRzq3si6R6iw90N8Ej94rVQ24jKvhpiOq8Rc0gxzF0WwOLhvP
         MKZUMDp8Qi4pr7sDJx9hLSmX2T5W5G0Mw/c0rv2tws0E76zpG6oPLDLhTo/voGY18wUc
         YgtA==
X-Forwarded-Encrypted: i=1; AJvYcCXiOZ35cCt7Op3+sjjHDGXIH+UdqVS81k4gRKDCCAkvWwc9HCyI//lj8NjvR6+CFvnmVoSI3/J8Q1fNVek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgL+s2JwjfVb7cOnEWup+I8l+rGcumKxZt7DjjgyFWa1rllpx
	ecDKwuzUZ5qp4AsYk5i9dTA+/U+5cLfUesfj32ZQYXJVgQaj/QIiDEav5JfEzoXEc9t1NSxoW/K
	MQtiUaTk+f8iVY8GOvWK999RKw2/Hpq1jJ6ujNZt0UU/9jx8p
X-Gm-Gg: ASbGncvAen1SlRWNYAtCmUwWLJLtL5+HkYmOOFAVW+jMhemxnMFQWc5Zi4MLQgEDXfE
	8wmPQrHhdxg+naCzYJudt6tYNcwUWOQ==
X-Google-Smtp-Source: AGHT+IGQ/9s5DEKVq56LcELRCgbbSUJDxrGME9rneM000XHdp2t+8py1fz0BjAa9e/C+4ixWTgkXDY5JwOAFrvAaJEA=
X-Received: by 2002:a05:6902:20c9:b0:e39:93ab:dbab with SMTP id
 3f1490d57ef6-e39d3e39f09mr2319862276.28.1733227069673; Tue, 03 Dec 2024
 03:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118084046.3201290-1-quic_ekangupt@quicinc.com>
 <20241118084046.3201290-5-quic_ekangupt@quicinc.com> <2024111804-doze-reflected-0feb@gregkh>
 <c3b285b0-33d1-4bfa-b8ab-6783ff5ed78d@quicinc.com> <cn7pqvhw4x4y7s5hbgzjpvyjnw4g6hoyepic4jai7x2fjdenxr@ikr4hkorbuwb>
 <365c4709-b421-4af8-b521-a195630242de@quicinc.com> <nsaq3zungvyhuikz35arvxmle2fovxh422jpyqxuleh57ufqnk@bekeh7qr7y76>
 <697e90db-6ecc-44ac-af86-6c7f910fc902@quicinc.com>
In-Reply-To: <697e90db-6ecc-44ac-af86-6c7f910fc902@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Dec 2024 13:57:41 +0200
Message-ID: <CAA8EJppbptPryu_O3G3YAapHT=Ai+MAdA38FtSU=YvWb+mqa1g@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] misc: fastrpc: Add debugfs support for fastrpc
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, srinivas.kandagatla@linaro.org, 
	linux-arm-msm@vger.kernel.org, quic_bkumar@quicinc.com, 
	linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, 
	dri-devel@lists.freedesktop.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 07:22, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
>
>
>
> On 12/2/2024 6:18 PM, Dmitry Baryshkov wrote:
> > On Mon, Dec 02, 2024 at 03:27:43PM +0530, Ekansh Gupta wrote:
> >>
> >> On 11/22/2024 12:23 AM, Dmitry Baryshkov wrote:
> >>> On Thu, Nov 21, 2024 at 12:12:17PM +0530, Ekansh Gupta wrote:
> >>>> On 11/18/2024 7:32 PM, Greg KH wrote:
> >>>>> On Mon, Nov 18, 2024 at 02:10:46PM +0530, Ekansh Gupta wrote:
> >>>>>> Add changes to support debugfs. The fastrpc directory will be
> >>>>>> created which will carry debugfs files for all fastrpc processes.
> >>>>>> The information of fastrpc user and channel contexts are getting
> >>>>>> captured as part of this change.
> >>>>>>
> >>>>>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> >>>>>> ---
> >>>>>>  drivers/misc/fastrpc/Makefile        |   3 +-
> >>>>>>  drivers/misc/fastrpc/fastrpc_debug.c | 156 +++++++++++++++++++++++++++
> >>>>>>  drivers/misc/fastrpc/fastrpc_debug.h |  31 ++++++
> >>>>>>  drivers/misc/fastrpc/fastrpc_main.c  |  18 +++-
> >>>>>>  4 files changed, 205 insertions(+), 3 deletions(-)
> >>>>>>  create mode 100644 drivers/misc/fastrpc/fastrpc_debug.c
> >>>>>>  create mode 100644 drivers/misc/fastrpc/fastrpc_debug.h
> >>>>>>
> >>>>>> diff --git a/drivers/misc/fastrpc/Makefile b/drivers/misc/fastrpc/Makefile
> >>>>>> index 020d30789a80..4ff6b64166ae 100644
> >>>>>> --- a/drivers/misc/fastrpc/Makefile
> >>>>>> +++ b/drivers/misc/fastrpc/Makefile
> >>>>>> @@ -1,3 +1,4 @@
> >>>>>>  # SPDX-License-Identifier: GPL-2.0
> >>>>>>  obj-$(CONFIG_QCOM_FASTRPC)      += fastrpc.o
> >>>>>> -fastrpc-objs    := fastrpc_main.o
> >>>>>> \ No newline at end of file
> >>>>>> +fastrpc-objs    := fastrpc_main.o \
> >>>>>> +                fastrpc_debug.o
> >>>>> Only build this file if debugfs is enabled.
> >>>>>
> >>>>> And again, "debug.c"?
> >>>> I'll add change to build this only if debugfs is enabled. Going forward I have plans to add
> >>>> few more debug specific changes, maybe then I'll need to change the build rules again.
> >>>>>> diff --git a/drivers/misc/fastrpc/fastrpc_debug.c b/drivers/misc/fastrpc/fastrpc_debug.c
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..cdb4fc6845a8
> >>>>>> --- /dev/null
> >>>>>> +++ b/drivers/misc/fastrpc/fastrpc_debug.c
> >>>>>> @@ -0,0 +1,156 @@
> >>>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>>> +// Copyright (c) 2024 Qualcomm Innovation Center.
> >>>>>> +
> >>>>>> +#include <linux/debugfs.h>
> >>>>>> +#include <linux/seq_file.h>
> >>>>>> +#include "fastrpc_shared.h"
> >>>>>> +#include "fastrpc_debug.h"
> >>>>>> +
> >>>>>> +#ifdef CONFIG_DEBUG_FS
> >>>>> Please put the #ifdef in the .h file, not in the .c file.
> >>>> Ack
> >>>>>> +void fastrpc_create_user_debugfs(struct fastrpc_user *fl)
> >>>>>> +{
> >>>>>> +        char cur_comm[TASK_COMM_LEN];
> >>>>>> +        int domain_id, size;
> >>>>>> +        char *debugfs_buf;
> >>>>>> +        struct dentry *debugfs_dir = fl->cctx->debugfs_dir;
> >>>>>> +
> >>>>>> +        memcpy(cur_comm, current->comm, TASK_COMM_LEN);
> >>>>>> +        cur_comm[TASK_COMM_LEN-1] = '\0';
> >>>>>> +        if (debugfs_dir != NULL) {
> >>>>>> +                domain_id = fl->cctx->domain_id;
> >>>>>> +                size = snprintf(NULL, 0, "%.10s_%d_%d_%d", cur_comm,
> >>>>>> +                                current->pid, fl->tgid, domain_id) + 1;
> >>>>>> +                debugfs_buf = kzalloc(size, GFP_KERNEL);
> >>>>>> +                if (debugfs_buf == NULL)
> >>>>>> +                        return;
> >>>>>> +                /*
> >>>>>> +                 * Use HLOS process name, HLOS PID, fastrpc user TGID,
> >>>>>> +                 * domain_id in debugfs filename to create unique file name
> >>>>>> +                 */
> >>>>>> +                snprintf(debugfs_buf, size, "%.10s_%d_%d_%d",
> >>>>>> +                        cur_comm, current->pid, fl->tgid, domain_id);
> >>>>>> +                fl->debugfs_file = debugfs_create_file(debugfs_buf, 0644,
> >>>>>> +                                debugfs_dir, fl, &fastrpc_debugfs_fops);
> >>>>> Why are you saving the debugfs file?  What do you need to do with it
> >>>>> that you can't just delete the whole directory, or look up the name
> >>>>> again in the future when removing it?
> >>>> fl structure is specific to a process using fastrpc driver. The reason to save
> >>>> this debugfs file is to delete is when the process releases fastrpc device.
> >>>> If the file is not deleted, it might flood multiple files in debugfs directory.
> >>>>
> >>>> As part of this change, only the file that is getting created by a process is
> >>>> getting removed when process is releasing device and I don't think we
> >>>> can clean up the whole directory at this point.
> >>> My 2c: it might be better to create a single file that conains
> >>> information for all the processes instead of that. Or use fdinfo data to
> >>> export process / FD information to userspace.
> >> Thanks for your review. The reason of not having single file for all processes is that
> >> I can run 100s of iteration for any process(say calculator) and every time the properties
> >> of the process can differ(like buffer, session etc.). For this reason, I'm creating and
> >> deleting the debugfs files for every process run.
> >>
> >> Do you see any advantage of using fdinfo over debugfs? I'm not sure if we can add all
> >> the information(like in debugfs) here.
> > Which information is actually useful / interesting for application
> > developers? If not for the fdinfo, I might still vote for a single file
> > rather than a pile of per-process data.
> I have tried to capture all the information that could be useful.
>
> I can try changes to maintain single file for all active processes. Having this file specific
> to a channel should be fine, right? like fastrpc_adsp, fastrpc_cdsp, etc.? Each file will
> carry information of all processes using that remoteproc.

I think it's a better idea, yes.

>
> --ekansh
> >
> >> --ekansh
> >>>
>


-- 
With best wishes
Dmitry

