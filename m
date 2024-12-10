Return-Path: <linux-kernel+bounces-438839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795C69EA724
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331F328387E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81EF12B169;
	Tue, 10 Dec 2024 04:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls9Vls6o"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D0DF58;
	Tue, 10 Dec 2024 04:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733804311; cv=none; b=qAtoh/BvMJ/7p9hWwu0zi8WskXpds0wv6W8hqFkp8UBrDXjtbKpBvWP1iiMvGEcApFGQfpyLqd0amZsJ+EPZx/XbERq8CZB9aHVmyRFw3tf6WuSJ92Dxhvz5YQWF9ZBaUcZsP3Fcd29qcwAY1T6DEQ2cc38jkc6cN6Cx5FGNT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733804311; c=relaxed/simple;
	bh=4ZCkhNPraCDKu28AwvJToOpYgRXkT9aDvA0dc/npIZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n09xUhqwS1q/Y4Dai8sXPkq4HyeSQSkbKO384NL9ig1/viuTLxj7t4tzK9Qo2Sz/IahLRXNvWukpMlucRnk7IwewaYsEt2/Se117wzJ2hEsTOCetOrsXhQMytyqq37n3f2yGmYKnazmQYQBJcQq5gADXZwtM6q3Ju0Bq8T3Z64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls9Vls6o; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725ed193c9eso1500556b3a.1;
        Mon, 09 Dec 2024 20:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733804309; x=1734409109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WXcmOeBQShSAX9Ttd2+gJlKPqeL3o5FfDr6lZWXZHk=;
        b=Ls9Vls6oTdoLRmrtVGE0AD3UkXCTHdfJB7WtyeOzWrZnWCqI6YoBeBt/rLVoCobjOe
         JdayqiJhp5GZLY9e9fQfWiLrokv0RIcb49W/7I98C9giCxIXdDER+T6byTVETbBxR8a5
         blopf6SQCaXrDCM9Y5dAkOjKCaZIvk1KFmCdDUDYz1mrMImPlPRqYTQN+VHlmY/syltr
         /bmF+G0G8PjBTKIKr1ViCripeTbVaPNnPC74Xb6I22//NF0StSt249ed4j++JCumHz6X
         lYZKWsl6u+0hQAAXSqC6IqPe7Z/GL/TvFLbilH86/i95i4zMa08RGfBN+OnWbODAHckM
         ICGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733804309; x=1734409109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WXcmOeBQShSAX9Ttd2+gJlKPqeL3o5FfDr6lZWXZHk=;
        b=iYa4pH0eezUXZIdXqnDBG90BSyk+D+7eOCcfQo3+pPTsoIPdw619OwnqG+V8mJXJ41
         04r+bZzUiM6rEzeodbfVg6QHyg7Ix5GpZBj2hvLDhsGcfWxxHBLUFxAABQCIPCjUYPeL
         UpRY8DRcOTr2dgQUJXYo8IStDa4GfpL3FD3QpSdtiutPlR69OZHj5OJdITymoN9KNOtI
         UOKa+qVhn6JAMAuaLVhJ1ILqtSUf1kbEYB9KPzT8ToKOa1tcSVPBiKSnAvxiTx78RubG
         HD3eRZJ72HX19/LrZrVhTBiaceBs+7O86+yP6DsP+vjBmihiQPBPjWfVIHt1s51zUdDL
         +ZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMclFCkCKH8U/acneiGD5WNpd5GX2t2EaIb9Nb/aFghDhuqW2/sMYGAMmeOUXYRzAjDiemr2yU0uor3Zuu5MGPmFtY6Q==@vger.kernel.org, AJvYcCUmsRkzvoNPrIWaN26bK0nAeEWGsV3cQ14nme9fNB0QF8HRafkRfZOoLNVas5LdiiXXZ9McDocVLx/thGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpsElWSFQliXXJ9cRxCkC4RK2HS15O5yzjMMSROlPpzkX+/WU
	cSEfuuu0eto3oZMQdtue+qHTPvZ37mWv2u6OJTFKPXVixepaQJoC
X-Gm-Gg: ASbGnctACPL/J4NPj53ZQcev2a6RkiCBx3wwnoNJgDY/rFsXggrZ9+uxHW6Xz+y+Ozc
	t28h9YMUD9PLBffwpUutp2quiX7uAJXlxHsZA+lqkvcpNFE+jmF8SP5afJmJ2bE6uvZwKAtIOLO
	VDCoBjl/08DVCes0yBjCbsOuNIU2BEAQllxK7vc8DQhx9NS8vNx7J9CVsCRiNZoxB7gB783JmOR
	7QGIbNFFOXS3QAb0H1atGo5VHF3LWvVHOwv8RXDJ25bbePAC117y/yKMSBY3Zuy55Ro+hhI1bub
	TIAtOMSLUwu1
X-Google-Smtp-Source: AGHT+IHMJecX0zb8jcSzxSNQsxlN/Tu2MPr6/54CxmZVDGbv2tFVrNX8AsuBsYkI5PB+V88CmLcHZg==
X-Received: by 2002:a05:6a00:22c6:b0:725:9edd:dc30 with SMTP id d2e1a72fcca58-7273cb1af91mr4521788b3a.12.1733804308675;
        Mon, 09 Dec 2024 20:18:28 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d911615asm4818304b3a.147.2024.12.09.20.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:18:28 -0800 (PST)
