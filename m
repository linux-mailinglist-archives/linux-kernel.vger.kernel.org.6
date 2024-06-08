Return-Path: <linux-kernel+bounces-207220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783D6901408
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 01:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99BCB21648
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 23:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC55741A94;
	Sat,  8 Jun 2024 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuKNHWkh"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694CB249ED
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717891182; cv=none; b=SE0gyiKNcpLWtHk5Op95oZyT09X+Mow7F0VMeTjXTLXyJN5t88Mmm+XpVPfq9P2SJbh8QH4bYIpEYQ+6/j0KonEbyWb0gf7vQ/2L9jL2EcirV3d/3kRPHHaWkF1xtfBb+2xtY9mp54/SsOl4NOWFEcGG/LKG01Nqic4rf78DRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717891182; c=relaxed/simple;
	bh=7dkMTaKEDxv3MdaSOPDMnKCsk3qv6UifFYxbU71H8hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkrbLhtD6HZawLOBQWjedmmBCj09XO/ZMo28dlCRu8mt7M+88KhJ92Japn0Cp3mjpHaj5QM1mo/BP9KXlbBQ6EqO424x7UxQtBkPl5lsFRfIxmE0ekKzL5Az4gAWi/mhB1QHAySUF1ARfqt1JHH4/AJIq2AdF0bawibt/vK2IA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cuKNHWkh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5295e488248so3760908e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 16:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717891177; x=1718495977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwtXIQBojG/SNPIqYfSPugqMoxhpM0jyYnzPwfvGpME=;
        b=cuKNHWkhNLWtUJyv5ucatI8Lfv+geXsN5bX8iegUC9F9W/T+bYuDd9qfZxarl1S2MR
         t4nrluBXSGRzQuPG58L1mjUJdcrjhAF3ldQzGV67ka++ttfMw09zvd+DFV752ATsDs8+
         jFeBWaqUQ44xlZ1ODZkK4I1jxWvB20v/VW0Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717891177; x=1718495977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwtXIQBojG/SNPIqYfSPugqMoxhpM0jyYnzPwfvGpME=;
        b=Cpjg3YzOqu8LcOPodu6rRzAggzSx7uwtJ2FkRbJTXIUJErmZ+pDikUS1CVC34RmeHx
         6izjCWXqiZ0V17ayCfbjbQVyf15WXiM02ZTIBCUsbfoQPKFBWGEMSrF4ZBI6zOlHhhdc
         b5rlTr3i5V59k+H31XDjcxJvM+f8q1+DI5Kw5xtyYCB+OL4BbfqulLj62s2Au3RXxpWR
         BrkDnSEuYbts7looJBba8qLjRtAooZ1/Gab239xzzW1HI5xxBhDugDwrmiFwSIYxkd7A
         /hrJZR4VnjqR9r/zhK0HhlXuwenx1SXqdRuEBUIetk9CoaatsLf4p/aUH8JPgKlXIvKh
         f25g==
X-Forwarded-Encrypted: i=1; AJvYcCWiQAJqj3qTnhcKdBVI5EqiEVx+vVddvUbYoDiCRXiITwbMOtAAaZ1ppOfTqAv7CEt3E0dTKgCSjX+eyQBjO30YFTn9Z9v1kX2J0o39
X-Gm-Message-State: AOJu0YwLN02zQponl03TahP31YO9MqMoj6TSzyxkOlJ346LQ9jPmOw7+
	1Hp5YmqLO50vkVtCd62sw0wu7vrSo+gmS0DwjtF7RqhD0nPNXIGr7bPtMjRqR8nU/I/PlNBpuU1
	hAL3ZkGR7Zp2MJcPDyoEOoonXmo1PUsNpiXQ=
