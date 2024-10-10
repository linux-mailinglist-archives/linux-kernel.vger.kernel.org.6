Return-Path: <linux-kernel+bounces-358230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E294B997BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116F31C21768
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8719D070;
	Thu, 10 Oct 2024 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSjSLg2M"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B01405F7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533786; cv=none; b=In9IIXeXZq6qTJUV+CiTrDD/FnWwLrPu2WU1dIe/ihua+ma7hI6Q7k+9f9x7YbPIw53lXXyUHFKbteZnp/hF3ExQIFExEYUuPo9IOLFt3qkcRnMv5trAkAEf8oExHbVJ+i7l8Xox65twBLifCM0Z2Wpjl7c+P2Sc2DDwADDCTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533786; c=relaxed/simple;
	bh=/NOfPZ7eMm5ZzTytaiKGiKN9UkLL+n7+0hNpo6cf5sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccJtjQky9YpdQBjTPrmfKrCav71cfSnCJ8pa+e4EhwA+fs9w3cMpp3tL9HnhQBivy57o6So8B7GztyEBYWGGUC1eNirWpnBRoBqsO4v3iScgBPemZiCYeNJFyk/ICOzrnCEYozbI9C2RTs1oGi/ix6TfdkH5X2TJ/L+O2NntM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSjSLg2M; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43111d23e29so85735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728533782; x=1729138582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9CK/O4HA+lbmjqu3KI23h4Z9dZBS4xoaBV+wIbWtTc=;
        b=iSjSLg2MsDbrmkufcn5NT3CZZWsnpIZ2tJHIlJF8i0sdfBH5Ci4RFtdCUoHNw4AIlo
         kbWvzKemShGNnuuOeEDHUjSRHcY+xwajTpIseBJXem1pJHnkBNTUYLFPAKJdEXdB2hm3
         uyqd+G8VZpfyVwZylbbvOQvFpUkgdBHecSXOw6wJRKi06l9SLLlSeN/5OfXNrADqwNjl
         jcA1bdkywPpi1GVJITpgGOTaY/+zjPMUpV19MXCKU3YyWyxKo2BfcCKeW1OZSSEZqzbG
         i350bb00VDIqVD0taQjFwFSDpT8f+A/nGVMbWiQWTKYhQmQ5nJTnjHCYiMs87tLpX4KG
         qIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728533782; x=1729138582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9CK/O4HA+lbmjqu3KI23h4Z9dZBS4xoaBV+wIbWtTc=;
        b=WIjWiFnQhwjAHKVyNCTgb1AfYUXSw9Et0/EcuEMfMzfyI+elPRXia3GgrlqT7+ZUmh
         TAwHW7fkRxkuoNZE8Eyciycf18ukU9yiURM8kUo9t8VJpdw5ZypmPZ2Eo+VwHOrmF86X
         bElLEdn4a6Tnyk8FFD15iq6SudjtE0rMnrZ8rq/NQVm2giKoFwP0UMX+t/MWXrLI178+
         jFK9cEDIR5DuEg0o2/EHGe2+fAPn07zmg+tE+UzGGHGOzAuXAtxQIndB0w9keb44iz3H
         mtdnlVLEdd9lIiwcuzMRW++hHr1NtLT0YUpJ0KRsiC2VCEd6/T09C7jSsV9nBqarUnuE
         R2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVItCH7FrM5eRNmadQRZyDdL/Xh7bJLoJWfLyqsx6joTeKPrdNebkCGq6I0TQQpRnDb7+xqcidjN1o8VWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziFtCSlqToOT+YfQ4TJxXyvaXSuu4EHzRi5SCPWeUrHMOalNMD
	oumLmYvQJMfT7PoUgO6kbO08ofzukN4Wk9qjGJHdxkTcFY55g2ZSAej9btMvWsE7SxqDykNreGG
	IOOgp5GvNlkawLk0ACaH5A23sUIxjhSnQbk2w
X-Google-Smtp-Source: AGHT+IGP7qugmWppsd+XlsR9KmIIvyoIQhlhHpbvsPc4XOnMNQwrh5jCpIEK9VKbli8xlljzbWSo++KAN7+HMPOUG7g=
X-Received: by 2002:a05:600c:3ec3:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-43116e075ebmr1681815e9.1.1728533782304; Wed, 09 Oct 2024
 21:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009054429.3970438-1-guanyulin@google.com>
 <20241009054429.3970438-5-guanyulin@google.com> <2024100935-resonate-aneurism-b330@gregkh>
In-Reply-To: <2024100935-resonate-aneurism-b330@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Thu, 10 Oct 2024 12:16:00 +0800
Message-ID: <CAOuDEK11OaXX5g-1OvD3ehew=D=_PixL00PrSP2wf=O9zgUPvA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] xhci: sideband: add api to trace sideband usage
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, mathias.nyman@intel.com, 
	stern@rowland.harvard.edu, elder@kernel.org, oneukum@suse.com, 
	yajun.deng@linux.dev, dianders@chromium.org, kekrby@gmail.com, perex@perex.cz, 
	tiwai@suse.com, tj@kernel.org, stanley_chang@realtek.com, 
	andreyknvl@gmail.com, christophe.jaillet@wanadoo.fr, 
	quic_jjohnson@quicinc.com, ricardo@marliere.net, grundler@chromium.org, 
	niko.mauno@vaisala.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, badhri@google.com, 
	albertccwang@google.com, quic_wcheng@quicinc.com, pumahsu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:48=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Oct 09, 2024 at 05:42:58AM +0000, Guan-Yu Lin wrote:
> > --- a/include/linux/usb/hcd.h
> > +++ b/include/linux/usb/hcd.h
> > @@ -84,6 +84,10 @@ struct usb_hcd {
> >       struct urb              *status_urb;    /* the current status urb=
 */
> >  #ifdef CONFIG_PM
> >       struct work_struct      wakeup_work;    /* for remote wakeup */
> > +#ifdef CONFIG_USB_XHCI_SIDEBAND
> > +     /* Number of active sideband accessing the host controller. */
> > +     atomic_t                sb_usage_count;
>
> It's a reference count, use refcount_t please.

Appreciate the clear instructions, let me fix it in the next version.

