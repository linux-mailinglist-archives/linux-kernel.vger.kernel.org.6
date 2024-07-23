Return-Path: <linux-kernel+bounces-259846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C75939E25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FB8B21FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2585714D439;
	Tue, 23 Jul 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x+ngtoCJ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41031E522
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727891; cv=none; b=adLF9/MJHrQqbyPsDafbWz70tylS50I/QySf1SW6eWS93A68Pkmn5p8DmEBgbWFedT/RXFgu2s9Q41C2HqEp3cQ5vnP9CWU5UlAO1N0z5/wrlNdzWNfCYysQ6wniqoKjfEsgZfJR+3l4BN+o/x7jagQACKbehT1DlzTN9BvXhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727891; c=relaxed/simple;
	bh=aMm+/vBCa2nfKNzbPCjYipfCfv9RO2VvBOBUyPBJrt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+7bFF1SddN+Kyumbh4p3VrvxQWw2O6SbYkjXrD+TTjOgDUIcpto2D2giB30BWNzqAhm8Pbc5TH2ocUqzgqQkiLrNW4Se/dm4s5+Hw7lPQ17W33Nz/gJQjgQrrSLgZUHBMcL7mWv0anRJMq1DN9YXXJEJmKgz3Yh45IeeMX2vnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x+ngtoCJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3685a5e7d3cso2959780f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721727888; x=1722332688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/KGo/nVokiLj3bv4/tLBnmvbHMqPE0HJyTsoIo4zfw=;
        b=x+ngtoCJN0uTD6jfXgqECs+X/Cxkf+GaX01sDGPrQNMoq6MpE7vbus8/x1r/Lt+eed
         q2VLcTd7Ou9w3/4apAq2GQa35CPQtDFsT8obF/PjAAgPr7rcoXVk/RjdPZ4OxkVcv1Mj
         OIX5nulpyuFahigcySoLORIeXAwUnmywgDAAMqj8SnkkSwaLuD7AgBd+mROqi+FXm4QG
         7coaDTGwtWYWYJbiYD0FGKB7dK8fH2tlVTdSJIOYSMXo+ahDCn8LFYDyPmy+7DJ3LrWk
         qxLOakTOgURTPIQtDv0wsbxZQ9RqMjbO9Vy/8/N7cXhgEVPMvm97dtUPjC/j4/zVqDbH
         nxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721727888; x=1722332688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/KGo/nVokiLj3bv4/tLBnmvbHMqPE0HJyTsoIo4zfw=;
        b=sNI3zblJji5h7lkdloRMrfxyzifjMBDwB55OeGm4tsZ+pqpg0eyi2a6bgPLsH/rE6C
         QZWlK5i5aZr1EDIuc0iEBZ0qGQQIBPX1mFEXMaPaFS/rImN3OsiAo38qblw7Ow3OmpIz
         fk1SsYvGziz9wgi0L2eNrJXoRxubgxWQyjlgSMpnL2Bcua2xS1BI/gf2/qJ+PWbqN7Vd
         NDylQikvflDF+uOYzh+7of90OmdcfjW6b1eHAng9bu7d0FYTmxT3ZExXAndpyGQAwz+w
         G66RUsoLDPQdN22K95/wA6pq8/DY1UiVR3CqRz1EA+CVTMf5p1n4tcWKY1GY3wWpxJ6i
         5djA==
X-Forwarded-Encrypted: i=1; AJvYcCWygnBOhA65aTFS3FeKdlWGUtc/vJUJ7Ndn+GK//b+P6NrGiRjOmneAO1+ceunbhDpZilgakO4DdQq54NE+kkHG7oScFpL5knjO27GC
X-Gm-Message-State: AOJu0Ywbta73W/tWa8xxKUpZpe2TU0sLypfFdI6d6N4wuCyRe4FJzMWs
	i4wNYvqq+HA7OvPsqgL8YrJ8mpUPps5teQcJwaBxhBqCcBw6wtc++MC1NinY3Oc/6LoQQrQJfvH
	kntR+/gC2S28HdluPOKktVqb4z63dkuS58ieD
X-Google-Smtp-Source: AGHT+IFAQeSU/jPRzeYXkossBf87PWhdJTQULqPwlsmoUuAWDas/9AqxJWvANUh4GzlM1DAGcI5ypu0vpfgG9WksGz8=
X-Received: by 2002:a5d:460f:0:b0:366:e7b5:3b49 with SMTP id
 ffacd0b85a97d-369dee68242mr1645414f8f.54.1721727887880; Tue, 23 Jul 2024
 02:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com> <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
 <edda856e-3102-495a-8cc6-b79f5f114833@arm.com>
