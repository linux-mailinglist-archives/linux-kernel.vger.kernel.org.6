Return-Path: <linux-kernel+bounces-512301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51C2A33741
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAEC3A379D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4186325;
	Thu, 13 Feb 2025 05:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyAiXhOb"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B7145355
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424693; cv=none; b=TL1DzuV+5ChnVTBk7YRH6S9unxriRF6fxRg6ti8h1aGGhbILph7OfZmK2wWLJjV6BKxEavuGfukTl75JIcma37qlZeakawJlr88caQY4wvO5cOf06CLIm3nF/+LgG5MyuSsPzjpIdWRF0LIvmKkAe9rcVRaja3/Gy/0xptRgVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424693; c=relaxed/simple;
	bh=cnl2m4eSSFzUd2FI5RbArgk7aO/6MxFZUQsO6v5J5lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beUoU/vU5zNXjPzG7apMDuQSXjSf16jAu/Ok5cj64vR41zs8h5NuhaR/buYQc/mFbbhDYZkzOSVd1KkQJFxf7ilQtntjWoj39abgniwOWfRFzT+Gxex5++KnPdTm8gFAh8YJTD+uk27AHlGNh+/UrIsc2XUDMrycZYNgLR6x4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VyAiXhOb; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4bbcbbd0bb9so258973137.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739424691; x=1740029491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vx7h+AT1hd02pbPgDY1t0vIhjDwtSi7eGcVZkGc6A8=;
        b=VyAiXhOboCruzyZg0WmhtOqWcSocuOliKA1bYpi4T10kzluScfFmftE0BQ2M9cUsfq
         cqLrmul82UAo6T/ffNrQuErQ6/zgZpQ5XcUenbEGQTwhcONoj6+3rI6kIzvw6YgmJA34
         mWbjrhi9BpwTu0CEWT1FInP2PRq15N2A13RyVqX6OG/+0mPNwjGbZRiMuhdb+IHuDoJN
         97y+LY6WUwH2WNu2dMJ6I/Gjkc9xZGr4OJB3fNzGoBuk5QitdYD1evdJwIRdBROKh0T4
         zJd0sAmuFl5IQIpz68FaJqI7i+r5pcPb6hhe9cCXtURAnbeIFtTd0NJVYER0/hlh1gTk
         asVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739424691; x=1740029491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Vx7h+AT1hd02pbPgDY1t0vIhjDwtSi7eGcVZkGc6A8=;
        b=dSkhUdncaqRh9OHNP51ytEsbvacZFZel4rcOXzTjce2QbgKWLiWJfi7BglsCtyxocg
         h/unss/6+FhwA7UDlRAM3lO1zP9/FJqT8nWqYyxgsSkzk1NxShyqSfEVjAlEqQ8UGCCR
         Ho3UaRgiNtd9YE6KOVTzaWnL9+rTMrMRm8B0i3LD8wEsIhzlDGH3cU1HPhJDId4j8NXm
         ufkiOWIs81f5uwy7+lrbBxg/GSBqGsXt2EWWlq4JXExKz4IJLzWPlWJLqPDe3WkAMotC
         E8dEMQ4kbSe3rE7VPNOqdsXMadyYzD6tYVjtdq578b/Zlxl/ROY8t9mWHPP8tbkkY+AU
         qDLA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ75tIyNZWDkT8NPD8mbA5UIGQjdSo9cf8RJGPTbbYW2XN2vvN4giXaki/IY2iHmi4DmZnckHbE8/tJ4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWB+aa3jhiwUO/Ama3J48Owin6JRl2eTK7530ItYSvxwDKezo2
	tcpKDskd75RA7tcGxYe66kY7+GNGTv/L5ZoSXP2neNP1SE3sKLY0ZZiHzjqSWA4TZWpt2wJAWw3
	BNrZF7ZVQueP0jF399o8nh3MjTyyC8VK8thuBIg==
X-Gm-Gg: ASbGncseslA2CdrSAmlxw6R5ULCKVfqf4IPZVtJFKa0M/PtxDokpKAtqmmDf6Q8MZwj
	zhMrKAxIJf3E7sip7MJFqi7XXlQit+rrCUe8sJz2apLHYdDpFtlOOcqKa1mpJwUykUQ2ew6+ADq
	I=
