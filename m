Return-Path: <linux-kernel+bounces-564892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1FA65C68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652948839E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397C41EB1AE;
	Mon, 17 Mar 2025 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh/YXCU+"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CC1E833E;
	Mon, 17 Mar 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235673; cv=none; b=VHqFMD/0sI2UTU7gTgEOOYc70DqTDCFJYoDw7j0GODrceWfYtVSGHnZzaV6VNSNT1Me2apjknJAiDV/YSVs3qkI8ygltOWag5b2qDDkFdnCImGYuj1DCfakf+AREYw82DQix3f4Mn85aqjMmpnisT2s7shEE2fZzrTnEuzuFw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235673; c=relaxed/simple;
	bh=8F8LChKiyVYE1Z3bO3W71TWsfrI7c0cZayodIbi6dyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD0O7C5zAVShHSTar/KqUOaE8JKemxrg17LdrAehNA0yoqWsMQvjvawp2KmjbZ+9bQBJDP2pqJ7NUV9YVRcQhyUTOb4kHEke8ib90fPYYDFr4CeLYuAqNIdRmvTsIIeckuBOQ0I/+WpN7QAaIPL6w8oH5mnyvYS7EIHg0vFQ/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh/YXCU+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225b5448519so88342195ad.0;
        Mon, 17 Mar 2025 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235671; x=1742840471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9ZnVsx9YkOYJfj41WMgAcUudWjPt2oH4jU+k7Wr6Zg=;
        b=mh/YXCU+Zxa0kcvStAF+DafnJ/XaRrA0PuEwLJPjMju7Wd/8lT+zvOtG7iyH5cfPaD
         4jd6Mk2vcwe3PpPs87XhpnFIAluPVdb+04SIGIKturGjeVJ23UgyUgOwMasSPXj+SU25
         aV4e3G7D+9eawd9JpD1Vl3FsHAhSz09gKNyojUcIHMWU2RXsl769wgS0XXKtRJlnzKh3
         o2i3UwN44dtIyShf70+PYmFPBBhtw8IKdLATZ2N4llX0YGWtwJL4pJBzdB/TZEZhLBvA
         P48CS90t50n8qspvFY9VRqIeBcftvUwojSOX9YB1gFzE0BwE1zPxIPDOfOwvH+ZnBBjJ
         nr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235671; x=1742840471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9ZnVsx9YkOYJfj41WMgAcUudWjPt2oH4jU+k7Wr6Zg=;
        b=FfDJhuFeA6Tec2mTQxRSsGFnbn2LEyy3e6V1XwIkURnDprszYdrIWm9d1DlYZDmZvT
         kalTyEWX0EECzY6jmTQQtXLmQnH3dWZRTmakXMI4P4gagRmCTTTtazyQT4hvPW/nSmQr
         bmO+NR5HnNxoF69htF5zDZ5kflKweHWciNwu8lb/E9eGlaiRx5WECju2chx81XZvWgas
         r4lAmcB9/bPPQdfgFNqoJZObueRevocKmDmsIvUYuMxAVfVa1A7i4cKfgSNIi44Gqp3d
         vPA8JnH9JTKlYa8NyTRLGJljcmEjFTWXY75w0cOU8W2nZ0ODtZuAzAOeJ9XUXOarkpDn
         FhtA==
X-Forwarded-Encrypted: i=1; AJvYcCV/XrGp9V6RM/64HrB1xQWHCsCjPvt13p+rCClw6T5wKMd8mQ4gEqXEerj1xbsAxzhdmHYP6TIwqVAaG+Xe@vger.kernel.org, AJvYcCX6uDNUv1NoQHJrNWwzbm20vB6rx8s94rlAdOS83ePbVwWxstIR0zScvJEd/uGW4cORTIA5vSyYIlLN@vger.kernel.org, AJvYcCXpNxX8+fM6jMuhTsfI1w4nMIrQYmiaIkRNWXVZPCGcrT0XYGHQDitO/uUz3vqSt0+KbhV83tN5guf2qJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwI663t+D2n5iws8DsmE9Oj+zf/QJDOf9Y8XgH22CHGOo9iAus
	eYqo5itaegKwL31fWSbNTacNOXS1wjKC42FCHq8UudXT7v7/DRBY
X-Gm-Gg: ASbGncvTB/HN4UKwNx0w6ZxAfxo8WHxcYWFKyxfRWLEszUFC5xOCPzgXZKG04hj3wsQ
	jYkF9MnRq/5zUkzmZX73FwwzPy6eCdyv5qWlfIDOJakGyF0wkje0oAsJofKo5ZLdp5nwlV+Stqz
	2vv5lAq3puwQFRKGdMOyhMdbbVfLCgUtNQMs8WBEH5rnrRvZu2GaL+1Ks3e2X7M3bV+/9ehAn6V
	BEBQJPC9GOMTU/AwQJ92BGXxbI6Q5Jlo/9iWqqF2X5x7UF1+yqPRAy974anuVYUYCHViqhejZq6
	ljAqtRzyIlXC4bb2gGNV7ORcoPAJ4179P7sgqsggUAhW3G1IkxvrEdeKTgM0gCTn+a0C
X-Google-Smtp-Source: AGHT+IEoaHPO+uONugmjhf404W+32JKPjhhfNhtHtp9p/RUnn3f25J75pLNgT6US4mFkLKVkI89Fuw==
X-Received: by 2002:a17:902:d4ce:b0:223:64bb:f657 with SMTP id d9443c01a7336-225e0b14f03mr154379155ad.46.1742235671226;
        Mon, 17 Mar 2025 11:21:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68886a8sm78719735ad.44.2025.03.17.11.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:21:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 17 Mar 2025 11:21:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrei Lalaev <andrey.lalaev@gmail.com>
Cc: krzk@kernel.org, robh@kernel.org, christophe.jaillet@wanadoo.fr,
	jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v3 2/2] dt-bindings: hwmon: Add description for
 sensor HTU31
Message-ID: <d34d8b80-1ba0-4594-94f8-5afb7a2c22be@roeck-us.net>
References: <20250217051110.46827-1-andrey.lalaev@gmail.com>
 <20250217051110.46827-3-andrey.lalaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217051110.46827-3-andrey.lalaev@gmail.com>

On Mon, Feb 17, 2025 at 06:10:56AM +0100, Andrei Lalaev wrote:
> Add trivial binding for HTU31 Temperature and Humidity sensor.
> 
> Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

