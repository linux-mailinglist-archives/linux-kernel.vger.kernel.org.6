Return-Path: <linux-kernel+bounces-449240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5689F4C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053D01790F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45841F4730;
	Tue, 17 Dec 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvaPAVy4"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B61F1917
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441264; cv=none; b=hciYGd8II1gR4CrqadZe/vDhXP5Tv4WQPqYDvJcaSWPHw6kQQD9hJxoiYqxHmGh2U5FsuSNE+2la8YYJ6k1AwHgqL7QcSGDt1XCJ8g8nQ5rLXTT1QRcGOtPD4G+vCcKX71tgeNjTSFFURjdH97kPNRRgwoXyn1lQKVkwRIp8uXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441264; c=relaxed/simple;
	bh=ZRwEOgnrOBB+ZQKu8dQe/bgdimJsM43RIUjPzjawoV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj/xR/RIoQ65SV0YRZn+MgrtOjSjyoFXpcLtT8fiwCOKAy8AZZEB/1nxnWpDSvwc6VQ69rcWS+P00qWnDwksNJVGNWbny757O2VSnDhSj5Rp2pd++fBYSf9Kv++GANFbiqejHIS18AsuFI+sizRkgwfGoAmV7yED5DEgMofQDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvaPAVy4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso8835024a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734441261; x=1735046061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRwEOgnrOBB+ZQKu8dQe/bgdimJsM43RIUjPzjawoV0=;
        b=cvaPAVy4HTaoWedPRpVaGPV786gatNM+FQhmj4vDigIsJ2KOFJgsnDQ9yEC8Aabc21
         0lZSgUIu4Znut4+/PqNLK2ZfU6AKGHNWYjWzJ7bREQl4OZBA1hJRniyaN6V0xucolKSn
         mN1E2eRz+SS3ZV+b+rubVFuhYwXjaQ4dP1047l2Lo8NnbRIlZH/UTbhKoYkc2hLxO/Zk
         YM9JStuGBY8+qlZgu5SpExzAnBTkts/0QQ7h1XoNQMKySiGu4yr6tJHzhDNKb82190nB
         FoqaiKf4pTZqJlvquXTgcZfVeB9r1NBEP4ZN4bae5DGb9Sey5LtD5M0mPwQ1eQwQ/ug7
         fjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734441261; x=1735046061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRwEOgnrOBB+ZQKu8dQe/bgdimJsM43RIUjPzjawoV0=;
        b=GeatTKuPGPVFrw9PEbR6zmHlSyMSR8y/gJm5bd4DmKcWBveuA3hIdLBbhd6JUacsN3
         VrUMAlCo6z6YHYkLyr+8qMp1ryFe723llZthr+1uI+00vtkkS2ybRE0U+oo/VYZGTkY/
         ZhkDIZ4o52fDDtJN098wET7ESOGv/7mspfwiYq8cg7edBKBK1uH9YqTfEbJcYP91WE1H
         QZAdDj6Rph/VGkkMDjLax1isjF0DYcRjIExXCOu4mLsC5C2dTwIzzP2MfYX+KIZHgL7v
         E4qQf7CxVEtFo4bQpkJ/dYieBvbDhv+MxO2LpLL0rbU6Ab/yPFfKl2fMk7JLZgwviKeQ
         5Q5A==
X-Forwarded-Encrypted: i=1; AJvYcCUoMkNAP2UbEvcEpnG8Yn5R9upk4VvKHHxTIWPtQuHlaSfKyZXX3S25jVB4UXxFRlE7Nb8cCRh0DL4XbE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1tqrkIAhXkFlXt3+fi6SzJYZjxPVyWOrNsRYMLecg9yXiIHd
	8L8Yd5mei2xPulUzBSRyZoTjkbLsDUrBbCjhw3a5CEvrKJxcItA6H+i/yx+JZg==
X-Gm-Gg: ASbGnctY4bdrAkXJ/ik97WHpVXYM02QO60zRcH0mkw26b1nHtRiyuHuxEqSnPxApJZD
	v3b+huunDfn1/MgcVgExvo2enh5jCnzQKI0MJLJSK7DgeJIoDTewCb7hxLr+m51B8V/vi9IOJIW
	Sz7I/ou+FQ7NuxJ5WR5jRDr/Tu3hwQ1hx61gy8f6ZFFPeaps2VHtUotAoYqAmmVAVG2NJsD7OtI
	nuaTdRei11/dX5+mOZw/3RUW1m7b6F/Ufr+XKZ3vUUytqBW1gLsltNYahKTsJQJzk37hurglFXH
	4hJ6KFZOxoydc5Y=
X-Google-Smtp-Source: AGHT+IH5mltElk1JWkMMGj0bbNEjRXmDJL8qqfF7HW7DZRJ9qkEkQrLz3PI3FH4dCgH5rmzrjIPsIA==
X-Received: by 2002:a05:6402:3705:b0:5d2:7270:6124 with SMTP id 4fb4d7f45d1cf-5d63c3aac76mr14360142a12.23.1734441260795;
        Tue, 17 Dec 2024 05:14:20 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ad19ffsm4284077a12.24.2024.12.17.05.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:14:20 -0800 (PST)
Date: Tue, 17 Dec 2024 13:14:17 +0000
From: Quentin Perret <qperret@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/18] KVM: arm64: Introduce
 __pkvm_host_unshare_guest()
Message-ID: <Z2F5KboZewSDClKg@google.com>
References: <20241216175803.2716565-1-qperret@google.com>
 <20241216175803.2716565-12-qperret@google.com>
 <CA+EHjTxRt=XoCZbRLE1UjMg4bzgoLYD9Lh0nzmjvPZ2Q4xQOkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxRt=XoCZbRLE1UjMg4bzgoLYD9Lh0nzmjvPZ2Q4xQOkg@mail.gmail.com>

On Tuesday 17 Dec 2024 at 08:53:34 (+0000), Fuad Tabba wrote:
> nit: This parameter in this patch, and others, is sometimes hyp_vm, at
> others just vm. It would be nicer if it was always the same.

Argh, where specifically do you see inconsistencies? All changes to
mem_protect.c should use 'vm' consistently in this series now.

The code in hyp-main.c does use 'hyp_vm' consistently however, but
perhaps that is what you meant? I did that to follow the pattern of the
existing code that uses 'hyp_vcpu' in that file.

Thanks!
Quentin