X-Google-Smtp-Source: AGHT+IFmEiTWpR25JvtyJ3tGNwBJDyIYISzlE4IEQahxn8OLYNhyVTR6rAF+fnqiYye4wSnLPdqpgVM5ukwChTt6XKs=
X-Received: by 2002:a05:6512:2ed:b0:52c:82d9:66b8 with SMTP id
 2adb3069b0e04-52c82d96730mr929394e87.36.1717891177214; Sat, 08 Jun 2024
 16:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <CALwA+NZ7Cdd9M2Cus+Lv3yoc+eWNdUjCmECGJbfoin3ikHLbxQ@mail.gmail.com>
 <CAJfuBxxus5_0=ydNWwQhDNhe1++oh8nBe-+3Egt6mKk_W=0w3w@mail.gmail.com>
 <CALwA+NbtX4pkFm35L7bjL0D-c=RMOu7vVC0=cUg4Q6n7uD=u-A@mail.gmail.com> <CAJfuBxyZdxziS-d=3Ctjr4xyKoUX_GXEskKRMWco32c9Y1_WFA@mail.gmail.com>
In-Reply-To: <CAJfuBxyZdxziS-d=3Ctjr4xyKoUX_GXEskKRMWco32c9Y1_WFA@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Sun, 9 Jun 2024 01:59:25 +0200
Message-ID: <CALwA+NY74=708BKFLNMbdQ0Xm3gTSKXTq-8EuLnW9ojZJczRwg@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 00/33] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y regression
To: jim.cromie@gmail.com
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 6:48=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>
> hi =C5=81ukasz,
> sorry for the late reply..
>
>
> On Wed, May 29, 2024 at 4:01=E2=80=AFPM =C5=81ukasz Bartosik <ukaszb@chro=
mium.org> wrote:
>>
>> On Mon, May 27, 2024 at 5:45=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>> >
>> > hi =C5=81ukasz
>> >
>> > thanks for testing, and with all the config combos
>> > that uncovered this problem.
>> >
>> > On Sun, May 26, 2024 at 4:36=E2=80=AFPM =C5=81ukasz Bartosik <ukaszb@c=
hromium.org> wrote:
>> > >
>> > > On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail=
.com> wrote:
>> > > >
>> > > > hi Greg, Jason,
>> > > >
>> > > > This patchset fixes the CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy regressio=
n,
>> > > > Fixes: bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")
>> > > >
>> > > > Im calling it v8, to keep consistent with previous labels.
>> > > > v6 was what got committed, back in 9/2022.
>> > > > v7 had at least 2 problems that blocked its submission:
>> > > >
>> > > >  https://lore.kernel.org/lkml/20231101002609.3533731-1-jim.cromie@=
gmail.com/
>> > > >  https://patchwork.freedesktop.org/series/125066/
>> > > >
>> > > > 1. missing __align(8) in METATDATA macro, giving too much placemen=
t
>> > > > freedom to linker, caused weird segvs following non-ptr vals, but =
for
>> > > > builtin modules only. found by lkp-test.
>> > > >
>> > > > 2. the main patch touched 2 subsystems at once, which would requir=
e
>> > > > special handling.
>> > > >
>> > > > What was broken about DYNAMIC_DEBUG ?
>> > > >
>> > > > Booting a modular kernel with drm.debug=3D0x1ff enabled pr_debugs =
only
>> > > > in drm itself, not in the yet-to-be loaded driver + helpers.  Once
>> > > > loaded, the driver's pr_debugs are properly enabled by:
>> > > >
>> > > >    echo 0x1ff > /sys/module/drm/parameters/debug  # still worked
>> > > >
>> > > > I had tested with scripts doing lots of modprobes with various
>> > > > permutations of dyndbg=3D<> option, and I missed that I didn't tes=
t
>> > > > without them.
>> > > >
>> > > > The deeper cause was my design error, a violation of the K&R rule:
>> > > > "define once, refer many times".
>> > > >
>> > > > DECLARE_DYNDBG_CLASSMAP defined the classmap, and was used everywh=
ere,
>> > > > re-declaring the same static classmap repeatedly. Jani Nikula actu=
ally
>> > > > picked up on this (iirc shortly after committed), but the problem
>> > > > hadn't been seen yet in CI.  One patchset across 2 subsystems didn=
't
>> > > > help either.
>> > > >
>> > > > So the revised classmap API "splits" it to def & ref:
>> > > >
>> > > > DYNDBG_CLASSMAP_DEFINE fixes & updates the busted macro, EXPORTing=
 the
