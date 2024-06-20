Return-Path: <linux-kernel+bounces-223679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5869116B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608A61C21EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B45214387F;
	Thu, 20 Jun 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nthJo7P/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C18663A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718925905; cv=none; b=fuhLdt9q9fGeEwleYAYZYeD5XrgR7PvpkqfX9rEFI0tt5weUfE1Ae6Bb3sPFSrvIV3MxJrBA1NjKhkxD+t0Jj8k1MOCPCngbLya+G/qw+kSY4ww+OjkDiP9ngI+3FxnH39LV+4+CJWKNM9hg1vqGWq6l4kGMRaH+yjHFgMyE9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718925905; c=relaxed/simple;
	bh=XpnCDdCtFgwhKYViq+paZ/4p0x6bnKXUvWUEofljj9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWQn5Uvl07AgL7JHmMztuAe+b2/DXd1y2C/TjzJyVRpRcqkt7Xm35+JFGT+AwEsb56Yb48XaZ2RsZ2GfuDqXeMjRbefNdeqPSZ5xSD+uoBXwosxcjgMoXga3dPcuGWiospFLuZ4NAZUmbZuiPBdl8fxh5Nfb3lJZHBmFUgkVqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nthJo7P/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9de13d6baso6744135ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718925904; x=1719530704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3SPHHE27gYahsWkwlMaZaH2ZmSYr9KZMF6ALpWQofo=;
        b=nthJo7P/wgF0jfynJf7ijefrEcjhDhTv0XbiDdA8FXJeW1maEzqooXUvTimDH6WLoG
         VS2j8vlXGreNauFr5JCsI4zzJ2EPxx4N9OZRPXYN7rM0bKS0yeXqIo/Cqkgirm8XctM2
         2kqgGr2F1JG/1zcUNg0XQV35dk/9g/E0OPIcwEm/GAuA9W2LalV28aDc9uN5350txgDe
         hDHM9SwflBQ8Jo9OocgFx3+hIXqVE9BJcNoSbNZVT4ZCwtQQL+GS8li9cG/TzgnGyCQi
         4M1bmraqTT/cjnfcSISnMNqWghktUPUKnAM37YIvb5FMULtfl6aBc5Yzqq5e0uUbSRDW
         MKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718925904; x=1719530704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3SPHHE27gYahsWkwlMaZaH2ZmSYr9KZMF6ALpWQofo=;
        b=F6DW7MoQMGFZrNTEGtctAaIMLll1FGAXE/6cgBtZreazmyCC9REj90KyX/3w/Z17cs
         nhxyZHwfGNVB8k6HLnHyQ+zXMftB/Hq5D0+z2zm6xrQh4x+aQ/If1NaC0dZ3DnCU+ZTS
         R3YcvJtz/lV6kZ0ckgtCZ0lSxlox7cV/u9sTRtytcsHLA2GEIBGHw43EzG4e+IWHifh/
         3o8BGm32IcsPQMmlrQbOn2ImZzehK+/B0jONMGZmNtfqbpoeIfcsi3QVV+20BmY2dJLB
         DHWYGmRB0mQAWrKrkGIFqcWx4uFbLcR0uqncXgqfzGPFzJcAgeG3eVBBvAc1fiCnEIF7
         /wMg==
X-Forwarded-Encrypted: i=1; AJvYcCXnRE9ld85gMgCneaeHNPaDNgJaexlm4n2JEC+30owqW2gmIvbwrFoTnk3mIBSduyddR5h1P3WL7nOmEuTaD4z/IATaRDDdU9j0xAbm
X-Gm-Message-State: AOJu0YxKj3rjbgHftGn8zGOFC1XA+DKhtxB//EAeMsAKiWlNwvA8F4t8
	GqHdGhaJKm00TmaorBB7YmGobRZixIU6szBMBTdOzMl1gRfxsCw9C0uJEcwtHQ==
X-Google-Smtp-Source: AGHT+IEzZ/EZAxsNNZtlJ7tILFRqDfO8mcw4qYmbN5kVCzF1Rb+x/lYh8a2Fo4yZHpTcSsSEoqwpqw==
X-Received: by 2002:a17:902:db0d:b0:1f9:d930:85d7 with SMTP id d9443c01a7336-1f9d9308697mr21606745ad.20.1718925903442;
        Thu, 20 Jun 2024 16:25:03 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3205f3sm1664945ad.76.2024.06.20.16.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 16:25:02 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:24:59 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when
 ATA ERR/DF are set
Message-ID: <ZnS6S1fukhGVWZY2@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-3-ipylypiv@google.com>
 <b87d51d8-5a89-480e-b229-7750c241aa6f@kernel.org>
 <ZnDfNLBwsG6zFJ4-@google.com>
 <ZnQqxTgSTDHCBDNJ@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnQqxTgSTDHCBDNJ@ryzen.lan>

On Thu, Jun 20, 2024 at 03:12:37PM +0200, Niklas Cassel wrote:
> On Tue, Jun 18, 2024 at 01:13:24AM +0000, Igor Pylypiv wrote:
> > 
> > Any failed ATA PASS-THROUGH command with CK_COND=1 has this issue. For example,
> > Sending READ SECTOR(S) EXT via ATA PASS-THROUGH with CK_COND=1 to an lba
> > that was previously corrupted by WRITE UNCORRECTABLE EXT is supposed to
> > return "READ ERROR - LBA MARKED BAD BY APPLICATION CLIENT" but instead it
> > returns generated "UNRECOVERED READ ERROR - AUTO REALLOCATE FAILED".
> 
> I assume that the drive generated correct sense data, but that
> ata_gen_passthru_sense() overwrites/overwrote the sense data with
> generated sense data based on taskfile registers?
>

Yes, that is correct.

Thanks,
Igor
 
> 
> Kind regards,
> Niklas

