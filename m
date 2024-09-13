Return-Path: <linux-kernel+bounces-328208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6740978096
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BABB2323E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C041DA61E;
	Fri, 13 Sep 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tzZ4PVx/";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tzZ4PVx/"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E111D9337
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232128; cv=none; b=O3CQK7wLR5FelztLc/a8v05IfWd0KAA+TBp8TOPVeXXdZlvLZEhnuMLS3H+Z+p19n9UewdACRjZPR5LtFKrwcZ4yU6q1OR+9icbjv85OzMKQcsBihlM07sHIdSj4lUczwFCBqRfiMOMVaOmGnbCySYtbreFvIZAbnZMm4TXWLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232128; c=relaxed/simple;
	bh=LVc8Qq3XJd8QUnXxr/2fyOwrcDgbCrxl6qC1wvyhnog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZGUxJ/vByJARstlKg818G0NzbaRVHc0zep7QD4t/mz36+jue2t3istkiLBvxGb118Ux/rb3u7l+c69J9gzH3VBgUeyYkbmk16FVyMGAXhNQCo38XGMvcARgwEpz/oKBUTnouQ9+CudOBWf+nl1jkHGG4wRT8jgP3QE7hX0jx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=tzZ4PVx/; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=tzZ4PVx/; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726232126;
	bh=LVc8Qq3XJd8QUnXxr/2fyOwrcDgbCrxl6qC1wvyhnog=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tzZ4PVx/3wgsgw7tyVsaOUgsjrRtNtbMob5oX8GQXiJXAKiIa8ghaw40cLeGtYPwE
	 WdkWNyR4/8tTk4AcG5Qh+/LDUDv2qz6zTOR3FQu7nScs9FAQBI3FIMBo1vZmKU10pm
	 AtfI2gQ2e3+h57EaPcKi2LX+0YXQACi4WALTMINE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7D77A1287401;
	Fri, 13 Sep 2024 08:55:26 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id AmJzjMDlzMON; Fri, 13 Sep 2024 08:55:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726232126;
	bh=LVc8Qq3XJd8QUnXxr/2fyOwrcDgbCrxl6qC1wvyhnog=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tzZ4PVx/3wgsgw7tyVsaOUgsjrRtNtbMob5oX8GQXiJXAKiIa8ghaw40cLeGtYPwE
	 WdkWNyR4/8tTk4AcG5Qh+/LDUDv2qz6zTOR3FQu7nScs9FAQBI3FIMBo1vZmKU10pm
	 AtfI2gQ2e3+h57EaPcKi2LX+0YXQACi4WALTMINE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2A552128637B;
	Fri, 13 Sep 2024 08:55:25 -0400 (EDT)
Message-ID: <cc8f30d105758c06566bab32ad6fdd87489f875e.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, Qinkun Bao <qinkun@google.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Dan Williams
 <dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Lukas Wunner
 <lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Mikko
 Ylinen <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org,
  linux-coco@lists.linux.dev, suzuki.poulose@arm.com, sami.mujawar@arm.com,
 Chong Cai <chongc@google.com>
Date: Fri, 13 Sep 2024 08:55:23 -0400
In-Reply-To: <f284ce29-6afe-40ce-ad81-b6b2cec9199c@intel.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
	 <20240910170959.GA213064@myrica>
	 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
	 <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
	 <CAOjUGWfgYoXBzUB8wFvO5LDq+=t7hAEksu0EA4Dc7FwbmUJp7A@mail.gmail.com>
	 <f92766c96c993276bec770e8a255bca6cc46c292.camel@HansenPartnership.com>
	 <c7157fb7-b8d0-482b-9ec3-d60179a95882@intel.com>
	 <0b334090c4bf21740b19371664ad0d78b66830c4.camel@HansenPartnership.com>
	 <f284ce29-6afe-40ce-ad81-b6b2cec9199c@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-09-12 at 14:00 -0500, Xing, Cedric wrote:
> On 9/12/2024 7:15 AM, James Bottomley wrote:
> > On Wed, 2024-09-11 at 22:23 -0500, Xing, Cedric wrote:
> > > Hi James,
> > > 
> > > I would like to clarify that, even though the log format is
> > > incompatible with the existing TCG2 log format, nothing prevents
> > > TPM
> > > PCRs from being exposed through the TSM measurement framework.
> > 
> > Well, the PCRs are already exposed through
> > 
> TPM predates TSM so has an existing implementation for sure.
> 
> > /sys/class/tpm/tpm0/pcr-<algo>/<n>
> > 
> > but they don't have much meaning without the log.
> > 
> Consolidating PCRs under TSM is not a requirement.