>> > > > classmap instead.  It gets invoked once per subsystem, by the
>> > > > parent/builtin, drm.ko for DRM.
>> > > >
>> > > > DYNDBG_CLASSMAP_USE in drivers and helpers refer to the classmap b=
y
>> > > > name, which links the 2 modules, (like a driver's dependency on ex=
tern
>> > > > __drm_debug).
>> > > >
>> > > > These 2 tell dyndbg to map "class FOO" to the defined FOO_ID, whic=
h
>> > > > allows it to make those changes via >control, in both class define=
r
>> > > > modules and dependent modules.
>> > > >
>> > > > DYNDBG_CLASSMAP_PARAM*, defines the controlling kparam, and binds =
it
>> > > > to both the _var, and the _DEFINEd classmap.  So drm uses this to =
bind
>> > > > the classmap to __drm_debug.
>> > > >
>> > > > It provides the common control-point for the sub-system; it is app=
lied
>> > > > to the class'd pr_debugs during modprobe of both _DEFINEr and USEr=
s.
>> > > > It also enforces the relative nature of LEVEL classmaps, ie V3>V2.
>> > > >
>> > > > DECLARE_DYNDBG_CLASSMAP is preserved to decouple the DRM patches, =
so
>> > > > they can be applied later.  I've included them for anyone who want=
s to
>> > > > test against DRM now.
>> > > >
>> > > > A new struct and elf section contain the _USEs; on modprobe, these=
 are
>> > > > scanned similarly to the _DEFINEs, but follow the references to th=
eir
>> > > > defining modules, find the kparam wired to the classmap, and apply=
 its
>> > > > classmap settings to the USEr.  This action is what V1 missed, whi=
ch
>> > > > is why drivers failed to enable debug during modprobe.
>> > > >
>> > > > In order to recapitulate the regression scenario without involving
>> > > > DRM, the patchset adds test_dynamic_debug_submod, which is a dupli=
cate
>> > > > of its parent; _submod.c #defines _SUBMOD, and then includes paren=
t.
>> > > >
>> > > > This puts _DEFINE and _USE close together in the same file, for
>> > > > obviousness, and to guarantee that the submod always has the same
>> > > > complement of debug()s, giving consistent output from both when
>> > > > classmaps are working properly.
>> > > >
>> > > > Also ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh ad=
ds a
>> > > > turn-key selftest.  I pulled it forward from a dyndbg-to-trace pat=
chset
>> > > > that I and Lukasz Bartozik have been working out.
>> > > >
>> > > > It works nicely from virtme-ng:
>> > > >
>> > > > [jimc@frodo vx]$ vrun_ -- ./tools/testing/selftests/dynamic_debug/=
dyndbg_selftest.sh
>> > > > doing: vng --verbose --name v6.9-rc5-34-g2f1ace6e1c68 \
>> > > >        --user root --cwd ../.. \
>> > > >        -a dynamic_debug.verbose=3D2 -p 4 \
>> > > >        -- ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.=
sh
>> > > > virtme: waiting for virtiofsd to start
>> > > > ...
>> > > > [    3.546739] ip (260) used greatest stack depth: 12368 bytes lef=
t
>> > > > [    3.609288] virtme-init: starting script
>> > > > test_dynamic_debug_submod not there
>> > > > test_dynamic_debug not there
>> > > > # BASIC_TESTS
>> > > > ...
>> > > > # Done on: Fri Apr 26 20:45:08 MDT 2024
>> > > > [    4.765751] virtme-init: script returned {0}
>> > > > Powering off.
>> > > > [    4.805790] ACPI: PM: Preparing to enter system sleep state S5
>> > > > [    4.806223] kvm: exiting hardware virtualization
>> > > > [    4.806564] reboot: Power down
>> > > > [jimc@frodo vx]$
>> > > >
>> > > >
>> > > > I've been running the kernel on my x86 desktop & laptop, booting w=
ith
>> > > > drm.debug=3D0x1f, then turning it all-off after sleep 15.
>> > > >
>> > > > a few highlights from a bare-metal boot:
>> > > >
>> > > > here modprobe amdgpu; dyndbg applies last bit/class/category, and
>> > > > finishes init, then drm and amdgpu start logging as they execute
>> > > >
>> > > > [    9.019696] gandalf kernel: dyndbg: query 0: "class DRM_UT_ATOM=
IC +p" mod:amdgpu
>> > > > [    9.019704] gandalf kernel: dyndbg: class-ref: amdgpu.DRM_UT_AT=
OMIC  module:amdgpu nd:4754 nc:0 nu:1
>> > > > [    9.020012] gandalf kernel: dyndbg: processed 1 queries, with 2=
1 matches, 0 errs
>> > > > [    9.020017] gandalf kernel: dyndbg: bit_4: 21 matches on class:=
 DRM_UT_ATOMIC -> 0x1f
