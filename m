Return-Path: <linux-kernel+bounces-510777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E945A321D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F274818897FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C30205E05;
	Wed, 12 Feb 2025 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYKmR1Hg"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D3205AD1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351575; cv=none; b=hr1R0EJ+cYd1kstwPBUFTF3ep+JvzaEjZpyeJpXXsDIcr3ZY5XafQOS18MKHUznXqVC8+P5ySePPPQr9xpKCFgOKpd9wU6u2sewEMvVxmhccHCpm5ZzqT18Gn+5IzOnY5daJ1MQI8s56zADJBwox7LCMfm7Qq6iuJpoVQYY9/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351575; c=relaxed/simple;
	bh=VszNZ+tOcSRZmD+6PTeoB4E5xsU2P0ZBHqIsfJ80K+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wwd7RhviwvyIqB8Y2VR2uTI4zYE76kjFgR8dkO4aleU1SotfkyFss27AsEWVfuCe7JGmn9wCl73S9WfRkWOgD+0gyuSdPYX/zZNXety6F/H2e2IgMN1ZhqOTAvYcv3m+ls6nMXGZqccwOxrR+yIMYTo6iSCJBv/FrKnbjA3Jz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rYKmR1Hg; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e549be93d5eso6311423276.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739351572; x=1739956372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M4qmugdZ8b2EBLGeykukgskjWNLfUcPNwqpBmF/6qK8=;
        b=rYKmR1HgE0KHLpkEcnd5wMVaTPVxl4+6hPviv44hQjmho75FHKAzPFoD86mpW6fJZj
         1fNLjknMQVBH0Wc09hFtZKHelR+cjQ3sYD/gB/t3qDPhUcAivYMgmt4BEUNCNOoHkkLL
         jHP0oF9gu1FolN2MChw/cjRv8PhmUITPPJJLr0Z7TwoMjEPJDfPE12O/ohGBb6qIwv2v
         FTM1fX2d+9Pyu0YyW2KKbHJbs4QdPq3VZtpIzmeKL/oH5wS/On96RSZyEhkeU/yK8Oj7
         dmlf8cqukDSqOUC3QfWXog9G4ruQkrCfFqEwKhuGCGrqM3WPY8wXW7TboDVBbiSxpFa4
         0m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739351572; x=1739956372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4qmugdZ8b2EBLGeykukgskjWNLfUcPNwqpBmF/6qK8=;
        b=Qe/zAE7qZXSB1Xx7JpHiZ9wtOOyaMM/sscpGq9kEmLoDrQ8yDyVhqjKRMo/9M59p0h
         bdI+M3aO6ZeiBlpUO3Ef4yUuE2nJOU6GSQIegqQ743JAVLnKzkEjFNCnarI2zeSKSSHJ
         z18L/z8kgoVPDLGS9/iJOkHJO4jtEMT9OK4gaU+J97RMnMvll2/bw31L3kj1zj2OprVO
         ptOXJGB64nNGJX8VNXe9R7ROxpC3EFZEFsfh8cEb54uXtiAn5U+8joKVTXLzOPjrUaHf
         QW1i6HJCH5C1vj1MgC/MaRc56o+Oc0JgV189rdgUIId8kxoRjeOGpiMrHwlWd1ak8eL9
         QEBg==
X-Forwarded-Encrypted: i=1; AJvYcCW/4KKjdtMqKJvarYdaFVxX+TK1GJ4rtaDCxe+n082m97n44+W9BcoCyANHJi5EXv5qmxoaYi5CVbpyHBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1FRCieoKCesoY8VkK4JcUepMi+2gWtguN5L7UWTSO7H7VMENo
	yvIVMWNZJLw2WOLl3QJS27hsTjUCpcos5M060lWLbuvxWOO0mNFz6dqEhlAp3xv6hId29Scop7f
	+cTE58KULfAQIP/4j0EprxUvEkQP2pvsAX96DGkuAHYHJBgAQdP0=
X-Gm-Gg: ASbGncsQUxssJ4RgrFiqC0RTQhZGagjNI3O0AnBhup915OJR7X99FtqLOcfmjrpUNuI
	g1XDm5769PhYUT+E9gIJ5iT6NF7sdfoGyqkwK08HmvshBe4078VSIfjr7Ohvrbbn9sOmv7EQXuA
	==
