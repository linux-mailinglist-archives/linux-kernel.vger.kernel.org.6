Return-Path: <linux-kernel+bounces-339566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9A8986701
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F066EB214A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4F145336;
	Wed, 25 Sep 2024 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVFK7rGX"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E871140E38;
	Wed, 25 Sep 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293062; cv=none; b=W/AF9OatXAEuSHxUOZXM0JvARNuNFZnww+KAtPja8CiPPcJt3gGaoo0krCmqwy6NoCXHjaOWQ90yV+DhyLhDXez3Zhd0jGXGho0OnGA3CQLyKisPksaIFgz3vIYs11hROXm5/yY6TUJ3atDeqjYwgMTTFku8nsTLQb74kzH/yUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293062; c=relaxed/simple;
	bh=hr6w99V8Dt7Om5lAbCRDMzfu0anmCVDDeRj+KtSp7DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/9i61Zo4Fv4j7/69gYT02+vg408+gfuYPTlHDmDqJRJ5PQyUWjS+otsjd/vj4JtQd/KkpWz3mKKgd2qfQbme/qiv66dyKSz6BUAJ2BBQG2jo43KdSbaibKXZ5spV3PC0lhYThT9j9npE482LFpLsz2DOeW/ixSfhOZXAVpMDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVFK7rGX; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a1a90bd08cso754105ab.3;
        Wed, 25 Sep 2024 12:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727293059; x=1727897859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3inmzC1cBMAU1efYILglakaSQPbCmOcrhd59+dFzCc=;
        b=MVFK7rGX86TTpFINUEUqjySZ4QVsj1i339lxVxCmrhsTAsCEuHunWi2Qz9pf/8xKxz
         l9dIIJ6wezTayLJWU0QEoKoWoEXmBXyDoTGcIw0FJfU6tFk6YWIi/ZWEyIiqjfG27W+l
         qUZtS1qRWShQY8I+0T/sbGJrDxK3ck6e3roVNfei6cWdB8mxboegOdNSOo7eDsO7+bCg
         Rfwyfz7GJCqNYiMaijSpTINRNaNLtT+RNgHlme3ORqdZNtwRx2/VFGxH2XoOn1MUur/9
         1lmBtu8hmY8ryXxUjyQXtV0FtA7cGJ9PueHYPMPQ2alU0x70Ry2CZAV5rjPQztxLQMS1
         5cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727293059; x=1727897859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3inmzC1cBMAU1efYILglakaSQPbCmOcrhd59+dFzCc=;
        b=TrzQY8e23u//KCWdk2WtjibSxfFl4IAAGhEAf0irNW2XAp8QxVFRWwkNsbMNRe9YFF
         TSwtRHHIwPkZvSVaj5ST5FHAvSQB3CyvCz08ragPn6+gcji3n9Cj4or70Ta3cTMtqJxE
         3nDxjB9i3IIvVF4JBpKgh07zh7/mS7fQliikR2IKfWR2xJ789Tq78sfGi9lNDJatp2jP
         5o86evWzTuhzmuYhGgFavV4RHc9P6JnXYoo+u9fKP/+PdjbytWxg0RGCNtWdKGY9YL+D
         9mJPs/ajw9K8/WV+bSLbnsdvnCBw6JbWkV0QBO9YG6bwtwfvlsqoLV2cOTKfbS8KhHG8
         la1w==
X-Forwarded-Encrypted: i=1; AJvYcCWC0aS+eA6qp5yX4+5+Atw4HRPXdMuJR4rIyVndAt8XFB6aI9+0fplRbzKMMkX9UfEjPaXDfflakPekiEN2@vger.kernel.org, AJvYcCWiqcAc6aha8CewuxV/rLwpdKd8cOrJclSo/NOdnG+bmwTvTerbR5FMHZ55UjDcXaOPCaKx79v6TM7pEGVd@vger.kernel.org, AJvYcCXtPRTV2bvacttjq5EiAXKSr5cF+JyN+sb3vqMxPQ8cngjd789E8a2XYfGfLt8iRIY6Aa0ANXOEqggG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfrq1Qx9a0HVTw0zSAoBSYNSUQKalGh8t/ztkB2w0piUxCQ5az
	OwMOjcecKRpoNm/FeGPeYOJHMPSnA08qLMmqIOsmRWoHB21bsFlvF3tFsi12BkNHY2BOhHkoK1Y
	l6aHxkIcTKRQTVe69y/MkBfzBD3A=