>> > > > [    9.020021] gandalf kernel: dyndbg: applied bitmap: 0x1f to: 0x=
0 for amdgpu
>> > > > [    9.020026] gandalf kernel: dyndbg: attach-client-module:  modu=
le:amdgpu nd:4754 nc:0 nu:1
>> > > > [    9.020031] gandalf kernel: dyndbg: 4754 debug prints in module=
 amdgpu
>> > > > [    9.055065] gandalf kernel: [drm] amdgpu kernel modesetting ena=
bled.
>> > > > [    9.055138] gandalf kernel: [drm:amdgpu_acpi_detect [amdgpu]] N=
o matching acpi device found for AMD3000
>> > > > [    9.055564] gandalf kernel: amdgpu: Virtual CRAT table created =
for CPU
>> > > > [    9.055585] gandalf kernel: amdgpu: Topology: Add CPU node
>> > > > [    9.055752] gandalf kernel: amdgpu 0000:0c:00.0: enabling devic=
e (0006 -> 0007)
>> > > > [    9.055821] gandalf kernel: [drm] initializing kernel modesetti=
ng (NAVI10 0x1002:0x731F 0x148C:0x2398 0xC1).
>> > > > [    9.055835] gandalf kernel: [drm] register mmio base: 0xFCB0000=
0
>> > > > [    9.055839] gandalf kernel: [drm] register mmio size: 524288
>> > > > [    9.059148] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks=
 [amdgpu]] number of dies: 1
>> > > > [    9.059387] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks=
 [amdgpu]] number of hardware IPs on die0: 39
>> > > > [    9.059623] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks=
 [amdgpu]] ATHUB(35) #0 v2.0.0:
>> > > > [    9.059856] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks=
 [amdgpu]]         0x00000c00
>> > > > [    9.060096] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks=
 [amdgpu]]         0x02408c00
>> > > > [    9.060328] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks=
 [amdgpu]] set register base offset for ATHUB
>> > > >
>> > > > a startup script, after sleep 15, turns off the logging:
>> > > >
>> > > >   echo 0 > /sys/module/drm/parameters/debug
>> > > >
>> > > > heres 1st 2 bits/classes/categories being turned off:
>> > > >
>> > > > [   29.105991] gandalf kernel: [drm:amdgpu_ih_process [amdgpu]] am=
dgpu_ih_process: rptr 90752, wptr 90784
>> > > > [   29.118086] gandalf kernel: dyndbg: bits:0x0 > *.debug
>> > > > [   29.118096] gandalf kernel: dyndbg: apply bitmap: 0x0 to: 0x1f =
for '*'
>> > > > [   29.118102] gandalf kernel: dyndbg: query 0: "class DRM_UT_CORE=
 -p" mod:*
>> > > > [   29.118122] gandalf kernel: dyndbg: good-class: drm.DRM_UT_CORE=
  module:drm nd:338 nc:1 nu:0
