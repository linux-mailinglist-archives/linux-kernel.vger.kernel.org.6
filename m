Return-Path: <linux-kernel+bounces-182659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6968C8DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA451C21D08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3321411CD;
	Fri, 17 May 2024 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xveNHRdu"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF01A2C20
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715982704; cv=none; b=oqP9NtzBMaqrzCLUYrgV3b15KmnVp/S/EtwG4DrbC8p5HAVLv02ODoeRvItPAGlzy+py0GaagEtvg6x2ZATtDfRzH/JkoWpqIE9zfsIUTkWxWMQoiOxy+ASgVfP93LMgl3NmW7NKM42bhjoa9Tno8IBJTuklMZEbgmNwR1hJfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715982704; c=relaxed/simple;
	bh=0BnsCVzy0id/M//gXYNHDgKFcuT3ZsFHq/dlbbTEOFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fw65wDagAx0NOUOPE7hGzXttcuybzLcCNqHGCpRMYp5Vy/8B1qmOUDHavhB1l8x/UphJ5IwObC/6N+kh9Lf/a7OPf/zc+5dASijvoHe/18w2zCjegxJfcxFyxLX+2xCYkwkYZ67vldaJaE2cWugN9K+eYQCdqk17XViou+gVYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xveNHRdu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso5415ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715982703; x=1716587503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BnsCVzy0id/M//gXYNHDgKFcuT3ZsFHq/dlbbTEOFo=;
        b=xveNHRduf9vHMQT0zku245gxxkXc5VxYLQgni79eiuLEJdgIM6k6eI9EOLI/6FMtc7
         5eki17w0dP69P2lJvbsJ1JWA2N4FM1KG7baQtNnFt2Ohug8yTqJcyfSuT33g1NtUmw8W
         Nih2bX8uFtmcexi5DKbzDilt9rZZDdkiT0958RxygA/gtBURhq50wpVNFyXo/UB4KQdX
         efoNhhkw1D/4rU7XNXrP61RdY4FA4ATSvUzQ21WOt3JQUfWj2BvpXoBaYd9Niv+kLQXn
         o/EZr7egZdtJhK3GgaZKTnrCzIaDbznMZTeak9SNQeusu/3gk2c74zNF4VpJULHgLYeJ
         96fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715982703; x=1716587503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BnsCVzy0id/M//gXYNHDgKFcuT3ZsFHq/dlbbTEOFo=;
        b=Z7cA4ttr0Ag/Q3wPMHa2Nl+J1v5JiJ1ShMAvHaZ7Pd3l8+fIyLmYdnOQTIfTsYdJqv
         AMj3mnTJLOYnW4aXneBbtSAF2ettet9kOnlg7o7vuQyMBKaCGUfW6+mNcec19zsadP++
         Pw95wVLyZbtoBgcb1N0+T5HAjEkcTPd3nXa40z8AInu5I67MtCVSqErEu2C3k7QlJHrC
         JN3ceXYMDquRGAZIfeHQ5SdBUE+IUdL6GF/a1dqGV+xIFvoFhCwB1mx7edqxRb8+2f9z
         T1mVReJIEji6YG4I98Ovvy6wTsFvi8QeLsj+l/SnwQSotI2YwZA+GmCSboNJSKSm2o4Q
         /Urw==
X-Forwarded-Encrypted: i=1; AJvYcCWlYVFZUskMpUuFuX8ILnGTJcuH9IXqvBCvlZku9uzdV0gNdW3xNEjQTnUzAjfKtsYU24+MQYZn7vVCSpOY379qXZ4W7dIG0vXiCLU+
X-Gm-Message-State: AOJu0Yw3nOGvSqROW9Hp/ZoL0Vv4fBLbfFre5GdcOu4yeabeymace6z6
	DmRwkQZVk9s0CEB3zB5wIbMNfEx97EHSH+bBWKyUpwuziK8BQJuEQ19knJM+6E16ANMozfJLcv0
	CbQCniEykKN9mIkzzrrgbzE/gW988ANJTshji
X-Google-Smtp-Source: AGHT+IG+91I7rOKF2t9bNu6iWny0Jc+Pde2JFYBdmetZyANUcgW1VcEP8hO1J4SqD4XvoLgf2WRbUrcQCYEpWmxMRQM=
X-Received: by 2002:a17:903:8c3:b0:1e2:73a9:7df6 with SMTP id
 d9443c01a7336-1f2ee0b1ebdmr195265ad.23.1715982702348; Fri, 17 May 2024
 14:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711674410.git.babu.moger@amd.com> <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com> <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
 <6edffe1b-e9a9-4995-8172-353efc189666@amd.com> <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
 <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com>
 <b725e4ca-8602-eb26-9d47-914526621f52@amd.com> <CALPaoCiu2_UHyGjsyitz28BL1N93TSn28E1r-6nhXg--bzmU+Q@mail.gmail.com>
 <d7f3c5b1-c39d-4c66-92c3-5b096b9e0579@intel.com>
In-Reply-To: <d7f3c5b1-c39d-4c66-92c3-5b096b9e0579@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 17 May 2024 14:51:28 -0700
Message-ID: <CALPaoCiJ9ELXkij-zsAhxC1hx8UUR+KMPJH6i8c8AT6_mtXs+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, corbet@lwn.net, fenghua.yu@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette, Babu,

On Fri, May 3, 2024 at 2:15=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 5/3/2024 2:00 PM, Peter Newman wrote:
> > Hi Babu,
> >
> > On Fri, May 3, 2024 at 1:44=E2=80=AFPM Moger, Babu <bmoger@amd.com> wro=
te:
> >>
> >> Hi Peter,
> >>
> >> On 5/2/2024 7:57 PM, Peter Newman wrote:
> >>> Hi Reinette,
> >>>
> >>> On Thu, May 2, 2024 at 4:21=E2=80=AFPM Reinette Chatre
> >>>> I do think ABMC should be enabled by default when available and it l=
ooks
> >>>> to be what this series aims to do [1]. The way I reason about this i=
s
> >>>> that legacy user space gets more reliable monitoring behavior withou=
t
> >>>> needing to change behavior.
> >>>
> >>> I don't like that for a monitor assignment-aware user, following the
> >>> creation of new monitoring groups, there will be less monitors
> >>> available for assignment. If the user wants precise control over wher=
e
> >>> monitors are allocated, they would need to manually unassign the
> >>> automatically-assigned monitor after creating new groups.
> >>>
> >>> It's an annoyance, but I'm not sure if it would break any realistic
> >>> usage model. Maybe if the monitoring agent operates independently of
> >>
> >> Yes. Its annoyance.
> >>
> >> But if you think about it, normal users don't create too many groups.
> >> They wont have to worry about assign/unassign headache if we enable
> >> monitor assignment automatically. Also there is pqos tool which uses
> >> this interface. It does not have to know about assign/unassign stuff.
> >
> > Thinking about this again, I don't think it's much of a concern
> > because the automatic assignment on mongroup creation behavior can be
> > trivially disabled using a boolean flag.
>
> This could be a config option.

I'd like to work out the details of this option.

info/L3_MON/mbm_assign_on_mkdir?

boolean (parsed with kstrtobool()), defaulting to true?

-Peter

