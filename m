Return-Path: <linux-kernel+bounces-395027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3EF9BB74E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1E01F20F91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC710139D04;
	Mon,  4 Nov 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQi5W3sx"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E301C695
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729776; cv=none; b=LK3uHu4zuQiGDbtPz6mPq6ZWIvczu4DqteT+qrh/9jc822myuI5TyaumSsWzmK8Fr7DtXMXrZvPyzEHYCATno52mYLohPNDfAqN+MhPZQIwMm/Tg0P/dHXSkMr+9yl9EHYKV+E+TP2NNOYpjNdnos6CQYkJgREXymEduYiGveIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729776; c=relaxed/simple;
	bh=rxLe7Y9dqzlB+Lxzy1TU9l7LFoc0kg5jLg97h5pT9qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiX2k0dzxsGyZoEl5blM0FXDAMF9LEhcQ6se2FLtmcfkltZWDN+Qk4PgE1P44PSA9GToTtaekraQzhg9uHydzdn2kd3/0DBDQYE32uuTXuCkyHzCUPMNOlnxxKRdjyV0IrLViPjD+jkQPFjzZ0V0wYBzuSiaxeA9TcFUC0AcZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQi5W3sx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9eaf93e40dso2767166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730729772; x=1731334572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxLe7Y9dqzlB+Lxzy1TU9l7LFoc0kg5jLg97h5pT9qI=;
        b=bQi5W3sx4hM0DtYGpUlKNcfEFiJ2anS7PHjerpygiADvOpzBBh0ewFe7suMPF/i2Uz
         L98BYATKHdvOCcpiPNtCj2e0A8oGR2YnfLfEd7FPSOotohqBJVKKOznGlPGHGzS6si4t
         q2lLot8C2eT8xehl/q6hbo2UBhggjexZF0F4/5oUt7cmkTh+4BWQEfGGa5Iss55lSHTC
         ZB6hCpx1IE2F8yU+KSdg2OVIWwFJg4Uo1hgeKcAMnUgFbndARKoVdT21Lxd+Y/bngunv
         QJyWL0R5lN1zfycBKFXvBihHYMBzXfhIGC0W9Vt+ynyw8ml/GBLwQIzWh3TzbOCHU+FC
         SdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729772; x=1731334572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxLe7Y9dqzlB+Lxzy1TU9l7LFoc0kg5jLg97h5pT9qI=;
        b=LecO2itSviSpmkv/3lZ/L8KChVbtPAMvty7tjDTQiHFQTBApPNHDkj48zjlbrOlYUK
         zU3oVXogmrBHNqffrLepd9ec8SJRvP4IkfQ2YWAGi3QYR3D7LS6zC+eyccdJuD+kAozM
         oqNQK8k9i4687XsdJ6pRJYJ3g5AAu3Js4evzW0zQQ5FJ5En3M8DJLcQy+obykRbKT+ML
         sEDVvy8faifXy4Wa6cUiFDsPBiKQX8rOSndAiKN5k1yqlfqHBn3+1aUbKHjlyIHlcaAE
         E/abw7USCm0PwhWJ4LoGmr2hteGp/IGlbse58W4ewSmfPdUT+MBegsvimbCiwABUlpuJ
         mTfw==
X-Forwarded-Encrypted: i=1; AJvYcCVI5j5sDqpSUCxAanbP6qjp8AYt2P4IHPKQ8toDpelprIZ0f2BXfb9JzQH3N8lWQNVHWaLAVCUsXP5VRfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLkvECPIWhBGBO0viwEkacob86OnDMf9AjHRUGm8gb8fFvzB4i
	FpEoFGGe7CvhHlRC62gtAX1KrCn4T4zuGCZPx09Esq8PQUgWRJ2z36VyrEsPruqpr4ZOESTM3R5
	xRMTpS1MLecyG7moZbHCC5QPRYTA+NuzMhZAq
X-Google-Smtp-Source: AGHT+IEQp7CxSTcIpzbhac/Om/w+DYXGFRp4tTHPbDjHlSeM3TjAN+8VSUdY2j7RPrLZVT6+CnlfSBSnLTMAkCgEvdc=
X-Received: by 2002:a17:907:94cd:b0:a9a:230b:fb5e with SMTP id
 a640c23a62f3a-a9de5d6eb83mr3029233366b.4.1730729771530; Mon, 04 Nov 2024
 06:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730244116.git.babu.moger@amd.com> <d27c3a15ccb11c6ba76794eba6cf7c013b0bb074.1730244116.git.babu.moger@amd.com>
In-Reply-To: <d27c3a15ccb11c6ba76794eba6cf7c013b0bb074.1730244116.git.babu.moger@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Mon, 4 Nov 2024 15:16:00 +0100
Message-ID: <CALPaoCh1BWdWww8Kztd13GBaY9mMeZX268fOQgECRytiKm-nPQ@mail.gmail.com>
Subject: Re: [PATCH v9 19/26] x86/resctrl: Add the interface to unassign a MBM counter
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com, 
	paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org, 
	xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com, 
	daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com, 
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com, 
	jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com, 
	ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com, 
	james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com, 
	vikas.shivappa@linux.intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com, 
	eranian@google.com, jpoimboe@kernel.org, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Wed, Oct 30, 2024 at 12:25=E2=80=AFAM Babu Moger <babu.moger@amd.com> wr=
ote:
>
> The mbm_cntr_assign mode provides a limited number of hardware counters
> that can be assigned to an RMID, event pair to monitor bandwidth while
> assigned. If all counters are in use, the kernel will show an error
> message: "Out of MBM assignable counters" when a new assignment is
> requested. To make space for a new assignment, users must unassign an
> already assigned counter.
>
> Introduce an interface that allows for the unassignment of counter IDs
> from both the group and the domain. Additionally, ensure that the global
> counter is released if it is no longer assigned to any domains.

This seems unnecessarily restrictive. What's wrong with monitoring
different groups in different domains?


-Peter

