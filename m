Return-Path: <linux-kernel+bounces-560269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85E0A60143
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377A94202DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5011F37DA;
	Thu, 13 Mar 2025 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TS/dfdqH"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F741F30B2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894249; cv=none; b=gbDehNmMKWKu7UX938bXeX9dE9fy0Sxt4mbO0jtz3UBDbnxCipPjKJC4bHT0Uq88ht3d585g8RFvZ2oWwK0oPLQv73SCCZWz8Brr40p1k2FwBfCTDCUMFuyMNZmdAv9yYrBtqD/pfB3e3EVno2PdiQDrbH89M+HhNSkB2vVF68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894249; c=relaxed/simple;
	bh=7Md4guzuu+5PteE4+/PKz/uRcgnmj/2p8chBDnxxxko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbE9D/0ZD3QNLebcBa3CJRNKxNI+TNVc0r2TQR4Vth0TWrK/HVN9IYXIR8M5WRRsC8N8nKiwEMlA7PTzabQ34oUc2x+dtsgpwnNxqJ4RIxDVKj+HRiFMrkd+RZnMdbs2V2iskgjX7CwNN3CbherZ5IxuiTSbGcQHDgQl8JkYge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TS/dfdqH; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd01781b56so17477566d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741894245; x=1742499045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pU5dmfFAwtKVHugQOsEi9KoVusxSRI65CQ1c6e5/OxU=;
        b=TS/dfdqHCxtk9Ymy8JbpxdJlHMKgQYFBer9P61wrDRX6zDy0WZ8aupAlblLssuLtPD
         wjoJAT9855DSbgt/E7oU/7S8Oo9coNhP949NK4vE7C+Pi/nhwNH7KuD58EOYXqmYqsjG
         GJq9onHL5MrbVSSm7hNRhEWDBozvPAWcQkRRQaGP4htmt5OkQc1KFHIZPyeSrXVAirXq
         ICTTDEAKKJYTLTO4eUwkcBRgUDomHG5OZuyLM0xgPUoyt3bnU9Wupyoieer0Wrsr7zvR
         0DWsWCHLBM8/cXlZKFhQ4YNzpNve7dFpb8RHqSAaFaN3hb27pEvvPx7A1M7nnwnEUZ9I
         jmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741894245; x=1742499045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU5dmfFAwtKVHugQOsEi9KoVusxSRI65CQ1c6e5/OxU=;
        b=np+vy3c6jLC/6SdKChVhiT6eGkaUWQynDWDvgNximbUANdsv9biLlDmV8QXolL/Vim
         FO9bGJtirDEFAAWJVLvfNclhjrrQkp8B4C9chT1W0UuM4V9iX8B8KWRQRZHkYCCe3XvL
         UZGV0Jb+cxV4SO3EzgyjOaZ82HTMjBqO4q1clmcXnR8OM3o2vljSGCna7mlOdgPE1130
         Ex9DpvL70DlXhzknBG85hIV6W8j4J9ngtDwMC3sSFj3J0fFishg7OgBuClz9sOZRJsO0
         VxY7jogFwPomaZ59SqfMKQhX/XX3XfqbYBdMcjPe2jRfFvbOYNyDLXo9T1+0TValRRgZ
         YGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW5uqbqFxCWscj/iR8pm/zrTARF4B7EsiOQRowJDWjOqUthLVwY4tqmGuK2VvtgDLNKD3xPDo2tb+yQbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCO7EV5zjebMxxNNBkjLzfStZ4F5tFcqcKew+sRMT8ebV2U5Q0
	evpis7s7r67H38jYV26hkTaFi12aI0BdDW0MbhWcFLQtCWhrHxcNv/ZayFjn4Cw/zsjZXvYt+mf
	CfQas5iM/09PJPMfY7myhj0YYCIIPNMaW7g6g
X-Gm-Gg: ASbGncuYadYcgjiqWHWhBDHrTw5/ny6RkiemhM3aV7et8T6Zj5qB/O6KdnFePveyfU+
	WK4eTo9vdlmbj/NxNp81h81zqiGvQhgOiB+ZBEUxu78m2Mv20ZUoNdI3W0jjjtCx98L0yKpbXZi
	ygCjsOEUdG2adFRoSPbz3M0si4pG59TBxq8/5xRi50waKTxfdOKpuvgoEt
X-Google-Smtp-Source: AGHT+IErYf0CMh7pjopA3FPIsyT1DWsU21J14PsrsdFu892DgD9E7YId1+/cdaugNZMtD2vYkpyH/8y4YKpcXNKFUr0=
X-Received: by 2002:ad4:5def:0:b0:6e8:f2aa:a8af with SMTP id
 6a1803df08f44-6eae7af13camr12862786d6.38.1741894245341; Thu, 13 Mar 2025
 12:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312223434.3071598-1-royluo@google.com> <480c7796-2402-4009-9463-81280f9405bd@rowland.harvard.edu>
In-Reply-To: <480c7796-2402-4009-9463-81280f9405bd@rowland.harvard.edu>
From: Roy Luo <royluo@google.com>
Date: Thu, 13 Mar 2025 12:30:09 -0700
X-Gm-Features: AQ5f1JqqW3P8PdoKGB2y2ZgzSjr5ecrMCcWMGY3liW6jDEIX9qUAMkq0C0Wo3FQ
Message-ID: <CA+zupgxoHjK_JU-2djDa-bPFCn97gHDMnz0GSvXtJfL2mpFyyg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: core: Avoid redundant system suspend/resume callbacks
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 7:27=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, Mar 12, 2025 at 10:34:34PM +0000, Roy Luo wrote:
> > dwc3 device suspend/resume callbacks were being triggered during system
> > suspend and resume even if the device was already runtime-suspended.
> > This is redundant for device mode because the suspend and resume routin=
es
> > are essentially identical for system PM and runtime PM.
> >
> > To prevent these unnecessary callbacks, indicate to the PM core that it
> > can safely leave the device in runtime suspend if it's already
> > runtime-suspended in device mode by returning a positive value in
> > prepare() callback. This optimization only applies to devices without
> > pinctrl, as pinctrl has distinct logic tied to system suspend/resume.
> >
> > Signed-off-by: Roy Luo <royluo@google.com>
>
> Out of curiosity: What happens if the USB controller is already in
> runtime suspend (with wakeup interrupts enabled) when a system suspend
> occurs?  Does the fact that the interrupts are enabled mean the
> controller will remain able to wake up the system even if
> device_may_wakeup() is false?
>
> Alan Stern

For this specific device-mode scenario, "runtime suspend (with wakeup
interrupts enabled)" seems unlikely to happen, all irqs are masked as a
part of dwc3_gadget_suspend() and then the dwc3 core is torn down.
If this really happens in a hypothetical scenario, I would expect
device_may_wakeup() set to true when wakeup interrupt is enabled.
In device_suspend(), it does explicitly check
"(device_may_wakeup(dev) || device_wakeup_path(dev))"
and won't enable direct_complete if the device could wake up.

Best,
Roy