In-Reply-To: <edda856e-3102-495a-8cc6-b79f5f114833@arm.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 23 Jul 2024 11:44:34 +0200
Message-ID: <CAH5fLghSoYY6_RfQhShUvbJyx-cPU=0A2ipg-pm-9FdSyHf-yQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
To: Steven Price <steven.price@arm.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, ojeda@kernel.org, 
	Danilo Krummrich <dakr@redhat.com>, lyude@redhat.com, robh@kernel.org, lina@asahilina.net, 
	mcanal@igalia.com, airlied@gmail.com, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 11:12=E2=80=AFAM Steven Price <steven.price@arm.com=
> wrote:
> >>> +
> >>> +pub(crate) const GPU_ID: GpuRegister =3D GpuRegister(0x0);
> >>> +pub(crate) const fn gpu_arch_major(x: u64) -> GpuRegister {
> >>> +    GpuRegister((x) >> 28)
> >>> +}
> >>> +pub(crate) const fn gpu_arch_minor(x: u64) -> GpuRegister {
> >>> +    GpuRegister((x) & genmask(27, 24) >> 24)
> >>> +}
> >>> +pub(crate) const fn gpu_arch_rev(x: u64) -> GpuRegister {
> >>> +    GpuRegister((x) & genmask(23, 20) >> 20)
> >>> +}
> >>> +pub(crate) const fn gpu_prod_major(x: u64) -> GpuRegister {
> >>> +    GpuRegister((x) & genmask(19, 16) >> 16)
> >>> +}
> >>> +pub(crate) const fn gpu_ver_major(x: u64) -> GpuRegister {
> >>> +    GpuRegister((x) & genmask(15, 12) >> 12)
> >>> +}
> >>> +pub(crate) const fn gpu_ver_minor(x: u64) -> GpuRegister {
> >>> +    GpuRegister((x) & genmask(11, 4) >> 4)
> >>> +}
> >>> +pub(crate) const fn gpu_ver_status(x: u64) -> GpuRegister {
> >>> +    GpuRegister(x & genmask(3, 0))
> >>> +}
> >>> +pub(crate) const GPU_L2_FEATURES: GpuRegister =3D GpuRegister(0x4);
> >>> +pub(crate) const fn gpu_l2_features_line_size(x: u64) -> GpuRegister=
 {
> >>> +    GpuRegister(1 << ((x) & genmask(7, 0)))
> >>> +}
> >>> +pub(crate) const GPU_CORE_FEATURES: GpuRegister =3D GpuRegister(0x8)=
;
> >>> +pub(crate) const GPU_TILER_FEATURES: GpuRegister =3D GpuRegister(0xc=
);
> >>> +pub(crate) const GPU_MEM_FEATURES: GpuRegister =3D GpuRegister(0x10)=
;
> >>> +pub(crate) const GROUPS_L2_COHERENT: GpuRegister =3D GpuRegister(bit=
(0));
> >>> +pub(crate) const GPU_MMU_FEATURES: GpuRegister =3D GpuRegister(0x14)=
;
> >>> +pub(crate) const fn gpu_mmu_features_va_bits(x: u64) -> GpuRegister =
{
> >>> +    GpuRegister((x) & genmask(7, 0))
> >>> +}
> >>> +pub(crate) const fn gpu_mmu_features_pa_bits(x: u64) -> GpuRegister =
{
> >>> +    GpuRegister(((x) >> 8) & genmask(7, 0))
> >>> +}
> >>> +pub(crate) const GPU_AS_PRESENT: GpuRegister =3D GpuRegister(0x18);
> >>> +pub(crate) const GPU_CSF_ID: GpuRegister =3D GpuRegister(0x1c);
> >>> +pub(crate) const GPU_INT_RAWSTAT: GpuRegister =3D GpuRegister(0x20);
> >>> +pub(crate) const GPU_INT_CLEAR: GpuRegister =3D GpuRegister(0x24);
> >>> +pub(crate) const GPU_INT_MASK: GpuRegister =3D GpuRegister(0x28);
> >>> +pub(crate) const GPU_INT_STAT: GpuRegister =3D GpuRegister(0x2c);
> >>> +pub(crate) const GPU_IRQ_FAULT: GpuRegister =3D GpuRegister(bit(0));
> >>> +pub(crate) const GPU_IRQ_PROTM_FAULT: GpuRegister =3D GpuRegister(bi=
t(1));
> >>> +pub(crate) const GPU_IRQ_RESET_COMPLETED: GpuRegister =3D GpuRegiste=
r(bit(8));
> >>> +pub(crate) const GPU_IRQ_POWER_CHANGED: GpuRegister =3D GpuRegister(=
bit(9));
> >>> +pub(crate) const GPU_IRQ_POWER_CHANGED_ALL: GpuRegister =3D GpuRegis=
ter(bit(10));
> >>> +pub(crate) const GPU_IRQ_CLEAN_CACHES_COMPLETED: GpuRegister =3D Gpu=
Register(bit(17));
> >>> +pub(crate) const GPU_IRQ_DOORBELL_MIRROR: GpuRegister =3D GpuRegiste=
r(bit(18));
> >>> +pub(crate) const GPU_IRQ_MCU_STATUS_CHANGED: GpuRegister =3D GpuRegi=
ster(bit(19));
> >>> +pub(crate) const GPU_CMD: GpuRegister =3D GpuRegister(0x30);
> >>> +const fn gpu_cmd_def(ty: u64, payload: u64) -> u64 {
> >>> +    (ty) | ((payload) << 8)
> >>> +}
> >>> +pub(crate) const fn gpu_soft_reset() -> GpuRegister {
> >>> +    GpuRegister(gpu_cmd_def(1, 1))
> >>> +}
> >>> +pub(crate) const fn gpu_hard_reset() -> GpuRegister {
> >>> +    GpuRegister(gpu_cmd_def(1, 2))
> >>> +}
> >>> +pub(crate) const CACHE_CLEAN: GpuRegister =3D GpuRegister(bit(0));
> >>> +pub(crate) const CACHE_INV: GpuRegister =3D GpuRegister(bit(1));
> >>> +pub(crate) const GPU_STATUS: GpuRegister =3D GpuRegister(0x34);
> >>> +pub(crate) const GPU_STATUS_ACTIVE: GpuRegister =3D GpuRegister(bit(=
0));
> >>> +pub(crate) const GPU_STATUS_PWR_ACTIVE: GpuRegister =3D GpuRegister(=
bit(1));
> >>> +pub(crate) const GPU_STATUS_PAGE_FAULT: GpuRegister =3D GpuRegister(=
bit(4));
> >>> +pub(crate) const GPU_STATUS_PROTM_ACTIVE: GpuRegister =3D GpuRegiste=
r(bit(7));
> >>> +pub(crate) const GPU_STATUS_DBG_ENABLED: GpuRegister =3D GpuRegister=
(bit(8));
> >>> +pub(crate) const GPU_FAULT_STATUS: GpuRegister =3D GpuRegister(0x3c)=
;
> >>> +pub(crate) const GPU_FAULT_ADDR_LO: GpuRegister =3D GpuRegister(0x40=
);
> >>> +pub(crate) const GPU_FAULT_ADDR_HI: GpuRegister =3D GpuRegister(0x44=
);
> >>> +pub(crate) const GPU_PWR_KEY: GpuRegister =3D GpuRegister(0x50);
> >>> +pub(crate) const GPU_PWR_KEY_UNLOCK: GpuRegister =3D GpuRegister(0x2=
968a819);
> >>> +pub(crate) const GPU_PWR_OVERRIDE0: GpuRegister =3D GpuRegister(0x54=
);
> >>> +pub(crate) const GPU_PWR_OVERRIDE1: GpuRegister =3D GpuRegister(0x58=
);
> >>> +pub(crate) const GPU_TIMESTAMP_OFFSET_LO: GpuRegister =3D GpuRegiste=
r(0x88);
> >>> +pub(crate) const GPU_TIMESTAMP_OFFSET_HI: GpuRegister =3D GpuRegiste=
r(0x8c);
> >>> +pub(crate) const GPU_CYCLE_COUNT_LO: GpuRegister =3D GpuRegister(0x9=
0);
> >>> +pub(crate) const GPU_CYCLE_COUNT_HI: GpuRegister =3D GpuRegister(0x9=
4);
> >>> +pub(crate) const GPU_TIMESTAMP_LO: GpuRegister =3D GpuRegister(0x98)=
;
> >>> +pub(crate) const GPU_TIMESTAMP_HI: GpuRegister =3D GpuRegister(0x9c)=
;
> >>> +pub(crate) const GPU_THREAD_MAX_THREADS: GpuRegister =3D GpuRegister=
(0xa0);
> >>> +pub(crate) const GPU_THREAD_MAX_WORKGROUP_SIZE: GpuRegister =3D GpuR=
egister(0xa4);
> >>> +pub(crate) const GPU_THREAD_MAX_BARRIER_SIZE: GpuRegister =3D GpuReg=
ister(0xa8);
> >>> +pub(crate) const GPU_THREAD_FEATURES: GpuRegister =3D GpuRegister(0x=
ac);
> >>> +pub(crate) const fn gpu_texture_features(n: u64) -> GpuRegister {
> >>> +    GpuRegister(0xB0 + ((n) * 4))
> >>> +}
> >>> +pub(crate) const GPU_SHADER_PRESENT_LO: GpuRegister =3D GpuRegister(=
0x100);
> >>> +pub(crate) const GPU_SHADER_PRESENT_HI: GpuRegister =3D GpuRegister(=
0x104);
> >>> +pub(crate) const GPU_TILER_PRESENT_LO: GpuRegister =3D GpuRegister(0=
x110);
> >>> +pub(crate) const GPU_TILER_PRESENT_HI: GpuRegister =3D GpuRegister(0=
x114);
> >>> +pub(crate) const GPU_L2_PRESENT_LO: GpuRegister =3D GpuRegister(0x12=
0);
> >>> +pub(crate) const GPU_L2_PRESENT_HI: GpuRegister =3D GpuRegister(0x12=
4);
> >>> +pub(crate) const SHADER_READY_LO: GpuRegister =3D GpuRegister(0x140)=
;
> >>> +pub(crate) const SHADER_READY_HI: GpuRegister =3D GpuRegister(0x144)=
;
> >>> +pub(crate) const TILER_READY_LO: GpuRegister =3D GpuRegister(0x150);
> >>> +pub(crate) const TILER_READY_HI: GpuRegister =3D GpuRegister(0x154);
> >>> +pub(crate) const L2_READY_LO: GpuRegister =3D GpuRegister(0x160);
> >>> +pub(crate) const L2_READY_HI: GpuRegister =3D GpuRegister(0x164);
> >>> +pub(crate) const SHADER_PWRON_LO: GpuRegister =3D GpuRegister(0x180)=
;
> >>> +pub(crate) const SHADER_PWRON_HI: GpuRegister =3D GpuRegister(0x184)=
;
> >>> +pub(crate) const TILER_PWRON_LO: GpuRegister =3D GpuRegister(0x190);
> >>> +pub(crate) const TILER_PWRON_HI: GpuRegister =3D GpuRegister(0x194);
> >>> +pub(crate) const L2_PWRON_LO: GpuRegister =3D GpuRegister(0x1a0);
> >>> +pub(crate) const L2_PWRON_HI: GpuRegister =3D GpuRegister(0x1a4);
> >>> +pub(crate) const SHADER_PWROFF_LO: GpuRegister =3D GpuRegister(0x1c0=
);
> >>> +pub(crate) const SHADER_PWROFF_HI: GpuRegister =3D GpuRegister(0x1c4=
);
> >>> +pub(crate) const TILER_PWROFF_LO: GpuRegister =3D GpuRegister(0x1d0)=
;
> >>> +pub(crate) const TILER_PWROFF_HI: GpuRegister =3D GpuRegister(0x1d4)=
;
> >>> +pub(crate) const L2_PWROFF_LO: GpuRegister =3D GpuRegister(0x1e0);
> >>> +pub(crate) const L2_PWROFF_HI: GpuRegister =3D GpuRegister(0x1e4);
> >>> +pub(crate) const SHADER_PWRTRANS_LO: GpuRegister =3D GpuRegister(0x2=
00);
> >>> +pub(crate) const SHADER_PWRTRANS_HI: GpuRegister =3D GpuRegister(0x2=
04);
> >>> +pub(crate) const TILER_PWRTRANS_LO: GpuRegister =3D GpuRegister(0x21=
0);
> >>> +pub(crate) const TILER_PWRTRANS_HI: GpuRegister =3D GpuRegister(0x21=
4);
> >>> +pub(crate) const L2_PWRTRANS_LO: GpuRegister =3D GpuRegister(0x220);
> >>> +pub(crate) const L2_PWRTRANS_HI: GpuRegister =3D GpuRegister(0x224);
> >>> +pub(crate) const SHADER_PWRACTIVE_LO: GpuRegister =3D GpuRegister(0x=
240);
> >>> +pub(crate) const SHADER_PWRACTIVE_HI: GpuRegister =3D GpuRegister(0x=
244);
> >>> +pub(crate) const TILER_PWRACTIVE_LO: GpuRegister =3D GpuRegister(0x2=
50);
> >>> +pub(crate) const TILER_PWRACTIVE_HI: GpuRegister =3D GpuRegister(0x2=
54);
> >>> +pub(crate) const L2_PWRACTIVE_LO: GpuRegister =3D GpuRegister(0x260)=
;
> >>> +pub(crate) const L2_PWRACTIVE_HI: GpuRegister =3D GpuRegister(0x264)=
;
> >>> +pub(crate) const GPU_REVID: GpuRegister =3D GpuRegister(0x280);
> >>> +pub(crate) const GPU_COHERENCY_FEATURES: GpuRegister =3D GpuRegister=
(0x300);
> >>> +pub(crate) const GPU_COHERENCY_PROTOCOL: GpuRegister =3D GpuRegister=
(0x304);
> >>> +pub(crate) const GPU_COHERENCY_ACE: GpuRegister =3D GpuRegister(0);
> >>> +pub(crate) const GPU_COHERENCY_ACE_LITE: GpuRegister =3D GpuRegister=
(1);
> >>> +pub(crate) const GPU_COHERENCY_NONE: GpuRegister =3D GpuRegister(31)=
;
> >>> +pub(crate) const MCU_CONTROL: GpuRegister =3D GpuRegister(0x700);
> >>> +pub(crate) const MCU_CONTROL_ENABLE: GpuRegister =3D GpuRegister(1);
> >>> +pub(crate) const MCU_CONTROL_AUTO: GpuRegister =3D GpuRegister(2);
> >>> +pub(crate) const MCU_CONTROL_DISABLE: GpuRegister =3D GpuRegister(0)=
;
> >>
> >> From this I presume it was scripted. These MCU_CONTROL_xxx defines are
> >> not GPU registers but values for the GPU registers. We might need to
> >> make changes to the C header to make it easier to convert to Rust. Or
> >> indeed generate both the C and Rust headers from a common source.
> >>
> >> Generally looks reasonable, although as it stands this would of course
> >> be a much smaller patch in plain C ;) It would look better if you spli=
t
> >> the Rust-enabling parts from the actual new code. I also think there
> >> needs to be a little more thought into what registers are useful to du=
mp
> >> and some documentation on the dump format.
> >>
> >> Na=C3=AFve Rust question: there are a bunch of unwrap() calls in the c=
ode
> >> which to my C-trained brain look like BUG_ON()s - and in C I'd be
> >> complaining about them. What is the Rust style here? AFAICT they are a=
ll
> >> valid (they should never panic) but it makes me uneasy when I'm readin=
g
> >> the code.
> >>
> >> Steve
> >>
> >
> > Yeah, the unwraps() have to go. I didn=E2=80=99t give much thought to e=
rror handling here.
> >
> > Although, as you pointed out, most of these should never panic, unless =
the size of the dump was miscomputed.
> >
> > What do you suggest instead? I guess that printing a warning and then r=
eturning from panthor_core_dump() would be a good course of action. I don=
=E2=80=99t think there=E2=80=99s a Rust equivalent to WARN_ONCE, though.
>
> In C I'd be handling at least the allocation failures and returning
> errors up the stack - most likely with some sort of WARN_ON() or similar
> (because these are 'should never happen' programming bugs - but trivial
> to recover from).
>
> For the try_from(size).unwrap() type cases, I've no idea to be honest -
> Ideally they would be compile time checks. I've very little clue about
> Rust but on the surface it looks like you've got the wrong type because
> it's checking that things don't overflow when changing type. Of course
> the standard C approach is to just do the type conversion and pretend
> you're sure that an overflow can never happen ;)

