Return-Path: <linux-kernel+bounces-323760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F04CC974310
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810831F27CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66F1ABEB8;
	Tue, 10 Sep 2024 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPwWYrtg"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC01AB525
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995231; cv=none; b=L/hKtmklrfqVzGcq2qgvEVo1uy/FDg06sTHaxtWnlZhkngbO+Z1ucNsXLD27AyWklkPJOmMSceyyKS+d9H5i069PI/0AslbJ22sj1T3igXrT5RQ5y1IWi6SBTk4o7O21RccXqH0/tOETMOihMu48ud9KHoVqYWRwJ3SLI7FAjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995231; c=relaxed/simple;
	bh=/fPvS6tHaPYkd+ieklVpLMDzeZI3SXacgyA3mGQdBfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gsl6qQBCCjKvx21otlyt3ULVCgg9STfWSWzCZAqFDPgslkiGvzJaTFav+bUGf1rfwq4tnjdb9G46TMWfpIPi2R7I6nBJ611Ka88yfOoyveXzjvE/2N4YenQ6Z+oqA4bd7rLoSVUFxzvVR16jE5D37zBLy7XkmANbGFYdv0Buzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPwWYrtg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7163489149eso4817079a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725995228; x=1726600028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6lOiIJ4Mc69h2PNQojh4dfRelmJgPkTSzYXUp3tv+n8=;
        b=OPwWYrtg+pkopth4oI/grimU7EAsxvUP2xE8EmJfklUOTym/7SG5pL/WjcioC2OKwf
         ZGIrm7V0O0kx2EAoESaD1Bp8zYUILD2eNp8s28XcWcbDM8KiE8pXbcM2XxnaR81IUm3a
         jFTGpeqA5ES08Yuq5W7cep6VCsWIZOzgXK+CP2VEOtv48K+AdXqd+Tisdtin0L96eXEq
         K7uY9AvUoN8zCUYgwaXPTBCAGs2uVhO+6i7rQDMQ5OJ1hFrwZJihbvl/Q6fNZiGsV1wg
         BXSQJq2Q0scUkvKGOmDcofNL/ZUUp7pH77X8BtSejW2gepSqNeiudY5/m99NTi+B2exC
         zGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995228; x=1726600028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lOiIJ4Mc69h2PNQojh4dfRelmJgPkTSzYXUp3tv+n8=;
        b=p3ezD05yGwObNBeI8pQrhC8FAh+rdEaz4/0gyAm2dLXHX719AqEf5BgFstYFTnX8RF
         92cTOsArTtdwED9gFiaS3Z1tmO0BL04j9SELm4YeJ9834kR48YjpC1iYGUfUYBislS1L
         wvJXZ5QpaCp7D54K4FR4eRrfHCumrnWo8jNYKGC3Rajds2iD+fRllRTWtzghMoT6zakh
         9rashrqeNo/1rQbrHXQGcqsMwsYwsdByxuA5VYuWdDTD8FpVaKdpwQaScW6w/reZL1Bx
         9qJYD9xMQkJW6/wJ8NPD/+s+sxhzeIpmWHjVlLNuZvaRLF528H0Kp6z3y3sQlGrCyYT5
         wfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPQiqoxmOlwwWnH+JSAplci+60I08903RgNc4qBEY4eKXuJfcC7e7oHEHM+26oyNm+D6E9cfz7mG0zF94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy/Oro3TyixMkf9Bb01bV820cPDTuuKDiwSnTdtjjxsQf0mPNk
	ecVUoQb7C9IDesHr+ePET6f2lh1lX9dU/GyAbK68VlsbBj8NCdV6
X-Google-Smtp-Source: AGHT+IFh7ypVlg+pkVmteXSfq34hnWWEiP32lthCK2Pt8J4txP0R/BlbvzOq3InKFv3MpF58XUjruQ==
X-Received: by 2002:a17:902:ec8e:b0:205:4885:235e with SMTP id d9443c01a7336-2074c70dac2mr18657265ad.39.1725995227605;
        Tue, 10 Sep 2024 12:07:07 -0700 (PDT)
