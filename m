Return-Path: <linux-kernel+bounces-515593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E9A3668A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793E83B25D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B871C84D9;
	Fri, 14 Feb 2025 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kQvDgFZ8"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E21C84C0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562897; cv=none; b=NHRHuEy9dEINTKq7Z0XhBHPWec4B2eKiDoLBf7mpNrasKn6Vo9MZ72KzptHzdTbJMK2EKoolngoDFoF8YyJZ5IajKM5KCRezrIP+g98I9cQFz276lkDXQ68LvvOwiLGvXwA0CIWMttePjCl9NkRZNoiO6LyNxWcOQauB5S8EwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562897; c=relaxed/simple;
	bh=fs7xYFFwqQ62Ych3GIExCnntjCg9FP0oNJZ6VXlIsc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEY8ZnX7WYcvi0W6Tb/VsopaKU/fbCbjz7KCF9C4UG+/iPAvkDC7IgRHn+ymBMtpt8DFVfqyqx0rSu0bM/RGU5pJ57otfBMZIxyfPWR2SXmrQJferMGjWw1AC3pwBjOXyl6AEwcvMgXGoY1xSsIqD1W0oK3HVrHoM5xmRuKrN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kQvDgFZ8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220d28c215eso35044655ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739562894; x=1740167694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWHt9IRZ4IKaZ88n4ZgqoRJKrsyounHUlYV01yRt1N0=;
        b=kQvDgFZ8I+aUqOinllnU++/XWSuKF5FeyhSuClB8D7mh8zp08OmRA2lK/R9w7e5MRY
         lBCNHxK/ye6Q+QtkZvCyas7Zehojaprjn6A49Aogj6WLjfa/DKLOKfSjXbAwpuKp2lv1
         TiiR+NVd6nm0GNqE8knoxvhgjc3WMtJKVtUDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562894; x=1740167694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWHt9IRZ4IKaZ88n4ZgqoRJKrsyounHUlYV01yRt1N0=;
        b=BrotLTqKtklJV+w8Py/TsLfvLGGqwb1w5TI6Ws4f5FxTfNC9naCDH6EeRE7p+fzj7K
         7A6jrnnHafWG/BOKrBWY9ELtb3R2paQSsfVrNfMBKlCHdokEwlSSeJ7zPCmbmwlrUFOY
         6dLszaH9lmTo6A5sXi3f7kXWgz1et0xWzGYdhtSaDUDyP4mlz+SEIiZODeTB6bwC6GHr
         x4VLycMJRm29KNK8MrrfZmo4hcZVX6nOuqP1losNkzDuXvrqS1G/KEa9Cke2Y65O/28j
         YQOAH1EAk7FVZ66mkDGccHlaQsE5wNhTLN99kAbDRUmV7UEhp3dJGsdo9zRXJ/S6G76u
         BhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+arln3xuZoFAvmMaIkuf9Tkv+5kX+fTpw2uE6DIp9Dn9Hjntq/L6EnVyWyDjQhrlXteD9GkikYBr5o3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRRQDxmiRB0aoZ+xVbLByTNjHIX3NFLlmiPcRET5JcnisXTDOr
	RUr3KxBdU3e9/JS+dsDj2cXZJlTqJ8N2n4HSSupgZVa5LMxMQkgiIPsgM5QfPA==
X-Gm-Gg: ASbGnctjweZBVDA48H85LbgsMEQ1HM9Uc2Ck6xaFyy1m928+EzHwnqH2kOJMh53Evdz
	nqcH/ZL+ytl0NXgLuBMZNKKnpmPpLKVbTSgzUiEwjHBwXOlGHwB2dWuM698NniTrb9Chk6xZPP6
	naTau46XMO0bvk4nY2fZzttvkBU8fCdm5q9F8E/js781Jo2lSCRuWn5kuGCs+a2p/WgCxknaifU
	Jpwk+tcKqKuNGjKRUGK5n1SnDzX2/7gW+5nkLjUZRWvYqIenqUYccQjVSH86uewzU68+Mn73wLL
	KPdUF1Zl8/eJ++nzSEwVCvZpwgyC74s+zdG9ZqhBipxjTmzTVTriWg==
X-Google-Smtp-Source: AGHT+IFXYtIWlG9Hg6lYvjF543nMuCmfOfrftEZKgk7OREhHMKPxLqd61AVNp74OUw/5VgDSh/IqXg==
X-Received: by 2002:a17:903:32c2:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-221040cf36bmr7475655ad.50.1739562893886;
        Fri, 14 Feb 2025 11:54:53 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:6ff6:65ab:3cb0:990c])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220e0232190sm28832525ad.186.2025.02.14.11.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 11:54:53 -0800 (PST)
Date: Fri, 14 Feb 2025 11:54:52 -0800
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Tsai Sung-Fu <danielsftsai@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Chant <achant@google.com>, Sajid Dalvi <sdalvi@google.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
Message-ID: <Z6-fjJv3LXTir1Yj@google.com>
References: <20250115083215.2781310-1-danielsftsai@google.com>
 <20250127100740.fqvg2bflu4fpqbr5@thinkpad>
 <CAK7fddC6eivmD0-CbK5bbwCUGUKv2m9a75=iL3db=CRZy+A5sg@mail.gmail.com>
 <20250211075654.zxjownqe5guwzdlf@thinkpad>
 <CAK7fddDkQX1aj5ZyTjh1_Pk+XME3AY=m5ouEFRgmLuJjBJytbA@mail.gmail.com>
 <20250214071552.l4fufap6q5latcit@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214071552.l4fufap6q5latcit@thinkpad>

On Fri, Feb 14, 2025 at 12:45:52PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 11, 2025 at 04:23:53PM +0800, Tsai Sung-Fu wrote:
> > >Because you cannot set affinity for chained MSIs as these MSIs are muxed to
> > >another parent interrupt. Since the IRQ affinity is all about changing which CPU
> > >gets the IRQ, affinity setting is only possible for the MSI parent.
> > 
> > So if we can find the MSI parent by making use of chained
> > relationships (32 MSI vectors muxed to 1 parent),
> > is it possible that we can add that implementation back ?
> > We have another patch that would like to add the
> > dw_pci_msi_set_affinity feature.
> > Would it be a possible try from your perspective ?
> > 
> 
> This question was brought up plenty of times and the concern from the irqchip
> maintainer Marc was that if you change the affinity of the parent when the child
> MSI affinity changes, it tends to break the userspace ABI of the parent.
> 
> See below links:
> 
> https://lore.kernel.org/all/87mtg0i8m8.wl-maz@kernel.org/
> https://lore.kernel.org/all/874k0bf7f7.wl-maz@kernel.org/

It's hard to meaningfully talk about a patch that hasn't been posted
yet, but the implementation we have at least attempts to make *some*
kind of resolution to those ABI questions. For one, it rejects affinity
changes that are incompatible (by some definition) with affinities
requested by other virqs shared on the same parent line. It also updates
their effective affinities upon changes.

Those replies seem to over-focus on dynamic, user-space initiated
changes too. But how about for "managed-affinity" interrupts? Those are
requested by drivers internally to the kernel (a la
pci_alloc_irq_vectors_affinity()), and can't be changed by user space
afterward. It seems like there'd be room for supporting that, provided
we don't allow conflicting/non-overlapping configurations.

I do see that Marc sketched out a complex sysfs/hierarchy API in some of
his replies. I'm not sure that would provide too much value to the
managed-affinity cases we're interested in, but I get the appeal for
user-managed affinity.

Brian