Rust has infallible conversions (called from instead of try_from) for
the cases where the conversion is infallible. Some thoughts on the
various examples:

if isize::try_from(size).unwrap() =3D=3D isize::MAX {
    return Err(EINVAL);
}
This is saying:
* If size is exactly isize::MAX, then return EINVAL.
* If size is greater than isize::MAX, then BUG.
It should probably instead be:
if size >=3D isize::MAX as usize {
    return Err(EINVAL);
}

bindings::__vmalloc_noprof(size.try_into().unwrap(), ...)
This should probably have handling for size being too big, but I guess
it will go away when this code uses the Rust vmalloc wrappers.

alloc.alloc_header(HeaderType::Registers, sz.try_into().unwrap());
Change alloc_header to take an usize instead of u32. Then the cast goes awa=
y.

bos.push(bo, GFP_KERNEL).unwrap();
The error isn't possible because the vector is pre-allocated, but we
can still handle it by returning ENOMEM.

> In particular for alloc<T>() - core::mem::size_of::<T>() is returning a
> value (of type usize) which is then being converted to isize. A C
> programmer wouldn't have any qualms about assigning a sizeof() into an
> int, even though theorectically that could overflow if the structure was
> massive. But this should really be a compile time check as it's clearly
> dead code at runtime.
>
> Steve
>
>

