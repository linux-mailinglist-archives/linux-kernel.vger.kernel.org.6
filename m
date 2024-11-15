Return-Path: <linux-kernel+bounces-411032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55929CF2FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D975CB6285D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854C1D9359;
	Fri, 15 Nov 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j/7OySEz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC82B1D90B3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689025; cv=none; b=F8mo1AwaWBgZ/lgfJefA6Tb30eD95k5FLnB8A78/EQUO+Vg7yQAwpHsUjRzZhWwJkNHNSd36wSWqNfJPTDwIk4FACBNAJ25R7sesBuUbu0f0WyZIHi5xocHGPqdbiaLeAwUpdAO2csGodhFGc0NFOWshkr0Kwe0mq+vNDKcE1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689025; c=relaxed/simple;
	bh=sQz+81vx5ETPjv1MwyOSg6OQ6+aoLFGzGZ/rREzpu0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nff8+PuUHZpWElZhGKDDXHzHqee8xwCVWzSSWRSQXLZjRJu6GIxYNl6UVx3JfFBUMXsECy+98qWwAhz7Jp3V8cRmcGSdEDqQaDa2KBlvtPrk0kCUWpjA3yY16ZU57Q7J9BagtV8NZ5/afB+tRa3p4DeuOJ9kphG2q3wNKCJYvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j/7OySEz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7409540E0276;
	Fri, 15 Nov 2024 16:43:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 74qbOv9gDWFA; Fri, 15 Nov 2024 16:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731689007; bh=qPPNxiB/Np8It39mkTxXil03jNVr2VA4fqVIKnxsOyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/7OySEz2D/1ouZToqOROa508YGYU3YvRW+QGST9yDkNHSD7jkaRgfIDARJdHA4p2
	 6WGkmyE8nZjyi6kzzb+2CjFQsWfr1XBaL117kcvJ25wrO2/fAI0E/yATdB+Feak+P4
	 uGywafrwAQbASrtNHiD17R3Q+cP3j2iYqz7oYcZ/Pseqh0K0VFCmvRmmsUbEodjDgP
	 6fvVLhINfzWiTeK8y0l0F63PUXxeHVdSTN+PF2+99BDNVPwIwpV1QbYy4oQZNLCmXO
	 tQAhsUU1Sip7WprJTs8cSb7paueFWg8dCcny++JEwCNQFAPSroYfkIT8vmuvd8Ci9A
	 QxVCEiXgdnZjD+3Th5OKrhv/XiV+RboCODkUZQxEDNoNKu97V8kU0lDMN050YDSJPn
	 mttG3jr2GgOvXkDYIVs/6lT0ex1EAhgJRpZ+HVLABH4pAyH+NHc2TzKnAQokcHWpjz
	 q9+bEHfxerJEx3K+kKKNmyLcovTr4HIGDlvRIdb8ppylGMjTwxTh8c5feouJm+M+0x
	 cSnVtZMJqHzMXDVZ4NzRvdtNxEzaG81wYNUMEQjPKyq5iQKF+r4IR8tdCkcXuHwZ3Y
	 FtNceG5YPKIxg+pynTAepCQeB667NWx21nmvAR2E1JQIu38ioMaD12MODIcXfLg+2T
	 Ko+M2vEL/eWivzXv/yVndPB0=
Received: from zn.tnic (p200300ea9736a1b1329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a1b1:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB95C40E0263;
	Fri, 15 Nov 2024 16:43:24 +0000 (UTC)
Date: Fri, 15 Nov 2024 17:43:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/microcode/AMD: Make __verify_patch_size() return
 bool
Message-ID: <20241115164315.GAZzd6I2nyRR5h7D-v@fat_crate.local>
References: <20241018155151.702350-1-nik.borisov@suse.com>
 <20241018155151.702350-3-nik.borisov@suse.com>
 <20241114125818.GFZzXz6vdhwPdSa4dk@fat_crate.local>
 <d5708abe-40ed-4885-919c-b491f61cceb7@suse.com>
 <20241114140154.GFZzYC0ifEztvQ49-P@fat_crate.local>
 <3fd8368f-fb21-452c-b9da-5382fcf4f657@suse.com>
 <20241114142652.GGZzYIrHJUVoE18vp4@fat_crate.local>
 <3cc87528-e7a9-4dc0-800b-bb8f0cf279cd@suse.com>
 <20241114154704.GHZzYbeDmCV9u1fdVJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114154704.GHZzYbeDmCV9u1fdVJ@fat_crate.local>

On Thu, Nov 14, 2024 at 04:47:04PM +0100, Borislav Petkov wrote:
> On Thu, Nov 14, 2024 at 04:40:50PM +0200, Nikolay Borisov wrote:
> > Right, the important bit here is that max_size is not really max_size but,
> 
> I take that back and this really is max_size. I went back and looked. These
> are the patches for the older families:
> 
> Patch 00: type 1, size:  960
> Patch 01: type 1, size:  960
> Patch 02: type 1, size:  960
> Patch 03: type 1, size:  960
> Patch 04: type 1, size:  960
> Patch 05: type 1, size:  960
> Patch 06: type 1, size:  960
> Patch 07: type 1, size:  960
> Patch 08: type 1, size:  512
> Patch 09: type 1, size:  960
> Patch 10: type 1, size: 1568
> Patch 11: type 1, size: 1568
> 
> Lemme go and look in detail again, just to be sure.

IOW the below. Which is basically equivalent to what we have now but converted
to return bool. Oh well.

static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
{
        u8 family = x86_family(bsp_cpuid_1_eax);
        u32 max_size;

        if (family >= 0x15)
                goto ret;

#define F1XH_MPB_MAX_SIZE 2048
#define F14H_MPB_MAX_SIZE 1824

        switch (family) {
        case 0x10 ... 0x12:
                max_size = F1XH_MPB_MAX_SIZE;
                break;
        case 0x14:
                max_size = F14H_MPB_MAX_SIZE;
                break;
        default:
                WARN(1, "%s: WTF family: 0x%x\n", __func__, family);
                return false;
        }

        if (sh_psize > max_size)
                return false;

ret:
        /* Working with the whole buffer so < is ok. */
        return sh_psize <= buf_size;
}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

