Return-Path: <linux-kernel+bounces-570023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EAFA6AAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0283B967E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCBF1E3DD3;
	Thu, 20 Mar 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="fVQf7CPM"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CAA1EB195
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487715; cv=none; b=hhirI5i1wcdqe8G6UM+khR4l3EI1ZLu+iHDN42lj/MzL7HNesKfjIa5BdfP9Dk65XBlaTCkEFyXmhvhif1xjr12l3GAR9eaevfGkSgC6De8pBEwoP1LoPu7uej8dbFHyri5iihYz/3Q20ORRhV0g/NddyfB1SlZrOR+IYQoo+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487715; c=relaxed/simple;
	bh=aJWehN9LGNpVj94w01hh2MmsarJakM853udqiTvZ7w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvVoRrGN7ZMjA1T4attuYionxGmxcf3Qj5NLNIPO6BuUD1p63BsbGxxy3rkoOiJbM4cW1j0vr0Fc4zYmqlgPaM2tbiPAlhJkmexqfjygrOKIqTIDX/K2UYnp3f5MzX0fOdOurQBgaaqIkRiL7OJIRYrQrcDZ36g9NJLt9cTMry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=fVQf7CPM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso67161266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742487712; x=1743092512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WsSHdLKubVh1IMGmcvj7Aq0XahJ/1yi7vqSiFBPiWOE=;
        b=fVQf7CPMjcpaCyMuZWocaPvXyfPSpH1JClDQAEZasd7/cd4LzyI0ALxPckvrPJJ1lD
         qrZxEHH2z9F/tT1kELMw5HvuPP6DrFhkImJaSzcunFAfaKHBrML8g6jRvG/momj7L4ZU
         +VRiPJ2oTENRngcd8myJgB4UuEAXLG5UOiqu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487712; x=1743092512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsSHdLKubVh1IMGmcvj7Aq0XahJ/1yi7vqSiFBPiWOE=;
        b=OKfcC3iGRc5gGZKcH7eET5Y8cvahc/zp4SIWC/KJlwSoJjGwMVbVExiudKE3hdccSm
         D0LBkqdi5AQnlWQJYE2FwBT/3vMcxfFz4SY54VdDL4nY1lMqiSJq3iy8PytaFujHb+p0
         PVRcvktlsLsJjwfXpwk+sNlcblqlcZxOyAudDh3Mspw87jgiHYK2jlyPO7wgg8Ty7HX/
         U6B4U+4fCXvfsS2mUkF357XssMEwQXyvAandcmyOH8++7FyxCFmoeOR9Pl8KR9BAmdaU
         KlvafF149yzlJ6BN12OYosAonSbX8FR70jMjtQIocRPNbkwziWKG/CpRuLknJfZW5Mcg
         xupw==
X-Forwarded-Encrypted: i=1; AJvYcCWFOtoGgsz7BsROfeTvwFHgyaPxV/rEchqSKyP0zLIM8qX6f3CVKiFXb5Ng1VujQOCADuXCoBWRiTX3Th4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+safk6X7g5Gqq4/EGuzrznIdxVqSa//2czK4Axhclfb7n3IL
	DHg7kxSAPkfE8rNE7y9gu2CGgyx09BHzfe2QjqgFJZBgl6y1JWOCloruhGCfE0g=
X-Gm-Gg: ASbGnct8QCp37ZKRQb4UFuT0TiyD8nuSAbMBz72A5alODuf04rFZcwD9hbO3MJvO88X
	qv7cvlpnuXn4frrgNz+hLSegfg7IWqz4n07Wu98J6yG6x1cCLXQ4rD2EJ8MuQKCJBHL9JMnwcln
	aehXRQzAkqjpKxMQi//NicQMTEYc59K0B1TRrIh/A11KyogfrWSDD/9K7AXg5MWAJqrHC6DTrUb
	T+uvUNM1pWzMIiYtPv4jkpIf4jYWkcHa47eqUqOJMY43UWoGyu6KSoVovhYlfRTDw7oiXPAobhD
	smghMDyq4woX40y9b+V20ij/NpdoLshcfyHAhXq0hEE0swLNLbsV/0w=
X-Google-Smtp-Source: AGHT+IGWh2pEgle/irg0C/CUM00/xQIommVW2MZdhgOZpOyebwdp0vHY/RtGkExib7V2R/tNv0BCZw==
X-Received: by 2002:a17:907:86ac:b0:ac2:8faa:e037 with SMTP id a640c23a62f3a-ac3b8068789mr753209266b.57.1742487711611;
        Thu, 20 Mar 2025 09:21:51 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac3efd5e92fsm5223566b.174.2025.03.20.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:21:51 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:21:50 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 0/3] xen: Fix usage of devices behind a VMD bridge
Message-ID: <Z9xAnusUbAiAHT7s@macbook.local>
References: <20250219092059.90850-1-roger.pau@citrix.com>
 <Z8lhR2DSsB8P6L96@macbook.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8lhR2DSsB8P6L96@macbook.local>

Ping x2?

Thanks, Roger.

On Thu, Mar 06, 2025 at 09:48:07AM +0100, Roger Pau Monné wrote:
> Hello,
> 
> I've attempted to ping Nirmal directly on the VMD patch, but got no
> reply so far.
> 
> First version of this series was posted on 10/01, yet there hasn't
> been any feedback from Nirmal.  Would it be possible to merge this
> without Nirmal Ack due to timeout?
> 
> It's not even a new feature, just a bugfix that allows running with
> VMD devices when using Xen.
> 
> Thanks, Roger.
> 
> On Wed, Feb 19, 2025 at 10:20:54AM +0100, Roger Pau Monne wrote:
> > Hello,
> > 
> > The following series should fix the usage of devices behind a VMD bridge
> > when running Linux as a Xen PV hardware domain (dom0).  I've only been
> > able to test PV. I think PVH should also work but I don't have hardware
> > capable of testing it right now.
> > 
> > I don't expect the first two patches to be problematic, the last patch
> > is likely to be more controversial.  I've tested it internally and
> > didn't see any issues, but my testing of PV mode is mostly limited to
> > dom0.
> > 
> > Thanks, Roger.
> > 
> > Roger Pau Monne (3):
> >   xen/pci: Do not register devices with segments >= 0x10000
> >   PCI: vmd: Disable MSI remapping bypass under Xen
> >   PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag
> > 
> >  arch/x86/pci/xen.c           |  8 ++------
> >  drivers/pci/controller/vmd.c | 20 +++++++++++++++++++
> >  drivers/pci/msi/msi.c        | 37 ++++++++++++++++++++----------------
> >  drivers/xen/pci.c            | 32 +++++++++++++++++++++++++++++++
> >  include/linux/msi.h          |  3 ++-
> >  kernel/irq/msi.c             |  2 +-
> >  6 files changed, 78 insertions(+), 24 deletions(-)
> > 
> > -- 
> > 2.46.0
> > 

