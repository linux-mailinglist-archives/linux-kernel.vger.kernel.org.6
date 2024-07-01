Return-Path: <linux-kernel+bounces-236166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 057ED91DE55
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B1DEB235CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37BA1474AD;
	Mon,  1 Jul 2024 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEJE6KJl"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271F14A4F1;
	Mon,  1 Jul 2024 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834538; cv=none; b=fF9Y19Q02mWsB51/CzXHJdwJeHXWt8UnOVfhF5fbF1Ca+EBjks+8RLqq/2KhOSt9xE3Fh6n48IrGS3q++OyYHh3lGgbs34gt+6Q+Y389XmpI47ZpDCqFWTjdscxBmmTnacjfaE1RBH8hMSxXU1Qqv3ZRd+kIig14cc/hTMRTEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834538; c=relaxed/simple;
	bh=6a1jANNPOTvEfPmJEWvbSZBbVBozVrmbh+bxb2UH+7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VA0SPh61teEC+08SDemdjR1Xvs0MyFxKIwy+L90YBxe85VfWMQKZ1R76WvmLt+HO6cKjo84hynz66B64ZyOZEEwDABXmRv/qvqjQzcvujYbHie3clo7MK4ad0oBUms+lDt9DTqSB0uLT4MXV3CFWSnq/RDuEfY06ETrY3LhkSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEJE6KJl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a72517e6225so322479566b.0;
        Mon, 01 Jul 2024 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719834535; x=1720439335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV/0naMj7Ov0TQcz1d4KTNBA6C9daFFiQCJCqoAVX9c=;
        b=PEJE6KJlvQzKAnpYUqxdvPjiYsGh4q8LcQO5UWz/L9izpqrJgR8wICOGCQvU+UpMAx
         Vqs3Irf8o5QkWEbGkHVM8vBe8yHcqwceGlHTu5qA3C0iQRoDY1ZXRrAYMmPp8aThVEF+
         RzGkr3TPAbqDrfoDPwc9Q9+iZSLmEE0gGy0G+y+6lUUGRYj4GX/NT90yQ7vdsMPwlFaV
         Zy6n3TI9CE8WiqsAqmXsaSSmdUoHRthwk/zqag1ED9kw6uCAzwVJLmq8ZfxxRHo6/G8R
         VyrTEMjOqLkHa8eO2nHg3WmkgvL8IvIifjDj+kIwKpyZjy1DWT/qfnJgBzsCQ9Udt9NM
         MQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834535; x=1720439335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OV/0naMj7Ov0TQcz1d4KTNBA6C9daFFiQCJCqoAVX9c=;
        b=mJCqOHPjOrhG0iWMyKCJ3/wPh8KmtfFXmcYMsj8vb1VWuDVZmBPyFOqQjcsP3MZOj3
         Qo82WCuYNnZcuJaAaDEKl7zrNoT6pm0UWihKzPcH8z2R5lzzPP3Y5UFhTGddMhlXfLMS
         GTutx+8lCO+9NujZ5Q4Cxq1ZSC62bO5IUQ9EkLPgDQ2Up4xbg21xh0KXBqBxlzZ1EJZh
         KYK9FRMGp2nWywmA6FXKvWhVi4hMRV7HhlA+WDBfCMMuXGpFeKxgw4bK6koTOaFcce18
         HgwynDtEOK92wFs0NVJRfO6CIXcfpigia/Vf7XixI72Ik2nzjVR34Oy3dPysIcSF3ZiS
         UFow==
X-Forwarded-Encrypted: i=1; AJvYcCXWgMnjyfXGQMUUmLdGtf4Rr1fqAimpcd3xPF+EZ4zdSXgsBBu+XDS8m8f6ynWe7y0veQjwgTIMylP/DXBEMRM8+DYm3uXp/GWzoZEOMVbsW7ZLUFAnHbTt6bPMbH/chMWVbDW7EeJjzF0MyPH0wp4tU4MUOsJxwl43JHKlWoNRcMoH5w==
X-Gm-Message-State: AOJu0YwwntuIEaYIe2i6VLzgc0EkAd2gzbwyS74GHpeLA9PtfMBHFWhx
	kDfXvA4E92yzPXUwd+ZZ87osIcYf3wWKCWfABODdydJVlGCOIJKDcfasiVFy1ptYWmkmKtG9+bf
	ozoCmfw8tWM/bpgcdTFzwJJUh0nRtMisqpYA=
X-Google-Smtp-Source: AGHT+IEb0SmE7nytN26KZiMUWH3d+2JmwWgbVDyujSQngfNsJbSRJMsPN5Ts/PU6SiSb5LYnb0/c/h26gtzP/k2ML4I=
X-Received: by 2002:a17:907:7242:b0:a6f:c886:b68b with SMTP id
 a640c23a62f3a-a75144398a9mr487892666b.43.1719834534317; Mon, 01 Jul 2024
 04:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240603130126.25758-1-joswang1221@gmail.com>
 <20240604000147.2xxkkp7efjsbr3i5@synopsys.com> <CAMtoTm0S2WSO6VxK79DkTs+1aq5xBYBMRsPXWAFuWo4DoymUEw@mail.gmail.com>
 <20240622000528.3keexfbetetkrxpy@synopsys.com> <CAMtoTm2_QoT6YL=9fDJfdgcc__X-dkJymwDXj8VpyYdXx1mHAA@mail.gmail.com>
 <20240626012927.obxdoarp6cotfowo@synopsys.com>
