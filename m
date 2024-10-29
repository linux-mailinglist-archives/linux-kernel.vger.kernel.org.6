Return-Path: <linux-kernel+bounces-386332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AC49B4204
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FA328363C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0BA20103B;
	Tue, 29 Oct 2024 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=overdrivepizza-com.20230601.gappssmtp.com header.i=@overdrivepizza-com.20230601.gappssmtp.com header.b="VNQVjc+R"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E4D1DEFCD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181611; cv=none; b=RuG8SCEXk+oeG0uCgA4SU9P8xFypKGANLXTlX0r4WVjRPlyDhrRgPtyC8tHY0lHWnFG3+878aZXrjDcv0LGt6kSMVedqgw6kLZ6zVmtABB6IwV9gOfPbkI3uKW8zgptElRtn+pgHx9xzljAigm0D8ZqrSHgs/1ugyEN0AMjvK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181611; c=relaxed/simple;
	bh=STuoyumVNVtMRJOYEUq3GMikzDjbwQE1dapw67NiRSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqzGPlKHZNSUaNCAnRJgigdy8ZRqzNaQLIrfImkWXWDpU18IToAhYUV26EZ6cPfjHmK+rTjEE85lqndVnZjritt/LougD4EJvrivXcw2wvmeugwV/IYHI2HIUTXWi74KbTzBfReVtSAvRowyXKC0D5Vxzzb0aAbXPbmoz4QruFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=overdrivepizza.com; spf=fail smtp.mailfrom=overdrivepizza.com; dkim=pass (2048-bit key) header.d=overdrivepizza-com.20230601.gappssmtp.com header.i=@overdrivepizza-com.20230601.gappssmtp.com header.b=VNQVjc+R; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=overdrivepizza.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=overdrivepizza.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f8490856so4663380e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=overdrivepizza-com.20230601.gappssmtp.com; s=20230601; t=1730181608; x=1730786408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STuoyumVNVtMRJOYEUq3GMikzDjbwQE1dapw67NiRSc=;
        b=VNQVjc+RFUssDIS2tad9h6RyAbi7fBLkeCuOzYNqfizVSzS3Q4E9C8vCbDct7At9r9
         bsOwUVo6nD5OjK+hQfCf1uWY6zjDNnCT50MwlbR8FFdXBjUlCr3KxYreFS3SxY4c5nz5
         TVzj5GBvJ45wLJSIR1iTf0eTu7Xpy7feDZi+5hxDQOhLenh2H9do+VGAo4lln93M36Kn
         wY+JmaQDOLzP4UWoGFzgpr9BelwdTkah5zJguGTV2J0QaC6dL4bAsDhea6J3jmPjXvi8
         gRI3Xz/xYbNwg5dXrkQtVXiHs0Sz5sLbTUNRFQyhdcRCDQp7MvVxo7z7Y4pdEvp6Wkzt
         0OzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181608; x=1730786408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STuoyumVNVtMRJOYEUq3GMikzDjbwQE1dapw67NiRSc=;
        b=F22jjSTPjgOMRxTCZ3jMDOd94oKo73gxXRTM8kzKbVDips1giJZFUn1wrmwqYmcCSH
         qjMbyKdoUWBOoTLbcNXv8dWO8dLTpipf869XDZeNF5857vv62eH4sVrJBvJvRNMYKuYO
         alxZGYM4E5jYaeFcv8rMrXuMefrZK3RhQZuuXQTRw9voNbez1pP79CyPgdOqGWKQbxtR
         Aewzeg6k4lHIHin2hZiae9YAUVRd+ItfJn/6ZuH8DpRhKx9iixWBl2pkPn7m+yhjbYf5
         9csx05e3+CGUQh8mSSMsY5ojl+HRrtIuNBG+gcjiNCwvyVAN/h9KHFPf9gr8R8bxVSfQ
         Sm9w==
X-Forwarded-Encrypted: i=1; AJvYcCUxdr4Jsw3pbmlGeY0x63x9dF8AYww7xn7ud3q3F6bAIjb/7C+Uj753jv9fA7/NlLSE+pHlGZ4umq8uoyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0VUhJ/u+P8Rs/2nB5ouJe22MPpxaJMtmSJPE0XPFyxoAMZy7v
	4t9Z9ly07d8qTj/2foWN9KJ6Z7oTWCQc+pkwhwFR5169AP/3dmmfZdZwGOfIa6YWbdg4YGLOMhi
	t48hFXDPYBrc8jlb1zsSKeTH7E6d6TcIr+qnmyQ==
X-Google-Smtp-Source: AGHT+IFvEeXda2y1QRn0JVB+b7XAepT3lSggnQri1gJiW8NnWfF8vZyD+ZBW/ytfUAux41gdXNrlNs4PHAlaWmoOP+g=
X-Received: by 2002:a05:6512:b84:b0:539:e0e6:cf44 with SMTP id
 2adb3069b0e04-53b347c0d70mr5280906e87.4.1730181607621; Mon, 28 Oct 2024
 23:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927194856.096003183@infradead.org> <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble> <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>
 <20240930223848.ulipiky3uw52ej56@treble> <20241001110310.GM5594@noisy.programming.kicks-ass.net>
 <a7912ce1-131e-4b30-bed4-2576441c6212@citrix.com> <20241003121739.GB17263@noisy.programming.kicks-ass.net>
 <630467e0-6cd4-441d-a2cd-070a002c6f95@citrix.com> <PH7PR11MB757220761F23360280DF4A0DBB442@PH7PR11MB7572.namprd11.prod.outlook.com>
 <7e621780-3b19-4b60-b8a5-c0727c1eb5fd@citrix.com> <PH7PR11MB7572107D7831693B9191B998BB432@PH7PR11MB7572.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7572107D7831693B9191B998BB432@PH7PR11MB7572.namprd11.prod.outlook.com>
From: Joao Moreira <joao@overdrivepizza.com>
Date: Mon, 28 Oct 2024 22:59:56 -0700
Message-ID: <CAKUFkX03dmRL9Kk0=OLjyB0+FAx6rGXAHke4Y-NVD0au01qkNg@mail.gmail.com>
Subject: Re: [PATCH 13/14] x86: BHI stubs
To: "Constable, Scott D" <scott.d.constable@intel.com>
Cc: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Milburn, Alyssa" <alyssa.milburn@intel.com>, 
	"jose.marchesi@oracle.com" <jose.marchesi@oracle.com>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>, 
	"ndesaulniers@google.com" <ndesaulniers@google.com>, 
	"samitolvanen@google.com" <samitolvanen@google.com>, "nathan@kernel.org" <nathan@kernel.org>, 
	"ojeda@kernel.org" <ojeda@kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:06=E2=80=AFAM Constable, Scott D
<scott.d.constable@intel.com> wrote:
>
> Hello Andrew,
>
> My understanding of the FineIBT approach is that the hash values are not =
intended to be secret, and therefore leaking these hash values would not ex=
pose a new risk. Joao is also on this thread and knows a lot more about Fin=
eIBT than I do, so he can chime in if my reasoning is unsound.

Technically the hashes are not a secret indeed. With that said, I
think it was Kees who submitted a patch that randomizes the hash
values at boot time, as a security in depth / probabilistic measure
against an attacker being able to generate executable valid targets.

Tks,
Joao

