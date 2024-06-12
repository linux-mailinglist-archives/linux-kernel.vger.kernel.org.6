Return-Path: <linux-kernel+bounces-211660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E6390550B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E5B1C2116A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550917E46B;
	Wed, 12 Jun 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTlWzBH/"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB112B89;
	Wed, 12 Jun 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202233; cv=none; b=IrEeScfqR237cNzqdgeHWRAPXykW2I3BvGuT/bIKijH8T/xdB/sXlT0LiuuuXoOwguKxEpMBK2EsWuNtmQ+K3+e3SaRuYH5TtzXmjXzqIDMgk/VAdHrIALFuu5Qe5EN+ifZVdddjNSsufkUShB3n9VFWp3hXJeq4kVbw1kbWuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202233; c=relaxed/simple;
	bh=3SUwjfEdE7/+jWZ9Ch4cHafMHD2Z4aDWpTH5LPKONC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbPko3rnEokWS2G6yb1CZPnQXAmaE7YDjPOw52MC/7Nlerv7Hs6yKUhV7SGm1jSf2K6emCxEZ5p3RUluF0YxfL/AFEM/Zu50z2/BGG+/f2P9A5lRgCA3xu0u+r7dWwF64ssOts+1w/GxfIX2WZBhkD28AZ4AD47zv+wOnTgzi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTlWzBH/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f225ac23bso3432922f8f.0;
        Wed, 12 Jun 2024 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718202230; x=1718807030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyHQAv7KA+rn6UX/lfbQls3iW8tdEzN0HjsbuxSkKYs=;
        b=iTlWzBH/Cr4ERu3mBJUhCupeYHAKm1F9OUGgyYfxpGhnff09azxZnn52KR6NgVwH4+
         Hbwmv/h4+ArQHqiviLh6Zec03iITcM8loDZeupjlHfoPtNBXOf5FHpa0kmsx76GfgUTp
         yMioU/wfNDNkS8PcoxyvfdIdEpigqjmB2HhqENzcFeBvN0E6Uy7R0kdHW2qneComEYRu
         dvvRtqEGBch2REK6kA/u8DbIHeLq0CwGD5faTYi/gmm9soB8w6zuB5qyPRi7i1+Ybepc
         6dM5qla1F8a4g+pQN6Sohz2lL3AB1tU2znguWEvjNyBFlYPHQsJWS/q7R+lgFEdtEELO
         63pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718202230; x=1718807030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyHQAv7KA+rn6UX/lfbQls3iW8tdEzN0HjsbuxSkKYs=;
        b=AT8/Y2JmjyVZcCQ9DsyD6cZEl7wONuEAsq3QU7/3NPC96rvDPGpwwPEL2bt/j7Qvtc
         FsA6A/5t1YjSGfOr3Ld95nsz/U94G2as+tQ77CBMZvdjiyjjv+yZo6c7ybX3l/RbjcpY
         qC9ZLP/PwUeBHNbqTdMK1c+eGtqJ/1a/VyOg1GW2YAxEvG7gd99oGmzr3rFBsD5+rJN8
         ND6weZRciEWtpLMZ8y8W+8ovxRuYqJj76peFE/MjvCWsBOlbQCqFJrlUj4AbTgbXJ2f3
         fk/f6tfZ1c3RQ3PMbzIKKTBr+TzExkazfT7+MlVO4dMGFhylrDk8dDVE8Cvbcz+49cnV
         IRTg==
X-Forwarded-Encrypted: i=1; AJvYcCVFLNPSOrvI8WRjO28YPgJwp42kxKorVmkm4G5KUs8/OEfiKddruK0VcVkoHa5z9wVhZShkUyhr0PCNH88tMgD89g2aeSfxXGmkGaOVgnzhd6MYcfJ+HKArwZe7JV649aF3pLvnyOoj
X-Gm-Message-State: AOJu0Yw/pBk48YiIJXoZ7f+7fjtm78HWO9l6nGoIG5vZKEls/8R5t0z9
	lOe8YWeZvn5ATDVU0QxmCNZw7udCBw860uAl9SeSGq+QTpfTIZmR0NC0ClNGW5kFD2zQ7Jsjsjw
	/7zAfkOCukxKAzVF/bbrVH2oKE7A=
X-Google-Smtp-Source: AGHT+IF1PvGCSHdsKggJruHtQ6IFABccwQhxXVpOCJnfS32UBtyDtto4VYpqqX2CnamBP9xBwVsHzfCS57lKMWC2xek=
X-Received: by 2002:a5d:5184:0:b0:35f:1eba:cf66 with SMTP id
 ffacd0b85a97d-35fe8938566mr1901642f8f.61.1718202229602; Wed, 12 Jun 2024
 07:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601120640.73556-1-joswang1221@gmail.com> <1662c9c9-7330-4794-843a-940f05802021@linux.intel.com>
 <CAMtoTm1u+8ynBRaWgCMVgaR+dBoZfNGhzGqmvooBSDxZm5Qx+g@mail.gmail.com>
 <c9430561-ecfe-5b36-9574-73a946410eea@linux.intel.com> <CAMtoTm1xYUuaV1rO3dZexS=q_5Xf61+QAZ1++VvzK10VtGHexA@mail.gmail.com>
 <2521588d-30a6-0224-c7c9-3015e9cc65a3@linux.intel.com> <CAMtoTm2G-w+yRjechji7scJO-JZo6N==VK6Wun3ATRc7do9rEg@mail.gmail.com>
 <b5deb873-7151-46fa-164e-9e2c6a339636@linux.intel.com>
