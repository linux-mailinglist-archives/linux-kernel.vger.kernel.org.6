Return-Path: <linux-kernel+bounces-230885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B77918351
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7441F22225
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265A118508A;
	Wed, 26 Jun 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jbSc3l8Y"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338A1849FB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409773; cv=none; b=jbc36406WNmCTL+eHX7bRbA8JFFyW+ABnoj0c6bPk95pasTIg6FkZoOpok3k6frXpZ13DiNtOHEKKUEhE7Wkq5AW7yJ5aoBcyUMtpnBdzf6OLZWNWq1/5Cl+pijoaQ3Ufy8NeuWpzepFXIeK6DmjfxiJ4STqwVFV4cHHnA+62MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409773; c=relaxed/simple;
	bh=meI7zQuYpjGQqkBcKVyQVMDLDC0Y16VJsozKBd6D9/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEIycsNi+KK8h4b38NHjb21AcCPF6eaRr+CiOcuaUZuaah3VDNLP7zmP8xQ8p7jbzbWoFBtQWxWAzcnhcurqkvkBsmm0z7PzuJqk9vz98WFyTkjiMLrf0eXuDHBLA3Qh1HekShUjrV1tEOLpsMgD090oBCVssJ4cXPMEwOrdzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jbSc3l8Y; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-80fbf874128so393529241.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719409770; x=1720014570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRB/eQv1O8vFo1RpEOFuZT1vlG0b1HHSUcdSwe1QW7c=;
        b=jbSc3l8Yc8d9gQCWES4054ewBuZKXKApixOtP6UBdzJsjLvWkYGSOR1UAhZREyeZ6a
         H3HpJbFJ+sNGYXTIZMxwNwaDRwVXW5liz2/Ck86NMM1sQRzHFKrBs7lKxDovsB4ofevA
         g6AYnSrT8XbfXOuEgJqBTyimky0xeiyTFi70yCfRl+BHftzVwHa/oNAcmecE1IkZjdIX
         L3fYzgWJslUX1/jzPuJmvyKT7W86oi4WRA1iSAfoKcYVvthj2XeAuyrw52pxyhVp8gIn
         GPIku48I33lkTvW1XjJNtJVW8VywRvZqdxBG1Qm28GpPz5W5tn79k2umGc7nCBABh9ya
         5UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409770; x=1720014570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRB/eQv1O8vFo1RpEOFuZT1vlG0b1HHSUcdSwe1QW7c=;
        b=KbgyPedI+O65GcwdRmOue/W0B7t9xfs2/G5EGioQJMrqqsDJl9y/DkfFuw4CPCwJih
         NHLW/Vha8nQx5f4aktmmxCaHiM1szr0CEW30FR+bFLm7Js6ya3gIB+VTFsxjLam8Liyf
         F7mvDvV0usWjtwReHkbLViW5v3XSeFknkLmXPeE2fjJd1UXRX4cIsQWn8/twy1culZYu
         lik2KzW9bQsNpRd5kmMub2G8QvZaEg8EE7PP33GlN8rv8c9eJ4+9oWiWFWI3AGyeizYC
         kwKdCNrThaT+QquKBD9kJquG6rmKLev4VMwmlX5LoQk6zBAT0JGssnVuX4iFZLPbQfh0
         v1CA==
X-Forwarded-Encrypted: i=1; AJvYcCWHVnWcaYZQvTuo1P/iXGyhDI2b033/Xg+U3V+JBHUCMwjm69n4j4dYgy/Gq+cWXz+Wda0MaSeoJH5r79qrwwGKiZHMx5dJwbunIf8q
X-Gm-Message-State: AOJu0YzfYlrM0EmCWfFttuGoa2GUEq0AL19KfcXYSD19eKOmOgfH3E7R
	IyaDbspVuPqC8rzUGvRNugzqPlsyFCzOlQ8sQt9YOar8xH25qDX1pCjtoYiAjjA=
X-Google-Smtp-Source: AGHT+IGq9IFhSGjEjZNPj70KKXqaMuS5Ln6LwVIpSv5QFs5d/tixqxxA/GlJAm8IFYicQuE0oioy3Q==
X-Received: by 2002:a67:f35a:0:b0:48c:4fcd:f718 with SMTP id ada2fe7eead31-48f52a9bf89mr8746008137.20.1719409770587;
        Wed, 26 Jun 2024 06:49:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444f6ab41dcsm19532971cf.78.2024.06.26.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:49:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sMT1d-00DE0t-DW;
	Wed, 26 Jun 2024 10:49:29 -0300
Date: Wed, 26 Jun 2024 10:49:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
Message-ID: <20240626134929.GW791043@ziepe.ca>
References: <20240606034019.42795-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E8767AB63378C81130528CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E8767AB63378C81130528CD62@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Jun 26, 2024 at 06:53:04AM +0000, Tian, Kevin wrote:

> btw in concept PRI will not be enabled/disabled when there are
> PASIDs of this device being actively attached. 

Please don't bake such an assumption in.

non-PRI paging domains can be attached to a PASID and should not
enable PRI.

PRI is enabled when the first PRI domain is attached to a RID/PASID
and disabled when the last PRI domain is detached.

Jason

