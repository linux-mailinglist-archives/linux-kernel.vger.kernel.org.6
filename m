Return-Path: <linux-kernel+bounces-554626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE28A59A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9C516EC15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C41222DFA5;
	Mon, 10 Mar 2025 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt27WW1M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964122B8AC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622720; cv=none; b=aMkWrzCYPB6xmU02+VvZw0ufpVnofPMlNrSpa1Is9jRfPjNvC2skStBF9dasfXsAeGbUFRTrWdZoGWPiHkpCnd//ZKqZRjcHfUJ0cTML7DJZBCdN1Z5T/4VGzK1i6JmM39Yi5H2U8aIgizxxshLgDQe6VLI8i+UQSbXK0PQ8Kfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622720; c=relaxed/simple;
	bh=ATbO4QDHn3Ig8r1HNkDjSlZ+nFBIr80vxVD/XV2ZV8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/wdcNNti5SapMfQuQ5WGWVPh+JPhHfRNF4EFZYypha+7X15BQjbF6JFNfk53flj885M7UZ8UK6QlmeThyGyDXqoR0Bug8uFXdYpAl2BBNI5a1/jEvBgwPiGDfG5w4PAPTPXQ8vlnBC0/pruQGEXTX/v/vUmHlretxFXqj1BG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt27WW1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6DEC4CEE5;
	Mon, 10 Mar 2025 16:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741622719;
	bh=ATbO4QDHn3Ig8r1HNkDjSlZ+nFBIr80vxVD/XV2ZV8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lt27WW1MWOtKuMXUX4V3S7YpXHdDZ/HiTlIb8uAPhQxJo5lx+eM1ZMnT5issdpdO/
	 HTOtLokoUlBHG04QgQDFx8Ff91KFUGCcebN6U80EkPArPXa8/JLZ93UCSofvVzuFtD
	 l6aDJ5ZMp2yz5DzhE4ooKjVOHbUYvKJ0Nd++wSlV4VxtFvHwayAHPOThTGZZeC/sOU
	 MoBBK6Xdm01Lv2xLUcGAPJyq2Q79FZyiBHIDq/Z96gu6pZ68QNPj2kunMIcZSyHAlS
	 IPLf1YXXz/ZC/zgdbqFeXlRBBQGZRdmESDEP+Og3XEHtgQgCLIkfUPK2D+StcqdA6c
	 Wq/5dti0+0+vg==
Date: Mon, 10 Mar 2025 17:05:13 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z88NueKqfCPbpzQm@example.org>
References: <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
 <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>

On Mon, Mar 10, 2025 at 04:52:37PM +0100, Juergen Gross wrote:
> On 10.03.25 16:43, Alexey Gladkov wrote:
> > On Mon, Mar 10, 2025 at 04:33:08PM +0100, J=FCrgen Gro=DF wrote:
> >> On 10.03.25 16:11, Borislav Petkov wrote:
> >>> On Mon, Mar 10, 2025 at 03:50:09PM +0100, Alexey Gladkov wrote:
> >>>> Am I understand correctly that you and Joerg are proposing
> >>>>
> >>>> /sys/guest/tdx/...
> >>>> /sys/guest/sev/...
> >>>>
> >>>> ?
> >>>>
> >>>> Which path to use for the host side ?
> >>>>
> >>>> For guest: /sys/coco/guest/{tdx,sev}/...
> >>>> For host:  /sys/coco/host/{tdx,sev}/...
> >>>>
> >>>> Maybe it would be better to add the "coco" subdirectory or something=
 like
> >>>> that ?
> >>>
> >>> Hmm, so we can do
> >>>
> >>> /sys/guest
> >>>
> >>> and extend
> >>>
> >>> /sys/hypervisor
> >>>
> >>> Or we can do what you're suggesting.
> >>>
> >>> If we do /sys/coco/host, then we'll have two different places to read=
 HV info.
> >>>
> >>> Or we can stick *everything* coco needs in
> >>>
> >>> /sys/coco/{sev,tdx}
> >>>
> >>> but then it is coco-specific and if other guest types want to put stu=
ff in
> >>> sysfs, it'll get ugly.
> >>>
> >>> So I guess having
> >>>
> >>> /sys/guest
> >>> and
> >>> /sys/hypervisor
> >>>
> >>> kinda keeps it all clean, hierarchy-wise...
> >>>
> >>> Right?
> >>
> >> Kind of.
> >>
> >> /sys/hypervisor is meant to provide data for running under a hyperviso=
r.
> >>
> >> It is NOT meant to provide data for running as a hypervisor.
> >>
> >> So far when running either under Xen or under z/VM /sys/hypervisor is =
being
> >> populated.
> >>
> >> I'm not feeling really strong here. I just want to state the status qu=
o.
> >=20
> > OK, so I misunderstood.
> >=20
> > If in the /sys/hypervisor we have information for guest (for running un=
der
> > a hypervisor), where do you propose to put the information for the
> > host-side (for running as a hypervisor) ?
> >=20
>=20
> /sys/kvm/ might be a good fit when using KVM?

As far as I can see /sys/hypervisor should contain information about both
host-side and guest-side. If of course we would use the same files as
described in the ABI xen team.

Why do we need /sys/kvm/{tdx,sev}/ ?

I keep mentioning tdx and sev because they will have a different set of
files.

--=20
Rgrds, legion


