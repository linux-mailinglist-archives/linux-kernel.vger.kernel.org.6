Return-Path: <linux-kernel+bounces-197461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673B88D6AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C581C22FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66A917D8B0;
	Fri, 31 May 2024 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9GHoPXU"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14CFEAE7;
	Fri, 31 May 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188012; cv=none; b=mHeQC9kM+1L3FBc8cFeCYf7tg3GGS4hO11CgAUQjjI/oZvUGcXncXCTJ1U88h0RrUolGQ+3oX2E8Tk950a8cn8RgDYsMgSzwvvpYasjJ/Z/xpnvkjXep8djERmOyUuBydd0bIPf0VnYWGtSNyBn0FwilH3K0/mK60OFnJQ266EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188012; c=relaxed/simple;
	bh=XWJGA7WkumqEWVF3eNR36oimqhMNBPP0r3p047diBwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEftkduXAz9IW019w157WZ6ZuxrIKR9+hP90N+hxfo01aBpH/MvIWYDtBjHc/lD6BLvJw/tN88EENPVywGwk6I/ii5BP8yHn9bOnicrk+ROk58Og/4oh85YP5ORUilK11lHMbfLtyGcgCw7xYNKuEo5twzFaJU1VxqIurAStWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9GHoPXU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-701ae8698d8so2004988b3a.0;
        Fri, 31 May 2024 13:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717188010; x=1717792810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcSoUVjLNskF349BZzJVDHB2cNNxuuJE3IEXN9Qr/mg=;
        b=h9GHoPXUadVKUTY9/k/VSwV4FhfgQEvP698QEFdlsMbSSc1S0iZm9zbPV9VG5JNf3A
         Dy2SGtnGbNW1R8UGJPA7awvEmnhnJxEZIAj84szhp+4/UDIF0oY7Bp7vRnVt7TDQnTqf
         Zimwa8gjO9ialddWgFwJ9fypl/8v2FKpFNfTUS6h/rO1vXhRnHZT0cqtkXniVM1KjQ6+
         806fovGMH3cUrWvdFzjRXBK5rzQUGTSK/ixYH55xKXR9tIlrs2CYx6mhpuW+QEPvqkO8
         SHaTmRNpT9Ye+2VyLbEhgt1kAZ7aq8905dnN9ZN2Msr4W3GQCWE/R7epF0qStLXrPGzC
         +cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717188010; x=1717792810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcSoUVjLNskF349BZzJVDHB2cNNxuuJE3IEXN9Qr/mg=;
        b=NrzKfpb4G0IwiNQoLt08i/OyLE1AY0xmWm1lMaGv4ST+kb59FBumGQ7y9AKUSTHjwS
         rcph+4H9c3v0JCNrtayM2hDSsLx7VKJ+oaYbLtdKh7xibTPqf3TYEempUeYbkmUv/8bf
         6+vYRmHvL28y7NCskvNCuo3241wRiJi0hecwH7on8xEJMSu294z2ykTlVlzUennyMe01
         g3HZb8RX2kWbdwGbJOG/+PW9dmoyDU2iLVEwYEaLngcFgEE5MWUGkbVYAWNBjqHpMB7H
         4HuGTJ2Uz0rTgycPzFU/XwMoh6INiasefpCwDyhs9ti5yFWuT9zQBfpbVhWhv/hzsrpQ
         TD6w==
X-Forwarded-Encrypted: i=1; AJvYcCVqcdbyWGPfpmxYvpOrvvBuA8wtfFj+lPjWjXrlLIlarI2b3p2aTu8YrXkH19HIL8nSEgCP8abF8d/z+tZHRGe1lGQCwQlJCurJE6L7Ao0c9F3b6SSc//v5U8J6Zxlq47YMEnU7xzcxbJkM+Mndbh8o6lXXyS+W7VARwX1Du39U07/V3lE=
X-Gm-Message-State: AOJu0Yy2N+oF7NP4xL0wPl5kF45A/pkAk4XTpGEQ680Z3XP5ljSVl4RI
	n3AIUusgCLhpwLrY4WKW0T4UoPw9PTOZ7TDjWNeoSuwiEiXTRXtx
X-Google-Smtp-Source: AGHT+IHsl1mU7gRHY5Se++eXlfsTrPYGTP4qW4HqGsRZrj8ftol6XE0ti+DxCQCDzjqx1XI3vZkrlw==
X-Received: by 2002:a05:6a00:4388:b0:702:33a4:53a5 with SMTP id d2e1a72fcca58-7024789cccamr3371975b3a.27.1717188009902;
        Fri, 31 May 2024 13:40:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242ae88besm1774032b3a.116.2024.05.31.13.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:40:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 31 May 2024 13:40:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] drivers: hwmon: max31827: Add PEC support
Message-ID: <30cc3e47-3da3-4a92-956c-d1c1cba97e09@roeck-us.net>
References: <20240531084645.12935-1-radu.sabau@analog.com>
 <20240531084645.12935-2-radu.sabau@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531084645.12935-2-radu.sabau@analog.com>

On Fri, May 31, 2024 at 11:46:44AM +0300, Radu Sabau wrote:
> Add support for PEC by configuring the chip accordingly to the hwmon
> core PEC attribute handling.
> 
> Handle hwmon_chip_pec attribute writing in the max31827_write in the
> hwmon_chip type switch case, using the same code structure as for
> writing temperature limits. 
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>

Applied to hwmon-next.

Thanks,
Guenter