X-Google-Smtp-Source: AGHT+IE1b09Y0oh2SgYAlecKTFu/d9b/vl21w0WdHCnWjWmlZjDq81Lo0AiehcZEq4EZhisIZQ80PeR271tttdICELo=
X-Received: by 2002:a05:6102:1620:b0:4bb:d062:422 with SMTP id
 ada2fe7eead31-4bbf209b9eemr6518734137.3.1739424690944; Wed, 12 Feb 2025
 21:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210232227.97761-1-stuart.yoder@arm.com> <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
 <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com> <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
 <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
In-Reply-To: <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 13 Feb 2025 11:01:20 +0530
X-Gm-Features: AWEUYZkUe-JQu9WB8sdTJHZU0cqiP0txO2dUkC_k7zFWA78tOzalgc25rjYtTJQ
Message-ID: <CAFA6WYM0ANqc--ScYtJFRjOsCCjzO3NX46=F5V=rza_6Q-Q96g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de, 
	jgg@ziepe.ca, sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Wiklander <jens.wiklander@linaro.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

+ Rob

On Thu, 13 Feb 2025 at 03:25, Stuart Yoder <stuart.yoder@arm.com> wrote:
>
>
>
> On 2/12/25 1:39 AM, Sumit Garg wrote:
> > On Tue, 11 Feb 2025 at 21:39, Stuart Yoder <stuart.yoder@arm.com> wrote:
> >>
> >> Hi Sumit,
> >>
> >> On 2/11/25 12:45 AM, Sumit Garg wrote:
> >>> + Jens
> >>>
> >>> Hi Stuart,
> >>>
> >>> On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
> >>>>
> >>>> These patches add support for the CRB FF-A start method defined
> >>>> in the TCG ACPI specification v1.4 and the FF-A ABI defined
> >>>> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
> >>>> (https://developer.arm.com/documentation/den0138/latest/)
> >>>
> >>> Nice to have a specification standardizing interface to TPM
> >>> managed/implemented by the firmware. Care to add corresponding kernel
> >>> documentation under Documentation/security/tpm/.
> >>
> >> Yes, I can add some documentation there.
> >>
> >>> BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
> >>> possibilities for an abstraction layer on top of communication channel
> >>> based on either FF-A or TEE or platform bus?
> >>
> >> I think the CRB and OP-TEE based messaging approaches for interacting
> >> with a TZ-based TPM are fundamentally different and I don't see how
> >> to harmonize them through some abstraction.
> >>
> >> The OP-TEE TPM protocol copies the TPM command into a temp shared memory
> >> buffer and sends a message to the TPM referencing that buffer.
> >>
> >> The CRB uses a permanently shared memory carve-out that in addition
> >> to the command/response data has other fields for locality control,
> >> command control, status, TPM idle, etc. The only 'message' needed is
> >> something to signal 'start'.  Any OS that is FF-A aware and has a
> >> CRB driver can simply add a new start method, which is what this
> >> patch series does.
> >
> > Okay, I see how the CRB driver is closely tied to the ACPI based
> > systems.
>
> The CRB driver is currently probed based on ACPI, but it fundamentally
> doesn't have to be.  If there was a DT binding for CRB-based
> TPMs the different start methods would be defined there and the
> CRB driver could support that.
>

Can't we rather enable the CRB driver itself probed based on FF-A bus
and rather dynamically discover the shared memory buffer via FF-A
instead? AFAIU, FF-A provides you with a discovery framework for
firmware bits. But if we still want to overload ACPI or DT with the
discoverable firmware bits then it seems like an overkill here.

> > I was expecting the FF-A based TPM interface to be
> > independent of ACPI or DT such that it's not constrained by the
> > hardware description a platform chooses to use. I suppose there will
> > be a different TPM FF-A driver or spec when someone wants to deploy it
> > on DT based systems, right?
>
> The CRB is just a shared memory buffer, with some architected semantics
> defined by TCG. The basic CRB usage model is that a client puts
> something in the CRB, such as the bytes of a TPM command, and then
> notifies the TPM that a change was made to the CRB. The CRB over
> FF-A spec just defines the message to perform that notification
> when FF-A is used.
>
> So, whether the fTPM was advertised via ACPI or DT, it doesn't matter.
> The FF-A based interface is only about the the notification messages
> needed for the OS driver to tell the TPM that something has changed
> in the CRB.

-Sumit

