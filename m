Return-Path: <linux-kernel+bounces-325101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C142975502
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907261C20AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2A19993B;
	Wed, 11 Sep 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="oAzOuVX8";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="oAzOuVX8"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6F18593F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063820; cv=none; b=BF3h5bw0axR0Z1lrrmtXHmlRtcze7d37pZ+kS+uUvTk9Tj/7fSHvUs0Wz3DCLoSTzWMosNQZOc3kym73BE+wqN0bXmvGHMOfyhIu+t8jNjeq1ItY9b/InzNrPPXVZrNl2mHKA+TCKgLXudynzm/lyMNOLeepsOsJdU/KypUJsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063820; c=relaxed/simple;
	bh=MLFXgjmGGM2Bz0scmxo4yRyqbzIL0VWbBq6A/XZ3dVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Axxrbsan6F4sVoy73X26tBYabDLcpl+T8CXWXM1Y0RvBNLXhVS791IZyyRYUK/OTU1Hm0Z5Tz0LtCfO+5yZG6Z/Nqlf/dpiWZZm3dyYSfZX3zIu80p6KzdVOTEHB3U12AP/2NCpdUqtCqlNYQAMjJ4sqlh9JlsdJpHwX4RtfJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=oAzOuVX8; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=oAzOuVX8; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726063817;
	bh=MLFXgjmGGM2Bz0scmxo4yRyqbzIL0VWbBq6A/XZ3dVY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=oAzOuVX856XkIARG7wx2oQBH7x5opaPRZD8Z1+ONtudIK4iV6+6NUdzfrMtpJGJS9
	 rMYnAWWPzMPWLsnds0/1j0Hzo+EFuDeLAJMrv82NijHITPlkaY6D+WP4//v0Bbt2PZ
	 lk5JnQse2H73xB5bhNIrjOb7aaaj962gro8yqSTk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 94FCE128637B;
	Wed, 11 Sep 2024 10:10:17 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id wITZLUAgusyz; Wed, 11 Sep 2024 10:10:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726063817;
	bh=MLFXgjmGGM2Bz0scmxo4yRyqbzIL0VWbBq6A/XZ3dVY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=oAzOuVX856XkIARG7wx2oQBH7x5opaPRZD8Z1+ONtudIK4iV6+6NUdzfrMtpJGJS9
	 rMYnAWWPzMPWLsnds0/1j0Hzo+EFuDeLAJMrv82NijHITPlkaY6D+WP4//v0Bbt2PZ
	 lk5JnQse2H73xB5bhNIrjOb7aaaj962gro8yqSTk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C0C041286365;
	Wed, 11 Sep 2024 10:10:15 -0400 (EDT)
Message-ID: <f92766c96c993276bec770e8a255bca6cc46c292.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Qinkun Bao <qinkun@google.com>
Cc: "Xing, Cedric" <cedric.xing@intel.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Dan Williams <dan.j.williams@intel.com>, Samuel
 Ortiz <sameo@rivosinc.com>, Lukas Wunner <lukas@wunner.de>, Dionna Amalie
 Glaze <dionnaglaze@google.com>, Mikko Ylinen
 <mikko.ylinen@linux.intel.com>,  Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev,  suzuki.poulose@arm.com, sami.mujawar@arm.com,
 Chong Cai <chongc@google.com>
Date: Wed, 11 Sep 2024 10:10:14 -0400
In-Reply-To: <CAOjUGWfgYoXBzUB8wFvO5LDq+=t7hAEksu0EA4Dc7FwbmUJp7A@mail.gmail.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
	 <20240910170959.GA213064@myrica>
	 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
	 <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
	 <CAOjUGWfgYoXBzUB8wFvO5LDq+=t7hAEksu0EA4Dc7FwbmUJp7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-09-11 at 21:46 +0800, Qinkun Bao wrote:
> On Wed, Sep 11, 2024 at 8:06 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Tue, 2024-09-10 at 23:01 -0500, Xing, Cedric wrote:
> > > On 9/10/2024 12:09 PM, Jean-Philippe Brucker wrote:
> > > > Hi Cedric,
> > > > 
> > > > On Sat, Sep 07, 2024 at 11:56:18PM -0500, Cedric Xing wrote:
> > > > > Patch 2 introduces event log support for RTMRs, addressing
> > > > > the fact that the standalone values of RTMRs, which represent
> > > > > the cumulative digests of sequential events, are not fully
> > > > > informative on their own.
> > > > 
> > > > Would each event_log include the events that firmware wrote
> > > > before Linux?
> > > 
> > > No. The log format proposed here is textual and incompatible with
> > > TCG2 log format.
> > > 
> > > The proposed log format is based on the CoCo event log -
> > > https://github.com/confidential-containers/guest-components/issues/495
> > > .
> > 
> > Given that AMD is planning to use the SVSM-vTPM for post launch
> > measurements, not supporting TPMs in any form would make this Intel
> > only on x86 and thus not very "unified".  Microsoft also tends to
> > do attestations partly via the vTPM in its L1 openHCL component
> > (even for TDX) and thus would also have difficulty adopting this
> > proposal.
> > 
> 
> Hi James,
> 
> I don't think the patch should be blocked for not supporting the
> SVSM-vTPM and it is not an Intel only patch.

Actually, I'm not objecting to the patch not supporting the TPM, I'm
objecting to design choices, like the log, that make it much harder to
add TPM support later.  Realistically if you want a universal
measurement ABI, it has to work for physical systems as well, which
means TPM or DICE, since RTMR is a bit non-standard.

> 1. Not everyone prefers the SVSM-vTPM as it lacks the persistent
> storage and does not comply with TCG's TPM specifications. TPM is not
> just about the measurement.

I think you'll find an ephemeral TPM is TCG compliant: the NV is
actually an additional profile in the TCG specifications.

> Sealing and unsealing data is also a critical functionality for TPM.
> Treating thenSVSM-vTPM as a TPM misleads users and disrupts existing
> software based on TPMs. The SVSM-vTPM is not TPM. Just like
> Javascript is not Java.

I've already explained several times how sealing and unsealing can be
done with an ephemeral TPM. I'm not going to get into prejudices about
naming.

> 2. If our goal is to measure the boot chain and post-launch, the RTMR
> is an effective and straightforward method. We already support RTMR
> for TDX. For SNP, simulating the RTMRs in SVSM is very simple while
> implementing the SVSM-vTPM needs a lot of changes.

in the upstream, the vTPM is already done.  There's no current pull
request for RTMR emulation.

> The SVSM-vTPM significantly expands the TCB while offering limited
> security value enhancements compared to the RTMR.

So would every other feature on the coconut roadmap.

> 3. RTMR as a technology has been adopted widely. It is not an Intel
> only technology. The TDX CVMs on Google Cloud already support RTMRs.
> The TDX CVMs [1] on Alibaba Cloud supports RTMR as well. In terms of
> the attestation verifiers, the token from Intel ITA [2] and Microsoft
> Attestation Service [3] indicate they support RTMRs. The Ubuntu image
> [4] from Canonical enables RTMR by default.

So you think Intel should abandon its work on ephemeral vTPMs for TDX?

Regards,

James
 

