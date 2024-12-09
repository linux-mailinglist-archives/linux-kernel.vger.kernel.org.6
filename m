Return-Path: <linux-kernel+bounces-437733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64C9E97CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B518282F7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5DE1A23A5;
	Mon,  9 Dec 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EW3FOZCY"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BFD35957
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752282; cv=none; b=rVN6F2gGFvcdx73JhvfoVQM4bs2eTDsBK0LuTnGePx5u1SAb8rIkRWMfgkB8NDdnOjdgTQf+mV3oUS2yK3rpy2RhIs0B5WBd3PHqiEzETG81nUUUd47tfOklz5OWPSA6JuN497NaBluStUqGA0zr1uB+G3sSh1uvE8Gh/FaUOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752282; c=relaxed/simple;
	bh=G+NgakMEDsw39gt5RazNkQV4/6Me2lGpcV505Fl98PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joVQARsVrc7QF4OJwaKiXvwY9C2wBNQo8YStPg/5NxjTjqphAPt4RhY17RNwGu4zkZfqrQamJaXuDV88aXezHGJ6Sj9DuF1UyYyVP6sZqsLEWEvl9RIk1mD3PqboMFR7/TyP3JEeMt0Xl0YuB6/EqW37dqBQLEO7ZeiiL/WKAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EW3FOZCY; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b678da9310so375335185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733752280; x=1734357080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7oEv/kWOQJwYOJS1T6x11V4qC7qnoI5kWJVO2djWrI=;
        b=EW3FOZCYN/soW1gKj051PgDzyH6oX+VDiKbqtFCNOCPD1SbJWofLIxyKp3z1e6Eg8N
         P4o7ChDgh6et5q3M+h0NcfRlPMz1YkBYTSV/aN5OhXev5xW3juMojoqaHFVJZGlN8LQK
         guIXmH+ksq5IWIfyJqFPAMsZilrSA97tqKuBWsh31JUlMVrOo9p5/NCzQVjqRsz2FIhy
         CNAvaBjQ2z0+lVL+T+wiOcyrFPmxDgfMNXs9Z1MZNxiBx4vnq37XIbCa02xySCe9I1/6
         1gNSO63Xlg/YGxgKBP9M9s3j4FDyHdERhtDv9L6i4yMIZZmLUbuRtTOItiXAfJpFcx83
         9zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752280; x=1734357080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7oEv/kWOQJwYOJS1T6x11V4qC7qnoI5kWJVO2djWrI=;
        b=D5vZSYhxl1aA05F3syaJQtGbeSaNyCFSuGvmDqB+CRKD3FOUk2HD2xKZQY3PyKMptm
         o4B0XN4rQIfsbfc+8+vj7TitY0ai6XqqjQG4JivQduglKTVHmOiX7YQebzHuMMQP8+kD
         j5Wvj1skCpFd+sjOSiAX+TjrJTC/q8H7q8zsSTOTanA8uTVig9BamJY+fcod3lL08G7m
         dvhuC1dGYH/Jd0OHzHDRQ3MLPH7wgGlEZ22blqvqtuYbGDMPGL1dyxpNouODPSG/6YAp
         KZyaCQdhjL2Pb36NceFEC0bF0M24SihAL3+aanlxUaj2gyRCiG6J1HbfBvfnCqs91bzE
         4Mqg==
X-Forwarded-Encrypted: i=1; AJvYcCUpWBKkP0jyKaW17eO+FN0JAtsCS2KxIQwhY3tC1FRATPexPXXVJM3WCkn1Z+io8QkiwnM3Oda6dx0uPIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBPioffdhbQurtpTiGH+p+1m8FhhUfZeAbYagPq5zNXX2//rB
	cc4brXMAg4RJdTY9C+w96CZgNBGeJKzsM/14eWyeXIkLg9eU+qdGBfKsy7+D0fM=
X-Gm-Gg: ASbGnctfIGAeYBuJ5k1ul0BbyZ2VeIR/S19XF7EaRyjFE6rF+1IiVArbIG31PhYVBEE
	ziy0+HGavPdgkjhc1kjdBHwquTFph4frPaMHywcVk6C9TEmM7l3gesFdqHsL9C/xundt8iK8RCt
	rq2PWwZSbkf2wgm9TpMdNW+zKKF4w63WPazQ7FUU/ohGfvaBhLPmzIR5TPBfJ/gkatJIbLZQlF9
	E9fspbZ1DJlt3lhQEvLaAkN3xatkCDNEHSHYD9AiANubt9IW3bgzs5KFdLRapaEK1JFhRKfT6Vd
	pG8naQgCx0ntD4IaPypEyPI=
X-Google-Smtp-Source: AGHT+IGRyqXoR5cNxX5xvO4n15YRROPv7PJXVPH2i6fLRL31UgLra1GXmWLsON0vFVsKduu7O03lrw==
X-Received: by 2002:a05:620a:2994:b0:7b6:d383:3cca with SMTP id af79cd13be357-7b6dce79d7dmr60890585a.35.1733752279943;
        Mon, 09 Dec 2024 05:51:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6dd1b6cd6sm5754785a.64.2024.12.09.05.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:51:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tKeAR-00000009s0Q-07tC;
	Mon, 09 Dec 2024 09:51:19 -0400
Date: Mon, 9 Dec 2024 09:51:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Longfang Liu <liulongfang@huawei.com>
Cc: alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jonathan.cameron@huawei.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH 5/5] hisi_acc_vfio_pci: bugfix live migration function
 without VF device driver
Message-ID: <20241209135119.GB1888283@ziepe.ca>
References: <20241206093312.57588-1-liulongfang@huawei.com>
 <20241206093312.57588-6-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206093312.57588-6-liulongfang@huawei.com>

On Fri, Dec 06, 2024 at 05:33:12PM +0800, Longfang Liu wrote:
> If the driver of the VF device is not loaded in the Guest OS,
> then perform device data migration. The migrated data address will
> be NULL.
> The live migration recovery operation on the destination side will
> access a null address value, which will cause access errors.
> 
> Therefore, live migration of VMs without added VF device drivers
> does not require device data migration.
> In addition, when the queue address data obtained by the destination
> is empty, device queue recovery processing will not be performed.

This seems very strange, why can't you migrate over the null DMA addr?
Shouldn't this be fixed on the receiving side?

Jason