As I keep saying I'm not expecting you to do it.  However, it will be a
requirement for consolidating AMD SNP under this using the SVSM-vTPM,
so I do expect someone will do it.

>  But if it's desirable, it could be done. When it comes to the log,
> the assumption here is that we will switch log format after TSM takes
> over. The preboot log can stay where it is today. Yeah, it would be
> kinda ugly without a  unified log, but the separation of
> semantics/storage is more important,  because otherwise it will be
> very difficult to enable new applications.

I really don't think you'd want to do that because it creates a bigger
mess for all the tools if you keep using the same PCRs because now they
have to know where the log switches and how to change the extensions. 
There's no tool today that can do this.


> > > Please note that the existing event types in the TCG2 log format
> > > are predominantly BIOS/firmware-oriented, which seldom makes
> > > sense for applications in OS runtime. Consequently, most
> > > application-specific events have to come under the EV_EVENT_TAG
> > > umbrella, which is essentially arbitrary binary data with no
> > > specific format. Thus, I don't see much value in continuing the
> > > TCG2 log into OS runtime IMHO.
> > 
> > And the IMA log, which is runtime and isn't TCG2?
> > 
> By "TCG2", I refer to the TPM PC client profile that defines the EV_*
> event types. I could be very wrong but I thought IMA content/event
> types had not been defined until CEL came along.

The IMA log has always been defined in 

Documentation/security/IMA-templates

Even before CEL tried to add it as a format.

>  Though both TCG2 and CEL were designed to be extensible, adding new
> event/content types would require revising the specs, which is a very
> high bar for new applications, and is one of the major reasons for
> introducing this new log format.
> 
> Regarding the IMA log, there are several options to integrate it into
> the TSM framework:
> 
> One straight forward option is to dedicate a RTMR for IMA use. This 
> series allows off-log extension so nothing else (except mapping the
> PCR to the dedicated RTMR) needs changes.

I don't see how that would help:  From the IMA point of view there's no
practical difference between extending a PCR and extending a RTMR (it's
the same mathematical operation).  The difference is how you get the
quote and verify the log matches it.

I do note that since the whole problem boils down to the different
quoting mechanism between TPM and RTMR, it is entirely possible, since
the Quoting Enclave is all in software, for them to produce a TPM quote
even for RTMR measurements that could be verified against some external
key.  That way all the IMA tools would just work for RTMRs (which would
seem to me to be a much easier way of getting them to work with RTMRs).
It's always baffled me why Intel is so adamant that every existing
measurement tool and pathway should be rewritten for the RTMR approach
instead of simply being compatible enough to get existing tools to work
with RTMRs.  You can still keep the current RTMR quote format and the
certificate chain, simply add the ability to produce a signature that
matches the usual TPM quote.  Since a quote is only a signature over a
public key, the tools would work and the only difference is how you
confirm the certificate chain.

> The second option is to change IMA to use the new log format proposed
> here. Of course, it'd require more changes than the first option - I 
> don't believe many people would like it at the moment.

I think that's true, yes.  And that's precisely the problem with this
proposal: you're completely pejorative about log format but know that
no-one is going to change to the format you're trying to mandate.

> The third option is "virtual measurement". We can define a virtual MR
> - 
> say "mr_ima", to replace the current PCR. Then we back mr_ima by a
> real RTMR by logging the value extended to mr_ima. That is: when
> mr_ima is extended by value XYZ, an entry like "mr_ima extend
> <hash_algo>/XYZ" is  logged to some native RTMR. Later on, the
> verifier can replay the RTMR log to calculate an mr_ima value that
> matches the IMA's log. This is actually an example of sharing an RTMR
> among multiple arbitrary applications. Events from different
> applications can be distinguished by the prefix ("mr_ima" in this
> example), and a layered verifier can be built - the bottom CC-
> specific layer verifies the integrity of the log without
> understanding IMA, then the top (CC-agnostic) layer verifies
> the IMA log using calculated "mr_ima" value by the bottom layer.

But this sounds even worse.  You're adding an extra layer and an extra
logging tool simply to verify the PCR/RTMR quote and then after that
you need to us IMA tools to verify the log.

James

