Return-Path: <linux-kernel+bounces-197385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA248D69EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1141C24E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1317C7AA;
	Fri, 31 May 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDKkiDb7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9F8060E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184454; cv=none; b=c7GHWuA8GjbhPHauVEk4q1cUh++7XZn912SZtnJQvsYcoPEc8nhGrYPv+X6t6oJJ+g/eBRj6anGFCFeAMxe6qgC9MRJ4dPhkwEunORtCbPIDJcYpHrnx2xsdJr9//mSF4bsja6DenN+TTkJs31vvwyaYsEj+ImHqOmlX7pJxz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184454; c=relaxed/simple;
	bh=TQ2RL+BL2PmNJRXo1hXLGtYA+NaoDx0hkQ6nkL/9K40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwzAhfBbZoLqGM7qljFD2vZq3rlgM9Tq18Ot6g6z1Of/jgv6c0R/iZeytf8v/vUsuO8AknO5UlxHXL/LfMNGDecMHAw35dUlli9LMRMrxXOS7kbxyHvdQpAGvrFvXX8JbCgkTCYXs9NluKFPWc3Gk1K7yklUdn6aDWzmVgkv0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lDKkiDb7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b78c65cadso3212409e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717184450; x=1717789250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvFwjLMrTRmtQ0CyySB6yu7xfec87gsowa4Zls3ODKM=;
        b=lDKkiDb7TFPiiMtPqbjGPlxAgXYPWl4Vse131hU4XtWJKNDJF8YeEwBy0n9O0LfIsT
         Cb8XBx+vacWGSiMORc7EQPwLn+qx/w1X2qNRBnsICoayMZ16NzMk0TMZvk+FUWCROsKG
         O+N4cT5MU/cyloR2KJgpQop4d++9Grcu3ft6bFMVAsrfls5Nq/p7OPpyEQyW++9mma/9
         aWg178++QZfNqE40w7KpA/cpIolDNcpsdA0VJSskOU4LI5d7UCexfg+bCLkgpxxHnxpu
         te8/K+vwMqBcDEcXy4oCX4BLkzfQsC0rM1ekV5rY9Slk9DB3DC/G/3FIcTrTFOWLc+7J
         60MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717184450; x=1717789250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvFwjLMrTRmtQ0CyySB6yu7xfec87gsowa4Zls3ODKM=;
        b=top8i5rtsy1DrXHfj6CX7ZBU1Y4r0dBU8FpGo49k+yRWNPSBwVvOwKCi2nGzUhbiEk
         NWPjL7cIJKFNzu7ebyFJ2WOWI5tor6q10YZU5oq0T8XNPyw6ao8Y/2JQYV/0EqRRcmHx
         bO6p/A4r7JfJdW8q9Jos9YUtti6/BIZxGy84cBeI6OcZzCgxbGv79Afy4VQ5YCTyot/J
         PJILtONy2Q4i1xWdnXQ34jN8vJhys+K85K7aIILSfvvBKOrvNsHSi3n89JfQURIfPMip
         22zBugU1pOujwN2fZu8EW1IrS9XlRkO/ILVxukhLqomcBMJ6e4bVijEz1DDzMdft1Cxd
         +pfg==
X-Forwarded-Encrypted: i=1; AJvYcCXZzB4b1iczYHfTtsFIPU/XTuXAflClIcAb9XTD0qaD3mo7l2O/GMQm0O9JRtA/D/QTWLT2i/JvjO/9Jk97Pon2v+4834BtHQEEa/Wn
X-Gm-Message-State: AOJu0YywF1J58eFfKh1PPOtHi19yiveHy7OmFUhsBjBfJLkJF4L/QdQ8
	o8PWyCkkr+UNI1H7SqcWbJWbXytu2TdaK5tjbXce5c0Svwd2u3TAb4sV/1WoDBA=
X-Google-Smtp-Source: AGHT+IGSW17YxQLGQcUtlueslBoXW2uqO2r4S2Ky+nB8dMPnIdoeiclzSW2U28EBqOsG+qkcNlvxOQ==
X-Received: by 2002:a05:6512:2084:b0:52b:8411:20e5 with SMTP id 2adb3069b0e04-52b89572e9bmr1889709e87.15.1717184450399;
        Fri, 31 May 2024 12:40:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d7ebdesm419366e87.185.2024.05.31.12.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 12:40:49 -0700 (PDT)
Date: Fri, 31 May 2024 22:40:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v5 1/4] usb: typec: ucsi: Fix null pointer dereference in
 trace
Message-ID: <m4ycprnxwq7gfdpm7prbw5f6djxqzzkrwoxmghuoifaqfvu6ky@z66esyhxouzu>
References: <20240510201244.2968152-1-jthies@google.com>
 <20240510201244.2968152-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510201244.2968152-2-jthies@google.com>

On Fri, May 10, 2024 at 08:12:41PM +0000, Jameson Thies wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> ucsi_register_altmode checks IS_ERR for the alt pointer and treats
> NULL as valid. When CONFIG_TYPEC_DP_ALTMODE is not enabled,
> ucsi_register_displayport returns NULL which causes a NULL pointer
> dereference in trace. Rather than return NULL, call
> typec_port_register_altmode to register DisplayPort alternate mode
> as a non-controllable mode when CONFIG_TYPEC_DP_ALTMODE is not enabled.
> 
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

