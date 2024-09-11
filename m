Return-Path: <linux-kernel+bounces-324840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4221197516F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00B5B28744
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB5186E54;
	Wed, 11 Sep 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CRZv1gYF";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CRZv1gYF"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC7187321
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056393; cv=none; b=PX8pwSlstMGgVbl6ALimZEncDZ1X1RRolaTFGAY3r3jgz9D9yq7HP7hqIr6Lf3mGPKrVR4O4cc4eg80kTNV4MCgHJY6DmLdTG0NvfPUXIpVmW+azgGAKQPDAN8FQ7HRSpWBj+DfH3mZxht9K0gumhie7soK12CFgN6vfEj1dI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056393; c=relaxed/simple;
	bh=RRYpzrCIc4/Xe+g0aYPeg/MPSChEFt/5BSMzWDxbDso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/ivwWAcC8tZ9xBFv00Um4POKnZuAogpz5wap6l62TgTYuB0d5IpSvFKPw5sNHFzw5dcpwvcPw/PZTLvqCcI5pdjQrF0jGPPjuUzuiSObjPFs6mEvNRQNrohKU4n5hCIy2Q0ZUSTt+xLVqhDP5ZEl2QgqhFlaf6Ku5TFs/SPeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CRZv1gYF; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CRZv1gYF; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726056390;
	bh=RRYpzrCIc4/Xe+g0aYPeg/MPSChEFt/5BSMzWDxbDso=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CRZv1gYFz3vzsGaYWLyBX1eswzRTAlxF73KQsAJ3XdkBYT7KncC+NP5r0fzAJSVOq
	 0yLLaBa0HP/q+TMwIQpnTI9uiCNb7pADrGIjPIQris0Bsh/lYDWDNhPYXrCMtNgb/P
	 l36/rHQZmngGrp4hf9IhSeWZewno/DdYWyMdb5Rw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id DD156128609C;
	Wed, 11 Sep 2024 08:06:30 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hGpnq_4fl3-f; Wed, 11 Sep 2024 08:06:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726056390;
	bh=RRYpzrCIc4/Xe+g0aYPeg/MPSChEFt/5BSMzWDxbDso=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CRZv1gYFz3vzsGaYWLyBX1eswzRTAlxF73KQsAJ3XdkBYT7KncC+NP5r0fzAJSVOq
	 0yLLaBa0HP/q+TMwIQpnTI9uiCNb7pADrGIjPIQris0Bsh/lYDWDNhPYXrCMtNgb/P
	 l36/rHQZmngGrp4hf9IhSeWZewno/DdYWyMdb5Rw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A23F0128187B;
	Wed, 11 Sep 2024 08:06:29 -0400 (EDT)
Message-ID: <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, Jean-Philippe Brucker
	 <jean-philippe@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz
 <sameo@rivosinc.com>,  Lukas Wunner <lukas@wunner.de>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,  Mikko Ylinen
 <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org,
  linux-coco@lists.linux.dev, suzuki.poulose@arm.com, sami.mujawar@arm.com
Date: Wed, 11 Sep 2024 08:06:27 -0400
In-Reply-To: <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
	 <20240910170959.GA213064@myrica>
	 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-09-10 at 23:01 -0500, Xing, Cedric wrote:
> On 9/10/2024 12:09 PM, Jean-Philippe Brucker wrote:
> > Hi Cedric,
> > 
> > On Sat, Sep 07, 2024 at 11:56:18PM -0500, Cedric Xing wrote:
> > > Patch 2 introduces event log support for RTMRs, addressing the
> > > fact that the standalone values of RTMRs, which represent the
> > > cumulative digests of sequential events, are not fully
> > > informative on their own.
> > 
> > Would each event_log include the events that firmware wrote before
> > Linux?
>  
> No. The log format proposed here is textual and incompatible with
> TCG2 log format.
> 
> The proposed log format is based on the CoCo event log - 
> https://github.com/confidential-containers/guest-components/issues/495
> .

Given that AMD is planning to use the SVSM-vTPM for post launch
measurements, not supporting TPMs in any form would make this Intel
only on x86 and thus not very "unified".  Microsoft also tends to do
attestations partly via the vTPM in its L1 openHCL component (even for
TDX) and thus would also have difficulty adopting this proposal.

Regards,

James


