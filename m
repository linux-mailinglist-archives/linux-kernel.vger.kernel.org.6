Return-Path: <linux-kernel+bounces-398577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51D9BF30E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F20282596
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B2204929;
	Wed,  6 Nov 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DkohO5bJ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CE2038A1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909861; cv=none; b=eq7k+0EkkHNMwXFDNrPScrm4axkoFtdwZC7GljOQTkKFt+g8+lCc9DHwqW6WUPBCxebEqk8hyKFjR34R/2ItnqGHvU5mSVQYgCpfK7y0UEdbSv6IkX4EQ2Z8qTynCesdKztRkHSWgPD9ZrcInuobCk66kbu/JiZWZx1ZRa9ubQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909861; c=relaxed/simple;
	bh=fedLJeFnx53tF8ytv9N7sw3rQkKfQ5/ZXz2jxAZZFQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SNMMOo/Q8AVu+RtkjzOWR58+giNyPMzJYYAzzqlUqv97FiK8cDYW9R+0Q3yAiVgaQ2r3Lz4Ukf4bkoU2LH9mQsXXWCqI8dZ1ARhZLlRmUL7K0BmQHjfhYfQetsMj6954Ndsv+rRJBmmlSHgZmWrPZCZDgoLJHRDgctkuUbm8Tn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DkohO5bJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e55c9d23cso11740b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 08:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730909859; x=1731514659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7gX7J5OfXehl+QPtww/mhm3dQ9/mVzO2E9r70KgS5Q=;
        b=DkohO5bJqXwWzFac5zoUiJ5rhZvfi9P9GYhc5ewv0BEa8pmOsTlugS0+kT/mNvw5J6
         U/ZDPZW7pRXgXroRXimlCADokrUoLACSO7Q5RDumcWy+Xy9Gk0TSaP/bc2n3NdmGvqjj
         3pHEnulgbiGoEuZUsCcgNZdmKZKQaMezXWVm+GqkVQ6sbx3rxBG8k21SU9GksRtfXoho
         K2byjFta4/p4YA/3KgvkDpx5NOUaQMixEvya6SbQQQlOBfZhbvRflHFCMnkWJ1hczucE
         iOk/0y5EPFZ48WZXH4vjoUeCQBjdM4bU4E+SQCR6K17kh70Crt4PG4MvMYihRqj41Hqb
         ejeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909859; x=1731514659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7gX7J5OfXehl+QPtww/mhm3dQ9/mVzO2E9r70KgS5Q=;
        b=d1fTml6wlIqp4ZX5/knWin5KxN1i/v9tYLv5HQ3dKwPM04fnisFOkYBQfOjbw7NkKX
         Au5SCJ7v6hQqnY/I4xCp+GuoiCDWksCCc+rejJHEKNzXcjeNh+Kf0g5MX2tiGz9TXz9d
         13nhbmc9qRPEekoxIG2hhNNS+kXycbwWB/8BtHBbLIUW9SK98jAaP+28RyH7kf98L14N
         k5ltBFZW88nUe8GPeF1KcJU0dDld6l/5bhjhw1217LrQ6IWijYySxMvlJBUJ6p9XBVEE
         GbAgNpiTxiNq8RoYaTDwL1HpAuiedzMZnPBc60MWmnYPKa2XY4z1fTiV962PGMgn8xN8
         TMFA==
X-Forwarded-Encrypted: i=1; AJvYcCUwNHkeElxIOpiZIqtSOzlJM5sNur63Q5jfgQmQJF1yj+COTxwFHubPncQbpd3lNSIUIXVo75dy3tqdvKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+xj1IKu4mTBGcXWceBF7lHpyFyZrbnEwKm8zUI/HvLwsnkpx
	8Z3i/IVg8+t0bmdgyFDVfv8JAFLBSj5Mnly82GRpak8bsyGqub2fx3E1p8+OWYKJ5B4Nc0GMqqr
	h7g==
X-Google-Smtp-Source: AGHT+IH5+RHugGjNIyOCE03q8z+Pnhir0c96MdXDK12iPCjoXlkZZlPPOs48lMhm932hF8zhCzkzRWOqcX0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6514:b0:71e:6a72:e9d with SMTP id
 d2e1a72fcca58-723f79ca4a4mr64927b3a.3.1730909859150; Wed, 06 Nov 2024
 08:17:39 -0800 (PST)
Date: Wed, 6 Nov 2024 08:17:38 -0800
In-Reply-To: <20241106161323.GGZyuVo2Vwg8CCIpxR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZyltcHfyCiIXTsHu@google.com> <20241105123416.GBZyoQyAoUmZi9eMkk@fat_crate.local>
 <ZypfjFjk5XVL-Grv@google.com> <20241105185622.GEZypqVul2vRh6yDys@fat_crate.local>
 <ZypvePo2M0ZvC4RF@google.com> <20241105192436.GFZypw9DqdNIObaWn5@fat_crate.local>
 <ZyuJQlZqLS6K8zN2@google.com> <20241106152914.GFZyuLSvhKDCRWOeHa@fat_crate.local>
 <ZyuMsz5p26h_XbRR@google.com> <20241106161323.GGZyuVo2Vwg8CCIpxR@fat_crate.local>
Message-ID: <ZyuWoiUf2ghGvj7s@google.com>
Subject: Re: [PATCH] x86/bugs: Adjust SRSO mitigation to new features
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, kvm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 06, 2024, Borislav Petkov wrote:
> On Wed, Nov 06, 2024 at 07:35:15AM -0800, Sean Christopherson wrote:
> > You didn't though.  The original mail Cc'd kvm@, but neither Paolo nor I.
> 
> I think we established that tho - I didn't know that kvm@ doesn't CC you guys.

I do subscribe to kvm@, but it's a mailing list, not at alias like x86@.  AFAIK,
x86@ is unique in that regard.  In other words, I don't see a need to document
the kvm@ behavior, because that's the behavior for every L: entry in MAINTAINERS
except the few "L:	x86@kernel.org" cases.

