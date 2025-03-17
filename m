Return-Path: <linux-kernel+bounces-563319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA00A63D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10ED33AD889
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE41158553;
	Mon, 17 Mar 2025 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZldeXPYy"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F113A88A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742183731; cv=none; b=Dgrnt9a7twRGNl+9MH9imtWhAv63Wd7ZeTf/PAZvUQJAEvAo/NcMR7xMcWdHg3gK7lLjvlPGEQuXgIml1yUxl/JLP85d7/f4myXJfwIZ8WZs9ReJN0Z6g3ubuOhsgaZfmHhfLE1GoxW8X+y97lb3zUOuiPQgs+WpzvJ3FypwX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742183731; c=relaxed/simple;
	bh=hXHELc8xnpl+q7yyJCE/ro7GYj3uJ/qOkojU06P1S78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqGKGU/tuDFdU1olzBrSCd6kzy6Sg1P6SDV7H60/Q5Oi9gou8eNdvXZxT3m7WPRAjPh1a2wl/71CIZxBN/9V4Z5VwsD2D8zcK1MYlD3SwwgogbvLIqzlW/h80lbgyT7GdQrXz13hGws9XQDUS/VbMgaQ9NAmpljDIUgDihSSLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZldeXPYy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22548a28d0cso106872565ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 20:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742183729; x=1742788529; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CBTWj2JRao6hEYbpJcvmwDMWkAU9+qspu6K1SR4O2CU=;
        b=ZldeXPYy6G+KsddxlkwfjxFFiesovavCYiTPHnzSPuUzLuH1HCMms8r6e2bVy34T6C
         PuEb3ypmxDVfoYztPSaDU2abHx5NoT36YnkvSZEYwtPzYKBUTNWvUAd7Gi2jowiR6Ys8
         aN+DqKjW2cpuJXOMx4RuFH9IiUwYYITDE9gzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742183729; x=1742788529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBTWj2JRao6hEYbpJcvmwDMWkAU9+qspu6K1SR4O2CU=;
        b=JDXSztoJzuhmWy25o0SLlmlhNd6smqld+YyiLwWGOdm3/0V8vRJewVSZBhRX3cU3zv
         QjCjBPdkd8m+juZWOIzOi+L6wkPbOlhffK/G1nVBaORp+1wfCYXA7gqOCvW+bZOE6bMz
         RpvoECAYdV0/QiDncQmd7jFHW/ps8w2gqTDpJ7VvXqMXN/SN+74EBqZ5qClvBPjDQRjN
         +msgycGiW8TxFs2ZaqhBkVfVcNNWbaHIK1w7pRFLQr7x9JpROJIQqAqMebaXxy8zqrEj
         a5TJw6pNOfu2gqvCBfmAMJfwfvCocDnYYuvt7+h/1kRsNhgpKQZEQstYwA0jIUgZpVMY
         y7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVjzb4usEpW8DXcb/Jjxtv6SsPQv1WpkUgAnLLKXvC0gqXuDc9H4SVO3umVpmVC+1/JGyD54lzV5ww22fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6qwWAs4VheQDMuDorILM2izJoJjbzlu5T71ojdlPCVeGpdFoe
	JpC41L/Kg8XDDwM7/oPaz5Gba8/Che20/w3uqzBQCO5aANzPyC1H4nTwj7T1WA==
X-Gm-Gg: ASbGncvmHfCS7FBQXuXmSJ1EpyZQ4jxK7Jsd2mWtD8oMu6A1RlKooAtRtXNiMMhEswA
	hjJU+A+FWoLNqQ/l20wN9IwMLjAef3SbtIzvM9gvRD1vKMo87x/wiAKeRH6BCHSugpwysLRkcsa
	zZQW/Ol0a00knwgnAKYkFjXD5x3AY9bzrk44L7AlfwS9Ge1AkcdCGh0VYDJ4e+wOgRhcztq6PCl
	i/TPHYoRADl64cxreC2XbmLlG+EF6MF4F9TwpsCNOStHVMVueChK+s31OHaxLdIIQ2tvFBSShK8
	fFJQiXaOTj199U/f/PxC/C7pbSPmJ6+MOVhLfN4=
X-Google-Smtp-Source: AGHT+IH3J7SE6tEIIitDjSkDltLraVGoaJjVC2z0o5w6R0wVkSrN3Zf1UMSWDRTpV7zvnevMPEVf0g==
X-Received: by 2002:a05:6a00:b91:b0:736:5e6f:295b with SMTP id d2e1a72fcca58-737223bec84mr11823501b3a.12.1742183729670;
        Sun, 16 Mar 2025 20:55:29 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:77b5:e0b8:95d2:83db])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711557ee8sm6764462b3a.52.2025.03.16.20.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 20:55:29 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:55:26 +0800
From: "Sung-Chi, Li" <lschyi@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (cros_ec) Add setting target fan RPM function
Message-ID: <Z9edLnXKlc_L2Fmb@google.com>
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
 <20250313-extend_ec_hwmon_fan-v1-1-5c566776f2c4@chromium.org>
 <714be928-a655-4561-98fb-800bcb15cbfb@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <714be928-a655-4561-98fb-800bcb15cbfb@t-8ch.de>

On Thu, Mar 13, 2025 at 05:21:35PM +0100, Thomas Weißschuh wrote:
> On 2025-03-13 12:47:42+0800, Sung-Chi Li wrote:
> > Implement the functionality of setting the target fan RPM to ChromeOS
> > embedded controller under hwmon framework.
> > 
> > Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> > ---
> >  drivers/hwmon/cros_ec_hwmon.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> > index 9991c3fa020ac859cbbff29dfb669e53248df885..b2fec0768301f116f49c57b8dbfb042b98a573e1 100644
> > --- a/drivers/hwmon/cros_ec_hwmon.c
> > +++ b/drivers/hwmon/cros_ec_hwmon.c
> > @@ -52,6 +52,26 @@ static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8
> >  	return 0;
> >  }
> >  
> > +static int cros_ec_hwmon_set_fan_rpm(struct cros_ec_device *cros_ec, u8 index, u16 val)
> > +{
> > +	struct ec_params_pwm_set_fan_target_rpm_v1 p_v1 = {
> 
> The v1 protocol was "only" introduces in 2014.
> Could it be possible that devices without that command are still in use?
> If so the presence of the command should be probed.
> 
You are right, I will probe the command versions for both get and set fan RPM
values in the next change, and perform different handling based on the version.

