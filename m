Return-Path: <linux-kernel+bounces-359403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB53E998B06
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7825292166
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9A1CC141;
	Thu, 10 Oct 2024 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fNghzfND"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB63D3B8;
	Thu, 10 Oct 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572875; cv=none; b=jvAIl+F1iCUIeCnvcvAwutceJVUg0FItYa67gk26Dq2aASC8rRiAdfRTEhalESSlp0FpfuUQz91A2ZsfuBiOIn2kIOxR91lIPa8kvcyaj/rMsIcaoGPKfoafYyW4tUUrbhrU4MlgUxnHYrmevv845KbqT3YEag7u9C0zp2Nn9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572875; c=relaxed/simple;
	bh=FXnz/6+zRZNXdcQYpR2t1giU/Ki+1WevBRAjIusqUCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qk+riBgJcGSgxp7LYOAgVwRxMbWiw5NkqnIaV65eLmRE1upDdxAsjeW2f73orfX/QnGhlZHow6z+wMNHv7GMi7aLVBwesej/ku339PIpiT08Fzj76FNoyrEnDQB0c6+zTbLOnt1QD35HJGesmycaMW70TFxIH8bfHGu7zkA00iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fNghzfND; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A4VG9R000957;
	Thu, 10 Oct 2024 10:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=rRFszoAm5F0h0DLje/Lizchf0ZNh1onDr0em4Eo/jS8=; b=
	fNghzfNDxcqoLr4RsNic05jauY5ln51TG4w1StSE8y3j3eIDglkQwN1Lv4cY7YED
	kNJUlHa2CLWWzImrcv9Y4hxelyNLO8k7AjabbFMONpOEqM32ZzdAaDJ9TpsdQVn4
	tyW1e1BB5Qsfw0oV3evRpYhh1XS/CnJ86UD7wBt6/KikFRZEQTPCztA4jtKygvHN
	y+biUF3w8K13VK2ymYWPWKd+tZSIhppsn4odnqVgErQl7P7R7WacPWGjKVpKSWhx
	PMfgvfr1vVBtbBeOwzAw0UwxwvrYOSIIw85/13lnuIxrbSt0zqbCiFvdO68KzbVj
	FXvFi7xnE6qhIYrzPCxrCg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4232uy7g1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 10:07:27 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 16:07:24 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 10 Oct 2024 16:07:24 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B724482024A;
	Thu, 10 Oct 2024 15:07:24 +0000 (UTC)
Message-ID: <300a9fe1-a431-4fa2-8a25-d31d0d264099@opensource.cirrus.com>
Date: Thu, 10 Oct 2024 16:07:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/realtek: fixup ASUS GA605W
To: Takashi Iwai <tiwai@suse.de>, Simon Trimmer <simont@opensource.cirrus.com>
CC: "'Luke D. Jones'" <luke@ljones.dev>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <foss@athaariq.my.id>, <sbinding@opensource.cirrus.com>,
        <kailang@realtek.com>, <perex@perex.cz>
References: <20241009205800.40570-1-luke@ljones.dev>
 <000d01db1afa$4e76b430$eb641c90$@opensource.cirrus.com>
 <87wmig17f2.wl-tiwai@suse.de>
 <001401db1b17$2afd9060$80f8b120$@opensource.cirrus.com>
 <8734l410tn.wl-tiwai@suse.de>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <8734l410tn.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6pWlagTAbAdVnETHdO6_gcnI47bs2QzA
X-Proofpoint-ORIG-GUID: 6pWlagTAbAdVnETHdO6_gcnI47bs2QzA
X-Proofpoint-Spam-Reason: safe

On 10/10/2024 3:37 pm, Takashi Iwai wrote:
> On Thu, 10 Oct 2024 15:20:25 +0200,
> Simon Trimmer wrote:
>>
>> On Thu, 10 Oct 2024 13:15, Takashi Iwai wrote:
>>> On Thu, 10 Oct 2024 11:53:49 +0200, Simon Trimmer wrote:
>>>> On Wed, Oct 09, 2024, Luke D. Jones wrote:
>>>>> The GA605W laptop has almost the exact same codec setup as the GA403
>>>>> and so the same quirks apply to it.
>>>>>
>>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>> ---
>>>>>   sound/pci/hda/patch_realtek.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/sound/pci/hda/patch_realtek.c
>>> b/sound/pci/hda/patch_realtek.c
>>>>> index 41e1119877b3..19b0bae074b6 100644
>>>>> --- a/sound/pci/hda/patch_realtek.c
>>>>> +++ b/sound/pci/hda/patch_realtek.c
>>>>> @@ -10507,7 +10507,7 @@ static const struct snd_pci_quirk
>>>>> alc269_fixup_tbl[] = {
>>>> ...
>>>>>   	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W",
>>>> ALC285_FIXUP_CS35L56_I2C_2),
>>>>> -	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
>>>> ALC285_FIXUP_CS35L56_I2C_2),
>>>>> +	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W",
>>>> ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC),
>>>> ...
>>>>
>>>> Hi Luke,
>>>> Thanks!
>>>>
>>>> The support code for the CS35L56 has changed a little in Takashi's
>> branches
>>>> from what that patch was generated against and there is no longer an
>>>> existing quirk in the fixup table to trigger the component binding (but
>> the
>>>> general idea seems reasonable to hook the fixup of the headset mic).
>>>
>>> Right, the patch doesn't apply to the latest tree for 6.12-rc.
>>>
>>> We should start with setting up only the pincfg.  The binding with
>>> Cirrus is handled via find_cirrus_companion_amps().  The shared DAC
>>> of speaker and bass speaker is an open question, whether we still need
>>> the workaround by alc285_fixup_speaker2_to_dac1().  Let's see.
>>>
>>> BTW, rather a question to Cirrus devs: may the call of
>>> find_cirrus_companion_amps() conflict with the existing manual setup
>>> of the Cirrus codec by a quirk entry?
>>
>> I think we're good (I rarely get to access to the end products so try to
>> stick to the parts of the system that I have the details for which never
>> includes the Realtek codec...) in this general case I'd just expect that the
>> quirk entries wouldn't have the element at the end of the chain that used to
>> do the amp component binding fixup and the remaining tweaks for things like
>> the Realtek routing and mute indicators would be unaffected.
> 
> Well, there are quirks that do call comp_generic_fixup() with fixed
> arguments, and I'm afraid they'll lead to some spurious error
> messages.  Namely, find_cirrus_companion_amps() is called before
> snd_hda_apply_fixup(PRE_PROBE), so comp_generic_fixup() might be
> already invoked there, and the quirk entry invokes
> comp_generic_fixup() again.  This will end up with an error message by
> the parent->codec check in hda_component_manager_init().
> It's just a message and nothing harmful happening, though.
> 
find_cirrus_companion_amps() currently only handles CS35L54/56/57, and
when that patch was sent it also converted all quirks using those
devices so they _don't_ call comp_generic_fixup(). The purpose of the
warning was to detect people adding a quirk that tried to do the old
way of manual component binding setup from the quirk.

The remaining quirks that call comp_generic_fixup() are for CS35L41/51,
which we haven't converted yet because there are many more models, some
with strange ACPI and some that are old models we can't easily get hold
of to re-test.