Date: Tue, 10 Dec 2024 01:18:24 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] platform/x86: acer-wmi: Improve error handling
 when reading gaming system information
Message-ID: <z4big77gnqc5q2tvhv3oupzzycp7lsofogs3tzozr3fd2pqkyr@ouospkvcsxj7>
References: <20241210001657.3362-1-W_Armin@gmx.de>
 <20241210001657.3362-4-W_Armin@gmx.de>
 <i4jcyhqxfugfykbtvrwba4udln4l2cgk7zgj3sy7iqncf47a4q@exk6jk7rmmvk>
 <51dba8ab-b268-40ae-b005-87a5d0ab0566@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51dba8ab-b268-40ae-b005-87a5d0ab0566@gmx.de>

On Tue, Dec 10, 2024 at 05:08:01AM +0100, Armin Wolf wrote:
> Am 10.12.24 um 03:06 schrieb Kurt Borja:
> 
> > On Tue, Dec 10, 2024 at 01:16:55AM +0100, Armin Wolf wrote:
> > > If a call to ACER_WMID_GET_GAMING_SYS_INFO_METHODID fails, the lower
> > > 8 bits will be non-zero. Introduce a helper function to check this and
> > > use it when reading gaming system information.
> > > 
> > > Tested-by: Rayan Margham <rayanmargham4@gmail.com>
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   drivers/platform/x86/acer-wmi.c | 55 +++++++++++++++++++++------------
> > >   1 file changed, 36 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> > > index dd57787466b9..ac4500f33b8c 100644
> > > --- a/drivers/platform/x86/acer-wmi.c
> > > +++ b/drivers/platform/x86/acer-wmi.c
> > > @@ -70,6 +70,7 @@ MODULE_LICENSE("GPL");
> > > 
> > >   #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54
> > > 
> > > +#define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)
> > >   #define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
> > > 
> > >   /*
> > > @@ -1513,6 +1514,24 @@ static acpi_status WMID_gaming_get_u64(u64 *value, u32 cap)
> > >   	return status;
> > >   }
> > > 
> > > +static int WMID_gaming_get_sys_info(u32 command, u64 *out)
> > > +{
> > > +	acpi_status status;
> > > +	u64 result;
> > > +
> > > +	status = WMI_gaming_execute_u64(ACER_WMID_GET_GAMING_SYS_INFO_METHODID, command, &result);
> > > +	if (ACPI_FAILURE(status))
> > > +		return -EIO;
> > > +
> > > +	/* The return status must be zero for the operation to have succeeded */
> > > +	if (FIELD_GET(ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK, result))
> > > +		return -EIO;
> > > +
> > > +	*out = result;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static void WMID_gaming_set_fan_mode(u8 fan_mode)
> > >   {
> > >   	/* fan_mode = 1 is used for auto, fan_mode = 2 used for turbo*/
> > > @@ -1762,22 +1781,23 @@ static int acer_gsensor_event(void)
> > > 
> > >   static int acer_get_fan_speed(int fan)
> > >   {
> > > -	if (quirks->predator_v4) {
> > > -		acpi_status status;
> > > -		u64 fanspeed;
> > > +	u64 fanspeed;
> > > +	u32 command;
> > > +	int ret;
> > > 
> > > -		status = WMI_gaming_execute_u64(
> > > -			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
> > > -			fan == 0 ? ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED :
> > > -				   ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED,
> > > -			&fanspeed);
> > > +	if (!quirks->predator_v4)
> > > +		return -EOPNOTSUPP;
> > > 
> > > -		if (ACPI_FAILURE(status))
> > > -			return -EIO;
> > > +	if (fan == 0)
> > > +		command = ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED;
> > > +	else
> > > +		command = ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED;
> > > 
> > > -		return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
> > > -	}
> > > -	return -EOPNOTSUPP;
> > > +	ret = WMID_gaming_get_sys_info(command, &fanspeed);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
> > >   }
> > I wonder if it's necessary to refactor this function if you are going to
> > drop it on Patch 4.
> 
> I did it so each patch has a single well-defined scope. And refactoring this function was necessary for
> the patch being complete.

I'll keep that in mind when submitting.

In that case:

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

I apologize If this was out of place, as I'm still learning!

~ Kurt

> 
> Thanks,
> Armin Wolf
> 
> > >   /*
> > > @@ -1942,12 +1962,9 @@ static int acer_thermal_profile_change(void)
> > >   			return err;
> > > 
> > >   		/* Check power source */
> > > -		status = WMI_gaming_execute_u64(
> > > -			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
> > > -			ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS, &on_AC);
> > > -
> > > -		if (ACPI_FAILURE(status))
> > > -			return -EIO;
> > > +		err = WMID_gaming_get_sys_info(ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS, &on_AC);
> > > +		if (err < 0)
> > > +			return err;
> > > 
> > >   		switch (current_tp) {
> > >   		case ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO:
> > > --
> > > 2.39.5
> > > 

