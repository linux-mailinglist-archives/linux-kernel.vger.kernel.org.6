Return-Path: <linux-kernel+bounces-337273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FF09847F0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13446286CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A362B1AAE38;
	Tue, 24 Sep 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="A34i9DgE"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDAF1AAE16
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189059; cv=none; b=HWomoSsALUN+xYXU9NL7i07zkXT9L7RTd0M1hFpvIsLv8NhkOCnOg9w3PPyi1Q5bbbs01HacfwdXlulw+Frhq//uez4f5QotzvnxX6/DbIsHafAcNiDPvmI96lL4PksEXVtnTKZnBbZUixR5bDddPIF9LH7xk7Pmc6r3Zp/Alq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189059; c=relaxed/simple;
	bh=OnGN/XN+ee5MdZgun573fNASG088NLEb1co14YIjXWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JB4WVkMycd5G3gAOf6xCMSRQ1eZGlneCKPrt1/q7v10dzIq237V5QO3CW+nXH0a1wODBFjhxPMsni9T+GmEAXSPn6rIrtg5xsbHXSVQzpKYZnvv05a2QariWXwOr5N5tqOmAUELufffSd2enpP3knwP3zOLATxFcbnWfAahtlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=A34i9DgE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso4387155a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727189057; x=1727793857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OnGN/XN+ee5MdZgun573fNASG088NLEb1co14YIjXWE=;
        b=A34i9DgEADcWy+RGyIPUOW03d5lQe80fHYVsgi/CEOXwnN13aUFEMStHSazg8GM+LB
         d4LHM0jGu5P1Ibdydlq7sVImD59xcrWbrVfF+9Q8KqEaykoi/P4v95B0/MhQcuW6PF3A
         Faj3Vrn6xZG6UpijIdp0n4KbgJ0IrCgs9ytJFrZo8cE98r//izJDvwbpx4pAVuq8qECT
         FOoI2Wx8HQA+dw7czi42QwvONAWWHR+jl7P4HNZz1Yei+5e4LK34cqpWG94szjP33vd2
         RnV/J63Q4BcYGMiadtpQ5eGOAp9yhmyUWUmHDcEErU9fyl0J8odyo7IiQzEm/xnpt60K
         SkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727189057; x=1727793857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnGN/XN+ee5MdZgun573fNASG088NLEb1co14YIjXWE=;
        b=oeV0WnuQyRhq1LHqP/5eZhQgUL77x/NgEPzRcy1tJkunhY4LFUMZlujVUjeLBYKWzr
         8yzzfm+aT1l0/9QlupqjvaPPcVWtPwj+GX9+wC1iCe0DH5UscOxvyW/n19Ojs9RQ7jdw
         PMbw9DegUFxiedy143fUBsokFYcCv6TnKNu7v6YFrSi/2b4oDpSpjgZkur/yLGt1XIGS
         0ZwEzF0qovOizBNrOYs6K8JmKgMWQeot0PC9N/V6qfOLoytgrssUwl5UMuy7uzKDXkWi
         jV9tpLSlADs+yFmmsnwWwvOnP9L+wzAwNBEyfZB0ROJ9XsuQm3XX9ZsE1jXoDYz+YUOb
         zUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx+Eqgx8ZTM8IkiD+C/xGoyrIYJaF1if9U3p3LcSgrPqxIc7KyKOA9p4Y+oy8CuGsDQT2veaQCivFN1zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvpdiTdKA7VsJIySvO56LGlFn7zHi0hJ1VzOMu26Y0dBD4aGz
	M3bg6snWfjTsArNsSpdI4fZx2Q365a5lY+z52Pz+XCa6b0MWKmukudC/lvltLI6SvIcr+O8yfOF
	mKoKlamkIxs20TtHeKTo1V5qLXl6xKAe0RhYdfg==
X-Google-Smtp-Source: AGHT+IEY5FaohvDwhChVCfAb8IAInDakknFlo9kWlRYgAaj5nylT5EknAUxa83Yq83BTkwNcoKuexQZsbJhiVwlewVs=
X-Received: by 2002:a17:90a:ca96:b0:2cb:e429:f525 with SMTP id
 98e67ed59e1d1-2dd7f756480mr20035620a91.33.1727189056764; Tue, 24 Sep 2024
 07:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628115451.4169902-1-naresh.solanki@9elements.com>
 <349543e5-21b2-4725-9b33-1fcb4ae124f6@roeck-us.net> <CABqG17hpqFG-PeyENXnGn9k7V2goBP+k6BtSURoMM7DgXtxWmA@mail.gmail.com>
 <0aaed899-9001-4355-bcca-17855576a928@roeck-us.net>
In-Reply-To: <0aaed899-9001-4355-bcca-17855576a928@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 24 Sep 2024 20:14:06 +0530
Message-ID: <CABqG17h0+HWSCF0PRVBaj37WYYsz17+n1MD1Uiuscqy_dvU41g@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (max6639) : Add DT support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Tue, 24 Sept 2024 at 19:42, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 9/24/24 02:29, Naresh Solanki wrote:
> > Hi Guenter,
> >
> > Sorry for the late reply,
> >
> > On Fri, 28 Jun 2024 at 20:30, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 6/28/24 04:54, Naresh Solanki wrote:
> >>> Remove platform data & add devicetree support.
> >>>
> >>
> >> Unless I am missing something, this doesn't just add devicetree support,
> >> it actually _mandates_ devicetree support. There are no defaults.
> >> That is not acceptable.
> > I agree with you. It is best to have some defaults & then overwrite
> > based on DT properties.
> > But in that case we would have to assume that all fans are enabled
> > irrespective of their hardware connections in the schematics(example
> > fan_enable).
> >
> > I'm not sure if that is fine. But if you feel that is alright then
> > I'll rewrite the driver to assume
> > everything is enabled with default values.
>
> That would still be a functional change, or am I missing something ?
> It would overwrite any configuration written by a BIOS/ROMMON.
With that, driver would take the current chip configuration as default &
just configure specific config specified in DT(if any) & continue with
initialization?
This can keep into account the Chip defaults, BIOS written configuration
& even DT.
Is this what you mean ?
If yes then I'll align the driver accordingly.
Please let me know if I understood your intent correctly & any other
thoughts on this.

Regards,
Naresh

>
> Guenter
>