X-Google-Smtp-Source: AGHT+IEfjI8EcE0ZkJ+sptdGpXjZzm0A+cql6r0DLvyPqg9dSMW6R4pPBwsF5DXd3Tbf9D8V81a4ia2d7cEEGZjdACM=
X-Received: by 2002:a92:b746:0:b0:3a2:7592:2c5 with SMTP id
 e9e14a558f8ab-3a27592042bmr14057975ab.17.1727293059064; Wed, 25 Sep 2024
 12:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917-preemption-a750-t-v4-0-95d48012e0ac@gmail.com>
 <c70392bb-bda1-48c7-824e-23d6f92f54ef@linaro.org> <20240920170949.vp3642gghhey3pjb@hu-akhilpo-hyd.qualcomm.com>
 <29fee642-440a-4b68-909b-a7c391d5a842@gmail.com> <CAF6AEGsuduEZDAg3nMpEiaA8nMO4fR8cH8j3k+K160+CvzaO6Q@mail.gmail.com>
 <20240924152225.tf6etddoiuiusber@hu-akhilpo-hyd.qualcomm.com>
In-Reply-To: <20240924152225.tf6etddoiuiusber@hu-akhilpo-hyd.qualcomm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 25 Sep 2024 12:37:26 -0700
Message-ID: <CAF6AEGuJ97O6m-z6UK=c1hh=VxVPidS1Thqeo+OMCr_oGHcGCQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Preemption support for A7XX
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Antonino Maniscalco <antomani103@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Sharat Masetty <smasetty@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:22=E2=80=AFAM Akhil P Oommen <quic_akhilpo@quicin=
c.com> wrote:
>
> On Tue, Sep 24, 2024 at 07:47:12AM -0700, Rob Clark wrote:
> > On Tue, Sep 24, 2024 at 4:54=E2=80=AFAM Antonino Maniscalco
> > <antomani103@gmail.com> wrote:
> > >
> > > On 9/20/24 7:09 PM, Akhil P Oommen wrote:
> > > > On Wed, Sep 18, 2024 at 09:46:33AM +0200, Neil Armstrong wrote:
> > > >> Hi,
> > > >>
> > > >> On 17/09/2024 13:14, Antonino Maniscalco wrote:
> > > >>> This series implements preemption for A7XX targets, which allows =
the GPU to
> > > >>> switch to an higher priority ring when work is pushed to it, redu=
cing latency
> > > >>> for high priority submissions.
> > > >>>
> > > >>> This series enables L1 preemption with skip_save_restore which re=
quires
> > > >>> the following userspace patches to function:
> > > >>>
> > > >>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30544
> > > >>>
> > > >>> A flag is added to `msm_submitqueue_create` to only allow submiss=
ions
> > > >>> from compatible userspace to be preempted, therefore maintaining
> > > >>> compatibility.
> > > >>>
> > > >>> Preemption is currently only enabled by default on A750, it can b=
e
> > > >>> enabled on other targets through the `enable_preemption` module
> > > >>> parameter. This is because more testing is required on other targ=
ets.
> > > >>>
> > > >>> For testing on other HW it is sufficient to set that parameter to=
 a
> > > >>> value of 1, then using the branch of mesa linked above, `TU_DEBUG=
=3Dhiprio`
> > > >>> allows to run any application as high priority therefore preempti=
ng
> > > >>> submissions from other applications.
> > > >>>
> > > >>> The `msm_gpu_preemption_trigger` and `msm_gpu_preemption_irq` tra=
ces
> > > >>> added in this series can be used to observe preemption's behavior=
 as
