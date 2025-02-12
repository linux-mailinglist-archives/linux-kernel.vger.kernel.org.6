Return-Path: <linux-kernel+bounces-510246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E79DA31A39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F843A050A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365C6136;
	Wed, 12 Feb 2025 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QraXSjfA"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4FA50
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319089; cv=none; b=rV7T1cUmHF9xtf1sw1HTzlkz3tF+DnQPlurLn3yy/b1gy9hEkAhpN5EUrCC9BbOEmewOdmOH47mvNGYa1uoi5dyI7g6T04C2JSnTd0qSAhCJyVJg+jhKgxSfsHPAG3y2rMdGoRBrNaxuDFqLKqS5S7omOzFbGlK8lAtA/D5eEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319089; c=relaxed/simple;
	bh=qfqWUaxj4M5XI8X8hWIn0j03pFGWYZcGVqGDzFiPUfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5GUrN8EgqIM0KI1Vb8cyah7iX5q2JlJlj+98Iy9D/An4WW1EPKqaTAJnOSAqxvxtLFZTg+m904wZuQwoPEi0KIUY0CJr8AS0R+bJwciOulatXB7pIpjCw/tUL2/DXioUgxQyZxlUxmd8N7h24VBLBSDPN5sHZdXIq5rVmDNNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QraXSjfA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c05f7d9ac0so317376585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739319085; x=1739923885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMkf5oPLsMJQj2JhE5y7/ZrwjQP1VsYL3M5+AWgX0gA=;
        b=QraXSjfAWVOjH1StPU4l8HRAErmPT+Gm0pdnhEDejP9/qaj8snwSnYirygR2Zgiof3
         +jARFhrlEBN5bR4WCflWGI61CUt545DDL5vIxPgVSj5h1/VpeAhKBuOjTsMo4cQQbgUb
         6Qh0kShh0thOnGSPZwxs118qXP5MyLad43OA5L9y/6++EyQT1nlJFnROiCxOQmFDm8kb
         M8slzsWrkyHwld+oMJ8kC9ucYNk1jDP/dYtWwfu8jQAWViUHKLvln2snUjRgO8kRT1vU
         n5w41P4hadn7l1NHptslSHIbxU20mHW+R8ICinJqiYuMZtuya4ymNxzElp3da+Hol7tY
         Gp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319085; x=1739923885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMkf5oPLsMJQj2JhE5y7/ZrwjQP1VsYL3M5+AWgX0gA=;
        b=pQp3YN9FmZYMw43t4p2uysQjKe3tOM4yY6fmy83DENIcQOtmhPd+wYQbJeZwgmnhpe
         U8f9WWc+KI67xZmg7t1kKi2cSWdfmD9TkUvuCFHtIX7ISPVrsaV0pk9JxSToOl+3G9Ca
         kJxyu+oNPT6Tc3c/phCWsX9KJeZQkq/GZXwjNqYCub0NI1V9Gw1CsMt4yPCvOnhL1ec/
         B8tKUkibiJiE/dJiMWdfqM/OCzIcCSRqS2412Ae+d/XSjbSTA3+1eenKjaxMZ4iCjWgk
         LZizE0tPndRYx/WTKUd2Yf2tVGFg5AI+yM86twaIeYBUc8eMWlSgFk4FAEszH7AFaMlO
         yYuA==
X-Forwarded-Encrypted: i=1; AJvYcCW77R0MrEUUxkOqx2Asm1eVVqwm1dmDq6+A9aTfmBYYHDrWFHSNJYjVNT8bTgGYdpIZeX+DoUQT4oRcL6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW0/JqkhUR6SKQuB7foqE2EmtdDEcAO0VaUoA6lC3LlCAkaL22
	pNc9DFG+xv8fG3ooIc4nfgWfblul+pZpo0dkcFQFn2yyd/Y1WYMLs2podpiv7c4=
X-Gm-Gg: ASbGncses4Q1yXTf8ewk8/Phpb+VNFVKlIzJPB1Vla30iK/0C3S+ajYN2ePruB/xrzo
	jYJtkhLP+NVUgNtoJCh+2iwVDS1MHiActh+J+gRedVvtjub4ovprM+81svQhHKyHEjbmdzPhOaT
	fbVE1XrJ/pKsPMV1qrgb8xppsJzZddHgBaAcDmno6j2ql4sXFoAIikFHjAkWRruh8+jdZtLef68
	lrVsLV3YTaZWd2tCRVkdE2LwlDLQeCdyMPPFwCYZfEier5vBPmkTxSCgTUAAE+unBXUcxU3aFsc
	0SHR5FQlD/hzpPBmQ0N7ii0DbyExACm1wbp7ITJuhdqGU6HHWzFy0e09q/+a2ZSDJcDZ/B61kQ=
	=
X-Google-Smtp-Source: AGHT+IEhQLIsJaG/fbU8sJBgBx+OFg8MFFCqDuN0KUnDhhirQwBhRT3I4eLnjVSHDoK5Bq2ymF340g==
X-Received: by 2002:a05:620a:6293:b0:7b6:d6e5:ac6e with SMTP id af79cd13be357-7c06fc57302mr210133485a.4.1739319084971;
        Tue, 11 Feb 2025 16:11:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c065424c9esm257293885a.43.2025.02.11.16.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:11:24 -0800 (PST)
Date: Tue, 11 Feb 2025 19:11:21 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 13/17] cxl/pci: Add trace logging for CXL PCIe Port
 RAS errors
Message-ID: <Z6vnKT1pXuON2WNg@gourry-fedora-PF4VCD3F>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-14-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-14-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:40PM -0600, Terry Bowman wrote:
> The CXL drivers use kernel trace functions for logging Endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
> the CXL Port Protocol Error handlers to invoke these new trace functions.
> 
> Examples of the output from these changes is below.
> 
> Correctable error:
> cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'
> 
> Uncorrectable error:
> cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

