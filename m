Return-Path: <linux-kernel+bounces-328211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AFE97809F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D00CBB22DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FBC1DA62B;
	Fri, 13 Sep 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="uQ0/gsmQ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="uQ0/gsmQ"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25931D58BC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232323; cv=none; b=RDE9f737UE+i4D/zR2SRUAmuP0xniaII20zoIL0dkHCEu2bMbfU1K2QaB+2cOyTmEkFwz2VQjcE+LL0A+m0r4TsAvRtDGFl16jk3/bnr6Ctcqj2FV3qAkAzoYewbapWSEkWUWqoW8h1+NKcgkKpXbsqMBVzsBZZxiGAo8ErqAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232323; c=relaxed/simple;
	bh=NnRzSLb3UAoUgv/xwfkQphsxjMNdXSx4PzwUz+ixy+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sMNYOQlTtPq6aXESDKKwPX+bv1u79Kmu1sOitzXAo8dF0q0azt2wQUHEioLwlpjKWodj56u9Lma5l9U9kN5z9jIMYYn4DmXv4VLUQ20UkM6BuLR6AF2gXHV41Z1rCFjdXV3Gwu/653RZm1zAzWWHMostMwDX0ahNFiJWHX7gQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=uQ0/gsmQ; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=uQ0/gsmQ; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726232320;
	bh=NnRzSLb3UAoUgv/xwfkQphsxjMNdXSx4PzwUz+ixy+g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=uQ0/gsmQ5oJTKoZ+fRyJ32DJ/jRLha3YN6/5fc4kgF92ZItUji+Mwy3In6psTO2ii
	 3/HxXFwZbP+JK/hU4tcUBp3C7ZhwEpBnuf5q12i0TB4iToVWbRFUm5l3OWUUYRUhgo
	 kF5VUeSiOapHLKz4ovrzFPDNH+wzOrcaHhXhlO0k=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id F182F128637B;
	Fri, 13 Sep 2024 08:58:40 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id GP1w_91yw4Hq; Fri, 13 Sep 2024 08:58:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726232320;
	bh=NnRzSLb3UAoUgv/xwfkQphsxjMNdXSx4PzwUz+ixy+g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=uQ0/gsmQ5oJTKoZ+fRyJ32DJ/jRLha3YN6/5fc4kgF92ZItUji+Mwy3In6psTO2ii
	 3/HxXFwZbP+JK/hU4tcUBp3C7ZhwEpBnuf5q12i0TB4iToVWbRFUm5l3OWUUYRUhgo
	 kF5VUeSiOapHLKz4ovrzFPDNH+wzOrcaHhXhlO0k=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B30BE1287450;
	Fri, 13 Sep 2024 08:58:39 -0400 (EDT)
Message-ID: <6fa6084fb9157ec453854aa5b7d34bdfddc63a75.camel@HansenPartnership.com>
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
Date: Fri, 13 Sep 2024 08:58:37 -0400
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
Content-Transfer-Encoding: 8bit

On Thu, 2024-09-12 at 14:00 -0500, Xing, Cedric wrote:
> On 9/12/2024 7:15 AM, James Bottomley wrote:
> > On Wed, 2024-09-11 at 22:23 -0500, Xing, Cedric wrote:
[...]
> > > The proposed log format aims to provide a framework for
> > > unambiguous hashing while allowing application-defined events.
> > > Its primary design objective is to enable application-agnostic
> > > kernel/verifier to hash/verify logs without understanding the
> > > event records, allowing application-specific appraisers to be
> > > built on top (i.e., semantics/storage separation). Both TCG2 and
> > > CEL formats rely on event/content type to dictate what part of
> > > event data to hash, making semantics/storage separation
> > > impossible. Therefore, this proposed log format cannot
> > > accommodate entries from TCG2 or CEL logs due to that
> > > design conflict. However, entries of this log can easily be
> > > encapsulated in TCG2 (as EV_ACTION entries) or CEL-JSON (a new
> > > content type string needs to be defined, like what systemd is
> > > doing today) logs.
> > 
> > But that's my complaint.  This specification:
> > 
> >     - Records are lines ending with `\n`.
> >     - Each record (line) is hashed in its entirety (excluding the
> >     trailing `\n`) and extended to the RTMR.
> >     - The log for an RTMR is stored at
> >     `/sys/kernel/tsm/<MR group name>/<RTMR name>/event_log` and
> > consists
> >     of these delineated records.
> >     - Lines that are empty (containing only `\n`) or start with `#`
> > are
> >     skipped (not hashed or extended).
> >     
> > Is completely incompatible with pretty much every current log
> > format.
> 
> Unfortunately this is true, because this log format has different
> design objectives than pretty much all existing log formats. Another
> notable difference is this ABI is log oriented, vs. most existing log
> formats are digest oriented. A log oriented design allows
> applications to generate identical logs regardless of the underlying
> CC arch.

So you're saying in order to get this to work successfully you have to
design a better log.  I'm afraid I now have to quote xkcd 927 to you:

https://xkcd.com/927/

> > Given you have fairly elaborate decorations for the register
> > formats, what's the problem with simply having a decoration for the
> > log format? That way you can use the above incompatible log for
> > your purpose but this framework can support existing logs and
> > expand to future ones as they come along.  All this would mean
> > initially to the code is adding the decoration file (easy) and
> > ensuring that append_event is handled by a log format specific
> > component, allowing for expansion.
> > 
> Using CEL terms, ELCD (Event Log Critical Data) could be easily 
> encapsulated in both TCG2 and CEL, but ELID (Event Log Informative
> Data - i.e., lines starting with '#') is not. One use of ELID is to
> support off-log extension, designed to help migrating existing
> applications. The  `SYNC` lines (necessary after off-log extensions,
> see Patch 2 for details) would also require special treatments from
> the verifier. Therefore, converting this log to a TCG2 or CEL log is
> NOT always doable. It'll be better to convert log format only when
> needed (and before any off-log extensions have been done).

You seem to be hung up on requiring a single log format.  That horse
left the stable decades ago and isn't coming back (the CEL attempt to
corral it was ultimately not successful).  I'm saying we accept that
fact and simply expose and extend logs in whatever format they exist in
today without forcing them to change.  I proposed a mechanism for doing
that here:

https://lore.kernel.org/linux-coco/86e6659bc8dd135491dc34bdb247caf05d8d2ad8.camel@HansenPartnership.com/

Which seems like it would work with pretty much every current
measurement tool (with minor modifications to change a few paths) and
even allow you to add your new log format if you insist.

Regards,

James


