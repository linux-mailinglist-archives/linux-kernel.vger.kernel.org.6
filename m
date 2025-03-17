Return-Path: <linux-kernel+bounces-564880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0BA65C32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA4318983BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5CB1C07DA;
	Mon, 17 Mar 2025 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xnx8F6QF"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4414C5AA;
	Mon, 17 Mar 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235402; cv=none; b=ttCFX4vBU4j9K/ulDOzidbexcoC6VCaqsKV1QujTrkehSlt9z9emhKVKz9Ard+79Ni5KD4fpGGbbGTgzF1pVB8z0Kp48tJIRE/Wa+Qok+7pp0CkFbxRnbH1Feu8HaiL91/aB/FrutpOs0QnyFjCYc8RGguHiwLxDAFn84bBj5FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235402; c=relaxed/simple;
	bh=UYeNfcNlGpOAgum/qq1XWewCACm+JV4ZXY0pbXoiaJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0FTRlD1BMlim8nPwk5tt+paRHuBWYJ6+ooomHtRAmCMfz3bm4R9I43321nJxy43xNum5D/ml1os3P/zwjj+MP+juZQkTydZ4hA/ln3TZUrxRwu4r92FWC3yVJ4tx5wAl6a8ZZ0zxuhXRlmOH3FaPi3HrP2xRx22fRz7H8WH1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xnx8F6QF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2235189adaeso81285085ad.0;
        Mon, 17 Mar 2025 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235400; x=1742840200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUCdB66sjGcy5Ju/mCBXU+gcykaOapWPEnxRUb11FKw=;
        b=Xnx8F6QFAMsdtKkxBw99fOkDVhZEU6R7/wYz9eLW4Hb4aQ9jaeoVXhnmQPYU7yxB87
         e/v5bmwPR6ZTnssBpum5LYptug9EY/Wmx8TyvxJM24PEEK8TACzTyMCH0yRfuaMeWyKu
         2KH8g9GetFiHe318Q54OHJQDN1aCnnDIwRHLQu+x7RlG6wJk3DhPnkOObhIxYgfqoC3G
         mpAXjN5Sj321Mz8Lq5Ai9wIasQCYAAmrEw86Tyz1sLdWeIx/HfEyA1TfYVz+SkEHJAo1
         EJ5mfDONxkh+nAxwNY0YpuaTI8rX6a6gWbw1gj/vOWbjYlHcn02DfjCU9CAVgciA3OQw
         lHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235400; x=1742840200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUCdB66sjGcy5Ju/mCBXU+gcykaOapWPEnxRUb11FKw=;
        b=sQwKxIzouRzZ3MnxKqbG1QOcF9uf7jzMdkk5ycl/OacJv4T6KhsJFduER4rnqmyXpX
         rf2KEIZgdo5knjNbja5+qXx4ouBJgtcnnxmR35BaPUA+y7Ki2f/H5g62qWo2ANogYbvL
         CW1RTwJG6bowais8no3Z/s0OAwAkxvKAo3zU3avNak9vTtteWNhkA7+2yp4iZgP/iEgy
         HmEM9YT2IqA3FXwGhJ4c4i3n22k7qRfC/icpsSG6waj/LHj1pKma8FR0k7LhDRRLHfp+
         G82s6OxRji8i/QiuXGpwXTPUYKEoF+RZaZlQUd0xT63nbd7ddYbK2/ELOWzDJedm8Hj6
         2hnA==
X-Forwarded-Encrypted: i=1; AJvYcCVSVbX3hPI3M5q1Wc/uTbptlCPq68RuMQYxazikXEKDAo5HcXRvNH/wP9R539WyBccnLiR64+50C1/3ayI=@vger.kernel.org, AJvYcCVoJ7O9AZAsmAA4ypyWnT3aLk5Hl8QangUuUlQt/I8oN4DazEBAPfOZZ2JYEBpALH4dT7JiVvzGhM4=@vger.kernel.org, AJvYcCW9Dgt3T7cOxapyB38d62nn2v+60QfV10OAdqtIe3Xlp8CqcCAipwdqslyLRj+Ucnd/LqHdZbYmH45jgLTt@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2QtiL7l8t0FC75Zapfr595J7jpV07GVqP82KzY82+E+aVopG
	DA1bEA4Hk01IRSp4py5evErsH9Z1bsfqA7wdAWqBfVrOJJxu8u0c
X-Gm-Gg: ASbGnct1b7C1UT08s+YFi+Hfoj6a2Q7fNJhoE0T8n/GDTr4tzcTjZU7XOw/QbfCv+nY
	geaPrT9U+DNjxKzBk82XTDdt3RMufOu0y/ZQCKqYSU6eh4WgoxkxuYUysoDOfV7GR07Ia1fI2BC
	q0sUCBTdHJ8XHPuzZ6rpzkr1DMQRnX/xeFBWYxImchOatPbz/jVmVI/OJSOR5XN1Z5KHvamRftD
	bREasHMs9MRQDvC5vNwBectsbQ34qV1aNJBWy0rarqVnULz3OTUWo5bTYDRLL42iEPa8R/6t+Bx
	ZTgteVYk8NT/MXoe2nz6iaHa7N06krC92soruKJPyy5EZlYju4/d2oQEOQ==
X-Google-Smtp-Source: AGHT+IEKRnJOI9AZvMY9zGnQwkia7aBR5J0uGyNw+zBClToyOYhZ25i/zugKIW/w/LmNxiXuBMpIWw==
X-Received: by 2002:a17:903:2349:b0:215:58be:334e with SMTP id d9443c01a7336-2262c9b26ebmr4275985ad.10.1742235399779;
        Mon, 17 Mar 2025 11:16:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa637sm78858145ad.94.2025.03.17.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:16:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 17 Mar 2025 11:16:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Jean Delvare <jdelvare@suse.com>, Lee Jones <lee@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, thomas.petazzoni@bootlin.com,
	blake.vermeer@keysight.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hwmon: Add Congatec Board Controller monitoring
 driver
Message-ID: <4598db93-ca3b-4a29-9b4a-84445dc95577@roeck-us.net>
References: <20250203-congatec-board-controller-hwmon-v4-0-ff6c76a4662c@bootlin.com>
 <20250203-congatec-board-controller-hwmon-v4-1-ff6c76a4662c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-congatec-board-controller-hwmon-v4-1-ff6c76a4662c@bootlin.com>

On Mon, Feb 03, 2025 at 12:01:05PM +0100, Thomas Richard wrote:
> Add support for the Congatec Board Controller. This controller exposes
> temperature, voltage, current and fan sensors.
> 
> The available sensors list cannot be predicted. Some sensors can be
> present or not, depending the system.
> The driver has an internal list of all possible sensors, for all Congatec
> boards. The Board Controller gives to the driver its sensors list, and
> their status (active or not).
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Applied.

Note that I can not apply the mfd patch.

Guenter

