Return-Path: <linux-kernel+bounces-524190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9B2A3E048
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C15B1752FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A2E212B1F;
	Thu, 20 Feb 2025 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QK7z78W2"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57847212FAD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068154; cv=none; b=frV2h/GFyLfpTUZCxlUfVzG0d8Bf6KtNFhya6ov7V05QC24IgkeQjLuMRUhbX/C6uDywKcoayEcvWJ4+OMeO7qsUo2mRP4boOOHq676iRn32qkdGFVpukQ1yvuwfDfH2ZQvsdyqhtYX6+BeyJs1Gu+Q7EvkGi/zdQGcZSxD0xA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068154; c=relaxed/simple;
	bh=sefj6hxNE4DKzJ9Uo+g0WJ+GyLGTay+PVJVsLpQlNGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/6TsRNJLzDaQDZBpTVNbvMitvmKMKXE0RyKOPy6xHyYuGVMn849uadDPSCwUHZXGNQ+aIf3GGtXK6zFPwTAdHjsHZfCMyRuZwysAzekN+z3G0Y53e2AUh0l69wuQrPgb9k6+jjofiOIiCVTZ33OEq8p8GAknrMa2CUS9XhJW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QK7z78W2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22117c396baso172375ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740068151; x=1740672951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9z6CJ8GEmOUY+R90CcF3D8uqozLmZO9LjzSZXbDX8o=;
        b=QK7z78W2puJkm/e4WzNaLjgqCPZzGmRob1i3JzdKj9aAs7kILPT+75Ppo6D862n3MK
         VmWcg8XZM2vk7vCrYL9kXopU0Bswy/C2Lo4LIEzDQJ6R4ntwFQbDNzQgXhHWD4nKqt0d
         r6zBMYoR0FOmDuWiIR287BWwcADfhZ/QTmwa/6VCeYvqDdn0yRktRMg5itTYTbG7Z71e
         ARFwtCIPAk/l4No1VlYd4u2+S2W59mePHENm10ecvO3CoGtgsDW+b5dqsUHA4vFU/kjD
         XMHsZg+pKUEOJ4IoLjKiBBQyImvhRxG7x9yOxzi/JLcKmL+XXlbxWYrtgVYfuwbkyl9y
         VkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068151; x=1740672951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9z6CJ8GEmOUY+R90CcF3D8uqozLmZO9LjzSZXbDX8o=;
        b=ctr1nOItoZelWOA0LNgq44g2g/PfCSDXRhTFx2obR0U0nLn0WO10q/+UDxss1CPCLm
         N73sosFpWrSPfuNcY8S4ExitH9SKnysj2r5Qk43lMl7hXdwUs2k42L6PMR9nR349ZJlW
         VJkRvZwkzmZJdU1+WW2wK/8Dzo1n7jkVyoMP4GcODv2G1mkYx6CfbSeyw/nBdKQTYtit
         UfsGbzilborAKD8pUkIISNdBoGBfd5fhVCwMw2RbT1QI+CbKMb1zonlPXiXjXnrytgbn
         2SctA0FVOZmFp0MRkQHftWglgHplpnus9n8KlHcJbdElZ3TT2ufEJQLeEXIX4JYH4N1B
         wd7g==
X-Forwarded-Encrypted: i=1; AJvYcCWk9QYVK7DEWWNyGHJe2j7kkQmAa9m9tP7LFFpqErtQqM6Xz+bg5k8RXd8mqx/RAKfaWJROKJMV3EnKDnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0YY4F9RAIkLt16uRrw3h9PU+1M5B+WveukakmdZ05TPmpHJv
	yb6knew3dUBNiaTAqqYnpInq0C/SoXq948npFsLlBRpvd924j/Gsztm5SjnFxw==
X-Gm-Gg: ASbGncsjuyxNuwwE7HYs6FgjMmszeFB7ml9GLQ8OELeaA9LoZeTfnJ2hpGbJjhLipty
	ndXoSsjSvIQYfa2FhmoOCRinFUm3sjE9VvSth1WB1YDaSO68h5ZE5OBW0xd7byObKgeWAUd7+hG
	mzgrYaw1t6KB/QVD37LuyXX1InQ6vuWwef9nccPf+UVVzHK34uxFW6FBGvcnCxuEzP16JRj9gUY
	P34GLefiUhCFdarm83nETivwyezLTg33lTANmFsDiuBTblu2zZVZ6b8Fok+2Hk1O09NhRVrRGB7
	GQXk85cN7bSbHxnIf8DkFIgM8YHVwV8bZrJ1sE8xegfSwwFvJM7I
X-Google-Smtp-Source: AGHT+IEeeNO5YXG4GrTFzHJDa5KXpncdRPcsXRbYIZYGBm4w3MV78t3++PWrZwNmDnY5dth9MgRnnA==
X-Received: by 2002:a17:902:dacf:b0:21f:3e29:9cd4 with SMTP id d9443c01a7336-2218debe8bamr3119545ad.20.1740068151245;
        Thu, 20 Feb 2025 08:15:51 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc7e9325fesm8522382a91.46.2025.02.20.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:15:50 -0800 (PST)
Date: Thu, 20 Feb 2025 16:15:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z7dVLNLhP7VfZ-Ph@google.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
 <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z7TOq-gIGPY_ztW7@google.com>
 <Z7TXQ9EdyvHp/lmD@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7TXQ9EdyvHp/lmD@nvidia.com>

On Tue, Feb 18, 2025 at 10:53:55AM -0800, Nicolin Chen wrote:
> > > Is MEV available only in nested mode? Otherwise it perhaps makes
> > > sense to turn it on in all configurations in IOMMUFD paths...
> > 
> > I think the arm-smmu-v3's iommufd implementation only supports nested
> > which could be the reason.
> 
> I guess what Kevin says is that non-nested STE should set the MEV
> as well, e.g. BYPASS and ABORT, and perhaps stage-1-only case too
> where the attaching domain = UNMANAGED.
> 

Ohh okay, got it. Thanks!

Praan

