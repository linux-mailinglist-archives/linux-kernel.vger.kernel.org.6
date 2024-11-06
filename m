Return-Path: <linux-kernel+bounces-397694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037089BDF1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE8A1F23F2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08625193091;
	Wed,  6 Nov 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYjWN1Mk"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBFF19046E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730876763; cv=none; b=oUlkiv/Yz/+ppCWpAvHG3Z63VBzMUkQ8NurH5dzw1k0Bfubku7fepaUA+cXOpQoqdrapB5kqXD5gF58VmG/W0IDe37+egWxY9sT4dyIX+E3SHb7zv/OCESEKp9ADxM39fSng3yK3lFb+tvLn45FCKT0blvyPbw/iTi7hSuyFxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730876763; c=relaxed/simple;
	bh=p6C5IEPN6P+pbtCgSR46Ccoxyvy0NUXuTKfMt6Fl5DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkvXrqrSI6+JI58wK3nNeclzuJznOdJGFikwPU8maCHHzMXFJo2aD0swmxqNL9q/AvwG6QmumHde2SXZ8K2gRTb+vpsLsISXL3/tnLEmCHxKtJZgH7cXa/Q3hbLAkBh35PVT//8Sx1upb+0col+AKwdEqi2lyU7TVBRzYAAdZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYjWN1Mk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e13375d3so6536984e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 23:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730876760; x=1731481560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5sOFKhhbWxoz81S1+CXD6VUF6R09kQsa2DuJ0ohEo0=;
        b=DYjWN1Mk4I5BNVUvoMB+9dCwNfpGzgZfAeK2X1OuChtk6uVVKBes5WBjAh1/dfyiE2
         C1DvZuwC/hS+qzVFNQVDK8jIPnQtzUcvAqdEfJhEGiqBewLfcJgtlMzpJeaavw4QHcFf
         ZelZn+mjvsolL0Yzf18Vsa6Y6/AzaMG0FVxSezmGCHphZUdNn6Hz1WeKHfZumKFuJjQB
         wNWvtXcvqPkv4QxBgGd2Ne35LlhK0MgYgVfJoo2liiCN9U33YRXUFCMgM9pOkyW/9XUz
         OMg1elGEeDVkp5cwE4Lba175WNitbQritfZ6/wTv2+AxAj60IbLQqyfvhc7ph34sDiIg
         mTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730876760; x=1731481560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5sOFKhhbWxoz81S1+CXD6VUF6R09kQsa2DuJ0ohEo0=;
        b=YLn8vB16+S87KbaH5z+WxkxeydXotfwx/NYII4Vzo8AMbe50WA10C8PJPl7np4jCY+
         1pLsC23hBBiwrPgWGIDwHm4+j1Lk0yxIvdisvYNEsmqk2kQH6slhvzAClyvQ7JRTqDBz
         rltSm9FTtFFuY/EX58hPSfS/MNIrLSdNDRA4OyfhfnpVfjw2eaoeFpEn1TRsHTCIKTAG
         s88dE9hw2E41zqPNZUlXS/kFI61rKCejMbvwhF1AdD9hzPGSv773Q9DHBmYRbPyPz/qX
         fbjIPczaFPZLE5A/Cfg4mCXvWtldVc69JUxwZExrRT6sni8ErPKdqTXCl3hflVmQN2nP
         NMKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWufA94kdEEklfo9lXno6QSd2yPWwDz8hDdQMAt6lkkGBHg9D7lz/enJEW5rx17EbjgPeBzMYCEJSqzKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrzzdeL5QNf/8bh0kPCtxah0EvwEBa8QNHpWhwtlMSEQp1flyk
	1JfSGJoxiRr6+AZnqElbsZWsqejjJqYzhQCnuiagp6hhYMisMcW6
X-Google-Smtp-Source: AGHT+IHch6RbS1NM1k6CBI+Hi17vN7v1edOLx1yQHVelZgvWVj+Tc6VeH8uVB1lg6GXcZxXjYmSOiw==
X-Received: by 2002:a05:6512:ac3:b0:536:56d8:24b4 with SMTP id 2adb3069b0e04-53c79e15746mr10404636e87.5.1730876759339;
        Tue, 05 Nov 2024 23:05:59 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcc03asm2372232e87.207.2024.11.05.23.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:05:58 -0800 (PST)
Date: Wed, 6 Nov 2024 10:05:56 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Shoji Keita <awaittrot@shjk.jp>,
	Icenowy Zheng <icenowy@aosc.io>,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i-a64-pinephone: Add AF8133J to
 PinePhone
Message-ID: <ZysVVCIdJ_hpe0OS@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Shoji Keita <awaittrot@shjk.jp>,
	Icenowy Zheng <icenowy@aosc.io>,
	Andre Przywara <andre.przywara@arm.com>
References: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
 <20240908214718.36316-2-andrej.skvortzov@gmail.com>
 <CAGb2v65Laka+YaPyAecwxEhMkoodrXnDPn+UTwZUS_wsSBMzyg@mail.gmail.com>
 <ZuazIgLz5PP_Z8Cn@skv.local>
 <CAGb2v66-saec9RcQsCTNOz_Tz4+BSFPdDd6CEA+RrGcF6kCY=A@mail.gmail.com>
 <Zyp3N9pGWhLqmtq1@skv.local>
 <CAGb2v66DgOmfm0U_dm-+=3nEXaZWUMZiajCdkqVJ6vUPvGC8tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v66DgOmfm0U_dm-+=3nEXaZWUMZiajCdkqVJ6vUPvGC8tQ@mail.gmail.com>

Hi,

On 24-11-06 10:31, Chen-Yu Tsai wrote:
> On Wed, Nov 6, 2024 at 3:51 AM Andrey Skvortsov
> <andrej.skvortzov@gmail.com> wrote:

> >
> > >
> > > FYI I'm open to either approach. If the firmware can do it, that is also
> > > fine. I don't know if it makes sense to have both disabled by default
> > > though? That would break existing users, but so would the in-kernel
> > > prober approach, which requires both components be marked as
> > > "fail-needs-probe", and also requires that the kernel driver be enabled.
> > > In other words, I think the firmware approach is friendlier for existing
> > > users that have the original batches.
> >
> > Current patches leave original magnetometer enabled as before. So only
> > the new alternative magnetometer is disabled. Firmware prober will set
> > the correct status. So you are right firmware approach is a bit nicer
> > for existing users, nothing will change for them with any combination
> > of kernel and firmware. Let's go with a firmware approach with current
> > patches then, if nobody
> 
> If?
if no one has anything against that.


> I'll wait a day before applying this patch then.
Sure, thanks.

-- 
Best regards,
Andrey Skvortsov

