Return-Path: <linux-kernel+bounces-302547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFDD960012
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8ACB20D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BEC1B978;
	Tue, 27 Aug 2024 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrMqXrHX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444B14A90;
	Tue, 27 Aug 2024 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730935; cv=none; b=ptAmZqcXhnjarb5z+8Syo/O5ZOST/V/ZXMQMS9a+KYUoco2Shw22cPGiP9ZrSCIQ641qJSyZpZFj+L8zE/+GYDCnKQHxS8kxbOWKvOl7nT3HJBQAtw0irx6jmIBkB4szqhGpKlz7YQILJB6IMGaWW+LSWISB7LlYb7rTgq/Zo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730935; c=relaxed/simple;
	bh=UIZhClIfNP8RnyFc3uotLakfvAPBysWBHDbazqaO/t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7ruaqZRHpxcdHcJilTxq8bTMp11IrXJPZ6pgbC1Dx/E9/exZBQP2vsc/VByaTFmT8WkxlrpoD3dG1qBpSk5euGXOBtTfS5r6sgfpBkyptDSD4GP2UgElQ4W9yKnpZ+4Md1xKaseP57WmyHG3FVxt3PjyRr3ujjmb/guZj4wV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrMqXrHX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202089e57d8so31990115ad.0;
        Mon, 26 Aug 2024 20:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724730933; x=1725335733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h40UklaApWb5EyKvShhCYQi2t5utzRjtxNawvY/2Goo=;
        b=nrMqXrHX1aeo6EM7VgCFyBxw/IAtxMoqvp2pUn6CzRgkJs0mj40dFs79cxuTDxQu7A
         FvRv8TPjWSLDoeH6H8Z4sFJ9ytLgApYS4LkQocz4BfMRIZ5O2S2Rr6ozKH/H31GAsyOX
         JrAhZJbpk7keuP6a79eZApMkK9WWf8/Co6F8f5jGKq2OCX2sCjqiP1bmPHHh8OmNzO6H
         4y7OQdXuQ0yzHpiAod5aHrwvd6uLgFPyExkrA4f8VcUsnIB2iBa2dqRIEs41Dy5wpkd5
         u8xOToFdjzs5CPj0d5p/07vzsX0PRvefnjpOBWG6AUdW0FkD3GMKP7nRBZ71K4PL6ib3
         2Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724730933; x=1725335733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h40UklaApWb5EyKvShhCYQi2t5utzRjtxNawvY/2Goo=;
        b=F9Kpvm0T6ZaZq2lgxuv+VW0q+5Xszd8Xqi0CwIhyeMOlLlKynrh22VmSbeaEzlhJFl
         m3WnyEMiWknKAKw/wxRxe86VC+f7ylISonQ0eBj/9/voJIazSA5/Oz3t1eW52UXKsYue
         sT6G/Simc+HFP3y1+ul1nr8qLC3I7mbQSZvRsZx3p8l75pVAGbFdTF0n3q+AgkiirEr+
         9Og7Dy3oiFRah79Yt0kF954vUDlTpf5QBFtS8hZu4rVoXQDmc+1THkFBAbps3TrlBvJr
         dx+C0lRvgtZPZzAiXrj9mLQ67YzZKW7iKLGnVgtsNHw1kP1lsNBb/HPfFG7RWgLynPOc
         KoTg==
X-Forwarded-Encrypted: i=1; AJvYcCWAbKQxhH/o/1UP7fKm201GxqTAVbPSXP7oovzWT/ZfGEio+yYEppX0/g27SxhOo/iNbPwpOjPtgwonCw==@vger.kernel.org, AJvYcCWeX10PC4oVWMBsbmV4AR0ZnuSgE6j9hmEUH0R8hEkUadGNE8pXk46PTmBle90hMxsZLnwpEEFIiJnasOjz@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMVwPMEtytEPU8kXHfkgKEzqDFwPmUN8UUTmNx9bPzpEbJQmM
	4ZLnl6pDtUPIl7vs9IWTpmlt6vgdGdIZLcgWrx5htTLjAtXSqxkt
X-Google-Smtp-Source: AGHT+IEubpWsuetTzJO1D0T+D1MS0gJWbz/2p9QlqPTAMHbDxAd+8y+dKvihuV64opD3a+HU+x0QJw==
X-Received: by 2002:a17:902:c713:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-204ddd25f60mr19655035ad.15.1724730933231;
        Mon, 26 Aug 2024 20:55:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560dc8csm74345875ad.224.2024.08.26.20.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 20:55:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Aug 2024 20:55:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: stts751: Add "st" vendor prefix to "stts751"
 compatible string
Message-ID: <2672447a-67d3-464b-a3e9-acb7373677f3@roeck-us.net>
References: <20240826191811.1416011-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826191811.1416011-1-robh@kernel.org>

On Mon, Aug 26, 2024 at 02:18:11PM -0500, Rob Herring (Arm) wrote:
> The documented compatible string is "st,stts751", not "stts751". Even if
> "stts751" was in use, there's no need to list "stts751" in the DT match
> table. The I2C core will strip any vendor prefix and match against the
> i2c_device_id table which has an "stts751" entry.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

