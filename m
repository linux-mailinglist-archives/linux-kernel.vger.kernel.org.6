Return-Path: <linux-kernel+bounces-226801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B09914413
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3377B1F22B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD217482C3;
	Mon, 24 Jun 2024 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdhBpVwO"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0948CFC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215981; cv=none; b=JI/C1NdN8wjszRdKDudK9hz4JVWpOIgA+0DHGm6i123qFzrUXdaiZtoBMiOkrcg/f8guhyTpFzbUg59dqjwLoAVVxDqYlnb/a+Md9Vm2JL6yRXChDRnPu6DxM9S3I6jVH+52VWgP4accj5yWWH7ut7uVRfF3VUQeLrdd8iVKCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215981; c=relaxed/simple;
	bh=Cwr6U79YXw3VoE+eOF8owfYrVW8U4Cv4BeriCKZO+9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZmFTrzCuaWDzjoKbjjzQVwNjCZTq8dvWGveGUqyqJhMohh+gT5Ue+JXcbDkkOfSppdzARRz14tFmnY8hzf/OYI0W4jozb1oikFmgjpvx6nEcL0PR41gUhLPr9v+qXkFEqKSAEa/WII2cyRf37C+aCLTvAOZGUgAAIiDIdflpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FdhBpVwO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5295eb47b48so4731034e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719215977; x=1719820777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lDo6FigYFQGMZS3Mpraq4BokVAZg7iCXZo4sAcKEd/g=;
        b=FdhBpVwOE7AFDiwQld9ijyZeiKeavN7RML/sjyhUHQQbU8/dpYDOvFSVWPqNVXSNJ3
         etiARDdvI3831IlD+quj2+jZaLdJroCgFdxu1jIj56AV8mQs9KjzxKnDvxJuZYxrdWPm
         vVXwpvkV+pSMAnzzCrN6XiGU2lGdbPyIQFpD/3ITETkQUJDXEwKJg+NnBssKxmEN3x8z
         437xY+aEi9WA0ttXg2g/JkYCuti5k1xaiyIf7ye6ltTSU+60PD0KzqasJk9T2cR8J2Bb
         HEc3rMCKV3n07Ez0ZRa0THpS+Hsp8hp7vSNCJspfg2M2O9LN5ap52z06LOGtkOJnwrjt
         zYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719215977; x=1719820777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDo6FigYFQGMZS3Mpraq4BokVAZg7iCXZo4sAcKEd/g=;
        b=W5GKh+coCCrmt+UTLxXjxzlexc1v9gnMPHZepTNZOeogH1SZalwjnwuoiRh52Sm5GV
         mTLAeb5rgeAm3ZRUQ9qZKIy8WZaYlxpY2Ne7k59MOrgT8Y+FNcBscRu+xMRWtCBYls6L
         YylSV1GyY19pZjTNsLdrd/80BbJHz9UviQuzK5L+SqcgD/WoiQB0/svA81KVN8nTmRU8
         EBqrxcIDu9Bjl/wTwrpJZY+xyQ+4AdwyZIaWOhADBlGCnQBlLixZBbPvAPmZoV4hoqKn
         +y/EWSkOkuZQdU5QmpmOmnCT7grR47/q+50bIxfgCWCgr86vX8KQ/DthfpAAsFPxy6nW
         CdAg==
X-Forwarded-Encrypted: i=1; AJvYcCWdsDkE5mtPQSB7dwFZM/Mtx82j+Li82VqOoyblIIgqqBtTWg0UsFFVrkB2q1kdPx6Tm3SVta+bUVmcpsJAcdrHQmD2hrXST7UiAXea
X-Gm-Message-State: AOJu0YzjtRlgLaJS8G46rwOkVEyQb70O4IoU0GXEf4x8w+nY2Pi4PLph
	DtdjJg3YopW/XTI63gGfXBBvdTG7IUkKKbdlRi/NurRO/L0DlYNmJpggE21uc7I=
X-Google-Smtp-Source: AGHT+IHenuOkInITr6W0VLjG1A7f0qBzFfDGHfEiH9gMy4oUCngVCqpgbvTbaQobNROLVIHjJmUdEg==
X-Received: by 2002:a05:6512:b23:b0:52c:e383:b0d1 with SMTP id 2adb3069b0e04-52ce383b18cmr3072773e87.53.1719215976959;
        Mon, 24 Jun 2024 00:59:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdb4a7215sm787583e87.171.2024.06.24.00.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 00:59:36 -0700 (PDT)
