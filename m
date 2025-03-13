Return-Path: <linux-kernel+bounces-559725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222CDA5F890
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F1B178293
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527E7267F70;
	Thu, 13 Mar 2025 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="D6qPpum9"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD62676CA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876597; cv=none; b=Fyb/M3eTno6Xz/aKT+O8LP6kPAXA7OjUtvwT+K8qE6HEdb+AR+F6EXFWAeGtDHjIkODZ92BBYpBau6sHKi/M9a4jeOrisWZ/MnOtPY4SS2gLni8Mc+fr0SeJTMPuNexwxRzawX+fl5R1/cS3HfY3vXvetnNpobMqgP/0C1mDsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876597; c=relaxed/simple;
	bh=kpdGqB7sRL5WIstUzPvOeT4l/Yq+5vIRdCZmu1RHyOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5cjidYfxAOzHvS2JJ1r9GfmsyJXRA2C+vEL+3CzSgux2GbseWV2CbOMBM+crdFnUxxwK3G3eDw0SGNBvDnwg4eFVBuszQgZ1968hrlJ5V6aShA2yTsczfCq1CQkSS8HGqtgmKAPbxKTRZvdm5E59v9KNH0XI4UARCa9xhLeoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=D6qPpum9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c08b14baa9so74807685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741876595; x=1742481395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+GC/kQTwmLeftS0ziJ99XGRNFCxec8W85lzFkXDKks=;
        b=D6qPpum9gdzy+IMEFk92CTDy7CDq6ZC1Hee39DEIunEg3UCjElH9x9SVbuV87Na9SO
         +edc8BdHaLqnAjATTyEAtiQ0wGhUujxL9vScIPd8dPUKQnMgbtGYi786Jqyc8V5BiCcu
         eRTtwFd4d98JLNjB798hg+f2bCx54WUCOWju+8V/Ei6J9f3qV/N27tHbvIo1SHGn0YG5
         /jCvYn8adcSq5yOV0/vaagmBuT9D2TM4n6ZHOSzgS+ypVTjQfjgZ+VwAixaY7nr8R8Cp
         wUPOknZF1fHAnK2Spcq/vkRY874+zz99XHkOcRBibCBUMB4fwLAET1exVf00HYFZW5Sy
         3Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876595; x=1742481395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+GC/kQTwmLeftS0ziJ99XGRNFCxec8W85lzFkXDKks=;
        b=ZRA5OOkoxIQREPV7PwbwR8CKryj6jcdAufyb9Do9amQIs86xBPPKzjfFZEafPObA3S
         uPZBiSRnBZg1CcZbDDFfeTaxlEMR+i4mWPSkfn305s6kTZOIxRWJGnDKBeiSUJHcQyIZ
         qOjdkIeYkW6i2KwMUgdBCgtnngyInT8UC8lhKuDg+mk1JgfmtnAdjOlzfO304QHKVrFz
         VIl1115brC7D8uKBQ+ow++EYxB7zhhMtyV8Vn/BoyNNP58Cu2Gw0D1MsTk7f3HaC/+FL
         ixrFGQ+l04CdMTVAhtcNJwjhxNZh0glhb06tk4vDb4mDB9d9y++OqlxRcf1pCLLm40Cq
         ZXCg==
X-Forwarded-Encrypted: i=1; AJvYcCU6ITQQ/cO7PbjFx+PstH30G/Ix2H6/c8gjntGJg4PVDTSVOO7dDJ6h7w+DnC6NF9AK90ZA1p0UfjW6XOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ/pShOr+nrcQrXY1KETkyLHrwSgaqlGuwiZ9X3fWB6ioUd3Qj
	twEk1apLgat08liCfwXYwKVUF5ftlbrOP3HYT8aZcp+hQxCaxTmHHX1nv0C2tQ==
X-Gm-Gg: ASbGncs64azVvY/msUyxc4N2P3+vFnC/EczRtAsUX6t8LcvLQ91/OjDKNhSlhuJ6E69
	Nf4rkhucygHoiszr/b4mWRk7shO/v0g4rwJ2tEL3A+P3UIS88EQsCBl78t8drzTLQTO+7kx/nFU
	6gm4C+62FzLIvHnGSD6P++Y+2Qq8CS65m19AohytDq7ABs80JXohr/2wv1/jmslV8JqQIcrtqrU
	7WNcye22aOXCAe+QiQ2Jukth7t0uasWwXgsqJPbJIgVlGTOaOPMdl68LT20gqjBp4eIvyt2Dayq
	KLL2e4Lkr8o70NDB+cI5DbDHe+7rtx4y9HhpCaS25JpcgOf6e7pWiFT4fQjvWrE=
X-Google-Smtp-Source: AGHT+IElO+1ztaV5m+hivSUVgmImy/dTi1GJRC9PcO0ahEH42X8dkNaJACuepjN4sI//XopSPmMOQA==
X-Received: by 2002:a05:620a:439f:b0:7c5:6396:f161 with SMTP id af79cd13be357-7c56396fac3mr1848651985a.49.1741876594973;
        Thu, 13 Mar 2025 07:36:34 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89b9asm104149985a.99.2025.03.13.07.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:36:34 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:36:32 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: daixin_tkzc <daixin_tkzc@163.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	matthew dharm <mdharm-usb@one-eyed-alien.net>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH] usb: storage: Fix `us->iobuf` size for BOT transmission
 to prevent memory overflow
Message-ID: <814316b6-013b-4735-995d-b6c0c616c71b@rowland.harvard.edu>
References: <20250311084111.322351-1-daixin_tkzc@163.com>
 <2b6c4aa7.b165.1958f6b7a3a.Coremail.daixin_tkzc@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6c4aa7.b165.1958f6b7a3a.Coremail.daixin_tkzc@163.com>

On Thu, Mar 13, 2025 at 08:12:20PM +0800, daixin_tkzc wrote:
> Thank you for reviewing my patch.
> 
> 
> I'm sorry I just responded individually.
> 
> 
> Of course, when the USB device and host are transmitting normally, us->iobuf size is 64, which is enough for CBW/CSW and there will be no problem. 
> Howerver, we encountered a problem in the FPGA verification environment, that is, the DWC otg controller detected a Babble Error, and we believe that the processing flow of the device driver will cause the risk of us->iobuf overflow. 
> 
> 
> Regarding USB Babble Error, the DWC_otg_programming manual describes it as follows:
> |
> 
> 3.8.1 Handling Babble Conditions
> 
> DWC_otg handles two cases of babble: packet babble and port babble. Packet babble occurs if the device sends more data than the maximum packet size for the channel. Port babble occurs if the controller continues to receive data from the device at EOF2 (the end of frame 2, which is very close to SOF).
> 
> When DWC_otg detects a packet babble, it stops writing data into the Rx buffer and waits for the end of packet (EOP). When it detects an EOP, it flushes already-written data in the Rx buffer and generates a Babble interrupt to the application
> 
> |

What is your point?

Are you claiming that the DWC_otg driver doesn't handle packet babble 
properly?  If that is true then you need to fix the DWC_otg driver, not 
change the usb-storage driver.

You have not done a good job of explaining how us->iobuf overflow could 
occur.

Alan Stern

