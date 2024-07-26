Return-Path: <linux-kernel+bounces-263667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA0B93D8E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FD41F219DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEAC47F4D;
	Fri, 26 Jul 2024 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZwDvmxo"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8F32230F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021197; cv=none; b=ATXnehqZ19SnOvS6ScOO5RzVHPx0wvj5gdWEW7bpTOOvAsa6BcSAQwmGAP9X0uHfl8CHwFRhYEFdUChAAifxwMmtbA+2y/rfQSq5L8oZ7E2Da0XjY+86Q5GeVfbvPffdprbU02c8do6BegFWKkgQ8FpMyew4yECcx1MHWzVLSLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021197; c=relaxed/simple;
	bh=Z5UlAtnTF9WSQAqLlLAvp2MEr23WG6FTbF75OVh6LZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvBeII/d3CRLaSH/mBH5KpdbyFpX0F1K6nbreNVuG+xhfENpv4QYZwLzwziyxJsj+g/4DYXxex03WgLv/HTI7+dUky+ViISIScE3iqThAIHdjImvwTUWKKijpbu2uLRizGJFDzRLCxD1YJDxjqLhYHLTXSYKIYdeMBxX3XL0hxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZwDvmxo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so2448a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722021194; x=1722625994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01an1fmFYRDQJTBO7gd4IKDbgwU3h9H9PepxoxmslqI=;
        b=pZwDvmxoW+AXN9Bl/UQD2azp1JAUOFFnnWoG36aOl0TcxntAyppCXy154fr3g9MocZ
         OLIJpn/cO/eyuCDFeAit4FMxJLd3O2mQ9shXtT2aBtdMr0B3Un3/BItft+7x0Sj4awEq
         s+pCI1RtH0Y/f9YldPrzN3rdjGtGyxDjOQtZ5w3I3d5gjEQ+Y9ldLussKKzazOLvC/MM
         oHq4ztKoabScPw1l5SgOfMImflLpoqKHI5hEBzOO0pK3slcLNe/exjpHRhwSbzGtGZBc
         sq+esHfm8zOy8sZO2r/LC7ZNvwz3dZGyGOHuIUeEOGUOQhf8RHZOjukkFJ584gcPJ+B8
         CJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722021194; x=1722625994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01an1fmFYRDQJTBO7gd4IKDbgwU3h9H9PepxoxmslqI=;
        b=e352GVsBTOpJp5aWdH4XMDavBcokjipU27kE8yD4gNWrxEmNEPAdRn2vTvuLvJri72
         cxwQz69O+CZO8wXf+xOK7m419dBhD2RJrBytRDSFVj8BMWUA0AIHjr3HngM0b2/7wpRF
         FsvwHV6fG4p+nq9RARAFSeVipvkHqDCV14HISvESkQksIcRERNnulW8g1Lhd52Jlu+LC
         OmSScw8B0i1DI8ck3oYsuWRCQ998ChjK52vKlX2c/v2eppde+1YOSFFKHVsjNkNzTbZ3
         Ea6Ts/Su33CzXKJ/kMn5osxqBi6O9+gY08aHScPyW7A/C7atN7YaShKeNIQA+Msrw15A
         lRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUApNX/SiYH+zttcX0U4yMpQEm/lQQTiLmlpt1P1S0I3sJns0eo8TR3RcvZfrdh8XKpjfMJON7gMwGQJ3/1cZ4o/KhPYBEPqwUtB9Ax
X-Gm-Message-State: AOJu0Yy1040zITCgKeP9kS8yzO2XtKU2L2fkLGFuO/GqBuKQU53ZqR2E
	G6NRIziuxwjiOD9apB0uOVrGe38wlhU4WIliusxVqSun8goR65f9JexCHA6zreY99GdSDLGV0KL
	e0LlqESfesmOn7G42Owz4r26prpS8wYOjZDC/
X-Google-Smtp-Source: AGHT+IG6mMrOZ4gNjU9BtmgU/rGItqFM0VN7m3T+9TaefO+8m0IQ2eDFcUytlYr/Z0H9vDTWa2qrbVkQjzLAovseISo=
X-Received: by 2002:a05:6402:27c7:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5b034352b98mr13791a12.7.1722021194118; Fri, 26 Jul 2024
 12:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628215619.76401-1-tony.luck@intel.com> <20240628215619.76401-7-tony.luck@intel.com>
In-Reply-To: <20240628215619.76401-7-tony.luck@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 26 Jul 2024 12:13:02 -0700
Message-ID: <CALPaoCihZZXJDYmjZJP8nXyiUh7CdLKkKDyaOwb1yRRXWxXrNQ@mail.gmail.com>
Subject: Re: [PATCH v23 06/19] x86/resctrl: Introduce snc_nodes_per_l3_cache
To: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, James Morse <james.morse@arm.com>, 
	Babu Moger <babu.moger@amd.com>, Drew Fustini <dfustini@baylibre.com>, 
	Dave Martin <Dave.Martin@arm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Fri, Jun 28, 2024 at 2:56=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
> @@ -1022,8 +1066,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resourc=
e *r)
>         int ret;
>
>         resctrl_rmid_realloc_limit =3D boot_cpu_data.x86_cache_size * 102=
4;
> -       hw_res->mon_scale =3D boot_cpu_data.x86_cache_occ_scale;
> -       r->num_rmid =3D boot_cpu_data.x86_cache_max_rmid + 1;
> +       hw_res->mon_scale =3D boot_cpu_data.x86_cache_occ_scale / snc_nod=
es_per_l3_cache;
> +       r->num_rmid =3D (boot_cpu_data.x86_cache_max_rmid + 1) / snc_node=
s_per_l3_cache;

I noticed that resctrl_arch_system_num_rmid_idx() still returns a
value based on the original, undivided x86_cache_max_rmid. In my local
testing, this resulted in the alloc_rmid() returning values too large
for the arch_mbm_-arrays.

Please take a look at the patch I shared[1] to try to address this.

Thanks!
-Peter

[1] https://lore.kernel.org/lkml/20240722204611.3549213-1-peternewman@googl=
e.com/

