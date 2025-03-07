Return-Path: <linux-kernel+bounces-551630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B9EA56EE8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C78C17509E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA4B23F420;
	Fri,  7 Mar 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FIE9QcRS"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CD23CF08
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367900; cv=none; b=MD2PP01/tHqXtJ83C/racA7GAVGnyR+UtsaPvJlAEti1G2wTu3PBt6qtyjt/DiR0a2j4yujOBNDGTagwkeAKEwha9v8JbQ3BfFgKfKH/hnXNtG/fuGDvkJJsERyeFkbakEaXZIsvRFAdEtd9g7kOgKeEgpUSWd0iO+jJKRSrPZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367900; c=relaxed/simple;
	bh=Exa+LJbtcRhil2Mq0hG1/BWNs/UE6mgwSzeGSV6F5J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNhtIWpZg6kVNoXeLzlYfdGABm3h9AV3tzooCrFmSceKKNQ6h6MJuuD69vDq4KclluNA2f7EQ0dSvdFuTQYCJ03WqpvwFLNQX3R59WLqbhc4rrgq2od7Z1wLVFe5tqlxFUGYphkLpIn4YMm5YjqPBuKClcdbA3nTu8gSapOSL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FIE9QcRS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so483904a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741367897; x=1741972697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Exa+LJbtcRhil2Mq0hG1/BWNs/UE6mgwSzeGSV6F5J4=;
        b=FIE9QcRSX3czE47b6rsAH1Zwwz32B5bPDVSm6xyk5NQACjPKe07k4mEgtSsrOYtOR5
         GXICiBd9lf4z6UMqkGNGS83oxk8Dfp88K2PL0gvpHzM4yANqrheZBlLfdVWHsRJlkier
         Btn3btH01eNIRk0bSndkc87qdy9at1/9kpMRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741367897; x=1741972697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Exa+LJbtcRhil2Mq0hG1/BWNs/UE6mgwSzeGSV6F5J4=;
        b=b8ARYYfsHZdLxDuoVZRyTf0NKRNec+n4SiDhyYMaQ0n6SvsTfTu2GhVvsYa2xHGcA3
         ioqoEGem/qFuGdAv0K2qQOqWVX1BGooerZbeyBMnZLicazlqJ7dGm/759cx5o7UVLd9Z
         c3Uje3Utw/JpIKqBihcV2j2wBZamKSlvDOMDe/7jLMQIrYy5pzqqfsykyaMFo04I7V/4
         b1bq28LFdlbtUknUwPUqAok75YQE7diqh8QoiPpPdw9Lu13lKPdZ66uSsQXnHHCUzaPv
         pvGxwaHRvFx5Z3aE7SO0FijH2tt6Cy9lAjlo5BGGp6yH6TBAvF9z80fsX37CzXsmKH1h
         JdjA==
X-Forwarded-Encrypted: i=1; AJvYcCXK+LntRfijdQZHcXtrIIjIDfpDYmLwt3OLNH80JKectNvzTVxycPC1Y+h+fuy/ENdVS5+uravF6LX5MLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2RQkBcmpKe7QlmyP7jo9L1+rxtL/7TEOIlQ3wErKfuMVK03OR
	kQVGWnTrzRB5cw9EZuT6elIB9rmjGkE8wKpTvfJGWX9g3SBflAoKxXZkm4nQ5OAA+3IPtfwI+mz
	LXZUh0A8GmN/32IuOS7JuQj7lGYbuaHR7TGNJ
X-Gm-Gg: ASbGncsNI/9dAjHaVSZgYJ2d1hcTXPK4vSEliYLfBxCgjqoVwQj9J3VdBCZYULUepTj
	1zIkCOs9TKHe9P2qmyLeB8t4r81usz0VYbjQCt5muFq4tsFoSpFKzjUyPwyb2ZOaQet25LkmKbp
	wFHEbRwQVcARm5R8XlXHsgoFdQR/uI+YRRB3CNcAEQ0bXOEf17be5eSA==
X-Google-Smtp-Source: AGHT+IFj5m3zt+Gojvekzq1fuZQVeCyz7gnyUq6Vkk5e58fHmXRr37924drMwzNvEPdMxqSim6hQiGW+lLcrdQ24yGY=
X-Received: by 2002:a17:90b:3891:b0:2ee:6d73:7ae6 with SMTP id
 98e67ed59e1d1-2ff8f9100d3mr215985a91.7.1741367896144; Fri, 07 Mar 2025
 09:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307131243.2703699-1-revest@chromium.org> <2cf9798f-1a89-46e1-b1a4-7deec9cb7e40@intel.com>
 <CABRcYmLcXosu62EbTMQNGCEa+mmNtRKCQX8oL=WDrgP-UH6B_g@mail.gmail.com>
 <c43a1936-d8a6-42f4-bcfe-d4de56b38f10@intel.com> <20250307164429.GCZ8sibd8HT8R7gfs9@fat_crate.local>
In-Reply-To: <20250307164429.GCZ8sibd8HT8R7gfs9@fat_crate.local>
From: Florent Revest <revest@chromium.org>
Date: Fri, 7 Mar 2025 18:18:05 +0100
X-Gm-Features: AQ5f1JqIuoJsdDgTu7BibzmQNR2gwIlvFpXiSsIrvcT9AYke3jwOXnvwRZLjc5c
Message-ID: <CABRcYmLg3NG3VDDojxhX0sh89CAYksYAcMHmKcobGWrXVihMdQ@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode/AMD: Fix out-of-bounds on systems with
 CPU-less NUMA nodes
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:44=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Fri, Mar 07, 2025 at 08:32:20AM -0800, Dave Hansen wrote:
> > On 3/7/25 07:58, Florent Revest wrote:
> > > One thing I'm not entirely sure about is that
> > > for_each_node_with_cpus() is implemented on top of
> > > for_each_online_node(). This differs from the current code which uses
> > > for_each_node(). I can't tell if iterating over offline nodes is a bu=
g
>
> You better not have offlined nodes when applying microcode. The path you'=
re
> landing in here has already hotplug disabled, tho.
>
> > > or a feature of load_microcode_amd() so this would be an extra change
> > > to the business logic which I can't really explain/justify.
> >
> > Actually, the per-node caches seem to have gone away at some point too.
> > Boris would know the history. This might need a a cleanup like Boris
> > alluded to in 05e91e7211383. This might not even need a nid loop.
>
> Nah, the cache is still there. For now...
>
> for_each_node_with_cpus() should simply work unless I'm missing some othe=
r
> angle...

Awesome - thank you both! I'll send a v2 using
for_each_node_with_cpus() ... On Monday :) Have a good weekend!

