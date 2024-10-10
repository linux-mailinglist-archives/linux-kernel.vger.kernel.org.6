Return-Path: <linux-kernel+bounces-359101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99F099877C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164001C218C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B261C9DE9;
	Thu, 10 Oct 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="W+3qDMOr"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2921C9B95;
	Thu, 10 Oct 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566449; cv=none; b=CdjdiJgYuTVCre0au5sKgO/3W61b46sUz2HjzBmGiNrkmZvb63jVi30LjeuVDv8HxrMS1D//7uriC4fOnOkGNxrqm9bih8B1ZCf5oVwdr26vLW2vr28Dp/oGsEmhBz1G1O0llBet+ZXqUI1d9479aL17YVEvshz2hv2sHQ9LT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566449; c=relaxed/simple;
	bh=JZrAbpbckH2nBhnmg5VyCz6EUzQ3WD5A0ex838XTkKg=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=dzg59qT+b4fFg5AkcbdGCVwuC6xaciIpFIGEXxp6z3/yJNt8X4oaJBNBmv3jKxwtCeaAAU86eIRSOXGZmP1tNiJMTFBtsY5hb5fSeoYPmm31AY0Q+PD4u4gOa9WhaKLpi7NAWMFib/j0ujpxpQv7OaRi233LgdDdxa6ODiGVfWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=W+3qDMOr; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A7scEZ023252;
	Thu, 10 Oct 2024 08:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=G7le7fW1jGOAmb535XwG1XQ3Pf+60e0NkXkbfOAA50s=; b=
	W+3qDMOrmRSRe6ZvEy7OK9j6f8ZY2RvOeQZPAiGYQ/gXgdRVzwadSCX9rzyP+eyq
	q8rSHpfyyPTylAfZVoNFxv0KUQV+hUX3JSUrCSOAQQQ/rPdpSIzh7WtwwHRDzUJO
	lGCHlEKGrTYDunT+RLrM5BDqIACUj/ncIp1puOgoabnIuu3ghRFohDg3kuS7S29t
	XfVyezarpkjoAZRfOZfHYG0uV/V1nefpOmupWOpCTeOIlpoWLvSwfR5vlqjfiAyQ
	OLEFkeIhYz/i96+ht7QuMnTE/ZV12LSuaRXAA01B9Vzr15AVzMWISWYTlyZfWBAt
	63FD4rzBlMS2TiieDfo62w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4231vhxnra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 08:20:27 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 14:20:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 10 Oct 2024 14:20:25 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.61.68.101])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7082682024A;
	Thu, 10 Oct 2024 13:20:25 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Takashi Iwai' <tiwai@suse.de>
CC: "'Luke D. Jones'" <luke@ljones.dev>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <rf@opensource.cirrus.com>, <foss@athaariq.my.id>,
        <sbinding@opensource.cirrus.com>, <kailang@realtek.com>,
        <perex@perex.cz>
References: <20241009205800.40570-1-luke@ljones.dev>	<000d01db1afa$4e76b430$eb641c90$@opensource.cirrus.com> <87wmig17f2.wl-tiwai@suse.de>
In-Reply-To: <87wmig17f2.wl-tiwai@suse.de>
Subject: RE: [PATCH] ALSA: hda/realtek: fixup ASUS GA605W
Date: Thu, 10 Oct 2024 14:20:25 +0100
Message-ID: <001401db1b17$2afd9060$80f8b120$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQLaM5BF+fBgGyVU6uCoux+KLk9DawE2RdoNATtvTXawbjR9YA==
X-Proofpoint-GUID: TJcchQXsWPsZ4rQq9kkWWJ7ATE2ro_Vn
X-Proofpoint-ORIG-GUID: TJcchQXsWPsZ4rQq9kkWWJ7ATE2ro_Vn
X-Proofpoint-Spam-Reason: safe

On Thu, 10 Oct 2024 13:15, Takashi Iwai wrote:
> On Thu, 10 Oct 2024 11:53:49 +0200, Simon Trimmer wrote:
> > On Wed, Oct 09, 2024, Luke D. Jones wrote:
> > > The GA605W laptop has almost the exact same codec setup as the GA403
> > > and so the same quirks apply to it.
> > >
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > ---
> > >  sound/pci/hda/patch_realtek.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/sound/pci/hda/patch_realtek.c
> b/sound/pci/hda/patch_realtek.c
> > > index 41e1119877b3..19b0bae074b6 100644
> > > --- a/sound/pci/hda/patch_realtek.c
> > > +++ b/sound/pci/hda/patch_realtek.c
> > > @@ -10507,7 +10507,7 @@ static const struct snd_pci_quirk
> > > alc269_fixup_tbl[] = {
> > ...
> > >  	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W",
> > ALC285_FIXUP_CS35L56_I2C_2),
> > > -	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
> > ALC285_FIXUP_CS35L56_I2C_2),
> > > +	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
> > ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC),
> > ...
> >
> > Hi Luke,
> > Thanks!
> >
> > The support code for the CS35L56 has changed a little in Takashi's
branches
> > from what that patch was generated against and there is no longer an
> > existing quirk in the fixup table to trigger the component binding (but
the
> > general idea seems reasonable to hook the fixup of the headset mic).
> 
> Right, the patch doesn't apply to the latest tree for 6.12-rc.
> 
> We should start with setting up only the pincfg.  The binding with
> Cirrus is handled via find_cirrus_companion_amps().  The shared DAC
> of speaker and bass speaker is an open question, whether we still need
> the workaround by alc285_fixup_speaker2_to_dac1().  Let's see.
> 
> BTW, rather a question to Cirrus devs: may the call of
> find_cirrus_companion_amps() conflict with the existing manual setup
> of the Cirrus codec by a quirk entry?

I think we're good (I rarely get to access to the end products so try to
stick to the parts of the system that I have the details for which never
includes the Realtek codec...) in this general case I'd just expect that the
quirk entries wouldn't have the element at the end of the chain that used to
do the amp component binding fixup and the remaining tweaks for things like
the Realtek routing and mute indicators would be unaffected.

Cheers,
-Simon