X-Google-Smtp-Source: AGHT+IEFTfiiJO/Ldzgu1l/xRfUK7lO8stGZ8r1z/sjXf9F2I5Toe3YEuBIRQ5Xd4j94E+8EWqgMqvplCJDGM8GTOtE=
X-Received: by 2002:a05:6902:2b03:b0:e5b:21fe:d9bd with SMTP id
 3f1490d57ef6-e5d9f0cfcb2mr2258915276.10.1739351572470; Wed, 12 Feb 2025
 01:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <2314745.iZASKD2KPV@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Feb 2025 10:12:16 +0100
X-Gm-Features: AWEUYZmtpXJLhhN7Bd3XVjN5bt01NgkkmESkkQc2SjhdL8nC_uCDGFZOZpBMS08
Message-ID: <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> This series is a result of the discussion on a recently reported issue
> with device runtime PM status propagation during system resume and
> the resulting patches:
>
> https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwysocki.net/
> https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki.net/
>
> Overall, due to restrictions related to pm_runtime_force_suspend() and
> pm_runtime_force_resume(), it was necessary to limit the RPM_ACTIVE
> setting propagation to the parent of the first device in a dependency
> chain that turned out to have to be resumed during system resume even
> though it was runtime-suspended before system suspend.
>
> Those restrictions are that (1) pm_runtime_force_suspend() attempts to
> suspend devices that have never had runtime PM enabled if their runtime
> PM status is currently RPM_ACTIVE and (2) pm_runtime_force_resume()
> will skip device whose runtime PM status is currently RPM_ACTIVE.
>
> The purpose of this series is to eliminate the above restrictions and
> get pm_runtime_force_suspend() and pm_runtime_force_resume() to agree
> more with what the core does.

For my understanding, would you mind elaborating a bit more around the
end-goal with this?

Are you trying to make adaptations for
pm_runtime_force_suspend|resume() and the PM core, such that drivers
that uses pm_runtime_force_suspend|resume() should be able to cope
with other drivers for child-devices that make use of
DPM_FLAG_SMART_SUSPEND?

If we can make this work, it would enable the propagation of
RPM_ACTIVE in the PM core for more devices, but still not for all,
right?

The point is, the other bigger issue that I pointed out in our earlier
discussions; all those devices where their drivers/buses don't cope
with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will prevent
the PM core from *unconditionally* propagating the RPM_ACTIVE to
parents. I guess this is the best we can do then?

>
> First off, it turns out that detecting devices that have never had
> runtime PM enabled is not really hard - it is sufficient to check
> their power.last_status data when runtime PM is disabled.  If
> power.last_status is RPM_INVALID at that point, runtime PM has never
> been enabled for the given device, so patch [01/10] adds a helper
> function for checking that.
>
> Patch [02/10] makes the PM core use the new function to avoid setting
> power.set_active for devices with no runtime PM support which really
> is a fixup on top of
>
> https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki.net/
>
> Patch [03/10] modifies pm_runtime_force_suspend() to skip devices
> with no runtime PM support with the help of the new function.
>
> Next, patch [04/10] uses the observation that the runtime PM status
> check in pm_runtime_force_resume() is redundant and drops that check.
>
> Patch [05/10] removes the wakeirq enabling from the pm_runtime_force_resume()
> error path because it is not really a good idea to enable wakeirqs during
> system resume.
>
> Patch [06/10] makes the PM core somewhat more consistent with
> pm_runtime_force_suspend() and patch [07/10] prepares it for the subsequent
> changes.
>
> Patch [08/10] changes pm_runtime_force_resume() to handle the case in
> which the runtime PM status of the device has been updated by the core to
> RPM_ACTIVE after pm_runtime_force_suspend() left it in RPM_SUSPENDED.
>
> Patch [09/10] restores the RPM_ACTIVE setting propagation to parents
> and suppliers, but it takes exceptions into account (for example, devices
> with no runtime PM support).
>
> Finally, patch [10/10] adds a mechanism to discover cases in which runtime PM
> is disabled for a device permanently even though it has been enabled for that
> device at one point.
>
> Please have a look and let me know if you see any problems.
>
> Thanks!

Kind regards
Uffe