Received: from debian ([103.57.174.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1e29asm51657045ad.214.2024.09.10.12.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 12:07:07 -0700 (PDT)
Date: Wed, 11 Sep 2024 00:37:01 +0530
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, sayyad.abid16@gmail.com
Subject: Re: [PATCH v2] staging: rtl8723bs: Fix coding style issues in the
 hal_pwr_seq.h
Message-ID: <ZuCY1Tuog1sFHLBQ@debian>
References: <20240910121144.635348-1-sayyad.abid16@gmail.com>
 <89893a22-5018-4ae0-b4f9-e473a36f09b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89893a22-5018-4ae0-b4f9-e473a36f09b6@gmail.com>

On Tue, Sep 10, 2024 at 08:47:54PM +0200, Philipp Hortmann wrote:
> On 9/10/24 14:11, abid-sayyad wrote:
> > Improving the code readability and coding style compliance of the code.
> > Running checkpatch.pl on the file raised coding style warnings:
> > -The comment block needs "*" on all lines of the block
> > from line 8 to 26
> > -Use tabs for indent
> > on line 103 and 115
> >
> > Applying the patch fixes these coding style issues and makes the code more
> > readable/developer friendly.
> >
> > Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
> > ---
>
> Hi Abid,
>
> I cannot apply your patch. Are you using the right git repo?
>
> git remote show origin
> * remote origin
>   Fetch URL:
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> ...
> git branch -a
> my branch: staging-testing
>
>
> kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ mutt
> Applying: staging: rtl8723bs: Fix coding style issues in the hal_pwr_seq.h
> error: patch failed: drivers/staging/rtl8723bs/include/hal_pwr_seq.h:101
> error: drivers/staging/rtl8723bs/include/hal_pwr_seq.h: patch does not apply
> Patch failed at 0001 staging: rtl8723bs: Fix coding style issues in the
> hal_pwr_seq.h
>
I found the issue, I have been amending these changes on the mainline repo,
  $ git remote show origin
* remote origin
  Fetch URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

  I need to clone the staging branch.
> Please also change your Description. Concentrate on why this patch makes
> sense. Do not describe the patch. What is changed can be seen below. Please
> also use the correct time.
>
I did not understand the correct time here. could you please
elaborate a little on this please.
> You can find accepted examples in the git repo.
>
I'll look into the accepted patches right now. Meanwhile I have this question
, descriptions addressing only the coding style issue fixes are acceptable or
it needs to be having somethingelse too? (apologies in advance for
this illy question)
> Thanks for your support.
>
> Bye Philipp
>
Thank Youy for your feedbacks
>
>
> > changes since v1:
> > v2: Fix the email body, amke it more informative
> > link to v1:
> > https://lore.kernel.org/all/ca1908f3-74aa-45e7-a389-3995aba2660c@gmail.com/
> >   .../staging/rtl8723bs/include/hal_pwr_seq.h   | 46 +++++++++----------
> >   1 file changed, 23 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/include/hal_pwr_seq.h b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
> > index 5e43cc89f535..10fef1b3f393 100644
> > --- a/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
> > +++ b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
> > @@ -5,26 +5,26 @@
> >   #include "HalPwrSeqCmd.h"
> >
> >   /*
> > -	Check document WM-20130815-JackieLau-RTL8723B_Power_Architecture v08.vsd
> > -	There are 6 HW Power States:
> > -	0: POFF--Power Off
> > -	1: PDN--Power Down
> > -	2: CARDEMU--Card Emulation
> > -	3: ACT--Active Mode
> > -	4: LPS--Low Power State
> > -	5: SUS--Suspend
> > -
> > -	The transition from different states are defined below
> > -	TRANS_CARDEMU_TO_ACT
> > -	TRANS_ACT_TO_CARDEMU
> > -	TRANS_CARDEMU_TO_SUS
> > -	TRANS_SUS_TO_CARDEMU
> > -	TRANS_CARDEMU_TO_PDN
> > -	TRANS_ACT_TO_LPS
> > -	TRANS_LPS_TO_ACT
> > -
> > -	TRANS_END
> > -*/
> > + *	Check document WM-20130815-JackieLau-RTL8723B_Power_Architecture v08.vsd
> > + *	There are 6 HW Power States:
> > + *	0: POFF--Power Off
> > + *	1: PDN--Power Down
> > + *	2: CARDEMU--Card Emulation
> > + *	3: ACT--Active Mode
> > + *	4: LPS--Low Power State
> > + *	5: SUS--Suspend
> > + *
> > + *	The transition from different states are defined below
> > + *	TRANS_CARDEMU_TO_ACT
> > + *	TRANS_ACT_TO_CARDEMU
> > + *	TRANS_CARDEMU_TO_SUS
> > + *	TRANS_SUS_TO_CARDEMU
> > + *	TRANS_CARDEMU_TO_PDN
> > + *	TRANS_ACT_TO_LPS
> > + *	TRANS_LPS_TO_ACT
> > + *
> > + *	TRANS_END
> > + */
> >   #define	RTL8723B_TRANS_CARDEMU_TO_ACT_STEPS	26
> >   #define	RTL8723B_TRANS_ACT_TO_CARDEMU_STEPS	15
> >   #define	RTL8723B_TRANS_CARDEMU_TO_SUS_STEPS	15
> > @@ -101,7 +101,7 @@
> >   	{0x0007, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x20}, /*0x07 = 0x20 , SOP option to disable BG/MB*/	\
> >   	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, BIT3}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
> >   	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT2, BIT2}, /*0x04[10] = 1, enable SW LPS*/	\
> > -        {0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 1}, /*0x48[16] = 1 to enable GPIO9 as EXT WAKEUP*/   \
> > +	{0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 1}, /*0x48[16] = 1 to enable GPIO9 as EXT WAKEUP*/   \
> >   	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*0x23[4] = 1b'1 12H LDO enter sleep mode*/   \
> >   	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, BIT0}, /*Set SDIO suspend local register*/	\
> >   	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, 0}, /*wait power state to suspend*/
> > @@ -112,7 +112,7 @@
> >   	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3 | BIT7, 0}, /*clear suspend enable and power down enable*/	\
> >   	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, 0}, /*Set SDIO suspend local register*/	\
> >   	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, BIT1}, /*wait power state to suspend*/\
> > -        {0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0}, /*0x48[16] = 0 to disable GPIO9 as EXT WAKEUP*/   \
> > +	{0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0}, /*0x48[16] = 0 to disable GPIO9 as EXT WAKEUP*/   \
> >   	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, 0}, /*0x04[12:11] = 2b'01enable WL suspend*/\
> >   	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*0x23[4] = 1b'0 12H LDO enter normal mode*/   \
> >   	{0x0301, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0},/*PCIe DMA start*/
> > @@ -209,7 +209,7 @@
> >   #define RTL8723B_TRANS_END															\
> >   	/* format */																\
> >   	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
> > -	{0xFFFF, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, 0, PWR_CMD_END, 0, 0},
> > +	{0xFFFF, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, 0, PWR_CMD_END, 0, 0},
> >
> >
> >   extern struct wlan_pwr_cfg rtl8723B_power_on_flow[RTL8723B_TRANS_CARDEMU_TO_ACT_STEPS+RTL8723B_TRANS_END_STEPS];
> > --
> > 2.39.2
> >
>

