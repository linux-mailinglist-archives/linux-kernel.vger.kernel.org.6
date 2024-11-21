Return-Path: <linux-kernel+bounces-417457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B100A9D544C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BA12819EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781B1D041B;
	Thu, 21 Nov 2024 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLMAcM4q"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3581C1F24
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221949; cv=none; b=JK5QIlSNOe8yqekQcBU0mmC7KXUv4rS9mby4iGD6eSN+drkdY9jN6dNWpJuDPUcgeI1cLAeJr5Xv9w48CtimutTw8CL/HZRHfmA1o5exoVTQ5fT+plJ27zP31H0qHkPFAGWpdc2aqPD/mEeP5lAjGPo+15YGnOBfhSL2qBWlFRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221949; c=relaxed/simple;
	bh=+PjyAmyi4nMTZ2JOJskb4rrvBLr7SK4h92YxZvH4bJI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=TJz0MiLshB+cx3mBrjpNW9MQnSUm17aEtzoKBgR8GHMy58uPzLLXMEG51PXLYNGwZCLsa4hidFPo/MMI5RDjJzbdjSZsfynefKM8NkdFOLksKLerNLEwlb9jlVXnOBfiex3a4F+SswGY3207rQARuOkvbpMJZKh1aQuIHhswHgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLMAcM4q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72410cc7be9so1327592b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732221945; x=1732826745; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VtSRjuJwza2RH5ehpU7qNEh2YcxlKoG/hB48tQGalvQ=;
        b=DLMAcM4q5yYu5Cj7SntvcY0YLc8dydpfIiqB4FqvwdxkRgja3kj3whIoRDbbJ9h0Jn
         LdhsO2oKcouhihyBiGRVAwsLgANRJUA5CWAXGP3qCDxW5oaCw3wKfjHGPij97/ke+dfj
         56nvFKduT/GoF5EbDWUZEMoma47l0lZU/ICPrOxQUHCoaSNRmPgQpx+B2DDWltSq2aXh
         le2xKkjemFDRhST847ER1W3Rz3tnXWIioAzeJnpvhMmTlNL8aAnRw7Xwyw82VrFodinB
         RsGQpEPzDyl/7vRsJooJrZu3mDh5jvBplhwKyq4+xfEW9YPqPjsbYZURxzZiw/sha7hU
         ylGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221945; x=1732826745;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtSRjuJwza2RH5ehpU7qNEh2YcxlKoG/hB48tQGalvQ=;
        b=dUwcBaqh+aOhqyQxImfWOpDX/BEq3FvyfTu87iFD1y9VG43bIvjmtNh7lVLr34hPzC
         sagq10ppVdXhKmnS2wDBNdJ2izWTuavCyRDV+YGwUAlmR3MsM628aCJL1QVz48HHb9m8
         oSlG30MPVV46MSDoTn0PCEsAD+wUhNxXv0WwpwgSXw4TFQE9o3XNFFburnYA3f1kCl12
         SxqjlErOHaRY5Tg8HfFGjRH2SU96JZefMSiwg3/IBqtpCJ2y05CHieHEWFhCJQCMryvE
         yAmd3CLKhEitvpdG+3e60fEPR58t7fpfnIzIngwmrj/QRoY9hkoyM3NwTORLvWR5ue+S
         5fqg==
X-Forwarded-Encrypted: i=1; AJvYcCVAVqrYpEMmEl0ufkya9ZJuOggFVDJbmzZW+3jRzo43oyuHtJvpjsBK4p1puDmE8PKDJGKj/CLo7s18iCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5UP9BcEnzRna5tTWshRx4yhHN1A+VH0PlqYm3jZvG1LP2vYp
	pqDcGyHA0oQskE15JPCqfb89tjRPMHps6OKBp1Lg8+MgP05E/tbGUgHmfhHI
X-Gm-Gg: ASbGncuEWWFjkSs3jyd/zBxl/za471jQctk5KMfd5XVLldPIx+Fr2WuGt7EhGvNEp1W
	cy/F+0uvAgYLIyD6XwkswypPS+rgqxr2zxI/IyqSkcaEAGsD1tyv3YelOEtJ57rRYynvmxexupy
	RrscE10ck5pudUt+ZDirIOWPiNgbtZiwVeT2yqmQgNNz49Zi2POEit1UrclTRrdKJfyiN9SJGXH
	IlJuUSPPmtDFCSF/0hPJd2lhsE/oed9ei/KYLIh3yQ=
X-Google-Smtp-Source: AGHT+IGezdLw8pd5bAJJH2FxWUd5eSOKARsWYuo+GBjewBEIPtsbxv5xI7Rxnto/ZjiKV3i5xG02Gw==
X-Received: by 2002:a05:6a00:1388:b0:71d:eb7d:20d5 with SMTP id d2e1a72fcca58-724df5eed0cmr750905b3a.8.1732221944478;
        Thu, 21 Nov 2024 12:45:44 -0800 (PST)