>> > > > [   29.119548] gandalf kernel: dyndbg: class-ref: drm_kms_helper.D=
RM_UT_CORE  module:drm_kms_helper nd:93
>> > > > nc:0 nu:1
>> > > > [   29.119552] gandalf kernel: dyndbg: class-ref: drm_display_help=
er.DRM_UT_CORE  module:drm_display_helper nd:151 nc:0 nu:1
>> > > > [   29.119737] gandalf kernel: dyndbg: class-ref: amdgpu.DRM_UT_CO=
RE  module:amdgpu nd:4754 nc:0 nu:1
>> > > > [   29.122181] gandalf kernel: [drm:amdgpu_ih_process [amdgpu]] am=
dgpu_ih_process: rptr 90784, wptr 90816
>> > > > [   29.127687] gandalf kernel: dyndbg: processed 1 queries, with 4=
66 matches, 0 errs
>> > > > [   29.127690] gandalf kernel: dyndbg: bit_0: 466 matches on class=
: DRM_UT_CORE -> 0x0
>> > > > [   29.127692] gandalf kernel: dyndbg: query 0: "class DRM_UT_DRIV=
ER -p" mod:*
>> > > > [   29.127696] gandalf kernel: dyndbg: good-class: drm.DRM_UT_DRIV=
ER  module:drm nd:338 nc:1 nu:0
>> > > > [   29.127699] gandalf kernel: dyndbg: class-ref: drm_kms_helper.D=
RM_UT_DRIVER  module:drm_kms_helper nd:93 nc:0 nu:1
>> > > > [   29.127701] gandalf kernel: dyndbg: class-ref: drm_display_help=
er.DRM_UT_DRIVER  module:drm_display_helper nd:151 nc:0 nu:1
>> > > > [   29.127885] gandalf kernel: dyndbg: class-ref: amdgpu.DRM_UT_DR=
IVER  module:amdgpu nd:4754 nc:0 nu:1
>> > > > [   29.152925] gandalf kernel: dyndbg: processed 1 queries, with 1=
384 matches, 0 errs
>> > > >
>> > > >
>> > > > The resulting journal is ~14.6k lines, written in the 1st 15 (29)
>> > > > seconds of startup.  I'm unsure what the 15/29 discrepancy might
>> > > > indicate/betray, besides a lot of logging work.  sleep 15 is not t=
he
>> > > > best stopwatch.
>> > > >
>> > > > Recent spins thru lkp-test have also been SUCCESS-ful.
>> > > >
>> > > > CC: Lukas Bartosik <ukaszb@chromium.org>
>> > > > CC: Kees Cook <keescook@chromium.org>   # recent selftests/ review=
s
>> > > >
>> > > > Jim Cromie (33):
>> > > >
>> > > > cleanups & preparations:
>> > > >   docs/dyndbg: update examples \012 to \n
>> > > >   test-dyndbg: fixup CLASSMAP usage error
>> > > >   dyndbg: reword "class unknown," to "class:_UNKNOWN_"
>> > > >   dyndbg: make ddebug_class_param union members same size
>> > > >   dyndbg: replace classmap list with a vector
>> > > >   dyndbg: ddebug_apply_class_bitmap - add module arg, select on it
>> > > >   dyndbg: split param_set_dyndbg_classes to _module & wrapper fns
>> > > >   dyndbg: drop NUM_TYPE_ARRAY
>> > > >   dyndbg: reduce verbose/debug clutter
>> > > >   dyndbg: silence debugs with no-change updates
>> > > >   dyndbg: tighten ddebug_class_name() 1st arg type
>> > > >   dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
>> > > >   dyndbg: reduce verbose=3D3 messages in ddebug_add_module
>> > > >   dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
>> > > >
>> > > > core fix & selftests:
>> > > >   dyndbg-API: fix DECLARE_DYNDBG_CLASSMAP
>> > > >   selftests-dyndbg: add tools/testing/selftests/dynamic_debug/*
>> > > >   selftests-dyndbg: exit 127 if no facility
>> > > >   dyndbg-API: promote DYNDBG_CLASSMAP_PARAM to API
>> > > >   dyndbg-doc: add classmap info to howto
>> > > >   dyndbg: treat comma as a token separator
>> > > >   selftests-dyndbg: add comma_terminator_tests
>> > > >   dyndbg: split multi-query strings with %
>> > > >   selftests-dyndbg: test_percent_splitting multi-cmds on module cl=
asses
>> > > >   docs/dyndbg: explain new delimiters: comma, percent
>> > > >   selftests-dyndbg: add test_mod_submod
>> > > >   selftests-dyndbg: test dyndbg-to-tracefs
>> > > >   dyndbg-doc: explain flags parse 1st
>> > > >
>> > > > DRM parts
>> > > >   drm+drivers: adapt to use DYNDBG_CLASSMAP_{DEFINE,USE}
>> > > >   drm-dyndbg: adapt to use DYNDBG_CLASSMAP_PARAM
>> > > >   drm: use correct ccflags-y spelling
>> > > >   drm-drivers: DRM_CLASSMAP_USE in 2nd batch of drivers, helpers
>> > > >   drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
>> > > >   drm-print: workaround compiler meh
>> > > >
>> > > >  .../admin-guide/dynamic-debug-howto.rst       |  99 ++-
>> > > >  MAINTAINERS                                   |   3 +-
>> > > >  drivers/gpu/drm/Kconfig                       |   3 +-
>> > > >  drivers/gpu/drm/Makefile                      |   3 +-
>> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +-
>> > > >  drivers/gpu/drm/display/drm_dp_helper.c       |  12 +-
>> > > >  drivers/gpu/drm/drm_crtc_helper.c             |  12 +-
>> > > >  drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +
>> > > >  drivers/gpu/drm/drm_print.c                   |  38 +-
>> > > >  drivers/gpu/drm/gud/gud_drv.c                 |   2 +
>> > > >  drivers/gpu/drm/i915/i915_params.c            |  12 +-
>> > > >  drivers/gpu/drm/mgag200/mgag200_drv.c         |   2 +
>> > > >  drivers/gpu/drm/nouveau/nouveau_drm.c         |  12 +-
>> > > >  drivers/gpu/drm/qxl/qxl_drv.c                 |   2 +
>> > > >  drivers/gpu/drm/radeon/radeon_drv.c           |   2 +
>> > > >  drivers/gpu/drm/udl/udl_main.c                |   2 +
>> > > >  drivers/gpu/drm/vkms/vkms_drv.c               |   2 +
>> > > >  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   2 +
>> > > >  include/asm-generic/vmlinux.lds.h             |   1 +
>> > > >  include/drm/drm_print.h                       |  10 +
>> > > >  include/linux/dynamic_debug.h                 | 127 ++-
>> > > >  kernel/module/main.c                          |   3 +
>> > > >  lib/Kconfig.debug                             |  24 +-
>> > > >  lib/Makefile                                  |   3 +
>> > > >  lib/dynamic_debug.c                           | 435 ++++++----
>> > > >  lib/test_dynamic_debug.c                      | 131 +--
>> > > >  lib/test_dynamic_debug_submod.c               |  17 +
>> > > >  tools/testing/selftests/Makefile              |   1 +
>> > > >  .../testing/selftests/dynamic_debug/Makefile  |   9 +
>> > > >  tools/testing/selftests/dynamic_debug/config  |   2 +
>> > > >  .../dynamic_debug/dyndbg_selftest.sh          | 765 +++++++++++++=
+++++
>> > > >  31 files changed, 1391 insertions(+), 359 deletions(-)
>> > > >  create mode 100644 lib/test_dynamic_debug_submod.c
>> > > >  create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
>> > > >  create mode 100644 tools/testing/selftests/dynamic_debug/config
>> > > >  create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_s=
elftest.sh
>> > > >
>> > > > --
>> > > > 2.45.0
>> > > >
>> > >
>> > > Jim,
>> > >
>> > > With the TEST_DYNAMIC_DEBUG=3DM and TEST_DYNAMIC_DEBUG_SUBMOD=3DM se=
lf test passes
>> > > .../selftests/dynamic_debug# ./dyndbg_selftest.sh
>> > > # BASIC_TESTS
>> > > # COMMA_TERMINATOR_TESTS
>> > > # TEST_PERCENT_SPLITTING - multi-command splitting on %
>> > > # TEST_MOD_SUBMOD
>> > >
>> > > However when (TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=
=3DY) or
>> > >                          (TEST_DYNAMIC_DEBUG=3DY and
>> > > TEST_DYNAMIC_DEBUG_SUBMOD=3DM) self test fails with
>> > >
>> > > # TEST_PERCENT_SPLITTING - multi-command splitting on %
>> > > test_dynamic_debug_submod not there
>> > > test_dynamic_debug not there
>> > > : ./dyndbg_selftest.sh:240 check failed expected 1 on =3Dpf, got 0
>> > >
>> > > This happens because module is compiled into kernel and the followin=
g
>> > > line does not modify classmaps
>> > > modprobe test_dynamic_debug
>> > > dyndbg=3Dclass,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
>> > >
>> > > Maybe selftest could verify if a module is compiled into a kernel an=
d
>> > > in such a case instead of calling modprobe as in the line above
>> > > just do:
>> > > ddcmd class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
>> > >
>> > > What do you think ?
>> > >
>> >
>> > You found that problem by manual testing ?
>> >
>>
>> Yes I found it when testing manually.
>>
>> > [jimc@frodo linux.git]$ cat tools/testing/selftests/dynamic_debug/conf=
ig
>> > CONFIG_TEST_DYNAMIC_DEBUG=3Dm
>> > CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=3Dm
>> >
>> > Im guessing that config file prevents the problem conf from getting te=
sted in:
>> >   make run_tests    # in selftests dir
>> >
>> > so at least it shouldnt cause CI failures.
>> > Is there any regular run-&-report of selftests I can subscribe to ?
>> >
>> > on defconfig (iirc), I got:
>> >
>> > [root@v6 linux.git]# ./tools/testing/selftests/dynamic_debug/dyndbg_se=
lftest.sh
>> > : kernel not configured for this test
>> >
>> > [ -e /proc/dynamic_debug/control ] || {
>> >     echo -e "${RED}: kernel not configured for this test ${NC}"
>> >     exit 127
>> > }
>> >
>> > 1. We could add some more conditions to give up early.
>> > 2. Or we could avoid the mod-submod test if both modules arent modular=
.
>> > (those are both easy-outs)
>> >
>> > Also, builtin test modules are an unlikely choice generally.
>> >
>> > Or, as you suggest, do something like
>> > modprobe_or_apply_control( dyndbg_cmd_arg )
>> > rmmod_or_undo_control ( undo_cmd_arg )
>> >
>> > This is probably most thorough,
>> > but it might be a game of whack-a-mole;
>> > the test script exits at 1st failure,
>> > there may be a bunch of them.
>> >
>>
>> Alternatively there is a kernel configuration option
>> CONFIG_IKCONFIG_PROC which enables
>> access to .config through /proc/config.gz so for the purpose of dyndbg
>> self test it could be required to be enabled.
>> With /proc/.config.gz available the information whether a module is Y
>> or M is easy to reach.
>>
>
> I dont want it as a requirement, but we can add it later.
>
> KCONFIG_CONFIG exists to convey the config thru the build process,
> The selftest will now check the envar, grep the named file if any,
> and limit testing accordingly.  if no info, test everything.
>
> the selftests/dynamic_debug/.config will still avoid testing configs
> without the test modules selected, so only manual testing would get past =
that.
>
>
> so for a CONFIG_DYNAMIC_DEBUG_CORE=3DY only build
> (no builtin pr_debugs exist, so builtin tests fail)
>
> [root@v6 linux.git]# ./tools/testing/selftests/dynamic_debug/dyndbg_selft=
est.sh
> test_dynamic_debug_submod not there
> test_dynamic_debug not there
> # BASIC_TESTS
> [   68.273466] dyndbg: read 3 bytes from userspace
> [   68.273935] dyndbg: query 0: "=3D_" mod:*
> [   68.274294] dyndbg: processed 1 queries, with 0 matches, 0 errs
> : 0 matches on =3Dp
> [   68.328059] dyndbg: read 41 bytes from userspace
> [   68.328568] dyndbg: query 0: "module main file kernel/module/main.c +p=
" mod:*
> [   68.329273] dyndbg: processed 1 queries, with 0 matches, 0 errs
> : ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:228 check fa=
iled expected 14 on =3Dp, got 0
> [root@v6 linux.git]# KCONFIG_CONFIG=3D./builds/ddcore ./tools/testing/sel=
ftests/dynamic_debug/dyndbg_selftest.sh
> test_dynamic_debug_submod not there
> test_dynamic_debug not there
> # BASIC_TESTS
> [   92.930487] dyndbg: read 3 bytes from userspace
> [   92.930909] dyndbg: query 0: "=3D_" mod:*
> [   92.931264] dyndbg: processed 1 queries, with 0 matches, 0 errs
> : 0 matches on =3Dp
> [   92.961244] dyndbg: read 41 bytes from userspace
> [   92.961843] dyndbg: query 0: "module main file kernel/module/main.c +p=
" mod:*
> [   92.962601] dyndbg: processed 1 queries, with 0 matches, 0 errs
> : ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:228 check fa=
iled expected 14 on =3Dp, got 0
>
> again, expected builtins werent there.
>
> but with the config available, the BASIC TESTS are skipped
>
> [root@v6 linux.git]# KCONFIG_CONFIG=3D./builds/ddcore/.config ./tools/tes=
ting/selftests/dynamic_debug/dyndbg_selftest.sh
> # using KCONFIG_CONFIG: ./builds/ddcore/.config

The solution with the KCONFIG_CONFIG makes sense to me. Thanks.

> test_dynamic_debug_submod not there
> test_dynamic_debug not there
> # BASIC_TESTS
> SKIP
>
> # COMMA_TERMINATOR_TESTS
> SKIP
>
> # TEST_PERCENT_SPLITTING - multi-command splitting on %
> ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh: line 264: [: =
-eq: unary operator expected
> test_dynamic_debug_submod not there
> test_dynamic_debug not there
> [  117.690222] dyndbg: read 3 bytes from userspace
> [  117.690719] dyndbg: query 0: "=3D_" mod:*
> [  117.691057] dyndbg: processed 1 queries, with 0 matches, 0 errs
> [  117.727391] dyndbg: classes[0]: module:test_dynamic_debug base:14 len:=
8 type:LEVEL_NUM
> [  117.728131] dyndbg: classes[1]: module:test_dynamic_debug base:0 len:1=
0 type:DISJOINT_BITS
> [  117.728855] dyndbg: module:test_dynamic_debug attached 2 classes
> [  117.729387] dyndbg: loaded class: module:test_dynamic_debug base:14 le=
n:8 type:LEVEL_NUM
> [  117.730099] dyndbg:  found kp:p_level_num =3D0x0
>
>>
>> > at least part of the problem is that rmmod really wipes all the
>> > pr-debug settings,
>> > which is a pretty strong precondition for the next test.
>> >
>> > while not as robust as a full prdbg-state wipe,
>> > the undo_arg could certainly undo the dyndbg_cmd_arg.
>> > its a bit fiddly, but maybe just fiddle-once.
>> >
>> > Im thinking that a combo of 1, 2 would suffice.
>> > And we could probably drop the config constraints,
>> > especially if the test avoids failing on configs where a failure is ex=
pected.
>> > IOW - if no test-modules/builtins, run only 1st 3 tests, ending with P=
ERCENT
>> >
>> > That said, I wonder if the exit 127 should be success instead ?
>> >
>>
>> I don't follow you here. Could you please elaborate why exit 127
>> should be a success ?
>>
>
> well exit 127 is sort-of a monkey-patch.
>
> (this) monkey sees it used in git bisect to communicate a "special" failu=
re
> to a framework / harness that knows what to do with it.
>
> I have no substantive basis to think thats what selftests wants.  RFC.
>
> the reason to call it success is that its not a fail where a pass is reas=
onably expected.
> Not having /proc/dynamic_debug/control is probably intentional,
> and not something we should fail on.
>
>
>>
>> > thanks Lukas,
>> > ~jimc
>> >
>> > > Thanks,
>> > > Lukasz

