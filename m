Return-Path: <linux-kernel+bounces-417378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA0C9D5336
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DFE281ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84161DD886;
	Thu, 21 Nov 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ncos1WVO"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21861DD880
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215272; cv=none; b=KQYJNKgnpBSiIIszQpnv2kNL0M/uRQBKbv7t8dCBstNM4a4mStRz6YJL3Psa/cDbCFPZVMp2zzfuRfN+uLbnsgURHRZJ5wbP8wr3HNr9czzFhh0gO4hV8KwRGHnzfOlEe/8+7a+dw+LNrVFGioh7o97+xdXYGQrWQSKo3vBd+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215272; c=relaxed/simple;
	bh=1YPCn9zJJS4aEfnFmVlYq1c5Rme4ftV6YZCy6UiFw5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBu13qNOZuOr+S2/hbf8h2rRudHkqEB036yEzz3SDp3Qc2inL+aYCnn+lF/KL9YD1C0iP+WOZnWKJ9RrnU3+qxHCJ68Yb2A4dx5qzHbcwvShN1L+491y71cJ+4WB2pCcJsgo1TaEJzHqujHCYYVDyw5GvtJOFMEvYM/v2dn/OzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ncos1WVO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-212008b0d6eso11113395ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732215270; x=1732820070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVo/3gvYEDND0rD37osncOuM3Oyc9/1OV2rDKG8dQow=;
        b=ncos1WVOInINio401qms1NaRBBUfuKo+o37RzI3J8S7HuvjUCUA1TQeBF8cZIVimRB
         ph3re5mFwmatJkIVCds/LLBzY3hz17HDSUK92Jt+ghcYH5OvJgS7sVANlIDsA3/AF+/Y
         Klkp1PAwuBjGRRx94b+DbEXP/mkrNuHeEtVtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215270; x=1732820070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVo/3gvYEDND0rD37osncOuM3Oyc9/1OV2rDKG8dQow=;
        b=XpjSdazJB965BnVQTECKHaxMuLK1Pw3DjcjiaX81v45duBW0uci/PVve7fq9Z1eDWq
         2upWdA+UR7s+HHX0IlnX/ggtWe4jc7zfhwt2Y4/7vCU2RdkJFvwsm0hMI2C5Pr+rYeJZ
         rFBaU+K9PpBIwHzhPRNGBGupUcu4h/V7mgAdzQa2GRh7fyRsyK5Sx/5tGkCG2ZT/cpBL
         nWIUObvr6pJzTzk+eAS0Y1jdGB5HIdQTCIbP2BSZ9XOAiXE0g/z3rsDLmMayMnENWmU0
         iSuOoAMoqxAo4+uobN2BI/ElfhkNXc6gwndJtbJqkc9B5AaZJIVPjQ9tthOrMuBiIcqg
         Mxbg==
X-Forwarded-Encrypted: i=1; AJvYcCW1byb6xGGZPN7JMqDkEKnmVgTT9CweJkuC7w4zXQObQ5s8aqCIQZulIZ5q8bB38ksDvcMJyaqqpkQQT7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRkZRx0kUBJdYwqYmTE9i8YrB9h317bYhyN4yzIgeB2xWECR/
	1wMwiJsbLI0/Ztj80woAfGzhJ4Tp5bsPDHikGFE/qSyjEXm7jki1Hltb5ooPFg==
X-Gm-Gg: ASbGnctXwCSxogKaKtb6RbDX3L1Pz328IgMbhzQz8Zlx8AGeq58Ug5gxkO7EaymVvZP
	hPhJqHVP9QP0Oc991h2Fs6FO8lyIex0UdQaPhXkkEUOYM8W8E48H5RersY16I46hfPSux9fgAkX
	GpY7UrmHxLFgdqgyb/KQZaxnz6LED52cYxx8xo4f+trslpw/UxRonUyXdnUKXextANG/bW2b3me
	TeuilKicjrjNXBbTQdKQpW8KR3lzqV3yRWEMyiO3eOM1eh5V0wOxwgPVk3vt4QDmLB4a4HvNlrl
	SDXdDLqVUhNJ
X-Google-Smtp-Source: AGHT+IFwDhiiYxF0PoEBXjjEhwecpiAmAyU2t8KXrUR/0ogHKZJ2FPPWiWfHYGwqBhlMKTMk4/OA6g==
X-Received: by 2002:a17:902:e88a:b0:20b:7ece:322c with SMTP id d9443c01a7336-2129f23b036mr2790085ad.29.1732215270160;
        Thu, 21 Nov 2024 10:54:30 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:6485:23c4:db3b:3c93])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2129dc12917sm1576015ad.185.2024.11.21.10.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 10:54:29 -0800 (PST)
Date: Thu, 21 Nov 2024 10:54:28 -0800
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <Zz-B5DSJx6z_FEQ4@google.com>
References: <20240828155217.jccpmcgvizqomj4x@thinkpad>
 <20240828210705.GA37859@bhelgaas>
 <20240829052244.6jekalgshzlbz5hp@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829052244.6jekalgshzlbz5hp@thinkpad>

Hi Manivannan,

On Thu, Aug 29, 2024 at 10:52:44AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Aug 28, 2024 at 04:07:05PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 28, 2024 at 09:22:17PM +0530, Manivannan Sadhasivam wrote:
> > > I can, but I do not want these cleanups/refactoring to delay merging
> > > the patch 4. Are you OK if I just send it standalone and work on the
> > > refactoring as a separate series?
> > 
> > You mean to send patch 4/4 standalone, and do the rest separately?
> > That sounds reasonable to me.
> 
> Ack, thanks.

Did this ever happen? I ask, because I'm also interested in supporting
D3hot for bridges on device tree systems, and it seems like there's
pretty clear agreement that pci_bridge_d3_possible() should not prevent
it.

If there isn't an updated posting and plan to merge yet, would you mind
if I submitted one myself, carrying links to your work for
back-reference?

Also, I had some questions on patch 4, as I think it places too much
restriction on how the DT should look. So I might tweak it a bit if I
send a new revision.

Brian

