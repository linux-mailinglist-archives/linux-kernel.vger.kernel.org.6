Return-Path: <linux-kernel+bounces-536726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC8FA48371
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733F93B8DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE79C17C225;
	Thu, 27 Feb 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OT2sMCPc"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611CF187858
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671138; cv=none; b=EtgX+JtMA3RItU8PAAotAB9BUdYET+pYkgAVKhar4/+ovY9cl8bs+2DxB7r/5XJc/oUA7JM4CSGcsn5/SPpkVfOWL/FESk/EEOC9aJf4668/+0o/k+A/E6RM2qKLUrQgkv2rGC3sjxjG7tilqUqfqNsWlZXjb20d930Z98jSb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671138; c=relaxed/simple;
	bh=/ii1hq+QPUbfzauT0Vac3Ol89BWdodOU8tB3n0MbeGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iA6bjYO+ubNmdnvsehNelBEB2X3dtLIcJgwhp+SdbU148Oix/hIxXdTg32k0DsSrVGS+99UYYBjzw9cSFQ1rAXDr84FwjY1cKwEq62QZKerF5q6mja6XuKVAACw4r/PJYMwWfOQWIZpftdEM0xc0+5CSegPVXYJPHEKl+/aQ4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OT2sMCPc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54943bb8006so1071708e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740671134; x=1741275934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcuVzMPrrCCi+TThZU+HIFR963eQI7ErESoom0Yv0pw=;
        b=OT2sMCPcR0uvIOqI7fE7MV3HKRoLhjFCV7sZ/VQS37s7ZaiDnk5PmfoRjMPouCbLuE
         yBAFS7wyA9XXQSLJk7Cgjrz+GkLz1Zo7dTCDOiSlyAoxbuxnaAnqhRdcxo6QKHpWU2D0
         RnUMrlp3BUDTT0aBz0DGHo1ndvWgKXdwkzvwZePqajkulNC6g32RW17DaYPzX8eO91PA
         HvDRggSDxIx5E8DQ79Z9nEqTODnbvffA/sX8nozSAbe/RsLBMr1LDLU+PIqdm8LjHoeG
         sl74M/2KVVqAccgTDhPRNL6kgYC9SOMQlh+hKAdpm8PwHMnO/iYkvOUdmsNDOPumw3nc
         taiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740671134; x=1741275934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcuVzMPrrCCi+TThZU+HIFR963eQI7ErESoom0Yv0pw=;
        b=SMA5NNnDP/rW1T1FJu9Z1M8zSngUPt03YQeX6ZVJZpXUZhbok58uEhwznZJ2t1ZYWV
         PHiFRcYVO+svzSPSocyLmzbAVRydp10ne1PTcg50ZOhCa8vFLIT+Re2FqY7E3AojEYI/
         K1D1FlZ0VyskLnBu+NfXil6orH1qMa6/4/+9u4rz4u2oF4fp6z21CsqSGyIKKC2tgQlV
         cGCiGtRdPlI3cDrluBoakWC2GUZgRdWRXh/35H1kBuenrXFATf0iDgHfTKa2kKzBPydq
         Rgn6MPiumXHsVrJZ4xF2yr0Vy+Qu/CD0MXbBedaTIFeN99eOhitjPUEJiXGgGrU10eSV
         VrSw==
X-Forwarded-Encrypted: i=1; AJvYcCXLQzE7NXHloHngE/zlK0BDgY/y5bAlOiNzX1IpMAfDb1+PSL/fCmt65EEASF0sK4wjX8eEqOxWaO5JpWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb8AFIj/pCN+lefonqq7M+2sf9LwaBs8eb86TTwPu+z9k1SnG8
	O4DWTBmUgjoIbIwysM0kT5pB0ToH9IsbVdWoITzOPZncKnckvxoIlM+VFnRfaEktL5oFXf8alu2
	8/otbUny1URGZbQUQn9Z7eZhV5KJFWNFI34xw
X-Gm-Gg: ASbGncuHGhGmkunjedarqnrYl2gz11aaK7qa4z2Xuy1Zx8+2CiAGnOzrsBpGrb0NuZP
	rhHAGSkp34/9Uh+UFYh3kJueF5Mlm2L6phDBoHO0xDsS7cXFX3piZLrkwSDlZ+8TC64888Smjw5
	8Plx/iK2Th
X-Google-Smtp-Source: AGHT+IE+7zetE6DVGc6+iFS75ktCya3waqmc2xhr0SmYs1IrM45Kxr6XeFcELNyrhnn6EWIQf1McPU/XVWODl8dgMWY=
X-Received: by 2002:a05:6512:b8d:b0:545:2950:5360 with SMTP id
 2adb3069b0e04-548510d7323mr6563038e87.22.1740671134247; Thu, 27 Feb 2025
 07:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <13709135.uLZWGnKmhe@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 27 Feb 2025 07:44:56 -0800
X-Gm-Features: AQ5f1JoLn-Gmzkhoib8A3lXPDMeZMr-h9iZPxDZg9Oo-jd-3BrgtaFeYWPIBTYg
Message-ID: <CAGETcx-ow3T_R_Lj1s3sjp6nQz6Wv7T3dQdP3HJHd+E8nkh6rw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> Initially, this was an attempt to address the problems described by
> Saravana related to spawning async work for any async device upfront
> in the resume path:
>
> https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@googl=
e.com/
>
> but then I realized that it could be extended to the suspend path and
> used for speeding it up, which it really does.

Btw, maybe I didn't  word it correctly, but my patch series was meant
to speed up the non-async case too.

I was going to get around sending a v2 of my series, but was caught up
with some other work. But I'm okay if you want to finish up my effort
-- less work for me and I can focus on the other aspects of suspend :)

Maybe add a Suggested-by: to the patches?

I definitely want to review the series, but very busy this week with
some other work. I'll get to this next week for sure.

Thanks,
Saravana

>
> Overall, the idea is that instead of starting an async work item for ever=
y
> async device upfront, which is not very efficient because the majority of
> those devices will not be able to make progress due to dependencies anywa=
y,
> the async handling is only started upfront for the devices that are likel=
y
> to be able to make progress.  That is, devices without parents in the res=
ume
> path and leaf devices (ie. devices without children or consumers) in the
> suspend path (the underlying observation here is that devices without par=
ents
> are likely to have no suppliers too whereas devices without children that
> have consumers are not unheard of).  This allows to reduce the amount of
> processing that needs to be done to start with.
>
> Then, after processing every device ("async" or "sync"), "async" processi=
ng
> is started for some devices that have been "unblocked" by it, which are i=
ts
> children in the resume path or its parent and its suppliers in the suspen=
d
> path.  This allows asynchronous handling to start as soon as it makes sen=
se
> without delaying the "async" devices unnecessarily.
>
> Fortunately, the additional plumbing needed to implement this is not
> particularly complicated.
>
> The first two patches in the series are preparatory.
>
> Patch [3/5] deals with the resume path for all device resume phases.
>
> Patch [4/5] optimizes the "suspend" phase which has the most visible effe=
ct (on
> the systems in my office the speedup is in the 100 ms range which is arou=
nd 20%
> of the total device resume time).
>
> Patch [5/5] extend this to the "suspend late" and "suspend noirq" phases.
>
> Thanks!
>
>
>

