Return-Path: <linux-kernel+bounces-228936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BBD9168DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A4C1F239BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCD215F3FF;
	Tue, 25 Jun 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsWpwEMV"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79614F9E0;
	Tue, 25 Jun 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322303; cv=none; b=h5sB9O6dq6mLn4AoVlt1FISmluoU+mgs/vvJOsqn9xTxCJ8Gh4sXfljWg6V2WPVll5ikQ5zPKWE1QHD/YGWTgEGhqJ2z0qm7lNIpGxbCK1daFeRegmyb/cNvKj/hPjUUgM91UAcNn5w6/FDulVVeiaVGv/rFLldPRwZc6S9Jl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322303; c=relaxed/simple;
	bh=JhTOvlv/fFw83z9MA/JanU9QLXx5eZ/OqqxpAh6VhHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTB5ylLalJKz6rRPVnXVWDTDynmFrUCu1ARv1SHy+CzKhKTjjGdSYWjoYJIEbt6CUXQpgq9ZgLZwbJExN0MMCWBXvEEF5LfozMf3ghVTHCiVlUXIPu10aTjCqvJyCKA9vI9SkMAzHpKmju6PUrwgZRYbFW87gRzi1EWFWJfQvL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsWpwEMV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d106e69a2so214449a12.0;
        Tue, 25 Jun 2024 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719322300; x=1719927100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FIaUi0sIcr6xli/A2+XeBULbh1JSIVXUEV5tbDKSEc=;
        b=PsWpwEMVUK4oWdQo1SXjUIDkcoZwJ1Z43qs4LLQcsXwRT5c4poBZqdfZP/NyVDeJVe
         s5mEFHYty6cKrC2VOI51tD8gyM6KiueU+ri/gLmznPmLz6fUMZQOoyv0EC6lGQDiSMgM
         MEZGY52OiMR7mzv1zWOerYxmwB3ik6Gf+6fyQNebn/gAXLnqWtoaqscL30OS9hdvuZpR
         QJ01xvRhio/BOjfiuQTrP9MCZhCXLTxePERISM9m/JyFnc86tozKJ8Pi/xtfaLcwN8Sf
         UdLIphTg//gM5XMhs4O4KpyRJBO8+mzNHkVPbUblmMoVko0iXNdwgg/fj+57fEzCfVa4
         AslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719322300; x=1719927100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FIaUi0sIcr6xli/A2+XeBULbh1JSIVXUEV5tbDKSEc=;
        b=YPYW+PR2aBgeP4CUEzqhGFphk/GdPzcWcKMfpZus7sjhcDsYr4Gl/UrjnbUpXiC5FW
         /pIvc6TjOr5P9Qls02KaBz+hyHbyX77CgexhgY0hm/YSVtufHCjGCeupgaf1d8ENFP2L
         V84D0WWgN/CLZa1wnI6I4uXba5bz6MhAFaeYiS8onx33b/UtgXzecZRQrfrNma9FRcUT
         ZCuyY7YZD2mIXBdHcFin6106zcgy9a8sWv2BqNRoQNRgiGXxZUAfNq5kQ/u3nC8caxpA
         e0RYx3/jqziEjg+GiyGGBq9Hx8etQvJVXCQU6/xda7Wi1akE9ZEFZvdQGfo8mcqvKqVv
         v9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJB7KJf+EP35D18JDtWGo7BC6HCiuF1aCg+OMPngtVjQkgJIo5VI+Tq7YqlW9jOrr/+amRsu2eBkUVPP36YDc3HYZfFd0gYRnU3cDOgESPNFAoFUmnwEtHaaWeRxiHBrkX4OvzfHzL4MnNrWZVIetpGcpIbEf2F+UDms7VAo2Lj6JgGQ==
X-Gm-Message-State: AOJu0YyAc93VCJ0MAQN0CRtC+f3fUumKnUPB7dhaJyPcFf/mnW7XXEsU
	A3YZFYMtM2uKW7Wb/KMtWW7jk05AacSN4Gvd83qXyI5K8dqOp+uiQW3qPwMeOeAlXDqDh/5VhEt
	WsQIUk7UFDO6pHm2ml7Y2AR5e+G8Fq4sWhmc=
