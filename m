Return-Path: <linux-kernel+bounces-341253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D267987D49
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878961F23B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 03:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD27A16EBED;
	Fri, 27 Sep 2024 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTnO+5ay"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D554279
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727408468; cv=none; b=I3jUOfxucb1baOu9HgT4KfmXelflGxsdE6qbLq/XGw089b3rzjLhu56is28I31VzrGuU32008ow9BuTtpM4iuSWRfZYoVsQqnIKYFEYw7kDPSR7xlyV7WqCWXomJnczuhE1RGEWVZiDW7kVBQgJGR3vqc8SAm9DcNcgTzRtkuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727408468; c=relaxed/simple;
	bh=H/ZknXSdLjOIfEAyx5/I0kfMKB6jEzED7IOUxbDrLy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4MkHVRPajzuhJ/tWxtglZaioLLw//hzeVkSos73MFi6TCli55EF4gQrO4grFmMzCrCeq+8DUNY0ZV7llIMuVliFS072y86TDg9kPJAAxV+06VKjInmRbyf/oaCHj6LnKt/XuhwoSc+zeXKyx5Rw2TN9mJKLtyl7pAWHIlnVNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTnO+5ay; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e05a5f21afso932193b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 20:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727408466; x=1728013266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJkzlMDzTaxcI13kbzTG1P4xrFPBgCOycYsjVerEzFU=;
        b=nTnO+5aycxq44b9RoDeCH0qflKIPRbj6f8Ns8DXHfaXECl3f0pqfVHrDaPAsQ76+O9
         7IdrvcDIBpO2mZt/3JZtHeJv708vCmV/7v/9ugIvq1G38nlPmSO/+dmrz3G210rKEFpV
         I/3AfYFx3X5TL0DUS3kq7rzeb0DXm66G2cwEC3Pwwl6kcZTVICW2BeQz1HejZ4QcTd0X
         lV1B0NtIWBgtS/h9aPPvlolxjMZPjYDCalhSinQiNhRhR7XFZ2NxurH+dkWdOn1TFXPF
         eNdbsTjBApDWK+0/l6KQ+HteT6MhgeiWqPihtold/Hk7cJTJ+pzvwV85ynESNFOTPUV5
         VuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727408466; x=1728013266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJkzlMDzTaxcI13kbzTG1P4xrFPBgCOycYsjVerEzFU=;
        b=QXP8I0FYJiE3YXNtEtRklbfASN9DFxV/AV/tQZ4NzKoAjf/jQl6MnDAtYoAZMAJrBI
         sy06BiaCO4jdbAnxXF0AGI6L+kv3AEY38j8RYb19UKn3oun4OCl/VZbMfLZ0ICU7I6Cd
         GJGKruF3l5+ypU9JE0ObTI+Xu+vhq87LewZqGJ6rmXQscNf1cCMwV3gAEfCqaRnJHyqT
         0uVl6Dszh5yVWXNsVbO+Jyi0wAR8h/eYYN60tySs0941x/VO/ZQvpyrBNjy+4mcAtAp+
         cGJgFFEBuLUmtYfxmPD6tDkSxuJOcwc18yezYYxz1e3NBsu+gXAHz8DZ8JM/1OLctUkq
         IczA==
X-Forwarded-Encrypted: i=1; AJvYcCUTrYV3RstMLYbLmnUwQ+/th+UfX9mGuJAyguSsa7CRylYh9G8JaE9CXEEc/jY3U9xPqaSRnu5+Mgiuou0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+SGl612f5A8drpG9mXpfoz/du68zEVu3Dp+GnZFcFX0w0RCYc
	6uEUpyphSwuugOZBRmQ+vDUTaKW2SpVCYntrEaZLApU0h9rYFPQTABGmuWuSxNr/7yHhGeYlQGW
	fFBjcbjT9PPCtv/S3I2F0AxoKY9w=
X-Google-Smtp-Source: AGHT+IGLjiEdhtxFsoCoaov7izumpWpNG5l8yMdJXXymD96ryhZowEjgcKkTMXgoBr9wKoPDkuSuvQMXZMTfd7B6Aj0=
X-Received: by 2002:a05:6808:3385:b0:3d9:2b24:5b2 with SMTP id
 5614622812f47-3e3938d1ae1mr1495738b6e.0.1727408465701; Thu, 26 Sep 2024
 20:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926145817.1124-1-linux.amoon@gmail.com> <ZvWUCtkOXKfnIr-m@arm.com>
In-Reply-To: <ZvWUCtkOXKfnIr-m@arm.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 27 Sep 2024 09:10:49 +0530
Message-ID: <CANAwSgTyV-KOhyr3nhxp_W9KDEi4bAX8ET9acMbbn0AQyr2TJQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: defconfig: Enable CONFIG_EXPERT
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin,

On Thu, 26 Sept 2024 at 22:34, Catalin Marinas <catalin.marinas@arm.com> wr=
ote:
>
> On Thu, Sep 26, 2024 at 08:28:16PM +0530, Anand Moon wrote:
> > Enable CONFIG_EXPERT to allow the configuration of PREEMPT_RT.
> >
> > PREEMPT_RT depends on the following configuration:
> >
> > CONFIG_PREEMPT_RT
> >       bool =E2=80=9CFully Preemptible Kernel (Real-Time)=E2=80=9D
> >       depends on CONFIG_EXPERT && ARCH_SUPPORTS_RT
> >       select PREEMPTION
> >
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index 5fdbfea7a5b2..3d9d29eb0c13 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -28,6 +28,7 @@ CONFIG_CGROUP_BPF=3Dy
> >  CONFIG_USER_NS=3Dy
> >  CONFIG_SCHED_AUTOGROUP=3Dy
> >  CONFIG_BLK_DEV_INITRD=3Dy
> > +CONFIG_EXPERT=3Dy
> >  CONFIG_KALLSYMS_ALL=3Dy
> >  CONFIG_PROFILING=3Dy
> >  CONFIG_KEXEC=3Dy
>
> EXPERT is not really for defconfig (at least not for the arm64 one).
> Distros can (and do) enable it if they want. Also PREEMPT_RT is default
> off, so you'd have to enable it in your config anyway, not sure what
> this patch helps with.
>
Ok, I will enable this in my distro config.
> --
> Catalin

Thanks
-Anand