Date: Mon, 24 Jun 2024 10:59:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Ekansh Gupta <quic_ekangupt@quicinc.com>, Oded Gabbay <ogabbay@kernel.org>, srinivas.kandagatla@linaro.org, 
	linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
	linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, 
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v1] misc: fastrpc: Move fastrpc driver to misc/fastrpc/
Message-ID: <jhjbx32kxywnzzin6w3tzobpu5v3zxfak4vz4q5t36v6hrbvuo@uixf3imdiefl>
References: <20240612064731.25651-1-quic_ekangupt@quicinc.com>
 <zbpia232dh4ojfsvhcqxrp6cwfygaalu5cycdrs47pqmnrisvk@dq24nww26gkm>
 <z6g5ool5vomkudiroyaxh532rhlfu5x4i3l5xoqrsho2sxv4im@v5ghemjkpc3v>
 <CAA8EJprgCJKOnZo7Q31KZV3SA3NqWxcMmoUxuqnVF+8cQW5ucg@mail.gmail.com>
 <6f59552d-d7a3-5e05-3465-e707c1b7eaf2@quicinc.com>
 <ZnWhwJtTXS32UI9H@phenom.ffwll.local>
 <fin5dnpf3jyo5mk4b7fktdutbds5lkpxwzojecxa4zh7gwfad2@rkryxqzt6maq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fin5dnpf3jyo5mk4b7fktdutbds5lkpxwzojecxa4zh7gwfad2@rkryxqzt6maq>

On Sun, Jun 23, 2024 at 03:19:17PM GMT, Bjorn Andersson wrote:
> On Fri, Jun 21, 2024 at 05:52:32PM GMT, Daniel Vetter wrote:
> > On Fri, Jun 21, 2024 at 09:40:09AM -0600, Jeffrey Hugo wrote:
> > > On 6/21/2024 5:19 AM, Dmitry Baryshkov wrote:
> > > > On Fri, 21 Jun 2024 at 09:19, Bjorn Andersson <andersson@kernel.org> wrote:
> > > > > 
> > > > > On Wed, Jun 12, 2024 at 09:28:39PM GMT, Dmitry Baryshkov wrote:
> > > > > > On Wed, Jun 12, 2024 at 12:17:28PM +0530, Ekansh Gupta wrote:
> > > > > > > Move fastrpc.c from misc/ to misc/fastrpc/. New C files are planned
> > > > > > > to be added for PD notifications and other missing features. Adding
> > > > > > > and maintaining new files from within fastrpc directory would be easy.
> > > > > > > 
> > > > > > > Example of feature that is being planned to be introduced in a new C
> > > > > > > file:
> > > > > > > https://lore.kernel.org/all/20240606165939.12950-6-quic_ekangupt@quicinc.com/
> > > > > > > 
> > > > > > > Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > > > > > > ---
> > > > > > >   MAINTAINERS                          |  2 +-
> > > > > > >   drivers/misc/Kconfig                 | 13 +------------
> > > > > > >   drivers/misc/Makefile                |  2 +-
> > > > > > >   drivers/misc/fastrpc/Kconfig         | 16 ++++++++++++++++
> > > > > > >   drivers/misc/fastrpc/Makefile        |  2 ++
> > > > > > >   drivers/misc/{ => fastrpc}/fastrpc.c |  0
> > > > > > >   6 files changed, 21 insertions(+), 14 deletions(-)
> > > > > > >   create mode 100644 drivers/misc/fastrpc/Kconfig
> > > > > > >   create mode 100644 drivers/misc/fastrpc/Makefile
> > > > > > >   rename drivers/misc/{ => fastrpc}/fastrpc.c (100%)
> > > > > > 
> > > > > > Please consider whether it makes sense to move to drivers/accel instead
> > > > > > (and possibly writing a better Kconfig entry, specifying that the driver
> > > > > > is to be used to offload execution to the DSP).
> > > > > > 
> > > > > 
> > > > > Wouldn't this come with the expectation of following the ABIs of
> > > > > drivers/accel and thereby breaking userspace?
> > > > 
> > > > As I wrote earlier, that depends on the accel/ maintainers decision,
> > > > whether it's acceptable to have non-DRM_ACCEL code underneath.
> > > > But at least I'd try doing that on the grounds of keeping the code at
> > > > the proper place in the drivers/ tree, raising awareness of the
> > > > FastRPC, etc.
> > > > For example current fastrpc driver bypasses dri-devel reviews, while
> > > > if I remember correctly, at some point it was suggested that all
> > > > dma-buf-handling drivers should also notify the dri-devel ML.
> 
> If the agreement is that dma-buf-handling drivers must get reviews from
> dri-devel, then let's document that in MAINTAINERS and agree with the
> maintainer.

Good idea.

> 
> There's no need to move the driver for that.

-- 
With best wishes
Dmitry