> > > >>> well as measuring preemption latency.
> > > >>>
> > > >>> Some commits from this series are based on a previous series to e=
nable
> > > >>> preemption on A6XX targets:
> > > >>>
> > > >>> https://lkml.kernel.org/1520489185-21828-1-git-send-email-smasett=
y@codeaurora.org
> > > >>>
> > > >>> Signed-off-by: Antonino Maniscalco <antomani103@gmail.com>
> > > >>> ---
> > > >>> Changes in v4:
> > > >>> - Added missing register in pwrup list
> > > >>> - Removed and rearrange barriers
> > > >>> - Renamed `skip_inline_wptr` to `restore_wptr`
> > > >>> - Track ctx seqno per ring
> > > >>> - Removed secure preempt context
> > > >>> - NOP out postamble to disable it instantly
> > > >>> - Only emit pwrup reglist once
> > > >>> - Document bv_rptr_addr
> > > >>> - Removed unused A6XX_PREEMPT_USER_RECORD_SIZE
> > > >>> - Set name on preempt record buffer
> > > >>> - Link to v3: https://lore.kernel.org/r/20240905-preemption-a750-=
t-v3-0-fd947699f7bc@gmail.com
> > > >>>
> > > >>> Changes in v3:
> > > >>> - Added documentation about preemption
> > > >>> - Use quirks to determine which target supports preemption
> > > >>> - Add a module parameter to force disabling or enabling preemptio=
n
> > > >>> - Clear postamble when profiling
> > > >>> - Define A6XX_CP_CONTEXT_SWITCH_CNTL_LEVEL fields in a6xx.xml
> > > >>> - Make preemption records MAP_PRIV
> > > >>> - Removed user ctx record (NON_PRIV) and patch 2/9 as it's not ne=
eded
> > > >>>     anymore
> > > >>> - Link to v2: https://lore.kernel.org/r/20240830-preemption-a750-=
t-v2-0-86aeead2cd80@gmail.com
> > > >>>
> > > >>> Changes in v2:
> > > >>> - Added preept_record_size for X185 in PATCH 3/7
> > > >>> - Added patches to reset perf counters
> > > >>> - Dropped unused defines
> > > >>> - Dropped unused variable (fixes warning)
> > > >>> - Only enable preemption on a750
> > > >>> - Reject MSM_SUBMITQUEUE_ALLOW_PREEMPT for unsupported targets
> > > >>> - Added Akhil's Reviewed-By tags to patches 1/9,2/9,3/9
> > > >>> - Added Neil's Tested-By tags
> > > >>> - Added explanation for UAPI changes in commit message
> > > >>> - Link to v1: https://lore.kernel.org/r/20240815-preemption-a750-=
t-v1-0-7bda26c34037@gmail.com
> > > >>>
> > > >>> ---
> > > >>> Antonino Maniscalco (11):
> > > >>>         drm/msm: Fix bv_fence being used as bv_rptr
> > > >>>         drm/msm/A6XX: Track current_ctx_seqno per ring
> > > >>>         drm/msm: Add a `preempt_record_size` field
> > > >>>         drm/msm: Add CONTEXT_SWITCH_CNTL bitfields
> > > >>>         drm/msm/A6xx: Implement preemption for A7XX targets
> > > >>>         drm/msm/A6xx: Sync relevant adreno_pm4.xml changes
> > > >>>         drm/msm/A6xx: Use posamble to reset counters on preemptio=
n
> > > >>>         drm/msm/A6xx: Add traces for preemption
> > > >>>         drm/msm/A6XX: Add a flag to allow preemption to submitque=
ue_create
> > > >>>         drm/msm/A6xx: Enable preemption for A750
> > > >>>         Documentation: document adreno preemption
> > > >>>
> > > >>>    Documentation/gpu/msm-preemption.rst               |  98 +++++
> > > >>>    drivers/gpu/drm/msm/Makefile                       |   1 +
> > > >>>    drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   2 +-
> > > >>>    drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |   2 +-
> > > >>>    drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |   2 +-
> > > >>>    drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   6 +-
> > > >>>    drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |   7 +-
> > > >>>    drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 325 +++++=
+++++++++-
> > > >>>    drivers/gpu/drm/msm/adreno/a6xx_gpu.h              | 174 +++++=
+++
> > > >>>    drivers/gpu/drm/msm/adreno/a6xx_preempt.c          | 440 +++++=
++++++++++++++++
> > > >>>    drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   9 +-
> > > >>>    drivers/gpu/drm/msm/msm_drv.c                      |   4 +
> > > >>>    drivers/gpu/drm/msm/msm_gpu.c                      |   2 +-
> > > >>>    drivers/gpu/drm/msm/msm_gpu.h                      |  11 -
> > > >>>    drivers/gpu/drm/msm/msm_gpu_trace.h                |  28 ++
> > > >>>    drivers/gpu/drm/msm/msm_ringbuffer.h               |  18 +
> > > >>>    drivers/gpu/drm/msm/msm_submitqueue.c              |   3 +
> > > >>>    drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   7 +-
> > > >>>    .../gpu/drm/msm/registers/adreno/adreno_pm4.xml    |  39 +-
> > > >>>    include/uapi/drm/msm_drm.h                         |   5 +-
> > > >>>    20 files changed, 1117 insertions(+), 66 deletions(-)
> > > >>> ---
> > > >>> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> > > >>> change-id: 20240815-preemption-a750-t-fcee9a844b39
> > > >>>
> > > >>> Best regards,
> > > >>
> > > >> I've been running vulkan-cts (1.3.7.3-0-gd71a36db16d98313c43182943=
2a136dbda692a08 from Yocto)
> > > >> on SM8650-QRD, SM8550-QRD & SM8450-HDK boards with enable_preempti=
on in default value
> > > >> and forced to 1, and I've seen no regression so far
> > > >>
> > > >> On SM8550, I've seen a few:
> > > >> platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0 [msm]] *E=
RROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 2743 timed out waiting for res=
ponse
> > > >> platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0 [msm]] *E=
RROR* Unexpected message id 2743 on the response queue
> > > >> but it's unrelated to preempt
> > > >>
> > > >> and on SM8450:
> > > >> platform 3d6a000.gmu: [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout=
 waiting for GMU OOB set GPU_SET: 0x0
> > > >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] =
*ERROR* 7.3.0.1: hangcheck detected gpu lockup rb 0!
> > > >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] =
*ERROR* 7.3.0.1:     completed fence: 331235
> > > >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] =
*ERROR* 7.3.0.1:     submitted fence: 331236
> > > >> adreno 3d00000.gpu: [drm:a6xx_irq [msm]] *ERROR* gpu fault ring 0 =
fence 50de4 status 00800005 rb 0000/0699 ib1 0000000000000000/0000 ib2 0000=
000000000000/0000
> > > >> msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ER=
ROR* 7.3.0.1: hangcheck recover!
> > > >> msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ER=
ROR* 7.3.0.1: offending task: deqp-vk (/usr/lib/vulkan-cts/deqp-vk)
> > > >> msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ER=
ROR* 7.3.0.1: hangcheck recover!
> > > >> leading to a VK_ERROR_DEVICE_LOST, but again unrelated to preempt =
support.
> > > >>
> > > >> So you can also add:
> > > >> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-=
QRD
> > > >> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8450-=
HDK
> > > >>
> > > >
> > > > Niel,
> > > >
> > > > On my x1e device, all submissions were somehow going into only a si=
ngle
> > > > ring, even the compositor's. Not sure why. So effectively preemptio=
n was
> > > > not really exercised. I had to force one of the two benchmark I ran
> > > > using the "highprio" mesa debug flag force submittions to ring 0.
> > >
> > > I think that is because GL applications (so most compositors) run
> > > through zink which does not forward GL preemption to vulkan so yeah, =
for
> > > GL applications the only way of getting preemption is the debug flag.
> >
> > I guess if it is mesa 24.2.x or newer it would be using the gallium
> > driver.  Which I guess would need xAMBLE stuff wired up.  Outside of
> > fd6_emit_restore() and fd6_gmem.cc there isn't really any state emit
> > in IB1, so I guess it probably wouldn't be too hard to get preemption
> > support wired up.
> >
> > BR,
> > -R
> >
> > > Unfortunately this is not easy to fix in Zink because it creates one
> > > VkDevice at screen creation and uses it for all GL contexts. Since GL
> > > priority is provided per context and at context creation time Zink ha=
s
> > > no way of handling this.
> > >
> > > Once TU will support more than one queue it will be possible for Zink=
 to
> > > create one queue per priority then pick one at context creation time.
> > > Doing so would require a new vulkan extension for per queue global
> > > priority. I had started working on this some time ago
> > > https://gitlab.freedesktop.org/antonino/mesa/-/tree/priority_ext?ref_=
type=3Dheads
> > > but this solution will only be viable once TU can expose more than on=
e
> > > queue.
> > >
>
> Thanks, both of you for the clarification. Glad about the
> improvements planned for both freedreno and zink.

Only lightly tested so far, but
https://gitlab.freedesktop.org/robclark/mesa/-/tree/fd/a7xx-preemption?ref_=
type=3Dheads
appears to work for getting preemption going on gl.  Needs some
cleanup/etc, but if you want something with gl compositor supporting
preemption, you can give it a try

BR,
-R

> -Akhil.
>
> > > >
> > > > If possible it is a good idea to check the new preemption traces to
> > > > ensure preemption kicks in.
> > > >
> > > > -Akhil
> > > >
> > > >> Thanks,
> > > >> Neil
> > >
> > >
> > > Best regards,
> > > --
> > > Antonino Maniscalco <antomani103@gmail.com>

