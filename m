Return-Path: <linux-kernel+bounces-289000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5520E954119
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8800A1C235F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ABB7E0E9;
	Fri, 16 Aug 2024 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nefMuZMT"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916B77F1B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785863; cv=none; b=nlDLsuVtGL8Wt9BRlXVfeJCO+4xEoddMq6iFZ4+JJwuoh3HUlqrSxJW1hiXqVlXBv84TkbdIIqXGtrJwySWW24rYULFe8ZiVVWwx5a0w4gMi2UntceGa38ywYqGsTFbF6TAC0jtsnIA6ZKHujz9UT5hV/JbHMhvfUkqhx9EtezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785863; c=relaxed/simple;
	bh=IAD4Ng0J5zz3wi4ezGMVrCJzBG1aq3TvHsJccVDi9c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyYZ+vbA0gv8wXJFy/ZOjb7pRrbujSnxBhv6Z9guGQgmOnzLDwmf44i4wEW6Kmd3hB/WGErtVlqzSVZjSV0s/BBCN0M8lCNzDAo5BDY+gLo6+l4eJgP8HZ2kwi6leEqUeAisQHS1DZzw6+Vq6zYAi8KXq6VSHkAwJbfi0F4QyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nefMuZMT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7105043330aso1499619b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723785860; x=1724390660; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cWvqN8L9T4VZ6SwiImV1tS1PClTOGw7HuC117PJzjSA=;
        b=nefMuZMT5Lo3E1jMZ2Iqf9GMCtg/DwjddWyfaCgxKnTdSU+IUv7aN/Y76izAOlSZlf
         BgeciwRJ6bvgJ5R8ajn4e2i861TWmNi71AlWuHbF+X4R6Wr3CbgYIE3dIdvVr0TG1h+7
         q2vZMxtu+752HWDgRWxVR94GyTwUDJlgKEKX7K2O/pMr9O56swOjPZ2eS3/Wu8UoJNs3
         jqp+i1tW7G4ou4NJkQXJjVshisz9NC3lfr9fNuwimGCBEkrPdqtJR9S/sOK8Xol6dWN4
         elyYrmBV0diM15BZEUxn61vVn+zRQQXQ8bPA0mysO4nCYBDj+vQHyUEaKuGsxprBHhdQ
         5hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723785860; x=1724390660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWvqN8L9T4VZ6SwiImV1tS1PClTOGw7HuC117PJzjSA=;
        b=ZLzZMuSGlK9QMJZPFqFZ+gADpjjoRPOk9IjGEMTGRpOjuuP6rs3KHJfgLGA4E4A/kE
         Ic+QT19oSLLuWGTLMSxzscaJ2o1u8tzvCQVjyUwIG4iXFFP5tr7deHc0+JvVi5SJCWZF
         Iy3hdmj+KWM7iD7dWVd/f4bjPp9r7VDcluUdsN0uoACZ1VpZ//8Gb0AMuK8AWSN9vGwh
         NOpnLd5I6/DF3KdYg4bQIMCIIXZ/+I1QYhpBCSa0MPLOjqPlLGbxZwcGdOQooaCIygdU
         iZTbCrujetPqllCfCcKZ2T/ebF3mBaNKw9ow9zNpjxBBM6501AcJjkG3mxnD6LT32avn
         0N6w==
X-Forwarded-Encrypted: i=1; AJvYcCUD7SYGhFAsBiAOGQb6vJKxaAkS1k06ZqTWqZMZ2/5XShNSM2h9f3pmCulUgj/lOXedWysr2dd/kBi8gar8kJHqkHunhXo0ce5Qoqvs
X-Gm-Message-State: AOJu0Yyo4L9HXpmDGclmpe5g6//Yz1xQLkzm/lQMprxVxpPE3XsYYy9m
	J1txa+WWe2EgYle23Fx3tpmPHYwQeQ5aAihU44w9gMZlqK/jTggABjislIdN7Q==
X-Google-Smtp-Source: AGHT+IF+/eZuzaCI6HM490oe/E+8yN4V1wgPcX0TKQlnWBZOqOGaPmvWzefXzToBBiZPaWJyrTa+pA==
X-Received: by 2002:a05:6a00:99a:b0:70a:fb91:66d7 with SMTP id d2e1a72fcca58-713c4efbff8mr2435861b3a.20.1723785859871;
        Thu, 15 Aug 2024 22:24:19 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e9acsm1868956b3a.82.2024.08.15.22.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 22:24:19 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:54:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Kyoungrul Kim <k831.kim@samsung.com>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 2/3] ufs: core: Add a quirk for handling broken LSDBS
 field in controller capabilities register
Message-ID: <20240816052414.GC2331@thinkpad>
References: <20240815-ufs-bug-fix-v2-0-b373afae888f@linaro.org>
 <20240815-ufs-bug-fix-v2-2-b373afae888f@linaro.org>
 <f79a87ba-4d2d-42f0-ab94-1e6821a482f2@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f79a87ba-4d2d-42f0-ab94-1e6821a482f2@acm.org>

On Thu, Aug 15, 2024 at 11:25:38AM -0700, Bart Van Assche wrote:
> On 8/14/24 10:16 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index 0b1787074215..8c9ff8696bcd 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -2426,7 +2426,11 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
> >   	 * 0h: legacy single doorbell support is available
> >   	 * 1h: indicate that legacy single doorbell support has been removed
> >   	 */
> > -	hba->lsdbs_sup = !FIELD_GET(MASK_LSDBS_SUPPORT, hba->capabilities);
> > +	if (!(hba->quirks & UFSHCD_QUIRK_BROKEN_LSDBS_CAP))
> > +		hba->lsdbs_sup = !FIELD_GET(MASK_LSDBS_SUPPORT, hba->capabilities);
> > +	else
> > +		hba->lsdbs_sup = true;
> > +
> >   	if (!hba->mcq_sup)
> >   		return 0;
> 
> An additional question: since the next patch only sets
> UFSHCD_QUIRK_BROKEN_LSDBS_CAP for a board with a UFSHCI 3.0 controller,
> do we really need the new quirk or can we replace the "!(hba->quirks &
> UFSHCD_QUIRK_BROKEN_LSDBS_CAP)" test with a test that verifies that the
> UFSHCI controller implements version 4.0 or later of the specification?
> 

Ok. First I made a mistake by believing that SM8550 is a 3.0 based controller.
But by looking into the internal documentation, I learned that it is a 4.0
controller without MCQ support. So version check is not possible (and I need to
fix the description as well).

Also, while looking into the version info I found that the Qcom driver sets
UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION quirk and the callback function
get_ufs_hci_version() just hardcodes the version to 2.0. But the recent SoCs do
reveal the UFSHCD version info correctly in REG_UFS_VERSION register. So the
quirk might only be applicable for 2.0 controllers (not sure if those are
supported now). Will check that and remove that quirk altogether.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

