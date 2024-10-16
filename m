Return-Path: <linux-kernel+bounces-368859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852AA9A15C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6C52838B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC211D1738;
	Wed, 16 Oct 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="EnDFd4EK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8CA1D358B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729117171; cv=none; b=k61sA+z1Yx1vEGuDrLOyTcpFygVMR0uR7LcMfVoRKT9vdFL/vWnj+htG90SYZU2JVkDTYfk+VTKhD1kLRISoGPFA420GCT5GnEpsAANu9HBQ6DA6PKnAOsapWuoe3PpMeOpwEztDckzHnubudLD1KYyfNjlcwFX2YnbdjM3VzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729117171; c=relaxed/simple;
	bh=xFsZfQgPqpPnJ/Pzpb9A4cJ/EMFic38MFodPeDhr4kU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FLBNxddYqmTYvyeIfzHl1hpLkqKElM1qfnM42meik17kT6YjuQZFOVeEjn93mwby30AmPFyZUOAqrqP7bYEE1KXNP03yxqNl3vRCbh1u8Th4HOGsbtdkkV85y7XrhqDb8gLRNoM/J+W7xO11ivgWiqcQ1692qKie457ubKVkVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=EnDFd4EK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314f38d274so4226555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1729117168; x=1729721968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FOYJbfAX5sNBn8mhiNMzoxzPiKptRKCBwcsvt1ERVkA=;
        b=EnDFd4EKLTND7khrUQVY0yr0GYDmHrCQpmCpNA4f8GAoexi5ryEe2gENB5iB8z2ceB
         hc5Pz8AaLNyQn4oEO32VRFXvDbnyOkAjt5KLrqqTHt7khMTcXgV7iS1ov2avjGKCPqTu
         S+iiPyt1Dq1IaX9bfEEgs6GrreZr4mC2BMnrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729117168; x=1729721968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOYJbfAX5sNBn8mhiNMzoxzPiKptRKCBwcsvt1ERVkA=;
        b=p027V+3bLiYc4n6BjyQErc73LYoIEPkMzkMyggOQDCZxeEfff2Esur/Bv7VXuZJxx1
         NAb6TuGKS3Y+hA+DORLaekJn23paPYfIrEiTL/OHWnruz0VPqZl1kb2Xn6beEWls3yE+
         /gH6M4AQahZpAEpAa141JEBCR7PqQzvM5SPw7yyCkmEZR/oJoYsOjEbIsvlhw/k64ori
         c/fyI+1XXFcJOEqm3TOYujsgDLBvex1nuRdLCO8LsDce8Sv1RdBdK3M9SFErUaJSOWpv
         VMqMkUBNW/v0HPYE/xzK9OR8V2SF8klypaq3FgdS+GHfqyJPpkzKAoapKxr+BZTLsp+A
         5vKA==
X-Forwarded-Encrypted: i=1; AJvYcCXkKuRagSSRNgAAmNh6nwwiHp3An2mDjLrBZWu2Fy3a6t16uYVXt5yl9w7/haIpW8KFxotRDe5TiPheuBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFb0l7Ht2OMb86vjxUGYlLTeW2LWTP8W26gcsKFkwHY+Rhfpt
	y0X1jxgR+n8zyS6s/POUNOB4V01Md37rnDYjfDV9Pbps6fK1PaJPuBrSF/oiNGc=
X-Google-Smtp-Source: AGHT+IHeb5Aduxup6H+0JAn2ZoUdJhsdLrQos4FHWL5rorbkqtH8DDtsmp7fBZO4APm9YLwDBuDrHA==
X-Received: by 2002:a05:600c:1c13:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-43125617834mr161604605e9.35.1729117168115;
        Wed, 16 Oct 2024 15:19:28 -0700 (PDT)
Received: from [172.20.10.2] ([91.151.136.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43150455e30sm24453175e9.1.2024.10.16.15.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:19:27 -0700 (PDT)
Message-ID: <ed2a3efcb08af8286a5821acea8302164f0b0a35.camel@intelfx.name>
Subject: Re: [PATCH v3 00/11] Adjustments for preferred core detection
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Mario Limonciello <superm1@kernel.org>
Cc: bp@alien8.de, gautham.shenoy@amd.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 x86@kernel.org
Date: Thu, 17 Oct 2024 02:19:23 +0400
In-Reply-To: <cb7fad8c-f288-410e-b380-1204b26930ad@kernel.org>
References: <3b2195074d7c8fa20f93f1dc6fc25afe5dbb2909.camel@intelfx.name>
	 <cb7fad8c-f288-410e-b380-1204b26930ad@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2024-10-16 at 17:06 -0500, Mario Limonciello wrote:
> On 10/16/2024 17:03, Ivan Shapovalov wrote:
> > Hi,
> >=20
> > On my desktop Zen 3 (Vermeer) system applying this series yields a new
> > warning message on each boot:
> >=20
> > > Oct 16 06:20:41 kernel: Could not retrieve highest performance (-19)
> >=20
> > As I see it, this is one of the pr_debug()s newly promoted to warnings.
> > Is there anything I can provide to help fix this?
> >=20
>=20
> Open up a kernel Bugzilla and attach a full dmesg and all details.  You=
=20
> can CC me directly to it and I'll look into it.
>=20
> Also ideally; can you please check 6.12-rc3.
>=20

Alright, I'll do that once I build and test the -rc.

Besides dmesg+config+cpuinfo, are there any other details that you
would like to see there?

Thanks,
>=20
--=20
Ivan Shapovalov / intelfx /