In-Reply-To: <20240626012927.obxdoarp6cotfowo@synopsys.com>
From: joswang <joswang1221@gmail.com>
Date: Mon, 1 Jul 2024 19:48:43 +0800
Message-ID: <CAMtoTm0SaDfWN2DWoqvfSdqLGUp+jgoM_vuAudwhsp77aH5L_A@mail.gmail.com>
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

Thank you for your feedback. We will not deal with this issue after
internal discussion.
Thank you again for taking the time to review the code.

Thanks,
Jos Wang

On Wed, Jun 26, 2024 at 9:29=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> Hi Joswang,
>
> On Tue, Jun 25, 2024, joswang wrote:
> > On Sat, Jun 22, 2024 at 8:05=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@syno=
psys.com> wrote:
> > >
> > > Sorry for the delay response regarding this.
> > >
> > > On Wed, Jun 19, 2024, joswang wrote:
> > > > Hi Thinh
> > > >
> > > > The workaround solution provided by your company for this issue is =
as follows:
> > > >   Workaround=EF=BC=9Aif the phy support direct P3 to P2 transition=
=EF=BC=8Cprogram
> > > > GUSB3PIPECTL.P3P2Tranok=3D1
> > > >
> > > > As the databook mentions:
> > > > This bit is used only for some non-Synopsys PHYs that cannot do LFP=
S in P3.
> > > > This bit is used by third-party SS PHY. It must be set to '0' for S=
ynopsys PHY.
> > > >
> > > > For Synopsys PHY, if this bit is set to "1", will it cause unknown =
problems?
> > > > Please help confirm this, thank you!
> > > >
> > >
> > > That depends on what your use case and requirements are.
> > >
> > > I've reviewed this case. The impact to this issue is that power state
> > > change may take longer than expected. It may violate the PIPE spec, b=
ut
> > > functionally, at least for how linux drivers are handled, I'm not cle=
ar
> > > on how this will impact the typical user.
> > >
> > > Can you help clarify your use case and what does this resolve beside =
the
> > > fact that it workaround the increase latency/response time.
> > >
> > > Thanks,
> > > Thinh
> >
> > Your company provides usage scenarios:
> > System software places the controller in low-power when there is no
> > traffic on the USB.
> > Subsequently, system software programs the controller to exit
> > low-power to resume traffic.
> >
> > The method to reproduce the problem provided by your company:
> > 1. Program the DWC_usb31 controller to operate in device mode of
> > operation. Program GUSB3PIPECTL.P3P2TranOK=3D0. To increase the
> > probability of hitting the problem run with a slower frequency for
> > suspend_clk (for example, 32 KHz and 160 KHz).
> > 2. Place the link in U3 while ensuring that pipe_powerdown is driven to=
 P3.
> > 3. Program DWC_usb31 controller to exit U3. Ensure that for P0 ->P2
> > transition pipe_PhyStatus is returned immediately.
> > 4. Program U3 exit from the remote link.
> > 5. Program a D3 entry (pm_power_state_request=3DD3) at the same time
> > (from the device application) and observe if the D3 entry
> > acknowledgement (current_power_state_u3pmu=3DD3) takes longer than
> > expected (> 10 ms).
> >
> > Currently, we do not have a real environment to verify this case, but
> > considering the Android GKI regulations, we need to submit patches to
> > Linux in advance. Based on the following workaround solution provided
> > by your company=EF=BC=8Csince the hardware cannot be changed, we can on=
ly use
> > workaround 1 at present.
> > Workaround 1: If the PHY supports direct P3 to P2 transition, program
> > GUSB3PIPECTL.P3P2TranOK=3D1. However, note that as per PIPE4
> > Specification, direct transition from P3 to P2 is illegal.
> > Workaround 2: Delay the pipe_PhyStatus assertion by an amount greater
> > than two suspend_clk durations at the input of the controller's PIPE
> > interface.
> >
> > We have the following questions and hope you can help us confirm them.
> > Thank you!
> > 1. This case seems to describe that the P3 to P2 power state change
> > takes a long time, that is, the DWC3_usb31 controller takes a long
> > time to exit the D3 state. Please help evaluate whether this problem
> > is perceived from the software perspective, such as whether there is a
> > problem in the xhci_suspend or xhci_resume process. If from the
> > software perspective, this case will not cause the xhci driver to
> > fail, then we may not deal with this problem.
> > 2. If this case causes the above problem, for Synopsys PHY,
> > configuring GUSB3PIPECTL.P3P2TranOK=3D1 will cause other unknown
> > problems?
>
> For this to occur, the host must try to transition from P3 to P2, and
> somehow goes into suspend and request for D3 immediately, which causes
> D3 request to take longer than expected.
>
> This is not something we would expect for xhci, because:
> 1) On xhci_resume(), we would expect the pci device to be powered on
>    (D0). So it would not be in a condition for this issue to occur.
> 2) xhci_resume() takes some time restore the host controller states
>    and reinitialize the registers and start the controller. Then
>    xhci_suspend() also takes some time to save the states and halt the
>    controller. So there's some time before the pci driver can send a D3
>    request. I don't know how long your setup may take, but it's unlikely
>    to hit this condition.
>
> Even if we do somehow manage to run into this scenario, we can set a pci
> quirk to increase pci_pm_d3hot_delay to increase the suspend/resume
> timeout, avoid hitting this.
>
> Unfortunately we don't have the real environment to verify this. But
> IMHO, for a typical use case, I don't see the need to introduce this
> "snps,p2p3tranok-quirk".
>
> BR,
> Thinh

