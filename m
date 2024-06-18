Return-Path: <linux-kernel+bounces-219470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE3390D301
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD29E282ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE02915F320;
	Tue, 18 Jun 2024 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AGGMfug3"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7913B792
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717491; cv=none; b=DrvPyWOSnIhvEwz1u8ugtaw0suGVE/VoCYgZM4sEY7UrGtoPUkTF9jGqIbxOJQ9Is1M1I3LE0tV9pnDZC3hBGQuLMVA0DYComzXYQnVVizrt+q+33k9/JG4b5AhPK4lhm6+AlInrB09neF/a0T1e6ypqF90ZSd18zIcHFJy3TOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717491; c=relaxed/simple;
	bh=wsfusqGXRwKjIoEivqEsEsONr7O24Rsc8Ki975XFcE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz2joQCMXzFLsu0InxLNYgLGQinauKiezriJd2Cn4CdDU1rAhWxTA2QQ2y2GMtaFy+fm4h2CtLEOPl6MYwzOkgQ/0LYYRlF43KZZSiENJcepXlxinypWYau83EcNkWLzBKWCOrYbS2T52CyqkVsTrfA5b3OhkHoJDseoY8KUq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AGGMfug3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7954f8b818fso356200985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718717489; x=1719322289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zxeD/weYzFfAE7AIrut1f14B+OgFZqypLF8nlCdzLh0=;
        b=AGGMfug374S6z6pVZKdBSjJ9P39a4Anb9qKBLCHsVuT0NXt2y7hGvW7BIFWWN++nCu
         7jvnNTXJ54gyTh1NoSf+OXofCNzvThH9995Le9aFEUZehL8p7w3qnRsvwf4Kncz84Sgj
         6dwrxGKh+ZKQbEpBfxjR6VA2DbI7STUoT462WhgBzltrk1KrDnddsW6FKJUAi1MEagkF
         BOaEQYG8yPySv90PvBNOquDiYgUU7bGNjOLrQN1u0rtMbYoGP3d08wV7mcchJWz6B/Lg
         sgAvRUYdqLnH15USm7DkVjZq3aVgK9ovb0WkB8v7J6VWA8QSXyEhaDvDuOWZJf5tya5j
         PF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717489; x=1719322289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxeD/weYzFfAE7AIrut1f14B+OgFZqypLF8nlCdzLh0=;
        b=W181Zv589mG2a/0QEdgVlC4HRrzk8MOh7P+7GsrG0C4Q7RKgXcQ5VK+powhOSTx83u
         1Gtdvux3AKwUiE05gIWT0AAYgROEtkJPgiGhWfsNPR3l7HkdXhFDoR1w55iQPCby6sKY
         6tMgP0V+0C2UrNA2dTP/o+m/7ipX48oV80X07JxBSED5m5BglHxHTTVdJwr5Cph3PnaF
         0Sxyc6BHx4wFdfdvbBAl4AvCL26ssfpQfJK0lfiuwCL/9THaEoxWNV/Vc+11M4iz/TFn
         pBd/BYCLd3DQZcqQ5tS/xb9WbQyJ/PNON8dkaExb2bF6k4HSrVPKvZUUdE9DglYW0Nw9
         nx0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzqdWpb2HEkS9+fSysdZ4Ea4LQ7Zd8dl4JfXiH7OkJOwkM2WIlepC//JC1IXfaPSsbbBDl7l1ZwjXd1S+NfKYzw1GbbIFSCi+RdhKr
X-Gm-Message-State: AOJu0YxkHcXaW6pDDhdn4B+MfVuh24NJoH0euEjLTWDyYSiLgKmqEkME
	2eGHbOHqo6Q7EugnY//xXvWDxszAWveod5fa99vHi7dS/+tGSBEb+wodPpFC0Lc=
X-Google-Smtp-Source: AGHT+IEs9n+MhMG27TFEqE4fA0oA04u7oEqN1xSdYw62o33s+eARYgUVYcJ5Gs18tHiwwZoqi9PyIg==
X-Received: by 2002:a05:620a:29d4:b0:795:6092:154c with SMTP id af79cd13be357-798d2588fe4mr1433106985a.62.1718717488760;
        Tue, 18 Jun 2024 06:31:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798ab4c16acsm516821385a.59.2024.06.18.06.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:31:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJYvn-00FB4h-Kt;
	Tue, 18 Jun 2024 10:31:27 -0300
Date: Tue, 18 Jun 2024 10:31:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, tjeznach@rivosinc.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	kevin.tian@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 04/10] iommu/riscv: add iotlb_sync_map operation
 support
Message-ID: <20240618133127.GF791043@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-5-zong.li@sifive.com>
 <a1a99374-dc40-4d57-9773-e660dc33beb2@linux.intel.com>
 <CANXhq0pQuoriKfHF51fXUtrZLkJBNOCe6M8Z6JbDjoRvbe1nWg@mail.gmail.com>
 <20240617143920.GD791043@ziepe.ca>
 <CANXhq0pXYoeiVMFSGAijo-QHTVoZyM8M_uU4HWsbCwDg2oFPYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0pXYoeiVMFSGAijo-QHTVoZyM8M_uU4HWsbCwDg2oFPYg@mail.gmail.com>

On Tue, Jun 18, 2024 at 11:01:48AM +0800, Zong Li wrote:
> On Mon, Jun 17, 2024 at 10:39 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Jun 17, 2024 at 09:43:35PM +0800, Zong Li wrote:
> >
> > > I added it for updating the MSI mapping when we change the irq
> > > affinity of a pass-through device to another vCPU. The RISC-V IOMMU
> > > spec allows MSI translation to go through the MSI flat table, MRIF, or
> > > the normal page table. In the case of the normal page table, the MSI
> > > mapping is created in the second-stage page table, mapping the GPA of
> > > the guest's supervisor interrupt file to the HPA of host's guest
> > > interrupt file. This MSI mapping needs to be updated when the HPA of
> > > host's guest interrupt file is changed.
> >
> > It sounds like more thought is needed for the MSI architecture, having
> > the host read the guest page table to mirror weird MSI stuff seems
> > kind of wrong..
> 
> Perhaps I should rephrase it. Host doesn't read the guest page table.
> In a RISC-V system, MSIs are directed to a specific privilege level of
> a specific hart, including a specific virtual hart. In a hart's IMSIC
> (Incoming MSI Controller), it contains some 'interrupt files' for
> these specific privilege level harts. For instance, if the target
> address of MSI is the address of the interrupt file which is for a
> specific supervisor level hart, then that hart's supervisor mode will
> receive this MSI. Furthermore, when a hart implements the hypervisor
> extension, its IMSIC will have interrupt files for virtual harts,
> called 'guest interrupt files'.
> We will create the MSI mapping in S2 page table at boot time firstly,
> the mapping would be GPA of the interrupt file for supervisor level
> (in guest view, it thinks it use a supervisor level interrupt file) to
> HPA of the 'guest interrupt file' (in host view, the device should
> actually use a guest interrupt file). When the vCPU is migrated to
> another physical hart, the 'guest interrupt files' should be switched
> to another physical hart's IMSIC's 'guest interrupt file', it means
> that the HPA of this MSI mapping in S2 page table needs to be updated.

I am vaugely aware of these details, but it is good to hear them again.

However, none of that really explains why this is messing with
invalidation logic..

If you need to replace MSI pages in the S2 atomicaly as you migrate
vCPUs then you need a proper replace operation for the io page table.

map is supposed to fail if there are already mappings at that address,
you can't use it to replace existing mappings with something else.

Jason

