Return-Path: <linux-kernel+bounces-435022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8389E6E87
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6F5165F7F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869F3205AA3;
	Fri,  6 Dec 2024 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCz/F2qH"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1132201116
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489265; cv=none; b=CRM+2vOTtD1ByENXcnVcYFcYKQmotl1Pb+iBa+vYhLY5kMvWcL25EkVQA/0vkCMALOMRlhEgGw+JA5U4CubUHwIiboq4x5rKZGrRzQ+gxp8Hsx+6IgqatKXdnHYpTIYZJEkn/XReiYSVcTH1VYzdtzcHVw5JiK7QQ7ely+iifnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489265; c=relaxed/simple;
	bh=luvaLEsir7NjCvJffVBs4WtdDScEoHm8FBWXtLtg1R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxCMZKP5dPA/sY+9DyyCWItC+NKqRemmdMtNcHdrJy2isq2AdQI3S+AL/35f78ym1p9pOFF2VGlbgyMZyqPcYHROCeLdsBNvacHKHG32gbsvHZAvZN0izzWvGKU9Pk1EulJxKOicjukcLOKQgnSvbiNvU1sY6K4itfN2Lkr5TtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCz/F2qH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso1461871a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 04:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733489263; x=1734094063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN6wSJOQKeS8K8OswS/K9JukacIPLWbnXcQDadD1vP8=;
        b=aCz/F2qH3jlUbA8bkBES+837Tf+Dy/+AqYcMd+YCxE/eVUDQ6bvnxMd12oe0vUURfR
         UWmOArtLn/WxgeDk7q5+jKmpG6XcWW6ezmGTayP/XiR8xkvrRz59H0BpjTzrg1+lws3M
         N4bdunBssjp4ZKUXcpQuf6gN43e+cmPcH1H7sK31ANcosQ/ySpnMmrlkzEbsnJi9PNuq
         dcGwZTAKXHl7tCNt1IVCOQvjYY3LctdYhG6KsxUsM8mtWlzCzZnLSTnWEJIAoPAw2/ax
         hPqaIvmosHgSIq3L5U0NuTQuOPSnTeQwiwrtYQuDHLWrxRUi8EZa+tonwmC4zQ+FQwh9
         R2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733489263; x=1734094063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN6wSJOQKeS8K8OswS/K9JukacIPLWbnXcQDadD1vP8=;
        b=MPiRwSOpn6pW4j2YBXhM5qyY1o9GBdpXk+FblOmWb4TlsVLB++b30yjq6Z4B2GmxdT
         v1ZGpMw7dWZVtHRgrxTH4vFq7ceAJLikfSaX59+QKlgUqCC0ohs0F9GRrJID6+3/cN1V
         6V6592pC8x3dDSE0C+olbaiT2bauBlrqcol5KzUKWtWhY4yxAzHOcJFBI/EZ+SdahhjO
         9RfSCfz33RLAjtv1dV2kT5FbQsr1PUw+tn/ODdr0SjhGEA3geK5/ouvCLztmJj01IrQK
         N2nvGRgIS6aua+JBM9q43mrLpQH89u2zKEc2cDcg2OIy/Smr70veu3Yer1EOIiAthP//
         RPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUA4lVGmLGOm7/MnotXKFLax0gtX20YDR+BBkBpVCQKdqGlRsr0P1eYfAfe7fx8hp2W87GHuWZ+Z+Wqyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBFO+N6c83atfHZOO4fwG0f5CgcbfNdFauPno9gSpzugqm8L4
	UzXquIndI2bdGoGYPAvLQ1lEiWYQACRBJ7Lrfq0GVoVFGVmPFc0N830ltKSWEjHp0yniuwR+t57
	8klKRughRioj1BuJs/BYDPtIJtIc=
X-Gm-Gg: ASbGnctesCXuUo3fyxqR1qQP9igCF1SKxf1h3oaiXvFCLy6lzuN3+8SnEUMFBkEeY80
	j6ICN8020UGOzok74h7+BO0IT0RKaPg==
X-Google-Smtp-Source: AGHT+IFIuAmE5evZRQVOpWixS07pJUiCWd6rEIDUBIPKl09LCARVG3DFqnIcjP/XHH0456aJoyhfu8BCInBZIcs6m6g=
X-Received: by 2002:a17:90b:5101:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2ef6955f6fdmr4458139a91.3.1733489262934; Fri, 06 Dec 2024
 04:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408220755.LlaA10C6-lkp@intel.com> <3ba6caea-654e-4dcd-a4a4-bfdcf808f0e5@intel.com>
 <CAMo8BfJOPNaHb0f3Rf2GyhApCDg5bFfCGETWU9-LBJWiJpLeFw@mail.gmail.com> <20241204230526.GA1166824@ZenIV>
In-Reply-To: <20241204230526.GA1166824@ZenIV>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 6 Dec 2024 04:47:52 -0800
Message-ID: <CAMo8BfLYSRxEXJVJxrZEe-SpLhcz2ScZs7avCoh=_C4taWuL2Q@mail.gmail.com>
Subject: Re: WARNING: [xtensa] modpost: vmlinux: section mismatch in
 reference: ice_adv_lnk_speed_maps+0x14 (section: .data) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Paul Greenwalt <paul.greenwalt@intel.com>, Simon Horman <horms@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:05=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Fri, Aug 23, 2024 at 11:41:17PM -0700, Max Filippov wrote:
>
> > static struct ethtool_forced_speed_map ice_adv_lnk_speed_maps[]
> > __ro_after_init =3D {
> >        ETHTOOL_FORCED_SPEED_MAP(ice_adv_lnk_speed, 100),
> >
> > that array goes into the .data,
>
> ... due to
>
> #define __ro_after_init __read_mostly
>
> in your asm/cache.h,

Oh, the trail leads back to me (:

> instead of the usual .data..ro_after_init,
> which would be enough for modpost to assume that driver knows
> what it's doing and won't access the dangling pointers to
> .init.rodata in there after the initmem had been freed.
>
> The same goes for qed and the same thing happens on openrisc,
> for exact same reason.
>
> While we are at it, that might as well had been
> #define __ro_after_init
> since __read_mostly is not defined on xtensa and default is empty.
>
> If you don't want that stuff to go into RODATA, why not
> simply define an empty RO_AFTER_INIT_DATA in your vmlinux.lds
> and put those sections explicitly there, along with the data ones,
> as e.g. s390 does?  Or arch/arm/kernel/vmlinux-xip.lds.S,
> for that matter...

I'll do that, thanks for digging into it.

--=20
Thanks.
-- Max