Received: from dw-tp ([171.76.85.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de532d27sm186502b3a.118.2024.11.21.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:45:43 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, Narayana Murty N <nnmlinux@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, maddy@linux.ibm.com, naveen@kernel.org, ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries/eeh: Fix get PE state translation
In-Reply-To: <87cyiq3px0.fsf@vajain21.in.ibm.com>
Date: Fri, 22 Nov 2024 01:26:56 +0530
Message-ID: <87zflswebb.fsf@gmail.com>
References: <20241107042027.338065-1-nnmlinux@linux.ibm.com> <87ttc8d0vf.fsf@gmail.com> <87cyiq3px0.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Hi Ritesh,
>
> Thanks for looking into this patch. My responses on behalf of Narayana
> below:
>
> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
>
>> Narayana Murty N <nnmlinux@linux.ibm.com> writes:
>>
>>> The PE Reset State "0" obtained from RTAS calls
>>> ibm_read_slot_reset_[state|state2] indicates that
>>> the Reset is deactivated and the PE is not in the MMIO
>>> Stopped or DMA Stopped state.
>>>
>>> With PE Reset State "0", the MMIO and DMA is allowed for
>>> the PE.
>>
>> Looking at the PAPR spec - I do agree that it states the same. i.e.
>> The "0" Initial PE state means the "Not Reset", "Load/Store allowed" &
>> "DMA allowed" (Normal Operations). 
>>
>>> The function pseries_eeh_get_state() is currently
>>> not indicating that to the caller because of  which the
>>> drivers are unable to resume the MMIO and DMA activity.
>>
>> It's new to me, but could you help explain the user visible effect
>> of what gets broken. Since this looks like pseries_eeh_get_state() has
>> always been like this when it got first implemented.
>> Is there also a unit test somewhere which you are testing?
> Without this patch a userspace process performing VFIO EEH-Recovery wont
> get the correct indication that EEH recovery is completed. Test code at
> [2] has an example test case that uses VFIO to inject an EEH error on to
> a pci-device and then waits on it to reach 'EEH_PE_STATE_NORMAL' state
> . That state is never reached without this patch.
>
> [2] :
> https://github.com/nnmwebmin/vfio-ppc-tests/commit/006d8fdc41a4
>

Right. Thanks for helping with that test code. It's much clearer now. So
after the error inject and/or the PE hot reset, the PE is never reaching
it's normal state. That is due to this kernel bug in the pseries EEH
handling, where it fails to advertise the MMIO & DMA enabled capability
flag back to the caller. This therefore can cause the userspace VFIO
driver to incorrectly assume that MMIO/DMA operations cannot be done. 

>>
>> IIUC eeh_pe_get_state() was implemented[1] for supporting EEH for VFIO PCI
>> devices. i.e. the VFIO_EEH_PE_GET_STATE operation of VFIO EEH PE ioctl op
>> uses pseries_eeh_get_state() helper to query PE state on pseries LPAR.
>> So are you suggesting that EEH functionality for VFIO PCI device was
>> never enabled/tested before on pseries?
> VFIO-EEH had been broken for pseries for a quite some time and was
> recently fixed in kernel. So this issue was probably not discovered
> until recently when we started testing with userspace VFIO.
>

ohk right, then maybe we might have started testing it after the eeh
error inject op was implemented for pseries here [1].

[1]: https://lore.kernel.org/linuxppc-dev/20240909140220.529333-1-nnmlinux@linux.ibm.com/#t

>>
>> [1]: https://lore.kernel.org/all/1402364517-28561-3-git-send-email-gwshan@linux.vnet.ibm.com/
>>
>> Checking the powernv side of implementation I do see that it does
>> enables the EEH_STATE_[MMIO|DMA]_ENABLED flags in the result mask for
>> the callers. So doing the same for pseries eeh get state implementation
>> does look like the right thing to do here IMO.
>>
>>> The patch fixes that by reflecting what is actually allowed.
>>
>> You say this is "fixes" so I am also assuming you are also looking for
>> stable backports of this? If yes - could you please also add the "Fixes"
>> tag and cc stable?
> Yes, agree will re-send adding the fixes tag.
>

Yes and maybe let's also add some more context & information to the
commit message from this discussion.

-ritesh

>>
>> -ritesh
>>
>>>
>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>> index 1893f66371fa..b12ef382fec7 100644
>>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>> @@ -580,8 +580,10 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *delay)
>>>  
>>>  	switch(rets[0]) {
>>>  	case 0:
>>> -		result = EEH_STATE_MMIO_ACTIVE |
>>> -			 EEH_STATE_DMA_ACTIVE;
>>> +		result = EEH_STATE_MMIO_ACTIVE	|
>>> +			 EEH_STATE_DMA_ACTIVE	|
>>> +			 EEH_STATE_MMIO_ENABLED	|
>>> +			 EEH_STATE_DMA_ENABLED;
>>>  		break;
>>>  	case 1:
>>>  		result = EEH_STATE_RESET_ACTIVE |
>>> -- 
>>> 2.45.2
>>
>
> -- 
> Cheers
> ~ Vaibhav

