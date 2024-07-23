Return-Path: <linux-kernel+bounces-259943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA20F93A039
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A411E2838B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E80152199;
	Tue, 23 Jul 2024 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dd2rXOqN"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893915217D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735389; cv=none; b=iRIHdvX9VVbJKyJlzD9xQPaU5e693XC97/Ugiux88yZZMJOW77Q1axxOTIxZAN2tOPKfOH+D0qYkAbg2UZ401mzBDMpwvOWgVzzzc18cy3UlW4gHnuADAkkoc9TP1r4XnapfzGVeGL3+ByCstpcHr3qb9u2jl45JKVwWAHgW3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735389; c=relaxed/simple;
	bh=hCpkp5ANZ8OkyRK1jIyFubJUFgQl0f1cvXrspwfYuRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLUoDLtmh0cyFee0OuCZ97Mf6hcL5BBJdh2VBBU2hvUw93jjapKwPgHR1EZWyla5Bz/a5gio/8DAWuKhW7mW9XRdkzNDTXVgMgs81G1DI3HK/bDZWwTlpvKyOsJNPe70WQwvNGT5KHuAvueprY7AXHB8mlN2whzxThf1XwMcYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dd2rXOqN; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e05ebd3d607so5334442276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721735387; x=1722340187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=llaCJsVSUmU+Pmrfx22YDYSfpr8wrINFhr1BhQOlVyc=;
        b=dd2rXOqNr3sLwF0+oZwHXvguuj3L6yvtCV7VmzYHmD4wXCawQBgU8IGkDtwls2oXjT
         myXzwIVvdNfxZY+mM2ud3pjdMK4IShzAdcT/21InXxosdmw6G0WdngbgFm8Jx4voYlwv
         flfZJl6kvvd7CKw8NptA943+G5tXwWEQP9UJ4rU1m8Q8WUN7ThKzkZel7phk3DoIyQAg
         L8Ue8iksb1lZ7e2IFrUg2VRB79+kA6xxub4aKZEdooE8oODzaX9y/z6lcYzcwrw7/t7U
         oKP2iQbaV7vQWC9XvsnhZKS01xCK8tJcEP9Enbzbe7jfkoUBoromzjnVctIGaTwP8Uxo
         3K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721735387; x=1722340187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llaCJsVSUmU+Pmrfx22YDYSfpr8wrINFhr1BhQOlVyc=;
        b=VcyfUDlUSATQGCt2LIbXDF5jRH23RcBNTFHCI2/DLf6j8fYv8kstrjFuTlqCDB2a/2
         EvawZaHC+HYZ+BSvxkUiVEoWD/lHXXM+NoKaDz5LyfrDSWgOt+5b2FaHVgGtmRqSPqwm
         UaiiD3IeJcF9b1/VmsGkkwP2gJKAjCnJK3HfNa4ecSigGZIqMJ5xcTivHyYkH6ViE6Sy
         SkhTHBjzHGDg//gEOvVagFef42MSZrS3mdP0qDh5gPJfO/ec1MrpgRpzBBE64+3y3M31
         BMXYUeSyt+1BTwxRXgCckyz5/qukt/nfmJHIawXCu6PtxIxnQbB6UwPsDiXdKqGP5qh2
         dtKg==
X-Forwarded-Encrypted: i=1; AJvYcCVg3Rkog4dfV4CmICc3a0FuRWQ4ug7yYUIBKiuuT890iG+fNHlGhy0lmjssPjqelQtXBFJN5XJCpnEFu+k+yHGDdQt89hVl7iohjnOS
X-Gm-Message-State: AOJu0YxKUP+maHVCFh6tQw5k3w/2bwg+GCZjOfXv9dL8WCMXFq7DdllM
	7j8DIj+tXFDBw2P0QU7w657YzmrIxaJ9n9ge6I8yECZFhVtwzX2J9QcO/yF2nnvSBEF6JGh/uov
	8OFPzvtviNjrLsMj4ry3C+1Mut9FK6qz2wLv/5g==
X-Google-Smtp-Source: AGHT+IGuO4i1P5RHinuVPAWDIVC3NOtN+MxiPreBx2aMxJvTATo97Thp/RKQ+zI6rh4tuhZUg++9l/QZJxL5swB8y84=
X-Received: by 2002:a05:6902:1025:b0:e08:567c:c9c4 with SMTP id
 3f1490d57ef6-e086fe5459emr11815420276.6.1721735387259; Tue, 23 Jul 2024
 04:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-linux-next-24-07-13-sc8280xp-camcc-fixes-v1-1-fadb5d9445c1@linaro.org>
 <f0d4b7a3-2b61-3d42-a430-34b30eeaa644@quicinc.com> <86068581-0ce7-47b5-b1c6-fda4f7d1037f@linaro.org>
 <02679111-1a35-b931-fecd-01c952553652@quicinc.com> <ce14800d-7411-47c5-ad46-6baa6fb678f4@linaro.org>
 <dd588276-8f1c-4389-7b3a-88f483b7072e@quicinc.com> <610efa39-e476-45ae-bd2b-3a0b8ea485dc@linaro.org>
 <6055cb14-de80-97bc-be23-7af8ffc89fcc@quicinc.com> <a0ac4c3b-3c46-4c89-9947-d91ba06309f4@linaro.org>
 <8dfc5456-861b-e01a-d2d2-1bb9adea1984@quicinc.com>
In-Reply-To: <8dfc5456-861b-e01a-d2d2-1bb9adea1984@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jul 2024 14:49:36 +0300
Message-ID: <CAA8EJpqrxCyeJJGSORtfvi-bBdqPOjr6xO4gff2W+LBCEVoxJQ@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: camcc-sc8280xp: Remove always-on GDSC hard-coding
To: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, stable@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 14:37, Satya Priya Kakitapalli (Temp)
<quic_skakitap@quicinc.com> wrote:
>
>
> On 7/23/2024 2:59 PM, Bryan O'Donoghue wrote:
> > On 22/07/2024 09:57, Satya Priya Kakitapalli (Temp) wrote:
> >>> I have no idea. Why does it matter ?
> >>>
> >>
> >> This clock expected to be kept always ON, as per design, or else the
> >> GDSC transition form ON to OFF (vice versa) wont work.
> >
> > Yes, parking to XO per this patch works for me. So I guess its already
> > on and is left in that state by the park.
> >
>
> Parking RCG to XO doesn't keep the branch clock always-on. It just keeps
> the parent RCG at 19.2MHz, branch can still be disabled by clearing
> bit(0). So during late init, the CCF will disable this clock(in
> clk_disable_unused API) if modelled. Hence this clock shouldn't be modelled.

But it is already modelled:

static struct clk_branch camcc_gdsc_clk = {
        .halt_reg = 0xc1e4,
        .halt_check = BRANCH_HALT,
....
};

>
>
> >> Want to know the clock status after bootup, to understand if the
> >> clock got turned off during the late init. May I know exactly what
> >> you have tested? Did you test the camera usecases as well?
> >
> > Of course.
> >
> > The camera works on x13s with this patch. That's what I mean by tested.
> >
> > ---
> > bod



-- 
With best wishes
Dmitry