X-Google-Smtp-Source: AGHT+IFuiZIfFcuCgctYUzMapk4c0sCuzgKH79nA6kGjmiB1u9HpHIFJXlFCzVabBY8PqSs02KZ/7t64IBwgQ4+rnyA=
X-Received: by 2002:a50:c004:0:b0:57c:b82e:884b with SMTP id
 4fb4d7f45d1cf-57d70231a13mr2099283a12.19.1719322299429; Tue, 25 Jun 2024
 06:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240603130126.25758-1-joswang1221@gmail.com>
 <20240604000147.2xxkkp7efjsbr3i5@synopsys.com> <CAMtoTm0S2WSO6VxK79DkTs+1aq5xBYBMRsPXWAFuWo4DoymUEw@mail.gmail.com>
 <20240622000528.3keexfbetetkrxpy@synopsys.com>
In-Reply-To: <20240622000528.3keexfbetetkrxpy@synopsys.com>
From: joswang <joswang1221@gmail.com>
Date: Tue, 25 Jun 2024 21:31:28 +0800
Message-ID: <CAMtoTm2_QoT6YL=9fDJfdgcc__X-dkJymwDXj8VpyYdXx1mHAA@mail.gmail.com>
Subject: Re: [PATCH v2, 2/3] usb: dwc3: core: add p3p2tranok quirk
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "balbi@kernel.org" <balbi@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, joswang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 8:05=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> Sorry for the delay response regarding this.
>
> On Wed, Jun 19, 2024, joswang wrote:
> > Hi Thinh
> >
> > The workaround solution provided by your company for this issue is as f=
ollows:
> >   Workaround=EF=BC=9Aif the phy support direct P3 to P2 transition=EF=
=BC=8Cprogram
> > GUSB3PIPECTL.P3P2Tranok=3D1
> >
> > As the databook mentions:
> > This bit is used only for some non-Synopsys PHYs that cannot do LFPS in=
 P3.
> > This bit is used by third-party SS PHY. It must be set to '0' for Synop=
sys PHY.
> >
> > For Synopsys PHY, if this bit is set to "1", will it cause unknown prob=
lems?
> > Please help confirm this, thank you!
> >
>
> That depends on what your use case and requirements are.
>
> I've reviewed this case. The impact to this issue is that power state
> change may take longer than expected. It may violate the PIPE spec, but
> functionally, at least for how linux drivers are handled, I'm not clear
> on how this will impact the typical user.
>
> Can you help clarify your use case and what does this resolve beside the
> fact that it workaround the increase latency/response time.
>
> Thanks,
> Thinh

Your company provides usage scenarios:
System software places the controller in low-power when there is no
traffic on the USB.
Subsequently, system software programs the controller to exit
low-power to resume traffic.

The method to reproduce the problem provided by your company:
1. Program the DWC_usb31 controller to operate in device mode of
operation. Program GUSB3PIPECTL.P3P2TranOK=3D0. To increase the
probability of hitting the problem run with a slower frequency for
suspend_clk (for example, 32 KHz and 160 KHz).
2. Place the link in U3 while ensuring that pipe_powerdown is driven to P3.
3. Program DWC_usb31 controller to exit U3. Ensure that for P0 ->P2
transition pipe_PhyStatus is returned immediately.
4. Program U3 exit from the remote link.
5. Program a D3 entry (pm_power_state_request=3DD3) at the same time
(from the device application) and observe if the D3 entry
acknowledgement (current_power_state_u3pmu=3DD3) takes longer than
expected (> 10 ms).

Currently, we do not have a real environment to verify this case, but
considering the Android GKI regulations, we need to submit patches to
Linux in advance. Based on the following workaround solution provided
by your company=EF=BC=8Csince the hardware cannot be changed, we can only u=
se
workaround 1 at present.
Workaround 1: If the PHY supports direct P3 to P2 transition, program
GUSB3PIPECTL.P3P2TranOK=3D1. However, note that as per PIPE4
Specification, direct transition from P3 to P2 is illegal.
Workaround 2: Delay the pipe_PhyStatus assertion by an amount greater
than two suspend_clk durations at the input of the controller's PIPE
interface.

We have the following questions and hope you can help us confirm them.
Thank you!
1. This case seems to describe that the P3 to P2 power state change
takes a long time, that is, the DWC3_usb31 controller takes a long
time to exit the D3 state. Please help evaluate whether this problem
is perceived from the software perspective, such as whether there is a
problem in the xhci_suspend or xhci_resume process. If from the
software perspective, this case will not cause the xhci driver to
fail, then we may not deal with this problem.
2. If this case causes the above problem, for Synopsys PHY,
configuring GUSB3PIPECTL.P3P2TranOK=3D1 will cause other unknown
problems?

