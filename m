Return-Path: <linux-kernel+bounces-433512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B4F9E5963
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E1163AA9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351C1B0F22;
	Thu,  5 Dec 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="pTr+GQVS"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429A218EB8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411391; cv=none; b=JQgMjz/zzp73SwurB01p+JOIklIarUp8Y7ilemomXB+iqj72evrE62vaBslWtVORAh8JNgdjLIi3p/T8iys1TEnyIaoG5+m5gUD6kIgc0ED0Bj/8uxkG1oTKxsH/qocyJkiAQlWfOnNz1YNd5TxskakUq1xUSlh6La6kGxMCWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411391; c=relaxed/simple;
	bh=kuDwn5MNGL8adcYkNgcDkUlwY1RIiGi86ZN+oVM7n88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et4NjXJH8CbawyDwQh52Jf6uCm2VDUX7WN8eLrJczMuos/iOJpzfMIm979yL3cAFauhkbjHVi9c8HkVn3XDHcxMqA11e7zbgr/JrFS3bLVyXK+HzYKhwTDE0Gl72ldFoHrsA4Rf8qGDyivnjUMHyHwSBC1eAfd+A8OpVUQ9UAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=pTr+GQVS; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d87ceb58a0so8425246d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1733411389; x=1734016189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQOjMRYvtbhFCrEpt4LKpQp+egpXGKfp+zEXaVand9M=;
        b=pTr+GQVSEBdXCHfRc7MlFWfrTl3TaR42/zz/0KKrzLFfcX43Mo8/7iiylCN96BSKZl
         o9ufFCDF/MoGlOAQWj/eD90WdDm+C/bNLlBaMMYoJjItJ770CoMUEke4fSmazmLvbjd+
         PXCZC4Wc+Eil5WThzfLM/RSA/gcQaCxxtkIY45rgKGERPrf7kPVdCOppPztEUc2DMry4
         LhH1w6msmU5QGDW+HN7kbR/w/ln3rkk/YicCjwS2GkSzGJnYJElp+XI8+ZCqLuaohgne
         qj1qTOijcgorvoRyqm2xGUKynNMZPz1xhLWXNADC+GsXB+MCb1ZdY39CRT3Fgzonf70j
         2HPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411389; x=1734016189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQOjMRYvtbhFCrEpt4LKpQp+egpXGKfp+zEXaVand9M=;
        b=T6B6vj6FS2YEDo8U0jny97ejY46bPYswsacCOgnjF4GUEM7kmEyDaIB7pY2csh+N2b
         D85nVyK2feYLXWOY4RKrRfSfXfqDrQ7PRp7eUGw2e987Tg3Dr07t6k+o3z04uMHtH7HX
         KFrwBE9QTkDy3hesp05+uWdJfzsIzU1h60j+eNqxpz/w3VrmGMu2T/nzoWf4OWHZtRpv
         Zz0zbTV1qo9GzfmdhGQpBa8Elhu5kVIKPHlV/9a9M5CmbSZJjyVSzV9gEmAHoR6ef2T9
         CeGL568iBqzEdG7gq38vqEMPIcOLVUSG/JUwl1TO6r+U4Tii7zyohJ3941GXjBpP9JNz
         owbA==
X-Forwarded-Encrypted: i=1; AJvYcCVc0Zu47eLRoYrzoARJHylvZlnkVMWHYgC8J41Qv+dFsBHOmEHnknpYZ3MYIWXU4eQw3jK8I5DQ5zCg30k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2aeZhLSkHbEKDGhfH8XNMtVA1CAws7UynXkxUloh/rcewf7+D
	GHEx2MOHE8MYB2FcNyWaxMRYEflOnA7RkzbOEfjswuEfoLYX03KIlDDI4I1KRw==
X-Gm-Gg: ASbGncvkjXYLPlOwEDRCICWdWrnsXvgZ5GCmK6kyGpbAC920OQMR5btXHHedav9ywbs
	YnpfGSjHX/aFeDhR/PyfDAliSRJGPo4V2YCimiT7KD5rgKtBZOudmwtEauHaOnhiLzBZSEV/k+w
	q4LTrn5e1zXhsILfas9en2hHkP3Jki59QKCw9Uq+KnR5y+kIgqcVFQXK55KfE/CROJJ8bYJJrP9
	R+l7+UnbediMLSz9eK7CBPMRv2Qu/51wd/VO9DS8T73bxIREus=
X-Google-Smtp-Source: AGHT+IHhbf/pZzCcxgVHVLVyaXCHOzFn02c6Zf1CQlCRr1jsnO2iE7Rk8YDhgArk93K5vr5mhEnW9g==
X-Received: by 2002:a05:6214:27e4:b0:6d8:8f14:2f5c with SMTP id 6a1803df08f44-6d8b73a6cb9mr151197666d6.23.1733411389235;
        Thu, 05 Dec 2024 07:09:49 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::d4d1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da695c98sm7453136d6.33.2024.12.05.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:09:48 -0800 (PST)
Date: Thu, 5 Dec 2024 10:09:46 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
Message-ID: <f6621a09-d5e4-4d3b-9b5c-55294c22030f@rowland.harvard.edu>
References: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
 <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com>

On Thu, Dec 05, 2024 at 12:55:08PM +0100, Rafael J. Wysocki wrote:
> Expanded CC list.
> 
> On Thu, Nov 14, 2024 at 4:23 AM Len Brown <lenb@kernel.org> wrote:
> >
> > From: Len Brown <len.brown@intel.com>
> >
> > Drivers commonly return non-zero values from their suspend
> > callbacks due to transient errors, not realizing that doing so
> > aborts system-wide suspend.
> >
> > Log, but do not abort system suspend on non-zero return values
> > from driver's .suspend/.suspend_noirq/.suspend_late callbacks.
> >
> > Both before and after this patch, the correct method for a
> > device driver to abort system-wide suspend is to invoke
> > pm_system_wakeup() during the suspend flow.
> >
> > Legacy behaviour can be restored by adding this line to your .config:
> > CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=y
> >
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > ---

> 
> I'm wondering if there are any opinions on this.
> 
> IMV, drivers returning errors from their suspend callbacks without a
> sufficiently serious reason are kind of a problem.

There is a least one driver whose suspend callback returns an error if 
the device is enabled for wakeup and a wakeup event occurs during the 
suspend procedure.  We don't want to ignore those races.

Alan Stern

