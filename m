Return-Path: <linux-kernel+bounces-513598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ABEA34C39
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7533A4847
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B69C221725;
	Thu, 13 Feb 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3oOeehKh"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509FD211A36
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468447; cv=none; b=Y3xBR9ZDxeCnUSUJUskG+tJ60r5PYxx7NwYo0GFmeqi5kifEW0SMG4+A+0L40WEJztSlkKisry7DGOmSstbWa+uuzzCjITpJrMxKGI1nvomgxB/UzDi4RkR6gDSPj5yxrQiIIc7RpT3FO0acj2Zte+ITRYbW3j5wcdhafD13ERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468447; c=relaxed/simple;
	bh=PJn/xWyVQP+NbgKG1/5cj+3Ej4/TjwfE7JOTLbKKggU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3kysxn0b5dOi8ivdRo6ZPTDkaTXcn/5PUuFD+HGKE3ggThX32jDCaul2+9GDkVjnTMnoV2dYUdw0i38QcrfF1xpTyvN4aQV2cCOWkYstfT+CFhQMZzaZFRhylHDckNKbg3dsuQXdMXLY2fpWbApL7/hB3HbbrBal838kknOEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3oOeehKh; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-544043a21eeso7378e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739468443; x=1740073243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI0uvgkCUAQzUsKPd2Q1CMBy3nXX2t1tLsj93zCjWX8=;
        b=3oOeehKhwfXP+9oYqVpUBg7eBUK4AbSj2Q4kGICcT6l6zAauWPHSogFSX4kw9SAqgn
         Qnag9LaGIjdcM9Jb5MHvGYA6+DEdZnWc5TuMzviFEz7LubRYgJx8gyNYxv5acvwx8qul
         1m6aEuXitla6wLDNx7p9+Aq025AHXCeMjrOgr6eb4riOaJmahXLtnPB94K4nzAQSLFe2
         sGicoTJB5Aq6S8iOi3JB03sOUQ4QThUGgN7yuNRNT9hUV0ttGREc6WXpaGFgiww6cybn
         nSmUtt0kd8nbOV6Kbg8ag6ZnrC4M/6iqrplrAlfe4Tk8JUn3b5Ug5DNoAidY0cueZ6gP
         gWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468443; x=1740073243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI0uvgkCUAQzUsKPd2Q1CMBy3nXX2t1tLsj93zCjWX8=;
        b=QrzKgKYH+YoWhPvbPaO9vEHV8pmcZ3IcWaGrPo85jbOgCLcI+6v+aJZmwAYXwYQgPH
         bgjj6+I7vF1OWAJXPDxvZ1+Sx5RqfqPR9JPes8d3nT/sVZ2fIgMMPjM0Zx0OMd2vY9dp
         eiIWKQ+Lp330rQH/UynosxL+VuCAqG4UlyGFtqVNls3Rjott2z59+KLGeEGleLbbD4AU
         UivYNCUyLYwHnq4RNzFqG3yx4LwnCikciOOALR2F11ljxibD+UnIPBQnITJC8wSilTAK
         b7FweehuvbSuzswh2InL/sMnSoF6lT8UZCIlm/mAtxlXNjXCVdGN7RRrJhF+ddFfP06p
         mn/g==
X-Forwarded-Encrypted: i=1; AJvYcCXr1HMLeMCqDMExw07nCnstnrR/bP5hwablvHT8jt1x5/cHonyMLZzS+WvJ+S/88NPbtFbd36f0miHH2n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiYxPEoGzYkXMwSgLSmkS3Jk4nuDeRXvlYPovKMv3fb+iDex0
	bmIVDHg9XlfefIDKR2yy/wsr5H5uIvrEg5l+xwYBy+DxPj/XBM1CEFJg3W5QGhZ1bispe3fzFD1
	EYJaOxzkL28tcpSSVbjgVSKU/Nt++8cLMke8T
X-Gm-Gg: ASbGnct32oA2BUZ/TJoxj8uA2e8Iselxo8xoB18nDoUS2litu5HwrEJeuWtMi2evoG2
	X3/jka+U6QKV49VFMlCzlAe76Dov/+G8aXnevAAK+OYl0MoPd7EiM60a63/CpHsP/7j4lQ47n1Z
	ZWNuutioqs2STgfIzkWP5TKSSlUcDY
X-Google-Smtp-Source: AGHT+IHCscE0kQcny+7+pxlz/JKjpDU7Xmel9GvNySr8+k+ezi8pDuGOWCHVRqHYoHCadEroGET+4KmA6Vqca8S/8aA=
X-Received: by 2002:a05:6512:118d:b0:540:2543:3ea6 with SMTP id
 2adb3069b0e04-5451df69611mr324234e87.0.1739468443175; Thu, 13 Feb 2025
 09:40:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212000747.3403836-1-vannapurve@google.com>
 <20250212000747.3403836-5-vannapurve@google.com> <avodert2s5di3s4m3ays6z4qhskwfz6zxenoq3rsf7crpclkfz@jaq7ptkmco4o>
In-Reply-To: <avodert2s5di3s4m3ays6z4qhskwfz6zxenoq3rsf7crpclkfz@jaq7ptkmco4o>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 13 Feb 2025 09:40:31 -0800
X-Gm-Features: AWEUYZkHJzqGHOSRVIe0nepyd4-5c6NKDhi4t8FPJvlO1zoPxUpzsf7BIsKRtaw
Message-ID: <CAGtprH8Ts9ScKUTraw-V20mLvdGjT_ggZCwWQD393KgfVa1nNA@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] x86/tdx: Remove TDX specific idle routine
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 5:03=E2=80=AFAM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> On Wed, Feb 12, 2025 at 12:07:47AM +0000, Vishal Annapurve wrote:
> > With explicit dependency on CONFIG_PARAVIRT and TDX specific
> > halt()/safe_halt() routines in place, default_idle() is safe to execute=
 for
> > TDX VMs. Remove TDX specific idle routine override which is now
> > redundant.
>
> I am not convinced that it is good idea.
>
> It adds two needless flipping of IF in the hot path: first enabling
> interrupts in tdx_safe_halt() and disabling it back in default_idle().
>

IIUC, the aspect of flipping IF in the hot path twice is also
applicable to default_idle() that gets executed for non-confidential
VMs. I agree that it's redundant for TDX VMs and if there is strong
consensus here, I can drop this cleanup in the next version.

> --
>   Kiryl Shutsemau / Kirill A. Shutemov