In-Reply-To: <b5deb873-7151-46fa-164e-9e2c6a339636@linux.intel.com>
From: joswang <joswang1221@gmail.com>
Date: Wed, 12 Jun 2024 22:23:38 +0800
Message-ID: <CAMtoTm1cqeFhko_+D7cZL5vAv7ea+bvF0yGHn0Uy7cwyU=O0zw@mail.gmail.com>
Subject: Re: [RFC 1/1] usb: host: xhci-plat: add enable XHCI-AVOID-BEI quirk
 by dts
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joswang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:00=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 11.6.2024 17.45, joswang wrote:
> > On Tue, Jun 11, 2024 at 6:01=E2=80=AFPM Mathias Nyman
> > <mathias.nyman@linux.intel.com> wrote:
> >>
> >> On 6.6.2024 17.08, joswang wrote:
> >>> On Wed, Jun 5, 2024 at 6:31=E2=80=AFPM Mathias Nyman
> >>> <mathias.nyman@linux.intel.com> wrote:
> >> ...
> >>>>
> >>>> I was thinking of turning XHCI_AVOID_BEI behavior into the new defau=
lt, so no
> >>>> quirk flag would be needed:
> >>>>
> >>>> Currently without the quirk flag:
> >>>>
> >>>> - ISOC TRBs trigger interrupt if TRB is the last in the TD
> >>>>
> >>>> Currently with XHCI_AVOID_BEI quirk flag:
> >>>>
> >>>> - ISOC TRBs trigger interrupt if TRB is the last in the TD
> >>>> - Interrupt is additionally triggered every 32 isoc TRB (initially).
> >>>> - if more than 128 events are processed in one interrupt then the
> >>>>      32 is halved, and we trigger an interrupts every 16th isoc TRB,=
 and so
> >>>>      on, 16 -> 8...
> >>>>
> >>>> I would remove the quirk flag, and make all controllers interrupt
> >>>> behave as if it was set. i.e. interrupt at least every 32 isoc TRB
> >>>
> >>> Thank you for your detailed analysis.
> >>> Excuse me, I have a question, do you mean to set "Currently with
> >>> XHCI_AVOID_BEI quirk flag" as the default behavior?
> >>
> >> Yes, unless it causes some issues or there are strong objections
> >>
> >>>>
> >>>> Is there an actual real world case where interrupting every 32nd ISO=
C TRB is
> >>>> too often?
> >>>
> >>> I mean that if the XHCI_AVOID_BEI quirk flag is set, an interrupt wil=
l
> >>> be triggered every 8 TRBs, which makes the interrupts seem to be quit=
e
> >>> frequent.
> >>> Thanks
> >>> Jos
> >>>
> >>
> >> It should start with interrupting every 32nd isoc TD, not 8th
> >>
> >> #define AVOID_BEI_INTERVAL_MAX   32
> >>
> >> ir->isoc_bei_interval =3D AVOID_BEI_INTERVAL_MAX;
> >>
> >> Thanks
> >> Mathias
> >
> > As you mentioned=EF=BC=8Cif more than 128 events are processed in one
> > interrupt then the 32 is halved, and we trigger an interrupts every
> > 16th isoc TRB, and so on, 16 -> 8...
> > xhci_handle_events()
> >      ......
> >      if (event_loop++ > TRBS_PER_SEGMENT / 2) {
> >           if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
> >                ir->isoc_bei_interval =3D ir->isoc_bei_interval / 2;
> >      }
> >      .......
>
> Yes, and to me this seems reasonable .
> If there are over 128 events per interrupt then we should interrupt more =
often.
>
> Would this work as the default for the Synopsys hosts you are working wit=
h?
>
> Thanks
> Mathias

Without enabling XHCI_AVOID_BEI quirk, that is, triggering an
interrupt once for every 32TRB:
For some USB cameras (such as high-resolution cameras, etc.), the data
volume of one frame is relatively large, and the host controller will
frequently trigger interrupts during data transmission. For some SOC
platforms (such as rockchip platforms, which also use Synopsys USB IP)
with poor performance, it is possible that the CPU cannot respond to
interrupts in time, resulting in frame loss.
Therefore, I think that using XHCI_AVOID_BEI quirk by default may
aggravate the above problem. Please help evaluate, thank you.

Thanks,
Jos Wang

