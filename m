Return-Path: <linux-kernel+bounces-355790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC05995707
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21C1B21841
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884B213EFE;
	Tue,  8 Oct 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XiTIQy1k"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F10213EC0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412952; cv=none; b=sY/odRzuLx7BcIdq0+C8lrCIMHcBHzzvpAEN9vGDJRqdn1MnK12KXvnhOICkQ0U982d/T08pDxkF30y3DDQf7Kon+YNoIF5ipwuRhH1AzCKR/vcCiqeNRcp/HnVfgx7Zvvn44oco+N03XuzrONvdTRao77612l5JS1d3D808IKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412952; c=relaxed/simple;
	bh=sFOD81blpWZEYRBGKxcRiVOOkwKAQXTBls76Ie37LRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvL44cVK3nh5SRhceky8+yFYSs4MadSZdWPZlmGuavx50qwIbeNes+96y0dLoWZ1ccQR1e5RsTsjS38X/9h1JEkhkpS/QRqz+aTvpeACg1aj4GK1HwZM+tU3/h7JvcoNOKxGEbfQ3ozp1U4IA2S7+AebW1ivNQYk+iZIL0dURxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XiTIQy1k; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B790D40E01A5;
	Tue,  8 Oct 2024 18:42:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5ei-7OuD8Eyr; Tue,  8 Oct 2024 18:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728412941; bh=i+sQim/2Ft04C7Ea3Z9mF1Zqm34eBckmU0+nkoBqBSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XiTIQy1kZTJfLf7lfm0cVWoEG3BgbifYJxiy4B2ufHcISdwE7+Wj0FAmQtOhwhXF3
	 D2dIuCSDQRlF2sW3JObcaSnNRgUU1roukFw/RsuYfCbKGRWkk2cOaBBsJHjhTSQDML
	 5PT6YULU0rBYErKdiV9Y7Q0wWvkSr0F73wufge79u9nuC/faAouNyjz9Wsvj23iPvg
	 AaMnaM+isGPpQzjb2ivZ+p9VOGpFDFD6KJIgcpsNoU8Fy2QnSEFFgXoRKHDoXi684B
	 t1swyIgwCNpqypsmHzbCy/nObWErzF0mymytjnwQ5ufcDERdTjrM3amT4E/OE/IMPO
	 gz16xfvSvO7m6rH/4Hwm0q/RyfLd96IHklJcmcaCNt+nL3OXCfHX2ZG+9vM1ASkhUT
	 kKereWFbzPjcnLrRdwqKz5R9mVzPTdC02Vg2Zb3278IkvMtSisyEX8QRfLukPL9RtI
	 EvajyKs+PyznCexQrYc8PNt0Tf/bGaEHnHcERIe0RsjwvXYlAucPhKX833pQ3snbeP
	 FFC0BL4ograFIVSPcQvCR5lhmMuE0kxZtDZ8hIkVNC3T+uMRdmSUHYeGke/9ld7uTz
	 C7n2E93GHUCN+xjZhbOYGeDhoMIfEmVWe+RTvpPxle1jK2Z18Zyn2cAoUmbRDk+p9w
	 H79uvS1r6if4IPFfH/KJbcgw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3ACE640E021E;
	Tue,  8 Oct 2024 18:42:03 +0000 (UTC)
Date: Tue, 8 Oct 2024 20:41:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20241008184145.GGZwV86Y_BJEdADyCa@fat_crate.local>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
 <20240913083155.9783-2-ricardo.neri-calderon@linux.intel.com>
 <20241008155106.GMZwVU6gjw45z2gn8x@fat_crate.local>
 <20241008170015.GA24312@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008170015.GA24312@ranerica-svr.sc.intel.com>

On Tue, Oct 08, 2024 at 10:00:15AM -0700, Ricardo Neri wrote:
> IMHO, this patchset is needed in stable kernel because
> /sys/devices/system/cpu cpu0/cache would be broken on Meteor Lake and
> processors like it.

Is Meteor Lake and processors like it an already released product?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

