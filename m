Return-Path: <linux-kernel+bounces-292657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B2E957267
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5948B2444B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E7E18800B;
	Mon, 19 Aug 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCQATrkW"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602B14F12F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089838; cv=none; b=fGcC/OVtt3Ip8ZBRKCv3J7vfOE72Bks7uvRO2ggmkOhs+3peuv1/9MmUDM38/HxdeVlbdZfHswbHYeSnFUMDUBRj+dARqDPFRN5KD9khHcAW8AopzfXESn0b643G0j1PZPLYMBDjLJFkdZ+PXUSnBmxE+Zc6ZefRMVs+t+Qtj7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089838; c=relaxed/simple;
	bh=w/Fwcmt6wzBhQKj8NSEi6L2yI3ryj/IbNsRhMAgKF98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEaVM0kuLsXHOJZ0sONNIEw/+ksRYOSWS1ZRK7hUjcrpZk7ZAldVulXwUV+kRgEhpqzjjEMRDrbAXQVnZlxGtWYit3zb8cI+zisGQ2S+AIO0GebZoaUhf1nu/X560yASrMzfu7+fA8Dbg+tw1e/0yygWinryOIaaZ8jkRjzfER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCQATrkW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2021537a8e6so25243295ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089836; x=1724694636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOf43rLdvXlX2YVrcERQm/M+ITZnbYWg68aFZLl8QSU=;
        b=UCQATrkWYmkIoWmiQYHPtRba/mOgsdDk+HB2z4SJREhNUgPv7KvxJkvKUvDEsST13G
         vf0gLhbVsDDwGfVXUNqIROBjCGxbKE6v09ygEso2Y5Vr8OLFexLmmHeGJyJce4WSOxVv
         GkGqdBfEODgwfkXpgwAW3NfOy581ZlcnORs7IKwQAB6+DISaWcGQOPuybbXd684qtWUI
         wSe+HddLjmeG8t9PIdxRC0eLEqMMaWapdMw2rfc7kgRUHzJKAN1MUYTLQ+2USamP9OAP
         W6wQZGPyfbcb++sV2tn1qgE3mneK9EQLyyuvT3EwVNHjeMogBZif2zXHIhpNxKX5CRCQ
         aRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089836; x=1724694636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOf43rLdvXlX2YVrcERQm/M+ITZnbYWg68aFZLl8QSU=;
        b=cnb5L2Kz8lb8CnlJKuQ2NE3i1BWawVaYpUsUUDG8sYsoxDtXrC9dfXgm9f4o6b5xPr
         YzKmeluxR83ISBkCd21kRx28dULMYcnXx7VPNsDcWNTyPaLawcAnXUOqA5kw9eUPwNnS
         MbVKg9G4zjWq8vFaW+WSXOhN1SlDhfZS1C05Lz962b/ACROPeGP3ln3e4/mD80DaQjR4
         V+KxfQxB7cH+VQF6cP9/4VC7J/8DT0xeJv2ggv+B7lcI54j8pWhOj3IH8KGEea/c7pwS
         P3CtrGIhGPhHR+fJNjr1gi2Hv2StNgNnLep6EDj9eV4FU9iPYc8HQhnbs/B/8KPKjZii
         Kf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAtRkZWi22aNJB4D8OyaRfxe4kWF+MMAjcO2p1ChR3NXJrzeIT3aLOhhF8jFrTD0DH3OOFVGREvxjGF6kvjSZSrfxtzGYXjlZ7DOn/
X-Gm-Message-State: AOJu0Yx8iBiuiLfZ78Gzr3tBpjBOwcO7lx52wxgMOAs7iOk/Q9S3m15i
	GBlwmdQcpqEBqS2hOLSxPAEH/+0WJ/MwXBCw91gCRoJIA3WjB8JT
X-Google-Smtp-Source: AGHT+IHthh45koxlcqVb51AsdJSIiP+ADIZPw47JXoa3D6QFq1yXv+bLoH3499/vUQxg94w0/AWJPw==
X-Received: by 2002:a17:902:d2c2:b0:202:5ac:fa49 with SMTP id d9443c01a7336-20205acfb5fmr141255095ad.51.1724089836004;
        Mon, 19 Aug 2024 10:50:36 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.231.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fa4e0sm65064025ad.7.2024.08.19.10.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:50:34 -0700 (PDT)
Date: Mon, 19 Aug 2024 23:19:20 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: neil.armstrong@linaro.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: ili9341: Add comments for ILI9341 register
Message-ID: <ZsOFoP+NR/pGNC5M@embed-PC.myguest.virtualbox.org>
References: <20240812171019.561321-1-abhishektamboli9@gmail.com>
 <b783f932-851f-4ea5-a2cc-d39061c60652@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b783f932-851f-4ea5-a2cc-d39061c60652@linaro.org>

Hi, Neil
Thanks for the feedback.

On Mon, Aug 19, 2024 at 05:41:07PM +0200, neil.armstrong@linaro.org wrote:
> On 12/08/2024 19:10, Abhishek Tamboli wrote:
> > TODO : Add missing comments for ILI9341 register definition.
> 
> Please rephrase the commit message, and explain why in a proper english sentence.
Sure
> Neil
> 
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> >   drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 14 +++++++-------
> >   1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> > index 775d5d5e828c..cba6a6952568 100644
> > --- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> > +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> > @@ -121,19 +121,19 @@ struct ili9341_config {
> >   	const struct drm_display_mode mode;
> >   	/* ca: TODO: need comments for this register */
> >   	u8 ca[ILI9341_CA_LEN];
> > -	/* power_b: TODO: need comments for this register */
> > +	/* power_b: Power control B (CFh) */
> >   	u8 power_b[ILI9341_POWER_B_LEN];
> > -	/* power_seq: TODO: need comments for this register */
> > +	/* pdtcaower_seq: Power on sequence control (EDh) */
> >   	u8 power_seq[ILI9341_POWER_SEQ_LEN];
> > -	/* dtca: TODO: need comments for this register */
> > +	/* dtca: Driver timing control A (E8h) */
> >   	u8 dtca[ILI9341_DTCA_LEN];
> > -	/* dtcb: TODO: need comments for this register */
> > +	/* dtcb: Driver timing control B (EAh) */
> >   	u8 dtcb[ILI9341_DTCB_LEN];
> > -	/* power_a: TODO: need comments for this register */
> > +	/* power_a: Power control A (CBh) */
> >   	u8 power_a[ILI9341_POWER_A_LEN];
> >   	/* frc: Frame Rate Control (In Normal Mode/Full Colors) (B1h) */
> >   	u8 frc[ILI9341_FRC_LEN];
> > -	/* prc: TODO: need comments for this register */
> > +	/* prc: Pump ratio control (F7h) */
> >   	u8 prc;
> >   	/* dfc_1: B6h DISCTRL (Display Function Control) */
> >   	u8 dfc_1[ILI9341_DFC_1_LEN];
> > @@ -147,7 +147,7 @@ struct ili9341_config {
> >   	u8 vcom_2;
> >   	/* address_mode: Memory Access Control (36h) */
> >   	u8 address_mode;
> > -	/* g3amma_en: TODO: need comments for this register */
> > +	/* g3amma_en: Enable 3G (F2h) */
> >   	u8 g3amma_en;
> >   	/* rgb_interface: RGB Interface Signal Control (B0h) */
> >   	u8 rgb_interface;
> > --
> > 2.34.1
> > 
Regards,
Abhishek

